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

import spring.model.board.BoardDAO;
import spring.model.board.BoardDTO;
import spring.model.board.BoardMgr;
import spring.model.board.BoardReDAO;
import spring.model.board.BoardReDTO;
import spring.utility.webtest.Utility;



@Controller
public class BoardController {
	
	@Autowired
	private BoardDAO dao;
	
	@Autowired
	private BoardMgr mgr;
	
	@Autowired
	private BoardReDAO bdao;
	
	@RequestMapping("/board/rcreate")
	public String rcreate(BoardReDTO dto,Model model,
			String nowPage, String col, String word) {
		
		if(bdao.create(dto)) {
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("num", dto.getNum());
			
			return "redirect:/board/read";
		}else {
			return "/error/error";
		}
		
	}
	@RequestMapping("/board/rdelete")
	public String rdelete(int rnum,int num, int nowPage,int nPage, String col, String word,Model model){ 
	 
	int total = bdao.total(num);//댓글전체레코드값을 가져와서
	int totalPage = (int)(Math.ceil((double)total/3)); // 전체 페이지  
	if(bdao.delete(rnum)){
	if(nPage!=1&&nPage==totalPage&&total%3==1){//마지막페이지의 마지막레코드이면(3은 한페이지당보여줄 레코드 갯수)
	nPage=nPage-1;  //현재의 페이지값에서 1을 빼자 
	}
	model.addAttribute("num", num);
	model.addAttribute("nowPage", nowPage);
	model.addAttribute("nPage", nPage);
	model.addAttribute("col", col);
	model.addAttribute("word", word);
	 
	}else{
	return "/error/error";
	}
	 
	return "redirect:./read";
	}
	 
	@RequestMapping("/board/rupdate")
	public String rupdate(BoardReDTO dto,int nowPage,int nPage, String col, String word,Model model){
	if(bdao.update(dto)){
	model.addAttribute("num", dto.getNum());
	model.addAttribute("nowPage", nowPage);
	model.addAttribute("nPage", nPage);
	model.addAttribute("col", col);
	model.addAttribute("word", word);
	}else{
	return "/error/error";
	}
	 
	return "redirect:./read";
	}
	
	@RequestMapping(value="/board/delete", method=RequestMethod.POST)
	public String delete(String passwd, int num, String oldfile, HttpServletRequest request,Model model) {
		
		Map map = new HashMap();
		map.put("passwd", passwd);
		map.put("num", num);
		
		boolean pflag = dao.passwdCheck(map);
		
		boolean flag = false;
		String basePath = request.getRealPath("/storage");
		
		if(pflag) {
		
				flag = dao.delete(num);
				if(flag) {
					Utility.deleteFile(basePath, oldfile);
					model.addAttribute("col", request.getParameter("col"));
					model.addAttribute("word", request.getParameter("word"));
					model.addAttribute("nowPage", request.getParameter("nowPage"));
					
					return "redirect:/board/list";
					
				}else {
					return "/error/error";
				}
			
		}else {
			return "/error/passwdError";
		}
		
		
		
	}
	@RequestMapping(value="/board/delete", method=RequestMethod.GET)
	public String delete(int num, Model model) {
		
		boolean flag = dao.checkRefnum(num);
		
		model.addAttribute("flag", flag);
		
		return "/board/delete";
		
	}
	
	@RequestMapping(value="/board/reply",method=RequestMethod.POST)
	public String reply(BoardDTO dto, Model model, HttpServletRequest request) {
		
		String basePath = request.getRealPath("/storage");
		
		dto.setFilename(Utility.saveFileSpring(dto.getFilenameMF(), basePath));
		dto.setFilesize((int)dto.getFilenameMF().getSize());
		dto.setIp(request.getRemoteAddr());
		
		boolean flag = mgr.reply(dto);
		
		if(flag) {
			model.addAttribute("col", request.getParameter("col"));
			model.addAttribute("word", request.getParameter("word"));
			model.addAttribute("nowPage", request.getParameter("nowPage"));
			return "redirect:/board/list";
		}else {
			return "/error/error";
		}
		
		
	}
	
	@RequestMapping(value="/board/reply",method=RequestMethod.GET)
	public String reply(int num, Model model) {
		
		BoardDTO dto = dao.readReply(num);
		
		model.addAttribute("dto",dto);
		
		return "/board/reply";
	}
	
