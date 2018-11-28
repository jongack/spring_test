<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>

<%
	
 
	boolean flag = (Boolean)request.getAttribute("flag");


 	if(flag){
 		out.print("중복되어서 사용할 수 없습니다.");
 	}else{
 		out.print("중복아님,사용 가능합니다.");
 		
 	}
 %>
 