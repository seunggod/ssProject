<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../css/common.css"/>
<style>
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="/img/favicon.ico" type="image/x-icon" sizes="16x16">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function goPopup(){
	
	var xPos = (document.body.offsetWidth/2) - (570/2); // 가운데 정렬
	var yPos = (document.body.offsetHeight/2) - (420/2);
	
	var pop = window.open("/view/common/popup/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes , left="+xPos+", top="+yPos);
	
}


function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
		
	document.getElementById("addrBasic").value = roadAddrPart1;

    document.getElementById("addrDetail").value = addrDetail;

    document.getElementById("addrZipNum").value = zipNo;
		
}




        var expEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
        var expName = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
        var expTel2 = /^\d{3,4}/;
        var expTel3 = /^\d{4}$/;
       
	function Idcheck() {
		var id = $('#id').val();
		
		$.ajax({
			url :'/mboard?cmd=IdCheck',
			type : 'post',
			data : {id : id},
			success : function(result) {
				if(result == 1){  
					$('#id_check_text').html('사용할 수 있는 아이디입니다.');
					$("#id").css("background-color", "#B0F6AC");
					$('#btn_create').prop("disabled",false); 
				}else if(id == "" || result == 0){  
					$('#id_check_text').html('사용할 수 없는 아이디입니다.');
					$("#id").css("background-color", "#FFCECE");
					$('#btn_create').prop("disabled",true); 
				}
			},
			error : function(result) {
				alert("에러입니다");
			}
		});
			
		
	};
	
	function PwCheck() {
		var pw  = $('#pw').val();
		var rpw = $('#rpw').val();
		
		if(pw == rpw){
			$("#rpw").css("background-color", "#B0F6AC");
			$('#btn_create').prop("disabled",false); 
		}else{
			$("#rpw").css("background-color", "#FFCECE");
			$('#btn_create').prop("disabled",true); 
		}
		
	}
	
	function valiFormEmail(obj){
		if(validEmail(obj) == false){
		alert("올바른 이메일 주소를 입력하세요.");
		obj.value = '';
		obj.focus();
		return false;
		}
		}

	
	function validEmail(obj){
		var pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		return (obj.value.match(pattern) != null);
		}

      function check() {
		 
        var r = document.reg_input; 
        if ( r.id.value == "" ) {
            alert("아이디를 입력해주십시오");
            r.id.focus();
            return false;
        }
        if (r.pw.value == "") {
            alert("비밀번호를 입력해주십시오");
            r.pw.focus();           
            return false;
        }
        if(expName.test(r.name.value)==true){
            alert("이름이 올바르지 않습니다.");
            r.name.focus();
            return false;
            }
        if (r.name.value == "") {
            alert("이름을 입력해주십시오");
            r.name.focus();
            return false;
        }
        
        if(expEmail.test(r.email.value)==false){
        alert("이메일형식이 올바르지 않습니다.");
        r.email.focus();
        return false;
        }
        if (r.email.value == "") {
            alert("이메일을 입력해주십시오");
            r.email.focus();
            return false;
        }
        if (expTel2.test(r.tel2.value) === false) {
            alert('정확한 전화번호를 입력해주시세요.');
            r.tel2.focus();
            return false;
        }
        if (expTel3.test(r.tel3.value) === false) {
            alert('정확한 전화번호를 입력해주시세요.');
            r.tel3.focus();
            return false;
        }
        if (r.tel2.value == "" || r.tel3.value == "") {
            alert("전화번호를 입력해주십시오");
            r.tel1.focus();
            return false;
        }
        if (r.day.value == "") {
            alert("생일을 선택해주십시오");
            return false;
        }
        if (r.gender.value == "") {
            alert("성별을 선택해주십시오");
            return false;
        }
    };
window.onload = function() {
		$('#name').keyup( function NameCheck() {
			if( expName.test(this.value) ){
			this.value = this.value.replace(expName , "")    ;
			}
			return ;
		} );
	
		
	
	$('#mon,#year').change(function() {
	var mon = document.getElementById('mon').value;
	var year = document.getElementById('year').value;
	
	console.log(year);
	console.log(mon);
	
	let lastDate = new Date(year, mon, 0);
    var c = lastDate.getDate();
	
	console.log("마지막 일자" + c);
    
	var html ="";
	for (var i = 1; i < c+1; i++) {
		html += "<option>"+ i +"</option>";
	}
	  $('#day').html(html);
}
      )
      
      
	}
	function birthh() {
	var year = document.getElementById('year').value;
	var mon = document.getElementById('mon').value;
	
	console.log(year);
	console.log(mon);
	
	let lastDate = new Date(year, mon, 0);
    var c = lastDate.getDate();
	
	console.log("마지막 일자" + c);
    
	var html ="";
	for (var i = 1; i < c+1; i++) {
		html += "<option>"+ i +"</option>";
	}
	  $('#day').html(html);
}
</script>
</head>
<body>
<%@ include file="header.jsp" %>
<div style="height: 75px"></div>

