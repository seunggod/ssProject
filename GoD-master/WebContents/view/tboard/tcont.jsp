<%@page import="java.util.ArrayList"%>
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
//페이징 부분
  var totalData = ${totalData};    // 총 데이터 수 ${totalData}
  var dataPerPage = ${dpp};    // 한 페이지에 나타낼 데이터 수 ${dpp}
  if(totalData<100){
	  var pageCount = Math.ceil(totalData/dataPerPage);  
  } else{
      var pageCount = 10;        // 한 화면에 나타낼 페이지 수
  }


  function paging(totalData, dataPerPage, pageCount, currentPage){
  
    console.log("currentPage : " + currentPage);
  
    var totalPage = Math.ceil(totalData/dataPerPage);    // 총 페이지 수
    var pageGroup = Math.ceil(currentPage/pageCount);    // 페이지 그룹
  
    console.log("pageGroup : " + pageGroup);
  
    var last = pageGroup * pageCount;    // 화면에 보여질 마지막 페이지 번호
    if(last > totalPage)
      last = totalPage;
    var first = last - (pageCount-1);    // 화면에 보여질 첫번째 페이지 번호
    var next = last+1;
    var prev = first-1;
  
    console.log("last : " + last);
    console.log("first : " + first);
    console.log("next : " + next);
    console.log("prev : " + prev);

    var $pingingView = $("#cmtPaging");
  
    var html = "";
  
    if(prev > 0)
        html += "<a href='#' id='prev'><</a> ";
  
    for(var i=first; i <= last; i++){
        html += "<a href='#' id=" + i + ">" + i + "</a> ";
    }
  
    if(last < totalPage)
        html += "<a href=# id='next'>></a>";
  
    $("#cmtPaging").html(html);    // 페이지 목록 생성
    $("#cmtPaging a").css("color", "black");
    $("#cmtPaging a#" + currentPage).css({"text-decoration":"none", 
                                       "color":"red", 
                                       "font-weight":"bold"});    // 현재 페이지 표시
                                     
     
    $("#cmtPaging a").click(function(){
      
      var $item = $(this);
      var $id = $item.attr("id");
      var selectedPage = $item.text();
      console.log($id);
      if($id == "next")    selectedPage = next;
      if($id == "prev")    selectedPage = prev;
      
      paging(totalData, dataPerPage, pageCount, selectedPage);
      
      if($id=="next"||$id=="prev"){
      	console.log('none');
      } else{
      		
      	$.ajax({  // ajax
      		   url:'/tboard?cmd=TBCMTPAGINGACTION',		
      		   data:{ currentpage:$id,
      		   		  dpp:dataPerPage,
      		   		  boardNum:${tboardVo.tbNum},
      		   aa: new Date() //304 방지용 dummy data
      		   },
      		   dataType:'json'
      	}).done(function( json ){
      		console.log(json);
      		let tag='';
      		  var totalData = json.total;    // 총 데이터 수 ${totalData}
      		  var dataPerPage = json.dpp;    // 한 페이지에 나타낼 데이터 수 ${dpp}
      		 
      		  if(totalData<100){
      			  var pageCount = Math.ceil(totalData/dataPerPage);  
      		  } else{
      		  var pageCount = 10;        // 한 화면에 나타낼 페이지 수
      			  
      		  }
      		 
      		
      		  var cnt=1;
      		  json.cmtList.forEach(function(cmtVo,index){
      			  console.log(cmtVo.cmtNum);
      			  tag+='<tr>';
      			        tag+='<input type="hidden" id="cmtNum'+cnt+'" value="'+cmtVo.cmtNum+'"/>';
      			      tag+='<td><p id="cmtNick'+cnt+'" class="cmtNick">'+cmtVo.cmtNick+'</p><p class="cmtDate">'+cmtVo.cmtDate+'</p>';
						tag+= '<a class="reportc'+cnt+'" id="reportc" href="#">신고</a>';
						tag+= '<a class="cmtDel'+cnt+'" onclick="cmtDelete2('+cmtVo.cmtNum+')" id="cmtdelete" href="#">삭제</a><br>';
						tag+= '<textarea class="cmt" id="cmtbox'+cnt+'" disabled>'+ cmtVo.cmtCont+'</textarea></td>';
						tag+='</tr>';
						cnt=cnt+1;
      			  
      		  });
      		
				$('.comment #cmtCnt').html('&nbsp;&nbsp;&nbsp;&nbsp;댓글('+json.total+')')
				$('.cmtlist').html(tag);
				
			}).fail( function(xhr ){
				alert(xhr.status+''+xhr.statusText);
			 }) //ajax
      	
      	} //다음과 이전 버튼이 아닌 경우  
  })  //페이징 클릭시
      	
     
  
                                     
} //페이징 함수 끝
	//textarea가 페이지가 열린 뒤 시간을 두고 자동증가하는 함수
	function resize(obj) {
		obj.style.height = "300px";
 		obj.style.height = (12+obj.scrollHeight)+"px";
	}
	function resize2(obj) {
		if(obj!=null){
	    obj.style.height = "100px";
	    obj.style.height = (12+obj.scrollHeight)+"px";
			
		}
	}

	// 댓글 삭제
	function cmtDelete(tbcNum){
		console.dir(tbcNum);
		$.ajax({
			url:'/tboard?cmd=COMMENTDELETEACTION',
			data:{  tbNum  : ${tboardVo.tbNum},
					tbcNum : tbcNum.value },
			dataType:'json',
			success:function( json ){
				let tag='';
        		  var totalData = json.total;    // 총 데이터 수 ${totalData}
        		  var dataPerPage = json.dpp;    // 한 페이지에 나타낼 데이터 수 ${dpp}
        		 
        		  if(totalData<100){
        			  var pageCount = Math.ceil(totalData/dataPerPage);  
        		  } else{
        		  var pageCount = 10;        // 한 화면에 나타낼 페이지 수
        		  paging(totalData, dataPerPage, pageCount, 1);
        		  }
        		  
        		
        		  var cnt=1;
        		  json.cmtList.forEach(function(cmtVo,index){
        			  console.log(cmtVo.cmtCont);
        			  tag+='<tr>';
        			    tag+='<input type="hidden" id="cmtNum'+cnt+'" value="'+cmtVo.cmtNum+'"/>';
        			    tag+='<td><p id="cmtNick'+cnt+'" class="cmtNick">'+cmtVo.cmtNick+'</p><p class="cmtDate">('+cmtVo.cmtDate+')</p>';
						tag+= '<a class="reportc'+cnt+'" id="reportc" href="#">신고</a>';
						tag+= '<a class="cmtDel'+cnt+'" onclick="cmtDelete2('+cmtVo.cmtNum+')" id="cmtdelete" href="#">삭제</a><br>';
						tag+= '<textarea class="cmt" id="cmtbox'+cnt+'" disabled>'+ cmtVo.cmtCont+'</textarea></td>';
						tag+='</tr>';
						cnt=cnt+1;
        			  
        		  });
        		
        		$('.comment #cmtCnt').html('&nbsp;&nbsp;&nbsp;&nbsp;댓글('+json.total+')');
				$('.cmtlist').html(tag);
				$('.cmtCont').val(' ');
				displayUpdate();
				
				
			},
			error:function(xhr){
				alert(xhr.status+''+xhr.statusText);
			}
		})
	}
	// 댓글 삭제(페이징 대응)
	function cmtDelete2(tbcNum){
		console.log('댓글번호:'+tbcNum);
		$.ajax({
			url:'/tboard?cmd=COMMENTDELETEACTION',
			data:{  tbNum  : ${tboardVo.tbNum},
					tbcNum : tbcNum },
			dataType:'json',
			success:function( json ){
				let tag='';
        		  var totalData = json.total;    // 총 데이터 수 ${totalData}
        		  var dataPerPage = json.dpp;    // 한 페이지에 나타낼 데이터 수 ${dpp}
        		  console.log(totalData);
        		  if(totalData<100){
        			  var pageCount = Math.ceil(totalData/dataPerPage);  
        		  } else{
        		  var pageCount = 10;        // 한 화면에 나타낼 페이지 수
        		  paging(totalData, dataPerPage, pageCount, 1);
        		  }
        		  
        		
        		  var cnt=1;
        		  json.cmtList.forEach(function(cmtVo,index){
        			  console.log(cmtVo.cmtCont);
        			  tag+='<tr>';
        			    tag+='<input type="hidden" id="cmtNum'+cnt+'" value="'+cmtVo.cmtNum+'"/>';
        			    tag+='<td><p id="cmtNick'+cnt+'" class="cmtNick">'+cmtVo.cmtNick+'</p><p class="cmtDate">('+cmtVo.cmtDate+')</p>';
						tag+= '<a class="reportc'+cnt+'" id="reportc" href="#">신고</a>';
						tag+= '<a class="cmtDel'+cnt+'" onclick="cmtDelete2('+cmtVo.cmtNum+')" id="cmtdelete" href="#">삭제</a><br>';
						tag+= '<textarea class="cmt" id="cmtbox'+cnt+'" disabled>'+ cmtVo.cmtCont+'</textarea></td>';
						tag+='</tr>';
						cnt=cnt+1;
        			  
        		  });
        		
        		$('.comment #cmtCnt').html('&nbsp;&nbsp;&nbsp;&nbsp;댓글('+json.total+')');
				$('.cmtlist').html(tag);
				$('.cmtCont').val(' ');
				displayUpdate();
				
				
			},
			error:function(xhr){
				alert(xhr.status+''+xhr.statusText);
			}
		})
	}
	function displayUpdate(){
		//로그인 닉네임과 작성자 닉네임이 동일 시 좋아요,신고 제거 + 수정,삭제 등장
		let nick = '${LoginNick}';
		if(${ tboardVo.nickName }==nick){
			$('#like').css('display','none');
			$('#reportb').css('display','none');
			$('#boardUpdate').css('display','flex');
			$('#boardDelete').css('display','flex');
			
		}
		//로그인 아이디의 좋아요 기록이 존재하면 좋아요 취소가 활성화
		if(${record}==1){
			$('#like').css('display','none');
			$('#likeCancel').css('display','flex');
		}
		//조건 충족 시 모든 삭제 활성화
		if( ${uLevel}>=900){
			$('#boardDelete').css('display','flex');
			$('#cmtdelete').css('display','flex');
		}
		//댓글 작성자 = 로그인아이디 일 때 댓글신고 비활성화, 댓글삭제 활성화(1~10)
		if($('#cmtNick1').text()=='${LoginNick}' ){
			$('.cmtDel1').css('display','flex');
			$('.reportc1').css('display','none');
		}
		if($('#cmtNick2').text()=='${LoginNick}' ){
			$('.cmtDel2').css('display','flex');
			$('.reportc2').css('display','none');
		}
		if($('#cmtNick3').text()=='${LoginNick}' ){
			$('.cmtDel3').css('display','flex');
			$('.reportc3').css('display','none');
		}
		if($('#cmtNick4').text()=='${LoginNick}' ){
			$('.cmtDel4').css('display','flex');
			$('.reportc4').css('display','none');
		}
		if($('#cmtNick5').text()=='${LoginNick}' ){
			$('.cmtDel5').css('display','flex');
			$('.reportc5').css('display','none');
		}
		if($('#cmtNick6').text()=='${LoginNick}' ){
			$('.cmtDel6').css('display','flex');
			$('.reportc6').css('display','none');
		}
		if($('#cmtNick7').text()=='${LoginNick}' ){
			$('.cmtDel7').css('display','flex');
			$('.reportc7').css('display','none');
		}
		if($('#cmtNick8').text()=='${LoginNick}' ){
			$('.cmtDel8').css('display','flex');
			$('.reportc8').css('display','none');
		}
		if($('#cmtNick9').text()=='${LoginNick}' ){
			$('.cmtDel9').css('display','flex');
			$('.reportc9').css('display','none');
		}
		if($('#cmtNick10').text()=='${LoginNick}' ){
			$('.cmtDel10').css('display','flex');
			$('.reportc10').css('display','none');
		}
	}
	
	// $(function)-------------------------------
    $(function() {      
    	paging(totalData, dataPerPage, pageCount, 1 );
      
	
	//textarea 자동 크기 증가(각자 걸어줘야 됨...)
	$('#bcont').on('keyup',function(e){
		$(this).css('height', '100' );
		$(this).height(this.scrollHeight);
	});
	$('.bcont').on('keyup',function(e){
		$(this).css('height', '100' );
		$(this).height(this.scrollHeight);
	});
	//부드러운 textarea 증가(페이지 열리고 1초뒤 사이즈 변경)
	setTimeout(function() {resize($("#bcont")[0]); },1000);
	setTimeout(function() {resize2($(".bcont")[0]); },1000);
	setTimeout(function() {resize2($(".bcont")[1]); },1000);
	setTimeout(function() {resize2($(".bcont")[2]); },1000);
	
	//권한에 따른 설정 변경
	displayUpdate();
	
	
		
		
	// 좋아요 클릭(게시물)
	$('#like').on('click',function(){
		console.log('like');
		$.ajax({
			url:'/tboard?cmd=LIKEUPDATEACTION',
			data:{ boardNum : ${tboardVo.tbNum} }, 
			dataType:'json',
			success:function( json ){
				$('#likeCnt').text('추천수:'+json.likeCnt);
				$('#like').css('display','none');
				$('#likeCancel').css('display','flex');
			},  // 좋아요 수 업데이트 + 좋아요 버튼을 좋아요 취소버튼으로 변경할 필요가 있음...
			error:function(xhr){
				alert(xhr.status+''+xhr.statusText);
			}
		})
	})//좋아요 버튼 끝
		
	// 좋아요 취소(게시물)
	$('#likeCancel').on('click',function(){
		console.log('like Cancel');
		$.ajax({
			url:'/tboard?cmd=LIKEDELETEACTION',
			data:{ boardNum : ${tboardVo.tbNum} }, 
			dataType:'json',
			success:function( json ){
				$('#likeCnt').text('추천수:'+json.likeCnt);
				$('#likeCancel').css('display','none');
				$('#like').css('display','flex');
			},  
			error:function(xhr){
				alert(xhr.status+''+xhr.statusText);
			}
		})
	})//좋아요 버튼 끝
		
		
		
		//어디에 신고가 들어가도 이곳의 값이 바뀌면 신고완료를 의미
		$('#reportComp').on('change',function(){
			alert('신고되었습니다');
		})
		
		
		//게시물 신고
		$('#reportb').on('click',function(){
			let loc = '/view/common/report.jsp?reportedId='+${ tboardVo.nickName };
			loc    += '&reportId='+${LoginNick}
			window.open(loc,200,200);
			
			//신고자(LoginId)와 피신고자의 아이디를 인자로 보내야 함.
			
		})//게시물 신고 버튼 끝
		//댓글 신고(1~10)(안되면....전부  onclick으로 바꾸고 function설정하는 수밖에)
		$('.reportc').on('click',function(){			
			let loc = '/view/common/report.jsp?reportedId='+$('#cmtNick1').text();
			loc    += '&reportId='+'${LoginNick}'
			window.open(loc,200,200);
		})//끝
		$('.reportc').on('click',function(){			
			let loc = '/view/common/report.jsp?reportedId='+$('#cmtNick2').text();
			loc    += '&reportId='+'${LoginNick}'
			window.open(loc,200,200);
		})//끝
		$('.reportc').on('click',function(){			
			let loc = '/view/common/report.jsp?reportedId='+$('#cmtNick3').text();
			loc    += '&reportId='+'${LoginNick}'
			window.open(loc,200,200);
		})//끝
		$('.reportc').on('click',function(){			
			let loc = '/view/common/report.jsp?reportedId='+$('#cmtNick4').text();
			loc    += '&reportId='+'${LoginNick}'
			window.open(loc,200,200);
		})//끝
		$('.reportc').on('click',function(){			
			let loc = '/view/common/report.jsp?reportedId='+$('#cmtNick5').text();
			loc    += '&reportId='+'${LoginNick}'
			window.open(loc,200,200);
		})//끝
		$('.reportc').on('click',function(){			
			let loc = '/view/common/report.jsp?reportedId='+$('#cmtNick6').text();
			loc    += '&reportId='+'${LoginNick}'
			window.open(loc,200,200);
		})//끝
		$('.reportc').on('click',function(){			
			let loc = '/view/common/report.jsp?reportedId='+$('#cmtNick7').text();
			loc    += '&reportId='+'${LoginNick}'
			window.open(loc,200,200);
		})//끝
		$('.reportc').on('click',function(){			
			let loc = '/view/common/report.jsp?reportedId='+$('#cmtNick8').text();
			loc    += '&reportId='+'${LoginNick}'
			window.open(loc,200,200);
		})//끝
		$('.reportc').on('click',function(){			
			let loc = '/view/common/report.jsp?reportedId='+$('#cmtNick9').text();
			loc    += '&reportId='+'${LoginNick}'
			window.open(loc,200,200);
		})//끝
		$('.reportc').on('click',function(){			
			let loc = '/view/common/report.jsp?reportedId='+$('#cmtNick10').text();
			loc    += '&reportId='+'${LoginNick}'
			window.open(loc,200,200);
		})//1~10까지의 신고 이벤트
		
		//댓글 작성
		$('#cmtSubmit').on('click',function(){
			$.ajax({
				url:'/tboard?cmd=COMMENTWRITEACTION',
				data:{comment:$('.cmtCont').val(),
					  boardNum : ${tboardVo.tbNum} },
				dataType:'json',
				success:function( json ){
					let tag='';
	        		  var totalData = json.total;    // 총 데이터 수 ${totalData}
	        		  var dataPerPage = json.dpp;    // 한 페이지에 나타낼 데이터 수 ${dpp}
	        		 
	        		  if(totalData<100){
	        			  var pageCount = Math.ceil(totalData/dataPerPage);  
	        		  } else{
	        		  var pageCount = 10;        // 한 화면에 나타낼 페이지 수
	        		  paging(totalData, dataPerPage, pageCount, 1);
	        		  }
	        		  
	        		
	        		  var cnt=1;
	        		  json.cmtList.forEach(function(cmtVo,index){
	        			  console.log(cmtVo.cmtCont);
	        			  tag+='<tr>';
							tag+='<input type="hidden" id="cmtNum'+cnt+'" value="'+cmtVo.cmtNum+'"/>';
							tag+='<td><p id="cmtNick'+cnt+'" class="cmtNick">'+cmtVo.cmtNick+'</p><p class="cmtDate">('+cmtVo.cmtDate+')</p>';
							tag+= '<a class="reportc'+cnt+'" id="reportc" href="#">신고</a>';
							tag+= '<a class="cmtDel'+cnt+'" onclick="cmtDelete2('+cmtVo.cmtNum+')" id="cmtdelete" href="#">삭제</a><br>';
							tag+= '<textarea class="cmt" id="cmtbox'+cnt+'" disabled>'+ cmtVo.cmtCont+'</textarea></td>';
							tag+='</tr>';
							cnt=cnt+1;
	        			  
	        		  });
	        		
	        		$('.comment #cmtCnt').html('&nbsp;&nbsp;&nbsp;&nbsp;댓글('+json.total+')');
					$('.cmtlist').html(tag);
					$('.cmtCont').val(' ');
					displayUpdate();
					
					
				},
				error:function(xhr){
					alert(xhr.status+''+xhr.statusText);
				}
			})
		}); // 댓글 작성
		
				
		//댓글 삭제(10개의 버튼을 모두 이벤트 등록...)
		$('.cmtDel1').on('click',function(){
			let tbcNum   = document.getElementById('cmtNum1');
			console.dir(tbcNum);
			cmtDelete(tbcNum);
		})
		$('.cmtDel2').on('click',function(){
			let tbcNum   = document.getElementById('cmtNum2');
			cmtDelete(tbcNum);
		})
		$('.cmtDel3').on('click',function(){
			let tbcNum   = document.getElementById('cmtNum3');
			cmtDelete(tbcNum);
		})
		$('.cmtDel4').on('click',function(){
			let tbcNum   = document.getElementById('cmtNum4');
			cmtDelete(tbcNum);
		})
		$('.cmtDel5').on('click',function(){
			let tbcNum   = document.getElementById('cmtNum5');
			cmtDelete(tbcNum);
		})
		$('.cmtDel6').on('click',function(){
			let tbcNum   = document.getElementById('cmtNum6');
			cmtDelete(tbcNum);
		})
		$('.cmtDel7').on('click',function(){
			let tbcNum   = document.getElementById('cmtNum7');
			cmtDelete(tbcNum);
		})
		$('.cmtDel8').on('click',function(){
			let tbcNum   = document.getElementById('cmtNum8');
			cmtDelete(tbcNum);
		})
		$('.cmtDel9').on('click',function(){
			let tbcNum   = document.getElementById('cmtNum9');
			cmtDelete(tbcNum);
		})
		$('.cmtDel10').on('click',function(){
			let tbcNum   = document.getElementById('cmtNum10');
			cmtDelete(tbcNum);
		})
		
		
		
	});
	

 
