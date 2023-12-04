<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- header.jsp -->
<%@ include file="layout/header.jsp" %>

<!-- TODO 여기서부터 main영역 -->
<div class="nav_bg">
    <div class="container">
        <div class="flight_ticket">
            <div class="flight_ticket_title">
                <h3>항공권 예매</h3>
            </div>
            <div class="flight_ticket_box">
                <form class="d-flex">
                    <input type="text" id="datepicker" placeholder="날짜 및 시간 선택">
                    <input class="form-control me-2" type="text" placeholder="검색어를 입력해주세요">
                    <button class="btn btn-primary" type="submit">검색</button>
                </form>
            </div>

        </div>
        <div class="col-sm-8">
            <h2>TITLE HEADING</h2>
            <h5>Title description, Dec 7, 2017</h5>
            <div class="fakeimg">Fake Image</div>
            <p>Some text..</p>
            <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
            <br>
            <h2>TITLE HEADING</h2>
            <h5>Title description, Sep 2, 2017</h5>
            <div class="fakeimg">Fake Image</div>
            <p>Some text..</p>
            <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
        </div>
    </div>
</div>
</div>
</div>
<script src="js/javascript.js"></script>
<!-- header.jsp -->
<%@ include file="layout/footer.jsp" %>