<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id ="dao" class="subscriber.SubscriberDAO"/>
<%
	String mname = request.getParameter("mname");
	String tel = request.getParameter("tel");
	
	Map map = new HashMap();
	
	map.put("mname", mname);
	map.put("tel", tel);
	
	String id = dao.idfind(map);
	
	
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
 
<DIV class="title">아이디 찾기 결과</DIV>
 <%if(id!=null){ %>
 
 <%=mname %>님의 아이디는 <%=id %> 입니다.
 <FORM name='frm' method='POST' action='./loginForm.jsp'>
 <input type="hidden" name="id" value="<%=id %>"/>
 <DIV class='bottom'>
    <input type='submit' value='로그인' >
    <input type='button' value='비밀번호찾기' onclick="location.href='passwdFind.jsp' ">
  </DIV>
  </FORM>
  <%}else{ %>
  <%=mname %>님의 아이디가 없습니다.
  <DIV class='bottom'>
    <input type='button' value='다시시도' onclick="history.back()">
    <input type='button' value='회원가입' onclick="location.href='agreement.jsp' ">
  </DIV>
  <%} %>

<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 