<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/common.css"/>
<style>
</style>
<meta charset="UTF-8">
<title>G.O.D</title>
<link rel="icon" href="/img/favicon.ico" type="image/x-icon" sizes="16x16">
</head>
<script>
	window.onload = function () {
		function login() {
			alert("로그인");
		}
	}
</script>
<body id="background">
<%@include file = "header.jsp" %>

 <div id="header"></div> 
<% if(session.getAttribute("LoginId") == null ) { %>
<div id="b_div">
	
	<button onClick="location.href='/index?cmd=GOMAINACTION"><b>둘러보기</b></button>
	<button onClick="location.href='Login.jsp'"><b>로그인</b></button>
	<button onClick="location.href='Create.jsp'"><b>회원가입</b></button>
	
</div>
<% }else{ %>
    <div id="b_div" class="login">
	<a href="" id="info"><img alt="내정보"  src="img/UserIcon.png"> &nbsp <b><%= session.getAttribute("LoginNick") %>님</b></a> &nbsp
		<button onClick="location.href='tboard?cmd=LoginOut'">로그아웃</button>
	</div> 
<% } %>

<div id="search" >
	원하는 여행지를 검색하세요 !!  ▶ &nbsp;&nbsp; <input type="text" class="findtext">
	<button id="b_search">검색</button>
</div>
	

<%@include file = "footer.jsp" %>

</body>
</html>
