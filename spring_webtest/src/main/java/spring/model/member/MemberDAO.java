package spring.model.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.db.webtest.DBClose;
import spring.db.webtest.DBOpen;



@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	

	
	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	
	public String findId(Map map) {
		String id = mybatis.selectOne("member.findId", map);
		
		return id;
		
	}
	public String findPw(Map map) {
		String passwd = mybatis.selectOne("member.findPw", map);
		
		return passwd;
		
	}
	
	public String getGrade(String id) {
		String grade = mybatis.selectOne("member.getGrade", id);
		
		
		
		return grade;
		
	}
	
	public boolean loginCheck(Map map) {
		boolean flag = false;
		int cnt = mybatis.selectOne("member.loginCheck", map);
		if(cnt>0) {
			flag = true;
		}
		
		
		return flag;
	}
	
	public String getFname(String id) {
		String getFname = mybatis.selectOne("member.getFname", id);
		
		
		return getFname;
	}
	
	public boolean updatePw(Map map) {
		boolean flag=false;
		int cnt = mybatis.update("member.updatePw", map);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	
	public boolean updateFile(Map map) {
		boolean flag=false;
		int cnt = mybatis.update("member.updateFile", map);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	
	public boolean duplicateEmail(String email) {
		boolean flag = false;
		int cnt = mybatis.selectOne("member.duplicateEmail", email);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}
	public boolean duplicatePw(Map map) {
		boolean flag = false;
		
		int cnt = mybatis.selectOne("member.duplicatePw", map);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	
	
	public boolean duplicateID(String id) {
		boolean flag = false;
		
		int cnt = mybatis.selectOne("member.duplicateID", id);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	
	public boolean create(MemberDTO dto) {
		boolean flag = false;
		
		int cnt = mybatis.insert("member.create", dto);
		if(cnt>0) {
			flag = true;
		}
		
		
		return flag;
	}
	public MemberDTO read(String id) {
		MemberDTO dto = mybatis.selectOne("member.read", id);
		return dto;
	}
	public boolean update(MemberDTO dto) {
		boolean flag = false;
		
		int cnt = mybatis.update("member.update", dto);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	public boolean delete(String id) {
		boolean flag = false;
		
		int cnt = mybatis.delete("member.delete", id);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	public int total(Map map) {
		int total =mybatis.selectOne("member.total", map);
		
		
		return total;
	}
	public List<MemberDTO> list(Map map) {
		return mybatis.selectList("member.list", map);
	}

}
