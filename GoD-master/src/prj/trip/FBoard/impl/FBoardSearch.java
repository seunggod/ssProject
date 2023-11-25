package prj.trip.FBoard.impl;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import prj.trip.FBoard.Vo.FreeBoardVo;
import prj.trip.FBoard.Vo.PagingVo;
import prj.trip.FBoard.controller.Action;
import prj.trip.FBoard.dao.FreeBoardDao;

public class FBoardSearch implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String main = request.getParameter("searchCondition");
		String Keyword = request.getParameter("searchKeyword");
		String main2 = request.getParameter("main");
		String Keyword2 = request.getParameter("keyword");

		System.out.println("메인 : " + main);
		System.out.println("메인2 : " + main2);
		System.out.println("키워드 : " + Keyword);
		System.out.println("키워드2 : " + Keyword2);

		int end;
		int start;
		int number;
		String num = request.getParameter("pagenum");
		System.out.println("숫자" + num);

		FreeBoardDao dao = new FreeBoardDao();

		// 페이징
		PagingVo pvo = new PagingVo();
		pvo.setPageSize(10);
		int s = pvo.getPageSize();
		if (num == null) {
			pvo.setPageNo(1);
			end = s * 1;
			start = end - s + 1;
			
		} else {
			number = Integer.parseInt(num);
			pvo.setPageNo(number);
			System.out.println("숫자 변화값" + number);
			end = s * number;
			start = end - s + 1;
			
		}
		System.out.println("끝"+end);
		System.out.println("시작"+start);

		System.out.println("첫번째 검색 : "+"Title".equals(main));
		System.out.println("페이지 넘길때 : "+"Title".equals(main2));
		System.out.println("첫번째 검색 : "+"Nick".equals(main));
		System.out.println("페이지 넘길때 : "+"Nick".equals(main2));
		if ( "Title".equals(main) || "Title".equals(main2) ) {
			if( null == Keyword ) {
				System.out.println("첫번째 키워드 null일때 제목!@!!@!@!@!@!@@!");
				pvo.setTotalCount(dao.getFBtitleSearchCount(Keyword2));
				request.setAttribute("pvo", pvo);
				List<FreeBoardVo> fbvo = dao.getFBoardtitleSearch(end, start, Keyword2);
				request.setAttribute("fbvo", fbvo);
				
				request.setAttribute("main", main2);
				request.setAttribute("Keyword", Keyword2);
				request.setAttribute("searchcount", dao.getFBtitleSearchCount(Keyword2));
				
				String path = "/view/fboard/FreeBoard.jsp?Keyword="+Keyword2;
				request.getRequestDispatcher(path).forward(request, response);
			}else {
				System.out.println("두번째 키워드 null일때제목!@!!@!@!@!@!@@!");
				pvo.setTotalCount(dao.getFBtitleSearchCount(Keyword));
				request.setAttribute("pvo", pvo);
				List<FreeBoardVo> fbvo = dao.getFBoardtitleSearch(end, start, Keyword);
				request.setAttribute("fbvo", fbvo);
				
				request.setAttribute("main", main);
				request.setAttribute("Keyword", Keyword);
				request.setAttribute("searchcount", dao.getFBtitleSearchCount(Keyword));
				
				String path = "/view/fboard/FreeBoard.jsp?Keyword="+Keyword;
				request.getRequestDispatcher(path).forward(request, response);
			}

		} else {
			if( null == Keyword ) {
				System.out.println("첫번째 키워드 null일때 닉네임!@!!@!@!@!@!@@!");
				pvo.setTotalCount(dao.getFBNickSearchCount(Keyword2));
				request.setAttribute("pvo", pvo);
				List<FreeBoardVo> fbvo = dao.getFBoardNickSearch(end, start, Keyword2);
				request.setAttribute("fbvo", fbvo);
				
				request.setAttribute("main", main2);
				request.setAttribute("Keyword", Keyword2);
				request.setAttribute("searchcount", dao.getFBtitleSearchCount(Keyword2));
				
				String path = "/view/fboard/FreeBoard.jsp?Keyword="+Keyword2;
				request.getRequestDispatcher(path).forward(request, response);
				
			}else {
				System.out.println("두번째 키워드 null일때 닉네임!@!!@!@!@!@!@@!");
				pvo.setTotalCount(dao.getFBNickSearchCount(Keyword));
				request.setAttribute("pvo", pvo);
				List<FreeBoardVo> fbvo = dao.getFBoardNickSearch(end, start, Keyword);
				request.setAttribute("fbvo", fbvo);
				
				request.setAttribute("main", main);
				request.setAttribute("Keyword", Keyword);
				request.setAttribute("searchcount", dao.getFBtitleSearchCount(Keyword));
				
				String path = "/view/fboard/FreeBoard.jsp?Keyword="+Keyword;
				request.getRequestDispatcher(path).forward(request, response);
				
			}
			
		
		}
		

	}
}
