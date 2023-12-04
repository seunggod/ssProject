package com.tenco.team_two_flight_ticket.controller;

import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class TestController {

    @GetMapping("/test")
    public String test(){
     return "test";
    }
    /*
    @PostMapping("/test")
    public String validtest(@Valid UserRequest.JoinDTO joinDTO){
        return "main";
    }
    */
}
