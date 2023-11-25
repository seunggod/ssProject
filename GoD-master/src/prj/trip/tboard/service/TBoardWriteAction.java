package prj.trip.tboard.service;

import java.io.IOException;

import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import prj.trip.member.dao.MemberDao;
import prj.trip.tboard.dao.TBoardDao;


public class TBoardWriteAction implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		request.setCharacterEncoding("UTF-8");
		// 필요한 인자: memNum, title, addr, bcont1,2,3,4 image1,m,3,2
		String loginId  = (String) session.getAttribute("LoginId"); //세션과의 연결
		MemberDao mDao  = new MemberDao();
		int memNum      = mDao.getMemNum(loginId);
		
		//String filepath = request.getRealPath("/uploadFiles"); //절대 경로
		String filepath = "D:\\kss_ws\\jsp\\PrjReqTrip\\WebContents\\uploadFiles"; //상대 경로
		int size = 1024 * 1024 * 20; //20MB
		
	    String str,filename,original_filename;
	    ArrayList<String> filenames= new ArrayList<String>();
	   
	    
	    //ArrayList original_filename= new ArrayList();
	    String bcont1, bcont2, bcont3, bcont4; //게시물 구분점 " %111% "
	    String bcontbox;
	    
	    try{
	    	
	    	MultipartRequest multiRequest = new MultipartRequest(request, filepath, size, "UTF-8", new DefaultFileRenamePolicy());
	    	System.out.println(multiRequest.getOriginalFileName("file"));
	    	String title = multiRequest.getParameter("title");
	    	String addr  = multiRequest.getParameter("addr");
	    	bcont1 = multiRequest.getParameter("bcont1");
	    	bcont2 = multiRequest.getParameter("bcont2");
	    	bcont3 = multiRequest.getParameter("bcont3");
	    	bcont4 = multiRequest.getParameter("bcont4");
	    	bcontbox = bcont1;
	    	
	    	bcontbox+="%111%"+bcont2;
	    	
	    	bcontbox+="%111%"+bcont3;
	    	
	    	bcontbox+="%111%"+bcont4;
	    	
	    	Enumeration files = multiRequest.getFileNames();
	    	
	    	while( files.hasMoreElements()){
	    		str = (String)files.nextElement();   //파일 형식
	    		filename = multiRequest.getFilesystemName(str);  //파일 이름
	    		original_filename = multiRequest.getOriginalFileName(str);  //파일 원래 이름
	    		//filename.add( multiRequest.getFilesystemName(str));  //파일 이름
	    		//original_filename.add( multiRequest.getOriginalFileName(str));  //파일 원래 이름
	    		//1-main-3-2
	    		System.out.println("str : "+str);
	    		System.out.println("filename : "+filename);
	    		System.out.println("original_filename : "+original_filename);
	    		filenames.add(filename);
	    		//filename과 original_filename을 인자로 받아 array에 넣을 필요가 있음(이미지 위치까지도)
	    	}
	    	 if(filenames.size()==2) {
	 	    	filenames.add(null);
	 	    	filenames.add(null);
	 	    }
	 	    if(filenames.size()==3) {
	 	    	filenames.add(null);
	 	    }
	 	   System.out.println("어레이크기:"+filenames.size());
	    	TBoardDao dao  = new TBoardDao();
	    	String img     = "";
	    	int aftcnt = dao.insertTBoard( memNum, title, addr, bcontbox, filenames);
	    	System.out.println(aftcnt);
	    } catch (Exception e){
	    	e.printStackTrace();
	    }
		
		
		
		
		
		
		String path = "/tboard?cmd=TBOARDLISTFORM";
		request.getRequestDispatcher(path).forward(request, response);
	}

}