<div class="home">
	<a href="../common/index.jsp"><img src="/img/home.png" style="width: 50px; height: 50px;"></a>
</div>

<h2 class ="jointitle">회원가입</h2>
<div  style="text-align: center;"  id="id_check_text"></div>

<form name="reg_input" action="/mboard?cmd=insert" method="post" class="CreateForm" onsubmit="return check()" >
	<table class="jointable">
	<tr>
	<td>아이디  </td>
		<td colspan="2"> <input type="text" name="id" id="id" placeholder="ID" required oninput="Idcheck()"></td>
	</tr>
	
	<tr>
	<td>비밀번호  </td>
		<td colspan="2"><input type="password" name="pw" placeholder="PW" id="pw" required ></td>
	</tr>
	
	<tr>
	<td>비밀번호 확인 </td>
		<td colspan="2"><input type="password" name="pw2" placeholder="Repeat PW" id="rpw" required oninput="PwCheck()"></td>
	</tr>
	
	<tr>
	<td>닉네임  </td>
		<td colspan="2"><input type="text" name="nick" id="nick" placeholder="닉네임" required ></td>
	</tr>
	
	<tr>
	<td>이름  </td>
		<td colspan="2"><input type="text" name="name" id="name" placeholder="이름" oninput="this.value = this.value.replace(/[^(ㄱ-힣a-zA-Z)]/gi, '').replace(/(\..*)\./g, '$1');" required ></td>
	</tr>
	
	<tr>
	<td>우편번호  </td>
		<td colspan="2">
			<input type="text" name="addrZipNum" id="addrZipNum" placeholder="우편번호" readonly >
			<button type="button" name="ad" id="ad" onclick="goPopup()" >검색</button>
		</td>
	</tr>
	
	<tr>
	<td>기본주소  </td>
		<td colspan="2"><input type="text" name="addrBasic" id="addrBasic" placeholder="기본주소" readonly ></td>
	</tr>
	
	<tr>
	<td>상세주소  </td>
		<td colspan="2"><input type="text" name="addrDetail" id="addrDetail" placeholder="상세주소" required ></td>
	</tr>
	
	<tr>
	<td>이메일  </td>
		<td colspan="2"><input type="text" name="email" placeholder="이메일" id="email" value="" onchange="valiFormEmail(this)" required></td>
	</tr>
	
	<tr>
	<td>생년월일  </td>
		<td colspan="2"> <select name="birth" id="year" onchange="birthh()">
	<%for(int i=1900; i<2021; i++){ %>
				<option><%=i %></option>
				<%} %>
	       </select> 년 
	       
	<select name="month" id="mon" onchange="birthh()">
	<%for(int a=1; a < 13; a++){ %>
				<option><%=a %></option>
				<%} %>
	       </select> 월
	     
	       
	<select name="day" id="day">
	
	
	       </select> 일</td>
	</tr>
	
	<tr>
	<td>전화번호  </td>
		<td colspan="2"><select name="tel1">
		<option>010</option>
		<option>011</option>
		<option>016</option>
		<option>017</option>
		<option>019</option>
</select>

	- <input type="text" name="tel2" size="4" maxlength='4' oninput="this.value = this.value.replace(/[^(0-9)]/gi, '').replace(/(\..*)\./g, '');"  required>
	- <input type="text" name="tel3" size="4" maxlength='4' oninput="this.value = this.value.replace(/[^(0-9)]/gi, '').replace(/(\..*)\./g, '');"  required> </td>
	</tr>
	
	<tr>
	<td>성별  </td>
		<td colspan="2"><input type="radio" name="gender" value="m" required>남자
	<input type="radio" name="gender" value="f" >여자 </td>
	</tr>
	
	<tr>
		<td colspan="3" ><input type="submit" value="회원가입" id="btn_create" disabled > </td>
	</tr>
	
</table>
	</form>
</body>
</html>
