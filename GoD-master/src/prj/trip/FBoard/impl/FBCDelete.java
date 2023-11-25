package prj.trip.FBoard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import prj.trip.FBoard.controller.Action;
import prj.trip.FBoard.dao.FreeBoardDao;

public class FBCDelete implements Action{

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fbcnum = request.getParameter("fbcnum");
		String fbnum = request.getParameter("fbnum");
		String id = request.getParameter("id");
		System.out.println("게시물 번호! :"+fbnum);
		System.out.println(fbcnum);
		System.out.println(id);
		
		FreeBoardDao fbvo = new FreeBoardDao();
		
		request.setAttribute("fbnum", fbnum);
		
		fbvo.FBCDelete(fbcnum);
		
		String path = "fboard?cmd=FBoardClick&fbnum=" + fbnum;
		request.getRequestDispatcher(path).forward(request, response);
		
	}

}
