<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style type="text/css">
		.uploadResult {
			
			width: 100%;
			background-color: gray;
		}	
		
		.uploadResult ul{
			display:flex;
			flex-flow: row;
			justify-content: center;
			align-items: center;
		}
		
		.uploadResult ul li{
			list-style: none;
			padding: 10px;
		}		
		
		.uploadResult ul li img{
			width: 20px;
		}
		
		.uploadResult ul li sapn{
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
			background: rgba(255,255,255,0.5); 
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
	<%@include file="../includes/header.jsp" %>
	
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">게시물 작성</h1>
			</div>
		
		</div>
		
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
				
					<div class="panel-heading">게시물 작성하기</div>
					
					<div class="panel-body">
						<form role="form" action="/board/register" method="post" >

							<div class="form-group">
								<label>제목</label>
								<input class="form-control" name="title">
							</div>						
						
							<div class="form-group">
								<label>글</label>
								<textarea class="form-control" rows="3" name="content"></textarea>
							</div>
							
							<div class="form-group">
								<label>작성자</label>
								<input class="form-control" name="writer" value="<sec:authentication property="principal.username"/>"
								readonly="readonly">
							</div>
						
							<button type="submit" class="btn btn-default"> 
								게시물 작성하기
							</button>
							
							<button type="reset" class="btn btn-default"> 
								게시물 다시작성하기
							</button>

							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						</form>
					</div>
					
										
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">

					<div class="panel-heading">사진 및 파일업로드 </div>
					<%-- /.panel-heading --%>
					<div class="panel-body">

						<div class="form-group uploadDiv">
							<input type="file" name="uploadFile" multiple>
						</div>

						<div class="uploadResult">
							<ul>


							</ul>
						</div>

					</div>
					<%--end panel body--%>
				</div>
				<%-- end panel body--%>
			</div>
			<%--end panel--%>
		</div>
			<%--/.row--%>
		
	<%@include file="../includes/footer.jsp" %>




<script>

	$(document).ready(function(e){

		var formObj = $("form[role='form']");

		$("button[type='submit']").on("click",function(e){

			e.preventDefault();

			console.log("submit Clicked");

			/*이미지 첨푸파일 추가해서 전송하기 스크립트 추가*/
			var str ="";

			$(".uploadResult ul li").each(function(i,obj){

				var jobj = $(obj);

				console.dir(jobj);

				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>;"
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>;"
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>;"

				console.log(str);
			});
				formObj.append(str).submit();

		});

		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880 // 5MB

		function checkExtension(fileName, fileSize) {

			if (fileSize > maxSize) {
				alert("업로드 용량을 초과했습니다.")
				return false;
			}

			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드 할 수 없습니다.");
				return false;
			}
			return true;
		}

		function showUploadResult(uploadResultArr){

				if(!uploadResultArr || uploadResultArr.length == 0 ){return;}

				var uploadUL = $(".uploadResult ul");

				var str = "";

				$(uploadResultArr).each(function(i,obj){

					//imageType
					if(obj.image){
						var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);

						str += "<li data-path='"+obj.uploadPath+"'";
						str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'";
						str += "> <div>";
						str += "<span>"+obj.fileName+"</span>";
						str += "<button type='button' data-file ='"+fileCallPath+"' " +
								"data-type='image' class ='btn btn-waring btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?filename="+fileCallPath+"'>";
						str += "</div>";
						str += "</li>";
					}else {
						var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);

						var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");

						str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'" +
								"data-type='"+obj.image+"'> <div>";
						str += "<span>"+obj.fileName+"</span>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file'" +
								"class='btn btn-warning btn-circle'>"+
								"<i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/img/attach.PNG'></a>";
						str += "</div>";
						str += "</li>";
					}
					uploadUL.append(str);

				});


		}



		$("input[type='file']").change(function(e){

			console.log("이미지파일 업로드 중입니다.");

			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";

			var formData = new FormData();

			var inputFile = $("input[name='uploadFile']");

			var files = inputFile[0].files;

			for(var i=0; i < files.length; i++){

				if(!checkExtension(files[i].name,files[i].size)){
					return false;
				}

				console.log("들어오는 파일 이름 :" + files[i].name);

				formData.append("uploadFile",files[i]);

			}

			$.ajax({
				url:"/uploadAjaxAction",
				processData:false,
				contentType:false,
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				data:formData,
				type:'post',
				dataType:'json',
				success:function(result){
					console.log(result);
					console.log("사진 데이터 전송 했습니다");
					showUploadResult(result);
				},
				error:function(request,status,error){
					console.log(error);
			}

			});

		});

		$(".uploadResult").on("click","button",function (){

			console.log("delete file click");
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";

			var targetFile = $(this).data("file");
			console.log(targetFile);
			var type = $(this).data("type");

			var targetLi = $(this).closest("li");

			$.ajax({
				url: "/deleteFile",
				data: {fileName:targetFile,type:type},
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				dataType: 'text',
				type:'POST',
				success:function(result){
					alert(result);
					targetLi.remove();
				}
			}); //end ajax


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
