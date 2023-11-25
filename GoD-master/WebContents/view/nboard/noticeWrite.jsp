<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
//취소 누르면 List로 이동
var  btnCancle = document.getElementById('btnCancle');
btnCancle.onclick = function() {
	   
	   var  url       = '/nboard?cmd=nboardList';
	   location.href  = url;
}
</script>

<link rel="stylesheet" href="/css/nboard.css" />
</head>
<body>

		<div class="nb_header">
		<%@ include file="/view/common/header.jsp"%>
	</div>
	<form action="/nboard?cmd=nboardWriteInsert" method="post">

		<table class="nboard">
			<caption>공지사항</caption>
			<tr>
				<td>제목</td>
				<td><input type="text" name="nTitle" /></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${nboardVo.mem_nick}</td>

			</tr>
			<tr>
				<td>조회수</td>
				<td>${nboardvo.nb_cnt}</td>
			</tr>
			<tr>
				<td colspan="2"><textarea name="nCont"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" id="btnInsert"  value="등록"/>
					<button id="btnCancle"> 취소 </button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
