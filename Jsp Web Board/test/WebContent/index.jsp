<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ include file="header.jsp" %>

<%
	sql = "select custno from member_tbl_02 where rownum <= 1 order by custno desc ";
	ResultSet rs = conn.prepareStatement(sql).executeQuery();
	int custno = 10001;
	if(rs.next()) custno = rs.getInt(1)+1;
%>
<h2>홈쇼핑 회원 등록</h2>
<script>
function checkAll() {
	if(custname.value==""){
		alert("이름을 입력해주세요");
		custname.focus();
		return false;
	}
	if(phone.value==""){
		alert("이름을 입력해주세요");
		phone.focus();
		return false;
	}
	if(address.value==""){
		alert("이름을 입력해주세요");
		address.focus();
		return false;
	}
	if(joindate.value==""){
		alert("이름을 입력해주세요");
		joindate.focus();
		return false;
	}
	if(grade.value==""){
		alert("이름을 입력해주세요");
		grade.focus();
		return false;
	}
	if(city.value==""){
		alert("이름을 입력해주세요");
		city.focus();
		return false;
	}
	document.form.action="./action.jsp";
} 
</script>
<form method="post" name="form">
	<input type="hidden" name="action" value="insert">
	<table>
		<tr>
			<th>회원번호</th>
			<td><input type="text"" size="20" name="custno" id="custno"></td>
		</tr>
		<tr>
			<th>회원이름</th>
			<td><input type="text"" size="20" name="custname" id="custname"></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="text"" size="20" name="phone" id="phone"></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text"" size="20" name="address" id="address"></td>
		</tr>
		<tr>
			<th>가입일자</th>
			<td><input type="text"" size="20" name="joindate" id="joindate"></td>
		</tr>
		<tr>
			<th>등급</th>
			<td><input type="text"" size="20" name="grade" id="grade"></td>
		</tr>
		<tr>
			<th>도시코드</th>
			<td><input type="text"" size="20" name="city" id="city"></td>
		</tr>
	</table>
	<div class="btn_group">
		<button type="submit" onclick="checkAll();">
		<button type="button" >
	</div>
</form>
<%@ include file="footer.jsp" %>