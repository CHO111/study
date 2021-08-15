<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
	String action = request.getParameter("action");
	String move_url = "./";
	PreparedStatement pstmt = null;
	
	switch(action){
	case "insert" :
		sql ="insert into member_tbl_02 values(member_seq.nextval, ? ,? ,? ,? ,?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("custname"));
		pstmt.setString(2, request.getParameter("phone"));
		pstmt.setString(3, request.getParameter("address"));
		pstmt.setString(4, request.getParameter("joindate"));
		pstmt.setString(5, request.getParameter("grade"));
		pstmt.setString(6, request.getParameter("city"));
		break;
	case "udpate" :
		sql ="update member_tbl_02 set custname=?, phone=?, address=?, joindate=?, grade=?, city=? where custno=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("custname"));
		pstmt.setString(2, request.getParameter("phone"));
		pstmt.setString(3, request.getParameter("address"));
		pstmt.setString(4, request.getParameter("joindate"));
		pstmt.setString(5, request.getParameter("grade"));
		pstmt.setString(6, request.getParameter("city"));
		pstmt.setInt(7, Integer.parseInt(request.getParameter("custno")));
		break;
	}
	pstmt.executeQuery();
%>
<script>
alert("등록되었습니다");
location.replace("<%=move_url%>");
</script>