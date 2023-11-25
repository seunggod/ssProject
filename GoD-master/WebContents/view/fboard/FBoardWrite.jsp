<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.WriteForm { text-align: center; border: 1px solid black;}
	table {margin-right: auto; margin-left: auto; }
</style>
<link rel="stylesheet" href="../css/common.css" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<div style="height: 75px"></div>
<div class="home">
	<a href="/view/common/index.jsp" id="main"><img src="../img/home.png" style="width: 50px; height: 50px;"></a>
</div>
<h2 class="logintitle">글쓰기</h2>

<div>
<form action="fboard?cmd=FBoardWrite" method="post" class="WriteForm">
	<table>		
	<tr>
		<td>작성자</td>
		<td><input type="text" value="${ LoginId }" name="loginid" readonly="readonly"></td>
	</tr>
		<tr>
			<td>제목</td>
			<td><input type="text" name="writeTitle" required id="title" />
			</td>
		</tr>
		<tr>
			<td colspan="2"><textarea rows="12" cols="50"
					name="writeContent" required></textarea></td>
		</tr>
		<tr>
			<td align="center"><input type="submit" value="작성" class="button"></td>
			<td><input type="button" value="게시판으로 이동" onclick="location.href='fboard?cmd=FreeBoard&id=${ LoginId }?pagenum=1'"></td>
		</tr>
	</table>
</form>	
</div>

</body>
</html>
