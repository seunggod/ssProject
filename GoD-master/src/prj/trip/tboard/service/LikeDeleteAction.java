package prj.trip.tboard.service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import prj.trip.member.dao.MemberDao;
import prj.trip.tboard.dao.TBoardDao;

public class LikeDeleteAction implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charSet=UTF-8");
		//현재 페이지와 장당 보여줄 페이지를 인자로 받아 보낼 필요
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String      loginId = (String) session.getAttribute("LoginId");
		MemberDao   mDao    = new MemberDao();
		//int         memNum  = mDao.getMemNum(loginId);
		int memNum =1;
		String stbNum   = request.getParameter("boardNum");
		
		int    tbNum	= Integer.parseInt(stbNum);
		
		TBoardDao dao = new TBoardDao();
		int likeCnt = dao.deleteLike(tbNum, memNum);
		
		
		
		JSONObject ljson = new JSONObject();
		ljson.put("likeCnt", likeCnt);
		
		String json = ljson.toJSONString();
		out.print(json);
		out.close();
	}

}
