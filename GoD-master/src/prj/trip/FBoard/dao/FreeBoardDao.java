package prj.trip.FBoard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import prj.trip.FBoard.Vo.FBCommentVo;
import prj.trip.FBoard.Vo.FreeBoardVo;
import prj.trip.db.DBConn;

public class FreeBoardDao {
	
	private Connection conn;
	private PreparedStatement pstmt;
	
	

//밑으로 자유게시판 (임시)

public List<FreeBoardVo> getFreeBoardList(int startNum, int endNum){
	
	ResultSet rs = null;
	List<FreeBoardVo> FreeBoardList = new ArrayList<FreeBoardVo>();
	
	try {
		DBConn db = new DBConn();
		conn = db.getConnection();
		 String sql =" SELECT AA.FB_NUM, AA.FB_TITLE, M.MEM_NICK , AA.FB_DATE, AA.FB_CNT , NVL((SELECT COUNT(*) OVER   FROM FB_LIKE WHERE FB_NUM= ? ),0)AS LIKECNT "
		 		+ " FROM ( SELECT ROWNUM AS RNUM, Z.* FROM ( SELECT * from FREE_BOARD A  order by A.FB_NUM asc ) Z WHERE ROWNUM <= ? ) AA , MEMBER M "
		 		+ " WHERE RNUM >= ? "
		 		+ " AND M.MEM_NUM = AA.MEM_NUM "
		 		+ " order by FB_NUM asc "; 
				
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, startNum);
		pstmt.setInt(2, endNum);
		
		rs = pstmt.executeQuery();
		
		while( rs.next() ) {
			String num = rs.getString(1);	
			String title = rs.getString(2);	
			String nick = rs.getString(3);	
			String date = rs.getString(4);	
			String cnt = rs.getString(5);	
			String likecnt = rs.getString(6);	
			
			FreeBoardVo fbvo = new FreeBoardVo(num, title, nick, date, cnt, likecnt);
			
			FreeBoardList.add(fbvo);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}finally {
		try {
			if(rs    != null )  rs.close();
			if(pstmt != null )  pstmt.close();
			if(conn  != null )  conn.close();
		} catch (SQLException e) {
		}
	}
	
	return FreeBoardList;
	
}

public int getCount(){
	ResultSet rs = null;
	int count = 0;
	String sql = "select count(*) from FREE_BOARD";
	try {
		DBConn db = new DBConn();
		conn = db.getConnection();
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()){
			count = rs.getInt(1);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs    != null )  rs.close();
			if(pstmt != null )  pstmt.close();
			if(conn  != null )  conn.close();
		} catch (SQLException e) {
		}
	}
	return count; // 총 레코드 수 리턴
}

//댓글 페이징@@@@@@@@@@@@@@@@@@@@@@@
public List<FreeBoardVo> getFBRipleList(int startNum, int endNum){
	
	ResultSet rs = null;
	List<FreeBoardVo> FreeBoardList = new ArrayList<FreeBoardVo>();
	
	try {
		DBConn db = new DBConn();
		conn = db.getConnection();
		String sql =" SELECT AA.FB_NUM, AA.FB_TITLE, M.MEM_NICK , AA.FB_DATE, AA.FB_CNT , NVL((SELECT COUNT(*) OVER   FROM FB_LIKE WHERE FB_NUM= ? ),0)AS LIKECNT "
				+ " FROM ( SELECT ROWNUM AS RNUM, Z.* FROM ( SELECT * from FREE_BOARD A  order by A.FB_NUM asc ) Z WHERE ROWNUM <= ? ) AA , MEMBER M "
				+ " WHERE RNUM >= ? "
				+ " AND M.MEM_NUM = AA.MEM_NUM "
				+ " order by FB_NUM asc "; 
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, startNum);
		pstmt.setInt(2, endNum);
		
		rs = pstmt.executeQuery();
		
		while( rs.next() ) {
			String num = rs.getString(1);	
			String title = rs.getString(2);	
			String nick = rs.getString(3);	
			String date = rs.getString(4);	
			String cnt = rs.getString(5);	
			String likecnt = rs.getString(6);	
			
			FreeBoardVo fbvo = new FreeBoardVo(num, title, nick, date, cnt, likecnt);
			
			FreeBoardList.add(fbvo);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}finally {
		try {
			if(rs    != null )  rs.close();
			if(pstmt != null )  pstmt.close();
			if(conn  != null )  conn.close();
		} catch (SQLException e) {
		}
	}
	
	return FreeBoardList;
	
}

