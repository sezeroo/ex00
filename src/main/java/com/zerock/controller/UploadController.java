package com.zerock.controller;

import com.zerock.domain.AttachFileDTO;
import lombok.Data;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import oracle.jdbc.proxy.annotation.Post;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.awt.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@Log4j
public class UploadController {

    @GetMapping("/uploadForm")
    public void uploadForm(){

        log.info("upload form");
    }

    @PostMapping("/uploadFormAction")
    public void uploadFormPost(MultipartFile[] uploadFile , Model model){

        String uploadFolder = "c:\\upload";

        for(MultipartFile multipartFile : uploadFile){

            log.info("===================================================");
            log.info("Upload FIle Name : "+ multipartFile.getOriginalFilename());
            log.info("Upload File Size : "+ multipartFile.getSize());

            File saveFile = new File(uploadFolder,multipartFile.getOriginalFilename());

            try {
                multipartFile.transferTo(saveFile);
            }catch (Exception e) {
                log.error(e.getMessage());
            }//end catch

        }// end for

    }

    @GetMapping("/uploadAjax")
    public void uplaodAjax(){

        log.info("upload ajax");
    }

    // 년/월/일 폴더 생성하기
    private String getFolder(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");

        Date date = new Date();

        String str = sdf.format(date);

        return str.replace("-",File.separator);
    }

    //이미지 파일 유효성 검사하기
    private boolean checkImageType(File file){
        try {
            String contentType = Files.probeContentType(file.toPath());

            return contentType.startsWith("image");
        }catch (IOException e){
            e.printStackTrace();
        }

        return false;
    }



    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/uploadAjaxAction",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity<List<AttachFileDTO>> uploadAjaxAction(MultipartFile[] uploadFile){

        log.info("update ajax post.........");

        List<AttachFileDTO> list = new ArrayList<>();
        String uploadFolder = "c:\\upload";

        String uploadFolderPath = getFolder();
        //make Folder
        File uploadPath = new File(uploadFolder,uploadFolderPath);
        log.info("uploadPath : " + uploadPath);

        if(uploadPath.exists() == false){
            uploadPath.mkdirs();
        }
        // make yyyy-mm-dd 폴더 생성.

        for(MultipartFile multipartFile : uploadFile){

            AttachFileDTO attachDTO = new AttachFileDTO();

            String uploadFileName = multipartFile.getOriginalFilename();

            //IE 떄문에 이거해줘야댐
            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
            attachDTO.setFileName(uploadFileName);

            log.info("only file name :" + uploadFileName);
            UUID uuid = UUID.randomUUID();

            uploadFileName = uuid.toString()+"_"+uploadFileName;


            try {

                File saveFile = new File(uploadPath,uploadFileName);
                multipartFile.transferTo(saveFile);

                log.info("저장되는 파일이름 : " +  saveFile);
                //attachFile 객체에 추가하기.
                attachDTO.setUuid(uuid.toString());
                attachDTO.setUploadPath(getFolder());

                //check image type file
                if(checkImageType(saveFile)){

                    attachDTO.setImage(true);

                    FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));

                    Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
                    thumbnail.close();
                }

                list.add(attachDTO);

            }catch (Exception e ){
                log.error(e.getMessage());
            } // end catch
        }//end for
        return new ResponseEntity<>(list, HttpStatus.OK);
    }


    @GetMapping("/display")
    @ResponseBody
    public ResponseEntity<byte[]> getFile(String filename){

        log.info("ajax 에서 넘어온 filename :" + filename);

        File file = new File("c:\\upload\\"+filename);

        log.info("file:" + file);

        ResponseEntity<byte[]> result = null;

        try {
            HttpHeaders header = new HttpHeaders();

            header.add("Content-Type",Files.probeContentType(file.toPath()));
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),
                    header,HttpStatus.OK);
        }catch (IOException e){
            e.printStackTrace();
        }
        return result;
    }

    @GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    @ResponseBody
    public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String filename){

        log.info("download file : " + filename);

        Resource resource = new FileSystemResource("c:\\upload\\"+ filename);

        if(resource.exists() == false){
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        log.info("resource : "+ resource);

        String resourceName = resource.getFilename();

        //remove uuid
        String resourceOriginalName= resourceName.substring(resourceName.lastIndexOf("-")+1);

        HttpHeaders headers = new HttpHeaders();

        //try cathc 안 userAgent 는 인터넷 브러우저에 따른 분류.
        try {
            String downloadName = null;

            if(userAgent.contains("Trident")){
                log.info("IE browser");
                downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8").replaceAll("\\+"," ");
            }else if(userAgent.contains("Edge")){

                log.info("Edge borwser");

                downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8");

                log.info("Edge name : "+ downloadName);

            }else{
                log.info("Chrome browser");
                downloadName = new String(resourceName.getBytes("UTF-8"),"ISO-8859-1");
            }
            //Content-Disposition 을 이용해 다운로드시 저장되는 이름 지정.
            headers.add("Content-Disposition",
                    "attachment; filename = "+ new String(resourceOriginalName.getBytes("UTF-8"),
                            "ISO-8859-1"));
        }catch (UnsupportedEncodingException e){
            e.printStackTrace();
        }
        return new ResponseEntity<>(resource,headers,HttpStatus.OK);
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/deleteFile")
    @ResponseBody
    public ResponseEntity<String> deleteFile(String fileName, String type){

        log.info("deletefile: " + fileName);

        File file;

        try {
            file = new File("c:\\upload\\"+ URLDecoder.decode(fileName,"UTF-8"));

            file.delete();

            if(type.equals("image")){

                String largeFileName = file.getAbsolutePath().replace("s_","");

                log.info("largeFilename : " + largeFileName);

                file = new File(largeFileName);

                file.delete();
            }
        }catch (UnsupportedEncodingException e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);

        }
        return new ResponseEntity<String>("deleted",HttpStatus.OK);
    }




}
