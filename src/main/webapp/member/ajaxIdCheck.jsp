<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.portfolio.member.MemberDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("idVal");
    MemberDAO memberDAO = MemberDAO.getInstance();

    boolean result = memberDAO.idCheck(id);
%>
<%=result%>
