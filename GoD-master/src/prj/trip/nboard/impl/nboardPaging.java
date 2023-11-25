package prj.trip.nboard.impl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import prj.trip.nboard.dao.NBoardDao;
import prj.trip.nboard.service.Action;
import prj.trip.nboard.vo.NBoardVo;

public class nboardPaging implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charSet=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		int currentpage = Integer.parseInt(request.getParameter("currentpage")); //현재페이지
		int dpp = Integer.parseInt(request.getParameter("dpp")); // 한페이지당 자료 수
		
		NBoardDao dao = new NBoardDao();
		
		int totald = dao.getDataCount(); // 총 자료수
		
		List<NBoardVo> boardList = dao.getPagingData(currentpage,dpp-10);
		
		JSONArray jarr = new JSONArray();
		JSONObject njson = new JSONObject();
		
		njson.put("total", totald);
		njson.put("dpp", dpp);
		
		for(NBoardVo nboardVo : boardList) {
			JSONObject jsonVo = new JSONObject();
			jsonVo.put("nbNum", nboardVo.getNb_num());
			jsonVo.put("title", nboardVo.getNb_title());
			jsonVo.put("nick", nboardVo.getMem_nick());
			jsonVo.put("date", nboardVo.getNb_date());
			jsonVo.put("cont", nboardVo.getNb_cont());
			jsonVo.put("cnt", nboardVo.getNb_cnt());
			
			jarr.add(jsonVo);
			
		}
		njson.put("nboard", jarr);
		String json = njson.toJSONString();
		request.setAttribute("nboardList", boardList);
		out.print(json);
		out.close();
		
	}

}
