<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Bootstrap Admin Theme</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <link href="/resources/css/mainpage.css" rel="stylesheet">
    <link href="/resources/css/login.css" rel="stylesheet">
    <script src="/resources/js/login/indexPage.js"></script>
    <script>
        $(document).ready(function(){
            <sec:authorize access="isAuthenticated()">
           const replyer = '<sec:authentication property="principal.username"/>';
            </sec:authorize>

            if(replyer.length >= 1){
                $("#login").html("????????????");
            }else{
                console.log("????????????????????????" + replyer)

            }

            $("#login").on("click",function(e){
                e.preventDefault();

                if(replyer.length >= 1){
                    var url = "/customLogout";
                    $(location).attr('href',url);

                }
            })
        })
    </script>

</head>

<body>

<div class="wrap">
    <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
        <div class="nav" id="navDiv">
            <ul>
                <li><a class="navbar-brand" href="/board/list">IUM</a></li>
                <li ><button class= "btn-primary btn-default" id="login" autocapitalize="off" >?????????</button></li>
                <li><button class="btn-info btn-default" id="insert">????????????</button></li>
            </ul>
        </div>
    </nav>
</div>


<!-- ????????? ??????  -->
<%--<div class="container">--%>
<%--    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"--%>
<%--         aria-labelledby="myModalLabel" aria-hidden="true">--%>
<%--        <div class="modal-dialog">--%>
<%--            <div class="modal-content">--%>
<%--                <div class="modal-header">--%>
<%--                    <button type="button" class="close" data-dismiss="modal"--%>
<%--                            aria-hidden="true">&times;</button>--%>
<%--                    <h4 class="modal-title" id="myModalLabel" align="center">?????????</h4>--%>
<%--                </div>--%>


<%--                <div class="modal-body">--%>
<%--                    <form action="/member/login" method="post" id="memberForm">--%>
<%--                        <div class="form-group">--%>
<%--                            <input class="form-control" name="id" placeholder="???????????? ??????????????????." value="">--%>
<%--                        </div>--%>

<%--                        <div class="form-group">--%>
<%--                            <input class="form-control" type="password" name="password" placeholder="??????????????? ??????????????????.">--%>
<%--                        </div>--%>

<%--                        <div class="loginMid">--%>
<%--                            <label class="autoLogin" for="hint">--%>
<%--                                <input type="checkbox" id="saveId" /> ???????????????--%>
<%--                            </label>--%>

<%--                            <div class="autoLogin">--%>
<%--                                <input type="checkbox" id="searchId">  ???????????????--%>
<%--                            </div>--%>
<%--                        </div>--%>


<%--                        <div class="row">--%>

<%--                            <div class="col-lg-2">--%>

<%--                            </div>--%>

<%--                            <div class="col-lg-8" align="center">--%>
<%--                                <button type="button" class="btn btn-default" data-dismiss="modal" id="lgsubmit">?????????</button>--%>
<%--                            </div>--%>

<%--                            <div class="col-lg-2">--%>

<%--                            </div>--%>
<%--                        </div>--%>

<%--                        <div class="row">--%>

<%--                            <div class="col-lg-2">--%>

<%--                            </div>--%>

<%--                            <div class="col-lg-8" align="center">--%>
<%--                                <a href="/member/" id="findId">????????? ??????/</a>--%>
<%--                                <a href="/member/" id="findPw">??????????????????/</a>--%>
<%--                                <a href="/member/" id="insertMember">????????????</a>--%>
<%--                            </div>--%>

<%--                            <div class="col-lg-2">--%>

<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </form>--%>
<%--                </div>--%>

<%--                <div class="modal-footer">--%>

<%--                    <div class="row">--%>
<%--                        <div class="col-lg-2">--%>

<%--                        </div>--%>
<%--                        <div class="col-lg-8" align="center">--%>
<%--                            <button id="naverBtn" class='btn-social-login'style='background:#1FC700'><i class="xi-2x xi-naver"></i></button>--%>
<%--                            <button class='btn-social-login' style='background:#FFEB00'><i class="xi-2x xi-kakaotalk text-dark"></i></button>--%>
<%--                            <button class='btn-social-login' style='background:#4267B2'><i class="xi-2x xi-facebook"></i></button>--%>
<%--                            <button class='btn-social-login' style='background:#55ACEE'><i class="xi-2x xi-twitter"></i></button>--%>
<%--                        </div>--%>
<%--                        <div class="col-lg-2">--%>

<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <!-- /.modal-content -->--%>
<%--        </div>--%>
<%--        <!-- /.modal-dialog -->--%>
<%--    </div>--%>
    <!-- /.modal -->
    <!-- end container  -->
<%--</div>--%>


      