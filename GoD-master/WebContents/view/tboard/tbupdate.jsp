<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/tboard.css" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
  // img태그에 이미지를 넣어 미리보기
  function changeImage(inImage,tagaddr){
	  if ( /\.(jpe?g|png|gif)$/i.test( inImage.name ) ) { //확장자 체크(이미지 인가)
			let reader = new FileReader();
	        reader.onload = function() {
	        	 
	   	      
	   		 	 tagaddr.src = this.result; // 지정해 파일 완성
  			}
	        if( inImage ) {
	            // readAsDataURL( )을 통해 파일의 URL을 읽어온다
	            reader.readAsDataURL( inImage );
	        }
	  }
  }
  //textarea size조절 함수
  function resize(obj) {
	  obj.style.height = "300px";
	  obj.style.height = (12+obj.scrollHeight)+"px";
	  }
  function resize2(obj) {
	  obj.style.height = "100px";
	  obj.style.height = (12+obj.scrollHeight)+"px";
	  }
  function clearImg2() {
	  $("#image2").val("");
	  $('#img2').removeAttr('src'); // src 삭제
	  //$('#img2').attr('src',''); 이건 src 변경
  }
  function clearImg3() {
	  $("#image3").val("");
	  $('#img3').removeAttr('src'); // src 삭제
	  //$('#img2').attr('src',''); 이건 src 변경
  }
  function backPage(){
	  location.href='/tboard?cmd=READBOARDCONT&boardNum='+${ tboardVo.tbNum };
	  
  }
  $(function(){
	  	//불러왔을때 textarea사이즈의 부드러운 증가
	 	 setTimeout(function() {resize($("#cont")[0]); },1000);
	 	 setTimeout(function() {resize2($(".bucont")[0]); },1000);	  	
	 	 setTimeout(function() {resize2($(".bucont")[1]); },1000);	  	
	 	 setTimeout(function() {resize2($(".bucont")[2]); },1000);	  	
	 	//textarea 자동 크기 증가 + 총합 글자 1000자 이내 유지
		$('.bucont').on('keyup',function(e){
			$(this).css('height', '100' );
			$(this).height(this.scrollHeight);
			var bucont = document.getElementsByClassName('bucont');
			bucont[1].maxLength = bucont[0].maxLength - bucont[0].textLength;
			bucont[2].maxLength = bucont[1].maxLength - bucont[1].textLength;
		});
	 	//textarea 자동 크기 증가  + 총합 글자 1000자 이내 유지
		$('#cont').on('keyup',function(e){
			$(this).css('height', '300' );
			$(this).height(this.scrollHeight);
			var cont = document.getElementById('cont');
			var bucont = document.getElementsByClassName('bucont');
			console.dir(cont);
			bucont[0].maxLength = 1000-cont.textLength;
		});
		
		
		
 		 //이미지를 누르면 첨부 input이 기능함
	  	$('#mimg').on('click',function(){
	  		$('#mimage').click();
	  		return false;
	  	})
	  	$('#img1').on('click',function(){
	  		$('#image1').click();
	  		return false;
	  	})
	  	$('#img2').on('click',function(){
	  		$('#image2').click();
	  		return false;
	  	})
	  	$('#img3').on('click',function(){
	  		$('#image3').click();
	  		return false;
	  	})
	    // 이미지 삽입
	  	$('#mimage').on('change',function(e){
	  		let mainimage = document.getElementById('mimage').files[0];
	  		let mimg      = document.getElementById('mimg');
	  		
	  		 changeImage(mainimage,mimg);
			 return false;
	  		
	  	});
		$('#image1').on('change',function(e){
			let inImage = document.getElementById('image1').files[0]; //이미지 파일들을 찾음
			let img1 = document.getElementById( "img1" );
			
			changeImage(inImage,img1);
			return false;
		});
		$('#image2').on('change',function(e){
			 let inImage = document.getElementById('image2').files[0];
			 let img2 = document.getElementById('img2');
			  		  
			 changeImage(inImage,img2);
			 return false;
		});
		$('#image3').on('change',function(e){
			 let inImage = document.getElementById('image3').files[0];
			 let img3 = document.getElementById('img3');
			 
			 changeImage(inImage,img3);
			 return false;
		});
	
		
			

  }) //function의 끝
</script>
</head>
<body>
	<%@include file ="/view/common/header.jsp" %>
	<form action="/tboard?cmd=TBOARDUPDATEACTION" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="tbNum" value="${ tboardVo.tbNum }"/>
	<table class="tboard">
	<caption>여행지 추천 수정</caption>
	<tr>
	<tr>
	<td id="mainimage" rowspan="4">
	<input type="file" id="mimage" name="mainimage" accept="image/*" />
	<img id="mimg"  src="/uploadFiles/${ tboardVo.img1 }"></img></td>
	<td id="input"><p>NO:<input type="text" name="tbNum" value="${ tboardVo.tbNum }"/></p>
		제목<br><input type="text" name="title" placeholder="제목 입력" value="${ tboardVo.title }"/></td>
	</tr>
	<tr>
	<td id="input">작성자<br><input type="text" value="${ LoginId }" disabled/></td>
	</tr>
	<tr>
	<td id="input">주소<br><input type="text" name="addr" placeholder="주소 입력" value="${ tboardVo.addr }" /></td>
	</tr>
	<tr>
	<td id="input"><p>조회수:${ tboardVo.readCnt }</p><p id="likeCnt">추천수:${ tboardVo.likeCnt }</p></td>
	</tr>
	<tr>
	<td colspan="2" id="contbox">
	<div id="content"><textarea id="cont"  name="bcont1" maxlength="1000" placeholder="내용 입력">${ tboardVo.cont }</textarea><br>
		<div id="imagebox">
		<input type="file" id="image1" name="imageOne" accept="image/*" />
		<img id="img1"  src="/uploadFiles/${ tboardVo.img2 }"></img></div>
		<textarea class="bucont" name="bcont2" id="bcont2" placeholder="내용 입력">${ tboardVo.cont2 }</textarea><br>
		<div id="imagebox">
		<input type="file" id="image2" name="imageTwo" accept="image/*" />
		<img id="img2"  src="/uploadFiles/${ tboardVo.img3 }"></img></div>
		<button id="clear2" type="button" onclick="clearImg2()">이미지 제거</button>
		<textarea class="bucont" name="bcont3" id="bcont3" placeholder="내용 입력">${ tboardVo.cont3 }</textarea><br>
		<div id="imagebox">
		<input type="file" id="image3" name="imageThree" accept="image/*" />
		<img id="img3"  src="/uploadFiles/${ tboardVo.img4 }"></img></div>
		<button id="clear3" type="button" onclick="clearImg3()">이미지 제거</button>
		<textarea class="bucont" name="bcont4" id="bcont4" placeholder="내용 입력">${ tboardVo.cont4 }</textarea><br>
	</div>
	</td>
	</tr>
	<tr>
	<td colspan="2" class="submit"><button type="button" onclick="backPage()" id="before">이전</button>
	</button><input type="submit" id="submit"  value="수정" /></td>
	</tr>
	
	</table>
	</form>
</body>
</html>
