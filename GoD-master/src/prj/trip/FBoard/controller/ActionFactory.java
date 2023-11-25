package prj.trip.FBoard.controller;


import prj.trip.FBoard.impl.FBCDelete;
import prj.trip.FBoard.impl.FBCInsert;
import prj.trip.FBoard.impl.FBCUpdate;
import prj.trip.FBoard.impl.FBLikeCnt;
import prj.trip.FBoard.impl.FBUpdate;
import prj.trip.FBoard.impl.FBoardClick;
import prj.trip.FBoard.impl.FBoardSearch;
import prj.trip.FBoard.impl.FBoardWrite;
import prj.trip.FBoard.impl.FBoardWriter;
import prj.trip.FBoard.impl.FreeBoard;

public class ActionFactory {

	public Action getAction(String command) {
		Action action = null;
		
		switch(command){
		
		case "FreeBoard":
			action = new FreeBoard();
			break;
		case "FBoardWriter":
			action = new FBoardWriter();
			break;
		case "FBoardWrite":
			action = new FBoardWrite();
			break;
		case "FBoardClick":
			action = new FBoardClick();
			break;
		case "FBLikeCnt":
			action = new FBLikeCnt();
			break;
		case "FBoardSearch":
			action = new FBoardSearch();
			break;
		case "FBCInsert":
			action = new FBCInsert();
			break;
		case "FBCDelete":
			action = new FBCDelete();
			break;
		case "FBCUpdate":
			action = new FBCUpdate();
			break;
		case "FBUpdate":
			action = new FBUpdate();
			break;
			
			
		default: break;
		}
		
		return action;
	}
	
	
}
