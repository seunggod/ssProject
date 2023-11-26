<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독후감 공유 카페</title>
<link rel="stylesheet" href="/css/common.css"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
  .cnt { width:14%;}
  .boardContainer th { width:18%; padding:10px;  }
  .bookGrade{ color:yellow; font-size:20px; }
  #imgSelect { height:140px; }
  .right { text-align: right;}
  .center { text-align: center;}
  .reply, th, td { border:1px solid black; 
  		   border-collapse: collapse;
  		   margin:0 auto;
  		   width:800px;
  		   text-align:center;
  		   }
   #rereply_nick { text-align:left;
  					 margin:40px 0 0 -250px;
  					 font-size:20px;
  					 position:absolute;
  					 color:orange;}
  #rereply_nick a { color:black;  
  					text-decoration: none;}
  #replyWriteForm h2 {  text-align:center; 
  						display:inline-block; 
  						margin:20px 0 20px 0;}
  #replyWriteForm { display:block; width:800px; margin:0 auto; border:3px solid black; text-align: center;}
  [name=reply_cont] { margin:0 0 2% 2%;
  			   		  width:80%; height:200px;
  			   	 	  resize: none;}
  .replyCont { margin:0 0 2% 2%;
  			   width:95%; height:200px;
  			   resize: none;}
  .reply td:nth-of-type(1) { width:20%; }
  .reply td:nth-of-type(2) a { float:right; margin:10px 5% 10px 0; }
  #replyUpdateForm, #rereplyWrite { margin-right:1%;}
  .reply b { font-size: 20px; cursor:pointer; color:orange; }
  .reply td:nth-of-type(1) { text-align:center;}
  #submit { margin:0 2% 2% 0; width:15%; height:200px; float:right;}
  .boardContainer { height:100px;}
  #cont { border:none;}
  #likeSpan { float:left; width:80px; height:20px; margin:10px 0 0 20px; }
  #likeSpan a { float:none; color:blue;}
  
   #paging { text-align:center; padding:10px;  }
  .page { padding:5px;
          margin-left:10px;
          text-decoration: none;
          font-weight: bold;
          cursor:pointer;}
  .page:nth-of-type(1) { margin-left:0;}
  .update, .delete, #likeBoard, #reportBoard { 
  							     background: orange;
  							     font-weight: bold;
  							     font-size:15px;
  							     border:none;
  							     padding:5px;
  							     width:50px;
  							     margin:10px 5px 10px;
  							     border-radius: 10px; } 
  #likeBoard { width:100px;}
  th { background: orange; }
