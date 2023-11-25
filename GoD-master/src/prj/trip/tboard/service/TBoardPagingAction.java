package prj.trip.tboard.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import prj.trip.comment.vo.CommentVo;
import prj.trip.tboard.dao.TBoardDao;
import prj.trip.tboard.vo.TBoardVo;

public class TBoardPagingAction implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charSet=UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String spage = request.getParameter("currentpage"); //현재 페이지(누른 번호)
		String sdpp = request.getParameter("dpp");  //한 페이지당 자료수
		System.out.println(spage+" "+sdpp);
		int currentPage = Integer.parseInt(spage);
		int dpp         = Integer.parseInt(sdpp);
		
		//pageCount를 받아서 이용하고 보낼지는 고민 중
		
		TBoardDao dao = new TBoardDao();
		int totald = dao.getDataCount(); //총 자료수
		List<TBoardVo> boardList = dao.getPagingData(currentPage,dpp-10);
		if(boardList.size()==0) {
			System.out.println("00000");
		}
		for (TBoardVo tBoardVo : boardList) {
			System.out.println(tBoardVo);
			
		}
		JSONArray jarr  = new JSONArray();
		JSONObject tjson = new JSONObject();
		tjson.put("total", totald);
		tjson.put("dpp", dpp);
		for (TBoardVo tBoardVo : boardList) {
			JSONObject jsonVo = new JSONObject();
			jsonVo.put("tbNum", tBoardVo.getTbNum());
			jsonVo.put("title", tBoardVo.getTitle());
			jsonVo.put("nickname", tBoardVo.getNickName());
			jsonVo.put("addr", tBoardVo.getAddr());
			jsonVo.put("wDate", tBoardVo.getwDate());
			jsonVo.put("img1", tBoardVo.getImg1());
			jsonVo.put("readCnt", tBoardVo.getReadCnt());
			jsonVo.put("likeCnt", tBoardVo.getLikeCnt());
			jsonVo.put("number", tBoardVo.getNumber());
			jarr.add(jsonVo);
		}
		tjson.put("tboard", jarr);
		String json = tjson.toJSONString();
		request.setAttribute("boardList", boardList);
		out.print(json);
		out.close();
	}
	
}
