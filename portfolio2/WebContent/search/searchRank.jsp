<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); %> 
<%@ include file="../ssi/ssi.jsp" %> 
<%
SearchDAO dao = new SearchDAO();
List <SearchDTO> list =	dao.searchRank();
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

</head> 
<body> 
<h4>실시간 search 순위</h4>
      <table>
      <tr>
      		<th>순위</th>
      		<th>검색어</th>
      		<th>검색수</th>
      </tr>
      
      <% 
      	SearchDTO dto = new SearchDTO();
      	for(int i=0;i<list.size();i++){
    	  dto=list.get(i);
    	  %>
      		
      			<tr>
      				<td><%=i+1 %></td>
      				<td><a href=""><%=dto.getKeyword() %></a></td>
      				<td><%=dto.getCnt() %></td>
      			</tr>
      		
      <%} %>
      </table>
</body> 
</html> 