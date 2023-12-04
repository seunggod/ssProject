package com.tenco.team_two_flight_ticket._core.handler.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class MyUnAuthorizedException extends RuntimeException{

    private HttpStatus status;

    public MyUnAuthorizedException(String message){
        super(message);
        this.status = HttpStatus.UNAUTHORIZED;
    }

}
