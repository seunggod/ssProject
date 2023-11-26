<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독후감 공유 카페</title>
<link rel="stylesheet" href="/css/common.css"/>
<style>
 h1, h2 { color:orange;}
 .myProfile,  .bboard { margin:0 auto;  width:900px;}
 .myProfile,td,th, .bboard { border: 1px solid black; border-collapse: collapse;}
 td, th { padding:10px;}
 th { background: orange;}
 img { width:80px; height:80px;}
 th:nth-of-type(3) { width:230px; }
 .boardList {  display: block; margin:50px auto 500px; width:900px; height:800px;}
 .boardList div { border:1px solid black; display: block;  width:900px; }
 .boardBtns a { text-decoration: none; font-weight: bold;  }
 .page { font-size:20px; font-weight:bold; cursor:pointer;}
 .checkbox, #allCheckbox { width:20px; height:20px;}
 .center, .submit { text-align:center;}
 .bboard { text-align: center;}
 input::-webkit-outer-spin-button,
 input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
button { border:none; background: orange; font-weight: bold; border-radius:5px; }
/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}
 #address { width:600px; padding:5px; margin-bottom:3px;}
 
</style>
<script>
//페이징
const paging = (nowpage,totalData)=>{
    let html ='';
	
	html += '<tr>';
	html += '<td id="paging" colspan="8">';
	
	if(totalData<50){
    	var pageCount =  Math.ceil( totalData / 5 ); 
    	var totalPage =  pageCount;
	} else {
		var pageCount = 10;
		var totalPage = Math.ceil( totalData / 5 );
	}
	if(pageCount == 0)
		var pageGroup = 0;
	else
		var pageGroup = Math.ceil(nowpage/pageCount);    
	console.log('totalData:'+totalData);
	console.log('pageCount:'+pageCount);
	console.log('pageGroup:'+pageGroup);
	console.log('totalPage:'+totalPage);
	var totalPageGrp = Math.ceil(totalPage/10);
	console.log('totalPageGrp:'+totalPageGrp);
	if(pageGroup>1)
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
	
    return html;
}

//후기게시판 그리기 sort - 1:내 게시물 2:좋아요 게시물
const writeBBoard = (result,nowpage,sort)=>{
	let html = '<table class="bboard">';
	if(sort == 1)
		html+='<caption><h2>내가 쓴 후기게시판 게시물</h2></caption>';
	else if(sort == 2)
		html+='<caption><h2>좋아요한 후기게시판 게시물</h2></caption>';
		
    html+='<tr>';
    html+='<th><input type="checkbox" id="allCheckbox"/></th>';
    html+='<th>번호</th>';
    html+='<th>책 이미지</th>';
    html+='<th>책 제목/제목</th>';
    html+='<th>작성자</th>';
    html+='<th><a id="readcount" href="">조회수</a></th>';
    html+='<th><a id="likecount" href="">추천수</a></th>';
    html+='<th><a id="regdate" href="">작성일</a></th>';
    html+='</tr>';
    for (let i = 0; i < result.list.length; i++) {
		let bboard = result.list[i];
		
    	html+='<tr>';

    	html+='<td><input type="checkbox" class="checkbox" id="checkbox'+ i +'"/></td>'
    	html+='<td>'+ bboard.board_num +'</td>';
    	html+='<td><img src="'+ bboard.book_image +'" alt="이미지 없음"/></td>';
    	html+='<td>[&nbsp;'+ bboard.book_title + '&nbsp;]<br/>';
		html+='<b><a href="/BBoard/View/page/${ nowpage }/bno/'+ bboard.board_num +'">'+ bboard.board_title +'</a></b>&nbsp;[ '+ bboard.replycount +']';
		html+='</td>';
		html+='<td>'+ bboard.board_writer +'</td>';
		html+='<td>'+ bboard.readcount +'</td>';
		html+='<td>'+ bboard.likecount +'</td>';
		html+='<td>'+ bboard.regdate +'</td>';
		html+='</tr>';
		
		
	} 
    if(result.list.length == 0) {
		html+='<tr>';
		html+='<td colspan="8"><b>검색된 자료가 없습니다</b></td>';
		html+='</tr>';
	}
    html+='<tr>';
    if(sort == 1)
    	html+='<td colspan="8"><button id="deleteBoard">선택된 게시물 삭제</button></td>';
    else if(sort == 2)
    	html+='<td colspan="8"><button id="boardLikeCancel">선택 게시물 좋아요 취소</button></td>';
    html+='</tr>';
    const totalData = result.totalcount;
    
    html+= paging(nowpage,totalData);
    
    const board = document.getElementsByClassName('boardDiv')[0];
	board.innerHTML = '';
	board.innerHTML += html;
	const page = document.getElementById('page'+nowpage);
	if(page!=null)
		page.style.color = 'orange';
    
    
}

