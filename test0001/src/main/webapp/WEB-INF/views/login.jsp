<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test App</title>

<link href="<%=request.getContextPath()%>/resources/css/jquery-ui.css"
	rel="stylesheet" />
<link
	href="<%=request.getContextPath()%>/resources/css/jquery-ui.structure.css"
	rel="stylesheet" />
<link
	href="<%=request.getContextPath()%>/resources/css/jquery-ui.theme.css"
	rel="stylesheet" />

<link href="<%=request.getContextPath()%>/resources/css/mail.css"
	rel="stylesheet" />

<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/jquery-ui.min.js"></script>

<link href="<%=request.getContextPath()%>/resources/css/datatables.css"
	rel="stylesheet" type="text/css" />
<script
	src="<%=request.getContextPath()%>/resources/js/datatables.min.js"></script>


<script>
// git 01
	window.onload = function(){
		if(document.getElementById('autoLogin')){
			document.forms['login_form'].submit();
		}
	}
</script>

</head>

<body>
	<form method="POST"
		action="<%=request.getContextPath()%>/j_spring_security_check"
		class="box login" name="login_form" id="login_form">

		<fieldset class="boxBody">
			<c:if test="${not empty user}">
				<label id="autoLogin">autoLogin...</label>
				<c:set var="user_login" scope="session" value="${user.username}" />
				<c:set var="user_password" scope="session"
					value="${user_plan_password}" />

				<input type='text' name='user_login' id='ul'
					value='<c:out value="${user_login}"/>' />

				<input type='password' id='up' name='password_login'
					value='<c:out value="${user_password}"/>' />
			</c:if>

			<c:if test="${empty user}">
				<label> Username </label>
				<input type='text' name='user_login' value='admin' />
				<label> Password </label>
				<input type='password' name='password_login' value='121212' />
			</c:if>

			<c:if test="${not empty error}">
				<div class="error" style="text-align: right;">${error}</div>
			</c:if>
			<c:if test="${empty error}">
				<label>&nbsp;</label>
			</c:if>
			

		</fieldset>

		<footer>
		<div class="addressBook">
			<div style="float: left; width: 50%;">
				<input name="_spring_security_remember_me" id="remember_me"
					type="checkbox" /> <label for="remember_me">Remember</label>
				<p style="text-align: left">
					<a href="<%=request.getContextPath()%>/reg"> Sign In </a>
				</p>
			</div>
			<div style="float: left; text-align: right; width: 50%;">
			<p style="text-align: right">
				<input type="submit" value="Вход" id="button" />
				</p>
			</div>
		</div>
		</footer>

	</form>

	<script>
$( "#button" ).button();
</script>

</body>
</html>