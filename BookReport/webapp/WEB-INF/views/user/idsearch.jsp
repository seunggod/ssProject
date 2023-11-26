<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독후감 공유 카페</title>
<link rel="stylesheet" href="/css/common.css" />
<style>
  table { margin:80px auto; width:350px; }
  th { width:20%; }
  caption h1 { color:orange;}
  #name { width:96%; height:30px; }
  .tel { width:29%; height:30px; }
  /* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}
input::placeholder { font-size: 15px;   }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
   $(function(){
	 $('#name').on('invalid',function(){
		 this.setCustomValidity('이름을 입력해주세요');
	 })
	 $('#name').on('input',function(){
		 this.setCustomValidity('');
	 })
	 $('#tel').on('invalid',function(){
		 this.setCustomValidity('전화번호를 입력해주세요');
	 })
	 $('#tel').on('input',function(){
		 this.setCustomValidity('');
	 })
	   
   })
</script>
</head>
<body>
  <%@ include file="/WEB-INF/include/header.jsp" %>
  <form action="/User/IdSearch" method="POST">
  <table>
    <caption><h1>아이디 찾기</h1></caption>
    <tr>
      <th>이름</th>
      <td><input type="text" id="name" name="name" placeholder="이 름" required/></td>
    </tr>
    <tr>
      <th>전화번호</th>
      <td><input type="number" class="tel" name="tel1"  required/>-
      <input type="number" class="tel" name="tel2"  required/>-
      <input type="number" class="tel" name="tel3"  required/></td>
    </tr>
    <tr>
      <td colspan="2"><input type="submit" id="submit" value="아이디 찾기"/></td>
    </tr>
  </table>
  </form>
</body>
</html>