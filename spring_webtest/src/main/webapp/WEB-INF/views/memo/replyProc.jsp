<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>

<%
 	boolean flag = (Boolean)request.getAttribute("flag");
	String col = (String)request.getAttribute("col");
	String word = (String)request.getAttribute("word");
	String nowPage = (String)request.getAttribute("nowPage");
	
%>

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
	function mlist(){
		var url="list.do";
		url=url+"?col=<%=col%>";
		url=url+"&word=<%=word%>";
		url=url+"&nowPage=<%=nowPage%>";
		location.href=url;
	}


</script>
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>

<!-- *********************************************** -->
 
<h2>처리결과</h2>
 <div class="container">
 	<%
 		if(flag){
 			out.print("답변이 등록되었습니다.");
 		}else{
 			out.print("답변 등록이 실패했습니다.");
 		}
 	
 	
 	%>
 
 
 </div>
 

    <input type='button' value='목록' onclick="mlist()">
    <input type='button' value='등록' onclick="location.href='create.do' ">


<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
 
</html> 