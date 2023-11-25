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
  // 삽입된 버튼의 이벤트 변경
  function putImage(){
	  $('#imageOne').click(); // 최초 삽입과의 구분을 위해 펑션을 3개 만들어야할 가능성
	  						  // 이미지가 들어갈 태그 위치와 해당 버튼을 누르도록 인자처리
  }
  function putImage2(){
	  $('#imageTwo').css('display','none');
	  $('#imageTwo').click(); 
	  if($('#insertbtn2').length){
			console.log("존재");
		} else{
		let cnt=3;
		let html ='<div id="imagediv"><button id="insertbtn2" type="button" onclick="putImage2()">이미지삽입</button></div>';
		html    += '<textarea id="insertcont" name="bcont'+cnt+'"  maxlength="1000"></textarea>';
			
		html    += '<input type="file" id="imageThree" name="image'+cnt+'" onchange="putImage'+cnt+'()" accept="image/*" />';
			
		// 버튼 안의 이미지를 찾아서 있다면 증가하지 않도록(경우에 따라서는 태그 생성 자체를 제어)
		// 이미지가 이미 있다면 바뀌도록
		$('#content').append(html);
		}
	  let inImage = document.getElementById('imageTwo').files[0];
	  let tagaddr = document.getElementById('insertbtn2');
	  
	  
	  readAndPreview(inImage,tagaddr);
  }
  function putImage3(){
	  $('#imageThree').css('display','none');
	  $('#imageThree').click(); 
	  if($('#insertbtn3').length){
			console.log("존재");
		} else{
		let cnt=4;
		let html ='<div id="imagediv"><button id="insertbtn3" type="button" onclick="putImage3()">이미지삽입</button></div>';
		html    += '<textarea id="insertcont" name="bcont'+cnt+'"  maxlength="1000"></textarea>';
			
		//html    += '<input type="file" id="imageThree" name="image'+cnt+'" onchange="putImage'+cnt+'()" accept="image/*" />';
			
		// 버튼 안의 이미지를 찾아서 있다면 증가하지 않도록(경우에 따라서는 태그 생성 자체를 제어)
		// 이미지가 이미 있다면 바뀌도록
		$('#content').append(html);
		}
	  let inImage = document.getElementById('imageThree').files[0];
	  let tagaddr = document.getElementById('insertbtn3');
	  
	  
	  readAndPreview(inImage,tagaddr);
  }
  
  function readAndPreview(inImage, tagaddr ){
	  console.dir(inImage);
	  console.dir(tagaddr);
	  if ( /\.(jpe?g|png|gif)$/i.test( inImage.name ) ) { //확장자 체크(이미지 인가)
			let reader = new FileReader();
	        reader.onload = function() {
	        	 let image = new Image();   //이미지를 생성하여
	   		 	 image.width = "600";
	   		  	 image.height = "450";
	   	     	 image.title = inImage.name;
	   	      
	   		 	 image.src = this.result; // 지정해 파일 완성
	            //파일의 URL을 Base64 형태로 가져온다.
	           tagaddr.innerText='';
	   		   tagaddr.appendChild( image );
	        };
	        // onload 대신 addEventListener( ) 사용가능
	    	// reader.addEventListener("load", function() {

	    	// }, false);
	    	if( inImage ) {
	            // readAsDataURL( )을 통해 파일의 URL을 읽어온다
	            reader.readAsDataURL( inImage );
	        }

	  	}
	  		
  }

  

  $(function(){
	  	var cnt= 1;	 //name변경을 위한 cnt
 		 //메인 이미지 첨부 버튼을 누르면 첨부 input이 기능함
	  	$('#putmimage').on('click',function(){
	  		
	  		$('#mimage').click();
	  		return false;
	  	})
	    // 메인 이미지를 html에 삽입
	  	$('#mimage').on('change',function(e){
	  		let mainimage = document.getElementById('mimage').files[0];
	  	// @details readAsDataURL( )을 통해 파일을 읽어 들일때 onload가 실행
	  		if ( /\.(jpe?g|png|gif)$/i.test( mainimage.name ) ) { //확장자 체크(이미지 인가)
			let reader = new FileReader();
	        reader.onload = function() {
	        	 let image = new Image();   //이미지를 생성하여
	   		 	 image.width = "600";
	   		  	 image.height = "450";
	   	     	 image.title = mainimage.name;
	   	      
	   		 	 image.src = this.result; // 지정해 파일 완성
	            //파일의 URL을 Base64 형태로 가져온다.
	            //document.getElementById("img").src = reader.result;
	           // document.getElementById("img").innerHTML = reader.result;
	           let putmimage = document.getElementById( "putmimage" );
	           putmimage.innerText='';
	           //console.dir(putmimage);
	   		   putmimage.appendChild( image );
	        };
	        // onload 대신 addEventListener( ) 사용가능
	    	// reader.addEventListener("load", function() {

	    	// }, false);
	    	if( mainimage ) {
	            // readAsDataURL( )을 통해 파일의 URL을 읽어온다
	            reader.readAsDataURL( mainimage );
	        }

	  		}
	  		
	  	});
	  	
	 	//textarea 자동 크기 증가 (처음의 textarea 한정)
		$('#cont').on('keyup',function(e){

			$(this).css('height', '300' );
			$(this).height(this.scrollHeight);
	
		});
		
		$('#imageTwo').on('change',function(e){
			console.log('success2');
			return false;
		})
		
		
		  
	  	//이미지를 넣으면 div를 생성해 그 안에 이미지를 삽입
		$('#imageOne').on('change',function(e){
			
			$('#imageOne').css('display','none');
			let inImage = document.getElementById('imageOne').files[0]; //이미지 파일들을 찾음
			
			if($('#insertbtn').length){
				console.log("존재");
			} else{
			cnt=cnt+1;
			let html ='<div id="imagediv"><button id="insertbtn" type="button" onclick="putImage()">이미지삽입</button></div>';
			html    += '<textarea id="insertcont" name="bcont'+cnt+'"  maxlength="1000"></textarea>';
				switch(cnt){
					case 2:
					html    += '<input type="file" id="imageTwo" name="image'+cnt+'" onchange="putImage'+cnt+'()" accept="image/*" />';
				}
			// 버튼 안의 이미지를 찾아서 있다면 증가하지 않도록(경우에 따라서는 태그 생성 자체를 제어)
			// 이미지가 이미 있다면 바뀌도록
			$('#content').append(html);
				console.log("없음");
			}
					
			let insertbtn = document.getElementById( "insertbtn" );
			//readAndPreview(imglist); //함수의 인자로 보냄
			readAndPreview(inImage, insertbtn);
			return false;
		});
		//이벤트가 안먹힘.... (삽입된 태그에 한하여)
		$('#imageOne2').on('change',function(e){
			console.log("success");
			return false;
		})
		
		//정렬 법
		$('#center').on('click',function(e){
			//$('#cont').css("text-align-last","center");
			e.stopPropagation();
			var cont = document.getElementById('cont');
			cont.style.textAlign="center";
			return false;
		})
		$('#left').on('click',function(e){
			e.stopPropagation();
			//$('#cont').css("text-align-last","center");
			var cont = document.getElementById('cont');
			cont.style.textAlign="left";
			return false;
		})
		
		

  }) //function의 끝