	@RequestMapping(value="/board/update", method=RequestMethod.POST)
	public String update(BoardDTO dto, HttpServletRequest request, 
			String oldfile, Model model) {
		String basePath = request.getRealPath("/storage");
		
		dto.setFilename(Utility.saveFileSpring(dto.getFilenameMF(), basePath));
		dto.setFilesize((int)dto.getFilenameMF().getSize());
		
		Map map = new HashMap();
		map.put("num", dto.getNum());
		map.put("passwd", dto.getPasswd());
		
		boolean pflag = dao.passwdCheck(map);
		boolean flag = false;
		
		if(pflag) {
			flag = dao.update(dto);
		}
		
		String str = null;		
		if(pflag) {
			if(flag) {
				if(dto.getFilesize()>0) {
					Utility.deleteFile(basePath, oldfile);	
				}			
				model.addAttribute("col", request.getParameter("col"));
				model.addAttribute("word", request.getParameter("word"));
				model.addAttribute("nowPage", request.getParameter("nowPage"));
				str = "redirect:/board/list";
			}else {
				if(dto.getFilesize()>0) {
					Utility.deleteFile(basePath, dto.getFilename());	
				}				
				str = "/error/error";
			}
		}else {
			if(dto.getFilesize()>0) {
				Utility.deleteFile(basePath, dto.getFilename());	
			}			
			str = "/error/passwdError";
		}						
		return str;		
	}
	@RequestMapping(value="/board/update", method=RequestMethod.GET)
	public String update(int num, Model model) {
		
		BoardDTO dto = dao.read(num);
		
		model.addAttribute("dto", dto);
		
		return "/board/update";
	}
	
	@RequestMapping("/board/read")
	public String read(int nowPage, String col, String word,HttpServletRequest request,int num,Model model) {
		dao.upCount(num);
		BoardDTO dto = dao.read(num);
		
		model.addAttribute("dto", dto);
		model.addAttribute("content", dto.getContent().replaceAll("\r\n", "<br>"));
		/* 댓글 관련  시작 */
		String url = "read";
		int nPage= 1; //시작 페이지 번호는 1부터 
		 
		if (request.getParameter("nPage") != null) { 
		nPage= Integer.parseInt(request.getParameter("nPage"));  
		}
		int recordPerPage = 3; // 한페이지당 출력할 레코드 갯수
		 
		int sno = ((nPage-1) * recordPerPage) + 1; // 
		int eno = nPage * recordPerPage;
		 
		Map map = new HashMap();
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("num", num);
		 
		List<BoardReDTO> list = bdao.list(map);
		 
		int total = bdao.total(num);
		 
		String rpaging = Utility.rpaging(total, nPage, recordPerPage, url,num,n
				.0owPage, col,word);
		 
		model.addAttribute("rlist",list);
		model.addAttribute("rpaging",rpaging);
		model.addAttribute("nPage",nPage);
		 
		/* 댓글 관련 끝 */ 
		
		return "/board/read";
	}
	
	@RequestMapping(value="/board/create", method=RequestMethod.POST)
	public String create(BoardDTO dto, HttpServletRequest request) {
		String upDir = request.getRealPath("/storage");
		
		dto.setFilename(Utility.saveFileSpring(dto.getFilenameMF(), upDir));
		dto.setFilesize((int)dto.getFilenameMF().getSize());
		dto.setIp(request.getRemoteAddr());
		
		boolean flag = dao.create(dto);
		
		
		if(flag) {
			return "redirect:/board/list";
		}else {
			return "/error/error";
		}
		
	}
	@RequestMapping(value="/board/create", method=RequestMethod.GET)
	public String create() {
		
		return "/board/create";
	}
	
	@RequestMapping("/board/list")
	public String list(HttpServletRequest request, Model model) {
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		if(col.equals("total")) word="";
		
		int nowPage = 1;
		int recordPerPage = 5;
		
		if(request.getParameter("nowPage")!=null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		
		int sno = ((nowPage -1) * recordPerPage) +1;
		int eno = nowPage * recordPerPage;
		
		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);
			
		//1. model 사용
		List<BoardDTO> list = dao.getList(map);
		int total = dao.getTotal(map);
		String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);
		//2. request 저장
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("col", col);
		model.addAttribute("word", word);
		model.addAttribute("nowPage", nowPage);
		
		return "/board/list";
	}

}
