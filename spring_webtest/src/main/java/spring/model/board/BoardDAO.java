package spring.model.board;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis; 
	
	
	
	
	
	//daotest.xml에서 dao객체 만들때 사용	
	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}

	public boolean create(BoardDTO dto) {
		boolean flag = false;
		
		int cnt = mybatis.insert("board.create",dto);
		if(cnt>0) {
			flag = true;
		}
		/*PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		Connection con = DBOpen.open();
		sql.append(" INSERT INTO board (num, name, passwd, ");
		sql.append(" subject, content, regdate, ref, ");
		sql.append(" ip, filename, filesize ) ");
		sql.append(" VALUES((SELECT NVL(MAX(num),0) + 1 FROM board), ");
		sql.append(" ?,?,?,?,sysdate, ");
		sql.append(" (SELECT NVL(MAX(ref),0) + 1 FROM board), ");
		sql.append(" ?,?,?) ");
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getPasswd());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getIp());
			pstmt.setString(6, dto.getFilename());
			pstmt.setInt(7, dto.getFilesize());
			int cnt = pstmt.executeUpdate();
			if (cnt > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}*/
		return flag;
	}

	/**
	 * 전체 레코드 갯수
	 * 
	 * @param searchColumn
	 * @param searchWord
	 * @return
	 */
	public int getTotal(Map map) {
		
		return mybatis.selectOne("board.total", map);
		
		/*Connection con = DBOpen.open();
		int total = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String col = (String) map.get("col");
		String word = (String) map.get("word");

		StringBuffer sql = new StringBuffer();

		sql.append(" SELECT COUNT(*) FROM board ");

		if (word.length() > 0 && col.equals("subject_content")) {
			sql.append("  WHERE (subject LIKE '%'||?||'%' ");
			sql.append("  OR content LIKE '%'||?||'%') ");
		} else if (word.length() > 0) {
			sql.append("  WHERE " + col + " LIKE  '%'||?||'%' ");
		}
		try {
			pstmt = con.prepareStatement(sql.toString());
			if(word.length() > 0 && col.equals("subject_content")) {
				pstmt.setString(1, word);
				pstmt.setString(2, word);
			}else if(word.length() > 0){
				pstmt.setString(1, word);
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				total = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return total;*/

	}

	/**
	 * 게시판 글목록
	 * 
	 * @param searchColumn
	 * @param searchWord
	 * @param beginPerPage
	 * @param numPerPage
	 * @return
	 */
	public List<BoardDTO> getList(Map map) {
		
		return mybatis.selectList("board.list", map);
		/*Connection con = DBOpen.open();
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String col = (String) map.get("col");
		String word = (String) map.get("word");
		int sno = (Integer) map.get("sno");
		int eno = (Integer) map.get("eno");

		StringBuffer sql = new StringBuffer();

		sql.append(" SELECT num, name, subject, to_char(regdate,'YYYY-MM-dd') as regdate, ");
		sql.append(" count, indent, filename, filesize, r  ");
		sql.append(" FROM(  ");
		sql.append("      SELECT num, name, subject, regdate , ");
		sql.append("      count, indent, filename, filesize, rownum r ");
		sql.append("      FROM ( ");
		sql.append("            SELECT num, name, subject, regdate,  ");
		sql.append("            count, indent, filename, filesize ");
		sql.append("            FROM board ");
		if (word.length() > 0 && col.equals("subject_content")) {
			sql.append("         WHERE (subject LIKE '%'||?||'%' ");
			sql.append("         OR content LIKE '%'||?||'%') ");
		} else if (word.length() > 0) {
			sql.append("         WHERE " + col + " LIKE  '%'||?||'%' ");
		}
		sql.append("            ORDER BY ref DESC, ansnum ASC ");
		sql.append("      ) ");
		sql.append(" ) ");
		sql.append(" WHERE r >= ? and r <= ? ");

		try {
			int i = 0;
			pstmt = con.prepareStatement(sql.toString());
			if (word.length() > 0 && col.equals("subject_content")) {
				pstmt.setString(++i, word);
				pstmt.setString(++i, word);
			}else if (word.length() > 0) {
				pstmt.setString(++i, word);
			}
			
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardDTO dto = new BoardDTO();

				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setCount(rs.getInt("count"));
				dto.setIndent(rs.getInt("indent"));
				dto.setFilename(rs.getString("filename"));
				dto.setFilesize(rs.getInt("filesize"));

				list.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
			;
		}

		return list;*/

	}

	/**
	 * 조회수 증가
	 * 
	 * @param num
	 */
	public void upCount(int num) {
		
		mybatis.update("board.upCount",num);
		/*Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE board SET count = count +1 ");
		sql.append(" WHERE num = ? ");
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, num);
			int cnt = pstmt.executeUpdate();
			if (cnt > 0) {
				System.out.println("조회수 증가");
			} else {
				System.out.println("조회수 증가 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}*/

	}

	/**
	 * 게시판 글보기
	 * 
	 * @param num
	 * @return
	 */
	public BoardDTO read(int num) {
		
		return mybatis.selectOne("board.read", num);
		/*Connection con = DBOpen.open();
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT num,name,subject,content,count, ");
		sql.append(" filename,filesize,ip,regdate from board WHERE num = ? ");
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCount(rs.getInt("count"));
				dto.setFilename(rs.getString("filename"));
				dto.setFilesize(rs.getInt("filesize"));
				dto.setIp(rs.getString("ip"));
				dto.setRegdate(rs.getString("regdate"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return dto;*/
	}

	/**
	 * 비밀번호 검사
	 * 
	 * @param num
	 * @param passwd
	 * @return
	 */
	public boolean passwdCheck(Map map) {
		boolean flag = false;
		
		int cnt = mybatis.selectOne("board.passwdCheck", map);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}

	public boolean update(BoardDTO dto) {
		
		boolean flag = false;
		int cnt =mybatis.update("board.update", dto);
		if(cnt>0	) {
			flag=true;
		}

		return flag;
	}

	/**
	 * ansnum 재정렬
	 * 
	 * @param ref
	 * @param ansnum
	 */
	public void upAnsnum(Map map){
		
		mybatis.update("board.upAnsnum", map);
	
		
	}

	/**
	 * 답변등록
	 * 
	 * @param dto
	 * @return
	 */
	public boolean insertReply(BoardDTO dto){
		boolean flag = false;
		
		int cnt = mybatis.insert("board.insertReply", dto);
		if(cnt>0) {
			flag=true;
		}
		
		return flag;
	}

	/**
	 * 부모글인지 확인
	 * 
	 * @param num
	 * @param con
	 * @return
	 */
	public boolean checkRefnum(int num) {
		
		boolean flag = false;
		
		int cnt= mybatis.selectOne("board.checkRefnum", num);
		if(cnt>0	) {
			flag=true;
		}
		return flag;
	}

	/**
	 * 게시판 글 삭제
	 * 
	 * @param num
	 * @return
	 */
	public boolean delete(int num) {
		
		boolean flag = false;
		
		int cnt = mybatis.delete("board.delete", num);
		if(cnt>0	) {
			flag=true;
		}
		return flag;
	}

	/**
	 * 부모의 ref,indent,ansnum 가져오기
	 * 
	 * @param num
	 * @return
	 */
	public BoardDTO readReply(int num) {
		
		BoardDTO dto = mybatis.selectOne("board.readReply", num);

		return dto;

	}

}
