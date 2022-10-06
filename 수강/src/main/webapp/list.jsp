<%@page import="DBPKG.Util"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./style.css"/>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section>
		<h1>교과서 목록</h1>
		<table border="1">
			<tr>
				<th>과목코드</th>
				<th>과목명</th>
				<th>학점</th>
				<th>담당강사</th>
				<th>요일</th>
				<th>시작시간</th>
				<th>종료시간</th>
				<th>삭제</th>
			</tr>
<%
request.setCharacterEncoding("UTF-8");
Connection conn = null;
Statement stmt = null;
int week;
String id = "";


try{
	conn = Util.getConnection();
	stmt = conn.createStatement();
	
	String mon="";
	String shour="";
	String endhour="";
	
	String sql="select id, course_tbl.name as name1, credit, lecturer_tbl.name as name2, week, start_hour, end_hour from course_tbl, lecturer_tbl where lecturer_tbl.idx = course_tbl.lecturer order by id ";
	ResultSet rs = stmt.executeQuery(sql);
	while(rs.next()){
		week = rs.getInt("week");
		id = rs.getString("id");
		switch(week){
		case 1:
			mon= "월요일";
			break;
		case 2:
			mon= "화요일";
			break;
		case 3:
			mon= "수요일";
			break;
		case 4:
			mon= "목요일";
			break;
		case 5:
			mon= "금요일";
			break;
		case 6:
			mon= "토요일";
			break;
		case 7:
			mon= "일요일";
			break;
		}
		if(rs.getString("start_hour").length() < 4) shour= "0" + rs.getString("start_hour").substring(0,1) + "시" + rs.getString("start_hour").substring(1) + "분" ;
		else shour = rs.getString("start_hour").substring(0,2) + "시" + rs.getString("start_hour").substring(2) + "분" ;
		if(rs.getString("end_hour").length()<4) endhour = "0" + rs.getString("end_hour").substring(0,1) + "시" + rs.getString("end_hour").substring(1) + "분" ;
		else endhour = rs.getString("end_hour").substring(0,2) + "시" + rs.getString("end_hour").substring(2) + "분" ;
		
			
%>
			<tr>
				<td><a href="modify.jsp?id=<%=id %>"><%=id %></a></td>
				<td><%=rs.getString("name1") %></td>
				<td><%=rs.getString("credit") %></td>
				<td><%=rs.getString("name2") %></td>
				<td><%=mon %></td>
				<td><%=shour %></td>
				<td><%=endhour %></t>
				<td><a href="delete.jsp?id=<%=id %>">삭제</a></td>
			</tr>
<%
	}
}
catch(Exception e){
		e.printStackTrace();
}
%>
		</table>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>