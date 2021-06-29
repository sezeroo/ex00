<%--
  Created by IntelliJ IDEA.
  User: innotree
  Date: 2021-06-23
  Time: 오전 9:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h1>Access Denied</h1>

    <h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"/></h2>

    <h2><c:out value="${msg}"/></h2>

</body>
</html>
