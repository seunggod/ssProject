<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../css/common.css"/>
<style>
.login_bottom {text-decoration: none; }
.logintable tr {margin: 50px; padding: 50px;}
.logintable td {margin: 50px; padding: 50px;}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

var expName = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;

window.onload = function() {
	$('#name').keyup( function NameCheck() {
		if( expName.test(this.value) ){
		this.value = this.value.replace(expName , "")    ;
		}
		return ;
	} );


$('#mon,#year').change(function() {
var mon = document.getElementById('mon').value;
var year = document.getElementById('year').value;

console.log(year);
console.log(mon);

let lastDate = new Date(year, mon, 0);
var c = lastDate.getDate();

console.log("마지막 일자" + c);

var html ="";
for (var i = 1; i < c+1; i++) {
	html += "<option>"+ i +"</option>";
}
  $('#day').html(html);
}
  )
  
  
}
function birthh() {
var year = document.getElementById('year').value;
var mon = document.getElementById('mon').value;

console.log(year);
console.log(mon);

let lastDate = new Date(year, mon, 0);
var c = lastDate.getDate();

console.log("마지막 일자" + c);

var html ="";
for (var i = 1; i < c+1; i++) {
	html += "<option>"+ i +"</option>";
}
  $('#day').html(html);
}	

function openPw( id ){
	var popupWidth = 600;
	var popupHeight = 300;

	var popupX = (window.screen.width / 2) - (popupWidth / 2);
	var popupY= (window.screen.height / 2) - (popupHeight / 2) - 100 ;
	
	var link = "/view/common/PW_Update.jsp?id="+ id ;
    window.open( link, " ", "width=600, height=300, toolbar=no, menubar=no, scrollbars=no, resizable=yes, left="+popupX+",top="+popupY );
    openWin.document
}
</script>
</head>
<body>
<%@ include file="header.jsp" %>
<div style="height: 75px"></div>

<div class="home">
	<a href="../common/index.jsp" id="main"><img src="/img/home.png" style="width: 50px; height: 50px;"></a>
</div>
<h2 class="logintitle">비밀번호 찾기</h2>



<form action="/mboard?cmd=PwSearch" method="post" class="loginForm"  >
	
 <table class="logintable">
 
 
 <tr>
 	<td>아이디</td>
 	<td class="idForm"> <input type="text" class="id" id="id" name="idd" placeholder="ID" required> </td>
 </tr>
 <tr>
 	<td>이름</td>
 	<td class="idForm"> <input type="text" class="id" id="name" name="name" placeholder="Name" required> </td>
 </tr>
 <tr>&nbsp</tr>
 <tr>
	<td>생년월일  </td>
		<td colspan="2"> <select name="birth" id="year" onchange="birthh()">
	<%for(int i=1900; i<2021; i++){ %>
				<option><%=i %></option>
				<%} %>
	       </select> 년 
	       
	<select name="month" id="mon" onchange="birthh()">
	<%for(int a=1; a < 13; a++){ %>
				<option><%=a %></option>
				<%} %>
	       </select> 월
	     
	       
	<select name="day" id="day" required>
	
	
	       </select> 일</td>
	</tr>
 <tr>
	<td>성별  </td>
		<td colspan="2"><input type="radio" name="gender" value="m" required>남자
	<input type="radio" name="gender" value="f" >여자 </td>
	</tr>
 <tr>
 	<td colspan="3"><input type="submit" class="btn" value="비밀번호 찾기"></td>
 
     
  </table>
    </form>
  <div style="margin-top: 30px; " class="loginForm"  >
  	<c:if test="${ requestScope.searchpw ne null }">
  	찾은 비밀번호 :  ${ requestScope.searchpw } <br>
  	<c:if test="${ requestScope.searchpw ne '아이디 없음' }">
  	<button style="margin-top: 10px; " onclick="openPw('${ requestScope.searchid }')" >비밀번호수정하기</button>  
  	</c:if>
  	<div style="margin-top: 20px; ">
  	<button type="button" onclick="location.href='/view/common/Login.jsp'" >로그인 화면</button>
  	<button type="button" onclick="location.href='/view/common/ID_Search.jsp'" >아이디 찾기</button>
  	</div>
  	</c:if>
  </div>
</body>
</html>