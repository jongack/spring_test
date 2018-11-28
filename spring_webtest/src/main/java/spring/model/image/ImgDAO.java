package spring.model.image;

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
public class ImgDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	public List Imgread(int no) {
		
		return  mybatis.selectList("img.Imgread", no);
		
		
		
		
		/*Connection con = DBOpen.open();
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select * from ( ");
		sql.append(" 				select lag(no, 2) over(order by no) pre_no2, ");
		sql.append(" 					   lag(no, 1) over(order by no) pre_no1, ");
		sql.append(" 				       no, ");
		sql.append(" 				       lead(no, 1) over(order by no) po_no1, ");
		sql.append(" 				       lead(no, 2) over(order by no) po_no2, ");
		sql.append(" 				       lag(fname, 2) over(order by no) pre_fname2, ");
		sql.append(" 				       lag(fname, 1) over(order by no) pre_fname1, ");
		sql.append(" 				       fname, ");
		sql.append(" 				       lead(fname, 1) over(order by no) po_fname1, ");
		sql.append(" 				       lead(fname, 2) over(order by no) po_fname2 ");
		sql.append(" 			from( ");
		sql.append(" 					select no, fname, name, title  ");
		sql.append(" 					from img  ");
		sql.append(" 					order by no desc ");
		sql.append(" 			) ");
		sql.append(" )where no=? ");
		

		try {
			pstmt=con.prepareStatement(sql.toString());
//			if(word.trim().length()>0)
//			pstmt.setString(++i, word);
//			pstmt.setInt(++i, sno);
			pstmt.setInt(1, no);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				int [] no1 = {
						rs.getInt("pre_no2"),
						rs.getInt("pre_no1"),
						rs.getInt("no"),
						rs.getInt("po_no1"),
						rs.getInt("po_no2")
						
				};
				String[] fname1 = {
						rs.getString("pre_fname2"),
					rs.getString("pre_fname1"),
					rs.getString("fname"),
					rs.getString("po_fname1"),
					rs.getString("po_fname2")
					
				};
				list.add(no1);
				list.add(fname1);
				
	
				
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt, rs);
			
		}*/
		
		
	}

	public boolean create(ImgDTO dto) {
		boolean flag=false;
		
		int cnt = mybatis.insert("img.create", dto);
		if(cnt>0) {
			flag =true;
		}

		
		return flag;
		
		
		
	}
	
	
	public boolean delete(int no) {
		boolean flag = false;
		int cnt = mybatis.delete("img.delete", no);
		if(cnt>0) {
			flag =true;
		}

		return flag;
	}
	
	public boolean update(ImgDTO dto) {
		boolean flag = false;
		
		int cnt = mybatis.update("img.update", dto);
		if(cnt>0) {
			flag =true;
		}
		
		return flag;
	}
	
	public boolean passCheck(Map map) {
		boolean flag= false;
		
		int cnt = mybatis.selectOne("img.passCheck", map);
		if(cnt>0) {
			flag =true;
		}
		
		return flag;
	}
	
	public List readFname2(int no) {
		List list = new ArrayList();
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * ");
		sql.append(" FROM ( ");
		sql.append(" 	SELECT LAG(fname,2,'member.jpg') OVER(ORDER BY r) as p2_fname, ");
		sql.append(" 		LAG(fname,1,'member.jpg') OVER(ORDER BY r) as p_fname, ");
		sql.append(" 		fname, ");
		sql.append(" 		LEAD(fname,1,'member.jpg') OVER(ORDER BY r) as n_fname, ");
		sql.append(" 		LEAD(fname,2,'member.jpg') OVER(ORDER BY r) as n2_fname, ");
		sql.append(" 		LAG(no,2,-1) OVER(ORDER BY r) as p2_no, ");
		sql.append(" 		LAG(no,1,-1) OVER(ORDER BY r) as p_no, ");
		sql.append(" 		no, ");
		sql.append(" 		LEAD(no,1,-1) OVER(ORDER BY r) as n_no, ");
		sql.append(" 		LEAD(no,2,-1) OVER(ORDER BY r) as n2_no ");
		sql.append(" 	FROM ( ");
		sql.append(" 		SELECT no, fname, rownum as r FROM img ORDER BY grpno DESC, ansnum ");
		sql.append("	) ");
		sql.append(" )  WHERE no = ? ");
		int i = 0;
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int[] imgNo = {rs.getInt("p2_no"), rs.getInt("p_no"), rs.getInt("no"), rs.getInt("n_no"), rs.getInt("n2_no")};
				String[] imgFname = {rs.getString("p2_fname"), rs.getString("p_fname"), 
						rs.getString("fname"), rs.getString("n_fname"), rs.getString("n2_fname")};
				list.add(imgNo);
				list.add(imgFname);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return list;
	}
	
	public ImgDTO read(int no) {
		ImgDTO dto = mybatis.selectOne("img.read", no);
		
		
		
		return dto;
	}
	
	public int total(Map map) {
		int total=mybatis.selectOne("img.total", map);
		
		
		
		return total;
	}
	
	public List<ImgDTO> list(Map map){
		List<ImgDTO> list = mybatis.selectList("img.list", map);
		
		return list;
	}
}
