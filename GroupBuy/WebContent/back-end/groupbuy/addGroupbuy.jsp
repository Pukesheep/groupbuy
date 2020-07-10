<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.groupbuy.model.*" %>
<%@ page import="com.product.model.*" %>

<jsp:useBean id="groupbuySvc" scope="page" class="com.groupbuy.model.GroupbuyService" />
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
    
    <!-- datetimepicker -->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/files/datetimepicker/jquery.datetimepicker.css" />
	<script src="<%=request.getContextPath()%>/files/datetimepicker/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/files/datetimepicker/jquery.datetimepicker.full.js"></script>
    
    
    

    <title>新增團購</title>
    
    <style>
    	img.card-header {
    		height: 300px;
    	}
    	body{
	 		background-image: url('http://getwallpapers.com/wallpaper/full/a/5/d/544750.jpg'); 
	/* 		background-image: url('http://getwallpapers.com/wallpaper/full/6/e/8/90110.jpg'); */
	/*  		background-image: url('http://getwallpapers.com/wallpaper/full/a/e/e/7532.jpg');  */
			background-size: cover;
			background-repeat: no-repeat;
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
		
			
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-10">
						<div class="card mt-5">
							<div class="card-body bg-info">
								<div class="media">
									<img src="<%=request.getContextPath()%>/images/groupbuy/addGroupbuy.png" class="mr-3" alt="">
									<div class="media-body">
										<h1 class="mt-0">新增團購案</h1>
										<div class="media mt-3">
											<div class="media-body">
												<h3 class="mt-0">請輸入團購案詳情</h3>
													<form action="">
														<div class="form-group">
															<label for="exampleInputEmail1" class="text-white">團購開始時間</label>
															<div class="input-group mb-3">
																<div class="input-group-prepend">
																	<span class="input-group-text" id="basic-addon1"><i class="fas fa-calendar-plus"></i></span>
																</div>
																<input type="text" class="form-control text-center" id="start_date" name="start_date" readonly>
															</div>
														</div>
														
														<div class="form-group">
															<label for="exampleInputEmail1" class="text-white">團購案活動期間</label>
															<div class="input-group mb-3">
																<div class="input-group-prepend">
																	<span class="input-group-text " id="basic-addon1"><i class="fas fa-calendar-minus"></i></span>
																</div>
																<select class="custom-select" name="grotime">
																	<c:forEach begin="1" end="7" varStatus="s">
																		<option value="${s.count}">${s.count} 天</option>
																	</c:forEach>
																</select>
															</div>
														</div>
														
														<div class="form-group">
															<label for="exampleInputEmail1" class="text-white">團購案截止時間</label>
															<div class="input-group mb-3">
																<div class="input-group-prepend">
																	<span class="input-group-text" id="basic-addon1"><i class="fas fa-calendar-times"></i></span>
																</div>
																<input type="text" class="form-control text-center" id="end_date" name="end_date" readonly>
															</div>
														</div>
														
														<div class="input-group mb-3">
															<div class="input-group-prepend">
																<span class="input-group-text" id="basic-addon1"><i class="fas fa-gift"></i></span>
															</div>	
															<select class="custom-select" name="p_id">
																<c:forEach var="productVO" items="${productSvc.all}" varStatus="q">
																	<option value="${productVO.p_id}">品名 ： ${productVO.p_name} － 原價 $<fmt:formatNumber pattern="#" value="${productVO.p_price}" /> 元</option>
																	<c:set var="p_id" value="${q.index}" />
																</c:forEach>
															</select>
														</div>
														
														<div class="input-group mb-3">
															<div class="input-group-prepend">
																<span class="input-group-text" id="basic-addon1"><i class="fas fa-percent"></i></span>
															</div>
															
															<select class="custom-select" name="reb1_no">
																<c:forEach var="rebateVO" items="${rebateSvc.all}">
																	<option value="${rebateVO.reb_no}">${rebateVO.people} 人 / <fmt:formatNumber pattern="#" value="${rebateVO.discount * 100}" />%</option>
																</c:forEach>
															</select>
	
															<select class="custom-select" name="reb2_no">
																<c:forEach var="rebateVO" items="${rebateSvc.all}">
																	<option value="${rebateVO.reb_no}">${rebateVO.people} 人 / <fmt:formatNumber pattern="#" value="${rebateVO.discount * 100}" />%</option>
																</c:forEach>
															</select>
															
															<select class="custom-select" name="reb3_no">
																<c:forEach var="rebateVO" items="${rebateSvc.all}">
																	<option value="${rebateVO.reb_no}">${rebateVO.people} 人 / <fmt:formatNumber pattern="#" value="${rebateVO.discount * 100}" />%</option>
																</c:forEach>
															</select>
															
														</div>
														
														<div class="input-group mb-3">
															<div class="input-group-prepend">
																<span class="input-group-text" id="basic-addon1"><i class="fas fa-percent"></i></span>
															</div>
															<input type="text" class="form-control text-center" readonly id="result1">
															<input type="text" class="form-control text-center" readonly id="result2">
															<input type="text" class="form-control text-center" readonly id="result3">
														</div>
														<div class="row justify-content-center">
															<div class="col-6 text-center">
																<div class="btn-group dropright">
																	<button class="btn btn-warning dropdown-toggle btn-lg" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">確認</button>
																
																	<div class="dropdown-menu">
																		<input type="hidden" name="action" value="insert">
																		<button type="button" class="btn btn-warning dropdown-item">送出</button>
																	</div>
																</div>
															</div>
														</div>
														
													</form>
<script>

	$("select[name='p_id']").change(thePrice);
	$("select[name='reb1_no']").change(thePrice);
	$("select[name='reb2_no']").change(thePrice);
	$("select[name='reb3_no']").change(thePrice);
	
	function thePrice(){
		var p_id = 		$("select[name='p_id']").val();
		var reb1_no = 	$("select[name='reb1_no']").val();
		var reb2_no = 	$("select[name='reb2_no']").val();
		var reb3_no = 	$("select[name='reb3_no']").val();
		
		var price = ${p_id};
		console.log(price);
		
		
		
	}
	
	$("select[name='grotime']").change(function(){
		var grotime = $(this).val();
		var nowLong = new Date().getTime();
		var endLong = nowLong + grotime * 24 * 60 * 60 * 1000;
		var end_date = new Date(endLong);
		
		$('#start_date').datetimepicker({
		    theme: '',              //theme: 'dark',
		     timepicker:true,       //timepicker:true,
		     step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
		     format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
			   value: new Date(), // value:   new Date(),
		    //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
		    //startDate:	            '2017/07/10',  // 起始日
		    //minDate:               '-1970-01-01', // 去除今日(不含)之前
		    //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
		 });
		
		$('#end_date').datetimepicker({
		    theme: '',              //theme: 'dark',
		     timepicker:true,       //timepicker:true,
		     step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
		     format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
			   value: new Date(endLong), // value:   new Date(),
		    //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
		    //startDate:	            '2017/07/10',  // 起始日
		    //minDate:               '-1970-01-01', // 去除今日(不含)之前
		    //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
		 });
	});
	
	
	$.datetimepicker.setLocale('zh');

	$('#start_date').datetimepicker({
	    theme: '',              //theme: 'dark',
	     timepicker:true,       //timepicker:true,
	     step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	     format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: new Date(), // value:   new Date(),
	    //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	    //startDate:	            '2017/07/10',  // 起始日
	    //minDate:               '-1970-01-01', // 去除今日(不含)之前
	    //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	 });
	
	// ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

//	      1.以下為某一天之前的日期無法選擇
//	      var somedate1 = new Date('2017-06-15');
//	      $('#f_date1').datetimepicker({
//	          beforeShowDay: function(date) {
//	        	  if (  date.getYear() <  somedate1.getYear() || 
//			           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
//			           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
//	              ) {
//	                   return [false, ""]
//	              }
//	              return [true, ""];
//	      }});


//	      2.以下為某一天之後的日期無法選擇
//	      var somedate2 = new Date('2017-06-15');
//	      $('#f_date1').datetimepicker({
//	          beforeShowDay: function(date) {
//	        	  if (  date.getYear() >  somedate2.getYear() || 
//			           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
//			           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
//	              ) {
//	                   return [false, ""]
//	              }
//	              return [true, ""];
//	      }});


//	      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
//	      var somedate1 = new Date('2017-06-15');
//	      var somedate2 = new Date('2017-06-25');
//	      $('#f_date1').datetimepicker({
//	          beforeShowDay: function(date) {
//	        	  if (  date.getYear() <  somedate1.getYear() || 
//			           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
//			           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
//			             ||
//			            date.getYear() >  somedate2.getYear() || 
//			           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
//			           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
//	              ) {
//	                   return [false, ""]
//	              }
//	              return [true, ""];
//	      }});

	
</script>
													
												
												
												
												
												
												<div class="row justify-content-center mt-2">
													<div class="col-4">
														<h2 class="mt-0 text-left">團購商品</h2>
<%-- 														<img alt="" src="<%=request.getContextPath()%>/product/proPic.do?p_id=${groupbuyVO.p_id}"> --%>
															<img src="<%=request.getContextPath()%>/images/groupbuy/addGroupbuy.png" class="" alt="">													</div>
													<div class="col-8">
														<h2 class="mt-0 text-left">商品描述</h2>
														2131231
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
			</div>
            
        </main>
    </div>
<script>
	
	
	
</script>

</body>

</html>