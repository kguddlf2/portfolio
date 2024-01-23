<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>계정 삭제</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/webjars/jquery/3.7.1/dist/jquery.min.js"></script>
    <script src="/js/deleteMember.js" defer></script>
</head>
<body>
    <%@ include file="/inc/header.jsp"%>
    <div class="container mt-2">
        <div class="text-center">
            <h1 class="modal-title">본인 확인</h1>
            <form class="form-control" id="deleteMember" method="post" action="/deleteMember.me">
                <div class="row my-1">
                    <label class="offset-3 col-3" for="id">아이디</label>
                    <input class="col-3" name="id" id="id" placeholder="아이디 입력(6 ~ 20자)">
                </div>
                <div class="row my-1">
                    <label class="offset-3 col-3" for="password">비밀번호</label>
                    <input class="col-3" type="password" name="password" id="password" placeholder="비밀번호 입력(문자, 숫자, 특수문자 포함 8~20자)">
                </div>
            </form>
            <button class="btn btn-dark .sign" form="deleteMember" type="submit">확인</button>
        </div>
    </div>
    <%@ include file="/inc/footer.jsp"%>
</body>
</html>
