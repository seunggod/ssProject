package prj.trip.FBoard.service;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@FunctionalInterface
public interface Action {

	public void excute(HttpServletRequest request,
						HttpServletResponse response)
								throws  ServletException, IOException;
	
}