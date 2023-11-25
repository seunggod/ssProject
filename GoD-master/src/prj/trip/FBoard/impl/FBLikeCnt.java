package prj.trip.FBoard.impl;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.FBoard.controller.Action;
import prj.trip.FBoard.dao.FreeBoardDao;

public class FBLikeCnt implements Action{

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("LoginId");
		String fbnum = request.getParameter("fbnum");
		
		if(id == null) {
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter writer = response.getWriter(); 
			writer.println("<script>alert('로그인이 필요합니다.'); history.back(); </script>"); 
			writer.close();
		}else {
			FreeBoardDao fbdao = new FreeBoardDao();
			String mnum = fbdao.getMemNumm(id);
			int a = fbdao.InFBLike(fbnum, mnum);
			if(a == 1) {
				
				String path = "fboard?cmd=FBoardClick&fbnum=" + fbnum;
				request.getRequestDispatcher(path).forward(request, response);
			}else {
				System.out.println(fbnum);
				fbdao.InsertFBLike(fbnum, mnum);
				String path = "fboard?cmd=FBoardClick&fbnum=" + fbnum;
				request.getRequestDispatcher(path).forward(request, response);
			}
			
			
		}
	}

}
