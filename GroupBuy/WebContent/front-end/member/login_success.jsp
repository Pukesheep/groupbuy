<%@ page contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Login Success</title>
<style>
	#container {
		border: 1px solid black;
		margin: 0 auto;
		width: 25%;
		text-align: center;
	}
	#container > div {
		margin: 10px;
	}
	div#logout {
		float: right;
	}
</style>
</head>
<body>
	<form action="member.do" method="post">
		<c:if test="${not empty memberVO }">
			<div id="logout">
				<input type="hidden" name="action" value="logout">
				<input type="submit" value="登出">
			</div>
		</c:if>
	</form>

	<div id="container">
		<h2>登入成功</h2>
		<div>
			${memberVO.mem_name}		
		</div>
		<div>
			123213213
		</div>
	</div>
	
</body>
</html>