<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<link rel="stylesheet" href="/css/bootstrap.min.css">--%>
<%
    String sessionID = (String) session.getAttribute("sessionID");
%>
<div class="container">
    <div class="row mt-2">
        <div class="col-2">
            <a class="display-6 text-decoration-none text-dark" href="/main/main.jsp">Logo</a>
        </div>
        <%
            if (sessionID == null) { // 로그인 안 됐을 때
        %>
        <div class="offset-6 col-2">
            <a class="text-decoration-none text-dark" href="/member/login.jsp">로그인</a>
        </div>
        <%
        }
            else if (sessionID.equals("test")) { // 관리자 계정
        %>
        <div class="offset-6 col-1">
            <a class="text-decoration-none text-dark" href="/main/myPage.jsp"><%=sessionID%></a>
        </div>
        <div class="col-1">
            <a class="text-decoration-none text-dark" href="/memberList.me">회원 관리</a>
        </div>
        <div class="col-1">
            <a class="text-decoration-none text-dark" href="/logout.me">로그아웃</a>
        </div>
        <%
            }
            else { // 로그인 됐을 때
        %>
        <div class="offset-6 col-2">
            <a class="text-decoration-none text-dark" href="/main/myPage.jsp"><%=sessionID%></a>
        </div>
        <div class="col-2">
            <a class="text-decoration-none text-dark" href="/logout.me">로그아웃</a>
        </div>
        <%
            }
        %>
    </div>
</div>
