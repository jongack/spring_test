var httpRequestSecond = null;

function sendRequestSecond(url, params, response_function_name, method){
	
	if (window.XMLHttpRequest){
		
		httpRequestSecond = new XMLHttpRequest();
		} else {
	
		httpRequestSecond = new ActiveXObject("Microsoft.XMLHTTP");
		}
	
	httpMethod =method.toLowerCase();
	
	var httpParams = (params == null||params=='')? null:params;
	var httpUrl = url;
	
	if(httpMethod =="get"&&httpParams!=null){
		httpUrl = httpUrl+"?"+httpParams;
	}
	httpRequestSecond.open(httpMethod, httpUrl, true);
	
	httpRequestSecond.setRequestHeader(
			"Content-Type","application/x-www-form-urlencoded");
	httpRequestSecond.onreadystatechange = response_function_name;
	
	httpRequestSecond.send(httpMethod=="post"?httpParams:null);
	
}
	function log(msg){
		var console = document.getElementById("debugConsole");
		
		if(console!=null){
			console.innerHTML += msg+"<Br/>"	;
		}
	}
	function show(elementId){
		var element = document.getElementById(elementId);
		if(element){
			element.style.display	='';
		}
	}
	function hide(elementId){
		var element = document.getElementById(elementId);
		if(element){
			element.style.display="none";
		}
	}
