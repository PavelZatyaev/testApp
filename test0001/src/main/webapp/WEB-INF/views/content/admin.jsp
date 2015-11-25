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

<style>
#dialog-link {
	padding: .4em 1em .4em 20px;
	text-decoration: none;
	position: relative;
}

#dialog-link span.ui-icon {
	margin: 0 5px 0 0;
	position: absolute;
	left: .2em;
	top: 50%;
	margin-top: -8px;
}

#icons {
	margin: 0;
	padding: 0;
}

#icons li {
	margin: 2px;
	position: relative;
	padding: 4px 0;
	cursor: pointer;
	float: left;
	list-style: none;
}

#icons span.ui-icon {
	float: left;
	margin: 0 4px;
}

.fakewindowcontain .ui-widget-overlay {
	position: absolute;
}

select {
	width: 200px;
}
</style>


<script type="text/javascript">
	$(document).ready(function() {
		$("#usrTable").DataTable({
			paging : false,
			"info" : false,
			"searching" : false
		});
	});

	function checkUserNameS(f) {
		if (checkUserName()) {
			f.submit();
		}
	};

	function checkUserName(frm) {

		var checkResult = "999";

		$.ajax({
			async : false,
			url : 'checkUserName_',
			data : {
				username : $('#username').val()
			},
			success : function(data) {
				checkResult = data;
			},
			error : function(obj, status, error) {
				alert("FAIL");
			}
		});

		if (checkResult == "0") {
			frm.submit();
			return false;
		}

		// имя уже используется, надо бы об этом сообщить
		$(
				"<div>Имя " + $('#username').val()
						+ " уже используется. Обновить?</div>").dialog({
			width : 500,
			//height : 150,
			buttons : {
				"Да" : function() { // обновляем данные по username
					frm.submit();
					$(this).dialog("close");
				},
				"Нет" : function() {
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

	<form:form method="post" action="addUser" modelAttribute="user"
		class="box users" onsubmit="checkUserName(this);return false;" style="border: 0px">


		<div class="addressBook">
			<div class="userList">
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

					<p>
						<form:label path="isAdmin">
							<form:checkbox path="isAdmin" id="isAdmin" checked="true" />
							<spring:message code="label.user_admin" />
						</form:label>
					</p>

					<input type="submit" class="btnLogin"
						value="<spring:message code="label.adduser"/>" id="button" />
				</fieldset>
			</div>
			<div class="userList" style='overflow: auto'>
				<c:if test="${!empty userList}">
					<table id="usrTable" class="display" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th><spring:message code="label.user_FIO" /></th>
								<th><spring:message code="label.user_email" /></th>
								<th><spring:message code="label.user_name" /></th>
								<th>adm</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${userList}" var="user">
								<tr>
									<td class="tableList">${user.FIO}</td>
									<td class="tableList">${user.email}</td>
									<td class="tableList">${user.username}</td>
									<td class="tableList">${user.adminGroup}</td>
									<td>
										<p>
											<a href="deleteUser/${user.id}" id="button-icon"
												class="ui-state-default ui-corner-all"><span
												class="ui-icon ui-icon-minusthick"></span> <spring:message
													code="label.delete" /></a>
										</p>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>

			</div>
		</div>

	</form:form>

	<script>

$( "#accordion" ).accordion();

var availableTags = [
	"Hi",
	"Hello",
	"Hi there",
	"hey",
	"howdy"
];
$( "#autocomplete" ).autocomplete({
	source: availableTags
});

$( "#button" ).button();
$( "#button-icon" ).button();
$( "#radioset" ).buttonset();

$( "#tabs" ).tabs();
if(document.getElementById('editAddressBook')){
	//alert('editAddressBook!!!');
	$('#tabs').tabs({ active: 1	});
}


$( "#dialog" ).dialog({
	autoOpen: false,
	width: 400,
	buttons: [
		{
			text: "Ok",
			click: function() {
				$( this ).dialog( "close" );
			}
		},
		{
			text: "Cancel",
			click: function() {
				$( this ).dialog( "close" );
			}
		}
	]
});

// Link to open the dialog
$( "#dialog-link" ).click(function( event ) {
	$( "#dialog" ).dialog( "open" );
	event.preventDefault();
});
$( "#datepicker" ).datepicker({
	inline: true
});
$( "#slider" ).slider({
	range: true,
	values: [ 17, 67 ]
});
$( "#progressbar" ).progressbar({
	value: 20
});
$( "#spinner" ).spinner();
$( "#menu" ).menu();
$( "#tooltip" ).tooltip();
$( "#selectmenu" ).selectmenu();
// Hover states on the static widgets
$( "#dialog-link, #icons li" ).hover(
	function() {
		$( this ).addClass( "ui-state-hover" );
	},
	function() {
		$( this ).removeClass( "ui-state-hover" );
	}
);
</script>



</body>
</html>