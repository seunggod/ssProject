package prj.trip.FBoard.Vo;

public class FBCommentVo {
	private String tbc_num;
	private String tbc_cont;
	private String tbc_date;
	private String mem_num;
	private String tb_num;
	private String nick;
	
	public FBCommentVo(String tbc_num, String tbc_cont, String tbc_date, String mem_num, String tb_num, String nick) {
		super();
		this.tbc_num = tbc_num;
		this.tbc_cont = tbc_cont;
		this.tbc_date = tbc_date;
		this.mem_num = mem_num;
		this.tb_num = tb_num;
		this.nick = nick;
	}
	public String getTbc_num() {
		return tbc_num;
	}
	public void setTbc_num(String tbc_num) {
		this.tbc_num = tbc_num;
	}
	public String getTbc_cont() {
		return tbc_cont;
	}
	public void setTbc_cont(String tbc_cont) {
		this.tbc_cont = tbc_cont;
	}
	public String getTbc_date() {
		return tbc_date;
	}
	public void setTbc_date(String tbc_date) {
		this.tbc_date = tbc_date;
	}
	public String getMem_num() {
		return mem_num;
	}
	public void setMem_num(String mem_num) {
		this.mem_num = mem_num;
	}
	public String getTb_num() {
		return tb_num;
	}
	public void setTb_num(String tb_num) {
		this.tb_num = tb_num;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	@Override
	public String toString() {
		return "FBCommentVo [tbc_num=" + tbc_num + ", tbc_cont=" + tbc_cont + ", tbc_date=" + tbc_date + ", mem_num="
				+ mem_num + ", tb_num=" + tb_num + ", nick=" + nick + "]";
	}
	
	
}
