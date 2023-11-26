<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta charset="UTF-8">
<style>
  #logout { display:none; }
   .navigation .menu     { margin-right:13%;
                       text-decoration:none;
                       font-size:30px;
                       font-weight: bold;
                       color: orange; }
   .navigation button { float:right;
                        margin-right: 20px; margin-top:15px;
                        border:none;
                        background-color: orange;
                        border-radius:5px; }
   .navigation button:hover { cursor:pointer; }
   .navigation       { margin:0 auto;
                       border: 1px solid black;
                       height:50px;
                       background-color: black;}
   #loginNick         { display:none;
                       text-decoration: none;
                       float: right;
                       margin-top:15px;
                       margin-right:20px;
                       color: blue;
                       font-weight: bold;
                         }
  
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(function(){
	  //로그인 창 이동
	  $('#login').on('click',function(){
		  let href= '/User/LoginForm';
		  location.href=href;
	  })
	  //회원가입 창 이동
	  $('#join').on('click',function(){
		  let href='/User/JoinForm';
		  location.href=href;
	  })
	  
	  
	  if('${ login.mem_id }'!=''){
		 $('#login').css('display','none');
		 $('#join').css('display','none');
		 $('#logout').css('display','inline');
		 $('#loginNick').css('display','inline');
	  }
	  
	  $('#logout').on('click',function(){
		  if(confirm('로그아웃하시겠습니까?')){
		  	location.href="/User/Logout";  
		  }
	  })
	  
  })

</script>
  <div class="navigation">
    <a class="menu" href="/">HOME</a>
    <a class="menu" href="/BBoard/page/1">후기게시판</a>
    <a class="menu" href="/FBoard/page/1">자유게시판</a>
    <a class="menu" href="/Notice/page/1">공지사항</a>
    
    <button id="join">회원가입</button>
    <button id="login">로그인</button>
    <button id="logout">로그아웃</button>
    <a id="loginNick" href="/User/Profile?upCheck=false">${ login.nickname }&nbsp;님</a>
  </div>