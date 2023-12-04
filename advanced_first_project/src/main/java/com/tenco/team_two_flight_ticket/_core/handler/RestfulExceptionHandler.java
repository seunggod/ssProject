package com.tenco.team_two_flight_ticket._core.handler;

import com.tenco.team_two_flight_ticket._core.handler.exception.MyBadRequestException;
import com.tenco.team_two_flight_ticket._core.handler.exception.MyForbiddenException;
import com.tenco.team_two_flight_ticket._core.handler.exception.MyNotFoundException;
import com.tenco.team_two_flight_ticket._core.handler.exception.MyUnAuthorizedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class RestfulExceptionHandler {

    @ExceptionHandler(MyBadRequestException.class)
    public String badRequest(MyBadRequestException e){
        StringBuffer sb = new StringBuffer();
        sb.append("<script>");
        sb.append("alert( '" + e.getMessage() + "   에러코드:" + e.getStatus() + "' );");
        sb.append("history.back();");
        sb.append("</script>");

        return sb.toString();

    }

    @ExceptionHandler(MyForbiddenException.class)
    public String forbidden(MyForbiddenException e){
        StringBuffer sb = new StringBuffer();
        sb.append("<script>");
        sb.append("alert( '" + e.getMessage() + "   에러코드:" + e.getStatus() + "' );");
        sb.append("history.back();");
        sb.append("</script>");

        return sb.toString();

    }

    @ExceptionHandler(MyNotFoundException.class)
    public String notFound(MyNotFoundException e){
        StringBuffer sb = new StringBuffer();
        sb.append("<script>");
        sb.append("alert( '" + e.getMessage() + "   에러코드:" + e.getStatus() + "' );");
        sb.append("history.back();");
        sb.append("</script>");
        return sb.toString();
    }

    @ExceptionHandler(MyUnAuthorizedException.class)
    public String unAuthorized(MyUnAuthorizedException e){
        StringBuffer sb = new StringBuffer();
        sb.append("<script>");
        sb.append("alert( '" + e.getMessage() + "   에러코드:" + e.getStatus() + "' );");
        sb.append("history.back();");
        sb.append("</script>");
        return sb.toString();
    }
}