public int getFBRipleCount(){
	ResultSet rs = null;
	int count = 0;
	String sql = "select count(*) from FREE_BOARD";
	try {
		DBConn db = new DBConn();
		conn = db.getConnection();
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()){
			count = rs.getInt(1);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs    != null )  rs.close();
			if(pstmt != null )  pstmt.close();
			if(conn  != null )  conn.close();
		} catch (SQLException e) {
		}
	}
	return count; // 총 레코드 수 리턴
}


//제목으로 검색
public List<FreeBoardVo> getFBoardtitleSearch(int startNum, int endNum, String keyword){
	
	ResultSet rs = null;
	List<FreeBoardVo> FreeBoardList = new ArrayList<FreeBoardVo>();
	
	try {
		DBConn db = new DBConn();
		conn = db.getConnection();
		String sql =" SELECT AA.FB_NUM, AA.FB_TITLE, M.MEM_NICK , AA.FB_DATE, AA.FB_CNT , NVL((SELECT COUNT(*) OVER   FROM FB_LIKE f WHERE f.FB_NUM= AA.FB_NUM ),0)AS LIKECNT  "
				+ " FROM ( SELECT ROWNUM AS RNUM, Z.* FROM ( SELECT AF.FB_NUM, AF.FB_TITLE, MF.MEM_NICK, AF.FB_DATE, AF.FB_CNT, MF.MEM_NUM "
				+ " FROM FREE_BOARD AF, MEMBER MF WHERE  MF.MEM_NUM = AF.MEM_NUM  AND AF.FB_TITLE LIKE ?  ORDER BY AF.FB_NUM ASC ) Z  WHERE ROWNUM <= ? ) AA , MEMBER M "
				+ " WHERE RNUM >= ? "
				+ " AND  M.MEM_NUM = AA.MEM_NUM "
				+ " order by FB_NUM asc "; 
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1,"%" + keyword + "%");
		pstmt.setInt(2,startNum);
		pstmt.setInt(3, endNum);
		rs = pstmt.executeQuery();
		
		while( rs.next() ) {
			String num = rs.getString(1);	
			String title = rs.getString(2);	
			String nick = rs.getString(3);	
			String date = rs.getString(4);	
			String cnt = rs.getString(5);	
			String likecnt = rs.getString(6);	
			
			FreeBoardVo fbvo = new FreeBoardVo(num, title, nick, date, cnt, likecnt);
			
			FreeBoardList.add(fbvo);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}finally {
		try {
			if(rs    != null )  rs.close();
			if(pstmt != null )  pstmt.close();
			if(conn  != null )  conn.close();
		} catch (SQLException e) {
		}
	}
	
	return FreeBoardList;
	
}

public int getFBtitleSearchCount(String keyword){
	ResultSet rs = null;
	int count = 0;
	String sql = "select count(*) from FREE_BOARD F, MEMBER M WHERE F.MEM_NUM = M.MEM_NUM AND FB_TITLE LIKE ? ";
	try {
		DBConn db = new DBConn();
		conn = db.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,"%" + keyword + "%");
		rs = pstmt.executeQuery();
		if(rs.next()){
			count = rs.getInt(1);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs    != null )  rs.close();
			if(pstmt != null )  pstmt.close();
			if(conn  != null )  conn.close();
		} catch (SQLException e) {
		}
	}
	return count; // 총 레코드 수 리턴
}
//////////////////////////////////
//닉네임으로 검색
public List<FreeBoardVo> getFBoardNickSearch(int startNum, int endNum, String keyword){
	
	ResultSet rs = null;
	List<FreeBoardVo> FreeBoardList = new ArrayList<FreeBoardVo>();
	
	try {
		DBConn db = new DBConn();
		conn = db.getConnection();
		String sql =" SELECT AA.FB_NUM, AA.FB_TITLE, M.MEM_NICK , AA.FB_DATE, AA.FB_CNT , NVL((SELECT COUNT(*) OVER   FROM FB_LIKE f WHERE f.FB_NUM= AA.FB_NUM ),0)AS LIKECNT "
				+ " FROM ( SELECT ROWNUM AS RNUM, Z.* FROM ( SELECT AF.FB_NUM, AF.FB_TITLE, MF.MEM_NICK, AF.FB_DATE, AF.FB_CNT, MF.MEM_NUM "
				+ " FROM FREE_BOARD AF, MEMBER MF WHERE  MF.MEM_NUM = AF.MEM_NUM  AND MF.MEM_NICK LIKE ?  ORDER BY AF.FB_NUM ASC ) Z  WHERE ROWNUM <= ? ) AA , MEMBER M "
				+ " WHERE RNUM >= ? "
				+ " AND  M.MEM_NUM = AA.MEM_NUM "
				+ " order by FB_NUM asc "; 
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1,"%" + keyword + "%");
		pstmt.setInt(2,startNum);
		pstmt.setInt(3, endNum);
		rs = pstmt.executeQuery();
		
		while( rs.next() ) {
			String num = rs.getString(1);	
			String title = rs.getString(2);	
			String nick = rs.getString(3);	
			String date = rs.getString(4);	
			String cnt = rs.getString(5);	
			String likecnt = rs.getString(6);	
			
			FreeBoardVo fbvo = new FreeBoardVo(num, title, nick, date, cnt, likecnt);
			
			FreeBoardList.add(fbvo);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}finally {
		try {
			if(rs    != null )  rs.close();
			if(pstmt != null )  pstmt.close();
			if(conn  != null )  conn.close();
		} catch (SQLException e) {
		}
	}
	
	return FreeBoardList;
	
}

