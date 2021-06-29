<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@include file="../includes/header.jsp" %>

	
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Board Read</h1>
			</div>
		
		</div>
		
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
				
					<div class="panel-heading">Board Read Page</div>
					
					<div class="panel-body">
						<form action="/board/modify" method="post" role="form">

							<%--post 방식으로 넘겨줄때는 무조건 사용한다고 생각하자--%>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

							<div class="form-group">
								<label>Bno</label>
								<input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly" >
							</div>						
						
							<div class="form-group">
								<label>Title</label>
								<input class="form-control" name="title" value='<c:out value="${board.title}"/>' >
							</div>
							
							<div class="form-group">
								<label>Text area</label>
								<textarea class="form-control" rows="3" name="content"><c:out value="${board.content}"></c:out></textarea>
							</div>
						
							<div class="form-group">
								<label>Writer</label>
								<input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
							</div>
			
							<div class="form-group">
								<label>RegDate</label>
								<input class="form-control" name="regdate" value='<fmt:formatDate pattern='yyyy/mm/dd' value="${board.regdate}"/>'  readonly="readonly">
							</div>
					
							<div class="form-group">
								<label>UpdateDate</label>
								<input class="form-control" name="updateDate" value='<fmt:formatDate pattern='yyyy/mm/dd' value="${board.updateDate }"/>' readonly="readonly">
							</div>

							<sec:authentication property="principal" var="pinfo"/>

							<sec:authorize access="isAuthenticated()">

							<c:if test="${pinfo.username eq board.writer}">

							<button data-oper="modify" type="submit" class="btn btn-default" > 
								Modify
							</button><button data-oper="remove" type="submit" class="btn btn-default" > 
								Remove
							</button>
							</c:if>

							</sec:authorize>
							
							<button data-oper="list" type="submit" class="btn btn-default" onclick="location.href='/board/list'"> 
								List
							</button>
							
							<input type="hidden" name="pageNum" value="${cri.pageNum}">
							<input type="hidden" name="amount" value="${cri.amount}">
							<input type="hidden" name="type" value="${cri.type}">
							<input type="hidden" name="keyword" value="${cri.keyword}">
						</form>
					</div>
				</div>
			</div>
		</div>

		<div class="bigPictureWrapper">
			<div class="bigPicture">

			</div>
		</div>
<style>
	.uploadResult{
		width: 100%;
		background-color: gray;
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
		background:rgba(255,255,255,0.5);

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
<div class="row">
	<div class="col-lg-12">
		<div class="panel-heading">Files</div>
		<%--panel-heading--%>
		<div class="panel-body">
			<div class="form-group uploadDiv">
				<input type="file" name="uploadFile" multiple="multiple">
			</div>

			<div class="uploadResult">
				<ul>
				</ul>
			</div>
		</div>
	</div>
</div>

		<script type="text/javascript">
			
		$(document).ready(function(){
			
			var formObj = $("form");
			
			$('button').on("click",function(e){
				
				e.preventDefault();
				
				/* 내가 클릭한 데이터oper 의 데이터  */
				var operation = $(this).data("oper");				
				
				console.log("선택한 버튼 " + operation);
				
				if(operation === 'remove'){
					
					formObj.attr("action", "/board/remove");
				}else if(operation === 'list'){
					
					formObj.attr("method","get");
					formObj.attr("action",'/board/list');
					
					var pageNumTag = $("input[name='pageNum']").clone();
					var amountTag = $("input[name='amount']").clone();
					var typeTag = $("input[name='type']").clone();
					var keywordTag = $("input[name='keyword']").clone();
					
					
					formObj.empty();
					formObj.append(pageNumTag);
					formObj.append(amountTag);
					formObj.append(typeTag);
					formObj.append(keywordTag);
					
				}else if(operation==="modify"){

					console.log("modifybutton Click");

					var str = "";

					$(".uploadResult ul li").each(function(i,obj){

						var jobj = $(obj);

						console.dir(jobj)

						str += "<input type='hidden' name='attachList[i].fileName'" +
								"value='"+jobj.data("filename")+"'>";
						str += "<input type='hidden' name='attachList[i].uuid'" +
								"value='"+jobj.data("uuid")+"'>";
						str += "<input type='hidden' name='attachList[i].uploadPath'" +
								"value='"+jobj.data("path")+"'>";
						str += "<input type='hidden' name='attachList[i].fileType'" +
								"value='"+jobj.data("type")+"'>";
					});
					formObj.append(str).submit();
				}
				formObj.submit();
			});
			
		});
		
		
		
		
		
		</script>

<script>
	$(document).ready(function(){
		(function(){

			var bno = '<c:out value="${board.bno}"/>';

			$.getJSON("/board/getAttachList",{bno:bno},function(arr){

				console.log(arr);

				var str = "";

				$(arr).each(function(i,attach){

					//imageType
					if(attach.fileType){
						var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);

						str += "<li data-path='"+attach.uploadPath+"' data-uuid= '"+attach.uuid+"' data-filename='"+attach.fileName+"'" +
								"data-type='"+attach.fileType+"'><div>";
						str += "<span>"+attach.fileName+"</span>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image'";
						str += "class ='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?filename="+fileCallPath+"'>";
						str += "</div>";
						str += "</li>";
					}else{

						str += "<li data-path='"+attach.uploadPath+"' data-uuid= '"+attach.uuid+"' data-filename='"+attach.fileName+"'" +
								"data-type='"+attach.dataType+"'><div>";
						str += "<span>+attach.fileName+</span><br/>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file'";
						str += "class='btn btn-warning btn-circle'> <i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/img/attach.PNG'></a>"
						str += "</div>"
						str += "</li>";
					}
				});
				$(".uploadResult ul").html(str);
			});
		})()

		$(".uploadResult").on("click","button",function(){

			console.log("delete file");

			if(confirm("Remove this file?")){

				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
		});

		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxsize = 5242880; // 5MB

		function checkExtension(fileName,fileSize){



		}
		$("input[type='file']").change(function(e){


		});

		function showUploadResult(arr){


		};



	});


</script>
		
	<%@include file="../includes/footer.jsp"%>