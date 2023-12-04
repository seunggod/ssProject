package com.tenco.team_two_flight_ticket._core.utils;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

public class ApiUtils {

    //성공시 ApiUtil.success - response에 body데이터 넣어서 보내기
    //실패시 ApiUtil.error  - 메세지 알아서 정해주고, BAD_REQUEST 이런거 넣기
    public static <T> ApiResult<T> success(T response){
        return new ApiResult<>(true, response, null);
    }

    public static ApiResult<?> error(String message, HttpStatus status){
        return new ApiResult<>(false, null, new ApiError(message, status.value()));
    }

    @Getter
    @Setter
    @AllArgsConstructor
    public static class ApiResult<T> {
        private final boolean success;
        private final T data;
        private final ApiError errorType;
    }

    @Getter
    @Setter
    @AllArgsConstructor
    public static class ApiError{
        private final String msg;
        private final int code;

    }

}
