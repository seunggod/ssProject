<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독후감 공유 카페</title>
<link rel="stylesheet" href="/css/common.css" />
<style>
 table { margin:0 auto; }
 table, th, td { border: 1px solid black;
                 border-collapse: collapse;
                 padding:5px; }
 th            { width:200px;}
 caption h1    { color:orange;}
 input         { width:400px; height:30px;}
 #pwdCheck, #pwdCheck2     { margin-left:5px; color:green; font-weight: bold;}
 #tel1, #tel2, #tel3 { width:100px; }
 .gender       { width:50px; height:20px;  }
 #radioTd      {line-height: 20px; 
                font-size:20px;}
 select        { height:30px; float:left;  }
 #month, #day { margin-left:20px; }
 #birth b  { margin-left:10px; float:left; }
 .word         { color:red; font-size: 10px; }
 tr:nth-of-type(10) { text-align: center; }
 #msg          { font-size:12px; font-weight: bold;}
 .submit      { text-align: center;  }
 #submit      { margin-top:2px; }
 /* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  //윤년 등 조정 함수
  function changeBirth(){
	  let html='';
	  let month = $('#month').val();
	  switch(month){
	  case '1': case '3': case '5': case '7': case '8': case '10': case '12':
	      for( var n=1;n<=31;n++){
	    	  html+='<option>'+n+'</option>';
	      }
		  break;
	  case '4': case '6': case '9': case '11':
		  for( var n=1;n<=30;n++){
	    	  html+='<option>'+n+'</option>';
	      }
		  break;
	  case '2':
		  if($('#year').val()%4!=0||$('#year').val()%100==0&&$('#year').val()%400!=0){
	    	  for( var n=1;n<=28;n++ ){
				    html+='<option>'+n+'</option>';
				    }
			  break;
	      }
	      else{
			  for( var n=1;n<=29;n++ ){
				    html+='<option>'+n+'</option>';
				    }
			  break;
		  }
	  }
	  
	  $('#day').html(html);
  }//changeBirth 끝
  
  //ID 정규식
  function idExp(memid){
	
	const idCheck =/^[a-z]+[a-z0-9]{5,11}$/g;
	const result = idCheck.test(memid);
	console.log(result);
	return result;
  }
  
  //Pwd 정규식
  function pwdExp(pwd){
	
	const pwdCheck =/^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,12}$/;
	const result = pwdCheck.test(pwd);
	console.log(result);
	return result;
  }
  
  //Name 정규식
  function nameExp(name){
	const nameCheck  = /^[a-zA-Zㄱ-힣][a-zA-Zㄱ-힣 ]*$/;
	const result = nameCheck.test(name);
	console.log(result);
	return result;
  }
  
  //TEL 정규식
  function telExp(tel1, tel2, tel3){
	const telCheck  = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
	const result = telCheck.test(tel1+'-'+tel2+'-'+tel3);
	console.log(result);
	return result;
  }
  
  //EMAIL 정규식
  function emailExp(email){
	const emailCheck  = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	const result = emailCheck.test(email);
	console.log(result);
	return result;
  }
	  
	  
		  
  
  
  
  $(function(){
	  var nickCheck = false; //닉네임 중복여부 확인용 변수
      
	 
	 
	  
	  // 윤년을 고려한 날짜 조절
	  $('#month').on('change', changeBirth);
	  $('#year').on('change', changeBirth);
	  

	  //아이디 중복 확인(Ajax)
	  $('#memId').on('keyup',function(){
		  if($('#memId').val()==''){
			  $('#msg').html('');
		  } else {
		  
		  
		  $.ajax({
			  url:'/IdDupCheck',
			  data:{ id:$('#memId').val() },
			  type:'GET',
			  contentType: "application/text; charset:UTF-8",
			  success : function(result){
				  let msg = '';
				  if(result==0){
					  if(idExp($('#memId').val())){
					 	 $('#msg').css('color','green');
					  	 msg += '사용 가능한 아이디입니다';
					  } else {
						 $('#msg').css('color','red');
						 msg += '아이디는 영문자 혹은 영문자 + 숫자로 된 6자 이상이어야 합니다';
					  }
				  } else if(result== 1){
					  $('#msg').css('color','red');
					  msg += '중복된 아이디입니다';
				  }
				  $('#msg').text(msg);
			  },
			  error : function(){
				  console.log('error');
			  }
		  })
		 }
	  })
	  
	  //비밀번호 유효성 이벤트
	  $('#memPwd').on('keyup',e=>{
		  const memPwd = e.target.value;
		  if(pwdExp(memPwd))
			  $('#pwdCheck').html('사용 가능');
		  
	  })
	  
	  //비밀번호 일치 확인
	  $('#memPwd2').on('keyup',()=>{
		  const memPwd  = $('#memPwd').val();
		  const memPwd2 = $('#memPwd2').val();
		  if(memPwd == memPwd2)
			  $('#pwdCheck2').html('일치');
		  
	  })
	  
	  
	  //닉네임 중복체크
	  $('#nickname').on('keyup',function(){
		  const nickname = this.value;
		  if( nickname == ''){
			  $('.word').html('');
		  } else {
		  
		  
		  $.ajax({
			  url:'/NickDupCheck',
			  data:{ nickname:nickname },
			  type:'GET',
			  contentType: "application/text; charset:UTF-8",
			  success : function(result){
				  let msg = '';
				  if(result==0){
					 $('.word').css('color','green');
					 msg += '사용 가능';
					 nickCheck = true;
					 
				  } else if(result== 1){
					 $('.word').css('color','red');
					 msg += '사용 불가';
					 nickCheck = false;
				  }
				  $('.word').text(msg);
			  },
			  error : function(){
				  console.log('error');
			  }
		  })
		 }
	  })
	  
	 
	 
	  
	  $('form').on('submit',function(){
		//아이디 유효성 검사(영문+숫자 최소 6자)
		 if(!idExp($('#memId').val())){
			alert('부적절한 아이디입니다');
			return false;
		} 
		
	    const memPwd  = $('#memPwd').val();
		const memPwd2 = $('#memPwd2').val();
		//비밀번호 유효성 검사
		if(!pwdExp(memPwd)&&memPwd != memPwd2){
			alert('부적절한 비밀번호입니다');
			return false;
		}
		
		
		//닉네임 유효성 검사(공백 여부)
		if(!nickCheck){
			alert('부적절한 닉네임입니다');
			return false;
		}
		
		//이름 유효성 검사(특수문자 사용여부+공백여부)
		if(!nameExp($('#memName').val())){
			alert('이름은 영문자와 한글로만 입력 가능합니다');
			return false;
		}
		
		//성별 유효성 검사
		if(!$('.gender')[0].checked&&!$('.gender')[1].checked){
			alert('성별을 선택해주세요');
			return false;
		}
		//휴대폰 유효성 검사
		if(!telExp(!$('#tel1').val(),$('#tel2').val(),$('#tel3').val())){
			alert('올바른 번호가 아닙니다');
			return false;
		}
		
		//이메일 유효성 검사
		if(!emailExp($('#email').val())){
			alert('올바른 이메일이 아닙니다');
			return false;
		}
		
	  })
	  
	  
  })

</script>
</head>
<body>
  <%@ include file="/WEB-INF/include/header.jsp" %>
  <form action="/User/Join" method="post">
  <table>
    <caption><h1>회원가입</h1></caption>
    <tr>
      <th>아이디</th>
      <td><input type="text" name="memId" id="memId" placeholder="※영문자 혹은 영문자와 숫자 조합 6자 이상 12자 이내"/>
          <span id="msg"></span></td>
    </tr>
    <tr>
      <th>비밀번호</th>
      <td><input type="password" name="memPwd" id="memPwd" maxlength="12" placeholder="※영문 대소문자,숫자,특수문자 포함 8자 이상 12자 이내"/><span id="pwdCheck"></span></td>
    </tr>
    <tr>
      <th>비밀번호 확인</th>
      <td><input type="password" name="memPwd2" id="memPwd2" maxlength="12"/><span id="pwdCheck2"></span></td>
    </tr>
    <tr>
      <th>닉네임</th>
      <td><input type="text" name="nickname" id="nickname" maxlength="12" placeholder="최대 12자"/><span class="word"></span></td>
    </tr>
    <tr>
      <th>이름</th>
      <td><input type="text" name="memName" id="memName"/></td>
    </tr>
    <tr>
      <th>성별</th>
      <td id="radioTd"><input type="radio" name="gender" class="gender" value="남"/>남
                       <input type="radio" name="gender" class="gender" value="여"/>여</td>
    </tr>
    <tr>
      <th>휴대폰</th>
      <td><input type="number" name="tel1" id="tel1" maxlength="3"/>&nbsp;-&nbsp;
      <input type="number" name="tel2" id="tel2" maxlength="4"/>&nbsp;-&nbsp;
      <input type="number" name="tel3" id="tel3" maxlength="4"/></td>
    </tr>
    <tr>
      <th>이메일</th>
      <td><input type="email" name="email" id="email"/></td>
    </tr>
    <tr>
      <th>주소</th>
      <td><input type="text" name="address" id="address"/>
          <button id="addressSearch">찾기</button></td>
    </tr>
    <tr>
      <th>생년월일</th>
      <td id="birth"><select id="year" name="year">
      <c:forEach var="year" begin="1900" end="2020" step="1" >
      <option>${ year }</option>
      </c:forEach>
      </select>
      <b>년</b>     
      <select id="month" name="month">
      <c:forEach var="month" begin="1" end="12" step="1">
      <option>${ month }</option>
      </c:forEach>
      </select>
      <b>월</b>  
      <select id="day" name="day">
      <c:forEach var="day" begin="1" end="31" step="1">
      <option>${ day }</option>
      </c:forEach>
      </select>
      <b>일</b>
      </td>
    </tr>
    <tr>
      <td colspan="2" class="submit">
      <input type="submit" id="submit" value="회원가입"/></td>
    </tr>
  </table>
  </form>
</body>
</html>