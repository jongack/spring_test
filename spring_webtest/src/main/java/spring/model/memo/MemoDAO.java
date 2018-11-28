package spring.model.memo;

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
public class MemoDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	

	
	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}

	public boolean checkRefnum(int memono) {
		boolean flag = false;
		
		int cnt = mybatis.selectOne("memo.checkRefnum", memono);
		if(cnt>0) {
			flag = true;
		}
		
		
		return flag;
	}
	
	public int maxAnsnum(MemoVO grandsundto) {
		int maxnum =0;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
				
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select nvl((select max(ansnum) from memo where grpno=? and indent=?),0) from dual ");
		
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grandsundto.getGrpno());
			pstmt.setInt(2, grandsundto.getIndent());
			
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				maxnum = rs.getInt(1);
				
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		
		
		return maxnum;
	}
	public int maxMemono(MemoVO grandsundto) {
		int maxmemono =0;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
				
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select  max(memono) from memo ");
		
		
		try {
			pstmt = con.prepareStatement(sql.toString());
					
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				maxmemono = rs.getInt(1);
				
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		
		
		return maxmemono;
	}
	
	public boolean countAnsnum(Map map) {
		
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int ansnum = (Integer) map.get("ansnum");
		int maxnum= (Integer) map.get("maxnum");
		int grpno = (Integer) map.get("grpno");
		int indent = (Integer) map.get("indent");
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select count(ansnum) ");
		sql.append(" from memo ");
		sql.append(" where grpno=? and ansnum=? and indent=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);
			pstmt.setInt(3, indent);
			
			rs=pstmt.executeQuery();
			rs.next();
			int cnt = rs.getInt(1);
			if(cnt>0) {
				flag=true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	
	public void upAnsnum(Map map){
		
		mybatis.update("memo.upAnsnum", map);
	}
	
	
	public boolean upAnsall(Map map2) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		int ansnum=(Integer) map2.get("ansnum");
		int grpno= (Integer) map2.get("grpno");
				
		StringBuffer sql = new StringBuffer();
		
		sql.append(" update memo ");
		sql.append(" set ansnum= ansnum+1");
		sql.append(" where grpno=? and ansnum>=?");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);
			
			
			
			int cnt = pstmt.executeUpdate()	;
			if(cnt>0) {
				flag=true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con);
		}
		return flag;
		
	}
	
	/*public void upAnsnum(Map map) {
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
					
		int grpno = (Integer)map.get("grpno");
		int ansnum = (Integer)map.get("ansnum");
		StringBuffer sql = new StringBuffer();
		
		sql.append(" update memo ");
		sql.append(" set ansnum=(select max(ansnum) where grpno=?)+1");
		sql.append(" where grpno=? and ansnum)>?");
		//sql.append(" where grpno=? and ansnum>?");
		//where grpno=? and max(ansnum)>?")
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, grpno);
			pstmt.setInt(3, ansnum);
			
			pstmt.executeUpdate()	;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt);
		}
	}*/
	

	public boolean replyCreate(MemoVO dto){
		boolean flag = false;
		int cnt = mybatis.insert("memo.replyCreate", dto);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	
	public MemoVO replyRead(int memono) {
		MemoVO dto = mybatis.selectOne("memo.replyRead", memono);
		
		return dto;
	}

	public boolean create(MemoVO dto) {
		boolean flag = false;
		
		int cnt = mybatis.insert("memo.create", dto);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}
	
	public MemoVO read(int memono) {
		MemoVO dto = mybatis.selectOne("memo.read", memono);
		
		
		return dto;
	}
	
	public boolean update(MemoVO dto) {
		boolean flag = false;
		int cnt = mybatis.update("memo.update", dto);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}
	
	public boolean delete(int memono) {
		boolean flag = false;
		
		int cnt = mybatis.delete("memo.delete", memono);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
	public int total(Map map) {
		int total = mybatis.selectOne("memo.total", map);
		
		
		return total;		
	}
	public List<MemoVO> list(Map map) {
		
		return mybatis.selectList("memo.list", map);
	}
	
	
	public boolean updateViewcnt(int memono) {
		boolean flag = false;
		
		int cnt = mybatis.update("memo.updateViewcnt", memono);
		if(cnt>0) {
			flag = true;
		}
		
		return flag;
	}
}
