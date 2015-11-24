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
	src="<%=request.getContextPath()%>/resources/js/jquery-1.11.3.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/jquery-ui.min.js"></script>

<link href="<%=request.getContextPath()%>/resources/css/datatables.css"
	rel="stylesheet" type="text/css" />
<script
	src="<%=request.getContextPath()%>/resources/js/datatables.min.js"></script>

<script
	src="<%=request.getContextPath()%>/resources/js/jquery.validate.min.js"></script>


<script>
/* 	function changePassword(frm) {
		alert('Submit');
		frm.submit();
		return false;
	};
 */
	function checkOldPassword(passwd, check_mode) {
		var checkResult = "999";
		$.ajax({
			async : false,
			url : '__checkOldPassword',
			data : {
				password : passwd,
				check_password : check_mode
			},
			success : function(data) {
				checkResult = data;
			},
			error : function(obj, status, error) {
				alert("FAIL" + error);
			}
		});
		//alert(checkResult);
		return checkResult == "1"; 
    };	

	$.validator.setDefaults({
		submitHandler : function() {
			if (checkOldPassword($('#old_password').val(), 1)) {
				checkOldPassword($('#new_password').val(), 0);
				alert("passwd change!");
				history.go(-1);
			} else
				alert("Old password not confirmed!");
		}
	});

	$()
			.ready(
					function() {
						$("#changePassword")
								.validate(
										{
											rules : {
												old_password : {
													required : true
												},
												new_password : {
													required : true
												},
												confirm_password : {
													required : true,
													equalTo : "#new_password"
												}
											},
											messages : {
												old_password : {
													required : "Please provide a old password"
												},
												new_password : {
													required : "Please provide a new password"
												},
												confirm_password : {
													required : "Please provide a same password as above",
													equalTo : "Please enter the same password as above"
												}
											}
										});

						$("form input, form select")
								.live(
										'keypress',
										function(e) {
											if ($(this)
													.parents('form')
													.find(
															'button[type=submit].default, input[type=submit].default').length <= 0)
												return true;

											if ((e.which && e.which == 13)
													|| (e.keyCode && e.keyCode == 13)) {
												$(this)
														.parents('form')
														.find(
																'button[type=submit].default, input[type=submit].default')
														.click();
												return false;
											} else {
												return true;
											}
										});
					});
</script>

</head>
<body>
	<p style="text-align: right">
		<a href="j_spring_security_logout" id="button-icon"
			class="ui-state-default ui-corner-all"><span
			class="ui-icon ui-icon-close"></span> <spring:message
				code="label.logout" /></a>
	</p>


	<form:form method="get" action="" modelAttribute="user"
		id='changePassword' class="box changePassword">

		<fieldset class="boxBody">
			<p>
				<label for="password"><spring:message
						code="label.chPwd_passwdOld" /></label> <input id="old_password"
					name="old_password" type="password">
			</p>
			<p>
				<label for="password"><spring:message
						code="label.chPwd_passwdNew" /></label> <input id="new_password"
					name="new_password" type="password">

				<%-- 				<form:input path="password" id="password" type='password' /> --%>
			</p>
			<p>
				<label for="confirm_password"><spring:message
						code="label.chPwd_passwdConfirm" /></label> <input id="confirm_password"
					name="confirm_password" type="password">
			</p>
		</fieldset>

		<footer>
		<p style="text-align: right">
			<input type="submit" id='button'
				value="<spring:message code="label.chPwd_passwdSend"/>" /> <input
				action="action" type="button" id='button00'
				value="<spring:message code="label.chPwd_passwdCancel"/>"
				onclick="history.go(-1);" />
		</p>
		</footer>
	</form:form>

	<script>
		$("#button").button();
		$("#button00").button();
	</script>

</body>
</html>