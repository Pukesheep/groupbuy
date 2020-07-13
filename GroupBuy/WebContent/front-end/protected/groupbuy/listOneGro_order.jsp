<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.member.model.*" %>
<%@ page import="com.groupbuy.model.*" %>
<%@ page import="com.product.model.*" %>
<%@ page import="com.rebate.model.*" %>
<%@ page import="com.gro_order.model.*" %>
<%@ page import="com.ordstat.model.*" %>

<%
	Gro_orderVO gro_orderVO = (Gro_orderVO) request.getAttribute("gro_orderVO");
%>

<jsp:useBean id="groupbuySvc" scope="page" class="com.groupbuy.model.GroupbuyService" />
<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProService" />
<jsp:useBean id="rebateSvc" scope="page" class="com.rebate.model.RebateService" />
<jsp:useBean id="ordstatSvc" scope="page" class="com.ordstat.model.OrdstatService" />
<jsp:useBean id="memberSvc" scope="page" class="com.member.model.MemberService" />

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>訂單詳情</title>
    <%@ include file="../../../files/HeaderCssLink" %>
        
    <!-- SweetAlert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
 
	<!-- groupbuy.css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/groupbuy.css"> 		
	
</head>
<body>
    <!-- navbar -->
		<%@ include file="../../../files/header.jsp" %>
    <!-- navbar end -->
    <section class="blank0"></section>
    <!-- 內容 -->
    
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs }">
<%
	java.util.List<String> errorMsgs = (java.util.List<String>) request.getAttribute("errorMsgs");
	String message = "";
	for (String msg : errorMsgs) {
		message += msg;
		message += "\\n";
	}
%>
<script>
	Swal.fire({
		icon: 'error',
		title: '<%=message%>'
	});
</script>
</c:if>
<%-- 錯誤表列 --%>

<%-- 成功表列 --%>
<c:if test="${not empty successMsgs }">
<%
	java.util.List<String> successMsgs = (java.util.List<String>) request.getAttribute("successMsgs");
	String message = "";
	for (String msg : successMsgs) {
		message += msg;
		message += "\\n";
	}
%>
<script>
	Swal.fire({
		icon: 'success',
		title: '<%=message%>'
	});
</script>
</c:if>
<%-- 成功表列 --%>

<nav aria-label="breadcrumb">
	<ol class="breadcrumb bg-transparent">
		<li class="breadcrumb-item"><a class="bread" href="<%=request.getContextPath()%>/front-end/index.jsp">前台首頁</a></li>
		<li class="breadcrumb-item"><a class="bread" href="<%=request.getContextPath()%>/front-end/groupbuy/listAllGroupbuy.jsp">團購列表</a></li>
		<li class="breadcrumb-item"><a class="bread" href="<%=request.getContextPath()%>/front-end/protected/groupbuy/listAllGro_order.jsp">團購訂單</a></li>
		<li class="breadcrumb-item active text-warning" aria-current="page">訂單詳情</li>
	</ol>
</nav>

<div class="container-fluid">
	<div class="row justify-content-center">
		<div class="col-11">
			<div class="card alert alert-success">
				<div class="card-header">
					<h1 class="card-title text-dark">訂單詳情</h1>
				</div>
				<div class="card-body">
					<div class="row mt-1">
						<div class="col-6">
							<div class="card alert alert-dark listOneGro_order">
								<div class="card-header">
									<h4 class="card-title text-dark">會員資訊</h4>
								</div>
								<div class="card-body">
									<div class="media">
										<img src="<%=request.getContextPath()%>/member/ShowMemberPic.do?mem_id=${gro_orderVO.mem_id}" class="mr-3 listOneGro_order" alt="">
										<div class="media-body">
											<c:forEach var="memberVO" items="${memberSvc.all}">
												<c:if test="${memberVO.mem_id eq gro_orderVO.mem_id}">
													<h6>收件者名稱： ${memberVO.mem_name}</h6>
													<h6>收件者地址： ${memberVO.mem_addr}</h6>
													<h6>收件者手機： ${memberVO.mem_phone}</h6>
													<h6>收件者郵件： ${memberVO.mem_email}</h6>
												</c:if>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="card alert alert-info listOneGro_order">
								<div class="card-header">
									<h4 class="card-title text-dark">商品資訊</h4>
								</div>
								<div class="card-body">
									<div class="media">
										<c:forEach var="groupbuyVO" items="${groupbuySvc.all}">
											<c:if test="${groupbuyVO.gro_id eq gro_orderVO.gro_id}">
												<c:forEach var="productVO" items="${productSvc.all}">
													<c:if test="${productVO.p_id eq groupbuyVO.p_id}">
														<img src="<%=request.getContextPath()%>/product/proPic.do?p_id=${productVO.p_id}" class="mr-3 listOneGro_order" alt="">
														<div class="media-body">
															<h6>商品編號： ${productVO.p_id}</h6>
															<h6>商品名稱： ${productVO.p_name}</h6>
															<h6>商品原價： <fmt:formatNumber pattern="#" value="${productVO.p_price}" /></h6>
															<h6>商品描述： ${productVO.p_info}</h6>
														</div>
													</c:if>
												</c:forEach>
											</c:if>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row mt-1">
						<div class="col-6">
							<div class="card alert alert-warning listOneGro_order">
								<div class="card-header">
									<h4 class="card-title text-dark">訂單資訊</h4>
								</div>
								<div class="card-body">
									<div class="media">
										<img src="<%=request.getContextPath()%>/images/groupbuy/order.png" class="mr-3 listOneGro_order" alt="">
										<div class="media-body">
											<h6>訂單編號： ${gro_orderVO.ord_id}</h6>
											<h6>成立時間： <fmt:formatDate value="${gro_orderVO.ord_date}" pattern="yyyy-MM-dd hh:mm:ss" /></h6>
											<h6>團購商品編號： ${gro_orderVO.gro_id}</h6>
											<c:forEach var="ordstatVO" items="${ordstatSvc.all}">
												<c:if test="${ordstatVO.ordstat_id eq gro_orderVO.ordstat_id}">
													<h6>訂單狀態： ${ordstatVO.ordstat}</h6>
												</c:if>
											</c:forEach>
											<h6>訂單金額： ${gro_orderVO.ord_price}</h6>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="card alert alert-danger listOneGro_order">
								<div class="card-header">
									<h4 class="card-title text-dark">訂單操作</h4>
								</div>
								<div class="card-body">
									<div class="row mt-5 mb-4">
									<form action="<%=request.getContextPath()%>/gro_order/gro_order.do" method="post" style="width: 100%">
										<div class="col-12 text-center">
											<input type="hidden" name="ordstat_id" value="014">
											<input type="hidden" name="ord_id" value="${gro_orderVO.ord_id}">
											<input type="hidden" name="from" value="front-end">
											<input type="hidden" name="action" value="update">
											<button type="submit" class="btn btn-outline-dark btn-block">完成訂單</button>
										</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>






    <!-- 內容 ---end  -->


        <!-- footer -->
			<%@ include file="../../../files/footer.jsp" %>
        <!-- footer -->
</body>



</html>