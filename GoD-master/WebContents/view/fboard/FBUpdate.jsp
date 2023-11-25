<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script type="text/javascript">
	function move() {
		//var cont = $('#tarea').val();
		//request.setAttribute("cont",cont);
		//location.href = '/fboard?cmd=FBCUpdate&id=${ param.id }&fbcnum=${ param.fbcnum }&fbnum=${ param.fbnum }&cont='+cont;
		//opener.location.reload();
		//window.self.close();
	}
</script>
</head>
<body>
<div style="width: 400px; background-color : #F8F8F8; padding : 10px; margin-left: auto; margin-right: auto; margin-top: 40px;
	 margin-bottom: 20px; ">
		<form action="/fboard?cmd=FBUpdate&fbnum=${ param.fbnum }" method="post" >
		게시글 수정
		<table style="margin-top: 30px; margin-left: 10px;">		
		<tr>
			<td>제목</td>
			<td ><input type="text" name="writeTitle" value="${ param.title }" id="title" /></td>
		</tr>
		<tr>
			<td colspan="3"><textarea rows="12" cols="50" name="writeContent"  >${ param.cont }</textarea></td>
		</tr>
		<tr>
			<td colspan="3" align="center" >
				<div style="display: flex; justify-content: flex-end;">
					<input  type="submit" value="수정" class="button">
				</div>
			</td>
		</tr>
	</table>
		</form>
		</div>

</body>
</html>