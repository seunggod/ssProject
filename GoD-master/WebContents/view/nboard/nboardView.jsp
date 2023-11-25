<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/css/nboard.css" />
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
function report(){

	var pop = window.open('/nboard?cmd=nboardReportForm&mem_nick=${nboardView.mem_nick}&nb_num=${nboardView.nb_num}&nb_title=${nboardView.nb_title}', 'window팝업', 'width=500, height=500, scrollbar=yes');

}
</script>

</head>
<body>

	<div class="nb_header">
		<%@ include file="/view/common/header.jsp"%>
	</div>

	<table class="nboard">
		<tr>
			<td>제목</td>
			<td>${nboardView.nb_title}</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${nb_nick}</td>
		</tr>
		<tr>
			<td>조회수</td>
			<td>${nboardView.nb_cnt }</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td>${nboardView.nb_date }</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${nboardView.nb_cont }</td>
		</tr>

		<%
		String nb_nick = (String) request.getAttribute("nb_nick");
		String loginnick = (String) request.getAttribute("nick");
		if (nb_nick.equals(loginnick)) {
		%>

		<tr>
			<td><a
				href="/nboard?cmd=nboardUpdateForm&mem_nick=${nb_nick}&nb_num=${nboardView.nb_num}&nb_title=${nboardView.nb_title}&nb_cont=${nboardView.nb_cont}">수정</a>
			</td>
			<td><a
				href="/nboard?cmd=nboardDelete&mem_nick=${nb_nick}&nb_num=${nboardView.nb_num}">삭제</a>
			</td>

		</tr>
		<%
		}
		%>
	</table>
	
	<% if (loginnick!=null) {%>

	<a href="#none" target="_blank" onclick="report()">신고</a>
	
	<%} %>

</body>
</html>