public int getFBNickSearchCount(String keyword){
	ResultSet rs = null;
	int count = 0;
	String sql = "select count(*) from FREE_BOARD F, MEMBER M WHERE F.MEM_NUM = M.MEM_NUM AND MEM_NICK LIKE ? ";
	try {
		DBConn db = new DBConn();
		conn = db.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,"%" + keyword + "%");
		rs = pstmt.executeQuery();
		if(rs.next()){
			count = rs.getInt(1);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs    != null )  rs.close();
			if(pstmt != null )  pstmt.close();
			if(conn  != null )  conn.close();
		} catch (SQLException e) {
		}
	}
	return count; // 총 레코드 수 리턴
}
//////////////////////////////////

//테이블에 저장할 회원번호를 가져오기
public int getMemNum(String loginId) {
	ResultSet rs=null;
   int memNum = 0;
   String sql = "SELECT MEM_NUM FROM MEMBER WHERE MEM_ID = ? ";
   
   try {
      DBConn db         = new DBConn();
      conn       = db.getConnection();
      pstmt      = conn.prepareStatement(sql);
      pstmt.setString(1, loginId);
      rs = pstmt.executeQuery();
      
      if(rs.next()){
         memNum = rs.getInt("MEM_NUM");
      }
   } catch (SQLException e) {
      e.printStackTrace();
   } finally {
      try {
    	  if(rs!=null)rs.close();
    	  if(pstmt!=null)pstmt.close();
    	  if(conn!=null)conn.close();
   } catch (SQLException e) {
      e.printStackTrace();
   }
   }
         return memNum;
}
public String getMemNumm(String loginId) {
	ResultSet rs=null;
	String memNum = "";
	String sql = "SELECT MEM_NUM FROM MEMBER WHERE MEM_ID = ? ";
	
	try {
		DBConn db         = new DBConn();
		conn       = db.getConnection();
		pstmt      = conn.prepareStatement(sql);
		pstmt.setString(1, loginId);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			memNum = rs.getString("MEM_NUM");
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	return memNum;
}

//게시물 클릭시 제목내용 불러오기
public FreeBoardVo getFBoard(String fbnum) {
	ResultSet rs=null;
	FreeBoardVo fbv = new FreeBoardVo();
	String sql = "SELECT FB_NUM, FB_TITLE, FB_CONT, FB_CNT, FB_DATE,(SELECT MM.MEM_NICK FROM FREE_BOARD FBB , MEMBER MM WHERE FBB.FB_NUM = ? AND MM.MEM_NUM = FBB.MEM_NUM)AS NICK , "
			+ "NVL((SELECT COUNT(*) OVER   FROM FB_LIKE WHERE FB_NUM= ? ),0)AS LIKECNT, "
			+ "(SELECT MEM_NICK FROM MEMBER M , FREE_BOARD FBC WHERE  M.MEM_NUM = FBC.MEM_NUM AND FBC.fb_num = ?)AS NICK "
			+ "FROM FREE_BOARD WHERE FB_NUM = ? ";
 
 try {
    DBConn db         = new DBConn();
    conn       = db.getConnection();
    pstmt      = conn.prepareStatement(sql);
    pstmt.setString(1, fbnum);
    pstmt.setString(2, fbnum);
    pstmt.setString(3, fbnum);
    pstmt.setString(4, fbnum);
    rs = pstmt.executeQuery();
    
    if(rs.next()){
       String fbn = rs.getString("FB_NUM");
       String title = rs.getString("FB_TITLE");
       String cont = rs.getString("FB_CONT");
       String cnt = rs.getString("FB_CNT");
       String date = rs.getString("FB_DATE");
       String like = rs.getString("LIKECNT");
       String nick = rs.getString("NICK");
       
       fbv = new FreeBoardVo(fbn, title, date, cnt, cont, like, nick);
    }
 } catch (SQLException e) {
    e.printStackTrace();
 } finally {
    try {
  	  if(rs!=null)rs.close();
  	  if(pstmt!=null)pstmt.close();
  	  if(conn!=null)conn.close();
 } catch (SQLException e) {
    e.printStackTrace();
 }
 }
       return fbv;
}

public String getNick(String id) {  //닉네임 가져오기
	
	ResultSet      rs         = null;
	
	try {
		DBConn    db   =  new DBConn();
		conn           =  db.getConnection();
		String    sql  =  " SELECT  MEM_NICK";
		sql += " FROM   MEMBER ";
		sql += " WHERE  MEM_id =  ? ";
		pstmt          =  conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		rs       =  pstmt.executeQuery();
		if( rs.next() ) {
			return rs.getString("MEM_NICK");
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs    != null )  rs.close();
			if(pstmt != null )  pstmt.close();
			if(conn  != null )  conn.close();
		} catch (SQLException e) {
		}
	}
	
	return   "아이디없음";
}

