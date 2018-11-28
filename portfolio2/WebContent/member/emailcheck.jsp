<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 

<jsp:useBean id="dao" class="subscriber.SubscriberDAO"/>


<%
	
	String email = request.getParameter("email");
	
	
	boolean flag = false;
	
	flag = dao.emailcheck(email);
	
	 
%>

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


</head> 
<!-- *********************************************** -->
<body>
<%
if(flag){
	out.print("email이 중복되었습니다.다시 만들어주세요.");
	
}else{
	out.print("email이 중복되지 않았습니다.");
}
%>

</body>
<!-- *********************************************** -->
 
</html> 