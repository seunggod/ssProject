package prj.trip.tboard.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import prj.trip.comment.vo.CommentVo;
import prj.trip.tboard.dao.TBoardDao;

public class CommentPagingAction implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charSet=UTF-8");
		PrintWriter out  = response.getWriter();
		request.setCharacterEncoding("UTF-8");
		String sboardNum = request.getParameter("boardNum");
		String scrtPage = request.getParameter("currentpage");
		String sdpp     = request.getParameter("dpp");
		// 파라미터 받기
		int    currentPage = Integer.parseInt(scrtPage);
		int    dpp		   = Integer.parseInt(sdpp);
		int    boardNum    = Integer.parseInt(sboardNum);
		// dao 처리
		TBoardDao dao      = new TBoardDao();
		int    totalData   = dao.getCmtCount(boardNum); //총 자료수 갱신
		List<CommentVo> cmtList = dao.getCmtList(boardNum, currentPage, dpp-10);
		JSONObject jsoncmt = new JSONObject();
		jsoncmt.put("total", totalData);
		jsoncmt.put("dpp", dpp);
		JSONArray jarr = new JSONArray();
		for (CommentVo commentVo : cmtList) {
			JSONObject cmtVo = new JSONObject();
			cmtVo.put("cmtNum", commentVo.getCmtNum() );
			cmtVo.put("cmtNick", commentVo.getCmtWriter());
			cmtVo.put("cmtDate", commentVo.getCmtdate());
			cmtVo.put("cmtCont", commentVo.getCmtCont());
			jarr.add(cmtVo);
		}
		jsoncmt.put("cmtList", jarr);
		String json = jsoncmt.toJSONString();
		out.print(json);
		out.close();
		
		
	}

}
