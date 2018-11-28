package spring.model.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class BoardTest {

	
	
	public static void main(String[] args) {
		
		Resource resource = new ClassPathResource("daoTest.xml");
		//org.springframework.core.io import
		
		BeanFactory factory = new XmlBeanFactory(resource);
		
		BoardDAO dao = (BoardDAO)factory.getBean("dao");
		//create(dao);
		//createAns(dao);
		delete(dao);
		//list(dao);
		//passwdCheck(dao);
		//read(dao);
		//readAns(dao);
		//refnumCheck(dao);
		//total(dao);
		//update(dao);
		//updateAnsnum(dao);
		//updateCount(dao);

	}

	private static void updateCount(BoardDAO dao) {
		int num =1;
		boolean flag = false;
		 dao.upCount(num);
		
		if(flag) {
			System.out.println("조회수 증가성공");
		}else {
			System.out.println("조회수 증가 실패");
		}
		
	}

	private static void updateAnsnum(BoardDAO dao) {
		int num = 1;
		BoardDTO dto = dao.read(num);
		
		
		boolean flag = false;
		flag=dao.upAnsnum(dto);
		if(flag) {
			System.out.println("조회수 증가성공");
		}else {
			System.out.println("조회수 증가 실패");
		}
	}

	private static void update(BoardDAO dao) {
	
		BoardDTO dto = new BoardDTO();
		dto.setName("보스턴");
		dto.setSubject("rkrkrk");
		dto.setContent("fkfkfk");
		dto.setFilename("tnwjd.txt");
		dto.setFilesize(4);
		dto.setNum(1);
		boolean flag = false;
				flag=dao.update(dto);
				if(flag) {
					System.out.println("정보수정성공");
				}else {
					System.out.println("정보 수정 실패");
				}
	}

	private static void total(BoardDAO dao) {
		Map map = new HashMap();
		String col = "name";
		String word = "강정호";
		map.put("col", col);
		map.put("word",word);
		int total = dao.getTotal(map);
		
		System.out.println("총레코드수:"+total);
		
	}

	private static void refnumCheck(BoardDAO dao) {
		boolean flag = false;
		int num = 3;
		flag=dao.refnumCheck(num);
		if(flag) {
			System.out.println("답변이 있습니다");
		}else {
			System.out.println("답변이 없습니다");
		}
		
	}

	private static void readAns(BoardDAO dao) {
		int num =1;
		BoardDTO dto= dao.readReply(num);
		p(dto);
		
	}

	private static void read(BoardDAO dao) {
		int num = 1;
		
		BoardDTO dto = dao.read(num);
		p(dto);
	}

	private static void p(BoardDTO dto) {
		System.out.println("name:"+dto.getName());
		System.out.println("num:"+dto.getNum());
		System.out.println("subject:"+dto.getSubject());
		System.out.println("regdate:"+dto.getRegdate());
		System.out.println("count:"+dto.getCount());
		System.out.println("indent:"+dto.getIndent());
		
		
	}

	private static void passwdCheck(BoardDAO dao) {
		boolean flag = false;
		int passwd=1234;
		int num = 1;
		Map map = new HashMap();
		map.put("passwd", passwd);
		map.put("num", num);
		flag=dao.passwdCheck(map);
		if(flag) {
			System.out.println("비밀번호가 맞습니다");
		}else {
			System.out.println("비밀번호가 틀렷습니다");
		}
		
	}

	private static void list(BoardDAO dao) {
		Map map = new HashMap();
		int sno = 0;
		int eno = 5;
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("col", "name");
		map.put("word", "홍");
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		list = dao.getList(map);
		
		for(int i=0;i<list.size();i++) {
			BoardDTO dto =list.get(i);
			
			System.out.println("name:"+dto.getName());
			System.out.println("num:"+dto.getNum());
			System.out.println("subject:"+dto.getSubject());
			System.out.println("regdate:"+dto.getRegdate());
			System.out.println("count:"+dto.getCount());
			System.out.println("indent:"+dto.getIndent());
			System.out.println("--------------------");
		}
		
	}

	private static void delete(BoardDAO dao) {
		int num = 31;
		boolean flag = false;
		boolean flag2 = false;
		flag = dao.checkRefnum(num);
		if(flag) {
			System.out.println("답변글이 있어서 삭제불가");
		}else {
			flag2 = dao.delete(num);
			if(flag2) {
				System.out.println("삭제성공");
			}else {
				System.out.println("삭제실패");
			}
		}
	}

	private static void createAns(BoardDAO dao) {
		
		BoardDTO dto = new BoardDTO();
		int num = 1;
		dto=dao.readReply(num);
		dto.setName("답변자2");
		dto.setContent("답변자의글2");
		dto.setPasswd("1234");
		dto.setIp("111.222.222.333");
		dto.setFilename("ans.txt");
		dto.setFilesize(30);
		
		Map map  = new HashMap();
		map.put("ref", dto.getRef());
		map.put("ansnum", dto.getAnsnum());
		
		dao.upAnsnum(map);
		
		if(dao.insertReply(dto)) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
		
	}

	private static void create(BoardDAO dao) {
		boolean flag= false;
		
		
		BoardDTO dto = new BoardDTO();
		dto.setName("f구구구");
		dto.setSubject("dkdk");
		dto.setContent("dkdkdk");
		dto.setPasswd("1234");
		dto.setIp("111.111.111.11");
		//dto.setFilename("ttt.ttp");
		//dto.setFilesize(34);
		flag = dao.create(dto);
		
		if(flag) {
			System.out.println("등록성공");
		}else {
			System.out.println("등록실패");
		}
		
	}

}
