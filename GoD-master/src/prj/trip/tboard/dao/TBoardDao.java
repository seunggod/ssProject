package prj.trip.tboard.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLType;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.OracleCallableStatement;
import prj.trip.db.DBConn;
import prj.trip.comment.vo.CommentVo;
import prj.trip.tboard.vo.TBoardVo;




// close()를 이용해 Connection을 끊는 걸로
public class TBoardDao {
	private DBConn db;
	private Connection conn;
	private PreparedStatement pstmt;
	private CallableStatement cstmt;
	private ResultSet rs;
	
	

	//게시물 불러오기(조회수 증가하는 버전)
	public TBoardVo getTBoard(int inBoardNum) {
		TBoardVo board = new TBoardVo();
		String sql = "{ CALL PKG_TRIPREQ.PROC_GETBOARD( ? , ? ) }";
		try {
			db    = new DBConn();
			conn  = db.getConnection();
			cstmt = conn.prepareCall(sql);
			cstmt.setInt(1, inBoardNum);
			cstmt.registerOutParameter(2, oracle.jdbc.OracleTypes.CURSOR);
			
			cstmt.execute();
			OracleCallableStatement ocstmt = (OracleCallableStatement) cstmt;
			rs = ocstmt.getCursor(2);
			if(rs.next()) {
				int    boardNum    = rs.getInt("TB_NUM");
				String title       = rs.getString("TB_TITLE");
				String allcont     = rs.getString("TB_CONT"); // %111%로 SPLIT 필요
				String[] contbox   = allcont.split("%111%");
				int    readCnt     = rs.getInt("TB_CNT");
				String date        = rs.getString("TB_DATE");
				String addr        = rs.getString("TB_ADDR");
				String img1        = rs.getString("TB_IMG1");
				String img2        = rs.getString("TB_IMG2");
				String img3        = rs.getString("TB_IMG3");
				String img4        = rs.getString("TB_IMG4");
				//String video1      = rs.getString("TB_VIDEO1");
				//String video2      = rs.getString("TB_VIDEO2");
				String writer	   = rs.getString("MEM_NICK");
				int    likeCnt	   = rs.getInt("LIKECNT");
				int    cmtCnt      = rs.getInt("CMTCNT");
				System.out.println("추천수:"+likeCnt);
				System.out.println(img1+" "+img2+" "+img3+" "+img4);
				if( img3 == null) {
					img3 = "0";
					if( img4 == null) {
						img4 = "0";
					}
					
				}
				// vo 안에 투입
				board.setTbNum(boardNum);
				board.setTitle(title);
				for (int i = 0; i < contbox.length; i++) {
					System.out.println(i+":"+contbox[i]);
					switch(i) {
					case 0: board.setCont(contbox[i]); break;
					case 1: board.setCont2(contbox[i]); break;
					case 2: board.setCont3(contbox[i]); break;
					case 3: board.setCont4(contbox[i]); break;
					}
				}
				
			
				System.out.println(board.getCont2());
				System.out.println(board.getCont4());
				board.setReadCnt(readCnt);
				board.setwDate(date);
				board.setAddr(addr);
				board.setImg1(img1); // 예외처리 필요
				board.setImg2(img2);
				board.setImg3(img3);
				board.setImg4(img4);
				board.setNickName(writer);
				board.setLikeCnt(likeCnt);
				board.setCmtCnt(cmtCnt);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		
		
		
		return board;
	}
	
	// 댓글목록 가져오기(페이징)
	public ArrayList<CommentVo> getCmtList(int boardNum, int currentPage, int dpp) {
		ArrayList<CommentVo> cmtList = new ArrayList<CommentVo>();
		
		String sql = "SELECT * ";
		sql		  += " FROM (SELECT TBC_NUM, TBC_CONT, TBC_DATE, MEM_NICK , ";
		sql		  += " ROW_NUMBER() OVER (ORDER BY TBC_NUM DESC NULLS LAST) RN";
		sql		  += " FROM   TB_COMMENT C JOIN TRIP_BOARD T ON C.TB_NUM = T.TB_NUM";
		sql		  += " JOIN MEMBER M ON C.MEM_NUM = M.MEM_NUM";
		sql		  += " AND C.TB_NUM = ?)T";
		sql	      += "	WHERE RN BETWEEN 1 + (10)*(?+?) AND 10 + (10)*(?+?)";
		try {
			db    = new DBConn();
			conn  = db.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNum);
			pstmt.setInt(2, currentPage-1);
			pstmt.setInt(3, dpp);
			pstmt.setInt(4, currentPage-1);
			pstmt.setInt(5, dpp);
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				int    cmtNum  = rs.getInt("TBC_NUM");
				String cmtCont = rs.getString("TBC_CONT");
				String cmtDate = rs.getString("TBC_DATE");
				String cmtNick = rs.getString("MEM_NICK");
				CommentVo cmtVo = new CommentVo(cmtNum, cmtCont, cmtNick, cmtDate, boardNum);
				cmtList.add(cmtVo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cmtList;
	}

	// 댓글추가+입력(프로시저 각: 추가와 조회)
		public List<CommentVo> insertCmt( int memNum, int tbNum, String comment,int currentPage, int dpp) {
			ArrayList<CommentVo> cmtList = new ArrayList<CommentVo>();
			
			String sql = "{ CALL PKG_TRIPREQ.PROC_INSERTCMT( ? , ? , ? , ?, ?, ? ) }";
			
			try {
				db    = new DBConn();
				conn  = db.getConnection();
				cstmt = conn.prepareCall(sql);
				cstmt.setInt(1, memNum);
				cstmt.setInt(2, tbNum);
				cstmt.setString(3, comment);
				cstmt.setInt(4, currentPage-1);
				cstmt.setInt(5, dpp);
				cstmt.registerOutParameter(6, oracle.jdbc.OracleTypes.CURSOR);
				
				cstmt.execute();
				OracleCallableStatement ocstmt = (OracleCallableStatement) cstmt;
				rs = ocstmt.getCursor(6);
				while( rs.next() ){
					CommentVo cVo = new CommentVo();
					cVo.setCmtNum(rs.getInt("TBC_NUM"));
					cVo.setCmtCont(rs.getString("TBC_CONT"));  
					cVo.setCmtWriter(rs.getString("MEM_NICK"));
					cVo.setCmtdate(rs.getString("TBC_DATE")); 
					cmtList.add(cVo);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return cmtList;
		}
	
	
	//여행지 추천 게시글 삽입
	public int insertTBoard(int memNum, String title, String addr, String bcontbox, ArrayList<String> filenames) {
		int aftcnt = 0;
		
		String sql = "INSERT INTO TRIP_BOARD(TB_NUM, TB_TITLE, TB_ADDR, TB_CONT, TB_IMG1, TB_IMG2, TB_IMG3, TB_IMG4, MEM_NUM)";
		sql		  += " VALUES ((SELECT NVL(MAX(TB_NUM),0)+1 FROM TRIP_BOARD), ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			db    = new DBConn();
			conn  = db.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, addr);
			pstmt.setString(3, bcontbox);
			pstmt.setString(4, filenames.get(1));
			pstmt.setString(5, filenames.get(0));
			pstmt.setString(6, filenames.get(3));
			pstmt.setString(7, filenames.get(2));
			pstmt.setInt(8, memNum);
			aftcnt = pstmt.executeUpdate();
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close();
		}
		return aftcnt;
		
	}

	
	
	// 페이징 겸 게시판 목록 가져오기
	public List<TBoardVo> getPagingData(int currentPage,int dpp) {
		ArrayList<TBoardVo> boardList = new ArrayList<>();
		String sql =  "SELECT *  ";
		sql       +=  " FROM (SELECT TB.TB_NUM, TB_TITLE, TB_CNT, TB_DATE, TB_ADDR,";
		sql		  +=  " TB_IMG1, MEM_NICK, COUNT(L.TB_NUM),";
		sql	      +=  " ROW_NUMBER() OVER(ORDER BY TB.TB_NUM DESC NULLS LAST) RN";           
		sql       +=  " FROM TRIP_BOARD TB JOIN MEMBER M ON TB.MEM_NUM = M.MEM_NUM";
		sql       +=  " LEFT JOIN TB_LIKE L ON TB.TB_NUM = L.TB_NUM";
		sql		  +=  " GROUP BY TB.TB_NUM, TB_TITLE, TB_CNT, TB_DATE, TB_ADDR, TB_IMG1,  MEM_NICK) T";
		sql	      +=  "	WHERE RN BETWEEN 1 + (10)*(?+?) AND 10 + (10)*(?+?)";
		
		try {
			db     = new DBConn();
			conn   = db.getConnection();
			pstmt  = conn.prepareStatement(sql);
			pstmt.setInt(1, currentPage-1); //첫번째 ?= 세번째 ? :누른 버튼의 번호-1
			pstmt.setInt(2, dpp); //두번째 ?=네번째? :보여줄 자료 수(기본 10개씩 보여주나 -5,+10 으로 조절 가능) 
			pstmt.setInt(3, currentPage-1);
			pstmt.setInt(4, dpp); 
			rs     = pstmt.executeQuery();
			// 작성자 추천수, 메인 이미지
			while( rs.next() ){
				int    tb_num   = rs.getInt(1);    //테이블 번호 
				String tb_title = rs.getString(2); //테이블 제목
				int    tb_cnt   = rs.getInt(3);    // 조회수
				String tb_date  = rs.getString(4); // 작성일
				String tb_addr  = rs.getString(5); // 관광지 주소
				String mainImg  = rs.getString(6); // 메인이미지
				String nickname = rs.getString(7); // 작성자
				int    likeCnt  = rs.getInt(8);    // 추천수
				int    number   = rs.getInt(9);	   // 검색순대로 번호 붙이기 
				
				TBoardVo tVo = new TBoardVo();
				tVo.setTbNum(tb_num);
				tVo.setTitle(tb_title);
				tVo.setReadCnt(tb_cnt);
				tVo.setwDate(tb_date);
				tVo.setAddr(tb_addr);
				tVo.setImg1(mainImg);
				tVo.setNickName(nickname);
				tVo.setLikeCnt(likeCnt);
				tVo.setNumber(number);
				boardList.add(tVo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return boardList;
	}
	
	//총 자료수 조회
	public int getDataCount() {
		int    dataCnt = 0;
		String sql     = "SELECT COUNT(*) FROM TRIP_BOARD";
		try {
			db    = new DBConn();
			conn  = db.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs    = pstmt.executeQuery();
			if(rs.next()){
				dataCnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return dataCnt;
	}
	
	//검색한 데이터 숫자 가져오기
	public int getSearchDataCount(String keyword) {
		int    dataCnt = 0;
		String sql     = "SELECT COUNT(*) ";
		sql	     	  += " FROM TRIP_BOARD T JOIN MEMBER M";
		sql			  += " ON T.MEM_NUM = M.MEM_NUM";
		sql			  += " WHERE TB_ADDR LIKE ?";
		sql			  += " OR TB_TITLE LIKE ?";
		sql			  += " OR MEM_NICK LIKE ?";
		try {
			db    = new DBConn();
			conn  = db.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+keyword.trim()+"%");
			pstmt.setString(2, "%"+keyword.trim()+"%");
			pstmt.setString(3, "%"+keyword.trim()+"%");
			rs    = pstmt.executeQuery();
			if(rs.next()){
				dataCnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return dataCnt;
	}
	
	
	// 검색한 데이터 검색
	public List<TBoardVo> getSearchData(int currentPage, int dpp, String keyword) {
		ArrayList<TBoardVo> boardList = new ArrayList<>();
		String sql =  "SELECT *  ";
		sql       +=  " FROM (SELECT TB.TB_NUM, TB_TITLE, TB_CNT, TB_DATE, TB_ADDR,";
		sql		  +=  " TB_IMG1, MEM_NICK, COUNT(L.TB_NUM),";
		sql	      +=  " ROW_NUMBER() OVER(ORDER BY TB.TB_NUM DESC NULLS LAST) RN";           
		sql       +=  " FROM TRIP_BOARD TB JOIN MEMBER M ON TB.MEM_NUM = M.MEM_NUM";
		sql       +=  " LEFT JOIN TB_LIKE L ON TB.TB_NUM = L.TB_NUM";
		sql		  +=  " WHERE TB_TITLE LIKE ?";
		sql		  +=  " OR MEM_NICK LIKE ?";
		sql		  +=  " OR TB_ADDR LIKE ?";
		sql		  +=  " GROUP BY TB.TB_NUM, TB_TITLE, TB_CNT, TB_DATE, TB_ADDR, TB_IMG1,  MEM_NICK) T";
		sql	      +=  "	WHERE RN BETWEEN 1 + (10)*(?+?) AND 10 + (10)*(?+?)";
		try {
			db     = new DBConn();
			conn   = db.getConnection();
			pstmt  = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+keyword.trim()+"%");
			pstmt.setString(2, "%"+keyword.trim()+"%");
			pstmt.setString(3, "%"+keyword.trim()+"%");
			pstmt.setInt(4, currentPage-1); //첫번째 ?= 세번째 ? :누른 버튼의 번호-1
			pstmt.setInt(5, dpp); //두번째 ?=네번째? :보여줄 자료 수(기본 10개씩 보여주나 -5,+10 으로 조절 가능) 
			pstmt.setInt(6, currentPage-1);
			pstmt.setInt(7, dpp); 
			rs     = pstmt.executeQuery();
			// 작성자 추천수, 메인 이미지
			while( rs.next() ){
				int    tb_num   = rs.getInt(1);    //테이블 번호 
				String tb_title = rs.getString(2); //테이블 제목
				int    tb_cnt   = rs.getInt(3);    // 조회수
				String tb_date  = rs.getString(4); // 작성일
				String tb_addr  = rs.getString(5); // 관광지 주소
				String mainImg  = rs.getString(6); // 메인이미지
				String nickname = rs.getString(7); // 작성자
				int    likeCnt  = rs.getInt(8);    // 추천수
				int    number   = rs.getInt(9);	   // 검색순대로 번호 붙이기 
				
				TBoardVo tVo = new TBoardVo();
				tVo.setTbNum(tb_num);
				tVo.setTitle(tb_title);
				tVo.setReadCnt(tb_cnt);
				tVo.setwDate(tb_date);
				tVo.setAddr(tb_addr);
				tVo.setImg1(mainImg);
				tVo.setNickName(nickname);
				tVo.setLikeCnt(likeCnt);
				tVo.setNumber(number);
				boardList.add(tVo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return boardList;
	}
	
	
	//좋아요 후 추천수 조회
	public int updateLike(int tbNum, int memNum) {
		int likeCnt = 0;
		String sql = " { CALL PKG_TRIPREQ.PROC_LIKEUPDATE( ? , ? , ? ) }";
		try {
			db     = new DBConn();
			conn   = db.getConnection();
			cstmt  = conn.prepareCall(sql);
			cstmt.setInt(1, memNum);
			cstmt.setInt(2, tbNum);
			cstmt.registerOutParameter(3, Types.NUMERIC);
			cstmt.execute();
			likeCnt = cstmt.getInt(3);
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return likeCnt;
	}
	
	//좋아요 취소
	public int deleteLike(int tbNum, int memNum) {
		int likeCnt = 0;
		String sql = " { CALL PKG_TRIPREQ.PROC_LIKEDELETE( ? , ? , ? ) }";
		try {
			db     = new DBConn();
			conn   = db.getConnection();
			cstmt  = conn.prepareCall(sql);
			cstmt.setInt(1, memNum);
			cstmt.setInt(2, tbNum);
			cstmt.registerOutParameter(3, Types.NUMERIC);
			cstmt.execute();
			likeCnt = cstmt.getInt(3);
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return likeCnt;
	}
	
	
	// 총 댓글수 가져오기
	public int getCmtCount(int tbNum) {
		int    dataCnt = 0;
		String sql     = "SELECT COUNT(*) FROM TB_COMMENT WHERE TB_NUM = ? ";
		try {
			db    = new DBConn();
			conn  = db.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tbNum);
			rs    = pstmt.executeQuery();
			if(rs.next()){
				dataCnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return dataCnt;
	}
	
	
	
	//게시물 삭제
	public int deleteTBoard(int tbNum) {
		int aftcnt = 0;
		String sql="DELETE FROM TRIP_BOARD WHERE TB_NUM = ?";
		try {
			db    = new DBConn();
			conn  = db.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tbNum);
			aftcnt = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return aftcnt;
	}
	
	//게시물 수정
	public int updateTBoard(int tbNum, String title, String addr, String bcontbox, ArrayList<String> filenames) {
		int aftcnt=0;
		String sql = "UPDATE TRIP_BOARD";
		sql		  += " SET TB_TITLE = ?";
		sql		  += " ,TB_ADDR = ?";
		sql		  += " ,TB_CONT = ?";
		sql		  += " ,TB_IMG1 = ?";
		sql		  += " ,TB_IMG2 = ?";
		sql		  += " ,TB_IMG3 = ?";
		sql		  += " ,TB_IMG4 = ?";
		sql		  += " WHERE TB_NUM = ?";
		
		try {
			db    = new DBConn();
			conn  = db.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, addr);
			pstmt.setString(3, bcontbox);
			pstmt.setString(4, filenames.get(1));
			pstmt.setString(5, filenames.get(0));
			pstmt.setString(6, filenames.get(3));
			pstmt.setString(7, filenames.get(2));
			pstmt.setInt(8, tbNum);
			aftcnt = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		
		return aftcnt;
	}
	
	//게시물 불러오기
	public TBoardVo selectTBoard(int inBoardNum) {
		TBoardVo board = new TBoardVo();
		String sql = "SELECT DISTINCT T.TB_NUM, TB_TITLE, TB_CONT, TB_CNT, TB_DATE, TB_ADDR, ";
		sql		  += "  TB_IMG1, TB_IMG2, TB_IMG3, TB_IMG4, TB_VIDEO1, MEM_NICK, ";
		sql		  += "  (SELECT COUNT(TB_NUM) FROM TB_LIKE WHERE TB_NUM=? ) LIKECNT";
		sql		  += "  ,(SELECT COUNT(TB_NUM) FROM TB_COMMENT WHERE TB_NUM=?) CMTCNT";
		sql		  += " FROM TRIP_BOARD T JOIN MEMBER M ON T.MEM_NUM = M.MEM_NUM";
		sql		  += " LEFT JOIN TB_LIKE L ON T.TB_NUM = L.TB_NUM ";
		sql		  += " LEFT JOIN TB_COMMENT C ON T.TB_NUM = C.TB_NUM";
		sql		  += "  WHERE T.TB_NUM = ?";
 
		try {
			db    = new DBConn();
			conn  = db.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, inBoardNum);
			pstmt.setInt(2, inBoardNum);
			pstmt.setInt(3, inBoardNum);
			
			rs    = pstmt.executeQuery();
			
			
			if(rs.next()) {
				int    boardNum    = rs.getInt("TB_NUM");
				String title       = rs.getString("TB_TITLE");
				String allcont     = rs.getString("TB_CONT"); // %111%로 SPLIT 필요
				String[] contbox   = allcont.split("%111%");
				int    readCnt     = rs.getInt("TB_CNT");
				String date        = rs.getString("TB_DATE");
				String addr        = rs.getString("TB_ADDR");
				String img1        = rs.getString("TB_IMG1");
				String img2        = rs.getString("TB_IMG2");
				String img3        = rs.getString("TB_IMG3");
				String img4        = rs.getString("TB_IMG4");
				//String video1      = rs.getString("TB_VIDEO1");
				//String video2      = rs.getString("TB_VIDEO2");
				String writer	   = rs.getString("MEM_NICK");
				int    likeCnt	   = rs.getInt("LIKECNT");
				int    cmtCnt      = rs.getInt("CMTCNT");
				System.out.println(img1+" "+img2+" "+img3+" "+img4);
				if( img3 == null) {
					img3 = "0";
					if( img4 == null) {
						img4 = "0";
					}
					
				}
				// vo 안에 투입
				board.setTbNum(boardNum);
				board.setTitle(title);
				for (int i = 0; i < contbox.length; i++) {
					System.out.println(i+":"+contbox[i]);
					switch(i) {
					case 0: board.setCont(contbox[i]); break;
					case 1: board.setCont2(contbox[i]); break;
					case 2: board.setCont3(contbox[i]); break;
					case 3: board.setCont4(contbox[i]); break;
					}
				}
				
			
				System.out.println(board.getCont2());
				System.out.println(board.getCont4());
				board.setReadCnt(readCnt);
				board.setwDate(date);
				board.setAddr(addr);
				board.setImg1(img1); // 예외처리 필요
				board.setImg2(img2);
				board.setImg3(img3);
				board.setImg4(img4);
				board.setNickName(writer);
				board.setLikeCnt(likeCnt);
				board.setCmtCnt(cmtCnt);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		
		
		
		return board;
	}
	
	
	
	//댓글 삭제
	public List<CommentVo> deleteCmt(int tbcNum, int tbNum , int currentPage, int dpp) {
		ArrayList<CommentVo> cmtList = new ArrayList<CommentVo>();
		
		String sql = "{ CALL PKG_TRIPREQ.PROC_DELETECMT( ? , ?, ? , ? , ?) }";
		
		try {
			db    = new DBConn();
			conn  = db.getConnection();
			cstmt = conn.prepareCall(sql);
			cstmt.setInt(1, tbcNum);
			cstmt.setInt(2, tbNum);
			cstmt.setInt(3, currentPage-1);
			cstmt.setInt(4, dpp);
			cstmt.registerOutParameter(5, oracle.jdbc.OracleTypes.CURSOR);
			
			cstmt.execute();
			OracleCallableStatement ocstmt = (OracleCallableStatement) cstmt;
			rs = ocstmt.getCursor(5);
			while( rs.next() ){
				CommentVo cVo = new CommentVo();
				cVo.setCmtNum(rs.getInt("TBC_NUM"));
				cVo.setCmtCont(rs.getString("TBC_CONT"));  
				cVo.setCmtWriter(rs.getString("MEM_NICK"));
				cVo.setCmtdate(rs.getString("TBC_DATE")); 
				cmtList.add(cVo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cmtList;
	}
	
	// 게시물 입장 시 로그인한 아이디로 좋아요가 되어있는 지 확인
	public int searchLikeRecord(int memNum, int tbNum){
		int record = 0; //0는 기록없음 1은 기록존재
		String sql = " SELECT TBL_NUM";
		sql		  += " FROM TB_LIKE";
		sql		  += " WHERE MEM_NUM = ?";
		sql		  += " AND TB_NUM = ? ";
		try {
			db     = new DBConn();
			conn   = db.getConnection();
			pstmt  = conn.prepareStatement(sql);
			pstmt.setInt(1, memNum);
			pstmt.setInt(2, tbNum);
			rs     = pstmt.executeQuery();
			if( rs.next() ){
				record = 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return record;
	}
	
	//게시판 정렬
	public List<TBoardVo> getPagingSortData(int currentPage, int dpp, int odNum) {
		ArrayList<TBoardVo> boardList = new ArrayList<>();
		String sql =  "SELECT *  ";
		sql       +=  " FROM (SELECT TB.TB_NUM, TB_TITLE, TB_CNT, TB_DATE, TB_ADDR,";
		sql		  +=  " TB_IMG1, MEM_NICK, COUNT(L.TB_NUM),";
		if(odNum==1){ //추천순
			sql	      +=  " ROW_NUMBER() OVER(ORDER BY COUNT(L.TB_NUM) DESC NULLS LAST) RN";           
		}
		if(odNum==2){ //조회순
			sql	      +=  " ROW_NUMBER() OVER(ORDER BY TB_CNT DESC NULLS LAST) RN";           
		}
		sql       +=  " FROM TRIP_BOARD TB JOIN MEMBER M ON TB.MEM_NUM = M.MEM_NUM";
		sql       +=  " LEFT JOIN TB_LIKE L ON TB.TB_NUM = L.TB_NUM";
		sql		  +=  " GROUP BY TB.TB_NUM, TB_TITLE, TB_CNT, TB_DATE, TB_ADDR, TB_IMG1,  MEM_NICK) T";
		sql	      +=  "	WHERE RN BETWEEN 1 + (10)*(?+?) AND 10 + (10)*(?+?)";
		
		try {
			db     = new DBConn();
			conn   = db.getConnection();
			pstmt  = conn.prepareStatement(sql);
			pstmt.setInt(1, currentPage-1); //첫번째 ?= 세번째 ? :누른 버튼의 번호-1
			pstmt.setInt(2, dpp); //두번째 ?=네번째? :보여줄 자료 수(기본 10개씩 보여주나 -5,+10 으로 조절 가능) 
			pstmt.setInt(3, currentPage-1);
			pstmt.setInt(4, dpp); 
			rs     = pstmt.executeQuery();
			// 작성자 추천수, 메인 이미지
			while( rs.next() ){
				int    tb_num   = rs.getInt(1);    //테이블 번호 
				String tb_title = rs.getString(2); //테이블 제목
				int    tb_cnt   = rs.getInt(3);    // 조회수
				String tb_date  = rs.getString(4); // 작성일
				String tb_addr  = rs.getString(5); // 관광지 주소
				String mainImg  = rs.getString(6); // 메인이미지
				String nickname = rs.getString(7); // 작성자
				int    likeCnt  = rs.getInt(8);    // 추천수
				int    number   = rs.getInt(9);	   // 검색순대로 번호 붙이기 
				
				TBoardVo tVo = new TBoardVo();
				tVo.setTbNum(tb_num);
				tVo.setTitle(tb_title);
				tVo.setReadCnt(tb_cnt);
				tVo.setwDate(tb_date);
				tVo.setAddr(tb_addr);
				tVo.setImg1(mainImg);
				tVo.setNickName(nickname);
				tVo.setLikeCnt(likeCnt);
				tVo.setNumber(number);
				boardList.add(tVo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return boardList;
	}

	// 인덱스 목록 가져오기
			public List<TBoardVo> getMainData() {
				ArrayList<TBoardVo> boardList = new ArrayList<>();
				String sql =  "SELECT *  ";
				sql       +=  " FROM (SELECT TB.TB_NUM, TB_TITLE, TB_CNT, TB_DATE, TB_ADDR,";
				sql		  +=  " TB_IMG1, MEM_NICK, COUNT(L.TB_NUM),";
				sql	      +=  " ROW_NUMBER() OVER(ORDER BY TB.TB_NUM DESC NULLS LAST) RN";           
				sql       +=  " FROM TRIP_BOARD TB JOIN MEMBER M ON TB.MEM_NUM = M.MEM_NUM";
				sql       +=  " LEFT JOIN TB_LIKE L ON TB.TB_NUM = L.TB_NUM";
				sql		  +=  " GROUP BY TB.TB_NUM, TB_TITLE, TB_CNT, TB_DATE, TB_ADDR, TB_IMG1,  MEM_NICK) T";
				sql	      +=  "	WHERE RN BETWEEN 1 AND 5";
				
				try {
					db     = new DBConn();
					conn   = db.getConnection();
					pstmt  = conn.prepareStatement(sql);
					rs     = pstmt.executeQuery();
					// 작성자 추천수, 메인 이미지
					while( rs.next() ){
						int    tb_num   = rs.getInt(1);    //테이블 번호 
						String tb_title = rs.getString(2); //테이블 제목
						int    tb_cnt   = rs.getInt(3);    // 조회수
						String tb_date  = rs.getString(4); // 작성일
						String tb_addr  = rs.getString(5); // 관광지 주소
						String mainImg  = rs.getString(6); // 메인이미지
						String nickname = rs.getString(7); // 작성자
						int    likeCnt  = rs.getInt(8);    // 추천수
						int    number   = rs.getInt(9);	   // 검색순대로 번호 붙이기 
						
						TBoardVo tVo = new TBoardVo();
						tVo.setTbNum(tb_num);
						tVo.setTitle(tb_title);
						tVo.setReadCnt(tb_cnt);
						tVo.setwDate(tb_date);
						tVo.setAddr(tb_addr);
						tVo.setImg1(mainImg);
						tVo.setNickName(nickname);
						tVo.setLikeCnt(likeCnt);
						tVo.setNumber(number);
						boardList.add(tVo);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					close();
				}
				
				return boardList;
			}
	
	
	
	//DB CLOSE
	public void close() {
		try {
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(cstmt!=null)cstmt.close();
			if(conn!=null)conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}






	





}
