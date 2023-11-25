package prj.trip.tboard.vo;


import java.util.ArrayList;
import java.util.Arrays;

import prj.trip.comment.vo.CommentVo;

public class TBoardVo { // nickname
	// Fields
	private int     		  tbNum;    //게시판 번호
	private String  		  addr;   //주소(지역까지라도 좋음)
	private String  		  title;  //제목
	private String  		  nickName;   //닉네임
	private String   		  wDate;      //작성일
	private String  	      cont;   //내용 
	private String  	      cont2;   //내용 
	private String  	      cont3;   //내용 
	private String  	      cont4;   //내용 
	private String  		  img1;		  //이미지1
	private String  		  img2;		  //이미지2
	private String  		  img3;		  //이미지3
	private String  		  img4;		  //이미지4
	private String   		  video;      //비디오
	
	
	private int 			   cmtCnt;       //댓글수
	private int                readCnt;      //조회수
	private int                likeCnt;       //좋아요
	private int                number;		  //검색결과에 붙이는 번호
	// Constructor
	public TBoardVo() {}
	public TBoardVo(int tbNum, String addr, String title, String nickName, String wDate, String cont, String cont2,
			String cont3, String cont4, String img1, String img2, String img3, String img4, String video, int cmtCnt,
			int readCnt, int likeCnt, int number) {
		this.tbNum = tbNum;
		this.addr = addr;
		this.title = title;
		this.nickName = nickName;
		this.wDate = wDate;
		this.cont = cont;
		this.cont2 = cont2;
		this.cont3 = cont3;
		this.cont4 = cont4;
		this.img1 = img1;
		this.img2 = img2;
		this.img3 = img3;
		this.img4 = img4;
		this.video = video;
		this.cmtCnt = cmtCnt;
		this.readCnt = readCnt;
		this.likeCnt = likeCnt;
		this.number = number;
	}
	// Getter/ Setter
	public int getTbNum() {
		return tbNum;
	}
	public void setTbNum(int tbNum) {
		this.tbNum = tbNum;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public String getCont() {
		return cont;
	}
	public void setCont(String cont) {
		this.cont = cont;
	}
	public String getCont2() {
		return cont2;
	}
	public void setCont2(String cont2) {
		this.cont2 = cont2;
	}
	public String getCont3() {
		return cont3;
	}
	public void setCont3(String cont3) {
		this.cont3 = cont3;
	}
	public String getCont4() {
		return cont4;
	}
	public void setCont4(String cont4) {
		this.cont4 = cont4;
	}
	public String getImg1() {
		return img1;
	}
	public void setImg1(String img1) {
		this.img1 = img1;
	}
	public String getImg2() {
		return img2;
	}
	public void setImg2(String img2) {
		this.img2 = img2;
	}
	public String getImg3() {
		return img3;
	}
	public void setImg3(String img3) {
		this.img3 = img3;
	}
	public String getImg4() {
		return img4;
	}
	public void setImg4(String img4) {
		this.img4 = img4;
	}
	public String getVideo() {
		return video;
	}
	public void setVideo(String video) {
		this.video = video;
	}
	public int getCmtCnt() {
		return cmtCnt;
	}
	public void setCmtCnt(int cmtCnt) {
		this.cmtCnt = cmtCnt;
	}
	public int getReadCnt() {
		return readCnt;
	}
	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}
	public int getLikeCnt() {
		return likeCnt;
	}
	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	//toString
	@Override
	public String toString() {
		return "TBoardVo [tbNum=" + tbNum + ", addr=" + addr + ", title=" + title + ", nickName=" + nickName
				+ ", wDate=" + wDate + ", cont=" + cont + ", cont2=" + cont2 + ", cont3=" + cont3 + ", cont4=" + cont4
				+ ", img1=" + img1 + ", img2=" + img2 + ", img3=" + img3 + ", img4=" + img4 + ", video=" + video
				+ ", cmtCnt=" + cmtCnt + ", readCnt=" + readCnt + ", likeCnt=" + likeCnt + ", number=" + number + "]";
	}
	
	
}
