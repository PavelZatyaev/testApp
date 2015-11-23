<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change password</title>
</head>
<body>
	<p style="text-align: right">
		<a href="j_spring_security_logout" id="button-icon"
			class="ui-state-default ui-corner-all"><span
			class="ui-icon ui-icon-close"></span> <spring:message
				code="label.logout" /></a>
	</p>

	<form:form method="post" action="XXXXXX" modelAttribute="user"
		class="box users" onsubmit="checkUserName(this);return false;">
		
		</form:form>



<script>
	$( "#button" ).button();
</script>

</body>
</html>