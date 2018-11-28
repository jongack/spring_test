package spring.model.image;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class ImgTest {

	
	
	public static void main(String[] args) {
		
		Resource resource = new ClassPathResource("daoTest.xml");
		//org.springframework.core.io import
		
		BeanFactory factory = new XmlBeanFactory(resource);
		
		ImgDAO dao = (ImgDAO)factory.getBean("img");
		//create(dao);
		
		//delete(dao);
		//list(dao);
		
		read(dao);
		//readAns(dao);
		
		//total(dao);
		//update(dao);
		//updateFname(dao);
		//updateCount(dao);

	}

	private static void updateCount(ImgDAO dao) {
		int num =801;
		boolean flag = dao.updateViewcnt(num);
		
		if(flag) {
			System.out.println("조회수 증가성공");
		}else {
			System.out.println("조회수 증가 실패");
		}
		
	}

	private static void updateFname(ImgDAO dao) {
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

	private static void update(ImgDAO dao) {
	
		ImgDTO dto = dao.read(6);
	
		dto.setName("f");
		dto.setTitle("f");
		
		
		//dto.setFilename("tnwjd.txt");
		
		
		boolean flag = false;
				flag=dao.update(dto);
				if(flag) {
					System.out.println("정보수정성공");
				}else {
					System.out.println("정보 수정 실패");
				}
	}

	private static void total(ImgDAO dao) {
		Map map = new HashMap();
		String col = "title";
		String word = "부모";
		map.put("col", col);
		map.put("word",word);
		int total = dao.total(map);
		
		System.out.println("총레코드수:"+total);
		
	}

	private static void refnumCheck(ImgDAO dao) {
		boolean flag = false;
		int num = 801;
		flag=dao.checkRefnum(num);
		if(flag) {
			System.out.println("답변이 있습니다");
		}else {
			System.out.println("답변이 없습니다");
		}
		
	}

	private static void readAns(ImgDAO dao) {
		int Memono =801;
		ImgDTO dto= dao.replyRead(Memono);
		p(dto);
		
	}

	private static void read(ImgDAO dao) {
		int num = 7;
		List list = new ArrayList();
		list = dao.Imgread(num);
		ImgDTO dto = new ImgDTO() ;
		for(int i=0;i<list.size();i++) {
			dto = (ImgDTO) list.get(i);
			System.out.println(dto.getNo());
			System.out.println(dto.getPo_no1());
			System.out.println(dto.getPo_no2());
			System.out.println(dto.getPre_no1());
			System.out.println(dto.getPre_no2());
			System.out.println(dto.getFname());
			System.out.println(dto.getPre_fname1());
			System.out.println(dto.getPre_fname2());
			System.out.println(dto.getPo_fname1());
			System.out.println(dto.getPo_fname2());
			System.out.println("-----------");
		}
		
	}

	private static void p(ImgDTO dto) {
		
		System.out.println("num:"+dto.getName());
		System.out.println("subject:"+dto.getTitle());
		System.out.println("regdate:"+dto.getMdate());
		System.out.println("count:"+dto.getFname());
		
		
		
	}

	

	private static void list(ImgDAO dao) {
		Map map = new HashMap();
		int sno = 0;
		int eno = 5;
		map.put("sno", sno);
		map.put("eno", eno);
		//map.put("col", "title");
		//map.put("word", "부모");
		List<ImgDTO> list = new ArrayList<ImgDTO>();
		list = dao.list(map);
		
		for(int i=0;i<list.size();i++) {
			ImgDTO dto =list.get(i);
			
			p(dto);
			System.out.println("--------------------");
		}
		
	}

	private static void delete(ImgDAO dao) {
		int num = 6;
		
		boolean flag2 = false;
		
		
			flag2 = dao.delete(num);
			if(flag2) {
				System.out.println("삭제성공");
			}else {
				System.out.println("삭제실패");
			}
		}
	

	private static void createAns(ImgDAO dao) {
		
		ImgDTO dto = new ImgDTO();
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

	private static void create(ImgDAO dao) {
		boolean flag= false;
		
		
		ImgDTO dto = new ImgDTO();
		
		dto.setName("D");
		dto.setTitle("D");
		dto.setPasswd("D");
		dto.setFname("D.txt");
		
		
		flag = dao.create(dto);
		
		if(flag) {
			System.out.println("등록성공");
		}else {
			System.out.println("등록실패");
		}
		
	}

}
