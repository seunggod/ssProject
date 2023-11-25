package prj.trip.nboard.impl;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.member.dao.MemberDao;
import prj.trip.nboard.dao.NBoardDao;
import prj.trip.nboard.service.Action;
import prj.trip.nboard.vo.NBoardVo;

public class nboardList implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		
		String id = (String) session.getAttribute("LoginId");
		
		int currentpage = 1; //현재페이지
		int dpp = 10; // 한페이지당 자료 수
		
		NBoardDao dao = new NBoardDao();
		MemberDao mdao = new MemberDao();
		
		int level = mdao.getMemLevel(id);

		
		int totalData = dao.getDataCount();
		
		request.setAttribute("dpp", dpp);
		request.setAttribute("totalData", totalData);
		request.setAttribute("id", id);
		request.setAttribute("level", level);
		
		
		List<NBoardVo> nboardList = dao.getPagingData(currentpage,dpp-10);

		request.setAttribute("nboardList", nboardList);


		String path = "/view/nboard/noticeBoard.jsp";

		request.getRequestDispatcher(path).forward(request, response);

	}

}
