package prj.trip.nboard.vo;

public class NBoardVo {

//Fields
	int nb_num;
	int nb_like; // 좋아요 갯수
	int mem_num;
	int nb_cnt;


	String mem_nick;
	String nb_title;
	String nb_cont;
	String nb_date;
	String nb_img;
	String nb_video;

//Constructor
	public NBoardVo() {
	}
	
	public NBoardVo(int nb_num, int nb_like, int mem_num, int nb_cnt, String mem_nick, String nb_title, String nb_cont,
		String nb_date, String nb_img, String nb_video) {

	this.nb_num = nb_num;
	this.nb_like = nb_like;
	this.mem_num = mem_num;
	this.nb_cnt = nb_cnt;
	this.mem_nick = mem_nick;
	this.nb_title = nb_title;
	this.nb_cont = nb_cont;
	this.nb_date = nb_date;
	this.nb_img = nb_img;
	this.nb_video = nb_video;
}


	public NBoardVo(String nick, String cont, String title) {
		this.mem_nick = nick;
		this.nb_title = title;
		this.nb_cont = cont;

	}


	//dao.getnBoardList
	public NBoardVo(int nb_num, String nb_title, String mem_nick, int nb_cnt, String nb_date) {
		this.nb_num = nb_num;
		this.nb_cnt = nb_cnt;
		this.nb_title = nb_title;
		this.nb_date = nb_date;
		this.mem_nick = mem_nick;
	}


	//getboardView
	public NBoardVo(String nb_title, String mem_nick, int nb_cnt, String nb_date, String nb_cont,int nb_num) {
		this.nb_cont = nb_cont;
		this.nb_cnt = nb_cnt;
		this.nb_title = nb_title;
		this.nb_date = nb_date;
		this.mem_nick = mem_nick;
		this.nb_num = nb_num;
	}



//Insert
	public NBoardVo(String mem_nick, String nb_cont, String nb_title, int mem_num) {
		this.nb_cont = nb_cont;
		this.mem_nick = mem_nick;
		this.nb_title = nb_title;
		this.mem_num = mem_num;
	}

//Getter / Setter




	public int getNb_cnt() {
		return nb_cnt;
	}
	public void setNb_cnt(int nb_cnt) {
		this.nb_cnt = nb_cnt;
	}
	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}



	public String getMem_nick() {
		return mem_nick;
	}



	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}

	public int getNb_num() {
		return nb_num;
	}

	public void setNb_num(int nb_num) {
		this.nb_num = nb_num;
	}

	public String getMem_name() {
		return mem_nick;
	}

	public void setMem_num(String mem_nick) {
		this.mem_nick = mem_nick;
	}

	public int getNb_like() {
		return nb_like;
	}

	public void setNb_like(int nb_like) {
		this.nb_like = nb_like;
	}

	public String getNb_title() {
		return nb_title;
	}

	public void setNb_title(String nb_title) {
		this.nb_title = nb_title;
	}

	public String getNb_cont() {
		return nb_cont;
	}

	public void setNb_cont(String nb_cont) {
		this.nb_cont = nb_cont;
	}

	public String getNb_date() {
		return nb_date;
	}

	public void setNb_date(String nb_date) {
		this.nb_date = nb_date;
	}

	public String getNb_img() {
		return nb_img;
	}

	public void setNb_img(String nb_img) {
		this.nb_img = nb_img;
	}

	public String getNb_video() {
		return nb_video;
	}

	public void setNb_video(String nb_video) {
		this.nb_video = nb_video;
	}

//toString
	@Override
	public String toString() {
		return "nboardVo [nb_num=" + nb_num + ", mem_nick=" + mem_nick + ", nb_title=" + nb_title + ", nb_cont=" + nb_cont
				+ ", nb_date=" + nb_date + ", nb_img=" + nb_img + ", nb_video=" + nb_video + "]";
	}

}
