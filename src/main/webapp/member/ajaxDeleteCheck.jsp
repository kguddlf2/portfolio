<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.portfolio.member.MemberDTO" %>
<%@ page import="com.example.portfolio.member.MemberDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("idVal");
    String pw = request.getParameter("pwVal");
    MemberDAO memberDAO = MemberDAO.getInstance();
    MemberDTO memberDTO = new MemberDTO();

    memberDTO.setId(id);
    memberDTO.setPassword(pw);

    boolean result = memberDAO.loginCheck(memberDTO);
%>
<%=result%>