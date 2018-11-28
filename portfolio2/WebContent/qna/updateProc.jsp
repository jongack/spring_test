<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id="dto" class="qna.QnaDTO"/>
<jsp:useBean id="dao" class="qna.QnaDAO"/>


<%
	String tempDir = application.getRealPath("/qna/temp");
	String upDir = application.getRealPath("/qna/storage");
	
	UploadSave upload = new UploadSave(request,-1,-1,tempDir);
	//form값 받기
	dto.setWname(UploadSave.encode(upload.getParameter("wname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	
	//히든값받기
	dto.setQnano(Integer.parseInt(upload.getParameter("qnano")));
	String col = upload.getParameter("col");
	String word = UploadSave.encode(upload.getParameter("word"));
	String nowPage = upload.getParameter("nowPage");
	String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
	
	//업로드파일받기
	
	
	Map map = new HashMap();
	map.put("qnano",dto.getQnano());
	map.put("passwd",dto.getPasswd());
	
	boolean pflag= dao.passCheck(map);
	boolean flag = false;
	if(pflag){
		FileItem fileItem = upload.getFileItem("filename");
		long filesize= fileItem.getSize();
		String filename = null;
		if(filesize>0){
			if(oldfile!=null){
				UploadSave.deleteFile(upDir, oldfile);
			}
			filename = UploadSave.saveFile(fileItem, upDir);
		}
		dto.setFilename(filename);
		dto.setFilesize(filesize);
		flag = dao.update(dto);
		
	}
	
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
	function blist(){
		var url="list.jsp"
		url=url+"?col=<%=col%>";
		url=url+"&word=<%=word%>";
		url=url+"&nowPage=<%=nowPage%>";
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
 
<DIV class="title">처리결과</DIV>
 <div class="contente">
 	<%
 		if(pflag==false){
 			out.print("패스워드가 일치하지 않습니다.");
 		}else if(flag){
 			out.print("수정완료");
 		}else{
 			out.print("글변경을 실패했습니다.");
 		}
 		 	
 	
 	
 	%>
 
 
 </div>
 
  
  <DIV class='bottom'>
    <input type='button' value='다시시도' onclick="history.back()">
    <input type='button' value='목록' onclick="blist()">
  </DIV>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 