package prj.trip.tboard.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import prj.trip.comment.vo.CommentVo;
import prj.trip.member.dao.MemberDao;
import prj.trip.tboard.dao.TBoardDao;

public class CommentDeleteAction implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charSet=UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String stbcNum = request.getParameter("tbcNum");
		int    tbcNum  = Integer.parseInt(stbcNum);
		String stbNum = request.getParameter("tbNum");
		int    tbNum  = Integer.parseInt(stbNum);
		int    currentPage = 1;
		int    dpp		   = 10;
		
		TBoardDao dao   = new TBoardDao();
		List<CommentVo> cmtList = dao.deleteCmt( tbcNum , tbNum, currentPage, dpp-10); //최신 정보를 가져옴
		int    totalData   = dao.getCmtCount(tbNum);
		System.out.println("총 댓글수:"+totalData);
		
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
