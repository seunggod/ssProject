<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function PwCheck() {
	var pw  = $('#pw').val();
	var rpw = $('#pww').val();
	
	if(pw == rpw){
		$("#pww").css("background-color", "#B0F6AC");
		$('#btn_pw').prop("disabled",false); 
	}else{
		$("#pww").css("background-color", "#FFCECE");
		$('#btn_pw').prop("disabled",true); 
	}
	
}
</script>
</head>
<body>
	
	<div style="width: 400px; background-color : #F8F8F8; padding : 10px; margin-left: auto; margin-right: auto; margin-top: 40px;
	 margin-bottom: 20px; ">
		<form action="/mboard?cmd=PwUpdate&id=${ param.id }" method="post" >
		비밀번호 수정
		<table style="margin-top: 30px; margin-left: 10px;">		
		<tr>
			<td> 비밀번호	</td>	
			<td><input type="text" id="pw" placeholder="비밀번호" name="pw"></td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>	
				<td>
					<input type="password" id="pww" placeholder="비밀번호 확인" name="pww" oninput="PwCheck()">	
				</td>	
		</tr>
		<tr>
			<td colspan="2" align="center" >
				<div style="display: flex; justify-content: flex-end;">
					<input  type="submit" value="수정" class="button" id="btn_pw" disabled>
				</div>
			</td>
		</tr>
	</table>
		</form>
		</div>
</body>
</html>