<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- header.jsp -->
<%@ include file="/WEB-INF/view/layout/header.jsp" %>



<!-- TODO 여기서부터 main영역 -->

 <main class="profile_page">
 	<div class="section">
    <div class="container">
    	<h1 class="w-100 mb-4 ms-4"><b>프로필 관리</b></h1>
    	<div class="left_profile float-start w-25">
    	<div class="picture text-center mb-4 mx-4 p-5 border">
    	<img src="/images/git_img.png" alt="" name="" class="profile_image mx-auto d-block"/>
    	<label for="form-label" class="my-4 fs-5">홍길동</label>
    	<p class="left_profile_text">프로필 관리</p>
    	 </div>
    	<div class="coupon_profile col ">
    	<div class="coupon_count border mx-auto m-2 p-4 w-85 ">내 쿠폰<a class="color_primary02 float-end me-2" href="/user/coupon">0장 ></a></div>
    	</div>
    	<!-- 쿠폰 창 끝 -->
    	</div>
    	<!-- 여기까지 left-profile -->
    	
    	<div class="profile_box float-end d-flex flex-column border p-5 w-75">
    	<div><button class="border rounded px-4 py-2 float-end me-5">편집</button></div>
    	<div class="picture text-center w-100">
    	<img src="/images/git_img.png" alt="" name="" class="input_profile_image mx-auto d-block"/>
    	<!-- 뱃지 추가 필요 -->
    	<label for="form-label" class="my-4">홍길동</label>
    	</div>
    	<!-- 프로필 사진 창 끝 -->
        <div class="row row-cols-2 w-100 mx-auto">
    	<div class="type_name form-group col p-3">
    	<label for="userName">이름</label>
    	</div>
    	<div class="form-group col w-75 mb-3 p-3 ms-2">
    	<span class="userId">홍길동</span>	
    	</div>
    	<div class="type_name form-group col p-3">
    	<label for="userId">아이디</label>
    	</div>
    	<div class="form-group col w-75 mb-3 p-3 ms-2">
    	<span class="userId">idid123456</span>	
    	</div>
    	<div class="type_name form-group col p-3">
    	<label for="userTel">연락처</label>
    	</div>
    	<div class="form-group col w-75 mb-3 p-3 ms-2">
    	<span class="userTel">010-1234-5678</span>
    	<span class="color_primary02 ms-3">인증완료</span>
    	</div>
    	<div class="type_name col p-3">
    	<label for="snsLink" class="me-5">SNS 연동</label>
    	</div>
    	<div class="form-group col  form-check form-switch w-75 mb-3 p-3 ms-2">
    	<label for="kakaoLink" class="me-5"><img src="https://dffoxz5he03rp.cloudfront.net/icons/kakaotalk-logo.svg"/>     카카오 연동</label>
    	<input type="checkbox" class=" form-check-input sns_link float-end" role="switch"/>
    	</div>
    	<div class="type_name form-group col p-3">
    	<label for="password" class="me-5">비밀번호</label>
    	</div>
    	<div class="form-group col w-75 mb-5 p-3 ms-2">
    	<span>*******</span>
    	</div>
  		</div>
    	</div>
    	<!-- 프로필 상세 창 끝 -->
    	<!-- 우측 프로필 창 끝 -->
    	</div>
    	<!-- 프로필 관리 창 끝 -->
    	</div>
    	</main>
    	
</div>
</div>

<script src="js/javascript.js"></script>
<!-- footer.jsp -->
<%@ include file="/WEB-INF/view/layout/footer.jsp" %>