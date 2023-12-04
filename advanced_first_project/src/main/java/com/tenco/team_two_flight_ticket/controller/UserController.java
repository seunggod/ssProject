package com.tenco.team_two_flight_ticket.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {
	
	//회원가입
	@GetMapping("/sign-up")
	public String signUp(){
		return "user/signUp";
	}
	
	//로그인
	//주소:  http://localhost:8080/user/sign-in
	@GetMapping("/sign-in")
	public String signIn() {
		return "user/signIn";
	}
	
	//카카오 로그인
	@GetMapping("/kakao/sign-in")
	public String kakaoSignIn() {
		return "user/kakaoSignIn";
	}
	
	@GetMapping("/profile")
	public String profile() {
		return "user/profile";
	}
	
	@GetMapping("/profile-management")
	public String profileManagement() {
		return "user/profileManagement";
	}
	
	@GetMapping("/coupon")
	public String coupon() {
		return "user/coupon";
	}
	
	
	
}
