<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.js"></script> 
<script type="text/javascript" src="./ajax/httpRequest.js"></script>
<script type="text/javascript">
$(document).ready(function() {
 var f = document.indexfrm;
	  send(f);
	}); 
/*  window.onload = function(){
	var f = document.indexfrm;
	send(f);
}  */
function ecd(field){
	return encodeURIComponent(field.value);
}

function send(f){
	var b ="";
	var o ="";

	if(f.order.value=="pdprice/asc"){
		o="asc";
		b="pdprice";
	}else if(f.order.value=="pdprice/desc"){
		o="desc";
		b="pdprice";
	}else if(f.order.value=="pdnum"){
		o="desc";
		b="pdnum";
			
	}
	var params ="order="+o;
	params = params + "&by="+b;
	params = params + "&recordPerPage="+f.recordPerPage.value;
	
	var panel = document.getElementById("productPanel");
	panel.innerHTML="";
	
	sendRequest("./product/list.jsp", params, response, "post");
}
function send2(col, word, nowPage){
	var b ="";
	var o ="";
	//var form = document.indexfrm
	if(document.indexfrm.order.value=="pdprice/asc"){
		o="asc";
		b="pdprice";
	}else if(document.indexfrm.order.value=="pdprice/desc"){
		o="desc";
		b="pdprice";
	}else if(document.indexfrm.order.value=="pdnum"){
		o="desc";
		b="pdnum";
			
	}
	var params ="order="+o;
	params = params + "&by="+b;
	params = params + "&col="+col;
	params = params + "&word="+word;
	params = params + "&nowPage="+nowPage;
	
	params = params + "&recordPerPage="+document.indexfrm.recordPerPage.value;
	
	var panel = document.getElementById("productPanel");
	panel.innerHTML="";
	
	sendRequest("./product/list.jsp", params, response, "post");
}
function response(){
	if(httpRequest.readyState==4){
		if(httpRequest.status==200){
			var panel = document.getElementById("productPanel");
			var str = httpRequest.responseText;
			if(str.indexOf("search")==-1){
			panel.innerHTML=httpRequest.responseText;
			 sendProductRank();
			}
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

<!-- Image header -->
  <div class="w3-display-container w3-container">
    <img src="./images/jeans.jpg" alt="Jeans" style="width:100%">
    <div class="w3-display-topleft w3-text-white" style="padding:24px 48px">
      <h1 class="w3-jumbo w3-hide-small">New arrivals</h1>
      <h1 class="w3-hide-large w3-hide-medium">New arrivals</h1>
      <h1 class="w3-hide-small">COLLECTION 2016</h1>
      <p><a href="#jeans" class="w3-button w3-black w3-padding-large w3-large">SHOP NOW</a></p>
    </div>
  </div>

  <div class="w3-container w3-text-grey" id="jeans">
    <p>8 items</p>
  </div>

  <!-- Product grid -->
  
   
 <FORM name='indexfrm' method='POST' action=''>
<select name="order">
	
	<option value="pdnum">최신 순</option>
	<option value="pdprice/asc">가격 낮은순</option>
	<option value="pdprice/desc">가격 높은순</option>
	
	
</select>
<select name="recordPerPage">
	<option  value="6" >6개씩보기</option>
	<option value="15">15개씩보기</option>
</select>
  
  
    <input type='button' value='검색' onclick="send(this.form)">
    
  <div class="w3-container" id="productPanel"></div>
</FORM>
  
  <!-- <div class="w3-row w3-grayscale">
    <div class="w3-col l3 s6">
      <div class="w3-container">
        <img src="/images/jeans.jpg" style="width:100%">
        <p>Ripped Skinny Jeans<br><b>$24.99</b></p>
      </div>
      <div class="w3-container">
        <img src="/w3images/jeans2.jpg" style="width:100%">
        <p>Mega Ripped Jeans<br><b>$19.99</b></p>
      </div>
    </div>

    <div class="w3-col l3 s6">
      <div class="w3-container">
        <div class="w3-display-container">
          <img src="/w3images/jeans2.jpg" style="width:100%">
          <span class="w3-tag w3-display-topleft">New</span>
          <div class="w3-display-middle w3-display-hover">
            <button class="w3-button w3-black">Buy now <i class="fa fa-shopping-cart"></i></button>
          </div>
        </div>
        <p>Mega Ripped Jeans<br><b>$19.99</b></p>
      </div>
      <div class="w3-container">
        <img src="/w3images/jeans3.jpg" style="width:100%">
        <p>Washed Skinny Jeans<br><b>$20.50</b></p>
      </div>
    </div>

    <div class="w3-col l3 s6">
      <div class="w3-container">
        <img src="/w3images/jeans3.jpg" style="width:100%">
        <p>Washed Skinny Jeans<br><b>$20.50</b></p>
      </div>
      <div class="w3-container">
        <div class="w3-display-container">
          <img src="/w3images/jeans4.jpg" style="width:100%">
          <span class="w3-tag w3-display-topleft">Sale</span>
          <div class="w3-display-middle w3-display-hover">
            <button class="w3-button w3-black">Buy now <i class="fa fa-shopping-cart"></i></button>
          </div>
        </div>
        <p>Vintage Skinny Jeans<br><b class="w3-text-red">$14.99</b></p>
      </div>
    </div>

    <div class="w3-col l3 s6">
      <div class="w3-container">
        <img src="/w3images/jeans4.jpg" style="width:100%">
        <p>Vintage Skinny Jeans<br><b>$14.99</b></p>
      </div>
      <div class="w3-container">
        <img src="/w3images/jeans1.jpg" style="width:100%">
        <p>Ripped Skinny Jeans<br><b>$24.99</b></p>
      </div>
    </div>
  </div> -->



<!-- *********************************************** -->

<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 
