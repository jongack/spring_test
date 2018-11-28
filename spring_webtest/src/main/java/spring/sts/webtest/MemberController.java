package spring.sts.webtest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import spring.model.member.MemberDAO;
import spring.model.member.MemberDTO;
import spring.utility.webtest.Utility;





@Controller
public class MemberController {
	
	@Autowired
	private MemberDAO dao ;
	
	
	@RequestMapping(value="/member/updateFile",method=RequestMethod.POST)
	public String updateFile(HttpServletRequest request,String id,
			String oldfile, MultipartFile fnameMF,Model model) {
		
		String upDir = request.getRealPath("/member/storage");
		
	
		
		String fname = null;
		
		if(fnameMF.getSize()>0){
			if(oldfile!=null && !oldfile.equals("member.jpg")) {
				//old file 이 null이면 .equals 에서 nullpointexception때문에 먼저 낫null이면 조건사용
			Utility.deleteFile(upDir, oldfile);//oldfile지우기
			}
			fname=Utility.saveFileSpring(fnameMF, upDir);
		}
		Map map = new HashMap();
		map.put("id", id);
		map.put("fname", fname);
		
		
		boolean flag = dao.updateFile(map);
		
		if(flag) {
			/*MemberDTO dto = dao.read(id);
			model.addAttribute("dto",dto);*/
			model.addAttribute("id", id);
			return "redirect:/member/read";
		}else {
			return "/error/error";
		}
		
	}
	@RequestMapping(value="/member/updateFile",method=RequestMethod.GET)
	public String updateFile() {
		
		return "/member/updateFile";
	}
	
	
	@RequestMapping("/member/emailProc")
	public String emailProc(String email) {
		
		return "/member/email_form";
	}
	
	@RequestMapping(value ="/member/update", method = RequestMethod.POST)
	public String update(MemberDTO dto,Model model ) {
		
		boolean flag = dao.update(dto);
		
		if(flag) {
			/*MemberDTO dto2 = dao.read(dto.getId());
			model.addAttribute("dto",dto2);*/
			model.addAttribute("id", dto.getId());
			return "redirect:/member/read";
		}else {
			return "/error/error";
		}
		
		
		
	}
	@RequestMapping(value ="/member/update", method = RequestMethod.GET)
	public String update(String id, HttpServletRequest request) {
		
		MemberDTO dto = dao.read(id);
		
		request.setAttribute("dto", dto);
		
		return "/member/update";
				
	}
	
	
	@RequestMapping(value ="/member/delete",method=RequestMethod.POST)
	public String delete(String id, HttpServletRequest request,
			HttpSession session,Model model) {
		
		String upDir = request.getRealPath("/member/storage");
		
		
		String sid = (String)session.getAttribute("id");
		String grade = (String)session.getAttribute("grade");
		String oldfile = dao.getFname(id);

		boolean flag = false;
		 flag = dao.delete(id);
		if(flag){
			if(oldfile!=null && !oldfile.equals("member.jpg")) {
			Utility.deleteFile(upDir, oldfile);
			}
			if(sid!=null && !grade.equals("A")) {
			request.getSession().invalidate();
			return "redirect:/";
			}else {
				model.addAttribute("col",request.getParameter("col"));
				model.addAttribute("word",request.getParameter("word"));
				model.addAttribute("nowPage",request.getParameter("nowPage"));
			
				return "redirect:/admin/list";
			}
		}else{
			return "/error/error";
		}
			
		
		
	}
	@RequestMapping(value ="/member/delete",method=RequestMethod.GET)
	public String delete(String id, HttpServletRequest request) {

		if(id== null) {
			id=(String)request.getSession().getAttribute("id");
		}
		
		request.setAttribute("id", id);
		
		return "/member/delete";
		
	}
	@RequestMapping(value = "/member/updatePw", method=RequestMethod.POST)
	public String UpdatePw(String id, String oldPasswd, String passwd,HttpServletRequest request) {
		
	
	
		String str ="";
		Map map = new HashMap();
		map.put("id", id);
		map.put("passwd", passwd);
		map.put("oldpasswd",oldPasswd);
		
		System.out.println(id);
		System.out.println(passwd);
		System.out.println(oldPasswd);
		
		boolean flag = false;
		boolean pflag = dao.duplicatePw(map);
		
		 if(!pflag){
			str="기존 비밀번호가 잘못입력되었습니다 다시 입력해주세요";
			return "/error/passwdError";
		}else{ 
			flag=	dao.updatePw(map); 
			if(flag){
				return "redirect:/member/read";
			}else{
				return "/error/error";
			}
		
		}
		 	
	}
	
