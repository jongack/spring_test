<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
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

<FORM name='frm'  method='POST'  action='./createProc.jsp' enctype="multipart/form-data"
 onsubmit="return inputCheck(this)">
  <TABLE>
    <TR>
      <TH>상품명</TH>
      <TD><input type="text" name="pdname"></TD>
    </TR>
    <TR>
      <TH>카테고리</TH>
      <TD>
      	<select name="pdcategory">
      		<option value="jacket">자켓</option>
      		<option value="pants">바지</option>
      		<option value="skirts">치마</option>
      		<option value="shirts">셔츠</option>
      		<option value="shoes">신발</option>
      	</select>
      </TD>
    </TR>
    <TR>
      <TH>주소</TH>
      <TD><input type="text" name="pdurl"></TD>
    </TR>
    <TR>
      <TH>상품이미지(jpg,png,gif)</TH>
      <TD><input type="file" name="pdimg" accept=".jpg,.png,.gif"></TD>
    </TR>
    <TR>
      <TH>가격</TH>
      <TD><input type="text" name="pdprice"></TD>
    </TR>
    <TR>
      <TH>브랜드</TH>
      <TD><input type="text" name="pdbrand"></TD>
    </TR>
    <TR>
      <TH>색상</TH>
      <TD>
	    	<select name="pdcolor">
      		<option value="black">검은색</option>
      		<option value="white">하얀색</option>
      		<option value="blue">파란색</option>
      		<option value="red">빨간색</option>
      		<option value="green">초록색</option>
      	</select>
	</TD>
    </TR>
    
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='등록'>
    
  </DIV>
  
</FORM>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 