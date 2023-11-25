package prj.trip.nboard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.nboard.dao.NBoardDao;
import prj.trip.nboard.service.Action;

public class nboardReport implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		String loginNick = (String) session.getAttribute("LoginNick");
		String nick = request.getParameter("mem_nick");
		String nb_num = request.getParameter("nb_num");
		String nb_title = request.getParameter("nb_title");
		String rp_cont = request.getParameter("rp_cont");
		
		String cont = nb_title +","+ rp_cont;
		
		System.out.println(rp_cont);
		
		NBoardDao dao = new NBoardDao();
		
		int bmem_num = dao.getMem_num(nick); //게시물 올린 녀석의 mem_num
		int lmem_num = dao.getMem_num(loginNick); // 로그인한 녀석의 mem_num
		
		dao.report(cont,bmem_num,lmem_num);
		

		String path ="/nboard?cmd=nboardView&nb_num="+nb_num+"&nb_nick="+nick;
		
		request.getRequestDispatcher(path).forward(request, response);
	}

}
