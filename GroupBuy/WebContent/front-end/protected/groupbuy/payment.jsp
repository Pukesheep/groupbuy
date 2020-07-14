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
	MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
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
    <title>訂單付款</title>
    <%@ include file="../../../files/HeaderCssLink" %>
        
    <!-- SweetAlert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
 
	<!-- groupbuy.css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/groupbuy.css">
    
    <!-- tw-city-selector -->
	<script src="<%=request.getContextPath()%>/files/tw-city-selector/tw-city-selector.min.js"></script>
	
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
		<li class="breadcrumb-item active text-warning" aria-current="page">訂單付款</li>
	</ol>
</nav>

<div class="container-fluid">
	<div class="row justify-content-center">
		<div class="col-11">
			<form action="<%=request.getContextPath()%>/gro_order/gro_order.do" method="post" style="width: 100%">
				<div class="card alert alert-success">
					<div class="card-header">
						<h1 class="card-title text-dark">訂單付款</h1>
					</div>
					<div class="card-body">
						<div class="row mt-1">
							<div class="col-6">
								<div class="card alert alert-dark listOneGro_order">
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
							<div class="col-12">
								<div class="card alert alert-warning">
									<div class="card-header">
										<h4 class="card-title text-dark">付款資訊</h4>
									</div>
									<div class="card-body">
										<div class="media">
												<img src="<%=request.getContextPath()%>/member/ShowMemberPic.do?mem_id=${sessionScope.memberVO.mem_id}" class="mr-3 listOneGro_order" alt="">											<div class="media-body">
												<div class="row">
													<div class="col-4">
														<div class="form-group">
															<label for="receive_name">收件者名稱</label>
															<input type="text" class="form-control" id="receive_name" name="receive_name" value="${param.receive_name}" autocomplete="off">
														</div>
														<div class="form-group">
															<label for="phone">收件者手機</label>
															<input type="text" class="form-control" id="phone" name="phone" value="${param.phone}" autocomplete="off" maxlength="10">
														</div>
														<button type="button" id="fillForm" class="btn btn-outline-info btn-lg btn-block mt-4">導入會員資料</button>
														<button type="button" id="clearForm" class="btn btn-outline-danger btn-lg btn-block mt-5">清除</button>
													</div>
													<div class="col-4">
														<div class="form-group">
															<label for="card_no">信用卡號</label>
															<input type="text" class="form-control" id="card_no" name="card_no" value="${param.card_no}" autocomplete="off" maxlength="16">
														</div>
														<div class="form-group">
															<label for="card_yy">到期年份</label>
															<input type="text" class="form-control" id="card_yy" name="card_yy" value="${param.card_yy}" autocomplete="off" maxlength="4">
														</div>
														<div class="form-group">
															<label for="card_mm">到期月份</label>
															<input type="text" class="form-control" id="card_mm" name="card_mm" value="${param.card_mm}" autocomplete="off" maxlength="2">
														</div>
														<div class="form-group">
															<label for="card_sec">卡片安全碼</label>
															<input type="text" class="form-control" id="card_sec" name="card_sec" value="${param.card_sec}" autocomplete="off" maxlength="3">
														</div>
													</div>
													<div class="col-4  my-selector-c">
														<div class="form-group">
															<label for="county">縣市</label>
															<select class="form-control county" name="county" id="county"></select>
														</div>
														<div class="form-group">
															<label for="district">鄉鎮</label>
															<select class="form-control district" name="district" id="district"></select>
														</div>
														<div class="form-group">
															<label for="detail">細項</label>
															<input type="text" class="form-control" id="detail" name="detail" value="" autocomplete="off">
														</div>
														<div class="form-group">
															<label for="address">地址</label>
															<input type="text" class="form-control" id="address" name="address" value="${param.address}" readonly autocomplete="off">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<input type="hidden" name="ordstat_id" value="003">
						<input type="hidden" name="ord_id" value="${gro_orderVO.ord_id}">
						<input type="hidden" name="from" value="front-end">
						<input type="hidden" name="action" value="payment">
						<button type="submit" class="btn btn-outline-dark btn-lg btn-block">確認付款</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>





    <!-- 內容 ---end  -->


        <!-- footer -->
			<%@ include file="../../../files/footer.jsp" %>
        <!-- footer -->
</body>
<%-- 處理地址下拉式選單與手動輸入合併的區塊 --%>
<script>

new TwCitySelector({
    el: ".my-selector-c",
    elCounty: ".county", // 在 el 裡查找 dom
    elDistrict: ".district" // 在 el 裡查找 dom
  });

	$('#county').change(function(){
		
		$('#address').val($('#county').val() + $('#district').val() + $('#detail').val());
		
	});
	
	$('#district').change(function(){
		
		$('#address').val($('#county').val() + $('#district').val() + $('#detail').val());
		
	});
	
	$('#detail').keyup(function(){
		
		$('#address').val($('#county').val() + $('#district').val() + $('#detail').val());
		
	});
	
</script>
<%-- 處理地址下拉式選單與手動輸入合併的區塊 --%>
<script>
	$('#fillForm').click(function(){
		var receive_name = '${sessionScope.memberVO.mem_name}';
		var phone = '${sessionScope.memberVO.mem_phone}';
		var card_no = '${sessionScope.memberVO.card_no}';
		var card_yy = '${sessionScope.memberVO.card_yy}';
		var card_mm = '${sessionScope.memberVO.card_mm}';
		var card_sec = '${sessionScope.memberVO.card_sec}';
		var address = '${sessionScope.memberVO.mem_addr}';
		var detail = address.substring(6);
		
		$('#receive_name').val(receive_name);
		$('#phone').val(phone);
		$('#card_no').val(card_no);
		$('#card_yy').val(card_yy);
		$('#card_mm').val(card_mm);
		$('#card_sec').val(card_sec);
		$('#address').val(address);
		$('#detail').val(detail);
		
	});
	
	$('#clearForm').click(function(){
		
		$('#receive_name').val('');
		$('#phone').val('');
		$('#card_no').val('');
		$('#card_yy').val('');
		$('#card_mm').val('');
		$('#card_sec').val('');
		$('#address').val('');
		$('#detail').val('');
		
	})
</script>

</html>