<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 

<jsp:useBean id="dao" class="subscriber.SubscriberDAO"/>


<%
	
	String id = request.getParameter("id");
	
	
	boolean flag = false;
	
	flag = dao.idcheck(id);
	
	
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
	out.print("id가 중복되었습니다.다시 만들어주세요.");
	
}else{
	out.print("id가 중복되지 않았습니다.");
}
%>

</body>
<!-- *********************************************** -->
 
</html> 