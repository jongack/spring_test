<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 

<!DOCTYPE html>   
<html>  
<head> 
<meta charset="UTF-8"> 
<title></title>  
<script type="text/javascript">
function inCheck(f){ 
	if(f.passwd.value=""){
	alert("패스워드를 입력하세요");
	f.passwd.focus();
	return false; 
	}
}
</script>
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 
<DIV class="title">수정</DIV>
 
<FORM name='frm' method='POST' action='./update'
      onsubmit="return inputCheck(this)"
      enctype="multipart/form-data">
      <input type="hidden" name="no" value="${param.no}">
      <input type="hidden" name="oldfile" value="${dto.fname}">
      <input type="hidden" name="col" value="${param.col}">
      <input type="hidden" name="word" value="${param.word}">
      <input type="hidden" name="nowPage" value="${param.nowPage}">

  <table>
    <TR>  
      
      <TD colspan="3" >
      <img src="./storage/${dto.fname}"></TD>
      <td><input type="file" name="fnameMF"></td>
     
    </TR>
    <tr> 
    <th>*번호</th> 
    <TD>${dto.no } 
    </TD>
    <td> 번호입니다.</td>
    </tr>
    <tr>
    <th>이름</th>
    <TD><input type="text" name="name" value="${dto.name}">
    </TD>
    <td> 이름입니다.</td>
    </tr>
    <tr>
    <th>제목</th>
    <TD><input type="text" name="title" value="${dto.title }">
    </TD>
    <td> 제목입니다.</td> 
    </tr>
    <tr>
    <th>기존 패스워드</th>
    <TD><input type="password" name="passwd"></TD>
    <td> 기존 패스워드입니다.</td>
    </tr>
 
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='정보수정'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
</html> 