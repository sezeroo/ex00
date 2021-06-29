package com.zerock.domain;

import lombok.Data;

@Data
public class BoardAttachVO {

    // 게시물 에 들어갈 사진 uuid
    private String uuid;
    private String uploadPath;
    private String fileName;
    private boolean fileType;

    private Long bno;


}
