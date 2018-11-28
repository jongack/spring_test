<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>
<%@ page import ="spring.model.memo.*,java.util.*" %>
<%

String paging = (String)request.getAttribute("paging");
List<MemoVO> list = (List)request.getAttribute("list");
String col = (String)request.getAttribute("col");
String word = (String)request.getAttribute("word");
int nowPage = (Integer)request.getAttribute("nowPage");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function read(memono) {
		//alert(memono);
		var url = "./read";
		url = url + "?memono=" + memono;
		url=url+"&col=<%=col%>";
		url=url+"&word=<%=word%>";
		url=url+"&nowPage=<%=nowPage%>";
		location.href = url;
	}
</script>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 24px;
}
/* 
div {
	text-align: center;
	margin-top: 20px;
	margin-bottom: 20px;
}

table {
	width: 60%;
	margin: 0 auto;
}

table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	padding: 10px
}

a:LINK {
	color: #000000;
	text-decoration: none;
}

a:VISITED {
	color: #000000;
	text-decoration: none;
}

a:HOVER {
	color: #ff0000;
	text-decoration: none;
}

a:ACTIVE {
	color: #000000;
	text-decoration: none;
} */
.search{
	text-align:center;
	margin:2px auto;
}
</style>

</head>
<body>

	
	
	<div class="search">
	<form method="post" action="./list">
	<select name ="col">
		<option value="title"
		<%if(col.equals("title")) out.print("selected"); %>
		>제목</option>
		<option value="content"
		<%if(col.equals("content")) out.print("selected"); %>
		>내용</option>
		<option value="total">전체출력</option>
	</select>
	<input type="text" name="word" value="<%=word%>"/>
	<button>검색</button>
	<button type="button" onclick="location.href='create.do' ">등록</button>
	</form>
	</div>
	
	<div class="container">
	<h2><span class="glyphicon glyphicon-list"></span>메모목록</h2>
	<table class="table table-hover">
		<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>날짜</th>
			<th>조회수</th>
			<th>grpno</th>
			<th>indent</th>
			<th>ansnum</th>
		</tr>
		</thead>
		<%
			if (list.size()==0) {
		%>
		<tbody>
		<tr>
			<td colspan='7'>등록된 메모가 없습니다.</td>
		</tr>
		</tbody>
		<%
			} else {
				MemoVO dto = new MemoVO();
				for(int i=0;i<list.size();i++) {
					dto = list.get(i);
		%>
		<tbody>
		<tr>
			<td><%=dto.getMemono() %></td>
			<td style="align:left">
			<%
				for(int r=0;r<dto.getIndent();r++){
					out.print("&nbsp;&nbsp;");
				}if(dto.getIndent()>0){
					out.print("<img src='../images/re.jpg'> ");
				}
			%>
			<A href="javascript:read('<%=dto.getMemono()%>')"><%=dto.getTitle()%></A></td>
			<td><%=dto.getWdate()%></td>
			<td><%=dto.getViewcnt()%></td>
			<td><%=dto.getGrpno()%></td>
			<td><%=dto.getIndent()%></td>
			<td><%=dto.getAnsnum()%></td>
		</tr>
		</tbody>
		<%
			}
			}
		%>
	</table>
	<div>
		<%=paging %>
	</div>
	</div>

</body>
</html>