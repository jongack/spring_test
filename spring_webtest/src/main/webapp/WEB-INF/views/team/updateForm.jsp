<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); %> 
<%@ include file="/ssi/ssi.jsp" %>


<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
div{
	text-align:center;
	margin-top:20px;
}
table, th, td{
	border:1px solid black;
	border-collpse : collapse;
}
th,td{
	padding:5px;
	}
th{
min-width:100px;
align:left;
 }
table{
	width:70%;
	margin:5px auto;
	}
</style> 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('address2').focus();
            }
        }).open();
    }
</script>
<script type="text/javascript">
function incheck(f){
	
	var cnt=0;
	for(var i =0;i<f.skill.length;i++){
		if(f.skill[i].checked==true){
			cnt++;
			}
	}
	if(cnt==0){
		alert("보유기술을 체크하시오");
		f.skill[0].focus();
		return false;
	}
	if(f.hobby.selectedIndex==0){
		alert("취미을 선택하세요");
		f.hobby.focus();
		return false;
	}
	if(f.phone.value==""){
		alert("전화번호을 입력하세요");
		f.phone.focus();
		return false;
	}
	f.submit();
}
</script>
</head> 
<body> 
<div class="container">
<h2>수정</h2>
<form name="frm" action="./update" method="post" size="85">
<input type="hidden" name = "no"	value="${param.no }">
<input type="hidden" name = "col"	value="${param.col }">
<input type="hidden" name = "word"	value="${param.word }">
<input type="hidden" name = "nowPage"	value="${param.nowPage }">

<table style="width: 510px; height: 64px; ">
	
	
	<tr>
	<th>이름	</th>
	<td>${dto.name }</td>
	</tr>
	
	<tr>
	<th >성별</th>
	<td>${dto.gender } 
	</td>
	</tr>
	
	<tr>
	<th>보유기술</th>  
	<td><label><input type ="checkbox" name ="skill" value="백만볼트"
	<c:if test="${fn:indexOf(dto.skills,'백만볼트')!=-1 }">checked</c:if>
	>백만볼트</label>
		<label><input type ="checkbox" name ="skill" value="몸통박치기"
		<c:if test="${fn:indexOf(dto.skills,'몸통박치기')!=-1 }">checked</c:if>
		>몸통박치기</label>
		<label><input type ="checkbox" name ="skill" value="모래날리기"
	<c:if test="${fn:indexOf(dto.skills,'모래날리기')!=-1 }">checked</c:if>
		>모래날리기</label>
		<label><input type ="checkbox" name ="skill" value="버둥대기"
	<c:if test="${fn:indexOf(dto.skills,'버둥대기')!=-1 }">checked</c:if>
		>버둥대기</label>
		<label><input type ="checkbox" name ="skill" value="물대포"
	<c:if test="${fn:indexOf(dto.skills,'물대포')!=-1 }">checked</c:if>
		>물대포</label>
		
	</td>
	</tr>
	
	<tr>
	<th >취미</th>
	<td><select name="hobby">
			<option>취미를 입력하세요</option>
			<option value="영화보기">영화보기</option>
			<option value="게임">게임하기</option>
			<option value="기술서적읽기">기술서적읽기</option>
			<option value="잠자기">잠자기</option>
			<option value="밥먹기">밥먹기</option>
			
		</select>
		
		<script type="text/javascript">
			document.frm.hobby.value='${dto.hobby}';
		</script>
	</td>
	</tr>
	
	<tr>
	<th >전화번호</th>
	<td><input type="text" name="phone" value="${dto.phone }" style="width: 374px; "></td>
	</tr>
	
	<tr>
	<th >우편번호</th>
	<td><input type="text" name="zipcode" size="7" 
		maxlength="5" id="sample6_postcode" value="${dto.zipcode }">
		<button type="button" onclick="sample6_execDaumPostcode()">우편번호 검색</button>
	</td>
	</tr>
	
	<tr>
	<th >주소</th>
	<td><input type="text" name="address" size="50" value="${dto.address }">
		<input type="text" name="address2" size="50" value="${dto.address2 }">
	</td>
	</tr>
</table>
<div>										<!-- this는 버튼타입이므로 버튼 .form으로 폼타입 -->
<button type ="button" onclick="incheck(this.form)">수정</button> <!-- 타입선언안하면 디폴트는 submit -->
<button type="reset">입력취소</button>
</div>
</form>
</div>
</body> 
</html> 