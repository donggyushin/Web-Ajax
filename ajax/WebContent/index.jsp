<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html>
<html>
  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <title>Ajax web page</title>
    <script type="text/javascript">
    	var request = new XMLHttpRequest();
    	
    	function searchFunction(){
    		request.open("Post", "./UserSearchServlet?userName=" + encodeURIComponent(document.getElementById("userName").value), true);
    		request.onreadystatechange = searchProcess;	//servlet에 정보를 제대로 주고 정보를 제대로 받고 나면 실행.
    		request.send(null);
    	}
    	function searchProcess(){
    		
    		var table = document.getElementById("ajaxTable");
    		table.innerHTML = ""; 
    		
    		if(request.readyState == 4 && request.status == 200){
    			var object = eval('('+ request.responseText +')');	//여기서 넘어온 제이슨형식의 문자열을 객체 형식으로 받아주고
        		var result = object.result;							//그 객체중 result 요소들을 따로 담아주고
        		for(var i = 0 ; i < result.length; i ++){
        			//result 객체 요소 하나 받을때 마다 행 하나씩 추가해주고
        			var row = table.insertRow(0);
        			//result 객체 요소중 하나당 존재하는 자릿수만큼 셀을 넣어주고 그 셀에다가 정보(value) 넣어줌
        			for(var j = 0 ; j < result[i].length; j++){
        				var cell = row.insertCell(j);
        				cell.innerHTML = result[i][j].value;
        			}
        		}	
    		}	
    	}
    	
    	var registerRequest = new XMLHttpRequest();
    	function registerFunction(){
    		
    		registerRequest.open("Post", "./UserRegisterServlet?userName=" + encodeURIComponent(document.getElementById("registerName").value)
    										+"&userAge="+ encodeURIComponent(document.getElementById("registerAge").value)
    										+"&userGender=" + encodeURIComponent($('input[name=registerGender]:checked').val())
    										+"&userEmail=" + encodeURIComponent(document.getElementById("registerEmail").value), true);
    		
    		registerRequest.onreadystatechange = registerProcess;
    		
    		registerRequest.send(null);
    	}
    	function registerProcess(){
    		if(registerRequest.readyState == 4 && registerRequest.status == 200){
    			var result = registerRequest.responseText;
    			if(result != 1){
    				alert('등록에 실패하였습니다. ');
    			}else{
    				var registerName = document.getElementById("registerName");
    				var registerAge = document.getElementById("registerAge");
    				var registerEmail = document.getElementById("registerEmail");
    				var userName = document.getElementById("userName");
    				registerName.value = "";
    				userName.value = "";
    				registerAge.value="";
    				registerEmail.value = "";
    				searchFunction();
    			}
    				
    			
    		}
    	}
    	window.onload = function(){
    		searchFunction();
    	}
    </script>
  </head>
  <body>
  	<div class="container" style="margin-top:10px" >
  		<form class="form-inline mt-2 mt-md-0" style="float:right;">
            <input class="form-control mr-sm-2" type="text" id="userName" onkeyup="searchFunction()" placeholder="Name" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" onclick="searchFunction()" type="button">Search</button>
          </form>
				<table class="table" style="padding:10px;">
			  <thead>
			    <tr>
			      <th scope="col">이름</th>
			      <th scope="col">나이</th>
			      <th scope="col">성별</th>
			      <th scope="col">이메일</th>
			    </tr>
			  </thead>
			  <tbody id="ajaxTable">
			    </tbody>
			</table>
   	  
  	</div>
  	
  	<div class="container" style="margin-top:10px;">
  		<table class="table">
  <thead class="thead-light">
    <tr>
      <th colspan="4" style="text-align:center;"><h5>회원 등록 양식</h5></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td >이름</td>
      <td><input type="text" class="form-control" id="registerName" size="20"></td>
    </tr>
    <tr>
      <td scope="row">나이</td>
      <td><input type="text" class="form-control" id="registerAge" size="20"></td>
    </tr>
    <tr>
    	<td>
    		성별
    	</td>
    	<td colspan="3" style="text-align:center">
    		<div class="btn-group colors" data-toggle="buttons" >
				  <label class="btn btn-primary active">
				    <input type="radio" name="registerGender" value="남자" autocomplete="off" checked> 남자
				  </label>
				  <label class="btn btn-primary">
				    <input type="radio" name="registerGender" value="여자" autocomplete="off"> 여자
				  </label>
				  
				</div>
    	</td>
    </tr>
    <tr>
      <td scope="row">이메일</td>
      <td><input type="Email" class="form-control" id="registerEmail" size="20"></td>
    </tr>
    <tr>
    	<td colspan="4" style="text-align:center">
    		<button type="button"  class="btn btn-secondary" onclick="registerFunction()" >제출</button>
    	</td>
    </tr>
  </tbody>
</table>
  	</div>
   	
   	
   	
  
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </body>
</html>