	@RequestMapping("/member/idpwfind")
	public String idpwfind() {
		
				
		return "/member/idpwfind";
	}
	
	@RequestMapping(value = "/member/updatePw", method=RequestMethod.GET)
	public String UpdatePw() {
		
		return "/member/updatePw";
	}
	
	@ResponseBody  //비동기 통신이라 viewresolver 사용안하고 요청한 곳으로 리턴이 가는기능
	@RequestMapping(value="/member/pwfind",method=RequestMethod.GET, 
	produces="text/plain; charset=utf-8")
	public String PasswdFind(@RequestParam Map<String, String> map) {
		
		
		String passwd = dao.findPw(map);
		String str = null;
		
		if(passwd!=null){
			str = "비밀번호는"+passwd+"입니다";
		}else{
			str = "잘못된 정보를 입력하셧습니다";
		}
		
		return str;
		
	}
	@ResponseBody  //비동기 통신이라 viewresolver 사용안하고 요청한 곳으로 리턴이 가는기능
	@RequestMapping(value="/member/idfind",method=RequestMethod.GET, 
	produces="text/plain; charset=utf-8")
	public String IdFind(String mname, String email) {
		
		
		Map map = new HashMap();
		map.put("mname", mname);
		map.put("email",email);
		
		
		String str = null;
		String id = dao.findId(map);
		if(id!=null){
			str = "id는"+id+"입니다";
			
		}else{
			str = "잘못된 정보를 입력하셨습니다.";
		}
		
		return str;
		
	}
	
	
	@RequestMapping("/member/read")
	public String read(String id, HttpSession session, Model model) {
		
		
		if(id==null){
			id=(String)session.getAttribute("id"); //홈 화면에서 마이인포눌렀을때
		}
		
		MemberDTO dto = dao.read(id);
		
		model.addAttribute("dto", dto);
		
		
		return "/member/read";
	}
	
	@RequestMapping("/member/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/member/login",method=RequestMethod.POST)
	public String login(@RequestParam Map<String,String> map,HttpServletResponse response,
			String c_id,HttpSession session,HttpServletRequest request, Model model) {
	
	
		
		String id = (String)map.get("id");
		
		
		boolean flag = false;
	
		flag=dao.loginCheck(map);
		String url = "/error/passwdError";
		
		if(flag){
			String grade = dao.getGrade(id);
			session.setAttribute("id", id);
			session.setAttribute("grade", grade);
			
			  // ---------------------------------------------- 
		    // Cookie 저장, Checkbox는 선택하지 않으면 null 임 
		    // ---------------------------------------------- 
		    Cookie cookie = null; 
		       
		    	// Y, 아이디 저장 여부 
		       
		    if (c_id != null){  // 처음에는 값이 없음으로 null 체크로 처리
		      cookie = new Cookie("c_id", "Y");    // 아이디 저장 여부 쿠키 
		      cookie.setMaxAge(120);               // 2 분 유지 
		      response.addCookie(cookie);          // 쿠키 기록 
		   
		      cookie = new Cookie("c_id_val", id); // 아이디 값 저장 쿠키  
		      cookie.setMaxAge(120);               // 2 분 유지 
		      response.addCookie(cookie);          // 쿠키 기록  
		         
		    }else{ 
		      cookie = new Cookie("c_id", "");     // 쿠키 삭제 
		      cookie.setMaxAge(0); 
		      response.addCookie(cookie); 
		         
		      cookie = new Cookie("c_id_val", ""); // 쿠키 삭제 
		      cookie.setMaxAge(0); 
		      response.addCookie(cookie); 
		    } 
		    url = "redirect:/";
		    // --------------------------------------------- 
		    /**댓글처리 되돌아가기 위한 데이터받기 */
			String rflag = request.getParameter("flag");
			String bbsno = request.getParameter("bbsno");
			String num = request.getParameter("num");
			String col = request.getParameter("col");
			String word = request.getParameter("word");
			String nowPage = request.getParameter("nowPage");
			String nPage = request.getParameter("nPage");
			/**받기끝	 */
			if(rflag!=null && !rflag.equals("")) {
			model.addAttribute("bbsno", bbsno);
			model.addAttribute("num", num);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			model.addAttribute("nPage", nPage);
			model.addAttribute("nowPage", nowPage);
			
					url = "redirect:"+rflag;
			}
		}
		
		
		
		
		return url;
	}
	
	
	@RequestMapping(value="/member/login",method=RequestMethod.GET)
	public String login(HttpServletRequest request) {
		
		/*----쿠키설정 내용시작----------------------------*/
		String c_id = "";     // ID 저장 여부를 저장하는 변수, Y
		String c_id_val = ""; // ID 값
		 
		Cookie[] cookies = request.getCookies(); 
		Cookie cookie=null; 
		 
		if (cookies != null){ 
		 for (int i = 0; i < cookies.length; i++) { 
		   cookie = cookies[i]; 
		 
		   if (cookie.getName().equals("c_id")){ 
		     c_id = cookie.getValue();     // Y 
		   }else if(cookie.getName().equals("c_id_val")){ 
		     c_id_val = cookie.getValue(); // user1... 
		   } 
		 } 
		} 

		/*----쿠키설정 내용 끝----------------------------*/
		request.setAttribute("c_id", c_id);
		request.setAttribute("c_id_val", c_id_val);
		
		return "/member/login";
	}
	
