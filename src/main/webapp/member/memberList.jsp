<%@ page import="com.example.portfolio.member.MemberDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    int totalRecord = (int) request.getAttribute("totalRecord");
    int totalPage = (int) request.getAttribute("totalPage");
    int pageNum = (int) request.getAttribute("pageNum");
    List list = (List) request.getAttribute("list");

    String subject = (String) request.getAttribute("subject");
    String keyword = (String) request.getAttribute("keyword");

    if (subject == null) subject = "";
    if (keyword == null) keyword = "";

    int displayPage = 2;
    int startPage = ((pageNum - 1) / displayPage) * displayPage + 1;
    int endPage = ((pageNum - 1) / displayPage + 1 ) * displayPage;
    if (endPage > totalPage) endPage = totalPage;
%>
<html>
<head>
    <title>회원 목록</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/webjars/jquery/3.7.1/dist/jquery.min.js"></script>
    <script src="/js/memberList.js" defer></script>
</head>
<body>
<%@ include file="/inc/header.jsp"%>
<div class="container">
    <h1 class="modal-title mt-2">전체 <%=totalRecord%>명</h1>
    <form action="/memberList.me" method="get">
        <table class="table table-hover">
            <tr class="text-center">
                <th style="width: 18%">아이디</th>
                <th style="width: 18%">이름</th>
                <th style="width: 18%">비밀번호</th>
                <th style="width: 28%"></th>
                <th style="width: 18%"></th>
            </tr>
            <%
                for (int i = 0; i < list.size(); i++) {
                    MemberDTO memberList = (MemberDTO) list.get(i);
            %>
            <tr class="text-center">
                <td><%=memberList.getId()%></td>
                <td><%=memberList.getName()%></td>
                <td><%=memberList.getPassword()%></td>
                <td><button class="btn btn-primary btn-sm" name="pwChange" type="button">비밀번호 변경</button></td>
                <td><button class="btn btn-primary btn-sm" name="deleteMember" type="button">계정 삭제</button></td>
            </tr>
            <%
                }
            %>
        </table>
        <div class="d-flex justify-content-center">
            <div>
                <%
                    if (startPage != 1) {
                %>
                <span><a class="text-decoration-none text-dark" href="/memberList.me?pageNum=<%=(startPage-1)%>&subject=<%=subject%>&keyword=<%=keyword%>"> 이전 </a></span>
                <%
                    }
                %>
                <%
                    for (int i = startPage; i <= endPage; i++) {
                        if (i == pageNum) {
                %>
                <span><b> <%=i%> </b></span>
                <%
                        }
                        else {
                %>
                <span><a class="text-decoration-none text-dark" href="/memberList.me?pageNum=<%=i%>&subject=<%=subject%>&keyword=<%=keyword%>"> <%=i%> </a></span>
                <%
                        }
                    }
                %>
                <%
                    if (endPage != totalPage) {
                %>
                <span><a class="text-decoration-none text-dark" href="/memberList.me?pageNum=<%=(endPage+1)%>&subject=<%=subject%>&keyword=<%=keyword%>"> 다음 </a></span>
                <%
                    }
                %>
            </div>
        </div>
        <div class="d-flex justify-content-start">
            <select name="subject">
                <option name="optionId" value="id">아이디</option>
                <option name="optionName" value="name">이름</option>
            </select>
            <input name="keyword" type="text" value="<%=keyword%>">
            <input class="btn btn-primary" type="submit" value="검색">
        </div>
    </form>
</div>
<%@ include file="/inc/footer.jsp"%>
</body>
</html>
