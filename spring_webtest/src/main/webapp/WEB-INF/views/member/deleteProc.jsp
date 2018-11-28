<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 


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
 
 <div class="container">
<h2>회원 탈퇴 처리</h2>
 <c:choose>
 	<c:when test="${flag}">
 		탈퇴되었습니다 자동 로그아웃 됩니다.<br>
 	</c:when>
 	<c:otherwise>
 		탈퇴 실패<br>
 	</c:otherwise>
 </c:choose>
 

 
 
 
 
  <DIV class='bottom'>
    <input type='button' value='홈' onclick="location.href='../index.jsp' ">
    <input type='button' value='다시시도' onclick="history.back()">
  </DIV>

<!-- *********************************************** -->
</div>
</body>
<!-- *********************************************** -->
 
</html> 