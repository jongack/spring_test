<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>
<%
	String col = (String)request.getAttribute("col");
	String word = (String)request.getAttribute("word");
	String nowPage = (String)request.getAttribute("nowPage");
	
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
	margin-top: 100px;
}
</style>
<script type="text/javascript">
function mlist() {
	var url = "list.do";
	url=url+"?col=<%=col%>";
	url=url+"&word=<%=word%>";
	url=url+"&nowPage=<%=nowPage%>";
	location.href = url;
}
</script>
</head>
<body>
	<div>
		<%
			if (flag) {
				out.print("메모를 삭제했습니다.");
			} else {
				out.print("메모삭제를 실패했습니다.");
			}
		%>
		<br> <input type="button" value="목록"
			onclick="mlist()">
	</div>
</body>
</html>