package prj.trip.common.controller;

import prj.trip.common.service.GoMainAction;

public class ActionFactory {
	public Action getAction(String command) {
		Action action = null;
		
		switch(command){
		case "GOMAINACTION": //메인 화면으로 이동
			action = new GoMainAction();
			break;
		
				
		default: break;
		}
		
		return action;
	}
}
