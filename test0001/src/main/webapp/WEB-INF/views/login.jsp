<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


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
	<form:form method="POST" action="j_spring_security_check"
		name="login_form" id="login_form" class="box changePassword">
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
			
			<span style="float: right"> 
				<a href="?lang=en">en</a> 
				<a href="?lang=ru">ru</a>
			</span>
			
				<label> <spring:message code="label.login" /> </label>
				<input type='text' name='user_login' value='admin' />
				<label> <spring:message code="label.password" /> </label>				
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
					type="checkbox" /> <label for="remember_me"><spring:message code="label.remember" /></label>
					
				<p style="text-align: left">
					<a href="<%=request.getContextPath()%>/reg"><spring:message code="label.registration" /></a>
				</p>
			</div>
			<div style="float: left; text-align: right; width: 50%;">
			<p style="text-align: right">
				<input type="submit" value="<spring:message code="label.login" />" id="button" />
				
				</p>
			</div>
		</div>
		</footer>

	</form:form>

	<script>
$( "#button" ).button();
</script>

</body>
</html>