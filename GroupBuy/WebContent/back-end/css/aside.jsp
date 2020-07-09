<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>aside.jsp</title>
</head>
<body>
        <aside class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ">
                <li class="nav-item">
                    <div class="nav-link" data-toggle="collapse" data-target="#sideNavColl01">
                        <i class="fas fa-user-edit ml-3"></i> 會員管理</div>
                    <ul class="collapse navbar-nav" id="sideNavColl01" data-parent="#navbarNav">
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">會員權限管理</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">會員資料管理</a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item">
                    <div class="nav-link" data-toggle="collapse" data-target="#sideNavColl02">
                        <i class="fas fa-home-alt ml-3 mr-2"></i>商城管理</div>
                    <ul class="collapse navbar-nav" id="sideNavColl02" data-parent="#navbarNav">
                        <li class="nav-item ">
                            <a class="nav-link pl-4" href="#">商品上下架</a>
                        </li>
                        <li class="nav-item ">
                            <a class="nav-link pl-4" href="#">商成訂單管理</a>
                        </li>
                        <li class="nav-item ">
                            <a class="nav-link pl-4" href="#">限時專案管理</a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item ">
                    <div class="nav-link" data-toggle="collapse" data-target="#sideNavColl03">
                        <i class="fas fa-gift ml-3 mr-2"></i>紅利商城管理</div>
                    <ul class="collapse navbar-nav" id="sideNavColl03" data-parent="#navbarNav">
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">紅利商品上下架</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">紅利商品訂單管理</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">紅利商品商品管理</a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item ">
                    <div class="nav-link" data-toggle="collapse" data-target="#sideNavColl04">
                        <i class="fas fa-users-class  ml-3 mr-1"></i>團購管理</div>
                    <ul class="collapse navbar-nav pt-2" id="sideNavColl04" data-parent="#navbarNav">
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">團購訂單管理</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">團購商品管理</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">團購商品上下架</a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item ">
                    <div class="nav-link" data-toggle="collapse" data-target="#sideNavColl05">
                        <i class="fas fa-hand-pointer ml-3 mr-2"></i>交易區管理</div>
                    <ul class="collapse navbar-nav" id="sideNavColl05" data-parent="#navbarNav">
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">交易管理</a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item ">
                    <div class="nav-link" data-toggle="collapse" data-target="#sideNavColl06">
                        <i class="fas fa-exclamation-triangle ml-3 mr-1"></i>檢舉管理</div>
                    <ul class="collapse navbar-nav" id="sideNavColl06" data-parent="#navbarNav">
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">商品檢舉管理</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">會員檢舉管理</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">文章檢舉管理</a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item ">
                    <div class="nav-link" data-toggle="collapse" data-target="#sideNavColl07">
                        <i class="far fa-envelope-open-text ml-3 mr-2"></i>客服中心</div>
                    <ul class="collapse navbar-nav" id="sideNavColl07" data-parent="#navbarNav">
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">客服訊息管理</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">Q&A管理</a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item ">
                    <div class="nav-link" data-toggle="collapse" data-target="#sideNavColl08">
                        <i class="fas fa-address-card ml-3 mr-2"></i>員工管理</div>
                    <ul class="collapse navbar-nav" id="sideNavColl08" data-parent="#navbarNav">
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">員工帳號管理</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link pl-4" href="#">員工權限管理</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </aside>
</body>
</html>