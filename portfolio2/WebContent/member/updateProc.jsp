<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="subscriber.SubscriberDAO"/>
<jsp:useBean id = "dto" class="subscriber.SubscriberDTO"/>
<%
String tempDir = "/member/temp";
String upDir = "/member/storage";

tempDir = application.getRealPath(tempDir);
upDir = application.getRealPath(upDir);

UploadSave upload = new UploadSave(request,-1,-1,tempDir);

Map map = new HashMap();

map.put("id", upload.getParameter("id"));
map.put("passwd",upload.getParameter("oldpasswd"));

boolean loginCheck = false;

loginCheck = dao.loginCheck(map);

dto.setId(upload.getParameter("id"));

dto.setPasswd(upload.getParameter("passwd"));

dto.setTel(upload.getParameter("tel"));

dto.setZipcode(upload.getParameter("zipcode"));

dto.setAddress1(UploadSave.encode(upload.getParameter("address1")));
dto.setAddress2(UploadSave.encode(upload.getParameter("address2")));

String oldfile = UploadSave.encode(upload.getParameter("oldfile"));


FileItem fileItem = upload.getFileItem("fname");
	int size= (int)fileItem.getSize();
	String fname= null;
	if(size>0){
		UploadSave.deleteFile(upDir, oldfile);
		fname=UploadSave.saveFile(fileItem, upDir);
	}else{
		fname="member.jpg";
	}
	dto.setFname(fname);
	dao.printd(dto);
	boolean flag= dao.update(dto);
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
 
<DIV class="title"></DIV>
 
 <%
 	if(loginCheck){
 
	 	if(flag){
	 		out.print("정보수정을 성공했습니다.");
	 		
	 	}else{
	 		out.print("정보수정을 실패했습니다.");
	 	}
 	}else{
 		out.print("비밀번호가 다릅니다");
 	}
 %>
 </div>
 <%
 if(loginCheck){
 if(flag){ %>
  <DIV class='bottom'>
    <input type='button' value='로그인' onclick="location.href='./loginForm.jsp' ">
    <input type='button' value='홈' onclick="location.href='../index.jsp' ">
  </DIV>
  <%}else{ %>
<DIV class='bottom'>
    <input type='button' value='다시시도' onclick="history.back()">
    <input type='button' value='홈' onclick="location.href='../index.jsp' ">
  </DIV>
  <%}
 	}else{%>
 		<DIV class='bottom' align="center">
 	    <input type='button' value='다시시도' onclick="history.back()">
 	    <input type='button' value='홈' onclick="location.href='../index.jsp' ">
 	  </DIV>
 	<%}
 %>
  

<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>

</body>
<!-- *********************************************** -->
 
</html> 