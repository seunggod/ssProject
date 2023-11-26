package com.book.fboard.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;


import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FBoardFile {

	public static  void   save(
			HashMap<String, Object> map,
			HttpServletRequest request) {
		
		//    넘어온 파일저장(d:\\upload\\)처리 (중복파일처리)
		CheckFileName  checkFile =  new CheckFileName(); 
		
		// 자료실 파일 저장될 경로
		String   filePath = "C:\\Develop Lab\\kss\\spring\\BookReport\\webapp\\WEB-INF\\resources\\upload\\";
		
		MultipartHttpServletRequest  multipartHttpServletRequest
		 =  (MultipartHttpServletRequest) request;
		
		Iterator<String> iterator =
				multipartHttpServletRequest.getFileNames();
		
		MultipartFile  multipartFile = null; 
		
				
		String         fileName      = null; 
		String         orgFileName   = null; 
		String         fileExt       = null; 
		String         sFileName     = null; 
		
		// upload 된 파일마다 반복하여 처리
		// 파일하나당 반복
		    iterator.hasNext();
			multipartFile = multipartHttpServletRequest.getFile(
					iterator.next());
			
			if( !multipartFile.isEmpty()  )
			{
				fileName    = multipartFile.getOriginalFilename();              // 김연아.광고.jpg
				orgFileName = fileName.substring(
						0, fileName.lastIndexOf(".")); 
				fileExt     = fileName.substring( 
						fileName.lastIndexOf(".") );  
				
				// filePath + orgFileName + fileExt 이 존재하면 
				//  중복되지 않는 새로운 파일명을 생성
				sFileName = checkFile.getCheckFileName(
						filePath, orgFileName, fileExt );
				String src = "/upload/";			
				map.put("board_image", src + sFileName );				
				// 파일 저장 : c:\\upload\\
				File file = new File(filePath + sFileName);				
				try {
					multipartFile.transferTo(file);   // 실제파일 저장
				} catch( IllegalStateException e ) {
					e.printStackTrace();
				} catch( IOException e ) {
					e.printStackTrace();
				} // try end
			} // if end				
	}

	//공지사항 삭제 시 사용 이미지도 삭제
	public static void delete(HashMap<String, Object> map) {
		String src = (String) map.get("board_image");
		File file          = new File( src );
		file.delete();
		
	}
	
}
