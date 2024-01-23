<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
    <h1>redirect to main</h1>
    <%
        response.sendRedirect("/main/main.jsp");
    %>
</body>
</html>