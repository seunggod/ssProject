<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/common.css"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file = "/view/common/header.jsp" %>

<div id="maintbBox">
<h2 id="tripreq">여행지 추천</h2><a href="/tboard?cmd=TBOARDLISTFORM">더보기</a>
<c:forEach var="tboardVo" items="${ tboardList }">
<div id="tboardBox">
	<div id="tbimgbox"><a href="/tboard?cmd=READBOARDCONT&boardNum=${ tboardVo.tbNum }">
	<img src="/uploadFiles/${ tboardVo.img1 }"></img></a></div>
	<div id="mlistcont">
	<p>${ tboardVo.title } - ${ tboardVo.nickName }</p>
	<p>주소:${ tboardVo.addr }</p>
	<p>조회수:${ tboardVo.readCnt } 추천수:${ tboardVo.likeCnt } </p>
	<p>작성일:${ tboardVo.wDate }</p>
	</div>
</div>
</c:forEach>
<%-- <div id="tboardBox">
	<div id="tbimgbox"><a href="/tboard?cmd=READBOARDCONT&boardNum=${ boardVo.tbNum }">
	<img src="/uploadFiles/2.jpg"></img></a></div>
	<div id="mlistcont">
	<p>아름다운 풍경을 찾아서 - 영그니</p>
	<p>주소:동작시 서울구 삼만동 11-2</p>
	<p>조회수:1100 추천수:23 </p>
	<p>작성일:2021.01.23 13:00</p>
	</div>
</div> --%>
</div>
<!-- 공지사항 칸 -->
<div id="mainnBox" class="mBox">
<h2 id="tripreq">공지사항</h2><a href="/nboard?cmd=nboardList">더보기</a>
<c:forEach var="nboardVo" items="${ nboardList }">
<div id="nboardBox">
	<div id="nlistcont">
	<p><a href="">${ nboardVo.nb_title }</a></p>
	<p>${ nboardVo.nb_date }</p>
	</div>
</div>
</c:forEach>
<!-- <div id="nboardBox">
	<div id="nlistcont">
	<p><a href="">천지연 관광 일정에 관하여</a></p>
	<p>2021.01.23 13:00</p>
	</div>
</div> -->

</div>
<!-- 자유 게시판 -->
<div id="mainfBox" class="mBox">
<h2 id="tripreq">자유게시판</h2><a href="/fboard?cmd=FreeBoard">더보기</a>
<c:forEach var="fboardVo" items="${ fboardList }">
<div id="fboardBox">
	<div id="flistcont">
	<p><a href="">${ fboardVo.title }</a></p>
	<p>${ fboardVo.nick }</p>
	<p>${ fboardVo.date }</p>
	</div>
</div>
</c:forEach>
<!-- <div id="fboardBox">
	<div id="flistcont">
	<p><a href="">천지연 관광 일정에 관하여</a></p>
	<p>작성자:영그니</p>
	<p>2021.01.23 13:00</p>
	</div>
</div> -->




</div>
<%@include file = "/view/common/footer.jsp" %>
</body>
</html>
