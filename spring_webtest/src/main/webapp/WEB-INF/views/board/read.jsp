<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function fileDown(){
	var url = "${pageContext.request.contextPath}/download";
	
	url += "?filename=${dto.filename}";
	url += "&dir=/storage";
	
	location.href=url;
}

function replyb(){
	var url = "reply";
	url += "?col=${param.col}";
	url += "&word=${param.word}";
	url += "&nowPage=${param.nowPage}";
	url += "&num=${dto.num}";
	
	location.href=url;
}
function updateb(){
	var url = "update";
	url += "?col=${param.col}";
	url += "&word=${param.word}";
	url += "&nowPage=${param.nowPage}";
	url += "&num=${dto.num}";
	
	location.href=url;
}
function listb(){
	var url = "list";
	url += "?col=${param.col}";
	url += "&word=${param.word}";
	url += "&nowPage=${param.nowPage}";

	
	location.href=url;
}
function deleteb(){
	var url = "delete";
	url += "?col=${param.col}";
	url += "&word=${param.word}";
	url += "&nowPage=${param.nowPage}";
	url += "&num=${dto.num}";
	url += "&filename=${dto.filename}";

	
	location.href=url;
}

function rcheck(tarea){
	if('${sessionScope.id}'==""){
	if(confirm("로그인후 댓글를 쓰세요")){
	var url = "../member/login";
	url = url + "?num=${dto.num}";
	url = url + "&nowPage=${param.nowPage}";
	url = url + "&nPage=${nPage}";
	url = url + "&col=${param.col}";
	url = url + "&word=${param.word}";
	url = url + "&flag=../board/read";
	location.href=url;
	}else{
	tarea.blur();
	}
	}
	}
	 
	function input(f){
	if('${sessionScope.id}'==""){
		if(confirm("로그인후 댓글를 쓰세요")){
			var url = "../member/login";
			url = url + "?num=${dto.num}";
			url = url + "&nowPage=${param.nowPage}";
			url = url + "&nPage=${nPage}";
			url = url + "&col=${param.col}";
			url = url + "&word=${param.word}";
			url = url + "&flag=../board/read";
			location.href=url;
			return false;
		}else{
		 
			return false;
		}
	}else if(f.content.value==""){
		alert("댓글 내용을 입력하세요.");
		f.content.focus();
		return false;
	}
	}
	function rupdate(rnum,rcontent){
	var f = document.rform;
	
	f.content.value = rcontent;
	f.rnum.value = rnum;
	f.rsubmit.value="수정";
	f.action="./rupdate"
	}
	function rdelete(rnum){
	if(confirm("정말삭제 하겠습니까?")){ 
	var url = "./rdelete";
	url = url + "?rnum="+rnum;
	url = url + "&num=${dto.num}";
	url = url + "&nowPage=${param.nowPage}";
	url = url + "&nPage=${nPage}";
	url = url + "&col=${param.col}";
	url = url + "&word=${param.word}";
	location.href=url; 
	}
	}
</script>
</head>
<body>
<div class="container">
  <h2>조회</h2>
  <table class="table">
   
      <tr>
        <th>성명</th>
        <td>${dto.name}</td>
       </tr>
    
      <tr>
        <th>제목</th>
        <td>${dto.subject}</td>
      </tr>
      <tr>
        <th>내용</th>
        <td>${content }</td>
      </tr>
      <tr>
        <th>파일</th>
        <td>
        
        <c:choose>
         <c:when test="${empty dto.filename }">파일없음</c:when>
         <c:otherwise>
          <a href="javascript:fileDown()">${dto.filename}(${dto.filesize})</a>           
         </c:otherwise>
        </c:choose>  
        
        </td>
      </tr>
      <tr>
        <th>등록일</th>
        <td>${dto.regdate}</td>
      </tr>
      <tr>
        <th>조회수</th>
        <td>${dto.count}</td>
      </tr>
      <tr>
        <th>아이피</th>
        <td>${dto.ip}</td>
      </tr>

  </table>
  <button onclick="listb()">목록</button>
  <button onclick="updateb()">수정</button>
  <button onclick ="deleteb()">삭제</button>
  <button onclick="replyb()">답변</button> 

<hr>
<c:forEach var="rdto" items="${rlist}">
  <div class="rlist">
  ${rdto.id }<br>
  <p>${rdto.content }</p>
  ${rdto.regdate }<br>
	  <c:if test="${sessionScope.id==rdto.id }">
		  <span style="float:right">
		  <a href="javascript:rupdate('${rdto.rnum }','${rdto.content}')">수정</a>
		  <a href="javascript:rdelete('${rdto.rnum }')">삭제</a>
		  </span>
	  </c:if>
  </div>
 </c:forEach>

<div class="rcreate">
  <form name="rform" action="./rcreate" method="post" onsubmit="return input(this)">
	  
	  <textarea rows="3" cols="28" name="content" onclick="rcheck(this)"></textarea>
	  
	  <input type="submit" name="rsubmit" value="등록">
	  <input type="hidden" name="num" value="${dto.num}">
	  <input type="hidden" name="id" value="${sessionScope.id}">
	  <input type="hidden" name="nowPage" value="${param.nowPage}">
	  <input type="hidden" name="nPage" value="${nPage}">
	  <input type="hidden" name="col" value="${param.col}">
	  <input type="hidden" name="word" value="${param.word}">
	  <input type="hidden" name="rnum" value="${0}">
   </form>
  </div>
  <div class="bottom">
  ${rpaging}
</div>



</div>
</body>
</html>