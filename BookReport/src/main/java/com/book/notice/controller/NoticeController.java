package com.book.notice.controller;


import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.book.bboard.service.BBoardService;
import com.book.bboard.vo.BBoardVo;
import com.book.notice.service.NoticeService;
import com.book.notice.vo.NoticeVo;
import com.book.user.vo.UserVo;

@Controller
@RequestMapping("/Notice")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	//공지사항 이동
	@RequestMapping("/page/{nowpage}")
	public ModelAndView notice(
			@PathVariable HashMap<String,Object> map,@RequestParam HashMap<String,Object> map2) {
		ModelAndView mv = new ModelAndView();
		
		//검색어를 map에 저장
		String keyword = (String) map2.get("keyword");
		System.out.println("keyword:"+keyword);
		map.put("keyword", keyword);
		//분류를 map에 저장
		String sort    = (String) map2.get("sort");
		if(sort==null) {
			sort = "regdate";
		}
		System.out.println("sort:"+sort);
		map.put("sort", sort);
		//특정 작성자의 게시물만 보기
		String writer  = (String) map2.get("writer");
		System.out.println("writer:"+writer);
		map.put("writer", writer);
		
		//sort의 차순을 변경(내림차순<->오름차순)
		String sortDetail = (String) map2.get("sortDetail"); 
		//초기 설정: 내림차순
		if(sortDetail==null) {
			sortDetail="true";
		}
		System.out.println("check:"+sortDetail);
		map.put("check", sortDetail);
		
		//한 페이지당 보여줄 자료수를 map에 저장
		map.put("dpp", 10);
		
		System.out.println("board map:"+map);
		//게시판 목록 가져오기
		List<NoticeVo> list = noticeService.noticeList(map);
		System.out.println(list);
		//총 자료수 가져오기
		int totalCount = noticeService.getBoardCount(map);
		
		int nowPage = Integer.parseInt(String.valueOf(map.get("nowpage")));
		
		mv.addObject("boardList",list);
		//페이징 정보
		mv.addObject("nowpage", nowPage);
		mv.addObject("totalcount", totalCount);
		//검색 정보
		mv.addObject("keyword",keyword);
		mv.addObject("sort",sort);
		mv.addObject("sortDetail",sortDetail);
		mv.addObject("writer",writer);
		mv.setViewName("/notice/nboard");
		return mv;
	}
	
	//공지 작성 화면으로 이동
	@RequestMapping("/WriteForm")
	public String writeForm(HttpSession session) {
		String href="";
		if(session.getAttribute("login")!=null) {
			href="/notice/write";
		} else {
			href="/user/login";
		}
		
		return href;
	}	
	
	//공지사항 작성
	@RequestMapping("/Write")
	public ModelAndView write(@RequestParam HashMap<String, Object> map,HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		System.out.println("[Write]");
		System.out.println("map:"+map);
		System.out.println(request);
		
		//공지사항 작성
		noticeService.noticeWrite(map, request);

		
		mv.setViewName("redirect:/Notice/page/1");
		return mv;
	}
	
	//게시물 열람
	@RequestMapping("/View/page/{nowpage}/bno/{notice_num}")
	public ModelAndView view(@PathVariable HashMap<String, Object> map, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		
		//로그인 정보 가져오기
		HttpSession session = request.getSession();
		UserVo userVo = (UserVo) session.getAttribute("login");
		//로그인이 되어있다면
		if(userVo !=null) {
			int mem_num = userVo.getMem_num();
			map.put("mem_num", mem_num );
			//해당 게시물의 추천 여부를 확인
			int cnt = noticeService.likeStatus(map);
			String status;
			
			if(cnt==0) { status = "dislikeBoard"; }
			else       { status = "likeBoard"; }
			System.out.println("status:"+ status );
			mv.addObject("status",status);
		}
		
		//조회수 증가
		map.put("check", 1);
		
		//DB에서 게시물 정보 가져오기
		NoticeVo vo = noticeService.boardView(map);
		
		//현재 페이지 model에 저장
		String nowpage = (String) map.get("nowpage");
		System.out.println(vo);
		mv.addObject("nowpage", nowpage);
		mv.addObject("board", vo);
		mv.setViewName("notice/view");
		return mv;
	}
	
	//추천수 증감
	@ResponseBody
	@RequestMapping(
			value="/LikeBoard",
			method = RequestMethod.POST,
			headers = "Accept=application/json")
	public int likeBoard(@RequestBody HashMap<String, Object> map) {
		
		//추천수를 증감 시키고 현재의 추천수를 가져옴
		int cnt = noticeService.likeBoard(map);
		System.out.println(cnt);

		
		return cnt;
	}
	
	//공지사항 수정 페이지 이동
	@RequestMapping("/UpdateForm/{nowpage}/{notice_num}")
	public ModelAndView updateForm(@PathVariable HashMap <String, Object> map,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		UserVo login = (UserVo) session.getAttribute("login");
		String loginNick = login.getNickname();
		//DB에서 게시물 정보 가져오기(게시물 열람과 달리 조회수는 증가하지 않아야 함)
		NoticeVo vo = noticeService.boardView(map);
		String href="";
		System.out.println(vo);
		String notice_num  = (String) map.get("notice_num");
		String nowpage    = (String) map.get("nowpage");
		
		//타 이용자의 접근 제한
		if(vo.getNotice_writer().equals(loginNick)) {
			mv.addObject("board",vo);
			mv.addObject("notice_num",notice_num);
			mv.addObject("nowpage",nowpage);
			href ="/notice/update";
		} else {
			href="redirect:/";
		}
		
		
		mv.setViewName(href);
		return mv;
	}
	
	//게시물 수정
	@RequestMapping("/Update")
	public ModelAndView Update(@RequestParam HashMap <String, Object> map,HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		
		//DB 정보 수정
		noticeService.update(map,request);
		
		String nowpage = (String) map.get("nowpage");
		String notice_num = (String) map.get("notice_num");
		
		mv.setViewName("redirect:/Notice/View/page/"+ nowpage +"/bno/"+ notice_num);
		return mv;
	}
	
	
	//공지사항 삭제
	@RequestMapping("/Delete/{notice_num}")
	public ModelAndView delete(@PathVariable HashMap <String, Object> map,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		//로그인 아이디와 삭제할 게시물의 작성자의 일치여부를 위한 회원번호
		UserVo login = (UserVo) session.getAttribute("login");
		int mem_num = login.getMem_num();
		map.put("mem_num", mem_num);
		
		
		//공지사항 삭제
		noticeService.delete(map);
		
		mv.setViewName("redirect:/Notice/page/1");
		return mv;
	}
	
	//공지사항 삭제(ajax)
	@RequestMapping(value    = "/DeleteAjax",
					method   = RequestMethod.POST,
					produces = "application/json; charset=utf8")
	public @ResponseBody void deleteAjax(@RequestBody HashMap <String, Object> map,HttpSession session ) {
		System.out.println(map);
		//로그인 아이디와 삭제할 게시물의 작성자의 일치여부를 위한 회원번호
		UserVo login = (UserVo) session.getAttribute("login");
		int mem_num = login.getMem_num();
		map.put("mem_num", mem_num);
		
		
		noticeService.delete(map);
	}
	

	
	//공지사항 삭제(Ajax)
	@ResponseBody
	@RequestMapping(
			value="/ProfileNoticeList",
			method = RequestMethod.POST,
			headers = "Accept=application/json")
	public HashMap <String,Object> bboardList(@RequestBody HashMap<String, Object> map) {
		//필요 파라미터:nowpage, dpp, writer, sort 
		map.put("dpp", 5);
		map.put("sort", "regdate");
		System.out.println(map);
		
		//목록 가져오기
		List<NoticeVo> list = noticeService.noticeList(map);
		
		//총 자료수 가져오기
		int totalCount = noticeService.getBoardCount(map);
		
		map.put("list", list);
		map.put("totalcount", totalCount);
		
		return map;
	}
	
	//내 정보 - 좋아요 취소
	@RequestMapping(value    = "/LikeCancelAjax",
					method   = RequestMethod.POST,
					produces = "application/json; charset=utf8")
	public @ResponseBody void likeCancelAjax (@RequestBody HashMap <String, Object> map){
		//좋아요 취소
		noticeService.likeCancel(map);
	}
	
	
	
	
	
	
}
