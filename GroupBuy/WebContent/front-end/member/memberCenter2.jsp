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
    <title>會員中心</title>
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
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/member.css">
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
    <!-- 使用Boostrap Navbar -->
    <!-- 設定Navbar緊貼畫面上緣 -->
    <!-- b4-navbar-default 安裝Bootstrap外掛,可以使用快捷指令 -->
    <nav class="navbar navbar-expand-md navbar-dark fixed-top">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/front-end/index.jsp">
            <span class="logo"><i class="fas fa-bomb"></i></span>
            <span class="logo2">S.F.G</span>
            <span class="logo3">{{{</span>
        </a>
        <!-- 手機選單按鈕 -->
        <button class="navbar-toggler d-lg-none" type="button" data-toggle="collapse" data-target="#collapsibleNavId"
            aria-controls="collapsibleNavId" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="navbar2 navbar-dark">
            <div class="row">
                <div class="item col-md-2"><a href="#"></a>商城</div>
                <div class="item col-md-2"><a href="#"></a>團購</div>
                <div class="item col-md-2"><a href="#"></a>交易</div>
                <div class="item col-md-2"><a href="<%=request.getContextPath()%>/front-end/post/listAllPost.jsp" id="">討論區</a></div>
                <div class="item col-md-2"><a href="#"></a>紅利</div>
                <div class="item col-md-2"><a href="#"></a>Q&A</div>
            </div>
        </div>

        <div class="collapse navbar-collapse" id="collapsibleNavId">
            <ul class="navbar-nav ml-auto">
                <c:if test="${memberVO == null}">
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/front-end/member/login.jsp">登入</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/front-end/member/addMember.jsp">註冊</a>
                </li>
            </c:if>
            <c:if test="${sessionScope.memberVO ne null}">
            	
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/member/member.do?action=getOne_For_Update-front&mem_id=${sessionScope.memberVO.mem_id}">會員中心</a>
                </li>
                <li class="nav-item">
                	<a class="nav-link" href="<%=request.getContextPath()%>/member/login.do?action=logout">登出</a>
                </li>
          	</c:if>
                <li class="nav-item">
                    <a class="nav-link" href="#">我的最愛</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">購物車</a>
                </li>

            </ul>
        </div>


    </nav>
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
	<div class="row justify-content-center">
	<div class="col">
		<div class="text-center">
		<label for="upload">
			<img alt="" src="<%=request.getContextPath()%>/member/ShowMemberPic.do?mem_id=${memberVO.mem_id}" class="profile rounded-circle" id="display">
		</label>
		</div>
		</div>
		</div>
		<div class="card profile text-white">
			<form action="<%=request.getContextPath()%>/member/member.do" method="post" enctype="multipart/form-data" class="profile">
				<div class="card-body">
				
					<div class="form-group profile-header">
						<label for="mem_name">會員名稱</label>
						<input type="text" class="form-control" id="mem_name" name="mem_name" value="${memberVO.mem_name}" autocomplete="off">
					</div>
					
					<div class="form-group">
						<label for="mem_email">會員信箱</label>
						<input type="email" class="form-control" id="mem_email" name="mem_email" value="${memberVO.mem_email}" readonly>
					</div>
					
					<div class="form-group">
						<label for="mem_pass">會員密碼</label>
						<div class="input-group mb-3">
							<input type="password" class="form-control" id="mem_pass" name="mem_pass" value="${memberVO.mem_pass}">
							<div class="input-group-append">
								<span class="input-group-text"><img alt="" src="<%=request.getContextPath()%>/images/icons/opend-eye.png" class="float-right img-icon mem_pass" title="顯示"></span>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label for="mem_phone">會員手機</label>
						<input type="text" class="form-control" id="mem_phone" name="mem_phone" value="${memberVO.mem_phone}" autocomplete="off">
					</div>
					
					<div class="form-group">
						<label for="exampleFormControlSelect1">會員地址</label>
						<div class="my-selector-c">
							<div>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text">縣市</span>
									</div>
									<select class="form-control county" name="county" id="county">
									</select>
								</div>
							</div>
							<div>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text">鄉鎮</span>
									</div>
									<select class="form-control district" name="district" id="district">
									</select>
								</div>
							</div>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">細項</span>
							</div>
							<input type="text" class="form-control" name="detail" id="detail" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" autocomplete="off">
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">地址</span>
							</div>
							<input type="text" class="form-control" name="mem_addr" id="mem_addr" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" value="${memberVO.mem_addr}" readonly>
						</div>						
					</div>
					<%-- 處理地址下拉式選單與手動輸入合併的區塊 --%>
					<script>
						$('#county').change(function(){
							
							$('#mem_addr').val($('#county').val() + $('#district').val() + $('#detail').val());
							
						});
						
						$('#district').change(function(){
							
							$('#mem_addr').val($('#county').val() + $('#district').val() + $('#detail').val());
							
						});
						
						$('#detail').keyup(function(){
							
							$('#mem_addr').val($('#county').val() + $('#district').val() + $('#detail').val());
							
						});
					</script>
					<%-- 處理地址下拉式選單與手動輸入合併的區塊 --%>
					
					<div class="form-group">
						<label for="mem_birth">會員生日</label>
						<input type="text" class="form-control" id="mem_birth" name="mem_birth" autocomplete="off">
					</div>					
					
					<div class="form-group">
						<label for="mem_autho">會員權限</label>
						<input type="text" class="form-control" id="mem_autho" value="${memberVO.mem_autho}" readonly>
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
						}
					%>

					<div class="form-group">
						<label for="mem_bonus">紅利點數</label>
						<input type="text" class="form-control" id="mem_bonus" name="mem_bonus" value="${memberVO.mem_bonus}" readonly>
					</div>

					<div class="form-group">
						<label for="mem_warn">警告次數</label>
						<input type="text" class="form-control" id="mem_warn" name="mem_warn" value="${memberVO.mem_warn}" readonly>
					</div>

					<div class="form-group">
						<label for="mem_joindat">加入日期</label>
						<input type="text" class="form-control" id="mem_joindat" name="mem_joindat" value="${memberVO.mem_joindat}" readonly>
					</div>
					
					<div class="form-group">
						<label for="bank_acc">銀行帳戶</label>
						<input type="text" class="form-control" id="bank_acc" name="bank_acc" value="${memberVO.bank_acc}" autocomplete="off">
					</div>

					<div class="form-group">
						<label for="card_no">信用卡號</label>
						<div class="input-group mb-3">
						<input type="password" class="form-control" id="card_no" name="card_no" value="${memberVO.card_no}" autocomplete="off">
							<div class="input-group-append">
								<span class="input-group-text"><img alt="" src="<%=request.getContextPath()%>/images/icons/opend-eye.png" class="float-right img-icon card_no" title="顯示"></span>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label for="card_yy">到期年份</label>
						<div class="input-group mb-3">
						<input type="password" class="form-control" id="card_yy" name="card_yy" value="${memberVO.card_yy}" autocomplete="off">
							<div class="input-group-append">
								<span class="input-group-text"><img alt="" src="<%=request.getContextPath()%>/images/icons/opend-eye.png" class="float-right img-icon card_yy" title="顯示"></span>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label for="card_mm">到期月份</label>
						<div class="input-group mb-3">
						<input type="password" class="form-control" id="card_mm" name="card_mm" value="${memberVO.card_mm}" autocomplete="off">
							<div class="input-group-append">
								<span class="input-group-text"><img alt="" src="<%=request.getContextPath()%>/images/icons/opend-eye.png" class="float-right img-icon card_mm" title="顯示"></span>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label for="card_sec">卡片安全碼</label>
						<div class="input-group mb-3">
						<input type="password" class="form-control" id="card_sec" name="card_sec" value="${memberVO.card_sec}" autocomplete="off">
							<div class="input-group-append">
								<span class="input-group-text"><img alt="" src="<%=request.getContextPath()%>/images/icons/opend-eye.png" class="float-right img-icon card_sec" title="顯示"></span>
							</div>
						</div>
					</div>
					
					<input class="d-none" type="file" id="upload" name="mem_icon">
					<input type="hidden" name="mem_id" value="${memberVO.mem_id}">
					<input type="hidden" name="mem_autho" value="${memberVO.mem_autho}">
					<input type="hidden" name="action" value="update-front">
					<button type="submit" class="btn login_btn float-right submit">修改</button>
					
				</div>
			</form>
		</div>
		

		
		
		
		
</div>

<script>

new TwCitySelector({
    el: ".my-selector-c",
    elCounty: ".county", // 在 el 裡查找 dom
    elDistrict: ".district" // 在 el 裡查找 dom
  });



$('img.img-icon').click(function(){
	var source = $(this).attr('src');
	var thisClass = $(this).attr('class');
	var target = thisClass.substring(21);
	
	if (source.includes('opend')){
		$('#' + target).attr('type', 'text');
		$(this).attr('title', '隱藏');
		$(this).attr('src', '<%=request.getContextPath()%>/images/icons/closed-eye.png');
	} else if (source.includes('closed')){
		$('#' + target).attr('type', 'password');
		$(this).attr('title', '顯示');
		$(this).attr('src', '<%=request.getContextPath()%>/images/icons/opend-eye.png');
	}
});

function init() {
	 
    var display = document.getElementById("display");
    var upload = document.getElementById("upload");

    upload.addEventListener("change", function(e){
        var files = upload.files;
        if (files && files[0]) {
            for (i = 0; i < files.length; i ++) {
                if (files[i].type.indexOf("image") < 0) {
					Swal.fire({
						icon: 'error',
						title: '上傳的格式不符'
					})
                } else {
                    var file = files[i];
                    var reader = new FileReader();

                    reader.onload = function(e) {
                        var result = e.target.result;

                        display.setAttribute("src", result);

                    }
                    reader.readAsDataURL(file);
                }
            }
        }
    });
    
}

window.onload = init;	

$.datetimepicker.setLocale('zh');

$('#mem_birth').datetimepicker({
    theme: '',              //theme: 'dark',
     timepicker:false,       //timepicker:true,
     step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
     format:'Y-m-d',         //format:'Y-m-d H:i:s',
	   value: '${memberVO.mem_birth}', // value:   new Date(),
    //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
    //startDate:	            '2017/07/10',  // 起始日
    //minDate:               '-1970-01-01', // 去除今日(不含)之前
    //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
 });


// ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

//      1.以下為某一天之前的日期無法選擇
//      var somedate1 = new Date('2017-06-15');
//      $('#f_date1').datetimepicker({
//          beforeShowDay: function(date) {
//        	  if (  date.getYear() <  somedate1.getYear() || 
//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
//              ) {
//                   return [false, ""]
//              }
//              return [true, ""];
//      }});


//      2.以下為某一天之後的日期無法選擇
//      var somedate2 = new Date('2017-06-15');
//      $('#f_date1').datetimepicker({
//          beforeShowDay: function(date) {
//        	  if (  date.getYear() >  somedate2.getYear() || 
//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
//              ) {
//                   return [false, ""]
//              }
//              return [true, ""];
//      }});


//      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
//      var somedate1 = new Date('2017-06-15');
//      var somedate2 = new Date('2017-06-25');
//      $('#f_date1').datetimepicker({
//          beforeShowDay: function(date) {
//        	  if (  date.getYear() <  somedate1.getYear() || 
//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
//		             ||
//		            date.getYear() >  somedate2.getYear() || 
//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
//              ) {
//                   return [false, ""]
//              }
//              return [true, ""];
//      }});

</script>


	
    <!-- 內容 ---end  -->


        <!-- footer -->
        <footer id="footer" class="pt-5 ">
            <div class="container">
                <div class="row">
                    <div class="col-md-3 col-sm-6 footer-list">
                        <h5>快速連結</h5>
                        <ul>
                            <li>
                                <a class="footer-link" href="<%=request.getContextPath()%>/front-end/index.jsp">S.F.G首頁</a>
                            </li>
                            <li>
                                <a class="footer-link" href="<%=request.getContextPath()%>/front-end/member/addMember.jsp">註冊會員</a>
                            </li>
                            <li>
                                <a class="footer-link" href="">商城</a>
                            </li>
                            <li>
                                <a class="footer-link" href="">團購</a>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-3 col-sm-6 footer-list">
                        <h5 class="text-uppercase">會員互動</h5>
                        <ul>
                            <li>
                                <a class="footer-link" href="">競標區</a>
                            </li>
                            <li>
                                <a class="footer-link" href="">直購區</a>
                            </li>
                            <li>
                                <a class="footer-link" href="<%=request.getContextPath()%>/front-end/post/listAllPost.jsp">討論區</a>
                            </li>
                            <li>
                                <a class="footer-link" href="">聊天室</a>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-3 col-sm-6 footer-list">
                        <h5 class="text-uppercase">關於我們</h5>
                        <ul>
                            <li>
                                <a class="footer-link" href="">關於S.F.G</a>
                            </li>
                            <li>
                                <a class="footer-link" href="">最新消息</a>
                            </li>
                            <li>
                                <a class="footer-link" href="">隱私權政策</a>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-3 col-sm-6 footer-list">
                        <h5 class="text-uppercase">技術支援</h5>
                        <ul>
                            <li>
                                <a class="footer-link" href="">新手上路</a>
                            </li>
                            <li>
                                <a class="footer-link" href="">幫助&支援</a>
                            </li>
                            <li>
                                <a class="footer-link" href="">服務條款</a>
                            </li>
                        </ul>                    
                    </div>
                </div>
            </div>

            <div class="footer-end bg-dark mt-5 py-2">
                <p class="text-center">&copy; Copy right 2020</p>
            </div>
        </footer>

        <button id="chatBtn" class="bg-primary">
            <i class="fas fa-comments"></i>
        </button>

</body>

</html>