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
 .pwdChange { display:block; 
          width:800px;
          height:800px;
          margin:60px auto;
          text-align:center; }
 .pwdChange h1 { color:orange; font-size:50px; }
 .pwdChange p { font-size: 12px; color:red; }
 .userpwd { width:350px; height:50px; font-size: 30px;}
 input:nth-of-type(3) { margin-bottom: 20px; }
 input::placeholder { padding:10px; color:lightgray; font-size:15px; }
 .pwdChange a { margin:5px; text-decoration: none; color:gray; }

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(function(){
	  
	  //아이디가 ''거나 공백을 포함 시
	  $('#userpwd').on('invalid',function(){
		  this.setCustomValidity('비밀번호를 입력해주세요');
	  })
	  
	  //아이디가 입력된 경우에는 메시지를 비울 것
	  $('#userpwd').on('input',function(){
		  this.setCustomValidity('');
	  })
	  
	  //비밀번호가 ''거나 공백을 포함 시
	  $('#userpwd2').on('invalid',function(){
		  this.setCustomValidity('비밀번호 확인을 입력해주세요');
	  })
	  
	  //아이디가 입력된 경우에는 메시지를 비울 것
	  $('#userpwd2').on('input',function(){
		  this.setCustomValidity('');
	  })
	  
	
	  
	  
	  $('form').on('submit',()=>{
		  if($('#userpwd').val() != $('#userpwd2').val()){
			  alert('비밀번호가 불일치합니다')
			  return false;
		  }
	  })
	  
  })
</script>
</head>
<body>
  <%@ include file="/WEB-INF/include/header.jsp" %>
  <div class="pwdChange">
  <h1>비밀번호 변경</h1>
  <form action="/User/PwdChange" method="post">
   <input type="hidden" name="userid" value="${ userid }"/>
   <input type="password" class="userpwd" id="userpwd" name="userpwd" placeholder="영문 대소문자,숫자,특수문자 포함 8~12자" required/><br/>
   <input type="password" class="userpwd" id="userpwd2" placeholder="비밀번호 확인" required/><br/>
   <input type="submit" id="submit" value="비밀번호 변경"/> <br/>
  </form>
  </div>
</body>
</html>