//자유게시판 그리기 sort - 1:내 게시물 2:좋아요 게시물
const writeFBoard = (result,nowpage,sort)=>{
	let html = '<table class="bboard">';
	if(sort == 1)
		html+='<caption><h2>내가 쓴 자유게시판 게시물</h2></caption>';
	else if(sort == 2)
		html+='<caption><h2>좋아요한 자유게시판 게시물</h2></caption>';
		
    html+='<tr>';
    html+='<th><input type="checkbox" id="allCheckbox"/></th>';
    html+='<th>번호</th>';
    html+='<th>제목</th>';
    html+='<th>작성자</th>';
    html+='<th><a id="readcount" href="">조회수</a></th>';
    html+='<th><a id="likecount" href="">추천수</a></th>';
    html+='<th><a id="regdate" href="">작성일</a></th>';
    html+='</tr>';
    for (let i = 0; i < result.list.length; i++) {
		let bboard = result.list[i];
		
    	html+='<tr>';

    	html+='<td><input type="checkbox" class="checkbox" id="checkbox'+ i +'"/></td>'
    	html+='<td>'+ bboard.board_num +'</td>';
    	html+='<td><b><a href="/FBoard/View/page/${ nowpage }/bno/'+ bboard.board_num +'">'+ bboard.board_title +'</a></b>&nbsp;[ '+ bboard.replycount +']';
		html+='</td>';
		html+='<td>'+ bboard.board_writer +'</td>';
		html+='<td>'+ bboard.readcount +'</td>';
		html+='<td>'+ bboard.likecount +'</td>';
		html+='<td>'+ bboard.regdate +'</td>';
		html+='</tr>';
		
		
	} 
    if(result.list.length == 0) {
		html+='<tr>';
		html+='<td colspan="7"><b>검색된 자료가 없습니다</b></td>';
		html+='</tr>';
	}
    html+='<tr>';
    if(sort == 1)
    	html+='<td colspan="7"><button id="deleteBoard">선택된 게시물 삭제</button></td>';
    else if(sort == 2)
    	html+='<td colspan="7"><button id="boardLikeCancel">선택 게시물 좋아요 취소</button></td>';
    html+='</tr>';
    const totalData = result.totalcount;
    
    html+= paging(nowpage,totalData);
    
    const board = document.getElementsByClassName('boardDiv')[0];
	board.innerHTML = '';
	board.innerHTML += html;
	const page = document.getElementById('page'+nowpage);
	if(page!=null)
		page.style.color = 'orange';
    
    
}

const replyList = (result,replypage)=>{
	console.dir('댓글리스트 구현필요');
}


//검색 ajax
const writeBoard = (nowpage, reqJson, href, sort)=>{
	 console.log('nowpage:'+nowpage);
	 console.dir(reqJson);
	  
	 let httpRequest = new XMLHttpRequest();
	 httpRequest.onreadystatechange = () => {
	 	if (httpRequest.readyState === XMLHttpRequest.DONE) {
			if (httpRequest.status === 200) {
				const result = httpRequest.response;
				switch(href){
				case '/BBoard/ProfileBBoardList': writeBBoard(result,nowpage,sort); break;
				case '/FBoard/ProfileFBoardList': writeFBoard(result,nowpage,sort); break;
				case '/Reply/ProfileReplyList'  : replyList(result,replypage); break;
				}
				
			} else {
				alert('목록을 불러오는데 실패했습니다');
			}
	 	}
	};
	
	httpRequest.open('POST', href , true);
	httpRequest.responseType = "json";
	httpRequest.setRequestHeader('Content-Type', 'application/json; charset:UTF-8');
	httpRequest.send(JSON.stringify(reqJson));

}//ajax 끝

