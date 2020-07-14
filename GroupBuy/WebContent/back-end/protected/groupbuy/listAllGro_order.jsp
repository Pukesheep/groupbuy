<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gro_order.model.*" %>
<%@ page import="com.ordstat.model.*" %>

<%
	Gro_orderService gro_orderSvc = new Gro_orderService();
	List<Gro_orderVO> list = gro_orderSvc.getAll();
	pageContext.setAttribute("list", list);
 %>
 
 <jsp:useBean id="ordstatSvc" scope="page" class="com.ordstat.model.OrdstatService" />

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
    
     <!-- SweetAlert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>    
    

    <title>團購訂單管理</title>
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
		<li class="breadcrumb-item active text-warning" aria-current="page">團購訂單管理</li>
	</ol>
</nav>

<div class="container-fluid">
	<div class="row justify-content-center">
		<div class="col-11">
			<div class="card alert alert-dark">
				<div class="card-header">
					<h1 class="card-title text-dark">團購訂單管理</h1>
				</div>
				<%@ include file="../../../files/page1B.file" %>
				<div class="card-body">
					<div class="row">
						<c:forEach var="gro_orderVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
							<div class="col-6">
								<div class="card alert alert-danger">
									<div class="card-header"><h3>訂單資訊</h3></div>
									<div class="card-body">
										<div class="media alert alert-success text-dark">
											<div class="media-body">
												<div class="row justify-content-around align-items-center">
													<div class="col-5">
														<c:forEach var="ordstatVO" items="${ordstatSvc.all}">
															<c:if test="${ordstatVO.ordstat_id eq gro_orderVO.ordstat_id}">
																<h6>訂單狀態： ${ordstatVO.ordstat}</h6>
															</c:if>
														</c:forEach>
														<h6>訂單編號： ${gro_orderVO.ord_id}</h6>
														<h6>團購編號： ${gro_orderVO.gro_id}</h6>
														<h6>會員編號： ${gro_orderVO.mem_id}</h6>
													</div>
													<div class="col-7">
														<div class="row">
															<div class="col-6">
																<c:if test="${gro_orderVO.ordstat_id eq '003'}">
																	<form action="<%=request.getContextPath()%>/gro_order/gro_order.do" method="post">
																		<input type="hidden" name="ordstat_id" value="005">
																		<input type="hidden" name="ord_id" value="${gro_orderVO.ord_id}">
																		<input type="hidden" name="from" value="back-end">
																		<input type="hidden" name="action" value="manage">
																		<button type="submit" class="btn btn-outline-primary btn-lg btn-block">出貨</button>
																	</form>
																</c:if>
															</div>
															<div class="col-6">
																<form action="<%=request.getContextPath()%>/gro_order/gro_order.do" method="post">
																	<input type="hidden" name="ord_id" value="${gro_orderVO.ord_id}">
																	<input type="hidden" name="from" value="back-end">
																	<input type="hidden" name="action" value="getOne_For_Display">
																	<button type="submit" class="btn btn-outline-dark btn-lg btn-block">訂單詳情</button>
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
						</c:forEach>
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