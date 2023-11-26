package com.book.bboard.controller;



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
import com.book.book.vo.BookVo;
import com.book.user.vo.UserVo;

@Controller
@RequestMapping("/BBoard")
public class BBoardController {
	
	@Autowired
	private BBoardService bBoardService;

	//게시판 이동
	@RequestMapping("/page/{nowpage}")
	public ModelAndView board(
			@PathVariable HashMap<String,Object> map,@RequestParam HashMap<String,Object> map2) {
		ModelAndView mv = new ModelAndView();
		
		//검색어를 map에 저장
		String keyword = (String) map2.get("keyword");
		System.out.println("keyword:"+keyword);
		map.put("keyword", keyword);
		//검색조건을 map에 저장
		String option  = (String) map2.get("option");
		System.out.println("option:"+option);
		map.put("option", option);
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
		List<BBoardVo> list = bBoardService.boardList(map);
		System.out.println(list);
		//총 자료수 가져오기
		int totalCount = bBoardService.getBoardCount(map);
		
		int nowPage = Integer.parseInt(String.valueOf(map.get("nowpage")));
		
		mv.addObject("boardList",list);
		//페이징 정보
		mv.addObject("nowpage", nowPage);
		mv.addObject("totalcount", totalCount);
		//검색 정보
		mv.addObject("keyword",keyword);
		mv.addObject("option",option);
		mv.addObject("sort",sort);
		mv.addObject("sortDetail",sortDetail);
		mv.addObject("writer",writer);
		mv.setViewName("/bBoard/blist");
		return mv;
	}
	
	//글쓰기 화면으로 이동
	@RequestMapping("/WriteForm")
	public String writeForm(HttpSession session) {
		String href="";
		if(session.getAttribute("login")!=null) {
			href="/bBoard/write";
		} else {
			href="/user/login";
		}
		
		return href;
	}
	
	//책 검색 창 열기
	@RequestMapping("/BookSearchForm")
	public String bookSearchForm() {
		return "/window/booksearch";
	}
	
	
	//책 검색
	@ResponseBody
	@RequestMapping(value="/BookSearch",
	method = RequestMethod.POST,
	headers = "Accept=application/json")
	public HashMap<String, Object> bookSearch(@RequestBody HashMap<String,Object> map){
		
		String keyword = (String) map.get("keyword");
		System.out.println("keyword:"+keyword);
		
		
		
		//검색 결과 가져오기(첫 페이지:자료수 5개까지)
		List<BookVo> bookList = bBoardService.bookSearch(map);
		map.put("bookList", bookList);
		//총 검색 결과 가져오기(자료수 만큼)
		int resultCnt = bBoardService.bookSearchResultCnt(keyword);
		map.put("count", resultCnt);
		
		return map;
	}
	
	//게시글 쓰기
	@RequestMapping("/Write")
	public ModelAndView write(@RequestParam HashMap<String, Object> map,HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		System.out.println("Write");
		System.out.println("map:"+map);
		System.out.println(request);
		
		//게시글 등록 + 책 등록(프로시저)
		bBoardService.bookWrite(map,request);

		
		mv.setViewName("redirect:/BBoard/page/1");
		return mv;
	}
	
	//게시물 열람
	@RequestMapping("/View/page/{nowpage}/bno/{board_num}")
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
			int cnt = bBoardService.likeStatus(map);
			String status;
			
			if(cnt==0) { status = "dislikeBoard"; }
			else       { status = "likeBoard"; }
			System.out.println("status:"+ status );
			mv.addObject("status",status);
		}
		
		//조회수 증가
		map.put("check", 1);
		
		//DB에서 게시물 정보 가져오기
		BBoardVo vo = bBoardService.boardView(map);
		
		//현재 페이지 model에 저장
		String nowpage = (String) map.get("nowpage");
		
		mv.addObject("nowpage", nowpage);
		mv.addObject("board", vo);
		mv.setViewName("bBoard/view");
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
		int cnt = bBoardService.likeBoard(map);
		System.out.println(cnt);

		
		return cnt;
	}
	
	//게시물 수정 페이지 이동
	@RequestMapping("/UpdateForm/{nowpage}/{board_num}")
	public ModelAndView updateForm(@PathVariable HashMap <String, Object> map,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		UserVo login = (UserVo) session.getAttribute("login");
		String loginNick = login.getNickname();
		//DB에서 게시물 정보 가져오기(게시물 열람과 달리 조회수는 증가하지 않아야 함)
		BBoardVo vo = bBoardService.boardView(map);
		String href="";
		System.out.println(vo);
		String board_num  = (String) map.get("board_num");
		String nowpage    = (String) map.get("nowpage");
		
		//타 이용자의 접근 제한
		if(vo.getBoard_writer().equals(loginNick)) {
			mv.addObject("board",vo);
			mv.addObject("board_num",board_num);
			mv.addObject("nowpage",nowpage);
			href ="/bBoard/update";
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
		bBoardService.update(map,request);
		
		String nowpage = (String) map.get("nowpage");
		String board_num = (String) map.get("board_num");
		
		mv.setViewName("redirect:/BBoard/View/page/"+ nowpage +"/bno/"+ board_num);
		return mv;
	}
	
	
	//게시물 삭제
	@RequestMapping("/Delete/{board_num}")
	public ModelAndView delete(@PathVariable HashMap <String, Object> map,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		//로그인 아이디와 삭제할 게시물의 작성자의 일치여부를 위한 회원번호
		UserVo login = (UserVo) session.getAttribute("login");
		int mem_num = login.getMem_num();
		map.put("mem_num", mem_num);
		int mem_lvl = login.getMem_lvl();
		//관리자일 경우 관리자 레벨를 map에 추가
		if(mem_lvl>=100) {
			map.put("mem_lvl", mem_lvl);
		}
		
		bBoardService.delete(map);
		
		mv.setViewName("redirect:/BBoard/page/1");
		return mv;
	}
	
	//게시물 삭제(ajax)
	@RequestMapping(value    = "/DeleteAjax",
					method   = RequestMethod.POST,
					produces = "application/json; charset=utf8")
	public @ResponseBody void deleteAjax(@RequestBody HashMap <String, Object> map,HttpSession session ) {
		
		//로그인 아이디와 삭제할 게시물의 작성자의 일치여부를 위한 회원번호
		UserVo login = (UserVo) session.getAttribute("login");
		int mem_num = login.getMem_num();
		map.put("mem_num", mem_num);
		
		
		bBoardService.delete(map);
	}
	

	
	//내 정보 - 후기게시판 정보 조회
	@ResponseBody
	@RequestMapping(
			value="/ProfileBBoardList",
			method = RequestMethod.POST,
			headers = "Accept=application/json")
	public HashMap <String,Object> bboardList(@RequestBody HashMap<String, Object> map) {
		//필요 파라미터:nowpage, dpp, writer, sort 
		map.put("dpp", 5);
		map.put("sort", "regdate");
		System.out.println(map);
		
		//목록 가져오기
		List<BBoardVo> list = bBoardService.boardList(map);
		
		//총 자료수 가져오기
		int totalCount = bBoardService.getBoardCount(map);
		
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
		bBoardService.boardLikeCancel(map);
	}
	
	
	
	
	
	
}
