package com.tenco.team_two_flight_ticket._core.handler;

import com.tenco.team_two_flight_ticket._core.handler.exception.MyUnAuthorizedException;
import com.tenco.team_two_flight_ticket._core.utils.Define;
import com.tenco.team_two_flight_ticket.user.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AuthInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession();
        User principal = (User) session.getAttribute(Define.PRINCIPAL);
        if(principal == null){
            throw new MyUnAuthorizedException("로그인 먼저 해주세요");
        }
        return true;
    }
}
