<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독후감 공유 카페</title>
<link rel="stylesheet" href="/css/common.css" />
<style>
body { margin:0;}
#homepage {	 background:orange; width:100%; height:1000px;}
#home_center { border:1px solid black;
			   background:white; 
			   color:orange;
			   margin:0 auto; 
			   text-align: center; 
			   font-size:50px; 
			   font-weight: bold;
			   padding:50px;}
#book_board_home { margin:5% 0 0 5%;  background: gray; width:30%; height:500px; float:left;}
#free_board_home {	margin-top:5%; background: yellow; width:30%; height:500px; float:left;}
#notice_board_home { margin-top:5%; background: red; width:30%; height:500px; float:left;}
.board { margin:30px auto; font-size:20px;  }
caption { font-size:30px; }
.board td { padding-right:10px; }
</style>
<script>

  window.onload = function(){
	  
	  //탈퇴 후 홈페이지로 돌아온 경우 알림 발생
	  if('${ withdrawal }'==1)
		  alert('탈퇴가 완료되었습니다');
	  
	  //게시판에 자료가 없을 경우 게시물이 없다는 글을 띄움
	  var board = document.querySelectorAll('.board');
	  var btr = document.querySelectorAll('#book tr');	  
	  var ftr = document.querySelectorAll('#free tr');	  
	  var ntr = document.querySelectorAll('#notice tr');	  
	  if( btr.length == 0 )
	  	board[0].innerHTML = '<tr><th rowspan="3">게시물이 없습니다</th></tr>'
	  if( ftr.length == 0 )
	  	board[1].innerHTML = '<tr><th rowspan="3">게시물이 없습니다</th></tr>'
	  if( ntr.length == 0 )
	  	board[2].innerHTML += '<tr><th rowspan="3">게시물이 없습니다</th></tr>'
	  
  }
</script>
</head>
<body>
<%@ include file="/WEB-INF/include/header.jsp" %>
<div id="homepage">
<div id="home_center">독후감&nbsp;공유&nbsp;카페&nbsp;</div>
<div id="book_board_home">
	<table class="board" id="book">
	  <caption><h3>후기게시판</h3></caption>
	<c:forEach var="book_board" items="${ BookBoard }">
	  <tr>
	    <td><a href="/BBoard/View/page/1/bno/${book_board.board_num}">${ book_board.board_title }</a></td><td>${ book_board.board_writer }</td><td> ${ book_board.regdate }</td>
	  </tr>
	</c:forEach> 
	</table>
</div>
<div id="free_board_home">
	<table class="board" id="free">
	  <caption><h3>자유게시판</h3></caption>
	<c:forEach var="free_board" items="${ FreeBoard }">
	  <tr>
		  <td><a href="/FBoard/View/page/1/bno/${free_board.board_num}">${ free_board.board_title }</a></td><td>${ free_board.board_writer }</td><td> ${ free_board.regdate }</td>
	  </tr>
	</c:forEach> 
	</table>
</div>
<div id="notice_board_home">
  <table class="board" id="notice">
	  <caption><h3>공지사항</h3></caption>
	<c:forEach var="notice_board" items="${ NoticeBoard }">
	  <tr>
		  <td><a href="/Notice/View/page/1/bno/${notice_board.notice_num}">${ notice_board.notice_title }</a></td><td>${ notice_board.notice_writer }</td><td> ${ notice_board.regdate }</td>
	  </tr>
	</c:forEach> 
  </table>
</div>
</div>
</body>
</html>