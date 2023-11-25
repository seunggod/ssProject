package prj.trip.FBoard.impl;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.FBoard.controller.Action;

public class FBoardWriter implements Action{

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("LoginId") == null ) {
			String PageUrl ="/view/common/Login.jsp";
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter writer = response.getWriter(); 
			writer.println("<script>alert('로그인이 필요합니다.'); location.href='"+PageUrl+"';</script>"); 
			writer.close();
		}else {
			String path="/view/fboard/FBoardWrite.jsp";
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
