package prj.trip.nboard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.nboard.dao.NBoardDao;
import prj.trip.nboard.service.Action;
import prj.trip.nboard.vo.NBoardVo;

public class nboardUpdateForm implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		
	    String nick = (String) session.getAttribute("LoginNick");
	
		int nboardNum= Integer.parseInt(request.getParameter("nb_num"));
		String title = request.getParameter("nb_title");
		String cont = request.getParameter("nb_cont");
		

		NBoardDao dao = new NBoardDao();
		NBoardVo vo = new NBoardVo();
		
		vo.setMem_nick(nick);
		vo.setNb_title(title);
		vo.setNb_cont(cont);
		vo.setNb_num(nboardNum);
		
		request.setAttribute("nbUpdate", vo);
		
		String path="/view/nboard/udate.jsp";
		request.getRequestDispatcher(path).forward(request, response);

	}

}
