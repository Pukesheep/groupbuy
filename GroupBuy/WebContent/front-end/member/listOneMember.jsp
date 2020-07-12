<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.member.model.*" %>

<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>查詢會員</title>
    <!-- TODO: 換title 的icon -->
    <link rel="icon shortcut" href="<%=request.getContextPath()%>/front-end/img/ICON.ico">
    <!-- Bootstrap官方網站 https://getbootstrap.com/ -->
    <!-- 連結Bootstrap.min.css -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- 使用font awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css"
        integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
    <!-- 使用google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Sedgwick+Ave+Display&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lakki+Reddy&display=swap" rel="stylesheet">

    <!-- 使用style.css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

    <!-- 連結Bootstrap所需要的js -->
    <!-- jquery.min.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- popper.min.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
    <!-- bootstrap.min.js -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
        
    <!-- SweetAlert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	
	<!-- member.css -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/member.css">
	<!-- datetimepicker -->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/files/datetimepicker/jquery.datetimepicker.css" />
	<script src="<%=request.getContextPath()%>/files/datetimepicker/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/files/datetimepicker/jquery.datetimepicker.full.js"></script>
	
	<!-- tw-city-selector -->
	<script src="<%=request.getContextPath()%>/files/tw-city-selector/tw-city-selector.min.js"></script>
	
<style>
</style>	
	
</head>

<body>
    <!-- navbar -->
		<%@ include file="../../files/header.jsp" %>
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
<%-- 錯誤表列 --%>

</c:if>

<div class="container">
<div calss="row" style="display:flex">
	<div class="col-10">
	<div class="row justify-content-center">
	<div class="col">
		<div class="text-center">
		<label for="upload">
			<img alt="" src="<%=request.getContextPath()%>/member/ShowMemberPic.do?mem_id=${memberVO.mem_id}" class="profile rounded-circle showprofile" id="display">
			<c:if test="${requestScope.memberVO.mem_id ne sessionScope.memberVO.mem_id}">
				<img alt="" src="<%=request.getContextPath()%>/images/chat.png" id="chat_bubble" title="聊天">
			</c:if>
		</label>
		</div>
		</div>
		</div>
		<div class="card profile text-white">
			<form action="<%=request.getContextPath()%>/member/member.do" method="post" enctype="multipart/form-data" class="profile">
				<div class="card-body">
				
					<div class="form-group profile-header">
						<label for="mem_name">會員名稱</label>
						<input type="text" class="form-control" id="mem_name" name="mem_name" value="${memberVO.mem_name}" readonly>
					</div>
					
					<div class="form-group">
						<label for="mem_email">會員信箱</label>
						<input type="text" class="form-control" id="mem_email" name="mem_email" value="${memberVO.mem_email}" readonly>
					</div>
					
					<div class="form-group">
						<label for="mem_birth">會員生日</label>
						<input type="text" class="form-control" id="mem_birth" name="mem_birth" value="${memberVO.mem_birth}" readonly>
					</div>		
					
					<% 
						String autho = "";
						switch (memberVO.getMem_autho()){
							case 0:
								autho = "停權";
								break;
							case 1:
								autho = "一般會員";
								break;
							case 2:
								autho = "賣家資格會員";
								break;
							case 99:
								autho = "平台管理員";
								break;
						}
 					%>			 
					
					<div class="form-group">
						<label for="mem_autho">會員權限</label>
						<input type="text" class="form-control" id="mem_autho" value="<%=autho%>" readonly>
					</div>


					<div class="form-group">
						<label for="mem_warn">警告次數</label>
						<input type="text" class="form-control" id="mem_warn" name="mem_warn" value="${memberVO.mem_warn}" readonly>
					</div>

					<div class="form-group">
						<label for="mem_joindat">加入日期</label>
						<input type="text" class="form-control" id="mem_joindat" name="mem_joindat" value="${memberVO.mem_joindat}" readonly>
					</div>
					
					<c:if test="${requestScope.memberVO.mem_id == sessionScope.memberVO.mem_id}">
						<input type="hidden" name="mem_id" value="${memberVO.mem_id}">
						<input type="hidden" name="action" value="getOne_For_Update-front">
						<button type="submit" class="btn login_btn float-right submit">修改資料</button>
					</c:if>
				</div>
			</form>
		</div>
		</div>
		<div class="col-2">
<!--開改 -->
		<div class="ptlist" style="margin-top:120px;margin-right:60px;width:170px">

<div class="Now block" style="width:170px;height:170px;display: flex;background-color:#c6d4df;margin-bottom:4px;border-radius:10px">
	<div style="text-align:center; margin-top:70px;width:100%"><font style="font-weight:bold;font-size:20px;font-family:Microsoft JhengHei;">會員中心</font></div>
	</div>
	
<div class="list-group">
	<div class="list-group-item active">
		<h4 class="list-group-item-heading">
			商城
		</h4>
	</div>
	<a href="<%=request.getContextPath()%>/front-end/protected/productorder/listProductOrderIndex.jsp" class="list-group-item">
		<h4 class="list-group-item-heading">
			訂單管理
		</h4>
	</a>

</div>

<div class="list-group">
	<div class="list-group-item active">
		<h4 class="list-group-item-heading">
			直購區
		</h4>
	</div>
	<a href="<%=request.getContextPath()%>/front-end/product/listAllProductByPt.jsp?pt_id=PT004" class="list-group-item">
		<h4 class="list-group-item-heading">
			選項1
		</h4>
	</a>
	<a href="<%=request.getContextPath()%>/front-end/product/listAllProductByPt.jsp?pt_id=PT005" class="list-group-item">
		<h4 class="list-group-item-heading">
			選項2
		</h4>
	</a>
	<a href="<%=request.getContextPath()%>/front-end/product/listAllProductByPt.jsp?pt_id=PT006" class="list-group-item">
		<h4 class="list-group-item-heading">
			選項3
		</h4>
	</a>
</div> 

<div class="list-group">
	<div class="list-group-item active">
		<h4 class="list-group-item-heading">
			競標區
		</h4>
	</div>
	<a href="<%=request.getContextPath()%>/front-end/product/listAllProductByPt.jsp?pt_id=PT007" class="list-group-item">
		<h4 class="list-group-item-heading">
			1
		</h4>
	</a>
	<a href="<%=request.getContextPath()%>/front-end/product/listAllProductByPt.jsp?pt_id=PT008" class="list-group-item">
		<h4 class="list-group-item-heading">
			2
		</h4>
	</a>
	<a href="<%=request.getContextPath()%>/front-end/product/listAllProductByPt.jsp?pt_id=PT009" class="list-group-item">
		<h4 class="list-group-item-heading">
			3
		</h4>
	</a>
	
</div>

</div>
</div>
<!-- 開改 -->
		</div>
</div>

	
    <!-- 內容 ---end  -->


        <!-- footer -->
			<%@ include file="../../files/footer.jsp" %>
		<!-- footer -->
</body>

</html>