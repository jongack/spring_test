<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: ; 
  font-size: 24px; 
} 
</style> 

<script type="text/javascript">
	function inputCheck(f){
		if(f.passwd.value==""){
			alert("비밀번호를 입력해주세요");
			f.passwd.focus();
			return false;
		}
		if(f.repasswd.value==""){
			alert("비밀번호확인을 입력해주세요");
			f.repasswd.focus();
			return false;
		}
		
		if(f.passwd.value!=f.repasswd.value){
			alert("비밀번호를 같게 입력해주세요");
			f.repasswd.focus();
			return false;
		}
		if(f.oldPasswd.value==f.passwd.value){
			alert("기존 비밀번호와 새로운비밀번호가 같습니다 새로입력해주세요");
			f.passwd.focus();
			return false;
		}
	}
</script>
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 <div class="container">
<h2>비밀번호수정</h2>
 
 <FORM name='frm' method='POST' action='./updatePw' onsubmit="return inputCheck(this)">
 <input type ="hidden" name="id"	value="${param.id }">
 
 
  <TABLE>
    <TR>
      <TH>현재비밀번호</TH>
      <TD><input type="password" name="oldPasswd" value="${param.passwd }"></TD>
    </TR>          
    <TR>
      <TH>새로운 비밀번호</TH>
      <TD><input type="password" name="passwd" size="15"></TD>
    </TR>
    <TR>
      <TH>새로운 비밀번호 확인</TH>
      <TD><input type="password" name="repasswd" size="15"></TD>
    </TR>
    
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='등록'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
<!-- *********************************************** -->
</div>
</body>
<!-- *********************************************** -->
 
</html> 