</style>
<script>
  //textarea 크기 변경 함수
  function resize(obj) {
	  
	  obj.style.height = "100px";
      obj.style.height = (12+obj.scrollHeight)+"px";
  }
  //댓글 목록 가져오기(ajax) 함수
  function replylist(replypage,check){
	  console.log('replypage:'+replypage); //현재 댓글 페이지(페이징)
	  console.log('check:'+check); //check:true는 댓글 열기 클릭 시 check:false는 열린 상태에서 변경되는 모든 경우
	  $.ajax({
  		url:'/Reply/List',
  		data:{ free_num:${board.board_num},
  			   replypage:replypage },
  		type:'GET',
  		contentType:'application/json; charset:UTF-8'
  	  }).done(function(result){ 
  		var totalData = result.reCnt;
  		$('#replyBtn').text('▽  댓글 '+ totalData +'개 ▽');
  		var html='';
  		if(check){
  			html+='<table class="reply">';
  		}
  		//결과가 전혀 없을 경우
  		if(result.list.length == 0){
  			html+='<tr colspan="2"><td>';
  			html+='<h2>작성된 댓글이 없습니다</h2>';
  			html+='</tr></td>';
  		} else{
  			console.log(result);
  			console.dir(result.list);
  			//배열 선언
  			var array = new Array();
  			$.each( result.list, function(index, data ){
  				html+='<tr>';
  				html+='<td><input type="hidden" name="reply_mem_num" value="'+data.reply_mem+'"/>';
  				html+='<b>'+ data.reply_writer + '</b>';
  				//대댓글인 경우
  				if(data.rereply_nick != undefined){
  					html+='&nbsp;▶&nbsp;<br/><b>'+ data.rereply_nick + '</b>';
  				}
  				html+='<br/><span>'+ data.reply_date +'</span>';
  				html+='</td>';
  		   	    html+='<td>';
	     		html+='<input type="hidden" class="rnum" value="'+ data.reply_num +'" >';
	     		array.push(data.likeCheck);
	     		html+='<span id="likeSpan">';
	     		html+='<a id="likeReply" class="like" href="">좋아요</a>';
	     		html+='&nbsp;<span>'+ data.likeCnt +'</span>';
	     		html+='</span>';
	     		if(data.reply_writer =='${login.nickname}'){ //로그인된 닉네임과 작성자 닉네임이 동일할 경우
		     		html+='<a id="replyDelete" href="">삭제</a>';	
		     		html+='<a id="replyUpdateForm" href="">수정</a>';
	     		} else{
	     			if('${login.mem_lvl}'>=100){
		     			html+='<a id="replyDelete" href="">삭제</a>';		
	     			}
	     			html+='<a class="report" id="replyReport" href="">신고</a>';
	     			html+='<a id="rereplyWrite" href="">댓글 쓰기</a>';
	     		}
	     		html+='<textarea class="replyCont" disabled>'+ data.reply_cont +'</textarea>';
	     		html+='</td>';	     	
		   	    html+='</tr>';
  			})
  		}
  		//댓글 열기 클릭 시
  		if(check){
		     html+='</table>';
		     $('body').append(html);
  		} else {
	      	$('.reply').html(html);	
	    }
		//댓글 textarea의 size를 조정
	    var recont = $('.replyCont');
	    for (var i = 0; i < recont.length; i++) {
			resize(recont[i]);
		}
  	 	//좋아요 여부에 따른 색상 변경
  	 	console.dir($('[id = likeReply]'));
  	 	console.dir(array);
  	 	if(array!=undefined){
	  	 	for (var i = 0; i < array.length; i++) {
				if(array[i] == 1){
					$($('[id = likeReply]')[i]).css('color','orange');
				};
			}
  	 	}
	    
	    
	    //댓글 페이징
	    //댓글 결과가 0이 아니라면
	    if(result.list.length != 0){
			html='';
		  	html += '<tr>';
			html += '<td id="paging" colspan="2">';
		
			if(totalData<100){
		    	var pageCount =  Math.ceil( totalData / 10 ); 		//5는 한 페이지당 보여줄 자료 수
		    	var totalPage =  pageCount;
			} else {
				var pageCount = 10;
				var totalPage = Math.ceil( totalData / 10 );
			}
			var pageGroup = Math.ceil(replypage/pageCount);     // 페이지 그룹
			console.log('replypage:'+replypage);
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
			$('.reply').append(html);	
			$('#page'+replypage).css('color','orange');
		  
	    }
	    
		
  	}).fail(function(data, textStatus, errorThrown){
		alert('Error:댓글 목록을 불러오는데 실패했습니다');
  	})//ajax 끝
  	
  	//댓글을 여는 경우 
  	if(check){
  		return false;
  	}
  }


  $(function(){
		var replypage = 1; //페이징 용 변수
		//textarea 크기 변경
		var cont = document.getElementById('cont');
   		resize(cont);

		//좋아요 여부에 따른 텍스트 변경
	    if('${ status }'=='likeBoard')
	     	$('#likeBoard').text('좋아요 취소');
		//좋아요 버튼은 중앙에 존재하도록 설정
		if($('#likeBoard').length != 0)
			$('.right').prop('className','center');
			
		//이미지가 없는 공지사항을 경우 이미지 칸 제거
		if('${ board.board_image}'=='')
			$('#imgSelect').css('display','none');
	   console.log('${ board.board_image}');
		//좋아요 이벤트(게시물, 댓글 공통)
	    $(document).on('click','.like',function(){
	    	var btn = this;
	    	var text = '';
	    	console.dir('id:'+this.id);
	    	console.dir('text:'+this.innerText);
	    	var href='';
	    	//비로그인 시
	    	if('${ login.nickname }'==''){
	    		alert('로그인 후 이용해 주세요');
	    		return false;
	    	}

	    	//댓글 작성자와 동일인은 좋아요를 누를 수 없다
	    	if('${ login.nickname }'== $($(this).parent().parent().siblings().children().next()[0]).text()){
	    		alert('자신에게 좋아요를 누를 수 없습니다');
	    		return false;
	    	}
	    	//필요한 파라미터:게시물 번호 or 댓글 번호, 로그인 아이디, 좋아요 여부
	    	// 좋아요가 증가할 위치
	    	switch(this.id){
	    	case 'likeBoard': href = '/FBoard/LikeBoard'; 
	    	              var json = { free_num:${board.board_num},
	    	            		       mem_num:'${ login.mem_num }' };
	    	              var tag  = $($('.cnt')[1]);
	    	              if(this.innerText == '좋아요')
	    	              	  var text = '좋아요 취소';
	    	              else
	    	            	  var text = '좋아요';
	    	              break; //게시물
	    	case 'likeReply': href ='/Reply/LikeReply';
	    				 var  json = { sort:'fboard',
	    						 	   reply_num:$(this).parent().prev().val(),
	    						 	   mem_num:'${ login.mem_num }'};
	    				 var tag   = $(this).next();
	    				 var color = $(this).css('color');
	    				 if(color == 'rgb(255, 165, 0)'){
	    					$(this).css('color','blue');
	    				 } else {
	    					$(this).css('color','orange');
	    				 }
	    				 
	    				 break; //댓글
	    	}
	    	$.ajax({
	    		url:href,
	    		data:JSON.stringify(json),
	    		dataType:'json',
	    		contentType:'application/json; charset:UTF-8',
	    		type:'POST'
	    	}).done(function(result){
	    		
	    		tag.text(result);
	    		if(text!='')
	    			btn.innerText = text;
	    		
	   
	    	}).fail(function(data, textStatus, errorThrown){
	    		console.log(data);
				alert('Error:'+ data);
	    	})//ajax 끝
	    	return false;
	    })// 좋아요 이벤트 끝
	  
	    //게시물 삭제
	    $('.delete').on('click',function(){
	    	//삭제 확인
	    	if(!confirm('이 게시물을 삭제하시겠습니까?'))
	    		return false;
	    	location.href = '/FBoard/Delete/'+'${ board.board_num }';
	    })
	    
	    //게시물 수정
	    $('.update').on('click',function(){
	    	location.href = '/FBoard/UpdateForm/${ nowpage }/${ board.board_num }';
	    })
	    
	    //댓글 열기/닫기
	    //ajax로 댓글 db를 가져와야 함
	    //또한 댓글 작성, 수정, 삭제, 신고를 구현해야 함
	    var check = true; //댓글 개폐 상태 확인 변수
	    $(document).on('click','#replyBtn',function(){
	      console.log(check);
	      var html = '';
	      if(check){
	    	//댓글 작성 칸 
	    	html+='<div id="replyWriteForm">';
	    	html+='<input type="hidden" id="reply_num" name="reply_num" value="0"/>';
	    	html+='<input type="hidden" name="reply_writer" value="'+'${login.nickname}'+'" />';
	    	html+='<h2>댓글 작성(200자 이내)</h2>';

	    	html+='<textarea  name="reply_cont" maxlength="200"></textarea>';
	    	html+='<input type="button" id="submit" value="작성"/>';
	    	html+='</div>';
	    	$('body').append(html);
	     	//댓글 목록 함수
	    	check = replylist(1,true);
	     	
	    	
	      } else{
	    	//댓글이 열려있을 때 클릭 시 모두 제거
	    	$('#replyWriteForm').remove();
	    	$('.reply').remove();
	    	//댓글 수 갱신 및 버튼 텍스트 변경
	    	 $.ajax({
	    	  		url:'/Reply/Count',
	    	  		data:{ free_num:${board.board_num} },
	    	  		type:'GET',
	    	  		contentType:'application/json; charset:UTF-8'
	    	  	  }).done(function(result){ 
	    	  		$('#replyBtn').text('△ 댓글 '+ result +'개 △');
	    	  	  }).fail(function(data, textStatus, errorThrown){
	    	    		alert('Error:댓글 개수를 불러오는데 실패했습니다');
	    	      })//ajax 끝
	    	
	    	check = true;
	      }
	      return false;
	    })
	    
	    
	   	 //이전 10페이지를 표시
	 	 $(document).on('click','#prev',function(){
		  replypage = (Math.ceil(replypage/10)-2)*10+1;
		  console.log('replypage:'+replypage);
		  replylist(replypage,false);
	  	 })
	  	 
  	 	 //다음 10페이지를 표시
	 	 $(document).on('click','#next',function(){
		  replypage = Math.ceil(replypage/10)*10+1;
		  console.log('replypage:'+replypage);
		  replylist(replypage,false);
		  
	 	 })
	    
	    
	    
	    //페이지 클릭 시 
	 	$(document).on('click','.page',function(e){
		  
		  //클릭된 버튼이 <나 >였을 경우에는 현재 페이지 저장X
	  	  if(this.text=='<'||this.text=='>'){
	  		  return false;
	  	  }
	  	  replypage = this.text;
	  	  
	  	  replylist(replypage, false);
	  	 
		})
	    
	    
	    
	    
	    
	    //댓글 작성
	    $(document).on('click','#submit',function(){
	    	var reply_num    =  $('#reply_num').val(); //대댓글 여부
	    	var mem_num      = '${ login.mem_num }';
	    	var reply_cont   = $('[name=reply_cont]').val();
	    	//비로그인 시
	    	if(mem_num == ''){
	    		alert('로그인 후 이용해 주세요');
	    		let href= '/User/LoginForm';
	  		    location.href=href;
	    		return false;
	    	}
	    	//내용 공백
	    	if(reply_cont == ''){
	    		alert('내용을 입력해주세요');
	    		return false;
	    	}
	    	
	    	var data = { sort:'fboard',
	    				 reply_num:reply_num,
	    			     mem_num:mem_num,
	    			     reply_cont:reply_cont,
	    				 free_num:'${ board.board_num }' };
	    	console.log(data);
	    	
	    	$.ajax({
	    		url:'/Reply/Write',
	    		data:data,
	    		type:'GET'
	    	}).done(function(){
	    		replylist(1,false); //댓글 목록 갱신
	    		//대댓글 번호 및 추가된 요소 제거 
	    		if(reply_num != 0 ){
	    			console.dir($('#submit').parent().children());
		    		$('#rereply_nick').next().val(0);
		    		$('#rereply_nick').remove();	
	    		}
	    		$('[name=reply_cont]').val(''); //댓글 작성 후 내용 비우기
	    		alert('댓글 작성이 완료되었습니다');
	    	}).fail(function(data, textStatus, errorThrown){
				alert('Error:'+ data);
	    	})//ajax 끝
	    })
	    
	    //댓글 수정 상태로 변경
	    $(document).on('click','#replyUpdateForm',function(){
	    	
	    	if($('#replyUpdate').length == 0 ){
	    		$($(this).next()[0]).attr('disabled',false);
	    		$(this).parent().append('<br/><button id="replyUpdate">수정 완료</button>');
	    		$(this).text('취소');
	    	} else {
	    		$($(this).next()[0]).attr('disabled', true);
	    		$(this).next().next().remove(); //<br>제거
	    		$(this).next().next().remove(); //<button> 제거
	    		$(this).text('수정');
	    	}
	    	
	    	return false;
	    })
	    
	    //댓글 수정
	    $(document).on('click','#replyUpdate',function(){
	    	var reply_num  = $(this).parent().children()[0].value; 
	    	var reply_cont = $(this).prev().prev().val();
	    	var data = { sort:'fboard',
	    				 reply_num:reply_num,
   			     		 reply_cont:reply_cont };
	    	console.dir(data);
	    	
	    	//내용 공백
	    	if(reply_cont == ''){
	    		alert('내용을 입력해주세요');
	    		return false;
	    	}
	    	
	    	$.ajax({
	    		url:'/Reply/Update',
	    		data:data,
	    		type:'GET'
	    	}).done(function(){
	    		replylist(1,false); //댓글 목록 갱신
	    		$(this).prev().prev().attr('disabled', true );
	    		$(this).prev().remove() // <br> 제거
	    		$(this).remove(); //수정 완료 버튼 제거
	    		alert('댓글 수정이 완료되었습니다');
	    	}).fail(function(data, textStatus, errorThrown){
				alert('Error:댓글 수정에 실패했습니다');
	    	})//ajax 끝
	    	
	    })
	    
	    //댓글 삭제
	    $(document).on('click','#replyDelete',function(){
	    	if(!confirm('댓글을 삭제하시겠습니까?'))
	    		return false;
	    		
	    	
	    	console.dir('reply_num:'+$(this).parent().children().val());
	    	
	    	$.ajax({
	    		url:'/Reply/Delete',
	    		data:{ reply_num:$(this).parent().children().val(),
	    			   sort:'fboard'},
	    		type:'GET'
	    	}).done(function(){
	    		replylist(1,false); //댓글 목록 갱신
	    		alert('댓글 삭제가 완료되었습니다');
	    	}).fail(function(data, textStatus, errorThrown){
				alert('Error:'+ data);
	    	})//ajax 끝
	    	
	    	
	    	return false;
	    })
	    
	    //대댓글 쓰기
	    $(document).on('click','#rereplyWrite',function(){
	    	//대댓글을 쓸 댓글번호를 input 태그에 입력
	   		$('#reply_num').val($(this).parent().children()[0].value);
	    	var nickname = $(this).parent().siblings().children()[1].innerText;
	    	//댓글 작성창으로 focus 이동
	    	//'<a href="">▶ @master</a>';
	    	console.log($('#rereply_nick').length);
	    	if($('#rereply_nick').length == 0 ){	
	    		var html = '';
	    		html+='<span id="rereply_nick">▶ @'+ nickname +'  <a href="" id="rereplyCancel">x</a></span>';
	    		$('#replyWriteForm').prepend(html);
	    	} else {
	    		$('#rereply_nick span').val('▶ @'+ nickname +'  <a href="" id="rereplyCancel">x</a>');
	    	}
	   		$('[name=reply_cont]').focus();
	   		return false;
	    })
	    
	    //대댓글 취소
	    $(document).on('click','#rereplyCancel',function(){
	    	//대댓글 번호 및 추가된 요소 제거 
	    	$(this).parent().next().val(0);
	    	$(this).parent().remove();
	    	
	    	return false;
	    })
	    
	    
	    
	    //댓글 신고
	   //게시물 신고
	    $(document).on('click','.report',e=>{
	    	
	    	if('${login.nickname}'==''){
	    		alert('로그인 후 이용해주세요');
	    		return false;
	    	}
	    	
	    	const btn  = e.target;
	    	
	    	let reported_nick;
	    	let num;
	    	let sort;
	    	
	    	console.dir(btn.id);
	    	switch(btn.id){
	    	case 'replyReport':  reported_nick = $(btn).parent().siblings().children()[1].innerText;
	    						 console.dir($(btn).parent().siblings().children()[0].value);
	    					     reported_mem = $(btn).parent().siblings().children()[0].value;
	    						 num  = $(btn).parent().children()[0].value;
	    						 sort = '댓글';
	    						 break;
	    	case 'reportBoard':  reported_nick = '${board.board_writer}';
	    						 reported_mem = '${board.board_writer_num}';
	    						 num  = '${board.board_num}';
	    						 sort = '자유게시물';
	    						 break;
	    	}
	    	
			
	    	const href ='/ReportForm?reported_nick='+reported_nick+'&reported_mem='+reported_mem+'&num='+num+'&sort='+sort;
	    	
	    	window.open(href,'','width=550, height=450, left=450, top=150');
	    	
	    	return false;
	    })
	   
	    
  })
