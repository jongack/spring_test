<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<script type="text/javascript">
function inputCheck(f){
	
	if(f.name.value==""){
		alert("이름을 입력해 주세요");
		f.name.focus();
		return false;
	}	
	
	if(f.title.value==""){
	alert("제목을 입력해 주세요");
	f.title.focus();
	return false;
	}
	
	if(f.passwd.value==""){
	alert("비밀번호를 입력해 주세요");
	f.passwd.focus();
	return false;
	}
	if(f.fname.value==""){
	alert("사진을 등록해 주세요");
	f.fname.focus();
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
 
 <h2><span class="glyphicon glyphicon-pencil"></span>사진등록</h2>


 
<FORM name='frm'  method='POST'  action='./create' enctype="multipart/form-data"
 onsubmit="return inputCheck(this)">
  <TABLE>
  	<TR>
      <TH>이름</TH>
      <TD><input type="text" name="name" size="15"></TD>
      <td>이름 적어주세요.</td>
    </TR>
    
  	<TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" size="15">
      <td>제목 적어주세요.</td>
     
    
  
    <TR>
      <TH>패스워드</TH>
      <TD><input type="password" name="passwd" size="15"></TD>
      <td>패스워드를 적어주세요.</td>
    </TR>
    
    <TR>
      <TH>사진</TH>
      <TD><input type="file" name="fnameMF" accept=".jpg,.png,.gif"></TD>
      <td>사진은 JPG,PNG,GIF파일만 올려주세요.</td>
    </TR>
    
   
    
   
    
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='사진등록'>
    <input type='reset' value='취소' onclick="history.back()">
  </DIV>
</FORM>

 </div>
<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
</html> 