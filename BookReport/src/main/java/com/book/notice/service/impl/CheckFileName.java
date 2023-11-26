package com.book.notice.service.impl;

import java.io.File;

public class CheckFileName {
	
	public   String   getCheckFileName(
		String filePath, String orgFileName, String fileExt	) {
		
		boolean  isCheck         = true;
		String   returnFileName  = null;
		
		String   fullFilePath    = null;
		File     file            = null;
		
		int i = 0;
		int length = orgFileName.length();
		while( isCheck ) {
			fullFilePath  = filePath + orgFileName + fileExt;
			file          = new File( fullFilePath );
			if(  file.exists() ) { 
				i += 1;
				orgFileName = orgFileName.substring(0, length-1) + "("+String.valueOf(i)+")";
			} else {
				isCheck = false;
			}
		}
		
		returnFileName = orgFileName + fileExt;
		
		return  returnFileName;
	}
}




