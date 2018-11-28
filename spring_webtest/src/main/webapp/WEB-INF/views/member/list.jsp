<%@page import="com.sun.corba.se.impl.javax.rmi.CORBA.Util"%>
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
	function read(id){
		var url = "${root}/member/read";
		url = url+"?id="+id;
		url = url+"&col=${col}";
		url = url+"&word=${word}";
		url = url+"&nowPage=${nowPage}";
		location.href=url;
		
	}

</script>
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 
<h2>회원목록</h2>


 <div class="search">
 <FORM name='frm' method='POST' action='./list'>
  <select name ="col">
  <option value="mname"
  <c:if test="${col == 'mname' }">selected</c:if>
  
  >성명</option>
  <option value="email"
  <c:if test="${col == 'email' }">selected</c:if>
  >이메일</option>
  <option value="id"
  <c:if test="${col == 'id' }">selected</c:if>
  >아이디</option>
  <option value="total">전체출력</option>
  
  
  </select>
  <input type="text" name="word" value="${word }">
  <input type = "submit" value="검색">
  <input type ="button" value="회원가입" onclick="location.href='${root}/member/createForm.jsp'">
  </form>
  </div>
  <div class="container">
  <h2><span class="glyphicon glyphicon-th-list"></span>
회원 목록 
  </h2>
  <c:forEach var="dto" items="${list }">
  	
  
  <table class="table table-hover">
  	<tr>
  	<td rowspan="5"	 width="30%">
  	
  	<img src="${root }/member/storage/${dto.fname }" width="200px" height="200px">
  	
  	<th width="20%">아이디</th>
  	<td width="50%">
  	<a href="javascript:read('${dto.id }')">
  	${dto.id }</a>
  	</td>
  	</tr>
  	<tr>
  	<th>성명</th>
  	<td>${dto.mname }</td>
  	</tr>
  	<tr>
  	<th>전화번호</th>
  	<td>${dto.tel }</td>
  	</tr>
  	<tr>
  	<th>이메일</th>
  	<td>${dto.email }</td>
  	</tr>
  	<tr>
  	<th>주소</th>
  	<td>${dto.address1 }<br>
  	${dto.address2 }</td>
  	</tr>
  
  </table>
  </c:forEach>
  <DIV class='bottom'>
   ${paging }
  </DIV>
</div>
<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
 
</html> 