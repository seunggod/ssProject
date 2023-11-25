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
  var totalData = ${totalData};    // 총 데이터 수 ${totalData}
  var dataPerPage = ${dpp};    // 한 페이지에 나타낼 데이터 수 ${dpp}
  if(totalData<100){
	  var pageCount = Math.ceil(totalData/dataPerPage);  
  } else{
  var pageCount = 10;        // 한 화면에 나타낼 페이지 수(불변 예정)
  }
  var searchNum = ${searchNum};
  
  function paging(totalData, dataPerPage, pageCount, currentPage, searchNum, keyword){
    console.log("searchNum: "+searchNum);
    console.dir("keyword: "+keyword);
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
    var $pingingView = $("#paging");
    
    var html = "";
    
    if(prev > 0)
        html += "<a href='#' id='prev'><</a> ";
    
    for(var i=first; i <= last; i++){
        html += "<a href='#' id=" + i + ">" + i + "</a> ";
    }
    
    if(last < totalPage)
        html += "<a href=# id='next'>></a>";
    
    $("#paging").html(html);    // 페이지 목록 생성
    $("#paging a").css("color", "black");
    $("#paging a#" + currentPage).css({"text-decoration":"none", 
                                       "color":"red", 
                                       "font-weight":"bold"});    // 현재 페이지 표시
                                       
       
    $("#paging a").click(function(){
        
        var $item = $(this);
        var $id = $item.attr("id");
        var selectedPage = $item.text();
        console.log($id);
        if($id == "next")    selectedPage = next;
        if($id == "prev")    selectedPage = prev;
        
        paging(totalData, dataPerPage, pageCount, selectedPage, searchNum, keyword);
        console.log(searchNum);
        if($id=="next"||$id=="prev"){
        	console.log('none');
        } else{
        	if(searchNum!=0){
        		$.ajax({   // 검색 ajax
         		   url:'/tboard?cmd=SEARCHPAGINGACTION',	//검색용 cmd	
         		   data:{ currentpage:$id,
         		   		  dpp:dataPerPage,
         		   		  keyword:keyword,
         		   		  aa: new Date() //304 방지용 dummy data
         		   		  
         		   },
         		   datatype:'json'
         	}).done(function( json ){
         		let tag='';
         		  var totalData = json.total;    // 총 데이터 수 ${totalData}
         		  var dataPerPage = json.dpp;    // 한 페이지에 나타낼 데이터 수 ${dpp}
         		  
         		  if(totalData<100){
         			  var pageCount = Math.ceil(totalData/dataPerPage);  
         		  } else{
         		  var pageCount = 10;        // 한 화면에 나타낼 페이지 수
         			  
         		  }
         		  
         		  
         		  var cnt=1;
         		  json.tboard.forEach(function(tboard,index){
         			 console.dir(tboard.title);
 					if(cnt==2){
 					tag+='<div id="boardbox2">';
 					
 					} else{
 					tag+='<div id="boardbox">';
 						
 					cnt=cnt+1;
 					}
 					tag+='<div id="imagebox"><a href="/tboard?cmd=READBOARDCONT&boardNum='+tboard.tbNum+'">';
					tag+='<img src="/uploadFiles/'+tboard.img1+'"></img></a></div>';
					tag+= '<div id="listcont"><p>번호:'+ tboard.number +'</p>';
					tag+= '<p><a id="url" href="/tboard?cmd=READBOARDCONT&boardNum='+tboard.tbNum+'">'+tboard.title+'</a></p>';
					tag+= '<p>작성자:'+ tboard.nickname +'</p>';
					tag+= '<p>조회수:'+ tboard.readCnt  +'</p>';
					tag+= '<p>추천수:'+ tboard.likeCnt  +'</p>' ;
					tag+= '<p>작성일:'+ tboard.wDate    +'</p></div>';
					tag+='</div>';
         			  
         		  });
         		
 				
 				$('#tlist').html(tag);
 				
 			}).fail( function(xhr ){
 				alert(xhr.status+''+xhr.statusText);
 			 }) //ajax
        		
        		
        		
        	} // 검색 ajax 끝
        	else{
        	if(${odNum}!=3){ // 정렬 페이징
        		$.ajax({  // 게시판 목록 ajax
         		   url:'/tboard?cmd=BOARDSORTPAGINGACTION',		
         		   data:{ currentpage:$id,
         		   dpp:dataPerPage,
         		   odNum:${odNum},
         		   aa: new Date() //304 방지용 dummy data
         		   },
         		   datatype:'json'
         		}).done(function( json ){
         		let tag='';
         		  var totalData = json.total;    // 총 데이터 수 ${totalData}
         		  var dataPerPage = json.dpp;    // 한 페이지에 나타낼 데이터 수 ${dpp}
         		  
         		  if(totalData<100){
         			  var pageCount = Math.ceil(totalData/dataPerPage);  
         		  } else{
         		  var pageCount = 10;        // 한 화면에 나타낼 페이지 수
         			  
         		  }
         		  
         		  
         		  var cnt=1;
         		  json.tboard.forEach(function(tboard,index){
         			 console.dir(tboard.title);
 					if(cnt==2){
 					tag+='<div id="boardbox2">';
 					
 					} else{
 					tag+='<div id="boardbox">';
 						
 					cnt=cnt+1;
 					}
 					tag+='<div id="imagebox"><a href="/tboard?cmd=READBOARDCONT&boardNum='+tboard.tbNum+'">';
					tag+='<img src="/uploadFiles/'+tboard.img1+'"></img></a></div>';
					tag+= '<div id="listcont"><p>번호:'+ tboard.number +'</p>';
					tag+= '<p><a id="url" href="/tboard?cmd=READBOARDCONT&boardNum='+tboard.tbNum+'">'+tboard.title+'</a></p>';
					tag+= '<p>작성자:'+ tboard.nickname +'</p>';
					tag+= '<p>조회수:'+ tboard.readCnt  +'</p>';
					tag+= '<p>추천수:'+ tboard.likeCnt  +'</p>' ;
					tag+= '<p>작성일:'+ tboard.wDate    +'</p></div>';
					tag+='</div>';
         			  
         		  });
         		
 				
 				$('#tlist').html(tag);
 				
 			}).fail( function(xhr ){
 				alert(xhr.status+''+xhr.statusText);
 			 }) //ajax
        	} 
        	else{ // 일반 페이징
        	$.ajax({  // 게시판 목록 ajax
        		   url:'/tboard?cmd=BOARDPAGINGACTION',		
        		   data:{ currentpage:$id,
        		   dpp:dataPerPage,
        		   aa: new Date() //304 방지용 dummy data
        		   },
        		   datatype:'json'
        	}).done(function( json ){
        		let tag='';
        		  var totalData = json.total;    // 총 데이터 수 ${totalData}
        		  var dataPerPage = json.dpp;    // 한 페이지에 나타낼 데이터 수 ${dpp}
        		  
        		  if(totalData<100){
        			  var pageCount = Math.ceil(totalData/dataPerPage);  
        		  } else{
        		  var pageCount = 10;        // 한 화면에 나타낼 페이지 수
        			  
        		  }
        		  
        		  
        		  var cnt=1;
        		  json.tboard.forEach(function(tboard,index){
        			 console.dir(tboard.title);
					if(cnt==2){
					tag+='<div id="boardbox2">';
					
					} else{
					tag+='<div id="boardbox">';
						
					cnt=cnt+1;
					}
					tag+='<div id="imagebox"><a href="/tboard?cmd=READBOARDCONT&boardNum='+tboard.tbNum+'">';
					tag+='<img src="/uploadFiles/'+tboard.img1+'"></img></a></div>';
					tag+= '<div id="listcont"><p>번호:'+ tboard.number +'</p>';
					tag+= '<p><a id="url" href="/tboard?cmd=READBOARDCONT&boardNum='+tboard.tbNum+'">'+tboard.title+'</a></p>';
					tag+= '<p>작성자:'+ tboard.nickname +'</p>';
					tag+= '<p>조회수:'+ tboard.readCnt  +'</p>';
					tag+= '<p>추천수:'+ tboard.likeCnt  +'</p>' ;
					tag+= '<p>작성일:'+ tboard.wDate    +'</p></div>';
					tag+='</div>';
        			  
        		  });
        		
				
				$('#tlist').html(tag);
				
			}).fail( function(xhr ){
				alert(xhr.status+''+xhr.statusText);
			 }) //ajax
        	}
        	}
        	} //다음과 이전 버튼이 아닌 경우  
    })  //페이징 클릭시
    
    
    
                                       
} //페이징 함수 끝

