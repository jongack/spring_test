<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="qna.QnaDAO"/>
<%
	int qnano=Integer.parseInt(request.getParameter("qnano"));
	String passwd = request.getParameter("passwd");
	String oldfile = request.getParameter("oldfile");
	
	Map map = new HashMap();
	map.put("qnano", qnano);
	map.put("passwd",passwd);
	
	boolean pflag = dao.passCheck(map);
	boolean flag = false;
	
	if(pflag){
		
		flag = dao.delete(qnano);
	}
	String upDir = application.getRealPath("/qna/storage");
	if(flag){
		
			UploadSave.deleteFile(upDir, oldfile);
		
	}
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
	function blist(){
		var url="list.jsp";
		url =url+"?col=<%=request.getParameter("col")%>";
		url =url+"&word=<%=request.getParameter("word")%>";
		url =url+"&nowPage=<%=request.getParameter("nowPage")%>";
		
		
		
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
 
 <div class="content">
 <%
 	if(pflag==false){
 		out.print("패스워드가 일치하지 않습니다.");
 	}else if(flag){
 		out.print("글을 삭제했습니다.");
 		
 	}else{
 		out.print("글 삭제를 실패했습니다.");
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