</script>
</head>
<body>
	<%@include file ="/view/common/header.jsp" %>
	<input type="hidden" id="reportComp"/>
	<table class="tboard">
	<caption>여행지 추천 게시판</caption>
	<tr>
	<td id="mainimage" rowspan="4"><img src="/uploadFiles/${ tboardVo.img1 }"></img></td>
	<td id="input"><p>NO:${ tboardVo.tbNum }</p>
	제목<br><input type="text" value="${ tboardVo.title }" disabled/></td>
	</tr>
	<tr>
	<td id="input">작성자<br><input type="text" value="${ tboardVo.nickName }" disabled/></td>
	</tr>
	<tr>
	<td id="input">주소<br><input type="text" value="${ tboardVo.addr }" disabled/></td>
	</tr>
	<tr>
	<td id="input"><p>조회수:${ tboardVo.readCnt }</p><p id="likeCnt">추천수:${ tboardVo.likeCnt }</p></td>
	</tr>
	<tr>
	<td colspan="2" id="contbox">
	<div id="content"><textarea class="tbcont" id="bcont" disabled>${ tboardVo.cont }</textarea><br>
		<div id="imagebox"><img src="/uploadFiles/${ tboardVo.img2 }"></img></div>
		<textarea class="bcont" id="bcont2" disabled>${ tboardVo.cont2 }</textarea><br>
	<c:if test="${ tboardVo.img3 ne '0' }">
		<div id="imagebox"><img src="/uploadFiles/${ tboardVo.img3 }"></img></div>
		<textarea class="bcont" id="bcont3" disabled>${ tboardVo.cont3 }</textarea><br>
	</c:if>
	<c:if test="${ tboardVo.img4 ne '0' }">
		<div id="imagebox"><img src="/uploadFiles/${ tboardVo.img4 }"></img></div>
		<textarea class="bcont" id="bcont4" disabled>${ tboardVo.cont4 }</textarea><br>
	</c:if>
	</div>
	</td>
	</tr>
	<tr>
	<td colspan="2" class="boardbtn">
	<a id="boardDelete" href="/tboard?cmd=TBOARDDELETEACTION&tbNum=${ tboardVo.tbNum }">삭제</a>
	<a id="boardUpdate" href="/tboard?cmd=TBOARDUPDATEFORM&tbNum=${ tboardVo.tbNum }">수정</a>
	<a id="reportb" href="#">신고</a>
	<a id="likeCancel" href="#">좋아요 취소</a>
	<a id="like" href="#">좋아요</a></td>
	</tr>
	
	</table>
	</form>
	<div class="comment">
	<div class="cmtwrite">
	<h2>댓글 작성(200자 이내)</h2>
	<textarea class="cmtCont" name ="cmtCont" maxlength="200"></textarea>
	<button id="cmtSubmit">작성 완료</button>
	</div>
	<table class="cmtlist">
	<h2 id="cmtCnt">&nbsp;&nbsp;&nbsp;&nbsp;댓글(${ tboardVo.cmtCnt })</h2>
	<c:forEach var="cmt" items="${ cmtList }">
	<c:set var="i" value="${ i+1 }"/>
	<tr>
	<input type="hidden" id="cmtNum${ i }" value="${cmt.cmtNum }"/>
	<td><p id="cmtNick${ i }" class="cmtNick">${ cmt.cmtWriter }<p><p class="cmtDate">(${ cmt.cmtdate })</p>
	<a class="reportc${ i }" id="reportc" href="#">신고</a>
	<a class="cmtDel${ i }" id="cmtdelete" href="#">삭제</a><br>
	<textarea class="cmt" disabled>${ cmt.cmtCont } </textarea></td>
	</tr>
	</c:forEach>
	<%-- <tr>
	<input type="hidden" name="cmtname${cmt.cmtNum }" value="${cmt.cmtNum }"/>
	<td><p id="cmtNick" class="cmtNick">코딩하는작성자</p>&nbsp;<p id="cmtDate" class="cmtDate">(2021.09.20 13:00)</p>
	<a id="cmtdelete" href="#">삭제</a><br>
	<a id="reportc" href="#">신고</a>
	<textarea class="cmt" disabled >${ cmt.cont } </textarea></td>
	</tr> --%>
	
	</table>
	<div id="cmtPaging"></div>
	</div>
</body>
</html>
