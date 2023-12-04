<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- header.jsp -->
<%@ include file="/WEB-INF/view/layout/header.jsp"%>



<!-- TODO 여기서부터 main영역 -->
<div class="nav_bg"></div>
<main class="counpon_page">
<div class="container">
	<div class="section">
		<h1 class="mb-4 ms-4">
			<b>내 쿠폰</b>
		</h1>
		<div class="left_profile float-start w-25">
			<div class="picture text-center mb-4 mx-4 p-5 border">
				<img src="/images/git_img.png" alt="" name=""
					class="profile_image mx-auto d-block" /> <label for="form-label"
					class="my-4 fs-5">홍길동</label>
				<p class="left_profile_text">프로필 관리</p>
			</div>
			<div class="coupon_profile col ">
				<div class="coupon_count border mx-auto m-2 p-4 w-85 ">
					내 쿠폰<a class="color_primary02 float-end me-2" href="/user/coupon">0장 ></a>
				</div>
			</div>
			<!-- 쿠폰 창 끝 -->
		</div>
		<!-- 여기까지 left-profile -->
		<ul class="nav nav-tabs w-60">
  <li class="nav-item">
    <a class="nav-link active p-3" aria-current="page" href="#">사용가능한 쿠폰</a>
  </li>
  <li class="nav-item">
    <a class="nav-link p-3"  href="#">Link</a>
  </li>
  <li class="nav-item">
    <a class="nav-link p-3" href="#">Link</a>
  </li>
</ul>
		<div class="coupon_box d-flex flex-column border w-60">
		<div class="bg_primary01 m-4 p-2">
		<p class="pt-3"> · 지급 받으신 쿠폰은 중복 사용이 불가능합니다.</p>
		<p class="mt-2 pb-3"> · 거래 취소시 사용기간이 남아 있을 경우 쿠폰에 따라 돌려드립니다.</p>
		</div>
		<div class="p-2 mt-5">
			<label for="coupon_insert" class="ms-3 mb-2">쿠폰 등록하기</label><br>
			<input type="text" name="coupon" class="form-control d-inline w-81 ms-3 me-1"/>
			<button type="submit" class="btn btn-primary align-top">등록</button>
		</div>


		</div>
	</div>
	</div>
</main>
</div>
</div>

<script src="js/javascript.js"></script>
<!-- footer.jsp -->
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>