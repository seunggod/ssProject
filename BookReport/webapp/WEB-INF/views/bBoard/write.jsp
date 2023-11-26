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
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  function readAndPreview(inImage, tagaddr ){
	  console.dir(inImage);
	  console.dir(tagaddr);
	  if ( /\.(jpe?g|png|gif)$/i.test( inImage.name ) ) { //확장자 체크(이미지 인가)
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
	  
	  console.dir($('.bookGrade a').parent());
	  for(var n=0; n<5; n++ ){
		  console.log(n);
		  let num   = n; // hover 시 변수
		  let numii = num; // cusor가 벗어날 때 변수
		$('.bookGrade a').eq(num).on('click',function(){
			stars = num + 1;
			
			while(num>=0){
			  $('.bookGrade a').eq(num).text('★');  
			  num--;
			}
	        $('.bookGrade span').html('<input type="hidden" name="bookGrade" id="bookGrade" value="'+ stars +'"/>');
		    num= numii;
		    check=false;
		}) // 클릭 시 이벤트
		
	  	$('.bookGrade a').eq(num).hover(function(){
	  		for(var n=0;n<5;n++){ 
				$('.bookGrade a').eq(n).text('☆');  
			}
	  		
			while(num>=0){
			   $('.bookGrade a').eq(num).text('★');  
			   num--;
			}
			  num= numii;
		  },function(){
			  console.log(check);
			  if(check){
			 	 while(numii>=0){
					  $('.bookGrade a').eq(numii).text('☆');
					  numii--;
				  } 
				  numii = num;	  
			  } else{
				  
				  for(var n=0;n<5;n++){
					  $('.bookGrade a').eq(n).text('☆');  
				  }
				  for(var n=0;n<stars;n++){
					  $('.bookGrade a').eq(n).text('★');  
				  }	  
			  }   
		})//hover 시 이벤트 끝	
	  } //for문 끝
	  
	  //책 찾기 버튼 클릭 시
	  $('#bookSearch').on('click',function(){
		  var win = window.open('/BBoard/BookSearchForm','','width=600, height=400, left=450, top=150');
		  
	  })
	  
	  //책 이미지 선택
	  $('#imgSelect').on('click',function(){
		  console.log('click');
		  $('#bookImage').click();
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
		  if($('#bookTitle').val().trim()==''){
			  $('#bookTitle').focus();
			  alert('책 제목을 입력해주세요');
			  return false;
		  }
		  if($('#author').val().trim()==''){
			  $('#author').focus();
			  alert('책 저자를 입력해주세요');
			  return false;
		  }
		  if(check){
			  alert('책 평점을 정해주세요');
			  return false;
		  }
		  if($('#cont').val().trim()==''){
			  $('#cont').focus();
			  alert('내용을 입력해주세요');
			  return false;
		  }
		  
	  })//작성 클릭 유효성 검사 끝
	  
	  //파일 변경 시 이벤트
	  $('#bookImage').on('change',function(){
		  //let bookImage = document.getElementById('#bookImage').files[0];
		  let bookImage = document.getElementById('bookImage').files[0];
		  console.dir($('bookImage'));
		  let bookImg   = document.getElementById('bookImg');
		  readAndPreview(bookImage,bookImg);
		  
	  })
	  
	  
	  
	  
	  
  })
</script>
</head>
<body>
  <%@include file="/WEB-INF/include/header.jsp" %>
  <form action="/BBoard/Write" method="post" enctype="multipart/form-data">
  <input type="hidden" name="mem_num" id="mem_num" value="${ login.mem_num }"/>
  <table class="boardContainer">
    <caption><h1>후기게시판 글쓰기</h1></caption>
    <tr>
      <td colspan="6"><input type="text" name="title" id="title" placeholder="제목을 입력해주세요"/></td>
    </tr>
    <tr>
      <th>게시자</th>
      <td colspan="5"><input type="hidden" name="writer" id="writer" value="${ login.nickname }"/>${ login.nickname }</td>
    </tr>
    <tr>
      <th>등록일</th><td>0000.00.00 00:00</td>
      <th>조회수</th><td class="cnt">0</td><th>추천수</th><td class="cnt">0</td>
    </tr>
    <tr>
      <input type="file" name="bookImage" id="bookImage" accept="image/*" />
      <td id="imgSelect" rowspan="4">
      <img id="bookImg" alt="이미지 선택" /></td>
      <th>책 제목</th><td colspan="4"><input type="text" name="bookTitle" id="bookTitle" placeholder="책 제목을 입력해주세요"/>
      <input type="button" id="bookSearch" value="찾기"/></td>
    </tr>
    <tr>
      <th>책 저자</th><td colspan="4"><input type="text" name="author" id="author" placeholder="책 저자를 입력해주세요"/></td>
    </tr>
    <tr>
      <th>출판사</th><td colspan="2"><input type="text" name="publisher" id="publisher" placeholder="출판사를 입력해주세요"/></td>
      <th>출간일</th><td><input type="text" name="bookDate" id="bookDate" placeholder="출간일 입력"/></td>
    </tr>
    <tr>
      <th>책 평점</th>
      <td colspan="2" class="bookGrade">
      <a>☆</a>
      <a>☆</a>
      <a>☆</a>
      <a>☆</a>
      <a>☆</a>
      
      <span><!-- 평점 input 태그를 삽입하기 위한 span --></span>
      </td>
      <th>분류</th>
      <td>
        <select name="sort">
          <option></option>
          <option>컴퓨터/IT</option>
          <option>경제/경영</option>
          <option>정치/사회</option>
          <option>종교</option>
          <option>인문</option>
          <option>어린이</option>
          <option>예술/대중문화</option>
          <option>시/에세이</option>
          <option>소설</option>
          <option>과학</option>
          <option>역사/문화</option>
          <option>자기계발</option>
          <option>여행</option>
          <option>기술/공학</option>
          <option>외국어</option>
          <option>만화</option>
          <option>건강</option>
          <option>잡지</option>
          <option>요리</option>
        </select>
      </td>
    </tr>
    <tr>
      <td colspan="6"><textarea name="cont" id="cont"></textarea></td>
    </tr>
    <tr>
      <td colspan="6" class="center">
      <input type="button" id="cancel" value="취소"/>
      <input type="submit" id="submit" value="작성"/></td>
    </tr>
  </table>
  </form>
</body>
</html>