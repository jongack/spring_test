<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id = "dao" class="subscriber.SubscriberDAO"/>
<jsp:useBean id = "dto" class="subscriber.SubscriberDTO"/>
<%
	String tempDir = "/member/temp";
	String upDir = "/member/storage";
	
	tempDir = application.getRealPath(tempDir);
	upDir = application.getRealPath(upDir);
	
	UploadSave upload = new UploadSave(request,-1,-1,tempDir);
	
	
	
	dto.setId(upload.getParameter("id"));
	dto.setMname(UploadSave.encode(upload.getParameter("mname")));
	dto.setPasswd(upload.getParameter("passwd"));
	dto.setTel(upload.getParameter("tel"));
	dto.setEmail(upload.getParameter("email"));
	dto.setZipcode(upload.getParameter("zipcode"));
	dto.setAddress1(UploadSave.encode(upload.getParameter("address1")));
	dto.setAddress2(UploadSave.encode(upload.getParameter("address2")));
	dto.setMdate(upload.getParameter("mdate"));
	
	
	FileItem fileItem = upload.getFileItem("fname");
 	int size= (int)fileItem.getSize();
 	String fname= null;
 	if(size>0){
 		fname=UploadSave.saveFile(fileItem, upDir);
 	}else{
 		fname="member.jpg";
 	}
 	dto.setFname(fname);
 	
 	boolean flag= dao.create(dto);
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
 
<DIV class="title">회원 가입 처리</DIV>
<div class ="content">
 <%
 	if(flag){
 		out.print("회원가입을 성공했습니다.");
 		
 	}else{
 		out.print("회원가입을 실패했습니다.");
 	}
 %>
 </div>
 <%if(flag){ %>
  <DIV class='bottom'>
    <input type='button' value='로그인' onclick="location.href='./loginForm.jsp' ">
    <input type='button' value='홈' onclick="location.href='../index.jsp' ">
  </DIV>
  <%}else{ %>
<DIV class='bottom'>
    <input type='button' value='다시시도' onclick="history.back()">
    <input type='button' value='홈' onclick="location.href='../index.jsp' ">
  </DIV>
  <%} %>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 