package prj.trip.FBoard.impl;

import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.FBoard.Vo.FreeBoardVo;
import prj.trip.FBoard.Vo.PagingVo;
import prj.trip.FBoard.controller.Action;
//import prj.trip.FBoard.dao.FreeBoardDao;
import prj.trip.member.dao.MemberDao;

public class FreeBoard implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("LoginId");
		System.out.println("초기아이디 확인점"+id);
		int end;
		int start;
		int number;
		String num = request.getParameter("pagenum");
		
		String sort = request.getParameter("sort");
		String pagesize = request.getParameter("pagesize");
		System.out.println("sort값 : "+sort);
		
		
		//페이징
		PagingVo pvo = new PagingVo();
		if(pagesize ==null || pagesize.equals("---")) {
			pvo.setPageSize(10);
		}else {
			if(pagesize.equals("10개")) {
				System.out.println("10개로 들어옴 : "+pagesize);
				pvo.setPageSize(10);
			}else if(pagesize.equals("30개")){
				System.out.println("30개로로 들어옴 : "+pagesize);
				pvo.setPageSize(30);
			}else if(pagesize.equals("50개")){
				System.out.println("50개로로 들어옴 : "+pagesize);
				pvo.setPageSize(50);
			}
		}
		
		
		System.out.println("숫자"+num);
		System.out.println("pagesize값 : "+pagesize);
		
		MemberDao dao = new MemberDao();
		//FreeBoardDao fdao = new FreeBoardDao();
		//String mnum = dao.getMemNumm(id);
		
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
		pvo.setTotalCount(dao.getCount());
		//pvo.setStartPageNo(0*s+1);
		//pvo.setEndPageNo(2*);
		request.setAttribute("pvo", pvo);
		
		//게시판 목록
		System.out.println(start); //게시물 시작번호
		System.out.println(end); //게시물 끝번호
		System.out.println("한페이지에 보이는 게시물 갯수: "+pvo.getPageSize()); //한페이지에 보이는 게시물 갯수
		
		
		//정렬
		
		if(sort== null || sort.equals("---")) {
			List<FreeBoardVo> fbvo =   dao.getFreeBoardList( end , start);
			request.setAttribute("fbvo", fbvo);
			request.setAttribute("sort", "조회순");
			request.setAttribute("pagesize", "10개");
		}else {
			if(sort.equals("조회순")) {
				System.out.println("조회정렬로 들어옴 : "+sort);
				List<FreeBoardVo> fbvo =   dao.getFBListSortCntdown( end , start);
				request.setAttribute("fbvo", fbvo);
				request.setAttribute("sort", sort);
				request.setAttribute("pagesize", pagesize);
			}else if(sort.equals("추천순")){
				System.out.println("추천정렬로 들어옴 : "+sort);
				List<FreeBoardVo> fbvo =   dao.getFBListSortLike( end , start);
				request.setAttribute("fbvo", fbvo);
				request.setAttribute("sort", sort);
				request.setAttribute("pagesize", pagesize);
			}else {
				List<FreeBoardVo> fbvo =   dao.getFreeBoardList( end , start);
				request.setAttribute("fbvo", fbvo);
				request.setAttribute("sort", "조회순");
				request.setAttribute("pagesize", "10개");
			}
		}
		
		
		
		//Collections.sort(fbvo, new ListComparator());
		String   path         =   "/view/fboard/FreeBoard.jsp";  
		request.getRequestDispatcher(path).forward(request, response);
		
	}

}
