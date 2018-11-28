<%@ page contentType="text/html; charset=UTF-8"%>
<%
	

	int memono = Integer.parseInt(request.getParameter("memono"));

	boolean flag = (Boolean)request.getAttribute("flag");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 24px;
}

div {
	text-align: center;
	margin-top: 20px;
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<h2>삭제 확인</h2>
	
	<%if(flag){ %>
	부모글이므로 삭제할 수 없습니다<br><br>
	<input type="button" value="취소" onclick='history.back()'>
	
	<%}else{ %>
	
	<form method="post" action="delete">
		<input type="hidden" name="memono" value="<%=memono%>">
		<input type="hidden" name="col" value="<%=request.getParameter("col")%>"/>
		<input type="hidden" name="word" value="<%=request.getParameter("word")%>"/>
		<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>"/>
		<div>
			삭제를 하면 복구 될 수 없습니다.<br>
			<br> 삭제하시려면 삭제버튼을 클릭하세요<br>
			<br> 취소는 '취소'버튼을 누르세요 <br>
			<br> <input type="submit" value="삭제처리"> <input
				type="button" value="취소" onclick='history.back()'>
		</div>
	</form>
	<%} %>
</body>
</html>
