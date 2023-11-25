package prj.trip.tboard.controller;



import prj.trip.tboard.service.Action;
import prj.trip.tboard.service.CommentPagingAction;
import prj.trip.tboard.service.CommentWriteAction;
import prj.trip.tboard.service.LikeDeleteAction;
import prj.trip.tboard.service.LikeUpdateAction;
import prj.trip.tboard.service.SearchPagingAction;
import prj.trip.tboard.service.TBoardListForm;
import prj.trip.tboard.service.TBoardPagingAction;
import prj.trip.tboard.service.TBoardReadCont;
import prj.trip.tboard.service.TBoardSearchAction;
import prj.trip.tboard.service.TBoardWriteAction;
import prj.trip.tboard.service.TBoardWriteForm;
import prj.trip.tboard.service.TboardDeleteAction;
import prj.trip.tboard.service.TboardUpdateAction;
import prj.trip.tboard.service.TboardUpdateForm;


public class ActionFactory {

	public Action getAction(String command) {
		Action action = null;
		
		switch(command){
		case "TBOARDWRITEFORM": //글쓰기로 이동
			action = new TBoardWriteForm(); 
			break;
		case "TBOARDWRITEACTION": //글쓰기 완료
			action = new TBoardWriteAction();
			break;
		case "TBOARDLISTFORM": //게시판으로 이동
			action = new TBoardListForm();
			break;
		case "BOARDPAGINGACTION": //게시판 페이징
			action = new TBoardPagingAction();
			break;
		case "READBOARDCONT": //게시물 보기
			action = new TBoardReadCont();
			break;
		case "TBOARDSEARCHACTION": //게시판 검색
			action = new TBoardSearchAction();
			break;
		case "SEARCHPAGINGACTION": //게시판 검색 페이징
			action = new SearchPagingAction();
			break;
		case "TBOARDLISTSORT": //게시판 정렬
			action = new TBoardListSortForm();
			break;
		case "BOARDSORTPAGINGACTION": //게시판 정렬 페이징
			action = new TBoardSortPagingAction();
			break;
		
		
		//게시물	
		
		case "TBOARDUPDATEFORM": //게시물 수정으로 이동
			action = new TboardUpdateForm();
			break;
		case "TBOARDUPDATEACTION": //게시물 수정
			action = new TboardUpdateAction();
			break;
		case "TBOARDDELETEACTION": //게시물 삭제
			action = new TboardDeleteAction();
			break;
		case "LIKEUPDATEACTION": //좋아요(게시물)
			action = new LikeUpdateAction();
			break;
		case "LIKEDELETEACTION": //좋아요 취소(게시물)
			action = new LikeDeleteAction();
			break;
		
	    //게시물 댓글
		case "COMMENTWRITEACTION": //댓글 작성
			action = new CommentWriteAction();
			break;
		case "TBCMTPAGINGACTION": //댓글 페이징
			action = new CommentPagingAction();
			break;
		case "CMTLIKEUPDATEACTION": //댓글 좋아요
			action = new CMTLikeUpdateAction();
			break;
		case "CMTLIKEDELETEACTION": //댓글 좋아요 취소
			action = new CMTLikeDeleteAction();
			break;
		case "COMMENTDELETEACTION": //댓글 삭제
			action = new CommentDeleteAction();
			break;		
		default: break;
		}
		
		return action;
	}
	
	
}
