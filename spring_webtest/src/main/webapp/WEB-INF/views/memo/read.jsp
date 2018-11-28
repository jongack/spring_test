<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>
<%@ page import ="spring.model.memo.*,java.util.*" %>

<%
	MemoVO dto = (MemoVO)request.getAttribute("dto");
	String content = dto.getContent().replaceAll("\r\n", "<br>");
	int memono = (Integer)request.getAttribute("memono");
	String col = (String)request.getAttribute("col");
	String word = (String)request.getAttribute("word");
	String nowPage = (String)request.getAttribute("nowPage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 20px;
}

div {
	text-align: center;
	margin-top: 20px;
	margin-bottom: 20px;
}

table {
	width: 60%;
	margin: 0 auto;
}

table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	padding: 10px
}
</style>
<script type="text/javascript">
	function mupdate(memono) {
		var url = "update"
		url += "?memono=" + memono;
		url=url+"&col=<%=request.getParameter("col")%>";
		url=url+"&word=<%=request.getParameter("word")%>";
		url=url+"&nowPage=<%=request.getParameter("nowPage")%>";
		location.href = url;
	}
	function mdelete(memono) {
		var url = "delete";
		url += "?memono=" + memono;
		url=url+"&col=<%=request.getParameter("col")%>";
		url=url+"&word=<%=request.getParameter("word")%>";
		url=url+"&nowPage=<%=request.getParameter("nowPage")%>";
		location.href = url;
	}
	function mcreate() {
		var url = "create";
		url += "?memono=<%=memono%>"; 
		location.href = url;
	}
	function mlist() {
		var url = "list";
		url=url+"?col=<%=request.getParameter("col")%>";
		url=url+"&word=<%=request.getParameter("word")%>";
		url=url+"&nowPage=<%=request.getParameter("nowPage")%>";
		location.href = url;
	}
	function mreply(memono) {
		var url = "reply";
		url=url+"?memono="+<%=memono%>;
		url=url+"&col=<%=request.getParameter("col")%>";
		url=url+"&word=<%=request.getParameter("word")%>";
		url=url+"&nowPage=<%=request.getParameter("nowPage")%>";
		location.href = url;
	}
</script>
</head>
<body>

	<div>조회</div>
	<div>
		<table>
			<tr>
				<th>제목</th>
				<td><%=dto.getTitle()%></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><%=content%></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=dto.getViewcnt()%></td>
			</tr>
			<tr>
				<th>등록일</th>
				<td><%=dto.getWdate()%></td>
			</tr>

		</table>
	</div>
	<div>
		<input type="button" value="등록" onclick="mcreate()"> 
		<input type="button" value="수정"
			onclick="mupdate('<%=memono%>')">
		<input type="button" value="삭제"
			onclick="mdelete('<%=memono%>')">
		<input type="button" value="목록" onclick="mlist()">
		<button onclick="mreply('<%=memono%>')">답변</button>
	</div>

</body>
</html>
