package spring.model.team;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import spring.db.webtest.DBClose;
import spring.db.webtest.DBOpen;

@Repository
public class TeamDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}

	public boolean checkRefnum(int no) {
		boolean flag = false;
		
		int cnt = mybatis.selectOne("team.checkRefnum", no);
		if(cnt>0) {
			flag = true;
		}
		
	
		
		return flag;
	}
	
	public boolean replyCreate(TeamDTO dto){
		boolean flag = false;
		int cnt = mybatis.insert("team.replyCreate", dto);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	
	public void upAnsnum(Map map) {
		
		mybatis.update("team.upAnsnum", map);
	}
	
	public TeamDTO replyRead(int no) {
		TeamDTO dto = mybatis.selectOne("team.replyRead", no);
		
		
		
		return dto;
		
	}

	public boolean create(TeamDTO dto) {
		
		boolean flag = false;
		
		int cnt = mybatis.insert("team.create", dto);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}
	
	public TeamDTO read(int no) {
		TeamDTO dto= mybatis.selectOne("team.read", no);
		
		return dto;
	}
	public boolean update(TeamDTO dto) {
		
		boolean flag = false;
		
		int cnt = mybatis.update("team.update", dto);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	public boolean delete(int no) {
		
		boolean flag = false;
		
		int cnt = mybatis.delete("team.delete", no);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	
	public int total(Map map) {
		int total = mybatis.selectOne("team.total", map);
		
		
		
		return total;
	}
	
	public List<TeamDTO> list(Map map) {
		
		return mybatis.selectList("team.list", map);
		
	}
}
