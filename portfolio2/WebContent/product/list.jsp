<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="product.ProductDAO"/>
<jsp:useBean id="dto" class="product.ProductDTO"/>

<%
	//admin 
	String id = (String)session.getAttribute("id");
	String grade=(String)session.getAttribute("grade");
	
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	
	String order = "desc";
	String by = "pdnum";
	if(request.getParameter("order")!=null){
	order = request.getParameter("order");
	}
	if(request.getParameter("by")!=null){
	by = request.getParameter("by");
	}
	
	
	if(col.equals("total")){
		word ="";
	}
	
	int nowPage = 1;
	int recordPerPage = 5;
	if(request.getParameter("recordPerPage")!=null){
	 recordPerPage = Integer.parseInt(request.getParameter("recordPerPage"));
	}
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
	map.put("by", by);
	map.put("order", order);
	
	int totalRecord = dao.total(map);
	
	List<ProductDTO> list = dao.list(map);
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
</style>
<body class="w3-content" style="max-width:1200px">


<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:250px">

 <!-- Push down content on small screens -->
  <div class="w3-hide-large" style="margin-top:83px"></div>

<!-- top header -->



<!-- *********************************************** -->
 
<DIV class="title"></DIV>
 
 <!-- <FORM name='frm' method='POST' action='./list.jsp'> -->
  
  
  <%
  for(int j=1;j<(list.size()+1); j++){

	  out.print("<TABLE><tr>");

  for( int i=j; i<(list.size()+1); i++){ 
	  dto= list.get(i-1);

	out.print("<td><img src ='"+root+"/product/storage/"+dto.getPdimg()+" ' "+ "width='100%' height='100%'></td>");

		if(i%3==0){break;}
     }

     out.print("</tr>");
     out.print("<tr>");
 
  for(int i=j; i<list.size()+1; i++){ 
	  dto= list.get(i-1);
 
	out.print("<td>"+dto.getPdname() +"</td>");
	
	
  if(i%3==0){break;}
 } 
  out.print("</tr>");
  out.print("<tr>");
  for(int i=j; i<list.size()+1; i++){ 
	  
	  dto= list.get(i-1);
  
	  out.print("<th>"+dto.getPdprice() +"</th>");
    
    

  if(i%3==0){break;}
  }
  out.print("</tr>");
 
  j++;
  j++;

 out.print("</TABLE>");
 
 }

  out.print(paging);


  %>
  
  
<%--   <%
  for(int j=1;j<(list.size()+1); j++){
	 %>
	  <TABLE>
	  <tr>
<%
  for( int i=j; i<(list.size()+1); i++){ 
	  dto= list.get(i-1);
%>
	<td><img src ="<%=root%>/product/storage/<%=dto.getPdimg() %>" width="100%" height="100%"></td>
<% 
		if(i%3==0){break;}
     }
%>
     </tr>
     <tr>
  <%
  for(int i=j; i<list.size()+1; i++){ 
	  dto= list.get(i-1);
  %>
	<td><%=dto.getPdname() %></td>
	
 <% if(i%3==0){break;}
 }%> 
 </tr>
 <tr>
 <%
  for(int i=j; i<list.size()+1; i++){ 
	  dto= list.get(i-1);
  %>
	
 
    
      <th><%=dto.getPdprice() %>원</th>
    
    
<%
  if(i%3==0){break;}
  }
 %> </tr>
 <%
  j++;
  j++;
  %>
  </TABLE>
 <%
 }
%> 
  
  
  <DIV class='bottom'>
      <%=paging  %>
  </DIV>
   --%>
<!-- </FORM> -->
<!-- *********************************************** -->

</div>
</body>
<!-- *********************************************** -->
 
</html> 