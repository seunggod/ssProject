package prj.trip.member.vo;


public class MemberVo{
	
	//Fields
	int mem_num; // 고유번호
	int mem_level; // 900 이상 매니저 임명
	String mem_name;
	String mem_id;
	String mem_pwd;
	String mem_gender;
	String mem_addr;
	String mem_tel;
	String mem_birth;
	String mem_nick; // 닉네임
	String mem_email;
	
	
	//Constructor
	public MemberVo(){}

	public MemberVo(int mem_num, int mem_level, String mem_name, String mem_id, String mem_pwd, String mem_gender,
			String mem_addr, String mem_tel, String mem_birth, String mem_nick, String mem_email) {
		
		this.mem_num = mem_num;
		this.mem_level = mem_level;
		this.mem_name = mem_name;
		this.mem_id = mem_id;
		this.mem_pwd = mem_pwd;
		this.mem_gender = mem_gender;
		this.mem_addr = mem_addr;
		this.mem_tel = mem_tel;
		this.mem_birth = mem_birth;
		this.mem_nick = mem_nick;
		this.mem_email = mem_email;
	}

	
	//InsertUser Vo
	public MemberVo(String mem_id, String mem_pwd, String mem_name, String mem_email, String mem_nick, String mem_addr, String mem_birth,
			String mem_tel, String mem_gender) {

		this.mem_name = mem_name;
		this.mem_id = mem_id;
		this.mem_pwd = mem_pwd;
		this.mem_gender = mem_gender;
		this.mem_addr = mem_addr;
		this.mem_tel = mem_tel;
		this.mem_birth = mem_birth;
		this.mem_nick = mem_nick;
		this.mem_email = mem_email;
	
	}

	
	//내 정보 용
	public MemberVo(String mem_name, String mem_id, String mem_gender, String mem_addr, String mem_tel,
			String mem_birth, String mem_nick, String mem_email) {

		this.mem_name = mem_name;
		this.mem_id = mem_id;
		this.mem_gender = mem_gender;
		this.mem_addr = mem_addr;
		this.mem_tel = mem_tel;
		this.mem_birth = mem_birth;
		this.mem_nick = mem_nick;
		this.mem_email = mem_email;

	}

	// Getter/Setter
	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public int getMem_level() {
		return mem_level;
	}

	public void setMem_level(int mem_level) {
		this.mem_level = mem_level;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getMem_pwd() {
		return mem_pwd;
	}

	public void setMem_pwd(String mem_pwd) {
		this.mem_pwd = mem_pwd;
	}

	public String getMem_gender() {
		return mem_gender;
	}

	public void setMem_gender(String mem_gender) {
		this.mem_gender = mem_gender;
	}

	public String getMem_addr() {
		return mem_addr;
	}

	public void setMem_addr(String mem_addr) {
		this.mem_addr = mem_addr;
	}

	public String getMem_tel() {
		return mem_tel;
	}

	public void setMem_tel(String mem_tel) {
		this.mem_tel = mem_tel;
	}

	public String getMem_birth() {
		return mem_birth;
	}

	public void setMem_birth(String mem_birth) {
		this.mem_birth = mem_birth;
	}

	public String getMem_nick() {
		return mem_nick;
	}

	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	
	//toString
	@Override
	public String toString() {
		return "MemberVo [mem_num=" + mem_num + ", mem_level=" + mem_level + ", mem_name=" + mem_name + ", mem_id="
				+ mem_id + ", mem_pwd=" + mem_pwd + ", mem_gender=" + mem_gender + ", mem_addr=" + mem_addr
				+ ", mem_tel=" + mem_tel + ", mem_birth=" + mem_birth + ", mem_nick=" + mem_nick + ", mem_email="
				+ mem_email + "]";
	}
	
	
}
