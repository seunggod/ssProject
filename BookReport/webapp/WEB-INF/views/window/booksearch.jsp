<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 검색</title>
<style>
  body { }
  body h1 { text-align:center; color:orange; }
  .bookSearch { margin:0 auto;  width:100%; }
  table h3 { margin-left:20px; }
  td input { margin-left:8%; width:400px; height:30px;}
  td button { margin-left:5px; border:none; background:orange; color:white; font-weight: bold; height:38px; width:70px;  }
  #close { margin:0 auto 0 43%; cursor:pointer;}
  #search { cursor: pointer;}
  #result { margin:20px; border:2px solid orange; height:300px;
  			text-align: center;}
  #selectedBook { width:80%; }
  .th { width:25%;}
  .list td { height:100px;}
  img { width:100%; height:100%;}
  .bookResult table { width:100%; height:100%;}
  .result { width:100%; height:100%;}
  .result, .result td, .result th { border: 1px solid orange; border-collapse: collapse; }
  .bookResult p { text-align:center }
  .selectResult { cursor:pointer;}
  .selectResult:hover { color:orange; }
  
  #paging { text-align:center; }
  .page { padding:5px;
          margin-left:10px;
          text-decoration: none;
          font-weight: bold;
          cursor:pointer;}
  
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  //검색 및 페이징
  function paging(nowpage,json){
	  console.log('nowpage:'+nowpage);
	  console.dir(json);
	  $.ajax({
		url:'/BBoard/BookSearch',
		data:JSON.stringify(json) ,
		type:'POST',
		contentType: 'application/json; charset:UTF-8',
		dataType:'json'
		})
		.done(function(result){
			console.dir(result);
			var html='';
			var totalData = ''; //전체 자료수
			if(result.bookList.length==0){
			html+='<p>일치하는 결과가 없습니다</p>';
			} else{
			  	 totalData = result.count;
			  	 html += '<h3>검색 결과 ('+totalData+')</h3>';
			  	 html += '<table class="result">';
				   html += '<tr class="list">';
				   html += '<th>책 이미지</th>';
				   html += '<th>제목</th>';
				   html += '<th>저자</th>';
				   html += '<th>출판사</th>';
				   html += '<th>출간일</th>';
				   html += '<th>분류</th>';
				   html += '</tr>';
				   $.each( result.bookList, function(index, data ) {
				 	   html += '<tr class="list">';
					   html += '<td><img src="' + data.book_image + '"/></td>';
					   html += '<td><a class="selectResult">' + data.book_title + '</a></td>';
					   html += '<td>' + data.book_author + '</td>';
					   html += '<td>' + data.publisher + '</td>';
					   html += '<td>' + data.book_date + '</td>';
					   html += '<td>' + data.book_sort + '</td>';
					   html += '</tr>';
		 	 	   });
				html += '<tr>';
				html += '<td id="paging" colspan="6">';
				
			    
				if(totalData<50){
			    	var pageCount =  Math.ceil( totalData / 5 ); 		//5는 한 페이지당 보여줄 자료 수
			    	var totalPage =  pageCount;
				} else {
					var pageCount = 10;
					var totalPage = Math.ceil( totalData / 5 );
				}
				var pageGroup = Math.ceil(nowpage/pageCount);     // 페이지 그룹
				console.log('totalData:'+totalData);
				console.log('pageCount:'+pageCount);
				console.log('pageGroup:'+pageGroup);
				console.log('totalPage:'+totalPage);
				var totalPageGrp = Math.ceil(totalPage/10);
				console.log('totalPageGrp:'+totalPageGrp);
				if(pageGroup!=1)
					html += '<a class="page" id="prev"><</a>';	
				
				var first = 1+(pageGroup-1)*10; //시작 페이지
				var last  = pageCount+(pageGroup-1)*10; //마지막 페이지
				if(last>totalPage){
					var last = totalPage; //마지막 페이지
				} 
				
				
				for (var i = first; i <= last; i++) {
				     html += '<a class="page" id="page'+i+'">'+i+'</a>';
		 	 	}
				
				if(pageGroup != totalPageGrp)
					html += '<a class="page" id="next">></a>';
			
				html += '</td>';
				html += '</tr>';
			    html += '</table>';
			   
				   
			}
			$('.bookResult').html(html);
			$('#page'+nowpage).css('color','orange');
		})
		.fail(function(data, textStatus, errorThrown){
			console.log(data);
			alert('Error:'+ data);
		})
  }//ajax 끝




  $(function(){
	 
	  var nowpage = 1; //초기 페이지
	  var keyword = ''; //검색어
	  //enter 키 입력을 통한 검색 가능 
	  $('#keyword').on('keypress',function(e){
		  if(e.keyCode==13){
			  $('#search').click();
		  }
	  })
	  
	  //검색 시
	  $('#search').on('click',function(){
		  console.dir($('#keyword').val());
		  var keyword = $('#keyword').val();
		  var json =  {keyword:keyword,
		                  nowpage:nowpage}
		 paging(nowpage,json);
			
		 
	  })
	  
	  //이벤트 동적 바인딩 - 검색 결과 클릭 시
	  $(document).on('click','.selectResult',function(e){
		  var html='';
		  html += '<h3>선택 도서</h3>';
		  html += '<table class="result">';
		  html += '<tr class="list">';
		  html += '<th>책 이미지</th>';
		  html += '<th>제목</th>';
		  html += '<th>저자</th>';
		  html += '<th>출판사</th>';
		  html += '<th>출간일</th>';
		  html += '<th>분류</th>';
	      html += '</tr>';
		  html += '<tr class="list">';
		  html += '<td><img src='+$(this).parent().prev().children()[0].src+'></img></td>';
		  html += '<td>' + this.text + '</td>';
		  html += '<td>' + $(this).parent().next().eq(0).text() + '</td>';
		  html += '<td>' + $(this).parent().next().next().eq(0).text() + '</td>';
		  html += '<td>' + $(this).parent().next().next().next().eq(0).text() + '</td>';
		  html += '<td>' + $(this).parent().next().next().next().next().eq(0).text() + '</td>';
		  html += '</tr>';
		  html += '</table>';
		  $('#selectedBook').html(html);
	  })
	  //이전 10페이지를 표시
	  $(document).on('click','#prev',function(){
		  nowpage = (Math.ceil(nowpage/10)-2)*10+1;
		  console.log(nowpage);
		  var json = {keyword:keyword,
				  	  nowpage:nowpage}
		  paging(nowpage,json);
	  })
  	  //다음 10페이지를 표시
	  $(document).on('click','#next',function(){
		  nowpage = Math.ceil(nowpage/10)*10+1;
		  var json = {keyword:keyword,
				  	  nowpage:nowpage}
		  paging(nowpage,json);
		  
	  })
  	  
	 //페이지 클릭 시 
	 $(document).on('click','.page',function(e){
		  
		  //클릭된 버튼이 <나 >였을 경우에는 현재 페이지 저장X
	  	  if(this.text=='<'||this.text=='>'){
	  		  return false;
	  	  }
	  	  nowpage = this.text;
	  	  
	  	  var json = {keyword:keyword,
			  	  nowpage:nowpage}
	  	  paging(nowpage,json);
	 })
	 
	 //선택 완료 버튼 클릭 시 
	 $('#close').on('click',function(){
		 //선택된 도서가 없을 경우
		 if($('#selectedBook').children().length==0){
		  	alert('선택된 도서가 없습니다');
		 	return false; 
	  	 }
		 
		 //선택된 도서의 값들을 부모창에 입력
		 $('#bookImg', opener.document)[0].src = $('#selectedBook td:eq(0)').children()[0].src;
		 $('#bookTitle', opener.document).val($('#selectedBook td:eq(1)').text());
		 $('#author', opener.document).val($('#selectedBook td:eq(2)').text());
		 $('#publisher', opener.document).val($('#selectedBook td:eq(3)').text());
		 $('#bookDate', opener.document).val($('#selectedBook td:eq(4)').text());
		 for (var i = 0; i <= 19 ; i++) {
			 var option = $('[name=sort]', opener.document)[0][i];
			 if(option.value == $('#selectedBook td:eq(5)').text()){
				 console.log(option.value);
				 $(option).prop('selected',true);
			 }
		 }
		 window.close();
		 
	 })
	 
	 //크기 조절 시 다시 원래 크기로 조절
	 window.addEventListener('resize',function(){
		 this.resizeTo(620,480);
		 
	 })

	  
  })
  
</script>
</head>
<body>
 <h1>도서 검색</h1>
 <table class="bookSearch">
   <tr>
     <td><input type="text" id="keyword" /><button id="search">검색</button></td>
   </tr>
   <tr>
     <td class="bookResult">
       
     </td>
   </tr>
   <tr>
     <td id="selectedBook"></td>
   </tr>
   <tr>
     <td><button id="close">선택 완료</button></td>
   </tr>
 </table>
</body>
</html>