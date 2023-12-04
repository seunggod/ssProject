package com.tenco.team_two_flight_ticket._core.handler.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class MyBadRequestException extends RuntimeException{

    private HttpStatus status;

    public MyBadRequestException(String message){
        super(message);
        this.status = HttpStatus.BAD_REQUEST;
    }

}
