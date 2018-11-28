package spring.model.bbs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class BbsTest {

	
	
	public static void main(String[] args) {
		
		Resource resource = new ClassPathResource("daoTest.xml");
		//org.springframework.core.io import
		
		BeanFactory factory = new XmlBeanFactory(resource);
		
		BbsDAO dao = (BbsDAO)factory.getBean("dao");
		//create(dao);
		//createAns(dao);
		//delete(dao);
		//list(dao);
		passwdCheck(dao);
		//read(dao);
		//readAns(dao);
		//refnumCheck(dao);
		//total(dao);
		//update(dao);
		//updateAnsnum(dao);
		//updateCount(dao);

	}

	private static void updateCount(BbsDAO dao) {
		int num =1;
		boolean flag = false;
		 dao.upCount(num);
		
		if(flag) {
			System.out.println("조회수 증가성공");
		}else {
			System.out.println("조회수 증가 실패");
		}
		
	}

	private static void updateAnsnum(BbsDAO dao) {
		int num = 1;
		BbsDTO dto = dao.read(num);
		Map map = new HashMap();
		map.put("grpno", dto.getGrpno());
		map.put("ansnum", dto.getAnsnum());
		
		boolean flag = false;
		dao.upAnsnum(map);
		/*if(flag) {
			System.out.println("조회수 증가성공");
		}else {
			System.out.println("조회수 증가 실패");
		}*/
	}

	private static void update(BbsDAO dao) {
	
		BbsDTO dto = dao.read(3);
		dto.setWname("보스턴");
		dto.setTitle("rkrkrk");
		dto.setContent("fkfkfk");
		//dto.setFilename("tnwjd.txt");
		dto.setFilesize(4);
		
		boolean flag = false;
				flag=dao.update(dto);
				if(flag) {
					System.out.println("정보수정성공");
				}else {
					System.out.println("정보 수정 실패");
				}
	}

	private static void total(BbsDAO dao) {
		Map map = new HashMap();
		String col = "wname";
		String word = "왕눈이";
		map.put("col", col);
		map.put("word",word);
		int total = dao.total(map);
		
		System.out.println("총레코드수:"+total);
		
	}

	private static void refnumCheck(BbsDAO dao) {
		boolean flag = false;
		int num = 24;
		flag=dao.checkRefnum(num);
		if(flag) {
			System.out.println("답변이 있습니다");
		}else {
			System.out.println("답변이 없습니다");
		}
		
	}

	private static void readAns(BbsDAO dao) {
		int bbsno =1;
		BbsDTO dto= dao.replyRead(bbsno);
		p(dto);
		
	}

	private static void read(BbsDAO dao) {
		int num = 1;
		
		BbsDTO dto = dao.read(num);
		p(dto);
	}

	private static void p(BbsDTO dto) {
		System.out.println("name:"+dto.getWname());
		System.out.println("num:"+dto.getBbsno());
		System.out.println("subject:"+dto.getTitle());
		System.out.println("regdate:"+dto.getWdate());
		System.out.println("count:"+dto.getViewcnt());
		System.out.println("indent:"+dto.getIndent());
		
		
	}

	private static void passwdCheck(BbsDAO dao) {
		boolean flag = false;
		String passwd="r";
		int bbsno = 56;
		Map map = new HashMap();
		map.put("passwd", passwd);
		map.put("bbsno", bbsno);
		flag=dao.passCheck(map);
		if(flag) {
			System.out.println("비밀번호가 맞습니다");
		}else {
			System.out.println("비밀번호가 틀렷습니다");
		}
		
	}

	private static void list(BbsDAO dao) {
		Map map = new HashMap();
		int sno = 0;
		int eno = 5;
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("col", "name");
		map.put("word", "홍");
		List<BbsDTO> list = new ArrayList<BbsDTO>();
		list = dao.list(map);
		
		for(int i=0;i<list.size();i++) {
			BbsDTO dto =list.get(i);
			
			System.out.println("name:"+dto.getWname());
			System.out.println("bbsnum:"+dto.getBbsno());
			System.out.println("subject:"+dto.getTitle());
			System.out.println("regdate:"+dto.getWdate());
			System.out.println("count:"+dto.getViewcnt());
			System.out.println("indent:"+dto.getIndent());
			System.out.println("--------------------");
		}
		
	}

	private static void delete(BbsDAO dao) {
		int num = 55;
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

	private static void createAns(BbsDAO dao) {
		
		BbsDTO dto = new BbsDTO();
		int num = 44;
		dto=dao.replyRead(num);
		dto.setWname("답변자2");
		dto.setContent("답변자의글2");
		dto.setPasswd("1234");
		//dto.setIp("111.222.222.333");
		dto.setFilename("ans.txt");
		dto.setFilesize(30);
		
		Map map  = new HashMap();
		map.put("grpno", dto.getGrpno());
		map.put("ansnum", dto.getAnsnum());
		
		dao.upAnsnum(map);
		
		if(dao.replyCreate(dto)) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
		
	}

	private static void create(BbsDAO dao) {
		boolean flag= false;
		
		
		BbsDTO dto = new BbsDTO();
		dto.setWname("f구구구");
		dto.setTitle("dkdk");
		dto.setContent("dkdkdk");
		dto.setPasswd("1234");
		//dto.set("111.111.111.11");
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
