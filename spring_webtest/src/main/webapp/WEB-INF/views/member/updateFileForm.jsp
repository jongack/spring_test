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

<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 
<DIV class="title">파일수정</DIV>
 
 <FORM name='frm' method='POST' action='./updateFile'
  enctype="multipart/form-data">
  <input type="hidden" name="id" 
  value="${param.id }"/>
  <input type="hidden" name="oldfile" 
  value="${param.oldfile }"/>
  <TABLE>
  <TR>
      <td colspan="2">
      <img src="./storage/${param.oldfile }">
      </td>
      </tr>
    <TR>
      <TH>파일</TH>
      <TD><input type="file" name="fnameMF" required="required"></TD>
    </TR>
    
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='수정'> 
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
 
</html> 