//게시물 삭제
const boardDelete = (board,firstJson)=>{
	if( !confirm('게시물을 삭제하겠습니까?')){
		
	} else {
		let reqJson; //JSON
		let numberList = new Array(); //선택된 게시물번호를 담을 배열
		
		const checkedbox = document.querySelectorAll('.checkbox:checked');
		for (var i = 0; i < checkedbox.length; i++) {
			numberList.push(checkedbox[i].parentNode.nextSibling.innerText);
		}
		console.dir(numberList);
		let href='';
		//현재 목록의 상태에 따라 ajax로 들어갈 값이 달라짐
		switch(board){
		case 'bboard':href     = '/BBoard/DeleteAjax';
					  reqJson  = {board_num_list:numberList};
					  break;
		case 'fboard':href     = '/FBoard/DeleteAjax';
					  reqJson  = {free_num_list:numberList};
					  break;
		}
		
		//ajax
		let httpRequest = new XMLHttpRequest();
		httpRequest.onreadystatechange = () => {
		 	if (httpRequest.readyState === XMLHttpRequest.DONE) {
				if (httpRequest.status === 200) 
					alert('삭제되었습니다');
				else 
					alert('삭제에 실패했습니다');
				//목록 갱신
				switch(board){
				case 'bboard':writeBoard(1, firstJson, '/BBoard/ProfileBBoardList'); break;
				case 'fboard':writeBoard(1, firstJson, '/FBoard/ProfileFBoardList'); break;
				}
				

		 	}
		};
		
		httpRequest.open('POST', href , true);
		httpRequest.responseType = "json";
		httpRequest.setRequestHeader('Content-Type', 'application/json; charset:UTF-8');
		httpRequest.send(JSON.stringify(reqJson));
		//ajax 끝
	}
}

//좋아요 취소
const likeCancel = (board)=>{
	const checkedbox = document.querySelectorAll('.checkbox:checked');
	
	if( !confirm('좋아요를 취소하겠습니까?')){
		
	} else {
		//취소 후 목록 갱신을 위한 json
		let firstJson = { sort:'regdate',
						  like:'${login.mem_num}',
	 					  dpp:5,
						  nowpage:1};
		
		let reqJson; // ajax로 보낼 JSON
		let numberList = new Array(); //선택된 게시물번호를 담을 배열
		
		
		
			
		for (var i = 0; i < checkedbox.length; i++) {
			numberList.push(checkedbox[i].parentNode.nextSibling.innerText);
		}
		console.dir(numberList);
		let href='';
		//현재 목록의 상태에 따라 ajax로 들어갈 값이 달라짐
		switch(board){
		case 'bboardlike':href     = '/BBoard/LikeCancelAjax';
					  	  reqJson  = {boardNum:numberList,
					  			      mem_num:'${login.mem_num}'};
					  	  break;
		}
		
		//ajax
		let httpRequest = new XMLHttpRequest();
		httpRequest.onreadystatechange = () => {
		 	if (httpRequest.readyState === XMLHttpRequest.DONE) {
				if (httpRequest.status === 200) 
					alert('좋아요가 취소되었습니다');
				else 
					alert('좋아요 취소에 실패했습니다');
				//목록 갱신
				writeBoard(1, firstJson, '/BBoard/ProfileBBoardList');
		 	}
		};
		
		httpRequest.open('POST', href , true);
		httpRequest.responseType = "json";
		httpRequest.setRequestHeader('Content-Type', 'application/json; charset:UTF-8');
		httpRequest.send(JSON.stringify(reqJson));
		//ajax 끝
	}
	
	
	
	
}

