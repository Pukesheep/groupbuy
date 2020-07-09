<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.groupbuy.model.*" %>
<%@ page import="com.product.model.*" %>

<%
	GroupbuyVO groupbuyVO = (GroupbuyVO) request.getAttribute("groupbuyVO");
%>

<jsp:useBean id="groupbuySvc" scope="page" class="com.groupbuy.model.GroupbuyService" />
<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProService" />
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
    


    <title>團購案詳情</title>
    
    <style>
    	img.product_image {
    		width: 40%;
    		height: 40%;
    		border: 3px dashed yellow;
    		padding: 5px;
    	}
    	img#burning {
    		width: 40px;
    		height: 40px;
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
			
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-11">
						<div class="card mt-5">
							<div class="card-body bg-secondary">
								<c:forEach var="productVO" items="${productSvc.all}">
									<c:if test="${groupbuyVO.p_id eq productVO.p_id}">
										<div class="media">
											<img src="<%=request.getContextPath()%>/product/proPic.do?p_id=${groupbuyVO.p_id}" class="align-self-center mr-3 product_image rounded" alt="">
											<div class="media-body w-10">
												<h3 class="mt-0 mb-3 alert alert-primary">${productVO.p_name}</h3>
												<pre class="alert alert-primary">${productVO.p_info}</pre>
												<div class="row justify-content-around alert alert alert-primary ml-0 mr-0">
													<div class="col-3 text-center">
														<button type="button" class="btn btn-outline-danger btn-sm" data-container="body" data-toggle="popover" data-placement="top" data-content="目前團購案人數 ： ${groupbuyVO.people} 人">
															參與人數
														</button>
													</div>
													<div class="col-6 text-center">
														<button type="button" class="btn btn-outline-warning btn-sm" id="reveal" data-container="body" data-toggle="popover" data-placement="top" data-content="剩餘時間">
															0 天 00 小時 00 分鐘 00 秒
														</button>
													</div>	
													<div class="col-3 text-center">
														<button type="button" class="btn btn-outline-success btn-sm">
															立即參加
														</button>
													</div>
												</div>	
											</div>
										</div>
										<div class="row justify-content-center">
											<div class="col-11 alert alert-primary">
<!-- 												<div class="progress"> -->
<%-- 													<h4><span class="badge badge-pill badge-secondary">${productVO.p_price}</span></h4> --%>
<%-- 													<div class="progress-bar bg-danger" role="progressbar" style="width: 33.3%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">${groupbuyVO.reb1_no}</div> --%>
													
<%-- 													<div class="progress-bar bg-warning" role="progressbar" style="width: 33.3%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">${groupbuyVO.reb2_no}</div> --%>
													
<%-- 													<div class="progress-bar bg-success" role="progressbar" style="width: 33.3%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">${groupbuyVO.reb3_no}</div> --%>
<!-- 												</div> -->
												<h6><span class="badge badge-pill badge-secondary">${productVO.p_price}</span></h6>
												<div class="progress" style="height: 25px">
													<div class="progress-bar bg-danger" id="1stlevel" role="progressbar" style="width: 100%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"> 5 人</div>
													<h5><span class="badge badge-secondary">$${productVO.p_price * 0.9}</span></h5>
												</div>
												<h5><span class="badge badge-pill badge-secondary">${productVO.p_price * 0.9}</span></h5>
												<div class="progress">
													<div class="progress-bar bg-warning" id="2ndlevel" role="progressbar" style="width: 33.3%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"> 10 人</div>
												</div>												
												<h3><span class="badge badge-pill badge-secondary">${productVO.p_price * 0.85}</span></h3>
												<div class="progress">
													<div class="progress-bar bg-success" id="3rdlevel" role="progressbar" style="width: 33.3%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"> 15 人</div>
												</div>														
												<h1><span class="badge badge-pill badge-secondary">${productVO.p_price * 0.8}</span></h1>
												
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
            
        </main>
    </div>

<script>
	<%
		Long end_date = groupbuyVO.getEnd_date().getTime();
	%>
	function init(){
		var end_date = <%=end_date%>;
		var timer = setInterval(function(){
			var now = new Date().getTime();
			var remain = Math.ceil((end_date - now) / 1000);
			var day = Math.floor(remain / 86400);
			var hour = Math.floor(remain % 86400 / 3600);
			var minute = Math.floor((remain % 86400 % 3600) / 60);
			var second = (((remain % 86400) % 3600) % 60);
			
			$('#reveal').text(day + ' 天 ' + hour + ' 小時 ' + minute + ' 分鐘 ' + second + ' 秒 ');
			
		}, 1000);
	}
	
	window.onload = init;
	
	function progressbar(){
		var timer1 = setInterval(function(){
			var current = 	5;
			var first = 	(current / 5 * 100) + '%';
			var second = 	(current / 10 * 100) + '%';
			var third = 	(current / 15 * 100) + '%';
			
			$('#1stlevel').attr('style', 'width:' + first);
			$('#2ndlevel').attr('style', 'width:' + second);
			$('#3rdlevel').attr('style', 'width:' + third);			
		}, 1000);
		
	}
	
	window.onload = progressbar;
	
	$(function () {
		$('[data-toggle="popover"]').popover()
	})
</script>


</body>

</html>