function sortAction(){
	//추천
    if(${odNum}==1){
    	$('#sortbar li:nth-of-type(1)').css('color','red');
    	$('#sortbar li:nth-of-type(1)').css('font-weight','bold');
    }
    //조회
    if(${odNum}==2){
    	$('#sortbar li:nth-of-type(2)').css('color','red');
    	$('#sortbar li:nth-of-type(2)').css('font-weight','bold');
    }
    //날짜(기본)
    if(${odNum}==3){
    	$('#sortbar li:nth-of-type(3)').css('color','red');
    	$('#sortbar li:nth-of-type(3)').css('font-weight','bold');
    }                            	   
}
   

  $(function() {    
	  
    paging(totalData, dataPerPage, pageCount, 1 , 0 ,' ');
    //관리자는 모든 삭제 권한 가짐
    if(${uLevel}>=900){
    	$('.tboardDelete').css('display','flex');
    }
    
  
    
    // 정렬 표시
    sortAction();
    
    //검색을 했을때
    $('#searchok').on('click',function(){
    	console.log('success');
    	$.ajax({
    		url:'/tboard?cmd=TBOARDSEARCHACTION',
    		data:{ keyword:$('#keyword').val() } }).done(function( json ){
        	  var keyword= $('#keyword').val();
    	      let tag='';
    	      console.log(keyword);
      		  var totalData = json.total;    // 총 데이터 수 ${totalData}
      		  var dataPerPage = json.dpp;    // 한 페이지에 나타낼 데이터 수 ${dpp}
      		  var searchNum   = json.searchNum; //검색 식별 번호
      		  if(totalData<100){
      			  var pageCount = Math.ceil(totalData/dataPerPage);  
      		  } else{
      		  var pageCount = 10;        // 한 화면에 나타낼 페이지 수
      			  
      		  }
      		 paging(totalData, dataPerPage, pageCount, 1, searchNum ,keyword); // 검색결과에 맞춰 페이징
      		  var cnt=1;
      		  json.tboard.forEach(function(tboard,index){
      			 console.dir(tboard.title);
					if(cnt==2){
					tag+='<div id="boardbox2">';
					
						
					} else{
					tag+='<div id="boardbox">';
						
					cnt=cnt+1;
					}
					
					tag+='<div id="imagebox"><a href="/tboard?cmd=READBOARDCONT&boardNum='+tboard.tbNum+'">';
					tag+='<img src="/uploadFiles/'+tboard.img1+'"></img></a></div>';
					tag+= '<div id="listcont"><p>번호:'+ tboard.number +'</p>';
					tag+= '<p><a id="url" href="/tboard?cmd=READBOARDCONT&boardNum='+tboard.tbNum+'">'+tboard.title+'</a></p>';
					tag+= '<p>작성자:'+ tboard.nickname +'</p>';
					tag+= '<p>조회수:'+ tboard.readCnt  +'</p>';
					tag+= '<p>추천수:'+ tboard.likeCnt  +'</p>' ;
					tag+= '<p>작성일:'+ tboard.wDate    +'</p></div>';
					tag+='</div>';
      			  
      		  });
      		
				
				$('#tlist').html(tag);
				
			}).fail( function(xhr ){
				alert(xhr.status+''+xhr.statusText);
			 }) //ajax
    	})
 
   $('#keyword').on('keyup',function(e){
	   if(e.keyCode==13){
		   $('#searchok').click();
	   }
	});//엔터 키로 검색
    
   //어디에 신고가 들어가도 이곳의 값이 바뀌면 신고완료를 의미
	$('#reportComp').on('change',function(){
		alert('신고되었습니다');
	})
   //신고 버튼을 눌렀을 때 (1~10)
   $('#tboardReport1').on('click',function(){
	   let loc = '/view/common/report.jsp?reportedId='+$('#tbwriter1').val();
	   loc    += '&reportId='+${LoginNick}
	   window.open(loc, 200, 200);
   })
   $('#tboardReport2').on('click',function(){
	   let loc = '/view/common/report.jsp?reportedId='+$('#tbwriter2').val();
	   loc    += '&reportId='+${LoginNick}
	   window.open(loc, 200, 200);
   })
   $('#tboardReport3').on('click',function(){
	   let loc = '/view/common/report.jsp?reportedId='+$('#tbwriter3').val();
	   loc    += '&reportId='+${LoginNick}
	   window.open(loc, 200, 200);
   })
   $('#tboardReport4').on('click',function(){
	   let loc = '/view/common/report.jsp?reportedId='+$('#tbwriter4').val();
	   loc    += '&reportId='+${LoginNick}
	   window.open(loc, 200, 200);
   })
   $('#tboardReport5').on('click',function(){
	   let loc = '/view/common/report.jsp?reportedId='+$('#tbwriter5').val();
	   loc    += '&reportId='+${LoginNick}
	   window.open(loc, 200, 200);
   })
   $('#tboardReport6').on('click',function(){
	   let loc = '/view/common/report.jsp?reportedId='+$('#tbwriter6').val();
	   loc    += '&reportId='+${LoginNick}
	   window.open(loc, 200, 200);
   })
   $('#tboardReport7').on('click',function(){
	   let loc = '/view/common/report.jsp?reportedId='+$('#tbwriter7').val();
	   loc    += '&reportId='+${LoginNick}
	   window.open(loc, 200, 200);
   })
   $('#tboardReport8').on('click',function(){
	   let loc = '/view/common/report.jsp?reportedId='+$('#tbwriter8').val();
	   loc    += '&reportId='+${LoginNick}
	   window.open(loc, 200, 200);
   })
   $('#tboardReport9').on('click',function(){
	   let loc = '/view/common/report.jsp?reportedId='+$('#tbwriter9').val();
	   loc    += '&reportId='+${LoginNick}
	   window.open(loc, 200, 200);
   })
   $('#tboardReport10').on('click',function(){
	   let loc = '/view/common/report.jsp?reportedId='+$('#tbwriter10').val();
	   loc    += '&reportId='+${LoginNick}
	   window.open(loc, 200, 200);
   })//신고 끝
   
	
	
		
   
   
  });
