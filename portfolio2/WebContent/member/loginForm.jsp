<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<%
	

	String c_id ="";
	String c_id_val =request.getParameter("id");
	
	Cookie[]	 cookies = request.getCookies();
	Cookie cookie = null;
	
	if(cookies != null){
		for(int i=0;i<cookies.length;i++){
			cookie = cookies[i];
			
			if(cookie.getName().equals("c_id")){
				c_id=cookie.getValue();
			}else if(cookie.getName().equals("c_id_val")){
				c_id_val=cookie.getValue();
			}
		}
	}
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.w3-sidebar a {font-family: "Roboto", sans-serif}
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}
</style>
<body class="w3-content" style="max-width:1200px">
<jsp:include page="/menu/menu.jsp" flush="false"/>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:250px">

 <!-- Push down content on small screens -->
  <div class="w3-hide-large" style="margin-top:83px"></div>

<!-- top header -->
<jsp:include page="/menu/top.jsp" flush="false"/>


<!-- *********************************************** -->
 
<DIV class="title">로그인</DIV>
 
 <FORM name='frm' method='POST' action='./loginProc.jsp'>
  <TABLE border='1'>
    <TR>
      <TH>아이디</TH>
      <TD>
      <%if(c_id_val != null){ %>
      <input type="text" name="id" value="<%=c_id_val %>">
      <%}else { %>
      <input type="text" name="id" >
      <%}
      if(c_id.equals("Y")){
    	%>
    	<input type="checkbox" name="c_id" value="Y"	checked="checked" >Id 저장
    <%
      }else{
      %>
      	<input type="checkbox" name="c_id" value="Y">Id 저장
      <%} %>
      </TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
    
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='로그인'>
    <input type='button' value='회원가입' onclick="location.href='agreement.jsp'">
  </DIV>
  
</FORM>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 