package prj.trip.FBoard.impl;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import prj.trip.FBoard.controller.Action;
import prj.trip.FBoard.dao.FreeBoardDao;

public class FBCUpdate implements Action{

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fbcnum = request.getParameter("fbcnum");
		String id = request.getParameter("id");
		String fbnum = request.getParameter("fbnum");
		String cont = request.getParameter("cont");
		
		System.out.println("댓글 수정 댓글 번호 : "+ fbcnum);
		System.out.println("댓글 수정 아디이 : "+ id);
		System.out.println("댓글 수정 게시물 번호 : "+ fbnum);
		System.out.println("댓글 수정 내용 : "+ cont);
		
		FreeBoardDao dao = new FreeBoardDao();
		dao.RipleUpdate(fbcnum, cont);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		String str="";
		str = "<script>";
		str += " opener.window.location.reload();";  //오프너 새로고침
		str += " self.close();";   // 창닫기
		str += " </script>";
		out.print(str);
		out.close();
		
		   
		
	}

}
