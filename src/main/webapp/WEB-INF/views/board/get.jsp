<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>



<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시물</h1>
	</div>

</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">게시물</div>

			<div class="panel-body">
				<div class="form-group">
					<label>게시물 번호</label> <input class="form-control" name="bno"
						value='<c:out value="${board.bno}"/>' readonly="readonly">
				</div>

				<div class="form-group">
					<label>제목</label> <input class="form-control" name="title"
						value='<c:out value="${board.title}"/>' readonly="readonly">
				</div>

				<div class="form-group">
					<label>글</label>
					<textarea class="form-control" rows="3" name='content'
						readonly="readonly">
					<c:out value="${board.content}" /></textarea>
				</div>

				<div class="form-group">
					<label>작성자</label> <input class="form-control" name="writer"
						value='<c:out value="${board.writer}"/>' readonly="readonly">	
				</div>

				<sec:authentication property="principal" var="pinfo"/>

					<sec:authorize access="isAuthenticated()">

					<c:if test="${pinfo.username eq board.writer}">
					<button data-oper="modify" class="btn btn-default">수정하기</button>
					</c:if>

					</sec:authorize>

				<button data-oper="list" class="btn btn-default">게시판으로 돌아가기</button>
					
					<form action="/board/modify" method="get" id="operForm">
						<input type="hidden"  id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
						<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
						<input type="hidden" id="amount" name="amount" value="${cri.amount}">
						<input type="hidden" id="type" name="type" value="${cri.type}">
						<input type="hidden" id="keyword" name="keyword" value="${cri.keyword}">
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
		<div class="panel-panel-default">

			<div class="panel-heading">업로드된 파일</div>
			<%--/.panel-heading--%>
			<div class="panel=body">

				<div class="uploadResult">
					<ul>

					</ul>
				</div>
			</div>
			<%--end panel body--%>
		</div>
		<%--end panel body--%>
	</div>
	<%--end panel--%>
</div>
<%--end row--%>

<div class="row">

	<div class="col-lg-12">

		<div class="panel panel-default">
			

			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				<sec:authorize access="isAuthenticated()">
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">댓글달기</button>
				</sec:authorize>
			</div>


			<!-- /.panelheading  -->
			<div class="panel-body">
				<ul class="chat">
					<!--start reply  -->
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong> <small
									class="pull-right text-muted">2018-01-01 13:13</small>
							</div>
							<p>Good job!</p>
						</div>
					</li>
				</ul>
			</div>
				<div class="panel-footer">
					
				</div>
		</div>
	</div>
</div>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글달기</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label>
					<input class="form-control" name="reply" value="새로운댓글">
				</div>
			
				<div class="form-group">
					<label>Replyer</label>
					<input class="form-control" name="replyer" value="댓글작성자">
				</div>
			
				<div class="form-group">
					<label>ReplyDate</label>
					<input class="form-control" name="replyDate" value="">
				</div>
			
			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning" >수정하기</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">삭제하기</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-default">등록하기</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default">닫기</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->



<%@include file="../includes/footer.jsp"%>


<script type="text/javascript">
	$(document).ready(function(){
		
		var operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click",function(e){
	
				console.log("modify 버튼 클릭");
			
			/* submit 까지 연결해서 사용 할수 있슴 */
			operForm.attr("action","/board/modify").submit();;
			
		});	
		
		$("button[data-oper='list']").on("click",function(e){
			
			e.preventDefault();
			
			operForm.find("#bno").remove();
			operForm.attr('action',"/board/list");
			operForm.submit();
		});
		
		
	});


</script>

<script type="text/javascript" src="/resources/js/reply.js"></script>


