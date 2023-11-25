<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/nboard.css" />
</head>
<body>
		<div class="nb_header">
		<%@ include file="/view/common/header.jsp"%>
	</div>
	
	<form action="/nboard?cmd=nboardUpdate&nb_num=${nbUpdate.nb_num}"
		method="post">
		
			<table class="nboard">
				<caption>공지사항</caption>
				<tr>
					<th>제목</th>
					<td><input type="text" name="nb_title" id="nb_title" value="${nbUpdate.nb_title}"/></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${nbUpdate.mem_nick}</td>
				</tr>
				<tr>
					<td colspan="2" ><textarea name="nb_cont" id="nb_cont">${nbUpdate.nb_cont}</textarea></td>
				</tr>
				<tr>
				
					<td>
					<input type="submit" value="수정"/>
					</td>
					<td><a href="/nboard?cmd=nboardList">취소</a></td>
				</tr>
			</table>
	</form>
</body>
</html>
