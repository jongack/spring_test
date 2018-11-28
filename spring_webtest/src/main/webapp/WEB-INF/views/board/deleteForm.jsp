<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ut" uri="/ELFunctions" %>
<%
// 	String root = request.getContextPath();

// 	String col = request.getParameter("col");
// 	String word = request.getParameter("word");
// 	String nowPage = request.getParameter("nowPage");
// 	boolean flag = (boolean) request.getAttribute("flag");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="content">
<c:if test="${flag }">
<p>덧글이 존재하여 삭제할 수 없습니다.</p>
</c:if>
<c:if test="${flag eq false }">
<p>글 비밀번호를 입력하세요.</p>
  <form class="form-inline" method="post" action="./delete" >
    <input type="hidden" name="num" value="${param.num }">
    <input type="hidden" name="col" value="${param.col }">
    <input type="hidden" name="word" value="${param.word }">
    <input type="hidden" name="nowPage" value="${param.nowPage }">    
    <input type="hidden" name="oldfile" value="${param.filename }">    
    <div class="form-group">
      <label for="passwd" class="mr-sm-2">Password:</label>
      <input type="password" class="form-control mb-2 mr-sm-2" id="passwd" name="passwd" required="required">
    </div>
    <button type="submit" class="btn btn-light mb-2">Submit</button>
  </form>
  <hr>
</c:if>

    <button type="button" class="btn btn-secondary" onclick="listb()">list</button>
</div>
<script>
function listb(){
	var url = "list";
	url += "?col=${param.col}";
	url += "&word=${param.word}";
	url += "&nowPage=${param.nowPage}";
	location.href = url;
}
</script>
</body>
</html>