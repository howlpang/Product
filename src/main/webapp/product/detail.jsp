<%@page import="vo.Review"%>
<%@page import="java.util.List"%>
<%@page import="dao.ReviewDao"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<%
   //요청 URL - http://localhost/app4/product/detail.jsp?no=XXX

   //요청 파라미터 조회
   int no = Integer.parseInt(request.getParameter("no"));
   //업무로직 수행
   ProductDao productDao = new ProductDao();
   ReviewDao reviewDao = new ReviewDao();
   // 상품 상세정보 조회하기
   Product product = productDao.getProductByNo(no);
   //해당 상품의 모든 리뷰목록 조회하기
   List<Review> reviewList = reviewDao.getReviewsByProductNo(no);
   
   //세션에서 로그인된 사용자 정보 조회하기
   String loginId = (String) session.getAttribute("loginId");
   
%>
<!doctype html>
<html lang="ko">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
<jsp:include page="../nav.jsp">
   <jsp:param name="menu" value="상품"/>
</jsp:include>
<div class="container my-3">
   <div class="row mb-3">
      <div class="col-12">
         <h1 class="border bg-light fs-4 p-2">상품 상세 정보</h1>
         </div>
      </div>
   </div>
   <div class="row mb-3">
      <div class="col-12">
         <p>상품 상세정보를 확인하세요.</p>
         
         <table class="table table-bordered ">
            <colgroup>
               <col width="10%">
               <col width="40%">
               <col width="10%">
               <col width="40%">
            </colgroup>
            <tbody>
               <tr>
                  <th>상품이름</th>
                  <td><%=product.getName() %></td>
                  <th>카테고리</th>
                  <td><%=product.getCategory().getName() %></td>
               </tr>
               <tr>
                  <th>상품번호</th>
                  <td><%=product.getNo() %></td>
                  <th>제조회사</th>
                  <td><%=product.getMaker() %></td>
               </tr>
               <tr>
                  <th>할인가격</th>
                  <td><strong class="text-danger"><%=product.getDiscountPrice() %></strong>원</td>
                  <th>가격</th>
                  <td><span class = "text-decoration-line-through"><%=product.getPrice() %>원</span></td>
               </tr>
               <tr>
                  <th>판매여부</th>
                  <td><%="Y".equals(product.getOnSell())? "판매중":"판매종료" %></td>
                  <th>재고수량</th>
                  <td><%=product.getStock() %></td>
               </tr>
               <tr>
                  <th>수정일자</th>
                  <td><%=product.getUpdateDate() %></td>
                  <th>등록일자</th>
                  <td><%=product.getCreateDate()%></td>
               </tr>
               <tr>
                  <th>상품설명</th>
                  <td colspan="4"><%=product.getDescription() %></td>
               </tr>
            </tbody>
         </table>
         <div class="text-end">
         
         <!--
            현재 URL = http://localhost/app3/product/detail.ksp?no=xxx
            목록 -> http://localhost/app3/product/list.jsp
            삭제 -> http://localhost/app3/product/delete.jsp
         
           -->
            <a href="delete.jsp?no=<%=product.getNo() %>" class="btn btn-danger btn-sm">삭제</a>
            <a href="modifyForm.jsp?no=<%=product.getNo()%>" class="btn btn-warning btn-sm">수정</a>
            <a href="" class="btn btn-primary btn-sm">목록</a>
         </div>
      </div>
   </div>
   <div class="row mb-3">
    <div class="col-11">
      <form class="border bg-light p-2" method="post" action="insertReview.jsp">
         <input type="hidden" name="productNo" value="<%=product.getNo() %>"/>
         <div class="row">
            <div class="col-11">
               <textarea rows="2" class="form-control" name="content"></textarea>
            </div>
            <div class="col-1">
               <button class="btn btn-outline-primary h-100">등록</button>
            </div>
          </div>
       </form>  
     </div>
   </div>
   <div class="row mb-3">
      <div class="col-12 ">
 <%     
 	for(Review review : reviewList){
 %>
         <div class="border p-2 mb-2">
             <div class="d-flex justify-content-between mb-1">
             <span><%=review.getCustomer().getName() %></span> <span class="text-muted"><%=review.getCreateDate() %></span>
         </div>
               <div>
                  <%=review.getContent() %>
<% 
	if(review.getCustomer().getId().equals(loginId)){
%>          
                  <a href="deleteReview.jsp?no=<%=no %>&rno=<%=review.getNo() %>" 
                     class="btn btn-link text-danger text-decoration-none float-end"><i class="bi bi-trash"></i></a>
<%
	}
%>                     
               </div>            
            </div>
<%
 	}
%>            
        </div>
   </div>
</body>
</html>