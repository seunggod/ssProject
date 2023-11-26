<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독후감 공유 카페</title>
<link rel="stylesheet" href="/css/common.css"/>
<style>
  .idSearch { margin:50px auto; text-align: center; }
  b, h1 { color:orange; }
  #home { margin-top:10px; border: none; background: orange; width:300px; height:50px; }
</style>
<script>
  window.onload = function(){
	  var home = document.getElementById('home');
	  home.addEventListener('click',function(){
		  location.href="/";
	  })
  }
</script>
</head>
<body>
<%@ include file = "/WEB-INF/include/header.jsp" %>
<div class="idSearch">
 <h1>아이디/비밀번호 찾기</h1>
 <h2>${ result }</h2>
 <button id="home">확인</button>
 </div>
</body>
</html>