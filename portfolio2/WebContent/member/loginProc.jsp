<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id = "dao" class="subscriber.SubscriberDAO"/>
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	Map map = new HashMap();
	map.put("id",id);
	map.put("passwd",passwd);
	
	boolean flag = false;
	
	flag = dao.loginCheck(map);
	
	if(flag){
		String grade = dao.getGrade(id);
		session.setAttribute("id",id);
		session.setAttribute("grade",grade);
		
		Cookie cookie =null;
		
		String c_id = request.getParameter("c_id");
		
		if(c_id!=null){
			cookie = new Cookie("c_id","Y");
			cookie.setMaxAge(120);
			response.addCookie(cookie);
			
			cookie = new Cookie("c_id_val",id);
			cookie.setMaxAge(120);
			response.addCookie(cookie);
		}else{
			cookie = new Cookie("c_id","");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
			
			cookie = new Cookie("c_id_val","");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
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
 
<DIV class="title">로그인 결과</DIV>
 
 <%if(flag){
	 out.print("로그인 성공");
 }else{
	 out.print("회원이 아니거나 아이디 혹은 비밀번호가 틀렸습니다.");
 }%>
 
  <DIV class='bottom'>
  <%if(flag){ %>
    <input type='button' value='홈' onclick="location.href='../index.jsp'"/>
    <input type='button' value='로그아웃' onclick="location.href='./logout.jsp'"/>
  <%}else{%>
    <input type='button' value='아이디/비밀번호찾기' onclick="location.href='idfind.jsp'">
    <input type='button' value='다시시도' onclick="history.back()">
   <%} %>
  </DIV>
  

<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 