	@ResponseBody  //비동기 통신이라 viewresolver 사용안하고 요청한 곳으로 리턴이 가는기능
	@RequestMapping(value="/member/emailCheck",method=RequestMethod.GET, 
	produces="text/plain; charset=utf-8")
	public String emailCheck(String email) {
		
		
		boolean flag = dao.duplicateEmail(email);
		String str = null;
		
		if(flag) {
			str= "이메일 중복입니다";
		}else {
			str= "사용가능한 이메일입니다";
		}
		return str;
		
	}
	@ResponseBody  //비동기 통신이라 viewresolver 사용안하고 요청한 곳으로 리턴이 가는기능
	@RequestMapping(value="/member/idCheck",method=RequestMethod.GET, 
			produces="text/plain; charset=utf-8")
	public String idCheck(String id) {
		
		
		boolean flag = dao.duplicateID(id);
		String str = null;
		
		if(flag) {
			str= "아이디 중복입니다";
		}else {
			str= "사용가능한 아이디입니다";
		}
		return str;
		
	}
	
	
	
	@RequestMapping("/member/createProc")
	public String create(MemberDTO dto,HttpServletRequest request) {
		
		
		String str = "";
		String url = "/member/pcreate";
		
		
		if(dao.duplicateID(dto.getId())){
			str="중복된 아이디입니다. 아이디 중복확인을 해주세요";
			request.setAttribute("str", str);
		}else if(dao.duplicateEmail(dto.getEmail())){
			str="중복된 이메일 입니다 이메일 중복확인을 해주세요";
			request.setAttribute("str", str);
		}else {
			
			String upDir = request.getRealPath("/member/storage");
			
			int size=(int)dto.getFnameMF().getSize();
			String fname =null;
			
			if(size>0){
				fname=Utility.saveFileSpring(dto.getFnameMF(), upDir);
			}else{
				fname="member.jpg";
			}
			dto.setFname(fname);
			boolean flag = dao.create(dto);
			
			request.setAttribute("flag", flag);
			url = "/member/createProc";
			
		}
			
		return url;
	}
	
	@RequestMapping("/member/create")
	public String create() {
		
		return "/member/create";
	}
	
	@RequestMapping("/member/agree")
	public String aggree() {
		
		
		return "/member/agree";
	}
	
	
	@RequestMapping("/admin/list")
	public String list(HttpServletRequest request) {
		
		//검색간련 
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));

		if(col.equals("total")){
			word ="";
		}

		//페이징관련
		int nowPage = 1;
		int recordPerPage = 5;
		if(request.getParameter("nowPage")!=null){
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}


		//db에서 가져올 번호 지정
		int sno = ((nowPage-1)*recordPerPage)+1;
		int eno = nowPage*recordPerPage;

		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);
		
		int totalRecord = dao.total(map);
		List<MemberDTO>list = dao.list(map);

		String paging = Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);

		//dao빈즈사용
		request.setAttribute("col", col);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("word", word);
		request.setAttribute("paging", paging);
		request.setAttribute("list", list);
		
		return "/member/list";
	}
	
	
}
