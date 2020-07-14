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
	Gro_orderService gro_orderSvc = new Gro_orderService();
	List<Gro_orderVO> list = gro_orderSvc.getAllByMem_id(memberVO.getMem_id());
	pageContext.setAttribute("list", list);
%>

<jsp:useBean id="groupbuySvc" scope="page" class="com.groupbuy.model.GroupbuyService" />
<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProService" />
<jsp:useBean id="rebateSvc" scope="page" class="com.rebate.model.RebateService" />
<jsp:useBean id="ordstatSvc" scope="page" class="com.ordstat.model.OrdstatService" />

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>團購訂單</title>
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
		<li class="breadcrumb-item active text-warning" aria-current="page">團購訂單</li>
	</ol>
</nav>


            <div class="container-fluid">
                <div class="row justify-content-center mt-1">
                	<div class="col-10">
                		<div class="card bg-info">
							<img alt="" src="<%=request.getContextPath()%>/images/groupbuy/watermelon.jpg" id="front-end-Header">	
								<div class="card-body">
									<h1 class="card-text">團購訂單</h1>
									<%@ include file="../../../files/page1B.file" %>
									<div class="row">
										<div class="col">
											<div class="media m-3">
												<div class="media-body">
													<c:forEach var="gro_orderVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
														<c:forEach var="groupbuyVO" items="${groupbuySvc.all}">
															<c:if test="${groupbuyVO.gro_id eq gro_orderVO.gro_id}">
																<div class="media mt-3 alert alert-danger">
																	<img src="<%=request.getContextPath()%>/product/proPic.do?p_id=${groupbuyVO.p_id}" class="align-self-center mr-3 img-listAll" alt="">
																	<div class="media-body bg-secondary p-4">
																		<div class="row">
																			<div class="col-8">
																				<h3 class="mt-0 text-white mb-3">${productSvc.getOnePro(groupbuyVO.p_id).p_name}</h3>
																				<h4 class="mt-3 mb-1">訂單編號： ${gro_orderVO.ord_id}</h4>
																				<c:choose>
																					<c:when test="${groupbuyVO.status eq 0}">
																						<h4>團購案狀態： 下架</h4>
																					</c:when>
																					
																					<c:when test="${groupbuyVO.status eq 1}">
																						<h4>團購案狀態： 上架</h4>
																					</c:when>
																					
																					<c:when test="${groupbuyVO.status eq 2}">
																						<h4>團購案狀態： 已達標</h4>
																					</c:when>
																					
																					<c:when test="${groupbuyVO.status eq 3}">
																						<h4>團購案狀態： 未達標</h4>
																					</c:when>
																				</c:choose>
																				<h4>
																				<c:forEach var="ordstatVO" items="${ordstatSvc.all}">
																					<c:if test="${ordstatVO.ordstat_id eq gro_orderVO.ordstat_id}">
																						訂單狀態： ${ordstatVO.ordstat}
																					</c:if>
																				</c:forEach>
																				</h4>
																				<h4>原價： $<fmt:formatNumber pattern="#" value="${productSvc.getOnePro(groupbuyVO.p_id).p_price}" /></h4>
																				<h4>折扣價： $<fmt:formatNumber pattern="#" value="${groupbuyVO.money}" /> 元</h4>
																				<h5>訂單成立時間： <fmt:formatDate value="${gro_orderVO.ord_date}" pattern="yyyy-MM-dd hh:mm:ss" /></h5>
																			</div>
																			<div class="col-4">
																				<div class="row">
																					<div class="col-6">
																						<c:if test="${gro_orderVO.ordstat_id eq '002'}">
																							<form action="<%=request.getContextPath()%>/gro_order/gro_order.do" method="post">
																								<input type="hidden" name="ord_id" value="${gro_orderVO.ord_id}">
																								<input type="hidden" name="from" value="front-end">
																								<input type="hidden" name="action" value="getOne_For_Payment">
																								<button type="submit" class="btn btn-success btn-lg btn-block mt-3" style="height: 250px">付款</button>
																							</form>
																						</c:if>
																					</div>
																					<div class="col-6">
																						<form action="<%=request.getContextPath()%>/gro_order/gro_order.do" method="post">
																							<input type="hidden" name="ord_id" value="${gro_orderVO.ord_id}">
																							<input type="hidden" name="from" value="front-end">
																							<input type="hidden" name="action" value="getOne_For_Display">
																							<button type="submit" class="btn btn-success btn-lg btn-block mt-3" style="height: 250px">查看訂單詳情</button>
																						</form>
																					</div>
																				</div>
																			</div>
																		</div>
																	</div>
																</div>
															</c:if>
														</c:forEach>
													</c:forEach>
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