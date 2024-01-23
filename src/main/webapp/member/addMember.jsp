<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/webjars/jquery/3.7.1/dist/jquery.min.js"></script>
    <script src="/js/addMember.js" defer></script>
</head>
<body>
    <div class="container">
        <div class="text-center">
            <a class="display-3 text-decoration-none text-dark" href="/main/main.jsp">Logo</a>
            <h1 class="modal-title mt-2">회원가입</h1>
            <form class="form-control" name="formAddMember" id="addMember" method="post" action="/addMemberAction.me">
                <div class="row my-1">
                    <label class="offset-3 col-3" for="name">이름</label>
                    <input class="col-3" name="name" id="name" placeholder="이름">
                </div>
                <div class="row my-1">
                    <label class="offset-3 col-3" for="id">아이디</label>
                    <input class="col-3" name="id" id="id" placeholder="아이디 입력(영문, 숫자 6 ~ 20자)">
                    <span class="offset-6 col-3 text-start d-none idCheck">아이디 확인</span>
                </div>
                <div class="row my-1">
                    <label class="offset-3 col-3" for="password">비밀번호</label>
                    <input class="col-3" type="password" name="password" id="password" placeholder="비밀번호 입력(영문, 숫자, 특수문자 포함 8~20자)">
                    <span class="offset-6 col-3 text-start d-none passwordCheck">비밀번호 확인</span>
                </div>
                <div class="row my-1">
                    <label class="offset-3 col-3" for="passwordRe">비밀번호 확인</label>
                    <input class="col-3" type="password" name="passwordRe" id="passwordRe" placeholder="비밀번호 확인">
                    <span class="offset-6 col-3 text-start d-none passwordReCheck">비밀번호 확인 확인</span>
                </div>
            </form>
            <button class="btn btn-dark sign" form="addMember" type="submit">회원가입</button>
        </div>
    </div>
</body>
</html>
