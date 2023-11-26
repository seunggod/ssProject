package com.book.reply.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.book.reply.service.ReplyService;
import com.book.reply.vo.ReplyVo;
import com.book.user.vo.UserVo;

@RestController
@RequestMapping("/Reply")
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	
	//댓글 목록 가져오기
	@RequestMapping(value 		  = "/List",
					method 		  = RequestMethod.GET,
					headers       = "Accept=application/json")
	public HashMap <String, Object> replyList(@RequestParam HashMap <String, Object> map, HttpServletRequest request){
		//reply_num, writer, cont
		System.out.println(map);
		
		//로그인 정보 가져오기
		HttpSession session = request.getSession();
		UserVo userVo = (UserVo) session.getAttribute("login");
		//로그인이 되어있다면
		if(userVo !=null) {
			int mem_num = userVo.getMem_num();
			map.put("mem_num", mem_num );
		}	
		
		String board_num = (String) map.get("board_num");
		String free_num   = (String) map.get("free_num");
		String notice_num = (String) map.get("notice_num");
		String table = null;
		
		if(board_num!=null)  table = "reply";
		if(free_num!=null)   table = "reply_free";
		if(notice_num!=null) table = "reply_notice";
		map.put("table", table);
		
		//댓글 목록
		List<ReplyVo> list = replyService.replyList(map);

		//댓글 수
		int cnt = replyService.replycount(map);
		
		HashMap <String, Object> result = new HashMap<String, Object>();
		
		//map에 댓글 목록 저장
		result.put("list", list);
		result.put("reCnt", cnt);
		System.out.println(result);
		
		return result;
	}
	
	//댓글 수 불러오기
	@RequestMapping(value 		  = "/Count",
				    method 		  = RequestMethod.GET,
				    headers       = "Accept=application/json")
	public int replyCount(@RequestParam HashMap<String, Object> map) {
		
		String board_num = (String) map.get("board_num");
		String free_num = (String) map.get("free_num");
		String notice_num = (String) map.get("notice_num");
		String table = null;
		
		if(board_num!=null)  table = "reply";
		if(free_num!=null)  table = "reply_free";
		if(notice_num!=null) table = "reply_notice";
		map.put("table", table);
		
		int cnt = replyService.replycount(map);
		return cnt;
	}
	
	//댓글 작성
	@RequestMapping(value  = "/Write",
					method = RequestMethod.GET)
	public void replyWrite(@RequestParam HashMap <String, Object> map) {
		
		System.out.println("write:"+map);
		replyService.replyWrite(map);
	}
	
	//댓글 수정
	@RequestMapping(value  = "/Update",
					method = RequestMethod.GET)
	public void replyUpdate(@RequestParam HashMap <String, Object> map) {
		String table = (String) map.get("sort");
		switch(table) {
		case "board":table = "reply"; break;
		case "fboard":table = "reply_free"; break;
		case "notice":table = "reply_notice"; break;
		}
		map.put("table", table);
		
		replyService.replyUpdate(map);
		
	}
	
	
	//댓글 삭제
	@RequestMapping(value  = "/Delete",
					method = RequestMethod.GET)
	public void replyDelete(@RequestParam HashMap<String, Object> map) {
		System.out.println(map);
		replyService.replyDelete(map);
	}
	
	//댓글 좋아요
	@RequestMapping(value = "/LikeReply",
					method = RequestMethod.POST,
					headers = "Accept=application/json")
	public int replyLike(@RequestBody HashMap<String, Object> map) {
		
		int cnt = replyService.replyLike(map);
		
		return cnt;
	}
	
	//내 정보창 댓글 목록 불러오기
	@ResponseBody
	@RequestMapping(
			value="/ProfileBBoardList",
			method = RequestMethod.POST,
			headers = "Accept=application/json")
	public HashMap <String,Object> profileReplyList(@RequestBody HashMap<String, Object> map) {
	
		
		
		return map;
	}
		
		
		
}
