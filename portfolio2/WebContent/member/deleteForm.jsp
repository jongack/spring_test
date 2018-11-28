<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="subscriber.SubscriberDAO"/>
<%

String id= request.getParameter("id");


boolean flag = true;

flag = dao.delete(id);
String str ="";
String code = "";
 	if(flag){
 		
 		str="아이디 삭제를 성공했습니다";
 		code="success";
 			
 	}else{
 		str="아이디 삭제를 실패했습니다.";
 		code = "fail";
 	
 	}
 %>
  { "code":"<%=code %>", "rs":"<%=str %>"}