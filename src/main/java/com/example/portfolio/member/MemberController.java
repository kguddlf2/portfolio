package com.example.portfolio.member;


import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

public class MemberController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String ADMIN = "test"; // 관리자 계정

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String requestURI = request.getRequestURI(); // 전체 경로를 가져옴
        String contextPath = request.getContextPath(); // 프로젝트 path만 가져옴
        String command = requestURI.substring(contextPath.length()); // 전체 경로에서 프로젝트 path 길이 만큼의 인덱스 이후 문자열을 가져옴

        response.setContentType("text/html; charset=utf-8");
        response.setCharacterEncoding("utf-8");

        if (command.equals("/addMemberAction.me")) { // 회원가입
            insertMember(request);
            RequestDispatcher rd = request.getRequestDispatcher("/member/login.jsp");
            rd.forward(request, response);
        } else if (command.equals("/loginAction.me")) { // 로그인
            boolean isLogin = login(request);
            RequestDispatcher rd;
            if (isLogin == true) { // 로그인 성공시
                rd = request.getRequestDispatcher("/main/main.jsp");
                rd.forward(request, response);
            }
            else { // 로그인 실패시
                response.sendRedirect("/member/login.jsp?err=0");
            }
        } else if (command.equals("/logout.me")) { // 로그아웃
            logout(request);
            response.sendRedirect("/main/main.jsp");
        } else if (command.equals("/changePassword.me")) { // 비밀번호 변경
            changePassword(request);
            response.sendRedirect("/main/main.jsp");
        } else if (command.equals("/deleteMember.me")) { // 계정 삭제
            deleteMember(request);
            RequestDispatcher rd = request.getRequestDispatcher("/main/main.jsp");
            rd.forward(request, response);
        } else if (command.equals("/memberList.me")) { // 회원 정보 페이지로
            boolean admin = showMemberList(request);
            if (admin == true) { // 관리자 계정일 경우
                RequestDispatcher rd = request.getRequestDispatcher("/member/memberList.jsp");
                rd.forward(request, response);
            }
            else { // 관리자 계정이 아닐 경우
                response.sendRedirect("/main/main.jsp");
            }
        }
    }

    public void insertMember(HttpServletRequest request) {
        // 회원가입
        MemberDTO memberDTO = new MemberDTO();
        MemberDAO memberDAO = MemberDAO.getInstance();

        // 회원가입 페이지에서 가져온 이름, 아이디, 비밀번호 memberDTO에 넣기
        String name = request.getParameter("name");
        String id = request.getParameter("id");
        String password = request.getParameter("password");

        memberDTO.setName(name);
        memberDTO.setId(id);
        memberDTO.setPassword(password);

        memberDAO.insertMember(memberDTO);
    }

    public boolean login(HttpServletRequest request) {
        // 로그인
        MemberDTO memberDTO = new MemberDTO();
        MemberDAO memberDAO = MemberDAO.getInstance();

        HttpSession session = request.getSession();

        // 로그인 페이지에서 가져온 아이디, 비밀번호 memberDTO에 넣기
        String id = request.getParameter("id");
        String password = request.getParameter("password");

        memberDTO.setId(id);
        memberDTO.setPassword(password);

        boolean isLogin = memberDAO.loginCheck(memberDTO);
        if (isLogin == true) { // 로그인 정보가 맞으면
            session.setAttribute("sessionID", id); // session 에 id 저장
            session.setMaxInactiveInterval(12*60*60); // 12시간 설정
        }

        return isLogin;
    }

    public void logout(HttpServletRequest request) {
        // 로그아웃
        HttpSession session = request.getSession();
        session.invalidate();
    }

    public void changePassword(HttpServletRequest request) {
        // 비밀번호 변경
        MemberDTO memberDTO = new MemberDTO();
        MemberDAO memberDAO = MemberDAO.getInstance();

        HttpSession session = request.getSession();

        String id = (String) session.getAttribute("sessionID");
        String password = request.getParameter("password");

        memberDTO.setId(id);
        memberDTO.setPassword(password);

        memberDAO.changePassword(memberDTO);
    }

    public void deleteMember(HttpServletRequest request) {
        // 계정 삭제
        MemberDTO memberDTO = new MemberDTO();
        MemberDAO memberDAO = MemberDAO.getInstance();

        String id = request.getParameter("id");
        String password = request.getParameter("password");

        memberDTO.setId(id);
        memberDTO.setPassword(password);

        memberDAO.deleteMember(memberDTO);
        logout(request);
    }

    public boolean showMemberList(HttpServletRequest request) {
        // 회원 정보 표시
        MemberDAO memberDAO = MemberDAO.getInstance();
        HttpSession session = request.getSession();

        String id = (String) session.getAttribute("sessionID");
        if (id == null) id = "";

        boolean admin = false;
        if (id.equals(ADMIN)) { // 관리자 계정이면 true로
            admin = true;
        }

        int limit = 3;
        int pageNum = 1;
        if (request.getParameter("pageNum") != null)
            pageNum = Integer.parseInt(request.getParameter("pageNum"));

        String subject = request.getParameter("subject");
        String keyword = request.getParameter("keyword");

        if (subject == "") subject = null;
        if (keyword == "") keyword = null;

        ArrayList<MemberDTO> list = memberDAO.getMemberList(subject, keyword, limit, pageNum);
        int totalRecord = memberDAO.getMemberListCount(subject, keyword);

        int totalPage;

        if (totalRecord % limit == 0) {
            totalPage = totalRecord / limit;
            Math.floor(totalPage);
        }
        else {
            totalPage = totalRecord / limit + 1;
            Math.floor(totalPage);
        }

        request.setAttribute("subject", subject);
        request.setAttribute("keyword", keyword);
        request.setAttribute("totalRecord", totalRecord);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("list", list);

        return admin;
    }
}
