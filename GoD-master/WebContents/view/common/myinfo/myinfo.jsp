<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="prj.trip.member.vo.*" %>

<%
MemberVo vo = new MemberVo();
%>

<!DOCTYPE html>
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
			<td><%=vo.getMem_name()%></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><%= vo.getMem_id()%></td>
		</tr>
		<tr>
			<td>성별</td>
			<td><%= vo.getMem_gender()%></td>
		</tr>
		<tr>
			<td>주소</td>
			<td><%= vo.getMem_addr()%></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><%= vo.getMem_id()%></td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td><%= vo.getMem_birth()%></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><%= vo.getMem_nick()%></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><%= vo.getMem_email()%></td>
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