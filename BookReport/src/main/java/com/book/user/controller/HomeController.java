package com.book.user.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.book.bboard.service.BBoardService;
import com.book.bboard.vo.BBoardVo;
import com.book.fboard.service.FBoardService;
import com.book.fboard.vo.FBoardVo;
import com.book.notice.service.NoticeService;
import com.book.notice.vo.NoticeVo;
import com.book.user.service.UserService;
import com.book.user.vo.UserVo;

@Controller
public class HomeController {
	
	@Autowired
	private  UserService  userService;
	
	@Autowired
	private  BBoardService bBoardService;
	
	@Autowired
	private  FBoardService fBoardService; 
	
	@Autowired
	private  NoticeService noticeService;

	//home
	@RequestMapping("/")
	public  ModelAndView  home() {
		ModelAndView mv = new ModelAndView();
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		//분류를 map에 저장
		
		String sort    = "regdate";
		System.out.println("sort:"+sort);
		map.put("sort", sort);
		map.put("nowpage", 1);
		map.put("dpp", 5);
		//후기게시판 불러오기
		List<BBoardVo> bList = bBoardService.boardList(map);
		System.out.println(bList);	
		//자유게시판 불러오기
		List<FBoardVo> fList = fBoardService.boardList(map);
		System.out.println(fList);
		//공지사항 불러오기
		List<NoticeVo> nList = noticeService.noticeList(map);
		System.out.println(nList);
		
		mv.addObject("BookBoard", bList);
		mv.addObject("FreeBoard", fList);
		mv.addObject("NoticeBoard", nList);
		mv.setViewName("home");
		return mv;
	}
	
	
	//로그인 창 이동
	@RequestMapping("/User/LoginForm")
	public String loginForm() {
		return "user/login";
	}
	
	//로그인
	@RequestMapping("/User/Login")
	public ModelAndView login(HttpSession session, @RequestParam HashMap<String, Object> map) {
		ModelAndView mv = new ModelAndView();
		UserVo vo = userService.login(map);
		System.out.println("로그인[UserVo]:"+vo);
		String returnUrl="";
		if(vo==null) {  //일치하는 정보가 없을 때
			returnUrl="/user/login";
			mv.addObject("msg", "아이디가 존재하지 않거나 아이디 또는 비밀번호를 잘못 입력하셨습니다");
		} else {   // 일치하는 정보 존재 시 아이디, 닉네임을 세션(아니 쿠키로 할까...) 등록
			session.setAttribute("login", vo);
			returnUrl="redirect:/";
		}
		mv.setViewName(returnUrl);
		return mv;
	}
	
	//로그아웃
	@RequestMapping("/User/Logout")
	public String logout(HttpSession session) {
		session.invalidate();  // 세션 전체를 날려버림
		return "redirect:/";
	}
	
	//회원가입 창 이동
	@RequestMapping("/User/JoinForm")
	public String joinForm() {
		return "user/join";
	}
	
	//아이디 찾기 창으로 이동
	@RequestMapping("/User/IdSearchForm")
	public String idSearchForm() {
		return "user/idsearch";
	}
	
	//아이디 찾기
	@RequestMapping("/User/IdSearch") //name, tel
	public ModelAndView idSearch(@RequestParam HashMap <String, Object> map) {
		ModelAndView mv = new ModelAndView();
		
		String result="";
		String id=userService.idSearch(map);
		
		if(id!=null) {
			result="아이디는 <b>"+id+"</b>입니다";
		} else {
			result="아이디가 존재하지 않습니다";
		}
		System.out.println(result);
		mv.addObject("result", result);
		mv.setViewName("user/search_result");
		return mv;
	}
	
	//비밀번호 찾기 창으로 이동
	@RequestMapping("/User/PwdSearchForm")
	public String pwdSearchForm() {
		return "user/pwdsearch";
	}
	
	//비밀번호 변경 창으로 이동(인증 후)
	@RequestMapping("/User/PwdSearch") //name, tel
	public ModelAndView pwdSearch(@RequestParam HashMap <String, Object> map) {
		ModelAndView mv = new ModelAndView();
		
		String result="";
		String id=userService.idSearch(map);
		String href="";
		if(id!=null) {
			href="user/pwdchange";
			mv.addObject("userid", id);
		} else {
			href="user/pwdsearch";
			result="잘못 입력하셨거나 아이디가 존재하지 않습니다";
			mv.addObject("result", result);
		}
		
		
		mv.setViewName(href);
		return mv;
	}
	
	//비밀번호 변경 창으로 이동(내 정보창에서)
	@RequestMapping("/User/PwdChangeForm")
	public ModelAndView pwdChangeForm(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		UserVo vo = (UserVo) session.getAttribute("login");
		String id = vo.getMem_id();
		
		mv.addObject("userid",id);
		mv.setViewName("user/pwdchange");
		return mv;
	}
	
