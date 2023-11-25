<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	
	.page {
	text-align:center;
	font-size:0; margin-top: 20px;
 }
.page_nation {
	display:inline-block;
}
.page_nation .none {
	display:none;
}
.page_nation a {
	display:block;
	margin:0 3px;
	float:left;
	border:1px solid #e6e6e6;
	width:28px;
	height:28px;
	line-height:28px;
	text-align:center;
	background-color:#fff;
	font-size:13px;
	color:#999999;
	text-decoration:none;
}
.page_nation .arrow {
	border:1px solid #ccc;
}
.page_nation .first {
	background:#f8f8f8 url('img/page_pprev.png') no-repeat center center;
	margin-left:0;
}
.page_nation .prev {
	background:#f8f8f8 url('img/page_prev.png') no-repeat center center;
	margin-right:7px;
}
.page_nation .next {
	background:#f8f8f8 url('img/page_next.png') no-repeat center center;
	margin-left:7px;
}
.page_nation .last {
	background:#f8f8f8 url('img/page_nnext.png') no-repeat center center;
	margin-right:0;
}
.page_nation a.choice:hover {
	background-color:#42454c;
	color:#fff;
	border:1px solid #42454c;
}


</style>
<link rel="stylesheet" href="css/common.css" />

<% if(request.getParameter("sort") == null || request.getParameter("pagesize") == null) { %>
<div class="page">
  <div class="page_nation">
    <a href="fboard?cmd=FreeBoard&pagenum=${param.firstPageNo}" class="first" style="display: inline;"></a>
    <a href="fboard?cmd=FreeBoard&pagenum=${param.prevPageNo}" class="prev" style="display: inline;"></a>
    <span>
        <c:forEach var="i" begin="${param.startPageNo}" end="${param.endPageNo}" step="1">
            <c:choose>
                <c:when test="${i eq param.pageNo}"><a href="fboard?cmd=FreeBoard&pagenum=${ i }" class="choice" style="display: inline;">${i}</a></c:when>
                <c:otherwise><a href="fboard?cmd=FreeBoard&pagenum=${ i }" class="choice" style="display: inline;">${i}</a></c:otherwise>
            </c:choose>
        </c:forEach>
    </span>
    <a href="fboard?cmd=FreeBoard&pagenum=${param.nextPageNo}" class="next" style="display: inline;"></a>
    <a href="fboard?cmd=FreeBoard&pagenum=${param.finalPageNo}" class="last" style="display: inline;"></a>
  </div>  
  <div style="display: inline-block; float:right; "> <button onclick="location.href='fboard?cmd=FBoardWriter'" style="width:60; height: 30px; margin-right: 45px;">글쓰기</button></div>
</div>

<% }else if(session.getAttribute("LoginId") == null || request.getParameter("keyword") == null) { %>
<div class="page">
  <div class="page_nation">
    <a href="fboard?cmd=FreeBoard&pagenum=${param.firstPageNo}&sort=${ param.sort }&pagesize=${ param.pagesize }" class="first" style="display: inline;"></a>
    <a href="fboard?cmd=FreeBoard&pagenum=${param.prevPageNo}&sort=${ param.sort }&pagesize=${ param.pagesize }" class="prev" style="display: inline;"></a>
    <span>
        <c:forEach var="i" begin="${param.startPageNo}" end="${param.endPageNo}" step="1">
            <c:choose>
                <c:when test="${i eq param.pageNo}"><a href="fboard?cmd=FreeBoard&pagenum=${ i }&sort=${ param.sort }&pagesize=${ param.pagesize }" class="choice" style="display: inline;">${i}</a></c:when>
                <c:otherwise><a href="fboard?cmd=FreeBoard&pagenum=${ i }&sort=${ param.sort }&pagesize=${ param.pagesize }" class="choice" style="display: inline;">${i}</a></c:otherwise>
            </c:choose>
        </c:forEach>
    </span>
    <a href="fboard?cmd=FreeBoard&pagenum=${param.nextPageNo}&sort=${ param.sort }&pagesize=${ param.pagesize }" class="next" style="display: inline;"></a>
    <a href="fboard?cmd=FreeBoard&pagenum=${param.finalPageNo}&sort=${ param.sort }&pagesize=${ param.pagesize }" class="last" style="display: inline;"></a>
  </div>  
  <div style="display: inline-block; float:right; "> <button onclick="location.href='fboard?cmd=FBoardWriter'" style="width:60; height: 30px; margin-right: 45px;">글쓰기</button></div>
</div>
<% }else{ %>
<div class="page">
  <div class="page_nation">
    <a href="fboard?cmd=FBoardSearch&pagenum=${param.firstPageNo}&main=${ param.main }&keyword=${ param.Keyword }" class="first" style="display: inline;"></a>
    <a href="fboard?cmd=FBoardSearch&pagenum=${param.prevPageNo}&main=${ param.main }&keyword=${ param.Keyword }" class="prev" style="display: inline;"></a>
    <span>
        <c:forEach var="i" begin="${param.startPageNo}" end="${param.endPageNo}" step="1">
            <c:choose>
                <c:when test="${i eq param.pageNo}"><a href="fboard?cmd=FBoardSearch&pagenum=${ i }&main=${ param.main }&keyword=${ param.Keyword }" class="choice" style="display: inline;">${i}</a></c:when>
                <c:otherwise><a href="fboard?cmd=FBoardSearch&pagenum=${ i }&main=${ param.main }&keyword=${ param.Keyword }" class="choice" style="display: inline;">${i}</a></c:otherwise>
            </c:choose>
        </c:forEach>
    </span>
    <a href="fboard?cmd=FBoardSearch&pagenum=${param.nextPageNo}&main=${ param.main }&keyword=${ param.Keyword }" class="next" style="display: inline;"></a>
    <a href="fboard?cmd=FBoardSearch&pagenum=${param.finalPageNo}&main=${ param.main }&keyword=${ param.Keyword }" class="last" style="display: inline;"></a>
  </div>  
  <div style="display: inline-block; float:right; "> <button onclick="location.href='fboard?cmd=FBoardWriter'" style="width:60; height: 30px; margin-right: 45px;">글쓰기</button></div>
</div>
<% } %>

<c:if test="${ searchcount ne null}">
<div>
검색${ param.main } :  ${param.Keyword } | 검색결과 : ${ searchcount } 개
</div>
</c:if>
