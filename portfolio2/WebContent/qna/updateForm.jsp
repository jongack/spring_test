<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="qna.QnaDAO"/>
<%
	int qnano= Integer.parseInt(request.getParameter("qnano"));

	QnaDTO dto = dao.read(qnano);
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
 <script type="text/JavaScript">
   window.onload=function(){
     CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  };
 </script>
<style type="text/css"> 
*{ 
  font-family: ; 
  font-size: 24px; 
} 
</style> 
<script type="text/javascript">
	function incheck(f){
		if(f.wname.value==""){
			alert("이름을 입력하세요");
			f.wname.focus();
			return ;
		}
		if(f.title.value==""){
			alert("제목을 입력하세요");
			f.title.focus();
			return;
		}
		if(f.content.value==""){
			alert("내용을 입력하세요");
			f.content.focus();
			return;
		}
		if(f.passwd.value==""){
			alert("비번을 입력하세요");
			f.passwd.focus();
			return;
		}
		f.submit();
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
 
<DIV class="title">등록	</DIV>

<form name='frm' method = 'post' action='./updateProc.jsp'
	enctype="multipart/form-data">
<input type="hidden" name="qnano"	 value="<%=dto.getQnano() %>"/>
<input type="hidden" name="col"	 value="<%=request.getParameter("col") %>"/>
<input type="hidden" name="word"	 value="<%=request.getParameter("word") %>"/>
<input type="hidden" name="nowPage"	 value="<%=request.getParameter("nowPage") %>"/>
<input type="hidden" name="oldfile"	 value="<%=dto.getFilename() %>"/>

	<table>
		<tr>
			<th>성명</th>
			<td><input type ="text"	name="wname" value="<%=dto.getWname() %>"></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type ="text"	name="title" value="<%=dto.getTitle()%>"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="10" cols="45"	name="content" ><%=dto.getContent() %></textarea></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type ="password"	name="passwd" ></td>
		</tr>
		<tr>
			<th>파일</th>
			<td><input type ="file"	name="filename" ></td>
		</tr>
	
	</table> 
	
	<div class='bottom'>
		<button type='button' value='수정' onclick="incheck(this.form)">수정</button>
		<input type='button'	value='취소'	 onclick="history.back()">
		
		</div>
		</form>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 