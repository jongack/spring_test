<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); %> 
<%@ include file="/ssi/ssi.jsp" %>
<c:choose>
	<c:when test="${!dflag}">
		<c:set var="flag" value="${flag}"></c:set>
	</c:when>
	<c:otherwise>
		<c:set var="flag" value="false"></c:set>
	</c:otherwise>
</c:choose>


<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
table,th,td{
	border:1px solid black;
	border-collapse:collapse;
}
table{
	width:70%;
	margin:5px auto;
	}
div{
	text-align:center;
}
</style> 
<script type="text/javascript">
function tlist(){
	var url = "list";
	url=url+"?col=${param.col}";
	url=url+"&word=${param.word}";
	url=url+"&nowPage=${param.nowPage}";
	location.href=url;
}
</script>
</head> 
<body> 
<div class="container">
<h2>처리결과</h2>
<div>
<c:choose>
	<c:when test="${dflag }">
		답변글이 있으므로 삭제할 수 없습니다.<br>
	</c:when>
	<c:when test="${flag }">
		삭제를 성공했습니다<br>
	</c:when>
	<c:otherwise>
		삭제를 실패했습니다.<br>
	</c:otherwise>
</c:choose>

</div>

<button onclick="tlist()">목록</button>

</div>
</body> 
</html> 