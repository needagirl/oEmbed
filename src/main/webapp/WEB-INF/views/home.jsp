<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>oEmbed</title>
</head>
<body>
	<div class="main">
		<div class="input">
			<h3 class="title">oEmbed Test 박동현</h3>
			<form method="post" action="/codingTest/checkUrl">
				<input id="url" name="url" class="url" type="text"/>
				<input type="submit" value="확인" class="checkBtn" />
			</form>
		</div>
		<div class="contents">
			<ul>
				<li></li>			
			</ul>
		</div>
	</div>
</body>
</html>
