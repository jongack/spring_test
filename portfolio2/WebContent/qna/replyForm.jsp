<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="qna.QnaDAO"/>
<%
	int qnano = Integer.parseInt(request.getParameter("qnano"));
	QnaDTO dto = dao.replyRead(qnano);

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
<script type="text/javascript">
	function incheck(f){
		if(f.wname.value==""){
			alert("이름을 입력하세요");
			f.wname.focus();
			return false;
		}
		if(f.title.value==""){
			alert("제목을 입력하세요");
			f.title.focus();
			return false;
		}
		if(f.content.value==""){
			alert("내용을 입력하세요");
			f.content.focus();
			return false;
		}
		if(f.passwd.value==""){
			alert("비번을 입력하세요");
			f.passwd.focus();
			return false;
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
 
<DIV class="title">답변	</DIV>

<form name='frm' method = 'post' action='./replyProc.jsp' enctype="multipart/form-data">
	
<!-- 답변있는 부모글의 삭제를 못하게 하기위해서 qnano가져간다 -->
<input type="hidden" name="qnano" value ="<%=dto.getQnano()%>"/>
<!-- 답변에 필요한 부모의 자료들 -->
<input type="hidden" name="grpno" value="<%=dto.getGrpno() %>"/>
<input type="hidden" name="indent" value="<%=dto.getIndent()%>"/>
<input type="hidden" name="ansnum" value="<%=dto.getAnsnum() %>" />

	<table>
		<tr>
			<th>성명</th>
			<td><input type ="text"	name="wname"></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type ="text"	name="title" value="<%=dto.getTitle() %>"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="10" cols="45"	name="content"></textarea></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type ="password"	name="passwd" value=<%=request.getParameter("passwd") %>></td>
		</tr>
		<tr>
			<th>파일</th>
			<td><input type ="file"	name="filename"></td>
		</tr>
	
	</table> 
	
	<div class='bottom'>
		<input type='button' value='등록' onclick="incheck(this.form)">
		<input type='button'	value='취소'	 onclick="history.back()">
		
		</div>
		</form>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 