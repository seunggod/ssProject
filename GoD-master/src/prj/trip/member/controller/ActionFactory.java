package prj.trip.member.controller;

import prj.trip.member.service.Action;

import prj.trip.member.impl.IdCheck;
import prj.trip.member.impl.IdSearch;
import prj.trip.member.impl.InsertUser;
import prj.trip.member.impl.Login;
import prj.trip.member.impl.LoginOut;
import prj.trip.member.impl.PwSearch;
import prj.trip.member.impl.PwUpdate;
import prj.trip.member.impl.getMemInfo;

public class ActionFactory {

	public Action getAction(String command) {
		Action action = null;
		
		switch(command){
		case "insert":
			action = new InsertUser();
			break;
		case "IdCheck":
			action = new IdCheck();
			break;
		case "Login":
			action = new Login();
			break;
		case "LoginOut":
			action = new LoginOut();
			break;
		case "getMemInfo":
			action = new getMemInfo();
			break;
		case "IdSearch":
			action = new IdSearch();
			break;
		case "PwSearch":
			action = new PwSearch();
			break;
		case "PwUpdate":
			action = new PwUpdate();
			break;
				
		default: break;
		}
		
		return action;
	}
	
	
}
