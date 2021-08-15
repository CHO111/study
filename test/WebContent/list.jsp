<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="header.jsp"%>
<h2>회원목록</h2>
<table>
	<thead>
		<tr>
			<th>회원번호</th>
			<th>회원성명</th>
			<th>전화번호</th>
			<th>주소</th>
			<th>가입일자</th>
			<th>고객등급</th>
			<th>거주지역</th>
		</tr>
	</thead>
	<tbody>
	<%
		sql = "select * from member_tbl_02 order by custno asc" ;		
		ResultSet rs = conn.prepareStatement(sql).executeQuery();
		String custno, custname, phone, address, joindate, grade, city;
		
		while(rs.next())
		{
				custno = rs.getString("custno");
				custname = rs.getString("custname");
				phone = rs.getString("phone");
				address = rs.getString("address");
				grade = rs.getString("grade");
				city = rs.getString("city");
				joindate = rs.getString("joindate");
				if(joindate.length() > 10) joindate = joindate.substring(0, 10);
				
		switch(grade)
		{
		case "A" : grade ="VIP"; break;
		case "B" : grade ="일반"; break;
		case "C" : grade ="직원"; break;
		}
	%>
		<tr style="text-align:center;">
	 	<td><a href="./udpate.jsp?custno=<%=custno%>"><%= custno %></a></td>
	 	<td><%= custname %></td>
	 	<td><%= phone %></td>
	 	<td><%= address %></td>
	 	<td><%= joindate %></td>
	 	<td><%= grade %></td>
	 	<td><%= city %></td>
	 </tr>
	 <%
		}
	 %>
	</tbody>
</table>
<%@ include file = "footer.jsp" %>