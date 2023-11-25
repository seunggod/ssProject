package prj.trip.tboard.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.member.dao.MemberDao;
import prj.trip.tboard.dao.TBoardDao;
import prj.trip.tboard.vo.TBoardVo;

public class TBoardListSortForm implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int currentPage = 1; // 첫페이지를 보여줌
		int dpp         = 0; // 기본 페이지당 자료수는 10
		HttpSession session = request.getSession();
		
		String    loginId   = (String) session.getAttribute("LoginId");
		MemberDao mDao = new MemberDao();
		//관리자 권한 확인
		int uLevel = mDao.getMemLevel(loginId);
		request.setAttribute("uLevel",uLevel);
		//관리자여부를  확인하지 못하게 하기 위해 구분할만한 표시는 주지않는다.
		String sodNum   = request.getParameter("odNum");
		int    odNum    = Integer.parseInt(sodNum);
		request.setAttribute("odNum", odNum);
		int searchNum   = 0;
		request.setAttribute("searchNum", searchNum);
		TBoardDao dao = new TBoardDao();
		int totalData   = dao.getDataCount();
		request.setAttribute("dpp", dpp+10);
		request.setAttribute("totalData", totalData);
		List<TBoardVo> boardList =  dao.getPagingSortData(currentPage, dpp, odNum);
		request.setAttribute("boardList", boardList);
		
		
		String path="/view/tboard/tboardlist.jsp";
		request.getRequestDispatcher(path).forward(request, response);

	}

}
