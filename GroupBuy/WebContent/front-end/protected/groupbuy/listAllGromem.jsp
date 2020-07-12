<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<%@ page import="com.groupbuy.model.*" %>
<%@ page import="com.product.model.*" %>
<%@ page import="com.rebate.model.*" %>
<%@ page import="com.gromem.model.*" %>
<%@ page import="com.member.model.*" %>

<%
	MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
	GromemService gromemSvc = new GromemService();
	List<GromemVO> list = gromemSvc.getAllByM(memberVO.getMem_id());
	pageContext.setAttribute("list", list);
%>

<jsp:useBean id="groupbuySvc" scope="page" class="com.groupbuy.model.GroupbuyService" />
<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProService" />
<jsp:useBean id="rebateSvc" scope="page" class="com.rebate.model.RebateService" />

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>我的團購</title>
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

<nav aria-label="breadcrumb">
	<ol class="breadcrumb bg-transparent">
		<li class="breadcrumb-item"><a class="bread" href="<%=request.getContextPath()%>/front-end/index.jsp">前台首頁</a></li>
		<li class="breadcrumb-item"><a class="bread" href="<%=request.getContextPath()%>/front-end/groupbuy/listAllGroupbuy.jsp">團購列表</a></li>
		<li class="breadcrumb-item active text-warning" aria-current="page">我的團購</li>
	</ol>
</nav>

            <div class="container-fluid">
                <div class="row justify-content-center mt-1">
                	<div class="col-10">
                		<div class="card bg-info">
							<img alt="" src="<%=request.getContextPath()%>/images/groupbuy/watermelon.jpg" id="front-end-Header">	
								<div class="card-body">
									<h1 class="card-text">團購列表</h1>
									<%@ include file="../../../files/page1B.file" %>
									<div class="row">
										<div class="col">
											<div class="media m-3">
												<div class="media-body">
													<c:forEach var="gromemVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
														<c:forEach var="groupbuyVO" items="${groupbuySvc.all}">
															<c:if test="${groupbuyVO.gro_id eq gromemVO.gro_id}">
																<div class="media mt-3 alert alert-danger">
																	<a class="mr-3" href="<%=request.getContextPath()%>/groupbuy/groupbuy.do?action=getOne_For_Display&from=front-end&gro_id=${groupbuyVO.gro_id}">
																		<img src="<%=request.getContextPath()%>/product/proPic.do?p_id=${groupbuyVO.p_id}" class="align-self-end mr-3 img-listAll" alt="">
																	</a>
																	<div class="media-body bg-secondary p-4">
																		<div class="row">
																			<div class="col">
																				<a href="<%=request.getContextPath()%>/groupbuy/groupbuy.do?action=getOne_For_Display&from=front-end&gro_id=${groupbuyVO.gro_id}">
																					<h3 class="mt-0 text-white mb-3">${productSvc.getOnePro(groupbuyVO.p_id).p_name}</h3>
																				</a>
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
																				<a href="<%=request.getContextPath()%>/groupbuy/groupbuy.do?action=getOne_For_Display&from=front-end&gro_id=${groupbuyVO.gro_id}">
																					<button type="button" class="btn btn-success btn-lg btn-block mt-3">查看團購詳情</button>
																				</a>
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