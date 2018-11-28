<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %> 
<%!
//한글이 깨질시 인코딩 타입을 찾아내는 테스트용 메소드
public String findCharSet(String ko){
    String corean = null;
    try{
        String [] charset = {"utf-8", "euc-kr", "ksc5601", "ISO-8859-1", "ascii"};
        for(int i=0;i<charset.length; i++){
           for(int j=0;j<charset.length; j++){
              if(i==j) continue;
              System.out.print(charset[i] + " -> " + charset[j] + " : ");
              System.out.println(new String(ko.getBytes(charset[i]), charset[j]));
           }
        }
     }
     catch(Exception e){
        e.printStackTrace();
     }        
    return corean;
}

public String ko(String ko){
	 String corean = null;
	 try{
	     corean =  new String(ko.getBytes("ISO-8859-1"), "euc-kr");
	 }catch(Exception e){
	     return corean; 
	 }
	 return corean;
	}
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
<jsp:include page="/menu/menu.jsp" flush="false"/>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:250px">

 <!-- Push down content on small screens -->
  <div class="w3-hide-large" style="margin-top:83px"></div>

<!-- top header -->
<jsp:include page="/menu/top.jsp" flush="false"/>


<!-- *********************************************** -->
 
<h2>
<%
request.setCharacterEncoding("UTF-8");
 
String keyword = request.getParameter("keyword");
 
//------------------------------------------------------
// 한글 문자셋 검색
// ------------------------------------------------------
// findCharSet(keyword);
// ------------------------------------------------------
        
out.println("keyword:" + keyword);
%>
</h2>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</div>
</body>
<!-- *********************************************** -->
 
</html> 