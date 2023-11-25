package prj.trip.nboard.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.OracleCallableStatement;
import prj.trip.db.DBConn;
import prj.trip.nboard.vo.NBoardVo;

public class NBoardDao {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private CallableStatement cstmt = null;
	private ResultSet rs = null;

	// 게시글 삽입
	public void nboardInsert(NBoardVo vo) {

		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "INSERT INTO NOTICE_BOARD VALUES((SELECT NVL(MAX(NB_NUM),0)+1 FROM NOTICE_BOARD),?,?,0,SYSDATE,NULL,NULL,?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, vo.getNb_title());
			pstmt.setString(2, vo.getNb_cont());
			pstmt.setInt(3, vo.getMem_num());
			pstmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}

	}

	// 게시글 목록
	public List<NBoardVo> getnBoardList() {
		List<NBoardVo> vo = new ArrayList<>();
		ResultSet rs = null;

		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "SELECT NB_NUM, NB_TITLE, M.MEM_NICK, NB_CNT, NB_DATE";
			sql += " FROM NOTICE_BOARD NB, MEMBER M";
			sql += " WHERE M.MEM_NUM = NB.MEM_NUM";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int nb_num = rs.getInt("NB_NUM");
				String nb_title = rs.getString("NB_TITLE");
				int nb_cnt = rs.getInt("NB_CNT");
				String nb_date = rs.getString("NB_DATE");
				String mem_nick = rs.getString("MEM_NICK");

				NBoardVo nbvo = new NBoardVo(nb_num, nb_title, mem_nick, nb_cnt, nb_date);
				vo.add(nbvo);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
			}
		}
		return vo;
	}

	// 개인 식별번호 가져오기

	public int getMem_num(String nick) {

		ResultSet rs = null;
		int mem_num = 0;

		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "SELECT M.MEM_NUM FROM MEMBER M";
			sql += " WHERE M.MEM_NICK = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, nick);

			rs = pstmt.executeQuery();

			if (rs.next())
				mem_num = rs.getInt("MEM_NUM");

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
			}
		}
		return mem_num;

	}

	// 제목누르면 해당 게시글 들고옴
	public NBoardVo getnBoard(int getnb_num) {

		ResultSet rs = null;
		NBoardVo vo = new NBoardVo();

		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "{CALL PKG_NBOARD.PROC_NBOARD_VIEW(?,?)}";

			cstmt = conn.prepareCall(sql);

			cstmt.setInt(1, getnb_num);
			cstmt.registerOutParameter(2, oracle.jdbc.OracleTypes.CURSOR);

			cstmt.execute();

			OracleCallableStatement ostmt = (OracleCallableStatement) cstmt;

			rs = ostmt.getCursor(2);

			if (rs.next()) {
				String nb_title = rs.getString("NB_TITLE");
				String mem_nick = rs.getString("MEM_NICK");
				int nb_cnt = rs.getInt("NB_CNT");
				String nb_date = rs.getString("NB_DATE");
				String nb_cont = rs.getString("NB_CONT");
				int nb_num = rs.getInt("NB_NUM");

				vo = new NBoardVo(nb_title, mem_nick, nb_cnt, nb_date, nb_cont, nb_num);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null)
					conn.close();
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
			}
		}

		return vo;
	}

	// 수정
	public void nboardUpdate(int nboardNum, String cont, String title) {

		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "{CALL PKG_NBOARD.PROC_NBOARD_UPDATE(?,?,?)}";

			cstmt = conn.prepareCall(sql);

			cstmt.setInt(1, nboardNum);
			cstmt.setString(2, title);
			cstmt.setString(3, cont);

			cstmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null)
					conn.close();

			} catch (SQLException e) {
			}
		}

	}

	// 삭제
	public void nboardDelete(int nboardNum) {

		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "{CALL PKG_NBOARD.PROC_NBOARD_DELETE(?)}";

			cstmt = conn.prepareCall(sql);

			cstmt.setInt(1, nboardNum);

			cstmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (cstmt != null)
					cstmt.close();
				if (conn != null)
					conn.close();

			} catch (SQLException e) {
			}
		}
	}

	public int getDataCount() {
		int    dataCnt = 0;
		String sql     = "SELECT COUNT(*) FROM NOTICE_BOARD";
		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs    = pstmt.executeQuery();
			if(rs.next()){
				dataCnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
				if (rs != null)
					rs.close();
			} catch (SQLException e) {}
		}
		return dataCnt;
	}

	public List<NBoardVo> getPagingData(int currentpage, int dpp) {
		ArrayList<NBoardVo> boardList = new ArrayList<>();

		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "SELECT * ";
			sql += " FROM (SELECT NB_NUM, NB_TITLE, NB_CNT, NB_DATE, MEM_NICK,";
			sql += " ROW_NUMBER() OVER(ORDER BY NB.NB_NUM DESC NULLS LAST) RN ";
			sql += " FROM NOTICE_BOARD NB JOIN MEMBER M ON NB.MEM_NUM = M.MEM_NUM";
			sql += " GROUP BY NB.NB_NUM, NB_TITLE, NB_CNT, NB_DATE, MEM_NICK) T";
			sql += " WHERE RN BETWEEN 1 + (10)*(?+?) AND 10 + (10)*(?+?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, currentpage - 1); // 첫번째 ?= 세번째 ? :누른 버튼의 번호-1
			pstmt.setInt(2, dpp); // 두번째 ?=네번째? :보여줄 자료 수(기본 10개씩 보여주나 -5,+10 으로 조절 가능)
			pstmt.setInt(3, currentpage - 1);
			pstmt.setInt(4, dpp);
			rs = pstmt.executeQuery();
			// 작성자 추천수, 메인 이미지
			while (rs.next()) {
				int nb_num = rs.getInt(1); // 테이블 번호
				String nb_title = rs.getString(2); // 테이블 제목
				int nb_cnt = rs.getInt(3); // 조회수
				String nb_date = rs.getString(4); // 작성일
				String nick = rs.getString(5); // 작성자

				NBoardVo nVo = new NBoardVo();
				nVo.setNb_num(nb_num);
				nVo.setNb_title(nb_title);
				nVo.setNb_cnt(nb_cnt);
				nVo.setNb_date(nb_date);
				nVo.setMem_nick(nick);
				boardList.add(nVo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
				if (rs != null)
					rs.close();
			} catch (SQLException e) {}

		}
		return boardList;

	}
	
	//main으로 보낼 데이터 조회
		public List<NBoardVo> getMainData() {
			ArrayList<NBoardVo> boardList = new ArrayList<>();

			try {
				DBConn db = new DBConn();
				conn = db.getConnection();
				String sql = "SELECT * ";
				sql += " FROM (SELECT NB_NUM, NB_TITLE, NB_CNT, NB_DATE, MEM_NICK,";
				sql += " ROW_NUMBER() OVER(ORDER BY NB.NB_NUM DESC NULLS LAST) RN ";
				sql += " FROM NOTICE_BOARD NB JOIN MEMBER M ON NB.MEM_NUM = M.MEM_NUM";
				sql += " GROUP BY NB.NB_NUM, NB_TITLE, NB_CNT, NB_DATE, MEM_NICK) T";
				sql += " WHERE RN BETWEEN 1 AND 5";

				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				// 작성자 추천수, 메인 이미지
				while (rs.next()) {
					int nb_num = rs.getInt(1); // 테이블 번호
					String nb_title = rs.getString(2); // 테이블 제목
					int nb_cnt = rs.getInt(3); // 조회수
					String nb_date = rs.getString(4); // 작성일
					String nick = rs.getString(5); // 작성자

					NBoardVo nVo = new NBoardVo();
					nVo.setNb_num(nb_num);
					nVo.setNb_title(nb_title);
					nVo.setNb_cnt(nb_cnt);
					nVo.setNb_date(nb_date);
					nVo.setMem_nick(nick);
					boardList.add(nVo);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
					if (rs != null)
						rs.close();
				} catch (SQLException e) {}

			}
			return boardList;

		}
	
	//신고 내용 삽입
	public void report(String cont, int bmem_num, int lmem_num) {

		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = " INSERT INTO REPORT VALUES ";
				   sql += " ((SELECT NVL(MAX(REPORT_NUM),0)+1 FROM REPORT),?,SYSDATE,?,?)";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, cont);
			pstmt.setInt(2, lmem_num);
			pstmt.setInt(3, bmem_num);
			pstmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();

			} catch (SQLException e) {
			}
		}
		
	}
}
