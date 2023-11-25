package prj.trip.comment.vo;

public class CommentVo {
	// Fields
	private int    cmtNum;	//댓글번호
	private String cmtCont;	//댓글내용
	private String cmtWriter; //댓글작성자
	private String cmtdate;   //댓글날짜
	private int    boardNum;    //게시판번호
	// Constructor
	public CommentVo() {}
	public CommentVo(int cmtNum, String cmtCont, String cmtWriter, String cmtdate, int boardNum) {
		this.cmtNum = cmtNum;
		this.cmtCont = cmtCont;
		this.cmtWriter = cmtWriter;
		this.cmtdate = cmtdate;
		this.boardNum = boardNum;
	}
	// Getter / Setter
	public int getCmtNum() {
		return cmtNum;
	}
	public void setCmtNum(int cmtNum) {
		this.cmtNum = cmtNum;
	}
	public String getCmtCont() {
		return cmtCont;
	}
	public void setCmtCont(String cmtCont) {
		this.cmtCont = cmtCont;
	}
	public String getCmtWriter() {
		return cmtWriter;
	}
	public void setCmtWriter(String cmtWriter) {
		this.cmtWriter = cmtWriter;
	}
	public String getCmtdate() {
		return cmtdate;
	}
	public void setCmtdate(String cmtdate) {
		this.cmtdate = cmtdate;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	// toString
	@Override
	public String toString() {
		return "CommentVo [cmtNum=" + cmtNum + ", cmtCont=" + cmtCont + ", cmtWriter=" + cmtWriter + ", cmtdate="
				+ cmtdate + ", boardNum=" + boardNum + "]";
	}
	
}
