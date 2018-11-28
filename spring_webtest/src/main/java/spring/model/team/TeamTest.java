package spring.model.team;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class TeamTest {

	
	
	public static void main(String[] args) {
		
		Resource resource = new ClassPathResource("daoTest.xml");
		//org.springframework.core.io import
		
		BeanFactory factory = new XmlBeanFactory(resource);
		
		TeamDAO dao = (TeamDAO)factory.getBean("team");
		//create(dao);
		//createAns(dao);
		//delete(dao);
		list(dao);
		
		//read(dao);
		//readAns(dao);
		//refnumCheck(dao);
		//total(dao);
		//update(dao);
		//updateAnsnum(dao);
		//updateCount(dao);

	}

	private static void updateCount(TeamDAO dao) {
		int num =801;
		boolean flag = dao.updateViewcnt(num);
		
		if(flag) {
			System.out.println("조회수 증가성공");
		}else {
			System.out.println("조회수 증가 실패");
		}
		
	}

	private static void updateAnsnum(TeamDAO dao) {
		int num = 1;
		TeamDTO dto = dao.read(num);
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

	private static void update(TeamDAO dao) {
	
		TeamDTO dto = dao.read(24);
		
		//dto.setAddress("인천");
		//dto.setAddress2("부평구");
		
		
		dto.setHobby("영화보기");
		
		dto.setPhone("1111111");
		dto.setSkills("백만볼트");
		dto.setZipcode("12345");
		
		
		boolean flag = false;
				flag=dao.update(dto);
				if(flag) {
					System.out.println("정보수정성공");
				}else {
					System.out.println("정보 수정 실패");
				}
	}

	private static void total(TeamDAO dao) {
		Map map = new HashMap();
		String col = "title";
		String word = "부모";
		map.put("col", col);
		map.put("word",word);
		int total = dao.total(map);
		
		System.out.println("총레코드수:"+total);
		
	}

	private static void refnumCheck(TeamDAO dao) {
		boolean flag = false;
		int num = 801;
		flag=dao.checkRefnum(num);
		if(flag) {
			System.out.println("답변이 있습니다");
		}else {
			System.out.println("답변이 없습니다");
		}
		
	}

	private static void readAns(TeamDAO dao) {
		int Memono =24;
		TeamDTO dto= dao.replyRead(Memono);
		p(dto);
		
	}

	private static void read(TeamDAO dao) {
		int num = 24;
		
		TeamDTO dto = dao.read(num);
		p(dto);
	}

	private static void p(TeamDTO dto) {
		
		System.out.println("num:"+dto.getName());
		System.out.println("subject:"+dto.getGender());
		System.out.println("regdate:"+dto.getHobby());
		System.out.println("count:"+dto.getNo());
		System.out.println("indent:"+dto.getSkills());
		System.out.println("ansnum:"+dto.getAnsnum());
		
		
	}

	

	private static void list(TeamDAO dao) {
		Map map = new HashMap();
		int sno = 0;
		int eno = 5;
		map.put("sno", sno);
		map.put("eno", eno);
		//map.put("col", "title");
		//map.put("word", "부모");
		List<TeamDTO> list = new ArrayList<TeamDTO>();
		list = dao.list(map);
		
		for(int i=0;i<list.size();i++) {
			TeamDTO dto =list.get(i);
			
			p(dto);
			System.out.println("--------------------");
		}
		
	}

	private static void delete(TeamDAO dao) {
		int num = 806;
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

	private static void createAns(TeamDAO dao) {
		
		TeamDTO dto = new TeamDTO();
		int num = 24;
		dto=dao.replyRead(num);
		
		dto.setGender("여자");
		dto.setHobby("영화보기");
		dto.setName("답글2");
		dto.setPhone("0101111111");
		dto.setSkills("몸통박치기");
		
		
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

	private static void create(TeamDAO dao) {
		boolean flag= false;
		
		
		TeamDTO dto = new TeamDTO();
		//dto.setAddress("서울");
		//dto.setAddress2("종로구");
		
		dto.setGender("남자");
		dto.setHobby("영화보기");
		dto.setName("홍길동");
		dto.setPhone("0101111111");
		dto.setSkills("몸통박치기");
		//dto.setZipcode("11111");
		
		
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
