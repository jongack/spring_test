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


import spring.model.team.TeamDAO;
import spring.model.team.TeamDTO;
import spring.model.team.TeamService;
import spring.utility.webtest.Utility;

@Controller
public class TeamController {
	
	@Autowired
	private TeamDAO dao;
	
	@Autowired
	private TeamService ts;
	
	@RequestMapping("/team/delete")
	public String delete(int no,Model model, HttpServletRequest request) {
		
		boolean dflag = dao.checkRefnum(no);
		
		boolean flag = false;
		
		if(dflag==false){
		flag = dao.delete(no);
		}
		/*if(flag) {
			model.addAttribute("col", request.getParameter("col"));
			model.addAttribute("word", request.getParameter("word"));
			model.addAttribute("nowPage", request.getParameter("nowPage"));
			
			return "redirect:/team/list";
		}else {
			return "/error/error";
		}*/
		request.setAttribute("flag", flag);
		request.setAttribute("dflag", dflag);
		
		return "/team/delete";
	}
	@RequestMapping(value="/team/update", method=RequestMethod.POST)
	public String update(int no,TeamDTO dto,Model model, HttpServletRequest request) {
		
		
		boolean flag = dao.update(dto);
		if(flag) {
			
			model.addAttribute("col", request.getParameter("col"));
			model.addAttribute("word", request.getParameter("word"));
			model.addAttribute("nowPage", request.getParameter("nowPage"));
			
			return "redirect:/team/list"	;
		}else {
			return "/error/error";
		}
		
	}
	
	@RequestMapping(value="/team/update", method=RequestMethod.GET)
	public String update(int no, HttpServletRequest request) {
		
		
		TeamDTO dto = dao.read(no);
		
		request.setAttribute("dto", dto);
		
		return "/team/update"	;
	}
	
	@RequestMapping(value="/team/reply",method=RequestMethod.POST)
	public String reply(int no,Model model, TeamDTO dto,HttpServletRequest request) {
		
		
		
		Map map = new HashMap();
		map.put("grpno", dto.getGrpno());
		map.put("ansnum",dto.getAnsnum());
		
		boolean flag = ts.reply(dto);
		
		if(flag) {
			
			model.addAttribute("col", request.getParameter("col"));
			model.addAttribute("word", request.getParameter("word"));
			model.addAttribute("nowPage", request.getParameter("nowPage"));
			
			return "redirect:/team/list";
		}else {
			return "/error/error";
		}
		
		
	}
	@RequestMapping(value="/team/reply",method=RequestMethod.GET)
	public String reply(int no, HttpServletRequest request) {
		
		
	 	TeamDTO dto = dao.replyRead(no);
	 	
	 	request.setAttribute("dto", dto);
		
		return "/team/reply";
	}
	
	@RequestMapping("/team/read")
	public String read(int no, HttpServletRequest request) {
		
		TeamDTO dto = dao.read(no);
		
		request.setAttribute("dto", dto);
		
		return "/team/read"	;
	}
	
	@RequestMapping("/team/list")
	public String list(HttpServletRequest request,Model model) {
		
		//검색관련
		String col = Utility.checkNull(request.getParameter("col"));
		String word=Utility.checkNull(request.getParameter("word"));
		
		String col2 = Utility.checkNull(request.getParameter("col2"));
		String word2 = Utility.checkNull(request.getParameter("word2"));
		
		String[] bCol ={col,col2};
		String[] bWord ={word,word2};
		
		
		if(col.equals("total")){
			word=""	;
		}
			
		//페이징 관련
		int nowPage = 1;
		int recordPerPage=5;
		
		if(request.getParameter("nowPage")!=null){
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		
		//db에서 가져올 시작번호 끝번호
		int sno=((nowPage-1) *recordPerPage)+1;
		int eno= nowPage*recordPerPage;
		Map map = new HashMap();
		map.put("col", bCol[0]);
		map.put("word",bWord[0]);
		map.put("col2",bCol[1]);
		map.put("word2",bWord[1]);
		map.put("sno",sno);
		map.put("eno", eno);
		
		
		
		List<TeamDTO> list = dao.list(map);
		int totalRecord = dao.total(map);
		
		String paging = Utility.paging3(totalRecord, nowPage, recordPerPage, col2, word2);
		
		request.setAttribute("list", list);
		request.setAttribute("paging", paging);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("col2", col2);
		request.setAttribute("word2", word2);
		request.setAttribute("nowPage", nowPage);
		
		return "/team/list";
	}
	
	@RequestMapping(value="/team/create",method=RequestMethod.POST)
	public String create(TeamDTO dto, HttpServletRequest request) {
		
		boolean flag=dao.create(dto);
		
		if(flag) {
			return "redirect:/team/list";
		}else {
			return "/error/error";
		}
		
	}
	
	@RequestMapping(value="/team/create",method=RequestMethod.GET)
	public String create() {
				
		return "/team/create";
	}
	
}
