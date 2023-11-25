<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
function btnSubmit(){

	
	window.opener.name="nboardView";
	document.report.target="nboardView";
	document.report.action="/nboard?cmd=nboardReport&mem_nick=${rp_vo.mem_nick }&nb_num=${rp_vo.nb_num}&nb_title=${rp_vo.nb_title}";
	document.report.submit();
	self.close();
}
</script>
</head>
<body>
	<form id="report" name="report" action="/nboard?cmd=nboardReport&mem_nick=${rp_vo.mem_nick }&nb_num=${rp_vo.nb_num}&nb_title=${rp_vo.nb_title}"method="post">
		<table>
			<caption>${rp_vo.nb_title } 게시글 신고하기</caption>
			<tr>
				<td>게시글 번호 : ${rp_vo.nb_num }</td>
			</tr>
			<tr>
				<td>작성자 :${rp_vo.mem_nick } </td>
			</tr>
			<tr>
				<td>신고사유</td>
				<td><textarea style="width: 350px; height: 400px;" name="rp_cont"></textarea></td>
			</tr>
			<tr>
			<td><input type="button" value="신고하기" onclick="javascript:btnSubmit();"/></td>
			</tr>
		</table>
		
	</form>
</body>
</html>
