<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="qna.QnaDAO"/>


<%
	//admin 비밀번호 없이 read하기
	String id = (String)session.getAttribute("id");
	String grade=(String)session.getAttribute("grade");
	
	

	//검색관련 처리
	String col = Utility.checkNull(request.getParameter("col"));	//보낸게 없을때는 null로 받아옴
	String word = Utility.checkNull(request.getParameter("word"));
	
	
	if(col.equals("total")){
		word="";
	}
	//paging 관련
	int nowPage = 1; //기본페이지 1페이지로 시작
	int recordPerPage = 5; //한페이지당 보여질 레코드 개수 
	
	if(request.getParameter("nowPage")!=null){
	nowPage = Integer.parseInt(request.getParameter("nowPage")); //null값들어오고 인티저하면 넘버포맷입셋션
	
	}
	
	int sno = ((nowPage-1)*recordPerPage)+1;
	
	int eno = nowPage*recordPerPage;
	
	
	Map map = new HashMap();
	map.put("col",col);
	map.put("word",word);
	map.put("sno",sno);
	map.put("eno",eno);
	

	List<QnaDTO> list = dao.list(map);
	
	int totalRecord = dao.total(map);//전체 레코드 갯수(col,word만 가져간다 검색후의 페이지도 토탈로 읽어야함)
	

%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
	function read(qnano){
		var url= "passCheck.jsp";
		url = url+"?qnano="+qnano;
		url=url+"&col=<%=col%>";
		url=url+"&word=<%=word%>";
		url=url+"&nowPage=<%=nowPage%>";
		
		location.href=url;
		
	}
	function readAdmin(qnano){
		var url= "read.jsp";
		url = url+"?qnano="+qnano;
		url=url+"&col=<%=col%>";
		url=url+"&word=<%=word%>";
		url=url+"&nowPage=<%=nowPage%>";
		location.href=url;
		
	}
	function fileDown(filename){
		var url="<%=root%>/download";
		url=url+"?filename="+filename;
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
 

 <div class ="serch">
 <form method="post" action="./list.jsp">
 
 <select name="col" >
 <option value="wname"
 <%if(col.equals("wname")) out.print("selected"); %>
 >성명</option>
 <option value="title"
 <%if(col.equals("title")) out.print("selected"); %>
 >제목</option>
 <option value="content"
 <%if(col.equals("content")) out.print("selected"); %>
 >내용</option>
 <option value="total"
 <%if(col.equals("total")) out.print("selected"); %>
 >전체출력</option>
<option value="title/content"
<%if(col.equals("title/content")) out.print("selected"); %>
>제목+내용</option> 
 </select>
 
 <input type="text" name="word" value="<%=word%>"/>

 <button>검색</button>
 <button type="button" onclick="location.href='createForm.jsp' ">등록</button>
 </form>
  </div>
<div class="container">
<h2><span class="glyphicon glyphicon-list"></span>목록</h2>
  <TABLE class="table table-hover">
    <thead>
    <TR>
      <TH>번호</TH>
      <TH>제목</TH>
      <TH>성명</TH>
      <TH>조회수</TH>
      <TH>등록일</TH>
      <TH>파일명</TH>
      
     
    </TR>
    </thead>
    <%
    	if(list.size()==0){
    %>	
    <tbody>
    	<tr><td colspan="6">
    		등록된 글이 없습니다.
    	</td></tr>
    	</tbody>
    <%
    	}else{
			for(int i=0;i<list.size();i++){
    				
    		
    		QnaDTO dto = list.get(i);
    %>	
    		
    			
    <tbody>
    <tr>
    	<td><%=dto.getQnano() %></td>
    	<td>
    	<%
    		for(int r=0; r<dto.getIndent();r++){
    			out.print("&nbsp;&nbsp;");
    			
    		}
    		if(dto.getIndent()>0){
    			out.print("<img src='../images/re.jpg'> ");
    		}
    		if(id!=null && grade.equals("A")){
    	%>
    	<a href="javascript:readAdmin('<%=dto.getQnano() %>')"><%=dto.getTitle() %></a>
    	<%}else{ %>
    	<a href="javascript:read('<%=dto.getQnano() %>')"><%=dto.getTitle() %></a>
    		<%}
    		if(Utility.compareDay(dto.getWdate())){
    			out.print("<img src='../images/new.JPG'>");
    		}
    		%>
    	</td>
    	<td><%=dto.getWname() %></td>
    	<td><%=dto.getViewcnt() %></td>
    	<td><%=dto.getWdate() %></td>
    	<td><% if(dto.getFilename()!=null){out.print(dto.getFilename());  %>
    			
    			<a href="javascript:fileDown('<%=dto.getFilename()%>')">
          		<span class="glyphicon glyphicon-download-alt"></span>
        		</a>
    			<% 	}else{
    						out.print("<img src='../images/vkdlfl.JPG'>"+"없습니다");
    				}
    	
    	%></td>
    	
    	
    </tr>
    </tbody>
    <% 
   			 }//for end
    	}//if end			
    %> 
     
  </TABLE>
  
  <DIV class='bottom'>
   
    <%=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word) %>
  </DIV>
</div> 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 