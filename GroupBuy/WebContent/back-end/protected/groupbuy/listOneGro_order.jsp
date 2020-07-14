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

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootstrap.min.css">
    <!-- Include Favicon ico-->
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/back-end/img/ICON.ico">
    <!-- Font-awesome CSS -->
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.13.0/css/all.css">
    <!--GoogleFont-->
    <link href="https://fonts.googleapis.com/css2?family=Sedgwick+Ave+Display&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lakki+Reddy&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
    <!-- Include style.css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/style.css">
    
     <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
        integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
        integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
        crossorigin="anonymous"></script>   
  
	<!-- groupbuy.css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/groupbuy.css">    
    

    <title>團購訂單詳情</title>
</head>

<body>
<!-- header -->
	
	<%@ include file="../../css/header.jsp" %>
<!-- header -->

    <div class="content d-md-flex">

<!-- aside -->
	<%@ include file="../../css/aside.jsp" %>
<!-- aside -->

        <main>
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
		<li class="breadcrumb-item"><a class="bread" href="<%=request.getContextPath()%>/back-end/index.jsp">後台首頁</a></li>
		<li class="breadcrumb-item"><a class="bread" href="<%=request.getContextPath()%>/back-end/protected/groupbuy/select_page.jsp">團購查詢</a></li>
		<li class="breadcrumb-item"><a class="bread" href="<%=request.getContextPath()%>/back-end/protected/groupbuy/listAllGro_order.jsp">團購訂單查詢</a></li>
		<li class="breadcrumb-item active text-warning" aria-current="page">團購訂單詳情</li>
	</ol>
</nav>

<div class="container-fluid">
	<div class="row justify-content-center">
		<div class="col-11">
			<div class="card alert alert-success">
				<div class="card-header">
					<h1 class="card-title text-dark">團購訂單詳情</h1>
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
													<h6>收件者名稱： ${(gro_orderVO.receive_name eq null) ? '尚未填寫資料' : gro_orderVO.receive_name }</h6>
													<h6>收件者手機： ${(gro_orderVO.phone eq null) ? '尚未填寫資料' : gro_orderVO.phone}</h6>
													<h6>收件者地址： ${(gro_orderVO.address eq null) ? '尚未填寫資料' : gro_orderVO.address}</h6>
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
									<div class="row mt-2 mb-4">
									<form action="<%=request.getContextPath()%>/gro_order/gro_order.do" method="post" style="width: 100%">
										<div class="col-12 text-center">
											<div class="form-group">
												<select name="ordstat_id" class="form-control">
													<c:forEach var="ordstatVO" items="${ordstatSvc.all}">
														<option value="${ordstatVO.ordstat_id}" ${(ordstatVO.ordstat_id eq gro_orderVO.ordstat_id) ? 'selected' : ''} >${ordstatVO.ordstat}</option>
													</c:forEach>
												</select>
											</div>
											<div class="form-group mt-5">
												<input type="hidden" name="ord_id" value="${gro_orderVO.ord_id}">
												<input type="hidden" name="from" value="back-end">
												<input type="hidden" name="action" value="manage">
												<button type="submit" class="btn btn-outline-dark btn-block">修改訂單狀態</button>
											</div>
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









            
        </main>
    </div>


</body>

</html>