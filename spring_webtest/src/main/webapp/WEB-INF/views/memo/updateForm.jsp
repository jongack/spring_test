<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>
<%@ page import ="spring.model.memo.*,java.util.*" %>
<%
	
	MemoVO dto = (MemoVO)request.getAttribute("dto");
	String content = dto.getContent().replaceAll("\r\n", "<br>");
	
	int memono = Integer.parseInt(request.getParameter("memono"));
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

table {
	width: 50%;
	margin: 0 auto;
}

table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}
</style>
<script type="text/javascript">
function incheck(f){
	if(f.title.value==""){
		alert("제목을 입력하세요");
		f.title.focus();
		return false;
	}
	if(f.content.value==""){
		alert("내용을 입력하세요");
		f.content.focus();
		return false;
	}

}</script>
</head>
<body>
	<div>재등록</div>
	<form name="frm" method="post" action="./update" onsubmit="return incheck(this)">
	<input type="hidden" name="memono" value="<%=memono%>"/>
	<input type="hidden" name="col" value="<%=request.getParameter("col")%>"/>
	<input type="hidden" name="word" value="<%=request.getParameter("word")%>"/>
	<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>"/>
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" size="30" value="<%=dto.getTitle() %>" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="30" name="content"><%=content %></textarea>
				</td>
			</tr>
		</table>
		<div>
			<input type="submit" value="전송">
		</div>
	</form>

</body>
</html>