</script>
</head>
<body>
	<%@include file ="/view/common/header.jsp" %>
	<form action="/tboard?cmd=TBOARDWRITEACTION" method="POST" enctype="multipart/form-data">
	<table class="tboard">
	<caption>여행지 추천 글쓰기</caption>
	<tr>
	<td id="mainimage" rowspan="4"><input type="file" id="mimage" name="mainimage" accept="image/*" />
		<button id="putmimage" >메인이미지 첨부</button></td>
	
	<td id="input"><p>NO:000(예시)</p>
		제목<br><input type="text" name="title" placeholder="제목 입력"/></td>
	</tr>
	<tr>
	<td id="input">작성자<br><input type="text" value="${ LoginId }" readonly/></td>
	</tr>
	<tr>
	<td id="input">주소<br><input type="text" name="addr" placeholder="주소 입력"/></td>
	</tr>
	<tr>
	<td id="input">정렬&nbsp;&nbsp;<button id="left">왼쪽 정렬</button><button id="center">가운데 정렬</button></td>
	</tr>
	<tr>
	<td colspan="2" id="contbox">
	<div id="content"><textarea name="bcont1" id="cont" maxlength="1000"></textarea><br>
		<input type="file" id="imageOne" name="imageOne" accept="image/*" />
	
	</div>
	
	</td>
	</tr>
	<tr>
	<td colspan="2" class="submit"><input type="submit" id="submit"  value="저장" /></td>
	</tr>
	
	</table>
	</form>
</body>
</html>
