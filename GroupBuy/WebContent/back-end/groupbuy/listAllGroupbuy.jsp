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
    <link rel="shortcut icon" href="./img/ICON.ico">
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
    
    
    <title>團購區</title>
    
    <style>
    	body{
  	 		background-image: url('http://getwallpapers.com/wallpaper/full/a/5/d/544750.jpg');   
/* 		background-image: url('http://getwallpapers.com/wallpaper/full/6/e/8/90110.jpg'); */
/*  			background-image: url('http://getwallpapers.com/wallpaper/full/a/e/e/7532.jpg');   */
/*   			background-image: url('http://getwallpapers.com/wallpaper/full/a/e/e/7532.jpg');   */
			background-size: cover;
			background-repeat: no-repeat;
		}
		img#groupbuyHeader {
			height: 250px;
		}
		img.card-display {
			height: 350px;
		}
		img.card-display:hover {
			cursor: pointer;
		}
		a.groupbuydetail {
			color:white; text-decoration:none;
		}
		a.groupbuydetail:visited {
			text-decoration:none;
		}
		a.groupbuydetail:hover {
			color:#00334e;text-decoration:none;
		}
		a.groupbuydetail:active {
			color:white;
		}
		
    </style>
    
</head>

<body>
<!-- header -->
	
	<%@ include file="../css/header.jsp" %>
<!-- header -->

    <div class="content d-md-flex">

<!-- aside -->
	<%@ include file="../css/aside.jsp" %>
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

            <div class="container-fluid">
                <div class="row justify-content-center mt-5">
                	<div class="col-10">
                		<div class="card bg-info">
							<img alt="" src="<%=request.getContextPath()%>/images/groupbuy/watermelon.jpg" id="groupbuyHeader">	
								<div class="card-body">
									<h1 class="card-text">團購案列表</h1>
									<div class="row">
										<c:forEach var="groupbuyVO" items="${list}">
											<c:if test="${groupbuyVO.status eq 0}">
												<div class="col-6">
													<div class="card border border-warning mt-2">
														<img class="card-display" alt="" src="<%=request.getContextPath()%>/product/proPic.do?p_id=${groupbuyVO.p_id}" onclick="location.href='<%=request.getContextPath()%>/groupbuy/groupbuy.do?action=getOne_For_Display&from=back-end&gro_id=${groupbuyVO.gro_id}';">
														<div class="card-body text-white bg-secondary">
															<c:forEach var="productVO" items="${productSvc.all}">
																<c:if test="${productVO.p_id == groupbuyVO.p_id}">
																	<a href="<%=request.getContextPath()%>/groupbuy/groupbuy.do?action=getOne_For_Display&from=back-end&gro_id=${groupbuyVO.gro_id}" class="groupbuydetail">
																		<h2>${productVO.p_name}</h2>
																	</a>
																	<h4>原價 $<fmt:formatNumber pattern="#" value="${productVO.p_price}" /></h4>
																	<h6>結束時間： <fmt:formatDate value="${groupbuyVO.end_date}" pattern="yyyy-MM-dd HH:mm:ss" /></h6>
																</c:if>
															</c:forEach>
															<a href="<%=request.getContextPath()%>/groupbuy/groupbuy.do?action=getOne_For_Display&from=back-end&gro_id=${groupbuyVO.gro_id}">
																<button type="button" class="btn btn-success btn-lg btn-block mt-3">查看團購案詳情</button>
															</a>
														</div>
													</div>
												</div>
											</c:if>
										</c:forEach>
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