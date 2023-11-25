package prj.trip.common.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import prj.trip.common.controller.Action;
import prj.trip.tboard.dao.TBoardDao;
import prj.trip.tboard.vo.TBoardVo;

public class GoMainAction implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//3가지 게시판에서 모두 정보를 받아와야 함
		request.setCharacterEncoding("UTF-8");
		
		//여행지 추천 자료 가져오기
		TBoardDao tDao = new TBoardDao();
		List<TBoardVo> tBoardList = tDao.getMainData();
		request.setAttribute("tboardList", tBoardList);
		
		//공지사항 자료 가져오기
		NBoardDao nDao = new NBoardDao();
		List<NBoardVo> nBoardList = nDao.getMainData();
		request.setAttribute("nboardList", nBoardList);
		
		
		//자유게시판 자료 가져오기
		int startNum = 1;
		int endNum   = 5;
		FreeBoardDao fDao = new FreeBoardDao();
		List<FreeBoardVo> fBoardList = fDao.getFreeBoardList(startNum, endNum);
		request.setAttribute("fboardList", fBoardList);
		// 경로 설정
		String path="main.jsp";
		request.getRequestDispatcher(path).forward(request, response);

	}

}
