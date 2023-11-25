package prj.trip.nboard.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.nboard.dao.NBoardDao;
import prj.trip.nboard.service.Action;
import prj.trip.nboard.vo.NBoardVo;

public class nboardReportForm implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String nick = request.getParameter("mem_nick");
		int nb_num = Integer.parseInt(request.getParameter("nb_num"));
		String nb_title = request.getParameter("nb_title");
		
		NBoardVo vo = new NBoardVo();
		
		vo.setMem_nick(nick);
		vo.setNb_num(nb_num);
		vo.setNb_title(nb_title);
		
		request.setAttribute("rp_vo",vo);

		String path="/view/common/report.jsp";
		request.getRequestDispatcher(path).forward(request, response);
		

	}

}
