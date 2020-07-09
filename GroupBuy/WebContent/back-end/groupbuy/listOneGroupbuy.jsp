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
    		border: 3px dashed red;
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
							<div class="card-body bg-info">
								<c:forEach var="productVO" items="${productSvc.all}">
									<c:if test="${groupbuyVO.p_id eq productVO.p_id}">
										<div class="media">
											<img src="<%=request.getContextPath()%>/product/proPic.do?p_id=${groupbuyVO.p_id}" class="align-self-start mr-3 product_image rounded" alt="">
											<div class="media-body">
												<h3 class="mt-0 mb-3">${productVO.p_name}</h3>
												<pre class="text-white">${productVO.p_info}</pre>
													<span class="badge badge-pill badge-success">
														<img alt="" src="<%=request.getContextPath()%>/images/groupbuy/fire.png" id="burning">
														<h6>
															<fmt:formatDate value="${groupbuyVO.start_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
														</h6>
													</span>
												
												<span class="badge badge-pill badge-success">
													<fmt:formatDate value="${groupbuyVO.start_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
												</span>
												
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
			console.log(end_date);
			var now = new Date().getTime();
			var remain = end_date - now;
			console.log(remain);
			var ok = new Date(remain);
			console.log(ok);
			
		}, 1000);
	}
	
	window.onload = init;
</script>


</body>

</html>