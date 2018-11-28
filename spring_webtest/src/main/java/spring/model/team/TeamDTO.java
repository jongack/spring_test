package spring.model.team;

public class TeamDTO {
	
	private int no;
	private String name;
	private String gender;
	private String hobby;
	private String skills;
	private String[] skill;//form에서 보낸 데이터 저장
	private String phone;
	private String zipcode;
	private String address;
	private String address2;
	private int grpno;
	private int indent;
	private int ansnum;
	
	
	
	public int getGrpno() {
		return grpno;
	}
	public void setGrpno(int grpno) {
		this.grpno = grpno;
	}
	public int getIndent() {
		return indent;
	}
	public void setIndent(int indent) {
		this.indent = indent;
	}
	public int getAnsnum() {
		return ansnum;
	}
	public void setAnsnum(int ansnum) {
		this.ansnum = ansnum;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	public String getSkills() {
		
		if(skill!=null) {
			String skills="";

			for(int i=0;i<skill.length-1;i++) {
				skills=skills+skill[i]+", ";
			}
			skills=skills+skill[skill.length-1];

			this.skills=skills;
		}
		return skills;
	}
	public void setSkills(String skills) {
		this.skills = skills;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String[] getSkill() {
		return skill;
	}
	public void setSkill(String[] skill) {
		this.skill = skill;
	}
}
