package com.example.portfolio.member;

import com.example.portfolio.db.DBConn;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MemberDAO {

    private static MemberDAO instance;

    private MemberDAO() {}

    public static MemberDAO getInstance() {
        if (instance == null)
            instance = new MemberDAO();
        return instance;
    }

    public int getMemberListCount(String subject, String keyword) {
        // 멤버 리스트 개수
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int cnt = 0; // 리스트 개수를 저장할 변수

        try {
            String sql;
            if (subject == null && keyword == null)
                sql = "select count(*) from member";
            else
                sql = "select count(*) from member where "
                        + subject + " like '%" + keyword + "%'";

            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next())
                cnt = rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                throw new RuntimeException(e.getMessage());
            }
        }
        return cnt;
    }

    public ArrayList<MemberDTO> getMemberList(String subject, String keyword, int limit, int pageNum) {
        // 멤버 리스트 표시
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        ArrayList<MemberDTO> list = new ArrayList<>();

        int start = (pageNum - 1) * limit;

        try {
            String sql;
            if (subject == null && keyword == null)
                sql = "select * from member order by id asc limit " + start + ", " + limit;
            else
                sql = "select * from member where "
                        + subject + " like '%" + keyword + "%' "
                        + " order by id asc limit " + start + ", " + limit;
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                MemberDTO memberDTO = new MemberDTO();
                memberDTO.setId(rs.getString("id"));
                memberDTO.setName(rs.getString("name"));
                memberDTO.setPassword(rs.getString("password"));
                list.add(memberDTO);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                throw new RuntimeException(e.getMessage());
            }
        }
        return null;
    }

    public void insertMember(MemberDTO memberDTO) {
        // 회원가입
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            String sql = "insert into member (name, id, password) "
                    + "values (?, ?, ?)";
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, memberDTO.getName());
            pstmt.setString(2, memberDTO.getId());
            pstmt.setString(3, memberDTO.getPassword());

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                throw new RuntimeException(e.getMessage());
            }
        }
    }

    public boolean idCheck(String id) {
        // 아이디 중복 확인
        // 중복된 아이디 있으면 true, 없으면 false
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        boolean result = true;

        try {
            String sql = "select count(*) as cnt from member " +
                    "where id = ?";
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, id);

            rs = pstmt.executeQuery();
            rs.next();
            result = rs.getInt("cnt") >= 1 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                throw new RuntimeException(e.getMessage());
            }
        }

        return result;
    }

    public boolean loginCheck(MemberDTO memberDTO) {
        // 로그인 아이디, 비밀번호 일치 확인
        // 일치할 경우 true, 틀릴 경우 false 반환
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        boolean result = false;

        try {
            String sql = "select count(*) as cnt from member " +
                    "where id = ? and password = ?";
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, memberDTO.getId());
            pstmt.setString(2, memberDTO.getPassword());

            rs = pstmt.executeQuery();
            rs.next();
            result = rs.getInt("cnt") == 1 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                throw new RuntimeException(e.getMessage());
            }
        }

        return result;
    }

    public void changePassword(MemberDTO memberDTO) {
        // 비밀번호 변경
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            String sql = "update member set password = ? where id = ?";
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, memberDTO.getPassword());
            pstmt.setString(2, memberDTO.getId());

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                throw new RuntimeException(e.getMessage());
            }
        }
    }

    public void deleteMember(MemberDTO memberDTO) {
        // 아이디 삭제
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            String sql = "delete from member " +
                    "where id = ? and password = ?";
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, memberDTO.getId());
            pstmt.setString(2, memberDTO.getPassword());

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                throw new RuntimeException(e.getMessage());
            }
        }
    }
}
