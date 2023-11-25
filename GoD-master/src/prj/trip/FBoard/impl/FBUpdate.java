package prj.trip.FBoard.impl;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import prj.trip.FBoard.controller.Action;
import prj.trip.FBoard.dao.FreeBoardDao;

public class FBUpdate implements Action{

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("writeTitle");
		String cont = request.getParameter("writeContent");
		String fbnum = request.getParameter("fbnum");
		
		FreeBoardDao dao = new FreeBoardDao();
		dao.FBUpdate(title, cont, fbnum);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		String str="";
		str = "<script>";
		str += " opener.window.location.reload();";  //오프너 새로고침
		str += " self.close();";   // 창닫기
		str += " </script>";
		out.println(str);
		out.close();
		
		               
		
	}

}
