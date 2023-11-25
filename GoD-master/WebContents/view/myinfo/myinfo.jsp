<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<link rel="stylesheet" href="/css/common.css" />
<meta charset="UTF-8">
</head>
<body>
<%@ include file="/view/common/header.jsp" %>
	<div style="text-align:center; border:solid 1px;">
	<h2 >내 정보</h2>
	<table>
		<tr>
			<td>이름</td>
			<td>${myinfo.mem_name}</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td>${myinfo.mem_id}</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>${myinfo.mem_gender}</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>${myinfo.mem_addr}</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>${myinfo.mem_tel}</td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td>${myinfo.mem_birth}</td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td>${myinfo.mem_nick}</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>${myinfo.mem_email}</td>
		</tr>
	</table>
</div>
	<hr>
	<h2>내가 쓴 글</h2>
	<button>수정</button>
	<button>삭제</button>

	<hr>
	<h2>내가 추천한 글</h2>
</body>
</html>