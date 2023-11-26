package com.book.notice.vo;

public class NoticeVo {
	//fields
	private int    notice_num;
	private String notice_title;
	private String notice_writer;
	private int    notice_writer_num;
	private String notice_cont;
	private String notice_image;
	private String regdate;
	private int    readcount;
	private int    likecount;
	private int    replycount;
	
	//Constructor
	public NoticeVo() {}
	public NoticeVo(int notice_num, String notice_title, String notice_writer, int notice_writer_num,
			String notice_cont, String notice_image, String regdate, int readcount, int likecount, int replycount) {
		super();
		this.notice_num = notice_num;
		this.notice_title = notice_title;
		this.notice_writer = notice_writer;
		this.notice_writer_num = notice_writer_num;
		this.notice_cont = notice_cont;
		this.notice_image = notice_image;
		this.regdate = regdate;
		this.readcount = readcount;
		this.likecount = likecount;
		this.replycount = replycount;
	}
	
	//Getter / Setter
	public int getNotice_num() {
		return notice_num;
	}
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_writer() {
		return notice_writer;
	}
	public void setNotice_writer(String notice_writer) {
		this.notice_writer = notice_writer;
	}
	public int getNotice_writer_num() {
		return notice_writer_num;
	}
	public void setNotice_writer_num(int notice_writer_num) {
		this.notice_writer_num = notice_writer_num;
	}
	public String getNotice_cont() {
		return notice_cont;
	}
	public void setNotice_cont(String notice_cont) {
		this.notice_cont = notice_cont;
	}
	public String getNotice_image() {
		return notice_image;
	}
	public void setNotice_image(String notice_image) {
		this.notice_image = notice_image;
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
		return "NoticeVo [notice_num=" + notice_num + ", notice_title=" + notice_title + ", notice_writer="
				+ notice_writer + ", notice_writer_num=" + notice_writer_num + ", notice_cont=" + notice_cont
				+ ", notice_image=" + notice_image + ", regdate=" + regdate + ", readcount=" + readcount
				+ ", likecount=" + likecount + ", replycount=" + replycount + "]";
	}

}
