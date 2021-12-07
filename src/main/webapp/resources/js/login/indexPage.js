$(document).ready(function(){
		
		var modal = $("#myModal");
		var formObj = $("#memberForm");
		var resultdata;



		$("#login").on("click",function(){

			var url = "/customLogin";
			$(location).attr('href',url);



			if(!$("#saveId").is(":checked")){
				modal.find("input[name='id']").attr("placeholder","아이디를 입력해주세요");				
			}
		});

		
		$("#lgsubmit").on("click",function(e){
			var id = $("input[name='username']").val();
			var password = $("input[name='password']").val();

			var memdata = {"id":id,"password":password};

			console.log(id,password);

			$.ajax({
				url:"/login",
				async:false,
				type: "POST",
				data:memdata,
				beforeSend : function(xhr)
				{   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(data,status,jqXHR){
					if(data){
						console.log(data + "입니다");
						sessionStorage.setItem("memberID",data);

					}
				}
			})

			var member = sessionStorage.getItem("memberID");


			console.log("로그인전송버튼 클릭");
			e.preventDefault();

			//formObj.submit();

			if(!$("#saveId").is(":checked")){

				localStorage.removeItem("id");

			}else{
				var item = modal.find("input[name='username']").val();
				localStorage.setItem("id", item);
				var id = localStorage.getItem("id");
				console.log(id);
			}
			return resultdata;

		});
			
			modal.find("input[name='username']").attr("placeholder",localStorage.getItem("id"));
			modal.find("input[name='username']").attr("value",localStorage.getItem("id"));
			
			console.log(localStorage.getItem("id"));	
	
			if(sessionStorage.getItem("memberID")!=null){
				$("#login").html("내정보").attr("id","mypage");
				$("#insert").html("로그아웃").attr("id","logout");

			}

		//ajax 시작	
		
		//아이디찾기
		$("#findId").on("click",function(){
				$.ajax({
					type:'get',
					url:"/member/findId",
					success:function(result,status){
						
						window.location.href = "/member/findId";
					}
					
				});
			});
		
		//비밀번호찾기
			$("#findPw").on("click",function(){
				$.ajax({
					type:'get',
					url:"/member/findPw",
					success:function(result,status){
						
						window.location.href = "/member/findPw";
					}
					
				});
			});
		
		//회원가입하기.	
	$("#insert").on("click",function(){
		console.log("회원가입 클릭");
		$.ajax({
			type:'get',
			url:"/member/home",
			success:function(result,status){
				window.location.href = "/member/insertMember";
			}
		});
	});

	//로그아웃하기
	$("#logout").on("click",function(){
		sessionStorage.clear();
		window.location.href='/member/home';

	});

	$("#mypage").on("click",function(e){
		var memberID = sessionStorage.getItem("memberID");
		var memdata = {"id":memberID};
		e.preventDefault();
		$.ajax({
			type:'get',
			success:function(data,status,jqXHR){
				window.location.href="/member/updateMembers";
			}
		})
	});


	});
