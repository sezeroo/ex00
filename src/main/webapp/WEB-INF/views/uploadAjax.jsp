<%--
  Created by IntelliJ IDEA.
  User: innotree
  Date: 2021-06-17
  Time: 오후 2:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

</head>
<body>
    <h1>Upload With Ajax</h1>

    <div class="uploadDiv">
        <input type="file" name="uploadFile" multiple>
    </div>

    <button id="uploadBtn">Upload</button>

    <div class="uploadResult">
        <ul>

        </ul>
    </div>

    <div class="bigPictureWrapper">
        <div class="bigPicture">
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>


    <script>
        function showImage(fileCallPath){
            //alert(fileCallPath);

            $(".bigPictureWrapper").css("display","flex").show();

            $(".bigPicture")
            .html("<img src='/display?filename="+encodeURI(fileCallPath)+"'>")
            .animate({width:'100%',height: '100%'}, 1000);
        }

        $(document).ready(function(){
            <%--확장자 크기 사전 처리 스크립트--%>
            var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
            var maxsize = 5242880; //5MB

            function checkExtension(fileName,fileSize){

                if(fileSize >= maxsize){
                    alert("파일 사이즈 초과입니다.");
                    return false;
                }

                if(regex.test(fileName)){
                    alert("해당 종류의 파일은 업로드할 수 없습니다.");
                    return false;
                }
                return true;
            }


            var uploadResult = $(".uploadResult ul");

            function showUploadedResult(resultArrays){

                var str = "";

                $(resultArrays).each(function(i,obj){

                    if(!obj.image){

                        var fileCallPath  = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+ "_" + obj.fileName);

                        var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");

                        str+= "<li><div><a href='/download?filename="+fileCallPath+"'>"+
                            "<img src='/resources/img/attach.PNG'>"+obj.fileName+"</a>"+
                            "<span data-file=\'"+fileCallPath+"\' data-type='file'>x</span>"+
                            "</div></li>";


                    }else{
                       // str += "<li>" + obj.fileName +"</li>";

                        var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);

                        var originPath = obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName;

                        originPath = originPath.replace(new RegExp(/\\/g),"/");

                        str+= "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+
                            "<img src='display?filename="+fileCallPath+"'></a>"+
                            "<span data-file=\'"+fileCallPath+"\' data-type='image'>x</span></li>";

                    }
                });
                uploadResult.append(str);


            }

            /*이미지 삭제 스크립트트*/
           $(".uploadResult").on("click",function(){

                var targetFile = $(this).data("file");
                var type = $(this).data("type");
                console.log(tagetFile);

                $.ajax({
                    url:'/deleteFile',
                    data:{fileName:targetFile,type:type},
                    dataType: 'text',
                    type:'POST',
                        success:function(result){
                            alert(result);
                        }
                }); // end ajax
            });


            $(".bigPictureWrapper").on("click",function(e){
                $(".bigPicture").animate({width: '0%',height: '0%'},1000);
                setTimeout(()=>{
                    $(this).hide();
                },1000);
            });

            //파일 업로드 후에 화면 초기화를 위해 복사합니다.
            var cloneObj = $(".uploadDiv").clone();

            <%--파일 업로드 스크립트--%>
            $("#uploadBtn").on("click",function(e){

                var formData = new FormData();

                var inputFile = $("input[name='uploadFile']");

                var files = inputFile[0].files;

                console.log(files);

                for(var i =0; i<files.length; i++){
                    //유효성 검사.
                    if(!checkExtension(files[i].name,files[i].size)){
                        return false;
                    }

                    formData.append("uploadFile",files[i]);
                }

                $.ajax({
                    url:'/uploadAjaxAction',
                    processData:false,
                    contentType:false,
                    data:formData,
                    type:'post',
                    dataType:'json',
                    success:function (result){
                        console.log(result);

                        showUploadedResult(result);

                        $(".uploadDiv").html(cloneObj.html());

                    }
                });//end ajax
            });
        });
    </script>

<style>
    .uploadResult{

        width: 100%;
        background-color:gray;
    }

    .uploadResult ul{
        display: flex;
        flex-float: row;
        justify-content: center;
        align-items: center;
    }

    .uploadResult ul li{
        list-style: none;
        padding: 10px;
        align-content: center;
        text-align: center;
    }

    .uploadResult ul li img{
        width: 100px;
    }

    .uploadResult ul li span{
        color: white;

    }

    .bigPictureWrapper{
        position: absolute;
        display: none;
        justify-content: center;
        align-items: center;
        top: 0%;
        width: 100%;
        height: 100%;
        background-color: gray;
        z-index: 100;
        background:rgba(255,255,25,0.5);

    }

    .bigPicture{
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;

    }

    .bigPicture img{
        width: 600px;

    }

</style>


</body>
</html>
