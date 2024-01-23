<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.portfolio.member.MemberDTO" %>
<%@ page import="com.example.portfolio.member.MemberDAO" %>
<%@ page import="java.util.regex.Pattern" %>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("idVal");
    String pw = request.getParameter("pwVal");
    MemberDAO memberDAO = MemberDAO.getInstance();
    MemberDTO memberDTO = new MemberDTO();

    boolean res;
    String regexPw = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$";
    res = Pattern.matches(regexPw, pw);

    if (res) {
        memberDTO.setId(id);
        memberDTO.setPassword(pw);

        memberDAO.changePassword(memberDTO);
    }
%>
<%=res%>