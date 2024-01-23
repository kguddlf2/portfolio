<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <div class="text-center">
            <a class="display-3 text-decoration-none text-dark" href="/main/main.jsp">Logo</a>
            <h1 class="modal-title mt-2">로그인</h1>
            <%
                // 파라미터에 err가 있는 경우
                String err = request.getParameter("err");
                if (err != null) {
                    out.println("<div class=\"alert alert-danger\">");
                    out.println("아이디와 비밀번호를 확인해주세요.");
                    out.println("</div>");
                }
            %>
            <form class="form-control" id="login" method="post" action="/loginAction.me">
                <div class="row my-1">
                    <label class="offset-3 col-3" for="id">아이디</label>
                    <input class="col-3" name="id" id="id" placeholder="아이디 입력(6 ~ 20자)">
                </div>
                <div class="row my-1">
                    <label class="offset-3 col-3" for="password">비밀번호</label>
                    <input class="col-3" type="password" name="password" id="password" placeholder="비밀번호 입력(문자, 숫자, 특수문자 포함 8~20자)">
                </div>
            </form>
            <button class="btn btn-dark" form="login" type="submit">로그인</button>
            <a class="btn btn-dark" href="/member/addMember.jsp">회원가입</a>
        </div>
    </div>
</body>
</html>
