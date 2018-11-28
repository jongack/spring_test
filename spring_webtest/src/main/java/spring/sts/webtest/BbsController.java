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

import spring.model.bbs.BbsDAO;
import spring.model.bbs.BbsDTO;
import spring.model.bbs.BbsService;
import spring.model.bbs.ReplyDAO;
import spring.model.bbs.ReplyDTO;
import spring.utility.webtest.Utility;






@Controller
public class BbsController {
	
	@Autowired
	private BbsDAO dao;
	
	@Autowired
	private BbsService mgr;
	
	@Autowired
	private ReplyDAO rdao;
	
	
	
	@RequestMapping("/bbs/rcreate")
	public String rcreate(ReplyDTO dto,Model model,
			String nowPage, String col, String word) {
		
		if(rdao.create(dto)) {
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("bbsno", dto.getBbsno());
			
			return "redirect:/bbs/read";
		}else {
			return "/error/error";
		}
		
	}
	@RequestMapping("/bbs/rdelete")
	public String rdelete(int rnum,int bbsno, int nowPage,int nPage, String col, String word,Model model){ 
	 
	int total = rdao.total(bbsno);//댓글전체레코드값을 가져와서
	int totalPage = (int)(Math.ceil((double)total/3)); // 전체 페이지  
	if(rdao.delete(rnum)){
	if(nPage!=1&&nPage==totalPage&&total%3==1){//마지막페이지의 마지막레코드이면(3은 한페이지당보여줄 레코드 갯수)
	nPage=nPage-1;  //현재의 페이지값에서 1을 빼자 
	}
	model.addAttribute("bbsno", bbsno);
	model.addAttribute("nowPage", nowPage);
	model.addAttribute("nPage", nPage);
	model.addAttribute("col", col);
	model.addAttribute("word", word);
	 
	}else{
	return "error/error";
	}
	 
	return "redirect:./read";
	}
	 
	@RequestMapping("/bbs/rupdate")
	public String rupdate(ReplyDTO dto,int nowPage,int nPage, String col, String word,Model model){
	if(rdao.update(dto)){
	model.addAttribute("bbsno", dto.getBbsno());
	model.addAttribute("nowPage", nowPage);
	model.addAttribute("nPage", nPage);
	model.addAttribute("col", col);
	model.addAttribute("word", word);
	}else{
	return "error/error";
	}
	 
	return "redirect:./read";
	}
	
	
	@RequestMapping(value="/bbs/delete", method=RequestMethod.POST)
	public String delete(int bbsno,String passwd,String oldfile,HttpServletRequest request
			,Model model) {
		
		Map map = new HashMap();
		map.put("bbsno", bbsno);
		map.put("passwd",passwd);
		
		
		boolean pflag = dao.passCheck(map);
		boolean flag = false;
		String str = "redirect:/bbs/list";
		
		String upDir = request.getRealPath("/bbs/storage");
		
		if(pflag){
			try {
			 mgr.delete(bbsno);
			 model.addAttribute("nowPage", request.getParameter("nowPage"));
			 model.addAttribute("col", request.getParameter("col"));
			 model.addAttribute("word", request.getParameter("word"));
			 Utility.deleteFile(upDir, oldfile);
			 return str;
			}catch(Exception e) {
				e.printStackTrace();
				return "/error/error";
			}
			
		}else {
			 return "/error/passwdError";
		}

		
	}
	@RequestMapping(value="/bbs/delete", method=RequestMethod.GET)
	public String delete(int bbsno,HttpServletRequest request) {
		
		boolean flag = dao.checkRefnum(bbsno);
		
		request.setAttribute("flag", flag);
		
		return "/bbs/delete";
	}
	
	@RequestMapping(value="/bbs/reply", method=RequestMethod.POST)
	public String reply(BbsDTO dto,  HttpServletRequest request) {
		
		String upDir = request.getRealPath("/bbs/storage");
		
		int filesize = (int)dto.getFilenameMF().getSize()	;
		
		String filename = "";
		
		if(filesize>0){
			filename = Utility.saveFileSpring(dto.getFilenameMF(), upDir);
		}
		dto.setFilename(filename);
		dto.setFilesize(filesize);
		
		try {
				mgr.reply(dto);
				
			
				return "redirect:/bbs/list";
		}catch(Exception e){
			e.printStackTrace();
			
			Utility.deleteFile(upDir, filename);
			
			return "/error/error";
			
		}
		
		}
		
		
	
