package prj.trip.nboard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.nboard.dao.NBoardDao;
import prj.trip.nboard.service.Action;
import prj.trip.nboard.vo.NBoardVo;

public class nboardUpdate implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
	    String nick = (String) session.getAttribute("LoginNick");
	    
		int nboardNum= Integer.parseInt(request.getParameter("nb_num"));
		
		String cont = request.getParameter("nb_cont");
		String title = request.getParameter("nb_title");
		

		NBoardDao dao = new NBoardDao();

		
		dao.nboardUpdate(nboardNum,cont,title);
		
		String path = "/nboard?cmd=nboardList";
		
		request.getRequestDispatcher(path).forward(request, response);
			
		
		
		
		

	}

}
