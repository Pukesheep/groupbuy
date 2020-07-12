<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.groupbuy.model.*" %>
<%@ page import="com.product.model.*" %>
<%@ page import="com.rebate.model.*" %>

<%
	GroupbuyService groupbuySvc = new GroupbuyService();
	List<GroupbuyVO> list = groupbuySvc.getAll();
	pageContext.setAttribute("list", list);
%>

<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProService" />
<jsp:useBean id="rebateSvc" scope="page" class="com.rebate.model.RebateService" />

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
        
    <!-- SweetAlert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>  
 
	<!-- groupbuy.css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/groupbuy.css"> 
    
    
    <title>團購區</title>
    

    
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
		<li class="breadcrumb-item active text-warning" aria-current="page">團購列表</li>
	</ol>
</nav>

            <div class="container-fluid">
                <div class="row justify-content-center mt-5">
                	<div class="col-10">
                		<div class="card bg-info">
							<img alt="" src="<%=request.getContextPath()%>/images/groupbuy/meme.png" id="groupbuyHeader">	
								<div class="card-body">
									<h1 class="card-text">團購列表</h1>
									<%@ include file="../../../files/page1B.file" %>
									<div class="row">
										<div class="col">
											<div class="media m-3">
<%-- 												<img src="<%=request.getContextPath()%>/images/groupbuy/groupbuy.png" class="mr-3" alt=""> --%>
												<div class="media-body">
													<c:forEach var="groupbuyVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
														<div class="media mt-3 alert alert-danger">
															<a class="mr-3" href="<%=request.getContextPath()%>/groupbuy/groupbuy.do?action=getOne_For_Display&from=back-end&gro_id=${groupbuyVO.gro_id}">
																<img src="<%=request.getContextPath()%>/product/proPic.do?p_id=${groupbuyVO.p_id}" class="align-self-end mr-3 img-listAll" alt="">
															</a>
															<div class="media-body bg-secondary p-4">
																<div class="row">
																	<div class="col-6">
																		<h3 class="mt-0 text-white mb-3">${productSvc.getOnePro(groupbuyVO.p_id).p_name}</h3>
																		<c:choose>
																		
																			<c:when test="${groupbuyVO.status eq 0}">
																				<h4 class="mt-5">狀態： 下架</h4>
																			</c:when>
																			
																			<c:when test="${groupbuyVO.status eq 1}">
																				<h4 class="mt-5">狀態： 上架</h4>
																			</c:when>
																			
																			<c:when test="${groupbuyVO.status eq 2}">
																				<h4 class="mt-5">狀態： 已達標</h4>
																			</c:when>
																			
																			<c:when test="${groupbuyVO.status eq 3}">
																				<h4 class="mt-5">狀態： 未達標</h4>
																			</c:when>
																		</c:choose>
																		<h4>原價： $<fmt:formatNumber pattern="#" value="${productSvc.getOnePro(groupbuyVO.p_id).p_price}" /></h4>
																		<h4>折扣1： ${rebateSvc.getOneRebate(groupbuyVO.reb1_no).people} 人 / $<fmt:formatNumber pattern="#" value="${rebateSvc.getOneRebate(groupbuyVO.reb1_no).discount * productSvc.getOnePro(groupbuyVO.p_id).p_price}" /> 元</h4>
																		<h4>折扣2： ${rebateSvc.getOneRebate(groupbuyVO.reb2_no).people} 人 / $<fmt:formatNumber pattern="#" value="${rebateSvc.getOneRebate(groupbuyVO.reb2_no).discount * productSvc.getOnePro(groupbuyVO.p_id).p_price}" /> 元</h4>
																		<h4>折扣3： ${rebateSvc.getOneRebate(groupbuyVO.reb3_no).people} 人 / $<fmt:formatNumber pattern="#" value="${rebateSvc.getOneRebate(groupbuyVO.reb3_no).discount * productSvc.getOnePro(groupbuyVO.p_id).p_price}" /> 元</h4>
																		<h5>截止時間： <fmt:formatDate value="${groupbuyVO.end_date}" pattern="yyyy-MM-dd hh:mm:ss" /></h5>
																	</div>
																	<div class="col-6">
																		<div class="row mt-5">
																			<div class="col-6 align-self-end">
																				<form action="<%=request.getContextPath()%>/groupbuy/groupbuy.do" method="post">
																					<input type="hidden" name="gro_id" value="${groupbuyVO.gro_id}">
																					<input type="hidden" name="from" value="back-end">
																					<input type="hidden" name="action" value="getOne_For_Update">
																					<button type="submit" class="btn btn-danger btn-lg btn-block text-dark" style="height: 250px">修改</button>
																				</form>
																			</div>
																			<div class="col-6 align-self-end">
																				<form action="<%=request.getContextPath()%>/groupbuy/groupbuy.do" method="post">
																					<input type="hidden" name="gro_id" value="${groupbuyVO.gro_id}">
																					<input type="hidden" name="from" value="back-end">
																					<input type="hidden" name="action" value="deploy">																			
																					<button type="submit" class="btn btn-danger btn-lg btn-block text-dark" style="height: 250px">上/下 架</button>
																				</form>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
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
            </div>
            
        </main>
    </div>


</body>

</html>