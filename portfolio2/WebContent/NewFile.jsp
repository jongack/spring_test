<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); %> 

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
</style> 
<script type="text/javascript">
	function ddd(f){
		
		var str = f.u.value;
		for(var i=2; i<11;i++){
			
		var urr = str+i;
		window.open(urr);
		}
		
	}

</script>
</head> 
<body> 

<form name="frm" action="./NewFile1.jsp" method="post">

<input type="text" name="u">
<button type="submit">서브밋</button>
<button type ="button" onclick="ddd(this.form);">전송</button>
</form> 
</body> 
</html> 