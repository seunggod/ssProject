<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독후감 공유 카페</title>
<link rel="stylesheet" href="/css/common.css"/>
<style>
 .center { text-align:center; margin:0 auto; height:100px;}
  select { width:100%; height:100%;}
 #noticeImg { width:500px;
 			  height:600px;
 			  margin:50px 0 50px;
 			  font-weight: bold;
 			  text-decoration: underline;
 			  color:blue;
 			  cursor:pointer; }
 #noticeImg:hover { color:cyan;}
 #imgSelect { text-align:center; 
 			  border-left-color: white;
 			  border-right-color: white;}
 #noticeImage { display:none; }
 .contTd {height:500px;}
 #cont {height:100%;}
 td { text-align: center;}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  function readAndPreview(inImage, tagaddr ){
	  console.dir(inImage);
	  console.dir(tagaddr);
	  if ( /\.(jpe?g|png|gif)$/i.test( inImage.name ) ) { //확장자 체크
			let reader = new FileReader();
	        reader.onload = function() {
	   		   tagaddr.src = this.result;
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
	  var check = true; //평점 작성 여부
	  var stars = 0;  //작성된 평점 개수
	//textarea 자동 크기 증가
		$('#cont').on('keyup',function(e){

			$(this).css('height', '496' );
			$(this).height(this.scrollHeight);
	
		});
	  
	  

	  
	  //공지사항 이미지 선택
	  $('#imgSelect').on('click',function(){
		  console.log('click');
		  $('#noticeImage').click();
	  })
	  
	  //취소 버튼 클릭 시
	  $('#cancel').on('click',function(){
		  history.go(-1);
	  })
	  
	  //작성 클릭 시 유효성 검사
	  $('form').on('submit',function(){
		  
		  if($('#title').val().trim()==''){
			  $('#title').focus();
			  alert('제목을 입력해주세요');
			  return false;
		  }
		  if($('#cont').val().trim()==''){
			  $('#cont').focus();
			  alert('내용을 입력해주세요');
			  return false;
		  }
		  
	  })//작성 클릭 유효성 검사 끝
	  
	  //파일 변경 시 이벤트
	  $('#noticeImage').on('change',function(){
		  let noticeImage = document.getElementById('noticeImage').files[0];
		  console.dir($('#noticeImage'));
		  let noticeImg   = document.getElementById('noticeImg');
		  readAndPreview(noticeImage,noticeImg);
		  
	  })
	  
	  
	  
	  
	  
  })
</script>
</head>
<body>
  <%@include file="/WEB-INF/include/header.jsp" %>
  <form action="/Notice/Write" method="post" enctype="multipart/form-data">
  <input type="hidden" name="mem_num" id="mem_num" value="${ login.mem_num }"/>
  <table class="boardContainer">
    <caption><h1>공지사항 글쓰기</h1></caption>
    <tr>
      <td colspan="4"><input type="text" name="title" id="title" placeholder="제목을 입력해주세요"/></td>
    </tr>
    <tr>
      <th>게시자</th>
      <td><input type="hidden" name="writer" id="writer" value="${ login.nickname }"/>${ login.nickname }</td>
      <th>등록일</th><td>0000.00.00 00:00</td>
    </tr>
    <tr>
      <th>조회수</th><td class="cnt">0</td><th>추천수</th><td class="cnt">0</td>
    </tr>
    <tr>
      <input type="file" name="noticeImage" id="noticeImage" accept="image/*" />
      <td id="imgSelect" colspan="4" >
      <img id="noticeImg" alt="[ 이미지 선택 ]" /></td>
    </tr>
    <tr>
      <td colspan="4" class="contTd"><textarea name="cont" id="cont"></textarea></td>
    </tr>
    <tr>
      <td colspan="4" class="center">
      <input type="button" id="cancel" value="취소"/>
      <input type="submit" id="submit" value="작성"/></td>
    </tr>
  </table>
  </form>
</body>
</html>