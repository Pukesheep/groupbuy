<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
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
                    <div class="item col-md-2"><a href="<%=request.getContextPath()%>/front-end/product/listAllProduct.jsp">商城 </a></div>
                    <div class="item col-md-2"><a href="<%=request.getContextPath()%>/front-end/groupbuy/listAllGroupbuy.jsp">團購 </a></div> 
                    <div class="item col-md-2"><a href="<%=request.getContextPath()%>/front-end/auct/Auct_index.jsp">競標區 </a></div> 
                    <div class="item col-md-2"><a href="#">直購區 </a></div> 
                    <div class="item col-md-2"><a href="<%=request.getContextPath()%>/front-end/post/listAllPost.jsp">討論區 </a></div> 
                    <div class="item col-md-2"><a href="#">紅利</a></div> 
                	<div class="item col-md-2"><a href="#">Q&A</a></div>
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
                    <a class="nav-link" href="<%=request.getContextPath()%>/member/member.do?action=getOne_For_Display-front&mem_id=${sessionScope.memberVO.mem_id}">會員中心</a>
                </li>
                <li class="nav-item">
                	<a class="nav-link" href="<%=request.getContextPath()%>/member/login.do?action=logout">登出</a>
                </li>
          	</c:if>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/front-end/protected/favouriteProduct/listAllFavouriteProduct.jsp">我的最愛</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/front-end/shopCart/shopCart.jsp">購物車<c:if test="${not empty shoppingcart}">(${shoppingcart.size()})</c:if></a>
                </li>

            </ul>
        </div>


    </nav>
    <!-- navbar end -->


</body>
</html>