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
			<th>고객등급</th>
			<th>매출</th>
		</tr>
	</thead>
	<tbody>
	<%
	sql  = "SELECT mb.custno, mb.custname, mb.grade, sum(mn.price) as total ";
	sql += "FROM member_tbl_02 mb ";
	sql += "JOIN money_tbl_02 mn on mb.custno = mn.custno ";
	sql += "group by (mb.custno, mb.custname, mb.grade) ";
	sql += "order by total desc";
	ResultSet rs = conn.prepareStatement(sql).executeQuery();
	String custno, custname, grade, total;
		
		while(rs.next())
		{
				custno = rs.getString("custno");
				custname = rs.getString("custname");
				grade = rs.getString("grade");
				total = rs.getString("total");
		switch(grade)
		{
		case "A" : grade ="VIP"; break;
		case "B" : grade ="일반"; break;
		case "C" : grade ="직원"; break;
		}
	%>
	 <tr style="text-align:center">
	 	<td><%= custno %></td>
	 	<td><%= custname %></td>
	 	<td><%= grade %></td>
	 	<td><%= total %></td>
	 </tr>
	 <%
		}
	 %>
	</tbody>
</table>
<%@ include file = "footer.jsp" %>