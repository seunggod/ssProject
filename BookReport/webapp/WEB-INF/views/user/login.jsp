<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독후감 공유 카페</title>
<link rel="stylesheet" href="/css/common.css" />
<style>
 .login { display:block; 
          width:800px;
          height:800px;
          margin:60px auto;
          text-align:center; }
 .login h1 { color:orange; font-size:50px; }
 .login p { font-size: 12px; color:red; }
 input:nth-of-type(1), input:nth-of-type(2) { width:350px; height:50px; font-size: 20px;}
 input:nth-of-type(2) { margin-bottom: 20px; }
 input::placeholder { padding:10px; color:lightgray; }
 .login a { margin:5px; text-decoration: none; color:gray; }

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(function(){
	  
	  //비밀번호 변경 후 입장 시
	  if('${pwdchange}'==1)
		  alert('비밀번호가 변경되었습니다');
	  
	  //아이디가 ''거나 공백을 포함 시
	  $('#userid').on('invalid',function(){
		  this.setCustomValidity('아이디를 입력해주세요');
	  })
	  
	  //아이디가 입력된 경우에는 메시지를 비울 것
	  $('#userid').on('input',function(){
		  this.setCustomValidity('');
	  })
	  
	  //비밀번호가 ''거나 공백을 포함 시
	  $('#userpwd').on('invalid',function(){
		  this.setCustomValidity('비밀번호를 입력해주세요');
	  })
	  
	  //아이디가 입력된 경우에는 메시지를 비울 것
	  $('#userpwd').on('input',function(){
		  this.setCustomValidity('');
	  })
	  
  })
</script>
</head>
<body>
  <%@ include file="/WEB-INF/include/header.jsp" %>
  <div class="login">
  <h1>로그인</h1>
   <p>${ msg }</p>
  <form action="/User/Login" method="post">
   <input type="text" id="userid" name="userid" placeholder="아이디" required/><br/>
   <input type="password" id="userpwd" name="userpwd" placeholder="비밀번호" required/><br/>
   <a href="/User/IdSearchForm" id="idsearch">아이디 찾기</a>
   <span class="bar">|</span>
   <a href="/User/PwdSearchForm" id="pwdsearch">비밀번호 찾기</a><br/>
   <input type="submit" id="submit" value="로그인"/> <br/>
  </form>
  </div>
</body>
</html>