	@RequestMapping(value="/bbs/reply", method=RequestMethod.GET)
	public String reply(int bbsno, Model model) {
		BbsDTO dto = dao.replyRead(bbsno);
		
		model.addAttribute("dto", dto);
		
		return "/bbs/reply";
	}
	
	
	@RequestMapping(value="/bbs/update", method=RequestMethod.POST)
	public String update(BbsDTO dto,String oldfile, HttpServletRequest request,Model model) {
		
		boolean flag = dao.update(dto);
		
		String upDir = request.getRealPath("/bbs/storage");
		
		Map map = new HashMap();
		map.put("bbsno",dto.getBbsno());
		map.put("passwd",dto.getPasswd());
		
		
		
		boolean pflag= dao.passCheck(map);
		
		if(pflag){
			
			int filesize = (int)dto.getFilenameMF().getSize();
			String filename = "";
			if(filesize>0){
				if(oldfile!=null){
					Utility.deleteFile(upDir, oldfile);
				}
				filename = Utility.saveFileSpring(dto.getFilenameMF(), upDir);
			}
			dto.setFilename(filename);
			dto.setFilesize(filesize);
			flag = dao.update(dto);
			
		}
		
		if(pflag && flag) {
			model.addAttribute("nowPage", request.getParameter("nowPage"));
			model.addAttribute("col", request.getParameter("col"));
			model.addAttribute("word", request.getParameter("word"));
			return "redirect:/bbs/list";
		}else if(!pflag) {
			return "/error/passwdError";
		}else {
			return "/error/error"	;
		}
		
	}
	@RequestMapping(value="/bbs/update", method=RequestMethod.GET)
	public String update(int bbsno, Model model) {
		
		BbsDTO dto = dao.read(bbsno);
		
		model.addAttribute("dto",dto);
		
		return "/bbs/update";
	}
	
	@RequestMapping("/bbs/read") //겟이던 포스트던 상고ㅓㅏㄴ없을때
	public String read(int nowPage, String col, String word,HttpServletRequest request,int bbsno,Model model) {

		dao.upViewcnt(bbsno);	
		BbsDTO dto = dao.read(bbsno);
		
		String content = dto.getContent();
		content = content.replaceAll("\r\n","<br>");
		
		dto.setContent(content);
		
		model.addAttribute("dto",dto);
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
		map.put("bbsno", bbsno);
		 
		List<ReplyDTO> list = rdao.list(map);
		 
		int total = rdao.total(bbsno);
		 
		String paging = Utility.paging(total, nPage, recordPerPage, url,bbsno,nowPage, col,word);
		 
		model.addAttribute("rlist",list);
		model.addAttribute("paging",paging);
		model.addAttribute("nPage",nPage);
		 
		/* 댓글 관련 끝 */ 

		return "/bbs/read";
	}
	
	@RequestMapping(value="/bbs/create", method=RequestMethod.POST)
	public String create(BbsDTO dto, HttpServletRequest request) {
		
		String upDir = request.getRealPath("/bbs/storage");
		
		int filesize = (int)dto.getFilenameMF().getSize();
		String filename ="";
		if(filesize>0) {
			filename =Utility.saveFileSpring(dto.getFilenameMF(),upDir);
		}
		dto.setFilename(filename);
		dto.setFilesize(filesize);
		
		
		boolean flag = dao.create(dto);
		
		
		
		if(flag) {
			return "redirect:/bbs/list";
		}else {
			if(!filename.equals("")) {
				Utility.deleteFile(upDir, filename);
			}
			return "/error/error"	;
		}
	
			
	}
	@RequestMapping(value="/bbs/create", method=RequestMethod.GET)
	public String create() {
		return "/bbs/create";
	}
	
	@RequestMapping("/bbs/list")
	public String list(HttpServletRequest request, Model model) {
		//검색관련 처리
		   String col = Utility.checkNull(request.getParameter("col"));
		   String word = Utility.checkNull(request.getParameter("word"));

		   if(col.equals("total")) word= "";
		   
		   //paging관련
		   int nowPage = 1;
		   int recordPerPage = 5;
		   
		   if(request.getParameter("nowPage")!=null){
		   	   nowPage = Integer.parseInt(request.getParameter("nowPage"));
		   }
		   
		   //DB에서 가져올 레코드의 순번
		   int sno = ((nowPage-1)*recordPerPage) + 1;
		   int eno = nowPage * recordPerPage;
		   
		   Map map = new HashMap();
		   map.put("col", col);
		   map.put("word", word);
		   map.put("sno", sno);
		   map.put("eno", eno);
		   		   
		   List<BbsDTO> list = dao.list(map);
		   //전체레코드 갯수(col,word)
		   int totalRecord = dao.total(map);
		   
		   String paging= Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);
		   
		   
		   model.addAttribute("list", list);
		   model.addAttribute("paging", paging);
		   model.addAttribute("nowPage", nowPage);
		   model.addAttribute("col", col);
		   model.addAttribute("word", word);
		   model.addAttribute("rdao", rdao);
		
		   return "/bbs/list";
	}

}
