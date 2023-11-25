package prj.trip.tboard.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import prj.trip.tboard.dao.TBoardDao;
import prj.trip.tboard.vo.TBoardVo;

public class TboardUpdateForm implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String    sboardNum = request.getParameter("tbNum");
		int       boardNum  = Integer.parseInt(sboardNum);
		System.out.println(sboardNum);
		// 게시물 불러오기
		TBoardDao dao       =  new TBoardDao();
		TBoardVo  tboardVo  = dao.selectTBoard(boardNum);
		
		request.setAttribute("tboardVo", tboardVo);
		
		String path = "/view/tboard/tbupdate.jsp";
		request.getRequestDispatcher(path).forward(request, response);
		
	}

}
