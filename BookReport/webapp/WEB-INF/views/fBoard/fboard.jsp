<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독후감 공유 카페</title>
<link rel="stylesheet" href="/css/common.css" />
<style>
 table { margin:0px auto; background-color: black;}
 .searchbar { text-align: center; margin:100px 0 40px 0; }
 .searchbar h1 { color:orange; font-size:50px; }
 .searchbar input { width:400px;
 					height:30px;
 					margin-right:10px; }
 .searchbar button { width:100px;
 					 height:30px;
 					 background: orange; 
 					 border:none; 
 					 font-weight: bold;  }
 .searchbar select { height:30px; }
 table, td, th { border-bottom: 1px solid orange;
                 border-top:1px solid orange;
                 border-collapse: collapse;
                 color:orange;
                 text-align:center;
                 padding:5px; }
 td img { width:100px; height:100px; }
 td:nth-of-type(3) a { text-decoration: none; color:orange; }
 th a,td a { text-decoration: none; color:orange; }
 td { padding:10px;}
 td:nth-of-type(2), th:nth-of-type(2) { width:50px;}
 td:nth-of-type(3), th:nth-of-type(3) { width:500px;}
 td:nth-of-type(4), th:nth-of-type(4) { width:150px;}
 td:nth-of-type(5), th:nth-of-type(5) { width:100px;}
 td:nth-of-type(6), th:nth-of-type(6) { width:100px;}
 td:nth-of-type(7), th:nth-of-type(7) { width:150px;}
 #bWrite { position:absolute;
 		   margin:5px 28%; 
 		   background: orange; 
 		   border: none; 
 		   font-weight: bold; 
 		   font-size: 15px;
 		   }
 .searchbar b { margin:0.5% -35%; position:absolute; font-size: 20px; }
 #searchOption, option { font-weight:bold;}
 input[type=checkbox] { width:18px; height:18px;}
 #delete { float:right;
 		   margin-right:14.5%;
 		   text-align: center;
 		   width:80px;
 		   height:30px;
 		   background: black;
 		   color:red;
 		   border:none;
 		   font-weight: bold;
 		   font-size:15px;
 		   margin-top:5px;}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
   $(function(){
	   

	   var option = $('#searchOption')[0];
	   switch('${option}'){
	       case 'all': $(option[0]).prop('selected',true); break;
	       case 'titleAndCont': $(option[1]).prop('selected',true); break;
	       case 'nickname': $(option[2]).prop('selected',true); break;
	   }
	   
	   if('${keyword}' != ''){
		   $('#bWrite').css('margin-left','28%');
	   }
	  
	   //글쓰기
	   $('#bWrite').on('click',function(){
		   if('${ login.mem_id }'==''){
			   alert('로그인이 필요한 서비스입니다');
		   }
		   
		   location.href="/FBoard/WriteForm";
	   })//글쓰기 끝
	   
	   //검색 버튼 클릭 시
	   $('#search').on('click',function(){
		   var option = $('#searchOption').val();
		   switch(option){
		   		case '전체 검색'     :  var option = 'all';  break;
		   		case '글 제목 + 내용' :  var option = 'titleAndCont'; break;
		   		case '작성자'       :  var option = 'nickname'; break;
		   }
		   location.href='/FBoard/page/1?keyword='+$('#keyword').val()+'&option='+option;
	   })
	   
	   //enter 키로 검색 가능
	   $('#keyword').on('keyup',function(e){
		   if(e.keyCode==13){
			   $('#search').click();
		   }
		});
	   
	   //페이징 버튼 클릭 시  검색어 존재 시 검색어 포함
	   console.log('${writer}');
	   var keyword= '${keyword}';
	   console.log('keyword:'+keyword.trim());
	   $('.pageBtn').on('click',function(){
		    if('${keyword}'.trim() !=''){
		    	this.href += '?keyword='+'${keyword}&option=${option}&sort=${sort}&sortDetail=${sortDetail}';
		  	      	    
		   } 
		   //작성자를 정한 경우 
		   if('${writer}'!=''){
			   this.href += '?writer=${writer}&sort=${sort}&sortDetail=${sortDetail}';
			   
		   }
		   alert(this.href); 
	   })
	  
	   //분류 버튼을 눌렀을 경우
	   $('th a').on('click',function(){
		   var href ='/FBoard/page/1';
		   let check = false;
		   if($('#keyword').val() != ''){
		   		href += '?keyword='+$('#keyword').val()+'&option=${option}';
		   		check = true;
		   }
		   if('${writer}'!=''){
			   href +='?writer=${writer}';
			   check = true;
		   }
		   
		   this.href = href+(check? '&':'?')+'sort='+this.id;

		   if('${sort}'== this.id){
			  console.log('${sortDetail}');
			  if('${sortDetail}'=='true')
		      	  this.href +='&sortDetail=false';
			  else if('${sortDetail}'=='false')
				  this.href +='&sortDetail=true';
		   } 
	   })
	   
	   //모두 체크 클릭 시
	   $('#allCheckbox').on('click',e=>{
		   console.dir($('#allCheckbox').is(':checked'));
		   if($('#allCheckbox').is(':checked'))
			   $('.checkbox').prop('checked',true);
		   else
		   	   $('.checkbox').prop('checked',false);
			   
	   })
	   
	   //선택 항목 삭제
	   $('#delete').on('click',e=>{
		   if(confirm('선택한 게시물을 삭제하시겠습니까?')){

			   if($('.checkbox:checked').length== 0){
				   alert('삭제할 항목이 없습니다');
				   return false;
			   }
			   
			   let arr = new Array();
			   for (var i = 0; i < $('.checkbox:checked').length; i++) {
				let checkbox = $('.checkbox:checked')[i];
				arr.push($(checkbox).parent().next().text());
			   }
			   let json = {free_num_list:arr};
			   
			   $.ajax({
				   url:'/FBoard/DeleteAjax',
				   data:JSON.stringify(json),
				   type:'POST',
				   accept:'application/json',
				   contentType:'application/json;charset=UTF-8'
				   }).done(()=>{
					   
				   }).fail((data, textStatus, errorThrown)=>{
					   alert('Error:삭제에 실패했습니다');
				   }).always(()=>{window.location.reload()})
		   }
	   })
	   
	   
   })
