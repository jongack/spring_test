<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript" src="./httpRequest.js"></script>
<script type="text/javascript">
var checkFirst = false;
var lastKeyword ="";
var loopSendKeyword = false;

function startSuggest(){
	if(checkFirst == false){
		setTimeout("sendKeyword()",500);
		loopSendKeyword=true;
	}
	checkFirst = true;
}
//요청 전송

function sendKeyword(){
	if(loopSendKeyword==false) return;
	
	var keyword = document.search.keyword.value;
	
	if(keyword==""){
		lastKeyword="";
		hide("suggest");
		
	}else if(keyword!=lastKeyword){//새로운 키워드가 입력되었다면
		lastKeyword = keyword; //새로운 키워드를 전역변수로 저장
		
		var params = "keyword="+encodeURIComponent(keyword);
		
		sendRequest("<%=root%>/suggest",params,response,"post");
		
	}
	setTimeout("sendKeyword();",500);
}
//결과 출력
function response(){
	if(httpRequest.readyState==4){
		if(httpRequest.status==200){
			var resultText = httpRequest.responseText;
			
			var result = resultText.split('|'); //배열로 나눠줌
			
			var count = parseInt(result[0]); //문자열을 정수로 변환
			
			var keywordList = null;
			
			if(count>0){
				keywordList = result[1].split(','); //배열을 문자열로 나눔
				
				var html="";
				html = html+"등록된 쿼리목록(선택하세요)<br>";
				
				for(var i=0; i<keywordList.length;i++){
					html = html+"<a href=\"javascript:select('"+keywordList[i]+"'')\">"+keywordList[i]
					+"</a><br>";
				}
				var listView = document.getElementById("suggestList");
				
				listView.innerHTML = html;
				
				show("suggest");
			}else{
				hide("suggest");
			}
		}else{
			alert("에러발생"+httpRequest.status);
		}
	}
}
function select(selectedKeyword){
	document.search.keyword.value = selectedKeyword;
	
	loopSendKeyword = false;
	checkFirst = false;
	
	hide("suggest");
}
function frmSend(f){
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
#debugConsole{
border: 1px solid #000000; 
color: #00ff00; 
background: #000000
}
 
#suggest{
display: block;  
postion: static;  
left: 0px; 
top: 30px; 
color: #000000; 
background: #EAEAEA; 
width: 500px"
}
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
 
<div id="debugConsole"></div>
 
<form name="search" action="./suggest_proc.jsp" method="post">
<input type="text" name="keyword" id="keyword"
onkeydown="startSuggest()" size="70" /> 
<input type="button"
value="검색" onclick="frmSend(this.form)" />
 
<!-- 서버로부터 검색된 목록 출력 -->
<div id="suggest">
<div id="suggestList"></div>
</div>
 
</form>
</body>
</html>
  
</FORM>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 