package prj.trip.FBoard.impl;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import prj.trip.FBoard.Vo.FBCommentVo;
import prj.trip.FBoard.Vo.FreeBoardVo;
import prj.trip.FBoard.Vo.PagingVo;
import prj.trip.FBoard.controller.Action;
import prj.trip.FBoard.dao.FreeBoardDao;

public class FBoardClick implements Action{

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fbnum = request.getParameter("fbnum");
		System.out.println("게시글 번호 : " + fbnum);
		FreeBoardDao dao  =new FreeBoardDao();
		String num = request.getParameter("pagenum");
		System.out.println("숫자"+num);
		//조회수 증가
		dao.CntUpdate(fbnum);
		FreeBoardVo fvo = dao.getFBoard(fbnum);
		request.setAttribute("fvo", fvo);
		String title = fvo.getTitle();
		String cont  = fvo.getCont();
		String nick  = fvo.getNick();
		String like  = fvo.getLikecnt();
		
		
		
		request.setAttribute("fbnuma", fbnum);
		request.setAttribute("like", like);
		request.setAttribute("nick", nick);
		request.setAttribute("title", title);
		request.setAttribute("cont", cont);
		
		//페이징
		int end;
		int start;
		int number;
		
				PagingVo pvo = new PagingVo();
				pvo.setPageSize(5);
				int s = pvo.getPageSize();
				if(num == null) {
					pvo.setPageNo(1);
					end = s * 1;
					start = end - s +1;
					
				}else {
					number = Integer.parseInt(num);
					pvo.setPageNo(number);
					System.out.println("숫자 변화값"+number);
					end = s * number;
					start = end - s +1;
					
				}
				//댓글불러오기
				List<FBCommentVo> fbcvo = dao.getFBCommentList(fbnum, end, start);
				request.setAttribute("fbcvo", fbcvo);
				
				//총 댓글 수
				int FBCTotal = dao.getTBCTotal(fbnum);
				request.setAttribute("FBCTotal", FBCTotal);
				
				
				pvo.setTotalCount(FBCTotal);
				//pvo.setStartPageNo(0*s+1);
				//pvo.setEndPageNo(2*);
				request.setAttribute("pvo", pvo);
				
				//게시판 목록
				System.out.println(start); //게시물 시작번호
				System.out.println(end); //게시물 끝번호
				System.out.println(pvo.getPageSize()); //한페이지에 보이는 게시물 갯수
		
		
		String path="/view/fboard/FBoardContent.jsp";
		request.getRequestDispatcher(path).forward(request, response);
		
	}

}