	//비밀번호 변경
	@RequestMapping("/User/PwdChange")
	public ModelAndView pwdChange(@RequestParam HashMap <String, Object> map, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		String href= "";
		
		userService.pwdChange(map);
		
		
		//비밀번호 변경 후 로그아웃
		session.invalidate();
		
		mv.addObject("pwdchange", 1);
		mv.setViewName(href);
		return mv;
	}
	
	
	
	//아이디 중복확인
	@RequestMapping(value         = "/IdDupCheck",
		            method        = RequestMethod.GET,
		            headers       = "Accept=application/text" )
	@ResponseBody
	public String idDupCheck(@RequestParam HashMap<String,Object> map) {
		System.out.println(map.get("id"));
		String msg = userService.idDupCheck(map);
		System.out.println("msg:"+msg);
		// msg 0:사용 가능 1: 중복
		return msg;
	}
	
	//닉네임 중복확인
	@RequestMapping(value         = "/NickDupCheck",
            method        = RequestMethod.GET,
            headers       = "Accept=application/text" )
	@ResponseBody
	public String NickDupCheck(@RequestParam HashMap<String,Object> map) {
		System.out.println(map.get("nickname"));
		String msg = userService.nickDupCheck(map);
		System.out.println("msg:"+msg);
		// msg 0:사용 가능 1: 중복
		return msg;
	}
	
	//회원가입
	@RequestMapping("/User/Join")
	public ModelAndView joinAction(@RequestParam HashMap<String, Object> map) {
		ModelAndView mv = new ModelAndView();
		
		
		userService.join(map);
		
		mv.setViewName("redirect:/User/LoginForm");
		return mv;
	}
	
	//내 정보창
	@RequestMapping("/User/Profile")
	public ModelAndView profile(HttpServletRequest request, @RequestParam("upCheck")String update ) {
		ModelAndView mv = new ModelAndView();

		//로그인 정보 가져오기
		HttpSession session = request.getSession();
		UserVo userVo = (UserVo) session.getAttribute("login");
		String nickname = userVo.getNickname();
		String returnUrl = "";
		//관리자의 경우 관리 페이지로 이동
		int memLvl = userVo.getMem_lvl();
		if(memLvl>=100) {
			returnUrl = "user/adminmanage";
		} else {
			returnUrl = "user/myprofile";
		}
		HashMap <String, Object> map = new HashMap<String, Object>();
		map.put("nowpage", 1);
		map.put("dpp", 5);
		map.put("sort", "regdate");
		map.put("writer", userVo.getNickname());
		
		
		//내 정보 불러오기
		UserVo userInfo = userService.getProfile(nickname);
		
		//회원 정보 수정을 경유 여부 체크
		mv.addObject("update", update);
	
		
		
		mv.addObject("nowpage", 1);
		mv.addObject("userVo", userInfo);
		mv.setViewName(returnUrl);
		return mv;
	}
	
	//회원 정보 수정
	@RequestMapping("/User/Update")
	public String update(RedirectAttributes redirect ,@RequestParam HashMap<String, Object> map) {
		
		System.out.println("update:"+map);
		
		//정보 수정
		userService.updateProfile(map);
	
		redirect.addAttribute("upCheck","true");
		
		return "redirect:/User/Profile";
	}
	
	//신고 팝업창
	@RequestMapping("/ReportForm")
	public ModelAndView reportForm(@RequestParam HashMap<String, Object> map) {
		ModelAndView mv = new ModelAndView();
		String nick = (String) map.get("reported_nick");
		String mem_num = (String) map.get("reported_mem");
		String num  = (String) map.get("num");
		String sort = (String) map.get("sort");
		
		mv.addObject("reported_mem", mem_num);
		mv.addObject("reported_nick",nick);
		mv.addObject("num",num);
		mv.addObject("sort",sort);
		mv.setViewName("/window/report");
		return mv;
	}

	//신고
	@ResponseBody
	@RequestMapping(value   = "/Report",
					method  = RequestMethod.POST,
					headers = "Accept=application/json")
	public int report(@RequestBody HashMap<String, Object> map) {
		System.out.println("report:"+map);
		
		//신고 내용을 DB에 저장
		int result = userService.report(map);
		//int result = 1;
		System.out.println(result);
		
		return result;
	}
	
	//회원 탈퇴
	@RequestMapping("/User/Withdrawal")
	public ModelAndView withdrawal(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		UserVo vo = (UserVo) session.getAttribute("login");
		int mem_num = vo.getMem_num();
		
		userService.withdrawal(mem_num); //탈퇴 
		
		session.invalidate();  // 세션 전체를 날려버림
		
		
		mv.addObject("withdrawal", "1");
		mv.setViewName("home");
		return mv;
	}
	
}