</script>
</head>
<body id="listcontainer">
	<%@include file = "/view/common/header.jsp" %>
	<input type="hidden" id="reportComp"/>
	<h2 id="tboardTitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;여행지 추천</h2>
	<div id="searchBox"><input id="keyword" type="text" name="keyword" /><button id="searchok">검색</button></div>
	<a id="writeButton" href="/tboard?cmd=TBOARDWRITEFORM" >게시물 작성</a>
	<ul id="sortbar">
	<li><a id="likesort" onclick="sortAction()"  href="/tboard?cmd=TBOARDLISTSORT&odNum=1">추천순</a></li>
	<li><a id="cntsort" href="/tboard?cmd=TBOARDLISTSORT&odNum=2">조회순</a></li>
	<li><a id="datesort" href="/tboard?cmd=TBOARDLISTFORM">날짜순</a></li></ul>
	<div id="tlist">
	<c:set var="i" value="1"/>
	<c:forEach var="boardVo" items="${ boardList }">
	<c:if test="${i eq '1' }">
	<div id="boardbox">
	</c:if>
	<c:if test="${i eq '2' }">
	<div id="boardbox2">
	</c:if>
	<c:set var="i" value="2"/>
	<c:set var="j" value="${ j+1 }"/>
	<div id="imagebox"><a href="/tboard?cmd=READBOARDCONT&boardNum=${ boardVo.tbNum }">
	<img src="/uploadFiles/${ boardVo.img1 }"></img></a></div>
	<input type="hidden" id="tbwriter${ j }" value="${ boardVo.nickName }"/>
	<div id="listcont">
	<a href="TBOARDDELETEACTION?tbNum=${ boardVo.tbNum }" id="tboardDelete${ j }" class="tboardDelete" >삭제</a>
	<a href="#" class="tboardReport" id="tboardReport${ j }">신고</a>
	<p>번호:${ boardVo.number }</p>
	<p><a id="url" href="/tboard?cmd=READBOARDCONT&boardNum=${ boardVo.tbNum }">${ boardVo.title }</a></p>
	<p>작성자:${ boardVo.nickName }</p>
	<p>조회수:${ boardVo.readCnt }</p>
	<p>추천수:${ boardVo.likeCnt }</p>
	<p>작성일:${ boardVo.wDate }</p>
	</div>
	</div>
	</c:forEach>
	</div>
	
	<%-- <div id="boardbox">
	<div id="imagebox"><a href="#">
	<img src="/uploadFiles/Desert.jpg"></img></a></div>
	<div id="listcont">
	<a href="TBOARDDELETEACTION?tbNum=${ boardVo.tbNum }" class="tboardDelete">삭제</a>
	<a href="" class="tboardReport" id="tboardReport">신고</a>
	<p>No:1</p>
	<p><a href="/tboard?cmd=READBOARDCONT">아름다운 풍경을 찾아서 떠나는 풍경여행</a></p>
	<p>작성자:</p>
	<p>조회수:</p>
	<p>추천수:</p>
	<p>작성일:</p>
	</div>
	</div> --%>
	
	
	
	<div id="paging"> </div>
	<%@include file = "/view/common/footer.jsp" %>
</body>
</html>
