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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
 
                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;
 
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }
 
                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;
 
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script>
<script type="text/javascript" src="./httpRequest.js"></script>
<script type="text/javascript">
	function send(f){
		var params = "id="+f.id.value;
		var panel = document.getElementById("idc");
		panel.innerHTML="";
		
		sendRequest("idcheck.jsp", params,response,"post");
	}
	function response(){
		if(httpRequest.readyState==4){
			if(httpRequest.status==200){
				var panel = document.getElementById("idc");
				
				panel.innerHTML=httpRequest.responseText;
			}else{
				alert(httpRequest.status);
			}
		}	
	}
	function send2(f){
		var params = "email="+f.email.value;
		var panel = document.getElementById("emailc");
		panel.innerHTML="";
		
		sendRequest("emailcheck.jsp", params,response2,"post");
	}
	function response2(){
		if(httpRequest.readyState==4){
			if(httpRequest.status==200){
				var panel = document.getElementById("emailc");
				
				panel.innerHTML=httpRequest.responseText;
			}else{
				alert(httpRequest.status);
			}
		}	
	}

</script>
<script type="text/javascript">

	function check(f){
		if(f.id.value==""||f.id.value==null){
			alert("아이디를 입력해주세요");
			f.id.focus();
			
		}else if(f.passwd.value==""||f.passwd.value==null){
			alert("비밀번호를 입력해주세요");
			f.passwd.focus();
		}else 	if(f.mname.value==""||f.mname.value==null){
			alert("이름을 입력해주세요");
			f.mname.focus();
		}else 	if(f.tel.value==""||f.tel.value==null){
			alert("전화번호를 입력해주세요");
			f.tel.focus();
		}else 	if(f.email.value==""||f.email.value==null){
			alert("이메일을 입력해주세요");
			f.email.focus();
		}else{
			f.submit();
		}
		
	}
	
</script>
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
 
<DIV class="title">회원가입</DIV>
 
 <FORM name='frm' method='POST' action='./createProc.jsp' 
	enctype="multipart/form-data">
  <TABLE>
    <TR>
      <TH>회원사진</TH>
      <TD><input type="file" name="fname" accept=".jpg,.png,.gif"></TD>
    </TR>
    <TR>
      <TH>아이디*</TH>
      
      <TD><input type="text" name="id"> 
      <input type="button" value="중복확인" onclick="send(this.form)"/>
      <div id="idc"></div>
      </TD>
      
    </TR>
    <TR>
      <TH>비밀번호*</TH>
      
      <TD><input type="password" name="passwd"> 
           
      </TD>
      
    </TR>
    <TR>
      <TH>이름*</TH>
      <TD><input type="text" name="mname"></TD>
    </TR>
    <TR>
      <TH>전화번호*</TH>
      <TD><input type="text" name="tel"></TD>
    </TR>
    <TR>
      <TH>이메일*</TH>
      <TD><input type="text" name="email">
      <input type="button" value="중복확인"  onclick="send2(this.form)"/>
      <div id="emailc"></div></TD>
    </TR>
    <TR>
      <TH>우편번호</TH>
      <TD><input type="text" name="zipcode" 
      			id="sample6_postcode" placeholder="우편번호">
      			<input type="button" value="우편번호찾기"
      			onclick ="sample6_execDaumPostcode()"></TD>
    </TR>
    <TR>
      <TH>주소</TH>
      <TD><input type="text" name="adress1" id='sample6_address'></TD>
    </TR>
    <TR>
      <TH>상세주소</TH>
      <TD><input type="text" name="address2" id='sample6_address2'></TD>
    </TR>
    
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='등록' onclick="check(this.form)">
    <input type='reset' value='취소' >
  </DIV>
  
</FORM>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 