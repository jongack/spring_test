<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %>
<%
	
	
	
	String col = "pdname/pdcategory/pdbrand";
	String keyword = request.getParameter("keyword");
	String id = (String)session.getAttribute("id");
	
	SearchDTO dto = new SearchDTO();
	SearchDAO dao = new SearchDAO();
	ProductDAO pdao = new ProductDAO();
	
	if(id != null){
	dto.setId(id);
	}else{
		dto.setId("logout");
	}
	dto.setKeyword(keyword);
	
	boolean flag = dao.createHotissue(dto);
	
	
	
	
	
%> 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript" src="../ajax/httpRequest.js"></script>
<script type="text/javascript">
window.onload = function(){
	var f = document.indexfrm
	send(f);
} 
function ecd(field){
	return encodeURIComponent(field.value);
}

function send(f){
	var by ="pdnum";
	var order ="desc";
	var recordPerPage =6;
	 
		
		
	var params ="order="+order;
	params = params + "&by="+by;
	params = params + "&recordPerPage="+recordPerPage;
	params = params + "&col=<%=col%>";
	params = params + "&word=<%=keyword%>";
	
	var panel = document.getElementById("productPanel");
	panel.innerHTML="";
	
	sendRequest("../product/list.jsp", params, response, "post");
}

function response(){
	if(httpRequest.readyState==4){
		if(httpRequest.status==200){
			var panel = document.getElementById("productPanel");
			
			panel.innerHTML=httpRequest.responseText;
		}
	}
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

 <FORM name='frm' method='POST' action='./.do'>
<div id="productPanel">

</div>
  <DIV class='bottom'>
    <input type='submit' value='등록'>
    <input type='button' value='취소' onclick="location.href='' ">
  </DIV>
  
</FORM>



<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 