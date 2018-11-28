<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="subscriber.SubscriberDAO"/>
<jsp:useBean id="dto" class="subscriber.SubscriberDTO"/>
<%
	String id = request.getParameter("id");
	dto = dao.read(id);
	
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
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<script type="text/javascript">
var id = "<%=id%>";
$.ajaxSetup({
    error: function(jqXHR, exception) {
        if (jqXHR.status === 0) {
            alert('Not connect.\n Verify Network.');
        }
        else if (jqXHR.status == 400) {
            alert('Server understood the request, but request content was invalid. [400]');
        }
        else if (jqXHR.status == 401) {
            alert('Unauthorized access. [401]');
        }
        else if (jqXHR.status == 403) {
            alert('Forbidden resource can not be accessed. [403]');
        }
        else if (jqXHR.status == 404) {
            alert('Requested page not found. [404]');
        }
        else if (jqXHR.status == 500) {
            alert('Internal server error. [500]');
        }
        else if (jqXHR.status == 503) {
            alert('Service unavailable. [503]');
        }
        else if (exception === 'parsererror') {
            alert('Requested JSON parse failed. [Failed]');
        }
        else if (exception === 'timeout') {
            alert('Time out error. [Timeout]');
        }
        else if (exception === 'abort') {
            alert('Ajax request aborted. [Aborted]');
        }
        else {
            alert('Uncaught Error.n' + jqXHR.responseText);
        }
    }
});
 


$(document).ready(function(){
$("#deletebtn").click(function(){
	$.getJSON(
		"deleteForm.jsp",
		{
			"id":id
		},
		function(data,textStatus){
			
			alert(textStatus);
		
			alert(data.rs);
			if(data.code =="success"){
				
				location.href="logout.jsp";
			}else{
				alert(data.str);
			}
			
		}
	);
});

});	
</script>
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
 
 
<table >
    <TR>
      <TH>이미지</TH>
      <TD><img src="./storage/<%=dto.getFname() %>" width="100px" height="100px"></TD>
    </TR>
    <TR>
      <TH>아이디</TH>
      <TD><%=dto.getId() %></TD>
    </TR>
    <TR>
      <TH>이름</TH>
      <TD><%=dto.getMname() %></TD>
    </TR>
    <TR>
      <TH>이메일</TH>
      <TD><%=dto.getEmail() %></TD>
    </TR>
    <TR>
      <TH>전화번호</TH>
      <TD><%=dto.getTel() %></TD>
    </TR>
    <TR>
      <TH>우편번호</TH>
      <TD><%=dto.getZipcode() %></TD>
    </TR>
    <TR>
      <TH>주소</TH>
      <TD><%=dto.getAddress1() %></TD>
    </TR>
    <TR>
      <TH>상세주소</TH>
      <TD><%=dto.getAddress2() %></TD>
    </TR>
    <TR>
      <TH>가입일</TH>
      <TD><%=dto.getMdate() %></TD>
    </TR>
    <TR>
      <TH>파일이름</TH>
      <TD><%=dto.getFname() %></TD>
    </TR>
    <TR>
      <TH>회원등급</TH>
      <TD><%=dto.getGrade() %></TD>
    </TR>
  </table><br>
  
  <DIV class='bottom'>
    <input type='button' value='정보수정' onclick="goupdate('<%=id%>')">
    <input type='button' id="deletebtn" value='삭제' >
  </DIV>
  

<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 