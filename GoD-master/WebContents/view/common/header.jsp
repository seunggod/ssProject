<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../../css/common.css" />

<script>
function enter() {
    var search = $('#input_search').val();
    location.href="fboard?cmd=FBoardSearch&keyword=1&searchKeyword=" + search+"&searchCondition=Title";
}
	window.onload = function () {
		$('#info').click( function() {
			alert("내정보");
		});
		
		$('#btn_search').click( function() {
		if($('#div_search').css('display') == 'none'){
			$('#div_search').css('display', 'flex');
		}else {
			$('#div_search').css('display', 'none');
		}
		});
	}
</script>

<body style="margin:0;"> <!-- body 기본 마진 때문에 넣었습니다. 여백이 생김 , 여백없이 만들려고 body 넣음  -->
<header class="headerBody">
<div class="headerTop">

<div style="display :flex;  width: 100vw; height :50px;  text-align: center; position: relative; z-index: 2">
<div id="div_search">
    <div style="display:inline; text-align: center;"><a href="www.naver.com" id="ent"><img src="../../img/whitem2.png"></a></div>
	<div><input type="text" id="input_search" size="19" onkeyup="if(window.event.keyCode==13){enter()}"  placeholder="                              검색"></div>
</div>
	
	<!-- 제목 -->
	<div class="mainTitle"><a href="/view/common/index.jsp"><img alt="" src="/img/logo2.png" style="width: 120px; height: 35px; margin-left: 15px; padding-top: 9px;"> </a><small style=" display :block;    font-size:0.6rem;
  line-height:1em;"></small></div>
	
	<!-- 메뉴 -->
	<div class="headerUl">
		<ul>
			<li><a href="/tboard?cmd=TBOARDLISTFORM&id=${ LoginId }">여행지 추천</a></li>
			<li><a href="/fboard?cmd=FreeBoard&pagenum=1&sort=&pagesize=10개">자유게시판</a></li>
			<li><a href="/nboard?cmd=nboardList&id=${LoginId }">공지사항</a></li>
		</ul>
	</div>
	
	<!-- 로그인,검색 -->
	<% if(session.getAttribute("LoginId") == null ) { %>
<div class="headerButtons">
		<input type="image" id="btn_search" alt="" src="/img/whitem2.png">
		<button onClick="location.href='/view/common/Login.jsp'" class="login_btn">로그인</button>
		<button onClick="location.href='/view/common/Create.jsp'">회원가입</button>
	</div>

<% }else{ %>
    <div id="b_div" class="login">
		<input type="image" id="btn_search" alt="" src="/img/whitem2.png" >
	<a class="a_home" href="/mboard?cmd=getMemInfo" id="info"><img alt="내정보"  src="/img/UserIcon.png" style="width: 30px;"> &nbsp <b> ${ sessionScope.LoginNick }님 </b></a> &nbsp
		&nbsp<button onClick="location.href='/mboard?cmd=LoginOut'">로그아웃</button>
	</div> 
<% } %>

	
	
	
  </div>
	</div>
</header>
</body>
