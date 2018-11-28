var httpRequest = null;

function sendRequest(url, params, response_function_name, method){
	
	if (window.XMLHttpRequest){
		
		httpRequest = new XMLHttpRequest();
		} else {
	
		httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
		}
	
	httpMethod =method.toLowerCase();
	
	var httpParams = (params == null||params=='')? null:params;
	var httpUrl = url;
	
	if(httpMethod =="get"&&httpParams!=null){
		httpUrl = httpUrl+"?"+httpParams;
	}
	httpRequest.open(httpMethod, httpUrl, true);
	
	httpRequest.setRequestHeader(
			"Content-Type","application/x-www-form-urlencoded");
	httpRequest.onreadystatechange = response_function_name;
	
	httpRequest.send(httpMethod=="post"?httpParams:null);
	
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
