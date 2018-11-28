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
	function mlist(){
		var url="list.do"
		url=url+"?col=<%=(String)request.getAttribute("col")%>";
		url=url+"&word=<%=(String)request.getAttribute("word")%>";
		url=url+"&nowPage=<%=(String)request.getAttribute("nowPage")%>";
		location.href=url;
	}
</script>
</head>
<body>
	<div>
		<%
			if (flag) {
				out.println("메모를 재등록했습니다.");
			} else {
				out.println("메모를 실패했습니다.");
			}
		%>
		<br> 
		<input type="button" value="계속 등록" onclick="location.href='./create.do'">
		<input type="button" value="목록" onclick="mlist()">
	</div>
</body>
</html>