<%@ page contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>Member: Home</title>

<style>
	table#table-1 {
		width: 100%;
		background-color: #CCCCFF;
		margin-top: 5px;
		margin-bottom: 10px;
		border: 3px ridge Gray;
		height: 80px;
		text-align: center;
	}
	table#table-1 h4 {
		color: red;
		display: block;
		margin-bottom: 1px;
	}
	h4 {
		color: blue;
		display: inline;
	}
	body {
		background: white;
	}
	font {
		color: red;
	}
	#errormsg {
		color: red;
	}
</style>

</head>
<body>

<table id="table-1">
	<tr><td><h3>Member: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for Member: Home</p>

<h3>資料查詢</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs }">
	<font>請修正以下錯誤：</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li id="errormsg">${message}</li>
		</c:forEach>
	</ul>
</c:if>

	<form action="<%=request.getContextPath()%>/member/login.do" method="post">
		<c:if test="${not empty memberVO }">
			<div id="logout">
				<input type="hidden" name="action" value="logout">
				<input type="submit" value="登出">
			</div>
		</c:if>
		<c:if test="${empty memberVO}">
			<a href="<%=request.getContextPath()%>/front-end/member/login.jsp">登入</a>
		</c:if>
	</form>

<ul>
<%-- 前台不提供查詢所有會員
	<li><a href='<%=request.getContextPath()%>/front-end/member/listAllMember.jsp'>List</a> all Members. <br><br></li>
--%>	
	<c:if test="${not empty sessionScope.memberVO}">
		<li>
			<a href="<%=request.getContextPath()%>/member/member.do?action=getOne_For_Display-front&mem_id=${sessionScope.memberVO.mem_id}">查詢自己</a>
			<form action="<%=request.getContextPath()%>/member/member.do" method="post" name="form1">
				<input type="hidden" name="mem_id" value="${sessionScope.memberVO.mem_id}">
				<input type="hidden" name="action" value="getOne_For_Display-front">
				<input type="submit" value="查詢自己">
				<button type="submit"><img alt="" src="<%=request.getContextPath()%>/images/back1.gif"></button>
			</form>
		</li>
	</c:if>
	
	<li>
		<form action="<%=request.getContextPath()%>/member/member.do" method="post">
			<b>請輸入會員編號 (如M000005)</b>
			<input type="text" name="mem_id">
			<input type="hidden" name="action" value="getOne_For_Display-front">
			<input type="submit" value="送出">
		</form>
	</li>
	
<jsp:useBean id="memberSvc" scope="page" class="com.member.model.MemberService" />

	<li>
		<form action="<%=request.getContextPath()%>/member/member.do" method="post">
			<b>選擇會員編號</b>
			<select size="1" name="mem_id">
				<c:forEach var="memberVO" items="${memberSvc.all}">
					<option value="${memberVO.mem_id}">${memberVO.mem_id}
				</c:forEach>
			</select>
			<input type="hidden" name="action" value="getOne_For_Display-front">
			<input type="submit" value="送出">
		</form>
	</li>
	
	<li>
		<form action="<%=request.getContextPath()%>/member/member.do" method="post">
			<b>請選擇會員名稱</b>
			<select size="1" name="mem_id">
				<c:forEach var="memberVO" items="${memberSvc.all}" >
					<option value="${memberVO.mem_id}">${memberVO.mem_name}
				</c:forEach>
			</select>
			<input type="hidden" name="action" value="getOne_For_Display-front">
			<input type="submit" value="送出">
		</form>
	</li>
</ul>

<h3>會員管理</h3>

<ul>
	<li><a href="<%=request.getContextPath()%>/front-end/member/addMember.jsp">add</a> a new Member.</li>
</ul>

</body>
</html>