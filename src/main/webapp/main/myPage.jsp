<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>마이페이지</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
</head>
<body>
    <%@ include file="/inc/header.jsp"%>
    <div class="container">
        <div class="row my-1">
            <div class="offset-4 col-4">
                <a class="text-decoration-none text-dark" href="/member/changePassword.jsp">비밀번호 변경</a>
            </div>
        </div>
        <div class="row my-1">
            <div class="offset-4 col-4">
                <a class="text-decoration-none text-dark" href="/member/deleteMember.jsp">계정 삭제</a>
            </div>
        </div>
    </div>
    <%@ include file="/inc/footer.jsp"%>
</body>
</html>
