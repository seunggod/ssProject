package com.book.book.vo;

public class BookVo {
	//fields
	private int book_num;
	private String book_title;
	private String book_author;
	private String book_sort;
	private String book_date;
	private String publisher;
	private String book_image;
	//Constructor
	public BookVo(int book_num, String book_title, String book_author, String book_sort, String book_date, String publisher,
			String book_image) {
		super();
		this.book_num = book_num;
		this.book_title = book_title;
		this.book_author = book_author;
		this.book_sort = book_sort;
		this.book_date = book_date;
		this.publisher = publisher;
		this.book_image = book_image;
	}
	//Getter/ Setter
	public int getBook_num() {
		return book_num;
	}
	public void setBook_num(int book_num) {
		this.book_num = book_num;
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
	public String getBook_sort() {
		return book_sort;
	}
	public void setBook_sort(String book_sort) {
		this.book_sort = book_sort;
	}
	public String getBook_date() {
		return book_date;
	}
	public void setBook_date(String date) {
		this.book_date = date;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getBook_image() {
		return book_image;
	}
	public void setBook_image(String book_image) {
		this.book_image = book_image;
	}
	//toString
	@Override
	public String toString() {
		return "BookVo [book_num=" + book_num + ", book_title=" + book_title + ", book_author=" + book_author
				+ ", book_sort=" + book_sort + ", date=" + book_date + ", publisher=" + publisher + ", book_image="
				+ book_image + "]";
	}
}
