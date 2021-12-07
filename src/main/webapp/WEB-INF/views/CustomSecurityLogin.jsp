<%--
  Created by IntelliJ IDEA.
  User: innotree
  Date: 2021-12-07
  Time: 오후 3:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <title>Title</title>
</head>
<link rel="stylesheet"
      href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script
        src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
        src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<script src="/resources/js/login/indexPage.js"></script>

<link href="/resources/css/login.css" rel="stylesheet">



<body>

        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel" align="center">로그인</h4>
                </div>
                <div class="modal-body">
                    <form action="/login" method="post" id="memberForm">

                        <input class="csrfId" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div class="form-group">
                            <input class="form-control" name="username" placeholder="아이디를 입력해주세요." value="">
                        </div>

                        <div class="form-group">
                            <input class="form-control" type="password" name="password" placeholder="비밀번호를 입력해주세요.">
                        </div>

                        <div class="loginMid">
                            <label class="autoLogin" for="hint">
                                <input type="checkbox" id="saveId" /> 아이디저장
                            </label>

                            <div class="autoLogin">
                                <input type="checkbox" id="searchId">  자동로그인
                            </div>
                        </div>


                        <div class="row">

                            <div class="col-lg-2">

                            </div>

                            <div class="col-lg-8" align="center">
                                <button type="button" class="btn btn-default" data-dismiss="modal" id="lgsubmit">로그인</button>
                            </div>

                            <div class="col-lg-2">

                            </div>
                        </div>

                        <div class="row">

                            <div class="col-lg-2">

                            </div>

                            <div class="col-lg-8" align="center">
                                <a href="/member/" id="findId">아이디 찾기/</a>
                                <a href="/member/" id="findPw">비밀번호찾기/</a>
                                <a href="/member/" id="insertMember">회원가입</a>
                            </div>

                            <div class="col-lg-2">

                            </div>
                        </div>
                    </form>
                </div>

                <div class="modal-footer">

                    <div class="row">
                        <div class="col-lg-2">

                        </div>
                        <div class="col-lg-8" align="center">
                            <button id="naverBtn" class='btn-social-login'style='background:#1FC700'><i class="xi-2x xi-naver"></i></button>
                            <button class='btn-social-login' style='background:#FFEB00'><i class="xi-2x xi-kakaotalk text-dark"></i></button>
                            <button class='btn-social-login' style='background:#4267B2'><i class="xi-2x xi-facebook"></i></button>
                            <button class='btn-social-login' style='background:#55ACEE'><i class="xi-2x xi-twitter"></i></button>
                        </div>
                        <div class="col-lg-2">

                        </div>
                    </div>
                </div>
            </div>
            <!-- /.modal-content -->

</body>
<script>
    $("#lgsubmit").on("click",function(e){
        e.preventDefault();
        $("form").submit();
    })

</script>

</html>