</script>
</head>
<body>
  <%@ include file="/WEB-INF/include/header.jsp" %>
  <div class="searchbar">
    <h1>자유 게시판</h1>
    <select id="searchOption">
      <option>전체 검색</option>
      <option>글 제목 + 내용</option>
      <option>작성자</option>
    </select>
    <input type="text" id="keyword" value="${ keyword }"/><button id="search">Search</button>
    <br/>
    <c:if test="${keyword ne null}">
    <b>"${ keyword }"검색 결과: ${ totalcount }개</b>
    </c:if>
    <button id="bWrite" >글쓰기</button>
  </div>
    <table>
      <tr>
        <c:choose>
      	<c:when test="${ login.mem_lvl >= 100 }">
      	<th><input type="checkbox" id="allCheckbox"/></th>
      	</c:when>
      	<c:otherwise>
      	<th>&nbsp;</th>
      	</c:otherwise>
      	</c:choose>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th><a id="readcount" href="">조회수</a></th>
        <th><a id="likecount" href="">추천수</a></th>
        <th><a id="regdate" href="">작성일</a></th>
      </tr>
      <c:forEach var="board" items="${ boardList }">
      <tr>
        <c:choose>
      	<c:when test="${ login.mem_lvl >= 100 }">
      	<td><input type="checkbox" class="checkbox"/></td>
      	</c:when>
      	<c:otherwise>
      	<td>&nbsp;</td>
      	</c:otherwise>
      	</c:choose>
        <td>${ board.board_num }</td>
        <td><b><a href="/FBoard/View/page/${ nowpage }/bno/${board.board_num}">${ board.board_title }</a>
        </b>&nbsp;[ ${ board.replycount } ]
        </td>
        <td><a href="/FBoard/page/1?writer=${board.board_writer}">${ board.board_writer }</a></td>
        <td>${ board.readcount }</td>
        <td>${ board.likecount }</td>
        <td>${ board.regdate }</td>
      </tr>
      </c:forEach>
      <c:if test="${ totalcount eq 0 }">
      <tr>
        <td colspan="6"><b>검색된 자료가 없습니다</b></td>
      </tr>
      </c:if>
      
    </table>
    <c:if test="${ login.mem_lvl >= 100 }">
    <button id="delete">선택삭제</button>
    </c:if>
    <c:set  var="href"  value="/FBoard/page/"/>
    <%@ include file="/WEB-INF/include/paging.jsp" %>
</body>
</html>