let nickCheck = true; //true:사용 가능 false:중복
//닉네임 중복 체크
const nickDupCheck = (nickname)=>{
	console.dir(nickname);
	let reqJson={nickname:nickname}; //JSON
	let href='';
	
	//ajax
	let httpRequest = new XMLHttpRequest();
	httpRequest.onreadystatechange = () => {
	 	if (httpRequest.readyState === XMLHttpRequest.DONE) {
			if (httpRequest.status === 200){
				const result = httpRequest.response;
				if(result == 0){
					alert('사용가능');
					nickCheck = true;
				} else if(result == 1){
					alert('중복된 닉네임');
					nickCheck = false;
					console.log(nickCheck);
				}
			} else 
				alert('ERROR:['+httpRequest.status)+']';
			
	 	}
	 	
	};
	httpRequest.open('GET', '/NickDupCheck?nickname='+nickname , true);
	httpRequest.responseType = "text";
	httpRequest.setRequestHeader('Content-Type', 'application/text; charset:UTF-8');
	httpRequest.send();
	//ajax 끝
	
}





 window.onload = function(){
	 
	//회원 정보 수정으로 온 경우
	if('${update}'=='true')
		alert('회원 정보 수정이 완료되었습니다');

	//전화번호 입력
	let tel = '${ userVo.mem_tel }';
	for (let i = 1; i <= tel.split('-').length; i++) {
		let telNum = document.getElementById('tel'+(i));
		telNum.value = tel.split('-')[i-1];
	}
	//생년월일 입력
	let birth = '${ userVo.birth}';
	console.dir(birth);
	const birthday = document.getElementById('birth');
	console.dir(birthday);
	birthday.innerHTML = birth.split('-')[0]+'년 ';
	birthday.innerHTML+= birth.split('-')[1].replace(/(^0+)/, '')+'월 ';
	birthday.innerHTML+=  birth.split('-')[2].replace(/(^0+)/, '')+'일';
	
	//비밀번호 변경 클릭
	const pwdChangeBtn = document.getElementById('pwdChange');
	const pwdChange = e=>{
		e.stopPropagation();
	  	e.preventDefault();
		location.href = "/User/PwdChangeForm/";
	}
	pwdChangeBtn.addEventListener('click', pwdChange);
	
	
	
	//후기 게시판 불러오기
	const firstJson =  { writer:'${login.nickname}',
	  		  			 sort:'regdate',
	  		  			 dpp:5,
	  	      			 nowpage:1};
	writeBoard(1, firstJson, '/BBoard/ProfileBBoardList', 1);
	

	
	
	//회원 탈퇴 기능
	const withdrawalBtn = document.getElementById('withdrawal');
	const withdrawal = e=>{
		e.stopPropagation();
	  	e.preventDefault();
		if(confirm('정말 탈퇴하시겠습니까?'))
			location.href="/User/Withdrawal";
	}
	withdrawalBtn.addEventListener('click', withdrawal );
	
	
	//닉네임 중복 확인
	const nickDupCheckBtn = document.getElementById('nickDupCheck');
	const nickDupCheckFunc = e=>{
		e.stopPropagation();
	  	e.preventDefault();
		const nickname = document.getElementById('nickname');
		if('${userVo.nickname}'!= nickname.value){
			nickDupCheck(nickname.value);
			
		}
		
		
		
	}
	nickDupCheckBtn.addEventListener('click', nickDupCheckFunc);
	
	//수정 시 이벤트
	const form = document.querySelector('form');
	const checkForm = e=>{
	  	if(!confirm('수정하시겠습니까?')){
	  		e.stopPropagation();
		  	e.preventDefault();
	  	}else{ //유효성 검사
	  		if(nickCheck == 'flase'){
	  			e.stopPropagation();
			  	e.preventDefault();
	  		}
	  	};
	  	console.log(nickCheck);
	}
	form.addEventListener('submit', checkForm );
	
	
	
	//게시물 리스트
	const boardList = document.getElementsByClassName('boardList')[0];
	//현재 목록 상태:기본(후기 게시판)
	let board = 'bboard';
	//게시물 리스트 목록
	const boardEvent = e=>{
		console.dir(e.target);
		const checkedbox = document.querySelectorAll('.checkbox:checked');
		//게시판 설정
		switch(e.target.id){
		case 'getBBoard': board = 'bboard'; 
						  reqJson = { writer:'${login.nickname}',
					 				  sort:'regdate',
						 			  dpp:5,
									  nowpage:1};
	   					  href    = '/BBoard/ProfileBBoardList';
	   					  writeBoard(1, reqJson, href, 1);
	   					  e.stopPropagation();
	   			  		  e.preventDefault();
	   					  break;//후기 게시물 리스트
		case 'getBBoardLike': board = 'bboardlike'; 
		  					  reqJson = { 	sort:'regdate',
 				  							like:'${login.mem_num}',
	 			  							 dpp:5,
				  						 nowpage:1};
		  					  href    = '/BBoard/ProfileBBoardList';
		  					  writeBoard(1, reqJson, href, 2);
		  					  e.stopPropagation();
 		  					  e.preventDefault();
		  					  break;//후기 게시물 리스트
		case 'getFreeBoard': board = 'fboard'; 
							 reqJson = { writer:'${login.nickname}',
						 			     sort:'regdate',
							 			 dpp:5,
										 nowpage:1};
							 href    = '/FBoard/ProfileFBoardList';
							 writeBoard(1, reqJson, href, 1);
							 e.stopPropagation();
						     e.preventDefault();
							 break;//자유 게시물 리스트
		case 'getFBoardLike': board = 'fboardlike'; 
							  reqJson = { 	sort:'regdate',
											like:'${login.mem_num}',
											dpp:5,
										 	nowpage:1};
							  href    = '/FBoard/ProfileFBoardList';
							  writeBoard(1, reqJson, href, 2);
							  e.stopPropagation();
							  e.preventDefault();
							  break;//자유 게시물 리스트
		case 'getReply' : board = 'reply';
						  reqJson = { writer:'${login.nickname}',
								      board_num:'*',
					 			      dpp:5,
								      replypage:1};
						  href    = '/Reply/ProfileReplyList';
						  //writeBoard(1, reqJson, href);
						  e.stopPropagation();
						  e.preventDefault();
						  break;//댓글을 단 게시물리스트
		case 'allCheckbox': //모두 선택
			const checkbox = document.querySelectorAll('.checkbox');
			for (var i = 0; i < checkbox.length; i++) {
				checkbox[i].checked = e.target.checked;
			}
			break;
		case 'deleteBoard': if(checkedbox.length != 0){
								if(board=='bboard'){
									boardDelete(board,firstJson);
								}else if(board=='fboard') { 
									reqJson = { writer:'${login.nickname}',
			     								sort:'regdate',
	 			 								dpp:5,
				 								nowpage:1};
									boardDelete(board,reqJson);
								}
							} else {
								alert('선택된 게시물이 없습니다')} 
							break; //게시물 삭제 
		case 'boardLikeCancel':
			if(checkedbox.length != 0){likeCancel(board);}else {alert('선택된 게시물이 없습니다')} break; //게시물 좋아요 취소
		case '':
			
			
		} // id 별 이벤트 switch 끝
		
		
		//페이지 버튼 클릭 시
		if(e.target.className == 'page'){

			const nowpage = e.target.innerText;
			e.stopPropagation();
	  		e.preventDefault();
			let reqJson; //보낼 인자
			let href; //주소
			let sort; //좋아요한 게시물/내가 작성한 게시물 여부
			//클릭된 버튼이 <나 >였을 경우에는 현재 페이지 저장X
		  	if(nowpage=='<'||nowpage=='>'){
		  	    e.stopPropagation();
		  		e.preventDefault();
		  	} else {
		  		switch(board){
		  		case 'bboard': reqJson = { writer:'${login.nickname}',
				  		  				   sort:'regdate',
				  		  				   dpp:5,
				  	      				   nowpage:nowpage};
		  					   href    = '/BBoard/ProfileBBoardList';
		  					   sort    = 1;
		  					   break;
		  		case 'bboardlike': reqJson = { 	sort:'regdate',
 												like:'${login.mem_num}',
 							 					dpp:5,
						 						nowpage:nowpage};
			  				   href    = '/BBoard/ProfileBBoardList';
			  				   sort    = 2;
			  				   break;

		  		case 'fboard': reqJson = { writer:'${login.nickname}',
				  		  				   sort:'regdate',
				  		  				   dpp:5,
				  	      				   nowpage:nowpage};
		  					   href    = '/FBoard/ProfileFBoardList';
		  					   sort    = 1;
		  					   break;
		  		case 'fboardlike': reqJson = { 	sort:'regdate',
											    like:'${login.mem_num}',
							 				    dpp:5,
										        nowpage:nowpage};
								   href    = '/FBoard/ProfileFBoardList';
								   sort    = 2;
								   break;
		  		}
		  		
				console.log(href);
				writeBoard(nowpage, reqJson, href, sort);
		  	}
		} // 페이지 버튼 클릭 이벤트 끝
		
	}//게시물 목록 관련 이벤트 끝
	boardList.addEventListener('click', boardEvent);
	
	
	
	
	
	
	
}

