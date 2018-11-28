package spring.sts.webtest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.model.memo.MemoService;
import spring.model.memo.MemoDAO;
import spring.model.memo.MemoVO;
import spring.utility.webtest.Utility;

@Controller
public class MemoController {
	
	@Autowired
	private MemoService ms;
	
	@Autowired
	private MemoDAO dao;
	
	@RequestMapping(value="/memo/update", method=RequestMethod.POST)
	public String update(Model model,int memono,MemoVO dto,HttpServletRequest request) {
		
		
		boolean flag = dao.update(dto);
		if(flag) {
			model.addAttribute("col", request.getParameter("col"));
			model.addAttribute("word", request.getParameter("word"));
			model.addAttribute("nowPage", request.getParameter("nowPage"));
			return "redirect:/memo/list";
		}else {
			return "/error/error";
		}
		
		
	}
	
	@RequestMapping(value="/memo/update", method=RequestMethod.GET)
	public String update(int memono,HttpServletRequest request) {
		
		MemoVO dto = dao.read(memono);
		
		request.setAttribute("dto", dto);
		
		return "/memo/update";
	}
	
	@RequestMapping(value="/memo/delete",method=RequestMethod.POST)
	public String delete(int memono,Model model, HttpServletRequest request) {
		
		
		
		boolean flag = dao.delete(memono);
		if(flag) {
			
			model.addAttribute("col", request.getParameter("col"));
			model.addAttribute("word", request.getParameter("word"));
			model.addAttribute("nowPage", request.getParameter("nowPage"));
			
			return "redirect:/memo/list";
		}else {
			return "/error/error";
		}
		
	}
	@RequestMapping(value="/memo/delete",method=RequestMethod.GET)
	public String delete(int memono, HttpServletRequest request) {
		
		boolean flag = dao.checkRefnum(memono);
		
		request.setAttribute("flag", flag);
		return "/memo/delete";
	}
	@RequestMapping(value="/memo/reply",method=RequestMethod.POST)
	public String reply(MemoVO dto, Model model,HttpServletRequest request) {
		
		
		boolean flag =ms.reply(dto);
		if(flag) {
			model.addAttribute("col", request.getParameter("col"));
			model.addAttribute("word", request.getParameter("word"));
			model.addAttribute("nowPage", request.getParameter("nowPage"));
			return "redirect:/memo/list";
		}else {
			return "/error/error";
		}
		
	}
	@RequestMapping(value="/memo/reply",method=RequestMethod.GET)
	public String reply(int memono, HttpServletRequest request) {
		
		
		MemoVO dto = dao.replyRead(memono);
		
		request.setAttribute("dto", dto);
		
		return "/memo/reply";
	}
	
	@RequestMapping("/memo/read")
	public String  read(int memono, HttpServletRequest request) {
		
		memono = Integer.parseInt(request.getParameter("memono"));
		String col = request.getParameter("col");
		String word = request.getParameter("word");
		String nowPage = request.getParameter("nowPage");
		
		
		dao.updateViewcnt(memono);
		MemoVO dto = dao.read(memono);
		
		request.setAttribute("memono", memono);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("dto", dto);
		
		return "/memo/read";
	}
	
	@RequestMapping(value = "/memo/create", method=RequestMethod.POST)
	public String create(MemoVO dto) {
		
		
		
		boolean flag = dao.create(dto);
		
		if(flag) {
			return "redirect:/memo/list";
		}else {
			return "/error/error"	;
		}
		
		
	}
	
	@RequestMapping(value = "/memo/create", method=RequestMethod.GET)
	public String create() {
		
		return "/memo/create";
	}
	
	@RequestMapping("/memo/list")
	public String list(HttpServletRequest request) {
		
	//검색관련 처리
			String col = Utility.checkNull(request.getParameter("col"));	//보낸게 없을때는 null로 받아옴
			String word = Utility.checkNull(request.getParameter("word"));
			
			
			if(col.equals("total")){
				word="";
			}
			//paging 관련
			int nowPage = 1; //기본페이지 1페이지로 시작
			int recordPerPage = 5; //한페이지당 보여질 레코드 개수 
			
			if(request.getParameter("nowPage")!=null){
			nowPage = Integer.parseInt(request.getParameter("nowPage")); //null값들어오고 인티저하면 넘버포맷입셋션
			
			}
			
			int sno = ((nowPage-1)*recordPerPage)+1;
			
			int eno = nowPage*recordPerPage;
			
			
			Map map = new HashMap();
			map.put("col",col);
			map.put("word",word);
			map.put("sno",sno);
			map.put("eno",eno);
			
			
			
			List<MemoVO> list = dao.list(map);
			
			int totalRecord = dao.total(map);//전체 레코드 갯수(col,word만 가져간다 검색후의 페이지도 토탈로 읽어야함)
			
			String paging = Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);
			
			
			request.setAttribute("paging", paging);
			request.setAttribute("list", list);
			request.setAttribute("col", col);
			request.setAttribute("word", word);
			request.setAttribute("nowPage", nowPage);
		
		return "/memo/list";
	}
}
