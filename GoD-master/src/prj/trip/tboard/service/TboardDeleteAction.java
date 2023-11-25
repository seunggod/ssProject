package prj.trip.tboard.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import prj.trip.tboard.dao.TBoardDao;

public class TboardDeleteAction implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String stbNum = request.getParameter("tbNum");
		int    tbNum  = Integer.parseInt(stbNum);
		
		TBoardDao dao = new TBoardDao();
		int aftcnt = dao.deleteTBoard(tbNum);
		System.out.println("삭제결과:"+aftcnt);
		
		String path="/tboard?cmd=TBOARDLISTFORM";
		request.getRequestDispatcher(path).forward(request, response);

	}

}
