<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 각 jsp가 nav.jsp를 include할 때 파라미터값을 전달한 menu를 조회한다.
	String menu = request.getParameter("menu");
	System.out.println("메뉴 :" + menu);
	
	// 세션에서 로그인된 사용자아이디를 조회
	String loginId = (String) session.getAttribute("loginId");
	System.out.println("로그인 아이디: " + loginId);
%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
   <div class="container">
      <ul class="navbar-nav me-auto">
         <li class="nav-item"><a class="nav-link <%="홈".equals(menu) ? "active" : "" %>" href="/app4/home.jsp">홈</a></li>
         <li class="nav-item"><a class="nav-link <%="상품".equals(menu) ? "active" : "" %>" href="/app4/product/list.jsp">상품관리</a></li>
         <li class="nav-item"><a class="nav-link <%="고객".equals(menu) ? "active" : "" %>" href="/app4/customer/list.jsp">고객 관리</a></li>
         <li class="nav-item"><a class="nav-link  <%="게시판".equals(menu) ? "active" : "" %>" href="/app4/board/list.jsp">게시판 관리</a></li>
      </ul>
      <ul class="navbar-nav">
<%
	if (loginId != null) {
%>
         <li class="nav-item"><a class="nav-link" href="/app4/logout.jsp">로그아웃</a></li>
<%
	} else {
%>
         <li class="nav-item"><a class="nav-link <%="로그인".equals(menu) ? "active" : "" %>" href="/app4/loginform.jsp">로그인</a></li>
         <li class="nav-item"><a class="nav-link <%="회원가입".equals(menu) ? "active" : "" %>" href="/app4/customer/form.jsp">회원가입</a></li>
<%	
	}
%>
      </ul>
   </div>
</nav>