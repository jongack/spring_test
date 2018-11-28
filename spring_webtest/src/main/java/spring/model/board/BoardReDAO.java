package spring.model.board;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class BoardReDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;

	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	
	public boolean create(BoardReDTO dto) {
		boolean flag = false;
				
		int cnt = mybatis.insert("breply.create", dto);
		
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}
	
	public boolean update(BoardReDTO dto) {
		boolean flag = false;
		
		int cnt = mybatis.update("breply.update", dto);
		
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}
	
	public BoardReDTO read(int rnum) {
		
		return mybatis.selectOne("breply.read", rnum);
	}
	public boolean delete(int rnum) {
		boolean flag = false;
		
		int cnt = mybatis.delete("breply.delete", rnum);
		
		if(cnt>0) {
			flag = true;
		}
		return flag;
		
	}
	public boolean bdelete(int num) {
		boolean flag = false;
		
		int cnt = mybatis.delete("breply.bdelete", num);
		
		if(cnt>0) {
			flag = true;
		}
		return flag;
		
	}
	
	public List<BoardReDTO> list(Map map) {
		return mybatis.selectList("breply.list", map);
	}
	public int total(int num) {
		return mybatis.selectOne("breply.total", num);
	}
	
}