<script type="text/javascript">

	$(document).ready(function(){
		
		var bnoValue = '<c:out value = "${board.bno}"/>';
		var replyUL = $(".chat"); //ul 태그 
		
		showList(1);
		
		function showList(page){
			
			replyService.getList({bno:bnoValue,page:page || 1 },function(replyCnt,list){
				
				
				console.log("list:" + list);
				console.log("댓글 갯수:" + replyCnt);
				
				
				//새로운 댓글을 달면 asc 방식으로 정렬되기 떄문에 마지막 페이지를 보여줘야 방금 작성한 댓글을 확인할수 있습니다.
				if(page == -1) {
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
					
				
				
				
				
				if(list == null || list.length == 0 ){
					
						replyUL.html("");
				}

				var str = "";
			
				for(var i = 0, len = list.length || 0; i < len; i++ ){
						str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
						str += "<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
						str += "<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
						str += "<p>"+list[i].reply+"</p></div></li>";
						
					}				
				replyUL.html(str);
				showReplyPage(replyCnt);
				
			});//end function
			
			
		} //end show List;
		
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");

		var replyer = null;

		<sec:authorize access="isAuthenticated()">
			replyer = '<sec:authentication property="principal.username"/>';
		</sec:authorize>

		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";

		$("#addReplyBtn").on("click",function(e){
			
			//input 태그들의 값을 공백으로 교체
			modal.find("input").val("");
			modal.find("input[name='replyer']").val(replyer);
			modal.find("input[name='replyer']").attr("readonly","readonly");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id!='modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
			
		});

		/*ajax 를 전송하기 전에 실행하는 함수*/
		/*Ajax spring security header...*/
		$(document).ajaxSend(function(e,xhr,options){
			xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);

		});


		modalRegisterBtn.on("click",function(){
				
				var reply  = {
						reply : modalInputReply.val(),
						bno : bnoValue,
						replyer : modalInputReplyer.val()
				};
				
				replyService.add(reply,function(result){
					
						alert(result);
						
						modal.find("input").val("");
						modal.modal("hide");
						
						//다시 갱신해줘야합니다.
						//showList(1);
						showList(-1);
				});
				
				
		});
		
		$(".chat").on("click","li",function(e){
				
			//	<li class="left clearfix" data-rno='12'>
			var rno =$(this).data("rno");
			
			console.log(rno + "입니다.");
			
			replyService.get(rno,function(data){

					modalInputReply.val(data.reply);
					modalInputReplyer.val(data.replyer).attr("readonly","readonly");
					modalInputReplyDate.val(replyService.displayTime(data.replyDate)).attr("readonly","readonly");
					modal.data("rno",data.rno);

					modal.find("button[id!='modalCloseBtn']").hide();
				if(replyer==data.replyer ){
					modalModBtn.show();
				}
				if(replyer == data.replyer|| replyer.includes("admin") ){
					modalRemoveBtn.show();
				}

					$(".modal").modal("show");
				
			});
			
		});
		
		
		modalModBtn.on("click",function(e){
				
				var reply = {
						rno : modal.data("rno"),
						reply : modalInputReply.val()
				};
			
				replyService.update(reply,function(result){
					
						alert(result);
						modal.modal("hide");
						showList(pageNum);
					
				});
				
			
		});
		
		
		modalRemoveBtn.on("click",function(e){
			
			// var rno = modal.data("rno");
			var reply = {
				rno : modal.data("rno"),
				reply :modalInputReply.val()
			};
			
			replyService.remove(reply,function(result){

				alert(result);
				modal.modal("hide");

				//showList(1);
				showList(pageNum);	
			});
			
		});
		
		var pageNum =1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt){
			
			//pageNum = 2 -> 2/10.0 = 0.2 * 10 = 2 
			var endNum = Math.ceil(pageNum/10.0)*10;
			var startNum = endNum -9;
			
			var prev = startNum != 1 ;
			var next = false;
			
			if(endNum * 10 >= replyCnt){
				
				endNum = Math.ceil(replyCnt/10.0);
				
				}
			
			if(endNum * 10 <replyCnt){
				
				next = true;
				
			}
			
			
			var str = "<ul class = 'pagination pull-right'>";
			
			if(prev){
				
				str+= "<li class = 'page-item'><a class = 'page-link' href='"+(startNum-1)+"'>Previous</a></li>";	
				
			}
			
			for(var i = startNum; i <= endNum; i++){
				
				var active = pageNum == i ? "active":"";
				
				str += "<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";				
				
			}
				
			if(next){
				
				str += "<li class = 'page-item'><a class= 'page-link' href= '"+(endNum + 1)+"'>Next</a></li>";
				
			}
			
			str += "</ul></div>";
			
			
			replyPageFooter.html(str);
			
			}
							
			
			replyPageFooter.on("click",function(e){
				
					e.preventDefault();
					console.log("pageClick");
					
					var targetPageNum = $(this).attr("href");
					
					pageNum = targetPageNum ;
					
					showList(pageNum);
				
			});
			
		
		
		//for replyService add test
		
		/*function add(reply,callback)  */

		
		/* 		replyService.add(
			{ reply:"JS TEST", replyer:"tester", bno:bnoValue}		
			,
			
			function(result){
				alert("Result :" + result);
			}
		); */
		
/* 		replyService.getList({bno:bnoValue,page:1},function(list){
			
				for(var i=0, len = list.length||0; i < len; i++){
						
						console.log(list[i]);
					
				}
			
		}); */
	
		
		/* replyService.remove(1,function(data){
			
			console.log(data);
			
			if(data ==='success'){
					alert("REMOVED");
				
			}
		},function(err){
			
			alert('ERROR');
			
		}); */
		
		
/* 		 replyService.update({rno:1,bno:bnoValue,reply:'수정했습니다.'},function(result){
				
			alert("스정완료");
			
		});  */
		
		
/* 		replyService.get(1,function(data){
			
				console.log(data);
			
		});
  */






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
					var fileCallPath = encodeURIComponent(attach.uploadPath +"/s_"+ attach.uuid+"_"+attach.fileName);

					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'" +
							"data-type='"+attach.fileType+"'><div>";
					str += "<img src='/display?filename="+fileCallPath+"'>";
					str += "</div>";
					str += "</li>";
				}else{
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"'" +
							"data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'> <div>";
					str += "<span>"+attach.fileName+"</span><br/>";
					str += "<img src='/resources/img/attach.PNG'>";
					str += "</div>";
					str += "</li>";
				}
			});
			$(".uploadResult ul").html(str);

		});//end getJson
			/*업로드된 사진 보기 스크립트*/
			$(".uploadResult").on("click","li",function(e){

				console.log("view image");

				var liObj = $(this);
				console.log(liObj+"확인하기");

				var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));

				console.log(path + "값 확인하는중입니다.");
				console.log(liObj.data("type")+"입니다.");
				//image 타입
				if(liObj.data("type")){
					showImage(path.replace(new RegExp(/\\/g),""));
				}else{
					self.location="/download?fileName="+path
				}

				function  showImage(arr){

					alert(arr);


					$(".bigPictureWrapper").css("display","flex").show();

					$(".bigPicture")
							.html("<img src='/display?filename="+path+"'>")
							.animate({width:'100%',height:'100%'},1000);

				}
			});

			$(".bigPictureWrapper").on("click",function(e){
				$(".bigPicture").animate({width:'0%',height: '0%'},1000);
				setTimeout(function(){
					$('.bigPictureWrapper').hide();
				},1000);
			});


		})();//end function




	});
</script>