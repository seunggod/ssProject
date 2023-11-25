package prj.trip.FBoard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.FBoard.controller.Action;
import prj.trip.FBoard.dao.FreeBoardDao;

public class FBCInsert implements Action{

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("LoginId");
		
		FreeBoardDao dao = new FreeBoardDao();
		String memnum = dao.getMemNumm(id);
		System.out.println("댓글아이디" +id);
		
		String fnum = request.getParameter("fbnum");
		String cont = request.getParameter("cont");
		
		dao.InsertFBC(fnum,memnum,cont);
		
		String path = "fboard?cmd=FBoardClick&fbnum=" + fnum;
		request.getRequestDispatcher(path).forward(request, response);
	}

}
