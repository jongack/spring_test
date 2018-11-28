package spring.sts.webtest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.model.image.ImgDAO;
import spring.model.image.ImgDTO;
import spring.utility.webtest.Utility;



@Controller
public class ImageController {
	
	@Autowired
	private ImgDAO dao;
	
	
	
	@RequestMapping(value="/img/update",method=RequestMethod.POST)
	public String update(String oldfile,ImgDTO dto,int no,String passwd, HttpServletRequest request) {
		

		String upDir = request.getRealPath("/img/storage");
		
	
		Map map = new HashMap();
		map.put("no", no); 
		map.put("passwd",passwd );
	 	
		
		 
		boolean pflag = dao.passCheck(map);
		boolean flag2 = false;
		if(pflag==true){
			
			String fname =null;
			System.out.println(dto.getFnameMF().getSize());
		 	if(dto.getFnameMF().getSize()>0){
		 		if(oldfile!=null) {
		 			Utility.deleteFile(upDir, oldfile);	
		 			
		 		}
		 		fname = Utility.saveFileSpring(dto.getFnameMF(), upDir);
		 		dto.setFname(fname);
		 	}
		 		
		 		  
		 		flag2= dao.update(dto);
		 	 	 
		}
		if(pflag && flag2) {
			
			request.setAttribute("col", request.getParameter("col"));
			request.setAttribute("word", request.getParameter("word"));
			request.setAttribute("nowPage", request.getParameter("nowPage"));
			return "redirect:/img/list";
			
		}else if(!pflag) {
			return "/error/passwdError";
		}else {
			return "/error/error";
		}
		
	}
	
		@RequestMapping(value="/img/update",method=RequestMethod.GET)
	public String update(int no, HttpServletRequest request) {

		
		ImgDTO dto = dao.read(no); 
		
		request.setAttribute("dto", dto);
		
		return "/img/update";
	}
	@RequestMapping(value="/img/delete",method=RequestMethod.POST)
	public String delete(HttpServletRequest request,int no,String passwd) {
		
		String upDir = request.getRealPath("/img/storage");
		
	
		
		String col = request.getParameter("col");
		String nowPage = request.getParameter("nowPage");
		String word = request.getParameter("word");
		
		
		ImgDTO dto = dao.read(no);
		String filename = dto.getFname();
		
		Map map = new HashMap();
		map.put("no", no);
		map.put("passwd", passwd);
		
		
		
		boolean pflag = dao.passCheck(map);
		
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);
		boolean flag =false;
		if(pflag) {
			flag = dao.delete(no);
			
			if(flag) {
				Utility.deleteFile(upDir, filename);
				return "redirect:/img/list";
			}else {
				return "/error/error";
			}
		}else {
			return "/error/passwdError";
		}
		
		
	}
	@RequestMapping(value ="/img/delete",method=RequestMethod.GET)
	public String delete() {
		
		return "/img/delete";
	}
	@RequestMapping("/img/read")
	public String read(int no, HttpServletRequest request){
	 	
		
		ImgDTO dto2 = dao.read(no);
	 	
	 	List<ImgDTO> list = dao.Imgread(no);
	 	
		
	 	ImgDTO	dto = list.get(0);
			int [] no1 = {
					dto.getPre_no2(),
					dto.getPre_no1(),
					dto.getNo(),
					dto.getPo_no1(),
					dto.getPo_no2()
					
			};
			String[] fname1 = {
					dto.getPre_fname2(),
				dto.getPre_fname1(),
				dto.getFname(),
				dto.getPo_fname1(),
				dto.getPo_fname2()
				
			};
		
	 	/*int[] no1 = (int[])list.get(0);
	 	
	 	String[] fname1 = (String[])list.get(1);*/
	 	
		request.setAttribute("dto", dto2);
	 	request.setAttribute("list", list);
	 	request.setAttribute("no1", no1);
	 	request.setAttribute("fname1", fname1);
	 	
		return "/img/read";
	}
	@RequestMapping("/img/list")
	public String list(HttpServletRequest request) {


		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		
		if(col.equals("total")){
			word="";
		}
		int nowPage = 1;
		if(request.getParameter("nowPage")!=null){
			nowPage= Integer.parseInt(request.getParameter("nowPage"));
		}
		int recordPerPage = 5;
		int sno = ((nowPage-1)*recordPerPage)+1;
		int eno = nowPage*recordPerPage;
		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno",eno);
		
		int totalRecord = dao.total(map);
		List<ImgDTO> list = dao.list(map);
		
		String paging = Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);
		
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("list", list);
		request.setAttribute("paging", paging);
		request.setAttribute("nowPage", nowPage);
		
		return "/img/list";
	}
	
	@RequestMapping(value="/img/create",method=RequestMethod.POST)
	public String create(HttpServletRequest request,ImgDTO dto) {
		
		
		String upDir = request.getRealPath("/img/storage");
		
		
	
	 	int size= (int)dto.getFnameMF().getSize();
	 	String fname= null;
	 	if(size>0){
	 		fname=Utility.saveFileSpring(dto.getFnameMF(), upDir);
	 	}else{
	 		fname="member.jpg";
	 	}
	 	dto.setFname(fname);
	 	
	 	boolean flag= dao.create(dto);
		
	 	if(flag) {
	 		return "redirect:/img/list";
	 	}else {
	 		return "/error/error";
	 	}
	}
	@RequestMapping(value="/img/create",method=RequestMethod.GET)
	public String create() {
		
		return "/img/create";
	}
}