</script>
</head>
<body>
  <%@ include file="/WEB-INF/include/header.jsp" %>
  <!-- 내 정보  -->
  <form action="/User/Update" method="POST">
  <input type="hidden" name="mem_num" id="mem_num" value="${ login.mem_num }"/>
  <table class="myProfile">
    <caption><h1>내 정보</h1></caption>
    <tr>
      <th>아이디</th>
      <td>${ userVo.mem_id }&nbsp;&nbsp;<button id="withdrawal">회원 탈퇴</button></td>
    </tr>
    <tr>
      <th>비밀번호</th>
      <td class="center"><button id="pwdChange">비밀번호 변경</button></td>
    </tr>
    <tr>
      <th>닉네임</th>
      <td><input type="text" name="nickname" id="nickname" value="${ userVo.nickname }"/>&nbsp;&nbsp;<button id="nickDupCheck">중복확인</button></td>
    </tr>
    <tr>
      <th>이름</th>
      <td><input type="text" name="mem_name" id="mem_name" value="${ userVo.mem_name }"/></td>
    </tr>
    <tr>
      <th>성별</th>
      <td>${ userVo.gender }</td>
    </tr>
    <tr>
      <th>휴대폰</th>
      <td><input type="number" name="tel1" id="tel1" maxlength="3" />&nbsp;-&nbsp;
      <input type="number" name="tel2" id="tel2" maxlength="4"/>&nbsp;-&nbsp;
      <input type="number" name="tel3" id="tel3" maxlength="4"/></td>
    </tr>
    <tr>
      <th>이메일</th>
      <td><input type="email" name="email" id="email" value="${ userVo.email }"/></td>
    </tr>
      <tr>
      <th>주소</th>
      <td><input type="text" name="address" id="address" value="${ userVo.address }"/>
          <button id="addressSearch">찾기</button><br/>
          <input type="text" name="address_detail" id="address" />
      </td>
    </tr>
    <tr>
      <th>생년월일</th>
      <td id="birth"></td>
    </tr>
    <tr>
      <td colspan="2" class="submit">
      <input type="submit" id="submit" value="수정"/></td>
    </tr>
  </table>
  </form>
  
   <!-- 게시판  -->
  <div class="boardList">
  <div class="boardBtns">
    &nbsp;<a href="" id="getBBoard">내 후기 게시물</a>&nbsp;│
    &nbsp;<a href="" id="getBBoardLike">좋아요한 후기 게시물</a>&nbsp;│
    <a href="" id="getFreeBoard">내 자유 게시판</a>&nbsp;│
    <a href="" id="getFBoardLike">좋아요한 자유 게시판</a>&nbsp;│
    <a href="" id="getReply">내 댓글</a>
  </div>
  <!-- 게시판을 불러올 div -->
  <div class="boardDiv">
  
  </div>
  </div>

    
</body>
</html>