</script>
</head>
<body>
  <%@include file="/WEB-INF/include/header.jsp" %>
  <table class="boardContainer">
    <caption><h1>자유게시판</h1></caption>
    <tr>
      <td colspan="4" id="title">${ board.board_title }</td>
    </tr>
    <tr>
      <th>게시자</th>
      <td>${ board.board_writer }</td>
      <th>등록일</th><td>${ board.regdate }</td>
    </tr>
    <tr>
      <th>조회수</th><td class="cnt">${ board.readcount }</td><th>추천수</th><td class="cnt">${ board.likecount }</td>
    </tr>
    <tr>
      <td id="imgSelect" colspan="4">
      <img id="boardImg"  src="${ board.board_image }" /></td>
    </tr>
    <tr>
      <td colspan="4"><textarea id="cont" disabled>${ board.board_cont }</textarea></td>
    </tr>
    <tr>
      <td colspan="4" class="right">
      <!-- 작성자가 접속한 경우 수정과 삭제가 등장 -->
      <c:if test="${ login.nickname ne null }">
      <c:choose>
        <c:when test="${ login.nickname eq board.board_writer }">
        <button class="update">수정</button>
        <button class="delete">삭제</button>
        </c:when>
        <c:otherwise>
        <button class="like" id="likeBoard">좋아요</button>
        <button class="report" id="reportBoard">신고</button>
        </c:otherwise>
      </c:choose>
      <c:if test="${ login.nickname ne board.board_writer  && login.mem_lvl >= 100 }">
      <button class="delete">삭제</button>
      </c:if>
      </c:if>
      </td>
    </tr>
    <tr>
      <td colspan="6" class="center">
      <a href="" id="replyBtn" >△ 댓글 ${ board.replycount }개 △</a>
      </td>
    </tr>
  </table>
  
  
  
 
</body>
</html>