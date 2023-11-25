package prj.trip.nboard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.nboard.dao.NBoardDao;
import prj.trip.nboard.service.Action;
import prj.trip.nboard.vo.NBoardVo;

public class nboardDelete implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
	    String nick = (String) session.getAttribute("LoginNick");
	    
		int nboardNum= Integer.parseInt(request.getParameter("nb_num"));

		NBoardDao dao = new NBoardDao();
		
		dao.nboardDelete(nboardNum);
		
		String path = "/nboard?cmd=nboardList";
		
		request.getRequestDispatcher(path).forward(request, response);
		

	}

}
