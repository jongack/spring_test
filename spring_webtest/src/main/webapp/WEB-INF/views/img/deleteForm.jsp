<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%
int no =  Integer.parseInt(request.getParameter("no"));
String col = request.getParameter("col");
String word = request.getParameter("word");
String nowPage = request.getParameter("nowPage");

%>
 
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
</style> 
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->

<h2>삭제</h2>
 
<FORM name='frm' method='POST' action='./delete'>
<input type="hidden" name="no"  value="<%=no%>">
<input type="hidden" name="word"  value="<%=word%>">
<input type="hidden" name="col"  value="<%=col%>">
<input type="hidden" name="nowPage"  value="<%=nowPage%>">


<div class = "container">
정말 삭제 하시겠습니까?

  
  	<input type='password' name="passwd" >
    <input type='submit' value='삭제' >
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
</html> 