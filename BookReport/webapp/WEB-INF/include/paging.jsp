<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@taglib  prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
 <%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<style>
	.paging { display:block;
			 
			  margin:10px auto;
			 
			  width:500px;
			  height:40px;
			  text-align:center;}
	.paging a { border:1px solid orange;
				color:orange;
				text-decoration: none;
				font-size: 20px;
				background: black;
				width:100px;
				height:30px;
				
				 }
	.pageBtn  { background: black; text-align:center; }
</style>
<script>
  $(function(){
	  //현재 페이지 표시
	  for(var i=${nowpage};i<${nowpage}+9;i++){
	  	 if( $('#page'+i).text() == ${nowpage} ){
	  		 $('#page'+1).css('color','red');
	  		 $('#page'+1).css('font-weight','bold');
	  	 }
	  }
	  
	  
	  
  })

</script>
	<!-- 필요한 변수
	-startNum : 1+(pagegrpnum-1)*10
	-pagegrpnum : 이 변수가 증가할 시 startNum+10
	-pagecount  : 그룹 당 보여줄 페이지 수 : 기본 10, 겅우에 따라 변경 가능(가령 작은 창에서는 5)
	-nowpage    : 현재 페이지. 현재 페이지의 위치의 색상이 변화 
	-dpp        : data per page. 한 페이지 당 보여줄 자료수  -->
   <c:set  var="dpp"             value="10" />
   <c:set  var="nowpage"         value="${ nowpage }" />
   <c:set  var="totalcount"      value="${ totalcount }" />
   
   <c:set  var="pagecount"       value="10" />
   <c:choose>
   <c:when test="${ totalcount < dpp*pagecount }">
   <fmt:formatNumber var="pagecount" value="${ totalcount/dpp+(1-(totalcount/dpp%1))%1 }" type="number" />
   <c:set  var="totalpage"       value="${ pagecount }"/>
   </c:when>
   <c:otherwise>
   <fmt:formatNumber var="totalpage" value="${ totalcount/dpp+(1-(totalcount/dpp%1))%1 }" type="number" />

   </c:otherwise>
   </c:choose>
    
   <c:choose>
   <c:when test="${ pagecount ne 10 }">
   <fmt:formatNumber var="pagegrpnum" value="1" type="number" />
   <fmt:formatNumber var="totalpagegrpnum" value="1" type="number" />
   </c:when>
   <c:otherwise>
   <fmt:formatNumber var="pagegrpnum" value="${ nowpage/pagecount+(1-(nowpage/pagecount%1))%1 }" type="number" />
   <fmt:formatNumber var="totalpagegrpnum" value="${ totalpage/pagecount+(1-(totalpage/pagecount%1))%1 }" type="number" />
   </c:otherwise>
   </c:choose>
   
   <c:set  var="startnum"        value="${ 1+(pagegrpnum-1)*pagecount }" />
   <c:set  var="endnum"          value="${pagecount+(pagegrpnum-1)*pagecount }" />
   <c:if test="${endnum > totalpage }" >
   <c:set  var="endnum"          value="${ totalpage }" />
   </c:if>
   <c:if test="${ pagegrpnum ne 1 }">
   <c:set  var="showprev"        value="${ true }" />
   </c:if>
   <c:if test="${ pagegrpnum ne  totalpagegrpnum && totalcount ne 0}">
   <c:set  var="shownext"        value="${ true }" />
   </c:if>
   
       

<div class="paging">   
      <c:if  test="${ showprev eq true }">
        <a href="${href}1">
         &nbsp;&nbsp;first&nbsp;&nbsp;
        </a>
      </c:if>
      
      <c:if  test="${ showprev eq true }">
      
       <a href="${href}${ 1+(pagegrpnum-2)*pagecount }">
        <
       </a>
      </c:if>
      
      <!--  페이지 표시  -->
      <c:forEach var="pagenum" begin="${ startnum }" end="${ endnum }" step="1">
      
      <a class="pageBtn" id="page${pagenum}" href="${ href }${pagenum}">
         &nbsp;${ pagenum }&nbsp;
      </a>
     
      </c:forEach>
      
      <c:if test="${ shownext eq true }">
       <a href="${href}${1+(pagegrpnum)*pagecount}">
        >
       </a>
      </c:if>
      <c:if test="${ shownext eq true }">
       <a href="${href}${endnum}">
        &nbsp;&nbsp;last&nbsp;&nbsp;
       </a>
      </c:if>
		
    
</div>


