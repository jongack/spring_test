<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id ="dao" class ="qna.QnaDAO"/>
<jsp:useBean id="dto" class="qna.QnaDTO"/>
<%
	String tempDir = application.getRealPath("/qna/temp");
	String upDir = application.getRealPath("/qna/storage");
	
	UploadSave upload = new UploadSave(request, -1, -1, tempDir);
	
	dto.setWname(UploadSave.encode(upload.getParameter("wname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(upload.getParameter("passwd"));
	
	FileItem fileItem = upload.getFileItem("filename");
	
	long filesize = fileItem.getSize();
	
	String filename = null;
	
	if(filesize>0){
		filename=UploadSave.saveFile(fileItem, upDir);
	}
	
	dto.setFilename(filename);
	dto.setFilesize(filesize);
	
	boolean flag = dao.create(dto);


%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
	function blist(){
		var url="list.jsp";
		
		location.href=url;
	}
</script>
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
 
<div class="content">
 	<%if(flag){
 		out.print("글이 등록되었습니다");
 	}else{
 		out.print("글 등록이 실패했습니다");
 	}
 		%>
</div>
 		
<DIV class='bottom'>
    <input type='button' value='목록' onclick="blist()">
    <input type='button' value='계속등록' onclick="location.href='createForm.jsp'">
 </DIV>
 		
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 