<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="qna.QnaDAO"/>
<%
	//admin 비밀번호 없이 read하기
	String id = (String)session.getAttribute("id");
	String grade=(String)session.getAttribute("grade");
	
	String passwd = request.getParameter("passwd");
	int qnano = Integer.parseInt(request.getParameter("qnano"));
	String col = request.getParameter("col");
	String word = request.getParameter("word");
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));
	
	Map map = new HashMap();
	
	map.put("passwd", passwd);
	map.put("qnano", qnano);
	
	boolean flag = dao.passCheck(map);
	
	
	String content =null;
	String filename =null;
	String wname =null;
	String title = null;
	String wdate = null;
	long filesize = 0;
	int viewcnt =0;
	if(flag || grade.equals("A")){
	dao.upViewcnt(qnano);	
	QnaDTO dto = dao.read(qnano);
	
	content = dto.getContent();
	content = content.replaceAll("\r\n","<br>");
	 filename = dto.getFilename();
	 wname = dto.getWname();
	title = dto.getTitle();	
	viewcnt = dto.getViewcnt();
	wdate = dto.getWdate();
	filesize = dto.getFilesize();
	passwd = dto.getPasswd();
	}
%>

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
	function blist(){
		var url= "list.jsp";
		url= url+"?col=<%=col%>";
		url= url+"&word=<%=word%>";
		url= url+"&nowPage=<%=nowPage%>";
		location.href=url;
	}
	function bupdate(){
		var url= "updateForm.jsp";
		url=url+"?qnano=<%=qnano%>";
		url= url+"&col=<%=col%>";
		url= url+"&word=<%=word%>";
		url= url+"&nowPage=<%=nowPage%>";
		location.href=url;
	}
	function bdel(){
		var url= "deleteForm.jsp";
		url=url+"?qnano=<%=qnano%>";
		url=url+"&oldfile=<%=filename%>";
		url= url+"&col=<%=col%>";
		url= url+"&word=<%=word%>";
		url= url+"&nowPage=<%=nowPage%>";
		location.href=url;
	}
	function breply(){
		var url = "replyForm.jsp";
		url=url+"?qnano=<%=qnano%>";
		url=url+"&passwd=<%=passwd%>";
		url= url+"&col=<%=col%>";
		url= url+"&word=<%=word%>";
		url= url+"&nowPage=<%=nowPage%>";
		location.href=url;
	}
	function fileDown(){
		var url="<%=root%>/download";
		url=url+"?filename=<%=filename%>";
		url = url +"&dir=/qna/storage";
		location.href = url;
		
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


<!-- *********************************************** -->
 
<DIV class="title">조회</DIV>
 
 <%if(flag || grade.equals("A")){ %>
  <TABLE   style="width:60%;padding:20px">
    <TR>
      <TH>제목</TH>
      <TD><%=title %></TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><%=wname%></TD>
    </TR>
    <TR>
      <TH>조회수</TH>
      <TD><%=viewcnt%></TD>
    </TR>
    <TR>
      
      <TD colspan="2"><%=content %></TD>
    </TR>
    <TR>
      <TH>등록일</TH>
      <TD><%=wdate %></TD>
    </TR>
    <TR>
      <TH>파일</TH>
      <TD>
      <%
      	if(filename!=null){
      		out.print(filename);
      		out.print("("+ (filesize/1024) +"KB)");%>
      			<a href="javascript:fileDown()">
          		<span class="glyphicon glyphicon-download-alt"></span>
        		</a>
        		
      	<%	
      	}else{
      		out.print("<img src='../images/vkdlfl.JPG'>"+"없습니다");
      	}
      %></TD>
    </TR>
    
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='목록' onclick="blist()">
    <input type='button' value='등록' onclick="location.href='createForm.jsp' ">
    <button onclick="bupdate()">수정</button>
    <button onclick="bdel()">삭제</button>
    <button onclick="breply()">답변</button>
  </DIV>
<%}else{	 %>
비밀번호가 잘못되었습니다 
<input type="button" value="다시시도" onclick ="history.back()">
<%} %>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 