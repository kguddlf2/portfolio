<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>비밀번호 변경</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/webjars/jquery/3.7.1/dist/jquery.min.js"></script>
    <script src="/js/changePassword.js" defer></script>
</head>
<body>
    <%@ include file="/inc/header.jsp"%>
    <div class="container mt-2">
        <div class="text-center">
            <h1 class="modal-title">비밀번호 변경</h1>
            <form class="form-control" id="changePassword" method="post" action="/changePassword.me">
                <div class="row my-1">
                    <label class="offset-3 col-3" for="password">새 비밀번호</label>
                    <input class="col-3" type="password" name="password" id="password" placeholder="비밀번호 입력(문자, 숫자, 특수문자 포함 8~20자)">
                    <span class="offset-6 col-3 text-start d-none passwordCheck">비밀번호 확인</span>
                </div>
                <div class="row my-1">
                    <label class="offset-3 col-3" for="passwordRe">비밀번호 확인</label>
                    <input class="col-3" type="password" name="passwordRe" id="passwordRe" placeholder="비밀번호 확인">
                    <span class="offset-6 col-3 text-start d-none passwordReCheck">비밀번호 확인 확인</span>
                </div>
            </form>
            <button class="btn btn-dark sign" form="changePassword" type="submit">비밀번호 변경</button>
        </div>
    </div>
    <%@ include file="/inc/footer.jsp"%>
</body>
</html>
