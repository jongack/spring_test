<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %> 

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: ; 
  font-size: 24px; 
} 
</style> 

<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 
<h2>로그인 처리</h2>
 
 
  <div class="container">
  <c:choose>
  	<c:when test="${flag }">
  		로그인 성공<br>
  		<input type="button" value="홈" onclick="location.href='${root}'">
  	</c:when>
  	<c:otherwise>
  		회원이 아니거나 아이디나 비밀번호가 틀렸습니다<br>
  		 <input type='button' value='다시시도' onclick="history.back()">
    	<input type="button" value="아이디찾기" onclick="location.href='idFind'">
  	</c:otherwise>
  </c:choose>

  

  
  

<!-- *********************************************** -->
</div>
</body>
<!-- *********************************************** -->
 
</html> 