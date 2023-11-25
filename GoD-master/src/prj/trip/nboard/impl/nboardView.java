package prj.trip.nboard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.nboard.dao.NBoardDao;
import prj.trip.nboard.service.Action;
import prj.trip.nboard.vo.NBoardVo;

public class nboardView implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		int num = Integer.parseInt(request.getParameter("nb_num"));
		String nb_nick = request.getParameter("nb_nick");
		String nick = (String) session.getAttribute("LoginNick");
		
		NBoardDao dao = new NBoardDao();

		NBoardVo vo = dao.getnBoard(num);
		
		request.setAttribute("nboardView", vo);
		request.setAttribute("nick", nick);
		request.setAttribute("nb_nick", nb_nick);
		
		String path = "/view/nboard/nboardView.jsp";

		request.getRequestDispatcher(path).forward(request, response);

	}

}
