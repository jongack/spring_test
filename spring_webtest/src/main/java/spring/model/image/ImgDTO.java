package spring.model.image;

import org.springframework.web.multipart.MultipartFile;

public class ImgDTO {    
	private int			 no		;
	private String 	name	;
	private String 	title;
	private String 	passwd;
	private String 	mdate;
	private String 	fname;
	private MultipartFile fnameMF;
	private int			grpno	;
	private int			indent	;
	private int			ansnum	;
	private int pre_no2;
	private int pre_no1;
	private int po_no1 ;
	private int po_no2 ;
	private String pre_fname2 ;
	private String pre_fname1 ;
	private String po_fname1 ;
	private String po_fname2 ;
	
	
	public int getPre_no2() {
		return pre_no2;
	}
	public void setPre_no2(int pre_no2) {
		this.pre_no2 = pre_no2;
	}
	public int getPre_no1() {
		return pre_no1;
	}
	public void setPre_no1(int pre_no1) {
		this.pre_no1 = pre_no1;
	}
	public int getPo_no1() {
		return po_no1;
	}
	public void setPo_no1(int po_no1) {
		this.po_no1 = po_no1;
	}
	public int getPo_no2() {
		return po_no2;
	}
	public void setPo_no2(int po_no2) {
		this.po_no2 = po_no2;
	}
	public String getPre_fname2() {
		return pre_fname2;
	}
	public void setPre_fname2(String pre_fname2) {
		this.pre_fname2 = pre_fname2;
	}
	public String getPre_fname1() {
		return pre_fname1;
	}
	public void setPre_fname1(String pre_fname1) {
		this.pre_fname1 = pre_fname1;
	}
	public String getPo_fname1() {
		return po_fname1;
	}
	public void setPo_fname1(String po_fname1) {
		this.po_fname1 = po_fname1;
	}
	public String getPo_fname2() {
		return po_fname2;
	}
	public void setPo_fname2(String po_fname2) {
		this.po_fname2 = po_fname2;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
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
	public MultipartFile getFnameMF() {
		return fnameMF;
	}
	public void setFnameMF(MultipartFile fnameMF) {
		this.fnameMF = fnameMF;
	}
	
	
	
}
