package prj.trip.nboard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.nboard.dao.NBoardDao;
import prj.trip.nboard.service.Action;
import prj.trip.nboard.vo.NBoardVo;

public class nboardWrite implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		String nick = (String) session.getAttribute("LoginNick");

		NBoardVo nboardVo = new NBoardVo();

		nboardVo.setMem_nick(nick);

		request.setAttribute("nboardVo", nboardVo);

		String path = "/view/nboard/noticeWrite.jsp";
		request.getRequestDispatcher(path).forward(request, response);

	}

}
