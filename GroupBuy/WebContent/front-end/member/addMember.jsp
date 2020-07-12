<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.member.model.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>註冊會員</title>
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
	
</head>

<body>
    <!-- navbar -->
		<%@ include file="../../files/header.jsp" %>
    <!-- navbar end -->
    <section class="blank0"></section>
    <!-- 內容 -->
    <section class="blank1">
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
					  title: '<%=message%>',
					})

			</script>
		</c:if>
		
<div class="container">
	<div class="d-flex justify-content-center h-100">
		<div class="card login">
			<div class="card-header">
				<h3>註冊</h3>
				<div class="d-flex justify-content-end social_icon">
					<span><i class="fas fa-user-plus"></i></span>
				</div>
			</div>
			<div class="card-body">
				<form action="<%=request.getContextPath()%>/member/member.do" method="post">
					<div class="input-group form-group">
						<div class="input-group-prepend forlogin">
							<span class="input-group-text"><i class="fas fa-user"></i></span>
						</div>
						<input type="text" name="mem_name" class="form-control" placeholder="會員名稱" autocomplete="off" id="mem_name">
						
					</div>
					<div class="input-group form-group">
						<div class="input-group-prepend forlogin">
							<span class="input-group-text"><i class="fas fa-envelope"></i></span>
						</div>
						<input id="mem_email" type="text" name="mem_email" class="form-control" placeholder="電子信箱" autocomplete="off" id="mem_email">
					</div>
					<font id="font" class="hint"></font>
					<img id="check" class="invisible">
					<div class="form-group">
						<input type="hidden" name="action" value="signup">
						<input type="submit" value="註冊" class="btn float-right login_btn" id="btn-submit">
					</div>
				</form>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="success" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content bg-dark">
			<div class="modal-header text-white">
				<h6 class="modal-title display-4" id="exampleModalCenterTitle">註冊成功</h6>
			</div>
		<div class="modal-body text-white">
			<p>
				歡迎成為 S.F.G 的會員！
			</p>
			<p>
				請到註冊的電子信箱收取信件,
			</p>
			<p>
				 並使用當中的密碼登入
			</p>
		</div>
		<div class="modal-footer text-white">
			<font>
				三秒後轉至登入頁面	或	
			</font>
			<a href="<%=request.getContextPath()%>/front-end/member/login.jsp"><button type="button" class="btn btn-warning btn-tologin">前往登入</button></a>
		</div>
		</div>
	</div>
</div>


<script>
	$('#mem_email').blur(function() {
		
		var font = document.getElementById('font');
		var mem_email = $(this).val().trim();
		var ok = /[.(a-zA-Z)0-9]/g.test(mem_email) && mem_email.includes('@');
		if (ok === true) {
			$.ajax({
				url: '<%=request.getContextPath()%>/member/check.do',
				type: 'post',
				data: {
					action: 'check',
					mem_email: mem_email
				},
				dataType: 'json',
				success: function(data){
					if (data !== null) {
						$('#check').attr('class', 'visible');
						if (data.isUsed === false){
							$('#check').attr('src', '<%=request.getContextPath()%>/images/icons/checked.png');
							font.innerText = '此電子信箱可使用';
						} else {
							$('#check').attr('src', '<%=request.getContextPath()%>/images/icons/cross.png');
							font.innerText = '此電子信箱不可使用';
						}
					}
				}
			});
		} 
	});
	
	$('#mem_email').focus(function(){
		var font = document.getElementById('font');
		font.innerText = '';
		$('#check').attr('class', 'invisible');
	});
	
	$('#btn-submit').click(function(){
		$('#success').modal('show');
	})
	
	
</script>











    </section>
    <!-- 內容 ---end  -->


        <!-- footer -->
			<%@ include file="../../files/footer.jsp" %>
        <!-- footer -->

</body>

</html>