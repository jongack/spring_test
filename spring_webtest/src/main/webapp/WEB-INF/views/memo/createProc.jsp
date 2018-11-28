<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>


<%
	

	
	
	
	boolean flag = (Boolean)request.getAttribute("flag");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

</head>
<body>
	<div class ="container" align="center">
		<%
			if (flag) {
				out.println("메모를 등록했습니다.<br><br>");
			} else {
				out.println("메모를 실패했습니다.<br><br>");
			}
		%>
		<br> 
		<input type="button" value="계속 등록" onclick="location.href='./create.do'">
		<input type="button" value="목록" onclick="location.href='./list.do'">
	</div>
</body>
</html>