public void CntUpdate(String fbnum) {
	DBConn db = new DBConn();
	conn = db.getConnection();
	String sql=" UPDATE FREE_BOARD SET FB_CNT = FB_CNT+1 WHERE FB_NUM = ? ";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, fbnum);
		
		pstmt.executeUpdate();
		conn.commit();
		
	} catch (SQLException e) {
		e.printStackTrace();
	}finally {
	    try {
	    	  if(pstmt!=null)pstmt.close();
	    	  if(conn!=null)conn.close();
	   } catch (SQLException e) {
	      e.printStackTrace();
	   }
	   }
}

public void FBUpdate(String title,String cont,String fbnum) {
	DBConn db = new DBConn();
	conn = db.getConnection();
	String sql = "UPDATE FREE_BOARD SET FB_TITLE = ? ,FB_CONT = ? WHERE FB_NUM = ? ";
	
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, cont);
		pstmt.setString(3, fbnum);
		
		pstmt.executeUpdate();
		conn.commit();
	} catch (SQLException e) {
		e.printStackTrace();
	}
}

public int InsertFBboard(String title, String cont, int memnum) {
	ResultSet rs = null;
	String sql ="INSERT INTO free_board ( fb_num, fb_title, fb_cont, fb_cnt, mem_num)"
			+ " VALUES ( (SELECT NVL( MAX(fb_num),0 )+1 FROM free_board), ?, ? , 0, ? )";
			
	DBConn db = new DBConn();
	conn =  db.getConnection();
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, cont);
		pstmt.setInt(3, memnum);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			conn.commit();
			return 1;
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
	
	return 0;
	
}

public List<FBCommentVo> getFBCommentList(String fnum,int end, int start){
	
	ResultSet rs = null;
	List<FBCommentVo> FBCommentList = new ArrayList<FBCommentVo>();
	
	try {
		DBConn db = new DBConn();
		conn = db.getConnection();
		 String sql = " SELECT FBC_NUM, FBC_CONT, FBC_DATE, AA.MEM_NUM, FB_NUM, MEM_NICK  "
		 		+ " FROM ( SELECT ROWNUM AS RNUM, Z.* FROM ( SELECT * from FB_COMMENT A  order by A.FBC_NUM DESC ) Z WHERE ROWNUM <= ? AND FB_NUM = ? ) AA,MEMBER M  "
		 		+ " WHERE RNUM >= ?  "
		 		+ " AND M.MEM_NUM = AA.MEM_NUM order by FBC_DATE desc ";
				
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, end);
		pstmt.setString(2, fnum);
		pstmt.setInt(3, start);
		
		
		rs = pstmt.executeQuery();
		
		while( rs.next() ) {
			String num = rs.getString("FBC_NUM");	
			String cont = rs.getString("FBC_CONT");	
			String date = rs.getString("FBC_DATE");	
			String mnum = rs.getString("MEM_NUM");	
			String fbnum = rs.getString("FB_NUM");	
			String nick = rs.getString("MEM_NICK");	
			
			FBCommentVo fbcvo = new FBCommentVo(num, cont, date, mnum, fbnum, nick);
			
			FBCommentList.add(fbcvo);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}finally {
		try {
			if(rs    != null )  rs.close();
			if(pstmt != null )  pstmt.close();
			if(conn  != null )  conn.close();
		} catch (SQLException e) {
		}
	}
	
	return FBCommentList;
	
}

