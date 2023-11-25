package prj.trip.nboard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.nboard.dao.NBoardDao;
import prj.trip.nboard.service.Action;
import prj.trip.nboard.vo.NBoardVo;

public class nboardWriteInsert implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		String nick = (String) session.getAttribute("LoginNick");
		
		String cont = request.getParameter("nCont");
		String title = request.getParameter("nTitle");
		
		NBoardDao dao = new NBoardDao();
		int mem_num = dao.getMem_num(nick);
		
		NBoardVo vo = new NBoardVo(nick, cont, title,mem_num);
		
		dao.nboardInsert(vo);
		
		
		String path = "/nboard?cmd=nboardList";
		request.getRequestDispatcher(path).forward(request,response);
		

	}

}
