<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="subscriber.SubscriberDAO"/>
<jsp:useBean id="dto" class="subscriber.SubscriberDTO"/>
<%
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total")){
		word ="";
	}
	
	int nowPage = 1;
	int recordPerPage = 5;
	
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	int sno = ((nowPage-1)*recordPerPage)+1;
	int eno = nowPage*recordPerPage;
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word",word);
	map.put("sno", sno);
	map.put("eno", eno);
	
	int totalRecord = dao.total(map);
	
	List<SubscriberDTO> list = dao.list(map);

	String paging = Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);
%>
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
.table,th,td{
	border:1px sold black;

}
</style>
<script type="text/javascript">
	function goread(id){
		url="read.jsp";
		url = url+"?id="+id;
		
		location.href=url;
	}
</script>
<body class="w3-content" style="max-width:1200px">
<jsp:include page="/menu/menu.jsp" flush="false"/>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:250px">

 <!-- Push down content on small screens -->
  <div class="w3-hide-large" style="margin-top:83px"></div>

<!-- top header -->
<jsp:include page="/menu/top.jsp" flush="false"/>


<!-- *********************************************** -->
 
<DIV class="title">회원 목록</DIV>
<div class="serch">
 <FORM name='frm' method='POST' action='./list.jsp'>

 <select name="col">
<option value="mname"
<%if(col.equals("mname")) out.print("selected"); %>
>이름</option>
<option value="id"
<%if(col.equals("id")) out.print("selected"); %>
>아이디</option>
<option value ="total">전체검색</option>
  </select>
 <input type="text" name="word" value="<%=word %>">
 <input type="submit" value="검색">
 <input type="button" value ="등록" onclick="location.href='createForm.jsp'">
</form>
 </div>
 <div class="container">
 <h2><span class="glyphicon glyphicon-th-list"></span>
 목록</h2>
 
  
    <%if(list.size()==0){ %>
    <TABLE class="table table-hover">
    <tr>
    	<td colspan="3">
    	등록된글이없습니다
    	</td>
    </tr>
    </TABLE>
    <%}else{
 

 	for(int i=0; i<list.size();i++){
 	
 		dto=list.get(i);
 %>
  <table >
    <TR>
      <TH>아이디</TH>
      <TD><a href="javascript:goread('<%=dto.getId() %>')"><%=dto.getId() %></a></TD>
    </TR>
    <TR>
      <TH>이름</TH>
      <TD><%=dto.getMname() %></TD>
    </TR>
    <TR>
      <TH>이메일</TH>
      <TD><%=dto.getEmail() %></TD>
    </TR>
    <TR>
      <TH>전화번호</TH>
      <TD><%=dto.getTel() %></TD>
    </TR>
    <TR>
      <TH>우편번호</TH>
      <TD><%=dto.getZipcode() %></TD>
    </TR>
    <TR>
      <TH>주소</TH>
      <TD><%=dto.getAddress1() %></TD>
    </TR>
    <TR>
      <TH>상세주소</TH>
      <TD><%=dto.getAddress2() %></TD>
    </TR>
    <TR>
      <TH>가입일</TH>
      <TD><%=dto.getMdate() %></TD>
    </TR>
    <TR>
      <TH>파일이름</TH>
      <TD><%=dto.getFname() %></TD>
    </TR>
    <TR>
      <TH>회원등급</TH>
      <TD><%=dto.getGrade() %></TD>
    </TR>
  </table><br>
 <%
 	}
    }
 %> 

  <DIV class='bottom'>
    <%=paging  %>
  </DIV>
  

<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 