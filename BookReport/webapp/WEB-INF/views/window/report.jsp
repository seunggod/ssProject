<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고</title>
<style>
 #report, td{ border:1px solid black; border-collapse: collapse;}
 #report { 
 		   margin:0 auto; height:200px; width:400px;}
 td:nth-of-type(1), select, option { text-align: center; width:100px; font-weight: bold; }
 
 select { width:100%; height:30px; font-size:15px; font-weight: bold;}
 input  { width:96%; height:30px; border:none; text-align: center; font-weight: bold; font-size:15px;}
 caption { color:orange;}
 #submit { width:75%; height: 80%; padding:10px;
 		   margin-top:15px;
           color:white; background: orange;
           font-size: 20px; font-weight: bold;
           cursor:pointer;}
 option { font-weight: bold;}
 textarea {  width:97%; height:100px;  
 			resize:none; border:none; overflow: hidden;}
 #submitTd { border-color: white;}
 #etc { display:none; }
</style>
<script>
  window.onload = function(){

	  const button = document.querySelector('[type=button]');
	  const select = document.querySelector('select');
      const cont = document.querySelector('[name = cont]');
      console.dir(cont);
      //cont resize 이벤트
      const resize = (e)=>{
    	  e.target.style.height = '100px';
    	  e.target.style.height = e.target.scrollHeight+'px';
      }
      cont.addEventListener('keyup',resize);
      
	  //submit 이벤트 함수
	  const report_submit =  e=> {

		  //신고사유 미선택시
		  if(select.value == '< 신 고 사 유 >'){
			  alert('신고사유를 선택해주세요');
		  }
		  //신고 내용 미 입력 시
		  else if(cont.value == ''){
			  alert('신고 내용을 입력해주세요');
		  } else {	
			 //각종 파라미터 설정
			 const report_num      = '${login.mem_num}';
			 let sort = '${sort}';
			 if(sort = '댓글')
				 sort = 'reply';
			 else
				 sort = 'board';
			 const reported_num = '${reported_mem}';
			 const num = '${num}';
			 const reason           = document.getElementById('reason');
			 const etc              = document.querySelector('[name = etc]');
			 var reqJson = { report_num:report_num,
							 reported_num:reported_num,
							 num:num,
							 sort:sort,
							 reason:reason.value,
							 etc:etc.value,
							 cont:cont.value
							 };
				
			 /* 통신에 사용 될 XMLHttpRequest 객체 정의 */
			 var httpRequest = new XMLHttpRequest();
			 /* httpRequest의 readyState가 변화했을때 함수 실행 */
			 httpRequest.onreadystatechange = () => {
			 	if (httpRequest.readyState === XMLHttpRequest.DONE) {
					if (httpRequest.status === 200) {
						var result = httpRequest.response;
						if(result == 1)
							alert('중복된 신고입니다');
						if(result == 0)
							alert('신고되었습니다');
						//EventListener 제거 및 팝업창 close 함수
						removeAndClose();
					} else {
						alert('신고에 실패했습니다');
					}
			 	}
		    };
		    /* Post 방식으로 요청 */
			httpRequest.open('POST', '/Report', true);
			/* Response Type을 Json으로 사전 정의 */
			httpRequest.responseType = "json";
			/* 요청 Header에 컨텐츠 타입은 Json으로 사전 정의 */
			httpRequest.setRequestHeader('Content-Type', 'application/json; charset:UTF-8');
			/* 정의된 서버에 Json 형식의 요청 Data를 포함하여 요청을 전송 */
			httpRequest.send(JSON.stringify(reqJson));
		  }
		  
	  }//report_submit 끝
	  
	  button.addEventListener('click', report_submit );
	  
	  
	  //select 시 이벤트 함수
	  const show_input = e =>{
		  let etcTr = document.getElementById('etc'); 
		  //let selectValue = select.options[select.selectedIndex].value;
		  let selectValue = select.value;
		  if(selectValue=='기타')
			  etcTr.style.display = 'table-row';
		  else 
			  etcTr.style.display = 'none';
		  
	  }
	  
	  select.addEventListener('change', show_input );
	  
	  const removeAndClose = ()=> {
		  cont.removeEventListener('keyup',resize);
		  select.removeEventListener('change', show_input );
		  button.removeEventListener('click', report_submit );
	      window.close();
	  }
	
	
	  
  }
</script>
</head>
<body>
<input type="hidden" name="report_num" value="${ login.mem_num }"/>
<input type="hidden" name="reported_num" value="${ reported_mem }"/>
<table id="report">
  <caption><h1>신&nbsp;고</h1></caption>
  <tr>
    <td>신고자</td><td><input type="text" name="report_nick" value="${ login.nickname }" disabled></td>
  </tr>
  <tr>
    <td>신고대상</td><td><input type="text" name="reported_content" value="${reported_nick}&nbsp;님의 &nbsp;${num}번  &nbsp;${sort}" disabled></td>
  </tr>
  <tr>
    <td> 신고사유</td><td> <select name="reason" id="reason">
  <option>&lt;&nbsp;신&nbsp;고&nbsp;사&nbsp;유&nbsp;&gt;</option>
  <option>선정적인 게시물</option>
  <option>도배</option>
  <option>심한 욕설 사용</option>
  <option>개인정보 침해</option>
  <option>광고</option>
  <option id="gita">기타</option>
 </select> 
  </td>
  </tr>
  <tr id="etc">
    <td>기타사유</td><td><input type="text" name="etc"></td>
  </tr>
  <tr>
    <td>상세내용</td><td><textarea name="cont" maxlength="200"></textarea></td>
  </tr>
  <tr>
    <td id="submitTd" colspan="2"><input type="button" id="submit" value="신   고"></td>
  </tr>
  
   
  
</table>
</body>
</html>