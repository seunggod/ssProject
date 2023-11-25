package prj.trip.FBoard.Vo;

public class FreeBoardVo {
	private String num;
	private String title;
	private String nick;
	private String date;
	private String cnt;
	private String cont;
	private String likecnt;
	private int fbc;
	public FreeBoardVo() {
		super();
		
	}
	
	
	
	public FreeBoardVo(String num, String title, String nick, String date, String cnt, String likecnt, int fbc) {
		super();
		this.num = num;
		this.title = title;
		this.nick = nick;
		this.date = date;
		this.cnt = cnt;
		this.likecnt = likecnt;
		this.fbc = fbc;
	}



	public FreeBoardVo(String num, String title, String nick, String date, String cnt, String cont, String likecnt,
			int fbc) {
		super();
		this.num = num;
		this.title = title;
		this.nick = nick;
		this.date = date;
		this.cnt = cnt;
		this.cont = cont;
		this.likecnt = likecnt;
		this.fbc = fbc;
	}



	public FreeBoardVo(String num, String title, String date, String cnt, String cont, String likecnt, String nick) {
		super();
		this.num = num;
		this.title = title;
		this.date = date;
		this.cnt = cnt;
		this.cont = cont;
		this.likecnt = likecnt;
		this.nick = nick;
	}



	public FreeBoardVo(String num, String title, String nick, String date, String cnt, String likecnt) {
		super();
		this.num = num;
		this.title = title;
		this.nick = nick;
		this.date = date;
		this.cnt = cnt;
		this.likecnt = likecnt;
	}
	
	public String getCont() {
		return cont;
	}



	public void setCont(String cont) {
		this.cont = cont;
	}



	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getLikecnt() {
		return likecnt;
	}
	public void setLikecnt(String likecnt) {
		this.likecnt = likecnt;
	}
	
	public int getFbc() {
		return fbc;
	}
	public void setFbc(int fbc) {
		this.fbc = fbc;
	}

	@Override
	public String toString() {
		return "FreeBoardVo [num=" + num + ", title=" + title + ", nick=" + nick + ", date=" + date + ", cnt=" + cnt
				+ ", cont=" + cont + ", likecnt=" + likecnt + ", fbc=" + fbc + "]";
	}

	
}
