package com.book.fboard.vo;

public class FBoardVo {
	//Fields
	private int    board_num;
	private String board_title;
	private String board_writer;
	private String board_writer_num;
	private String board_cont;
	private String board_image;
	private String regdate;
	private int    readcount;
	private int    likecount;
	private int    replycount;
	//Constructor
	public FBoardVo() {}
	public FBoardVo(int board_num, String board_title, String board_writer, String board_writer_num, String board_cont,
			String board_image, String regdate, int readcount, int likecount, int replycount) {
		super();
		this.board_num = board_num;
		this.board_title = board_title;
		this.board_writer = board_writer;
		this.board_writer_num = board_writer_num;
		this.board_cont = board_cont;
		this.board_image = board_image;
		this.regdate = regdate;
		this.readcount = readcount;
		this.likecount = likecount;
		this.replycount = replycount;
	}
	//Getter/Setter
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_writer() {
		return board_writer;
	}
	public void setBoard_writer(String board_writer) {
		this.board_writer = board_writer;
	}
	public String getBoard_writer_num() {
		return board_writer_num;
	}
	public void setBoard_writer_num(String board_writer_num) {
		this.board_writer_num = board_writer_num;
	}
	public String getBoard_cont() {
		return board_cont;
	}
	public void setBoard_cont(String board_cont) {
		this.board_cont = board_cont;
	}
	public String getBoard_image() {
		return board_image;
	}
	public void setBoard_image(String board_image) {
		this.board_image = board_image;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getLikecount() {
		return likecount;
	}
	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}
	public int getReplycount() {
		return replycount;
	}
	public void setReplycount(int replycount) {
		this.replycount = replycount;
	}
	//toString
	@Override
	public String toString() {
		return "FBoardVo [board_num=" + board_num + ", board_title=" + board_title + ", board_writer=" + board_writer
				+ ", board_writer_num=" + board_writer_num + ", board_cont=" + board_cont + ", board_image="
				+ board_image + ", regdate=" + regdate + ", readcount=" + readcount + ", likecount=" + likecount
				+ ", replycount=" + replycount + "]";
	}
	
	
}
