<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="subscriber.SubscriberDAO"/>
<%
	//id값 받아서 dao.read()사용 
	String id = "";
	if(request.getParameter("id")!=""||request.getParameter("id")!=null){
	id = request.getParameter("id");
	}
	SubscriberDTO dto = dao.read(id);
	
	//전화번호 받아서 별표로 가려서 출력하기
	String tel = dto.getTel();
	int hyphensecond = tel.indexOf("-",4);//7
	int hyphenfirst = tel.indexOf("-");//3+2
	
	String tel1 = tel.substring(hyphenfirst+2,hyphensecond);//5부터7까지 56
	String star1=""; 
	
	for(int i=0; i<tel1.length();i++){
		star1 = star1+"*";
	}
	
	String tel2 = tel.substring(hyphensecond+2);//
	String star2=""; 
	
	for(int i=0; i<tel2.length();i++){
		star2 = star2+"*";
	}
	String telResult = tel.substring(0,(hyphenfirst+2))+star1+tel.substring(hyphensecond,hyphensecond+2)+star2;
	//이메일 받아서 별표처리 출력
	String email = dto.getEmail();
	
	int gol = email.indexOf("@");
	int point = email.indexOf(".");
	
	String twotogol = email.substring(2,gol);
	String goltodot = email.substring((gol+2),point);
	String star3 = "";
	String star4 ="";
	
	for(int i=0;i<twotogol.length();i++){
		star3 = star3+"*";
	}
	for(int i=0; i<goltodot.length();i++){
		star4 = star4+"*";
	}
	String emailResult = email.substring(0,2)+
								star3+
								email.substring(gol,gol+2)+
								star4+
								email.substring(point);
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
   
      $("table").hide();


$(":radio").change(function(){

	if($('input:radio[name=certi]').is(':checked')){
	
		
		$(this).parent().children("table").show();
		$(this).parent().next().children("table").hide();
		$("input[name=mname]").val("");
		$("input[name=id]").val("<%=id%>");
		$(this).parent().prev().children("table").hide();
		
	}
	
	
});
});

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
 
 <FORM name='frm' method='POST' action='./updateForm.jsp'>
  
  <div id="tel">
  <input type="radio" id="telRadio" name="certi">
  <label for="telRadio">
  회원정보에 등록한 휴대전화로 인증(
  <%=telResult %>)
  </label><br>
  <TABLE id="useTel">
    <TR>
      <TH>아이디</TH>
      <TD><input type="text" name="id" value="<%=id%>"></TD>
    </TR>
    <TR>
      <TH>이름</TH>
      <TD><input type="text" name="mname" ></TD>
    </TR>
     <TR>
      <TH>전화번호</TH>
      <TD><input type="text" name="tel" ></TD>
    </TR>   
  </TABLE>
  </div>
 
  <div id="email">
  <input type="radio" id="emailRadio" name="certi">
  <label for="emailRadio">
  회원정보에 등록한 휴대전화로 인증(
  <%=emailResult %>)
  </label>
  <TABLE id="useEmail">
    <TR>
      <TH>아이디</TH>
      <TD><input type="text" name="id" value="<%=id%>"></TD>
    </TR>
    <TR>
      <TH>이름</TH>
      <TD><input type="text" name="mname" ></TD>
    </TR>
     <TR>
      <TH>이메일</TH>
      <TD><input type="text" name="email" ></TD>
    </TR>   
  </TABLE>
  </div>
  <DIV class='bottom'>
    <input type='submit' value='찾기' >
    <input type='button' value='취소' onclick="history.back() ">
  </DIV>
  <div id="panel"></div>
</FORM>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 