<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- header.jsp -->
<%@ include file="/WEB-INF/view/layout/header.jsp"%>



<!-- TODO 여기서부터 main영역 -->

<div class="nav_bg"></div>
	<main class="sign_in_page">
		<div class="container">
			<div class="section">
				<div class="mx-auto w-35">
					<form class="d-flex border" action="/user/sign-up" method="post">
						<div class="flex-column w-100">
							<div class="form-group w-75 mx-auto pt-2 mt-5">
								<label for="user_name">이름*</label> <input type="text"
									class="form-control mt-2 me-2 p-2" name="userName"
									id="userName" placeholder="이름를 입력해주세요" />
							</div>
							<div class="form-group w-75 mx-auto pt-2 mt-2">
								<label for="user_id">아이디*</label> <input type="text"
									class="form-control mt-2 me-2 p-2" name="userId" id="userId"
									placeholder="아이디를 입력해주세요" />
							</div>
							<div class="form-group w-75 mx-auto pt-2 mt-2">
								<label for="password">비밀번호*</label> <input type="password"
									class="form-control mt-2 me-2 p-2" name="password"
									id="password" placeholder="영문, 숫자, 특수문자 2가지 조합 8~15자" />
							</div>
							<div class="form-group w-75 mx-auto pt-2 mt-2">
								<label for="password_check">비밀번호 확인*</label> <input
									type="password" class="form-control mt-2 me-2 p-2"
									id="password_check" placeholder="비밀번호를 한번 더 입력해주세요" />
							</div>
							<div class="form-group w-75 mx-auto pt-2 mt-3 mb-4">
								<input type="checkbox" class="w-10" name="termsAll" /><label
									class="terms align-top">전체 약관 동의</label>
								<p class="terms_info lh-sm">선택 정보에 대한 동의를 포함합니다. 전체 동의하기 선택
									후 선택정보에 대한 동의를 변경 하실 수 있습니다.</p>
							</div>
							<div class="border w-75 mx-auto pt-2 mt-2">
								<div class="form-group w-85 mx-auto pt-2 mt-2">
									<input type="checkbox" class="w-10" name="termsInsert" /><label
										class="terms_font_size lh-sm align-top">[필수] 회원가입 및
										운영약관 동의</label>&nbsp; <a href="#" class="term_contents float-end">></a>
								</div>
								<div class="form-group w-85 mx-auto pt-2 mt-2">
									<input type="checkbox" class="w-10" name="termsPrivacy" /><label
										class="terms_font_size lh-sm align-top">[필수] 개인정보 수집 및
										이용 동의</label> <a href="#" class="term_contents float-end">></a>
								</div>
								<div class="form-group w-85 mx-auto pt-2 mt-2 mb-4">
									<input type="checkbox" class="w-10" name="termsLocationInfo" /><label
										class="terms_font_size lh-sm align-top">[필수] 위치 정보
										이용약관 동의</label>&nbsp; <a href="#" class="term_contents float-end">></a>
								</div>
							</div>
							<div class="form-group w-75 mx-auto mb-5 mt-4">
								<button type="submit" class="btn btn-primary p-2 w-100">회원가입</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
</main>

</div>
</div>

<script src="/js/javascript.js"></script>
<!-- footer.jsp  -->
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
