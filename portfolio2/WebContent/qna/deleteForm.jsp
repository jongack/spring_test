<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="qna.QnaDAO"/>
<%
	int qnano = Integer.parseInt(request.getParameter("qnano"));
	boolean flag = dao.checkRefnum(qnano);

%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
	function incheck(f){
		if(f.passwd.value==""){
			alert("비밀번호를 입력하세요");
			f.passwd.focus();
			return false;
		}
		
		
	}
	function blist(){
		var url = "list.jsp"
		location.href= url;
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
 
<%if(flag){%>
<DIV class="title">삭제 </DIV>

 <div class ="content"> 답변글이 존재합니다.부모글을 삭제할 수 없습니다.</div>
 <FORM method='POST' name='frm' action='./deleteProc.jsp'
 				onsubmit="return incheck(this)">
 <input type="hidden" name="bbsno" value="<%=qnano%>"/>
 <input type="hidden" name="col" value="<%=request.getParameter("col")%>"/>
 <input type="hidden" name="word" value="<%=request.getParameter("word")%>"/>
 <input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>"/>
  <DIV class='bottom'>
    <input type='submit' value='삭제'>
    <input type='button' value='목록' onclick="blist()">
  </DIV> 		
 	</FORM>	
 <%}else{%>
 
 
<DIV class="title">삭제 </DIV>

 <div class ="content"> 삭제하면 복구할 수 없습니다.</div>
 <FORM method='POST' name='frm' action='./deleteProc.jsp'
 				onsubmit="return incheck(this)">
 <input type="hidden" name="bbsno" value="<%=qnano%>"/>
 <input type="hidden" name="col" value="<%=request.getParameter("col")%>"/>
 <input type="hidden" name="word" value="<%=request.getParameter("word")%>"/>
 <input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>"/>
 <input type="hidden" name="oldfile" value="<%=request.getParameter("oldfile")%>"/>
  <TABLE>
    <TR>
      <TH>비밀번호 입력</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
    
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='삭제'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
<%}%>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 