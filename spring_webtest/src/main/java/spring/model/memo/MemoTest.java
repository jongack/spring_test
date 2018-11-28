package spring.model.memo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class MemoTest {

	
	
	public static void main(String[] args) {
		
		Resource resource = new ClassPathResource("daoTest.xml");
		//org.springframework.core.io import
		
		BeanFactory factory = new XmlBeanFactory(resource);
		
		MemoDAO dao = (MemoDAO)factory.getBean("memo");
		//create(dao);
		//createAns(dao);
		delete(dao);
		//list(dao);
		
		//read(dao);
		//readAns(dao);
		//refnumCheck(dao);
		//total(dao);
		//update(dao);
		//updateAnsnum(dao);
		//updateCount(dao);

	}

	private static void updateCount(MemoDAO dao) {
		int num =801;
		boolean flag = dao.updateViewcnt(num);
		
		if(flag) {
			System.out.println("조회수 증가성공");
		}else {
			System.out.println("조회수 증가 실패");
		}
		
	}

	private static void updateAnsnum(MemoDAO dao) {
		int num = 1;
		MemoVO dto = dao.read(num);
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

	private static void update(MemoDAO dao) {
	
		MemoVO dto = dao.read(801);
		
		dto.setTitle("zzz");
		dto.setContent("zzz");
		//dto.setFilename("tnwjd.txt");
		
		
		boolean flag = false;
				flag=dao.update(dto);
				if(flag) {
					System.out.println("정보수정성공");
				}else {
					System.out.println("정보 수정 실패");
				}
	}

	private static void total(MemoDAO dao) {
		Map map = new HashMap();
		String col = "title";
		String word = "부모";
		map.put("col", col);
		map.put("word",word);
		int total = dao.total(map);
		
		System.out.println("총레코드수:"+total);
		
	}

	private static void refnumCheck(MemoDAO dao) {
		boolean flag = false;
		int num = 801;
		flag=dao.checkRefnum(num);
		if(flag) {
			System.out.println("답변이 있습니다");
		}else {
			System.out.println("답변이 없습니다");
		}
		
	}

	private static void readAns(MemoDAO dao) {
		int Memono =801;
		MemoVO dto= dao.replyRead(Memono);
		p(dto);
		
	}

	private static void read(MemoDAO dao) {
		int num = 801;
		
		MemoVO dto = dao.read(num);
		p(dto);
	}

	private static void p(MemoVO dto) {
		
		System.out.println("num:"+dto.getMemono());
		System.out.println("subject:"+dto.getTitle());
		System.out.println("regdate:"+dto.getWdate());
		System.out.println("count:"+dto.getViewcnt());
		System.out.println("indent:"+dto.getIndent());
		System.out.println("ansnum:"+dto.getAnsnum());
		
		
	}

	

	private static void list(MemoDAO dao) {
		Map map = new HashMap();
		int sno = 0;
		int eno = 5;
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("col", "title");
		map.put("word", "부모");
		List<MemoVO> list = new ArrayList<MemoVO>();
		list = dao.list(map);
		
		for(int i=0;i<list.size();i++) {
			MemoVO dto =list.get(i);
			
			System.out.println("name:"+dto.getTitle());
			System.out.println("Memonum:"+dto.getMemono());
			System.out.println("subject:"+dto.getContent());
			System.out.println("regdate:"+dto.getWdate());
			System.out.println("count:"+dto.getViewcnt());
			System.out.println("indent:"+dto.getIndent());
			System.out.println("--------------------");
		}
		
	}

	private static void delete(MemoDAO dao) {
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

	private static void createAns(MemoDAO dao) {
		
		MemoVO dto = new MemoVO();
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

	private static void create(MemoDAO dao) {
		boolean flag= false;
		
		
		MemoVO dto = new MemoVO();
		
		dto.setTitle("dkdk");
		dto.setContent("dkdkdk");
		
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
