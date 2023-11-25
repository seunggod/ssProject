<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>댓글 수정</title>
<script type="text/javascript">
	function move() {
		//var cont = $('#tarea').val();
		//request.setAttribute("cont",cont);
		//location.href = '/fboard?cmd=FBCUpdate&id=${ param.id }&fbcnum=${ param.fbcnum }&fbnum=${ param.fbnum }&cont='+cont;
		opener.location.reload();
		window.self.close();
	}
	///fboard?cmd=FBCUpdate&id=${ param.id }&fbcnum=${ param.fbcnum }&fbnum=${ param.fbnum }
</script>
</head>
<body>
<div style="width: 400px; background-color : #F8F8F8; padding : 10px; margin-left: auto; margin-right: auto; margin-top: 40px;
	 margin-bottom: 20px; ">
		<form action="/fboard?cmd=FBCUpdate&id=${ param.id }&fbcnum=${ param.fbcnum }&fbnum=${ param.fbnum }" method="post" >
		댓글수정
		<div> &nbsp</div>
		<textarea id="tarea" rows="7" cols="53" name="cont" placeholder="고운말 부탁드려요" ></textarea>
		<div style="display: flex; justify-content: flex-end;">
		<input type="submit" value="수정하기" >
		</div>
		</form>
		
	</div>
</body>
</html>