public void InsertFBC(String fnum,String memnum, String cont) {
	ResultSet rs = null;
	String sql =" INSERT INTO FB_COMMENT (FBC_NUM, FBC_CONT, MEM_NUM, FB_NUM )  "
			+ " VALUES ( (SELECT NVL( MAX(FBC_NUM),0 )+1 FROM FB_COMMENT), ?, ?, ? )  ";
			
	DBConn db = new DBConn();
	conn =  db.getConnection();
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, cont);
		pstmt.setString(2, memnum);
		pstmt.setString(3, fnum);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			conn.commit();
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
}


public void InsertFBLike(String fbnum,String memnum) {
	ResultSet rs = null;
	String sql =" INSERT INTO FB_LIKE ( FBL_NUM, MEM_NUM, FB_NUM ) "
			+ " VALUES ( (SELECT NVL( MAX(FBL_NUM),0 )+1 FROM FB_LIKE) , ?, ? ) ";
	
	DBConn db = new DBConn();
	conn =  db.getConnection();
	try {
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, memnum);
		pstmt.setString(2, fbnum);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			
			conn.commit();
			System.out.println("추천 올라감");
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
}

public int InFBLike(String fbnum,String memnum) {
	ResultSet rs = null;
	String sql =" SELECT FBL_NUM, FBL_DATE, MEM_NUM, FB_NUM FROM FB_LIKE WHERE MEM_NUM = ? AND FB_NUM = ? ";
	int a = 0;
	DBConn db = new DBConn();
	conn =  db.getConnection();
	try {
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, memnum);
		pstmt.setString(2, fbnum);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			a = 1;
			
			System.out.println("추천수 제한");
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	return a;
}

public int getTotalTB(){
	ResultSet rs = null;
	int count = 0;
	String sql = " select NVL( MAX(FB_NUM),0 )FBNUM from FREE_BOARD ";
	try {
		DBConn db = new DBConn();
		conn = db.getConnection();
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()){
			count = rs.getInt(1);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs    != null )  rs.close();
			if(pstmt != null )  pstmt.close();
			if(conn  != null )  conn.close();
		} catch (SQLException e) {
		}
	}
	return count; // 총 레코드 수 리턴
}
public int getTBCTotal(String fnum){
	ResultSet rs = null;
	int count = 0;
	String sql = " select COUNT(*) FBCNUM from FB_COMMENT WHERE FB_NUM = ?  "
			+ " ";
	try {
		DBConn db = new DBConn();
		conn = db.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, fnum);		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			count = rs.getInt(1);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs    != null )  rs.close();
			if(pstmt != null )  pstmt.close();
			if(conn  != null )  conn.close();
		} catch (SQLException e) {
		}
	}
	return count; // 총 레코드 수 리턴
}

public void FBCDelete(String fbcnum) {
	int rs = 0;
	String sql=" DELETE FROM FB_COMMENT  WHERE FBC_NUM = ? ";
	
	DBConn db = new DBConn();
	conn = db.getConnection();
	
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, fbcnum);
		
		pstmt.executeUpdate();
		conn.commit();
		
		System.out.println("댓글삭제완료");
		
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if(pstmt != null )  pstmt.close();
			if(conn  != null )  conn.close();
		} catch (SQLException e) {
		}
	}
	
	
}

public void RipleUpdate(String fbnum,String cont) {
	DBConn db = new DBConn();
	conn = db.getConnection();
	String sql=" UPDATE FB_COMMENT SET FBC_CONT = ? WHERE FBC_NUM = ? ";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, cont);
		pstmt.setString(2, fbnum);
		
		int r = pstmt.executeUpdate();
		conn.commit();
		System.out.println("업데이트 된 수"+r);
	} catch (SQLException e) {
		e.printStackTrace();
	}finally {
	    try {
	    	  if(pstmt!=null)pstmt.close();
	    	  if(conn!=null)conn.close();
	   } catch (SQLException e) {
	      e.printStackTrace();
	   }
	   }
}




}
