package spring.model.bbs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import spring.model.board.ReplyDAO;
import spring.model.board.ReplyDTO;

public class ReplyTest {

	
	
	public static void main(String[] args) {
		
		Resource resource = new ClassPathResource("daoTest.xml");
		//org.springframework.core.io import
		
		BeanFactory factory = new XmlBeanFactory(resource);
		
		ReplyDAO dao = (ReplyDAO)factory.getBean("reply");
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




	private static void update(ReplyDAO dao) {
	
		ReplyDTO dto = dao.read(3);
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

	private static void total(ReplyDAO dao) {
		Map map = new HashMap();
		int bbsno = 56;
		int total = dao.total(bbsno);
		
		System.out.println("총레코드수:"+total);
		
	}





	private static void read(ReplyDAO dao) {
		int num = 1;
		
		ReplyDTO dto = dao.read(num);
		p(dto);
	}

	private static void p(ReplyDTO dto) {
		System.out.println("name:"+dto.getRnum());
		System.out.println("num:"+dto.getContent());
		System.out.println("subject:"+dto.getId());
		System.out.println("regdate:"+dto.getRegdate());
		System.out.println("count:"+dto.getBbsno());
		
		
	}

	

	private static void list(ReplyDAO dao) {
		Map map = new HashMap();
		int sno = 0;
		int eno = 5;
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("bbsno", 56);
		
		List<ReplyDTO> list = new ArrayList<ReplyDTO>();
		list = dao.list(map);
		
		for(int i=0;i<list.size();i++) {
			ReplyDTO dto =list.get(i);
			
			p(dto);
			System.out.println("--------------------");
		}
		
	}

	private static void delete(ReplyDAO dao) {
		int rnum = 1;
		boolean flag = false;
		boolean flag2 = false;
		
		
			flag2 = dao.delete(rnum);
			if(flag2) {
				System.out.println("삭제성공");
			}else {
				System.out.println("삭제실패");
			}
		}
	

	

	private static void create(ReplyDAO dao) {
		boolean flag= false;
		
		
		ReplyDTO dto = new ReplyDTO();
		dto.setBbsno(56);
		dto.setContent("ㅇㅇ");
		dto.setId("admin");
		
		
		flag = dao.create(dto);
		
		if(flag) {
			System.out.println("등록성공");
		}else {
			System.out.println("등록실패");
		}
		
	}

}
