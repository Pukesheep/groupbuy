<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*" %>

<%
	MemberService memberSvc = new MemberService();
	java.util.List<MemberVO> list = memberSvc.getAll();
	pageContext.setAttribute("list", list);
%>
<%--
	前台會員不提供listAllMember
 --%>

<html>
<head>
<title>所有會員資料 - listAllMember.jsp</title>

<style>
	table#table-1 {
		width: 100%;
		background-color: #CCCCFF;
		border: 2px solid black;
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
	table {
		width: 800px;
		background-color: white;
		margin-top: 5px;
		margin-bottom: 5px;
	}
	table, th, td {
		padding: 5px;
		text-align: center;
	}
	th, td {
		width: 300px;
	}
	body {
		background-color: white;
	}
	img {
		width: 100px;
		height: 32px;
	}
	font {
		color: red;
	}
	#errormsg {
		color: red;
	}
	img#display {
		width: 200px;
		height: 200px;
	}
</style>

</head>
<body>

<h4>此頁練習採用 EL 的寫法取值</h4>
<table id="table-1">
	<tr>
		<td>
			<h3>所有會員資料 - listAllMember.jsp</h3>
			<h4><a href="<%=request.getContextPath()%>/front-end/member/select_page.jsp"><img src="<%=request.getContextPath()%>/images/back1.gif">回首頁</a></h4>
		</td>
	</tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font>請修正以下錯誤</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li id="errormsg">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>會員編號</th>
		<th>會員信箱</th>
		<th>會員密碼</th>
		<th>會員名稱</th>
		<th>會員圖片</th>
		<th>會員手機</th>
		<th>會員地址</th>
		<th>銀行帳戶</th>
		<th>信用卡號</th>
		<th>到期年份</th>
		<th>到期月份</th>
		<th>卡片安全碼</th>
		<th>會員權限</th>
		<th>紅利點數</th>
		<th>加入時間</th>
		<th>會員生日</th>
		<th>警告次數</th>
	</tr>
<%@ include file="../../files/page1.file" %>

	<c:forEach var="memberVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${memberVO.mem_id}</td>
			<td>${memberVO.mem_email}</td>
			<td>${memberVO.mem_pass}</td>
			<td>${memberVO.mem_name}</td>
			<td><img alt="" src="<%=request.getContextPath()%>/member/ShowMemberPic.do?mem_id=${memberVO.mem_id}" id="display"></td>
			<td>${memberVO.mem_phone}</td>
			<td>${memberVO.mem_addr}</td>
			<td>${memberVO.bank_acc}</td>
			<td>${memberVO.card_no}</td>
			<td>${memberVO.card_yy}</td>
			<td>${memberVO.card_mm}</td>
			<td>${memberVO.card_sec}</td>
			<td>${memberVO.mem_autho}</td>
			<td>${memberVO.mem_bonus}</td>
			<td><fmt:formatDate value="${memberVO.mem_joindat}" pattern="yyyy-MM-dd"/></td>
			<td><fmt:formatDate value="${memberVO.mem_birth}" pattern="yyyy-MM-dd"/></td>
			<td>${memberVO.mem_warn}</td>
			<td>
				<form action="<%=request.getContextPath()%>/member/member.do" method="post">
					<input type="submit" value="修改">
					<input type="hidden" name="mem_id" value="${memberVO.mem_id}">
					<input type="hidden" name="action" value="getOne_For_Update-front">
				</form>
			</td>
<%-- 前台不提供刪除會員的功能		
			<td>
				<form action="<%=request.getContextPath()%>/member/member.do" method="post">
					<input type="submit" value="刪除">
					<input type="hidden" name="mem_id" value="${memberVO.mem_id}">
					<input type="hidden" name="action" value="delete">
				</form>
			</td>
 --%>			
		</tr>
	</c:forEach>
</table>
<%@ include file="../../files/page2.file" %>

</body>
</html>