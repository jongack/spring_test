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
  <div class ="container" >
 
<h2>비밀번호 수정결과</h2>
 
 
 ${str }
  

  
 
  <c:if test="${!pflag }">
  	<input type="button" value="다시시도" onclick="history.back()">
  </c:if>
  <c:if test="${flag }">
  	<input type="button" value="로그인" onclick="location.href='login.do'">
  </c:if>
  

<!-- *********************************************** -->
</div>
</body>
<!-- *********************************************** -->
 
</html> 