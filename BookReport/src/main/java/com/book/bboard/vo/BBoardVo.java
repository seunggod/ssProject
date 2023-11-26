package com.book.bboard.vo;

public class BBoardVo {
	//Fields
	private int board_num;
	private String board_title;
	private String board_writer;
	private int    board_writer_num;
	private String board_cont;
	private String regdate;
	private int readcount;
	private int likecount;
	private int book_grade;
	
	private String book_title;
	private String book_author;
	private String publisher;
	private String book_date;
	private String book_sort;
	private String book_image;
	
	private int    replycount;
	//Constructor
	public BBoardVo() {}
	public BBoardVo(int board_num, String board_title, String board_writer, int board_writer_num, String board_cont, String regdate,
			int readcount, int likecount, int book_grade, String book_title, String book_author, String publisher,
			String book_date, String book_sort, String book_image,int replycount) {
		super();
		this.board_num = board_num;
		this.board_title = board_title;
		this.board_writer = board_writer;
		this.board_writer_num = board_writer_num;
		this.board_cont = board_cont;
		this.regdate = regdate;
		this.readcount = readcount;
		this.likecount = likecount;
		this.book_grade = book_grade;
		this.book_title = book_title;
		this.book_author = book_author;
		this.publisher = publisher;
		this.book_date = book_date;
		this.book_sort = book_sort;
		this.book_image = book_image;
		this.replycount = replycount;
	}

	//Getter / Setter
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
	public String getBoard_cont() {
		return board_cont;
	}
	public void setBoard_cont(String board_cont) {
		this.board_cont = board_cont;
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
	public int getBook_grade() {
		return book_grade;
	}
	public void setBook_grade(int book_grade) {
		this.book_grade = book_grade;
	}
	public String getBook_title() {
		return book_title;
	}
	public void setBook_title(String book_title) {
		this.book_title = book_title;
	}
	public String getBook_author() {
		return book_author;
	}
	public void setBook_author(String book_author) {
		this.book_author = book_author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getBook_date() {
		return book_date;
	}
	public void setBook_date(String book_date) {
		this.book_date = book_date;
	}
	public String getBook_sort() {
		return book_sort;
	}
	public void setBook_sort(String book_sort) {
		this.book_sort = book_sort;
	}
	public String getBook_image() {
		return book_image;
	}
	public void setBook_image(String book_image) {
		this.book_image = book_image;
	}
	public int getReplycount() {
		return replycount;
	}
	public void setReplycount(int replycount) {
		this.replycount = replycount;
	}
	public int getBoard_writer_num() {
		return board_writer_num;
	}
	public void setBoard_writer_num(int board_writer_num) {
		this.board_writer_num = board_writer_num;
	}
	//toString
	@Override
	public String toString() {
		return "BBoardVo [board_num=" + board_num + ", board_title=" + board_title + ", board_writer=" + board_writer
				+ ", board_writer_num=" + board_writer_num + ", board_cont=" + board_cont + ", regdate=" + regdate
				+ ", readcount=" + readcount + ", likecount=" + likecount + ", book_grade=" + book_grade
				+ ", book_title=" + book_title + ", book_author=" + book_author + ", publisher=" + publisher
				+ ", book_date=" + book_date + ", book_sort=" + book_sort + ", book_image=" + book_image
				+ ", replycount=" + replycount + "]";
	}
}
