<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/nboard.css" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
var totalData = ${totalData};    // 총 데이터 수 ${totalData}
var dataPerPage = ${dpp};    // 한 페이지에 나타낼 데이터 수 ${dpp}
if(totalData<100){
	  var pageCount = Math.ceil(totalData/dataPerPage);  
} else{
var pageCount = 10;        
	  
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
  
  var $pingingView = $("#paging");
  
  var html = "";
  
  if(prev > 0)
	  html += "<a href=# id='prev' >"+"<"+"</a>";
  
  for(var i=first; i <= last; i++){
      html += "<a href='#' id=" + i + ">" + i + "</a> ";
  }
  
  if(last < totalPage)
      html += "<a href=# id='next'>"+">"+"</a>";
  
  $("#paging").html(html);   // 페이지 목록 생성
  $("#paging a").css({"color": "black",
	                  "width":"20px",
	                  "float":"left",
	                  "text-align":"center",
	                  "margin-top":"5px"});
  
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
      
      paging(totalData, dataPerPage, pageCount, selectedPage);
      
      if($id=="next"||$id=="prev"){
      	console.log('none action');
      } else{
      	
      $.ajax({
      	url:'/nboard?cmd=nboardPaging',
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
      		  
      		  var level = <%=request.getAttribute("level")%>
	
      		tag += '<caption>공지사항</caption>';
      	if(level >= 900){
			tag += '<tr>';
			tag += '<td colspan="4" style="border: 0"></td>';
			tag += '<th><a href="/nboard?cmd=nboardWrite">글 쓰기</a></th>';	
			tag +=	'</tr>';
      		  }
			
			tag += '<tr>';
			tag += '<th>번호</th>';
			tag += '<th>제목</th>';
			tag += '<th>작성자</th>';
			tag += '<th>작성일</th>';
			tag += '<th>조회수</th>';
			tag += '</tr>';
			
      		  json.nboard.forEach(function(nboard,index){
      			 console.dir(nboard.title);
					if(cnt==2){
					tag+='<div id="boardbox2">';
					
						
					} else{
					tag+='<div id="boardbox">';
						
					cnt=cnt+1;
					}
					
					
					tag +='<tr>'
					tag +='<td>'+ nboard.nbNum +'</td>';
					tag += '<td><a href="/nboard?cmd=nboardView&nb_num='+ nboard.nbNum + '&nb_nick='+nboard.nick+'">';
					tag +=  nboard.title+'</a></td>'
					tag+= '<td>'+ nboard.nick +'</td>';
					tag+= '<td>'+ nboard.date +'</td>' +'</div>';
					tag+= '<td>'+ nboard.cnt  +'</td>';
					tag+='</div>';
      			  
      		  });
      		
				
				$('#board').html(tag);
				
			}).fail( function(xhr ){
				alert(xhr.status+''+xhr.statusText);
			 }) //ajax
      	} //다음과 이전 버튼이 아닌 경우  
  })  //페이징 클릭시

                                     
}; //페이징 함수 끝


$(function() {        
  paging(totalData, dataPerPage, pageCount, 1);
});

</script>
</head>
<body>
	<div class="nb_header">
		<%@ include file="/view/common/header.jsp"%>
	</div>

	<table class="nboard" id="board">
		<tr>
			<caption>공지사항</caption>
		</tr>
		<%
		int level = (int) request.getAttribute("level");
		if (level >= 900) {
		%>
		<tr>
			<td colspan="4" style="border: 0"></td>
			<th><a href="/nboard?cmd=nboardWrite">글 쓰기</a></th>
		</tr>
		<%
		}
		%>

		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>

		<c:forEach var="nboard" items="${nboardList}">

			<tr>
				<td>${nboard.nb_num}</td>
				<td><a
					href="/nboard?cmd=nboardView&nb_num=${nboard.nb_num}&nb_nick=${nboard.mem_nick}">
						${nboard.nb_title}</a></td>
				<td>${nboard.mem_nick}</td>
				<td>${nboard.nb_date}</td>
				<td>${nboard.nb_cnt}</td>
			</tr>
		</c:forEach>
	</table>

	<div id="paging"
		style="margin: 0 auto; text-align: center; width: 10%; height: 30px;"></div>

</body>
</html>
