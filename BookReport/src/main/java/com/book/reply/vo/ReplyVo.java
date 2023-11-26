package com.book.reply.vo;

public class ReplyVo {
	//field
	private int    reply_num;
	private String reply_writer;
	private int    reply_mem;
	private String reply_cont;
	private String reply_date;
	private String rereply_nick;
	private int    likeCnt;
	private int    likeCheck;
	//Constructor
	public ReplyVo() {}
	public ReplyVo(int reply_num, String reply_writer,int reply_mem, String reply_cont, String reply_date, String rereply_nick, int likeCnt, int likeCheck) {
		super();
		this.reply_num = reply_num;
		this.reply_writer = reply_writer;
		this.reply_mem = reply_mem;
		this.reply_cont = reply_cont;
		this.reply_date = reply_date;
		this.rereply_nick = rereply_nick;
		this.likeCnt = likeCnt;
		this.likeCheck = likeCheck;
	}
	//Getter/ Setter
	public int getReply_num() {
		return reply_num;
	}
	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}
	public String getReply_writer() {
		return reply_writer;
	}
	public void setReply_writer(String reply_writer) {
		this.reply_writer = reply_writer;
	}
	public String getReply_cont() {
		return reply_cont;
	}
	public void setReply_cont(String reply_cont) {
		this.reply_cont = reply_cont;
	}
	public String getReply_date() {
		return reply_date;
	}
	public void setReply_date(String reply_date) {
		this.reply_date = reply_date;
	}
	public String getRereply_nick() {
		return rereply_nick;
	}
	public void setRereply_nick(String rereply_nick) {
		this.rereply_nick = rereply_nick;
	}
	public int getLikeCnt() {
		return likeCnt;
	}
	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}
	public int getLikeCheck() {
		return likeCheck;
	}
	public void setLikeCheck(int likeCheck) {
		this.likeCheck = likeCheck;
	}
	public int getReply_mem() {
		return reply_mem;
	}
	public void setReply_mem(int reply_mem) {
		this.reply_mem = reply_mem;
	}
	//toString
	@Override
	public String toString() {
		return "ReplyVo [reply_num=" + reply_num + ", reply_writer=" + reply_writer + ", reply_mem=" + reply_mem
				+ ", reply_cont=" + reply_cont + ", reply_date=" + reply_date + ", rereply_nick=" + rereply_nick
				+ ", likeCnt=" + likeCnt + ", likeCheck=" + likeCheck + "]";
	}
}
