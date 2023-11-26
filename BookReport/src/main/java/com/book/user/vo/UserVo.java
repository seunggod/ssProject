package com.book.user.vo;

public class UserVo {
	// Fields
	private  int    mem_num;
	private  String mem_name;
	private  String mem_id;
	private  String password;
	private  String nickname;
	private  String gender;
	private  String email;
	private  String mem_tel;
	private  String birth;
	private  String address;
	private  int    mem_lvl;  //관리자 여부
	private  String joindate;
	//Constructor
	public UserVo() {}
	public UserVo(int mem_num, String mem_name, String mem_id, String password, String nickname, String gender,
			String email, String mem_tel, String birth, String address, int mem_lvl, String joindate) {
		super();
		this.mem_num = mem_num;
		this.mem_name = mem_name;
		this.mem_id = mem_id;
		this.password = password;
		this.nickname = nickname;
		this.gender = gender;
		this.email = email;
		this.mem_tel = mem_tel;
		this.birth = birth;
		this.address = address;
		this.mem_lvl = mem_lvl;
		this.joindate = joindate;
	}
	//Getter / Setter
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMem_tel() {
		return mem_tel;
	}
	public void setMem_tel(String mem_tel) {
		this.mem_tel = mem_tel;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getMem_lvl() {
		return mem_lvl;
	}
	public void setMem_lvl(int mem_lvl) {
		this.mem_lvl = mem_lvl;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	//toString
	@Override
	public String toString() {
		return "UserVo [mem_num=" + mem_num + ", mem_name=" + mem_name + ", mem_id=" + mem_id + ", password=" + password
				+ ", nickname=" + nickname + ", gender=" + gender + ", email=" + email + ", mem_tel=" + mem_tel
				+ ", birth=" + birth + ", address=" + address + ", mem_lvl=" + mem_lvl + ", joindate=" + joindate + "]";
	}
	
}
