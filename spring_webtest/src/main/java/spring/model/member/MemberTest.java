package spring.model.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class MemberTest {

	
	
	public static void main(String[] args) {
		
		Resource resource = new ClassPathResource("daoTest.xml");
		//org.springframework.core.io import
		
		BeanFactory factory = new XmlBeanFactory(resource);
		
		MemberDAO dao = (MemberDAO)factory.getBean("member");
		//create(dao);
		
		//delete(dao);
		//list(dao);
		
		//read(dao);
		//readAns(dao);
		
		//total(dao);
		//update(dao);
		updateFname(dao);
		//updateCount(dao);

	}

	private static void updateCount(MemberDAO dao) {
		int num =801;
		boolean flag = dao.updateViewcnt(num);
		
		if(flag) {
			System.out.println("조회수 증가성공");
		}else {
			System.out.println("조회수 증가 실패");
		}
		
	}

	private static void updateFname(MemberDAO dao) {
		String num = "user1";
		
		Map map = new HashMap();
		map.put("fname", "qus");
		map.put("id", num);
		
		boolean flag = dao.updateFile(map);
		if(flag) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
	}

	private static void update(MemberDAO dao) {
	
		MemberDTO dto = dao.read("testdi");
	
		dto.setTel("12345");
		dto.setEmail("te@mail.com");
		dto.setZipcode("11111");
		dto.setAddress1("wnth");
		dto.setJob("qortn");
		
		//dto.setFilename("tnwjd.txt");
		
		
		boolean flag = false;
				flag=dao.update(dto);
				if(flag) {
					System.out.println("정보수정성공");
				}else {
					System.out.println("정보 수정 실패");
				}
	}

	private static void total(MemberDAO dao) {
		Map map = new HashMap();
		String col = "title";
		String word = "부모";
		map.put("col", col);
		map.put("word",word);
		int total = dao.total(map);
		
		System.out.println("총레코드수:"+total);
		
	}

	private static void refnumCheck(MemberDAO dao) {
		boolean flag = false;
		int num = 801;
		flag=dao.checkRefnum(num);
		if(flag) {
			System.out.println("답변이 있습니다");
		}else {
			System.out.println("답변이 없습니다");
		}
		
	}

	private static void readAns(MemberDAO dao) {
		int Memono =801;
		MemberDTO dto= dao.replyRead(Memono);
		p(dto);
		
	}

	private static void read(MemberDAO dao) {
		String num = "testdi";
		
		MemberDTO dto = dao.read(num);
		p(dto);
	}

	private static void p(MemberDTO dto) {
		
		System.out.println("num:"+dto.getId());
		System.out.println("subject:"+dto.getMname());
		System.out.println("regdate:"+dto.getMdate());
		System.out.println("count:"+dto.getEmail());
		System.out.println("indent:"+dto.getFname());
		System.out.println("ansnum:"+dto.getJob());
		
		
	}

	

	private static void list(MemberDAO dao) {
		Map map = new HashMap();
		int sno = 0;
		int eno = 5;
		map.put("sno", sno);
		map.put("eno", eno);
		//map.put("col", "title");
		//map.put("word", "부모");
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		list = dao.list(map);
		
		for(int i=0;i<list.size();i++) {
			MemberDTO dto =list.get(i);
			
			p(dto);
			System.out.println("--------------------");
		}
		
	}

	private static void delete(MemberDAO dao) {
		String num = "testdi";
		
		boolean flag2 = false;
		
		
			flag2 = dao.delete(num);
			if(flag2) {
				System.out.println("삭제성공");
			}else {
				System.out.println("삭제실패");
			}
		}
	

	private static void createAns(MemberDAO dao) {
		
		MemberDTO dto = new MemberDTO();
		int num = 805;
		dto=dao.replyRead(num);
		
		dto.setContent("답변자의글6");
		
		
		Map map  = new HashMap();
		map.put("grpno", dto.getGrpno());
		map.put("ansnum", dto.getAnsnum());
		System.out.println(dto.getGrpno()+" "+dto.getAnsnum());
		dao.upAnsnum(map);
		
		if(dao.replyCreate(dto)) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
		
	}

	private static void create(MemberDAO dao) {
		boolean flag= false;
		
		
		MemberDTO dto = new MemberDTO();
		
		dto.setId("testdi");
		dto.setAddress1("ad");
		dto.setAddress2("ad2");
		dto.setEmail("testdi@mail");
		dto.setFname("testdi.txt");
		dto.setJob("testdi");
		dto.setMname("ㄱㄱㄱ");
		dto.setPasswd("1234");
		
		flag = dao.create(dto);
		
		if(flag) {
			System.out.println("등록성공");
		}else {
			System.out.println("등록실패");
		}
		
	}

}
