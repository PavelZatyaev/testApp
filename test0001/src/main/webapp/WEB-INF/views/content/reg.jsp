<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="label.title.adm" /></title>

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


<script type="text/javascript">
	function checkUserName(frm) {

		var checkResult = "999";

		     	$.ajax({
		     		async: false,
		            url: 'checkUserName_',
		            data: {
		            	  username : $('#username').val()
		            	  },
		            success: function(data) {
		                 checkResult = data;
		                 },
		            error: function(obj, status, error) {
		                 alert("FAIL");
		                 }
		          });

		     	if (checkResult == "0") {
			     	frm.submit();
			     	return false;
		     	} 

		// имя уже используется, надо бы об этом сообщить
		$(
				"<div>Имя " + $('#username').val() + " == " + checkResult
						+ " уже используется. Необходимо выбрать другое имя.</div>").dialog({
			width : 500,
			buttons : {
				"Ok" : function() {
					$(this).dialog("close");
				}
			}
		}).show();

	};
</script>
</head>
<body>
	<p style="text-align: right">
		<a href="j_spring_security_logout" id="button-icon"
			class="ui-state-default ui-corner-all"><span
			class="ui-icon ui-icon-close"></span> <spring:message
				code="label.logout" /></a>
	</p>

	<form:form method="post" action="addUserReg" modelAttribute="user"
		class="box changePassword"
		onsubmit="checkUserName(this);return false;">

		<fieldset class="boxBody">

			<form:label path="FIO">
				<spring:message code="label.user_FIO" />
			</form:label>
			<form:input path="FIO" id="FIO" />
			<form:errors path="FIO" cssClass="error" />

			<form:label path="email">
				<spring:message code="label.user_email" />
			</form:label>
			<form:input path="email" id="email" />
			<form:errors path="email" cssClass="error" />

			<form:label path="username">
				<spring:message code="label.user_name" />
			</form:label>
			<form:input path="username" id="username" />

			<form:errors path="username" cssClass="error" />

			<form:label path="password">
				<spring:message code="label.user_password" />
			</form:label>
			<form:input path="password" id="password" />
			<form:errors path="password" cssClass="error" />

		</fieldset>
		<footer> <input type="submit" id='button'
			value="<spring:message code="label.adduser"/>" /> </footer>

	</form:form>
	<script>
$( "#button" ).button();
$( "#button-icon" ).button();
</script>

</body>
</html>