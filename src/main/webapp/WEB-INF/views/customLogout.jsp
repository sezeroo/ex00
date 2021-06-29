<%--
  Created by IntelliJ IDEA.
  User: innotree
  Date: 2021-06-23
  Time: 오후 2:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

    <h1> LogOut Page</h1>

    <%--post 매핑을 해놓지 않았지만 시큐리티 내부에서 동작합니다.--%>
    <%--로그아웃시 추가 작업은 logoutSuccessHandler 를 정의해서 처리합니다.--%>
    <form action="/customLogout" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <button>로그아웃</button>
    </form>


</body>
</html>
