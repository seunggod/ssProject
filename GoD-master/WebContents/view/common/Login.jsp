<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../css/common.css"/>
<style>
.login_bottom {text-decoration: none; color: #a68f8e;}
</style>
<meta charset="UTF-8">
<title>로그인 화면</title>
<link rel="icon" href="/img/favicon.ico" type="image/x-icon" sizes="16x16">
</head>
<body>
<%@ include file="header.jsp" %>
<div style="height: 75px"></div>

<div class="home">
	<a href="../common/index.jsp" id="main"><img src="/img/home.png" style="width: 50px; height: 50px;"></a>
</div>
<h2 class="logintitle">로그인</h2>



<form action="/mboard?cmd=Login" method="post" class="loginForm">
	
 <table class="logintable">
 
 
 <tr>
 	<td colspan="3" class="idForm"> <input type="text" class="id" name="id" placeholder="ID" required> </td>
 </tr>
 <tr>
 	<td colspan="3" class="pwdForm"><input type="password" class="pw" name="pwd" placeholder="PW" required></td>
 </tr>
 <tr>
 	<td colspan="3"><input type="submit" class="btn" value="로그인"></td>
 </tr>
 <tr>
 	<td colspan="3" style="color: #a68f8e; padding: 20px 0px; ">----------- 계정 만들기 -----------</td>
 </tr>
 <tr>
 	<td class="bottomText"> <a class="login_bottom" href="Create.jsp">회원가입</a></td>
 	<td class="bottomText"> <a class="login_bottom" href="ID_Search.jsp">아이디 찾기</a> </td>
 	<td class="bottomText"> <a class="login_bottom" href="PW_Search.jsp">비밀번호 찾기</a> </td>
 </tr>
 <tr>
 </tr>
     
  </table>
    </form>
<div style="text-align: center;">
<% 
    String msg = request.getParameter("msg");
	if( msg!=null && msg.equals("0") ){
		out.print("<h2>비밀번호가 틀렸습니다<h2>");
	}else if( msg!=null && msg.equals("-1") ){
		out.print("<h2>아이디가 틀렸습니다<h2>");
	}

%>
</div>   
</body>
</html>
