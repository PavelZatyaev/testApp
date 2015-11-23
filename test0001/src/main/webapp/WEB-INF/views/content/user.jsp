<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="label.title" /></title>

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

<script>
$(document).ready(function() {
  $("#msgTable").DataTable({paging: false,"info": false, "searching": false});
  $("#userList").DataTable({paging: false,"info": false, "searching": false});
  $("#selectedUserList").DataTable({paging: false,"info": false, "searching": false});
} );

function showMsg(msg_sender, msg_date, msg_subj, msg_text) {
		$(
				"<div style='text-align: left'>Отправитель:&nbsp;"+msg_sender+
				"<br>Дата:&nbsp;"+msg_date+
				"<br>Тема:&nbsp;"+msg_subj+
				"<br><br>Текст сообщения:<br>" + msg_text + 
				"</div>").dialog({
			width : 500,
			height : 300,
			buttons : {
				"Ok" : function() {  // обновляем данные по username
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

	<p style="text-align: right">
		<a href="j_spring_security_logout" id="button-icon"
			class="ui-state-default ui-corner-all"><span
			class="ui-icon ui-icon-close"></span> <spring:message
				code="label.user_password" /></a>
	</p>

	<c:if test="${not empty IsAdmin}">
		<br>
		<p style="text-align: right">
			<a href="<%=request.getContextPath()%>/admin" id="button-icon"
				class="ui-state-default ui-corner-all"><span
				class="ui-icon ui-icon-wrench"></span>
			<spring:message code="label.user_admin" /></a>
		</p>
	</c:if>

	<h2>
		<spring:message code="label.title" />
	</h2>
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">Сообщение</a></li>
			<li><a href="#tabs-2">Адресная книга</a></li>
		</ul>
		<div id="tabs-1">
			<div class="addressBook">
				<form:form method="post" action="add" modelAttribute="message"
					class="box">

					<fieldset class="boxBody">
						<form:label path="userID">
							<spring:message code="label.message_to" />
						</form:label>

						<form:select path="userID" id="selectmenu" width='300px'>
							<form:option value="0"> --SELECT--</form:option>
							<form:options items="${userMap}"></form:options>
						</form:select>
						<form:errors path="userID" cssClass="error" />

						<form:label path="subj">
							<spring:message code="label.message_subj" />
						</form:label>
						<form:input path="subj" id="autocomplete" />
						<form:errors path="subj" cssClass="error" />

						<form:label path="msg">
							<spring:message code="label.message_text" />
						</form:label>
						<form:input path="msg" id="autocomplete" />

						<input type="submit"
							value="<spring:message code="label.addmessage"/>" id="button" />
					</fieldset>


					<div class="layer1">
						<h3>
							<spring:message code="label.messages" />
						</h3>

						<c:if test="${!empty messageList}">
							<table id="msgTable" class="display" cellspacing="0" width="100%">
								<thead>
									<tr>

										<th width="25%"><spring:message code="label.message_from" /></th>
										<th width="10%"><spring:message code="label.message_date" /></th>
										<c:if test="${not empty IsAdmin}">
											<th width="25%"><spring:message code="label.message_to" /></th>
										</c:if>
										<th width="35%"><spring:message code="label.message_subj" /></th>
										<th width="5%">&nbsp;</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach items="${messageList}" var="message">
										<tr>
											<c:set var="msg_sender" scope="session"
												value="${message.user_from.FIO}" />
											<c:set var="msg_date" scope="session" value="${message.dt}" />
											<c:set var="msg_subj" scope="session" value="${message.subj}" />
											<c:set var="msg_text" scope="session" value="${message.msg}" />

											<td>${message.user_from.FIO}</td>
											<td>${message.dt}</td>
											<c:if test="${not empty IsAdmin}">
												<td>${message.user_to.FIO}</td>
											</c:if>
											<td
												onclick='showMsg(
								"<c:out value="${msg_sender}"/>",
								"<c:out value="${msg_date}"/>",
								"<c:out value="${msg_subj}"/>",
								"<c:out value="${msg_text}"/>");'><u
												style='cursor: pointer'>${message.subj}</u></td>
											<td>
												<p style="text-align: right">
													<a href="delete/${message.id}" id="button-icon"
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
				</form:form>
			</div>
		</div>

		<div id="tabs-2">
			<div class="addressBook">

				<c:if test="${not empty editAddressBook}">
					<label id="editAddressBook" style='display: none'>editAddressBook...</label>
				</c:if>

				<div class="userList">
					<h4>Общий список пользователей</h4>
					<c:if test="${!empty allAddressList}">
						<table id="userList" class="display" cellspacing="0" width="100%">
							<thead>
								<tr>
									<th width="90%"><spring:message code="label.message_from" /></th>
									<th width="10%">&nbsp;</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${allAddressList}" var="recipient">
									<tr>
										<td>${recipient.FIO}</td>
										<td><a href="addUser2AB/${recipient.id}">
												<ul id="icons" class="ui-widget ui-helper-clearfix">
													<li class="ui-state-default ui-corner-all"
														title="Добавить в список"><span
														class="ui-icon ui-icon-plusthick"></span></li>
												</ul>
										</a></td>
									</tr>
								</c:forEach>
							<tbody>
						</table>
					</c:if>
				</div>

				<div class="userList">
					<h4>Адресная книга</h4>
					<c:if test="${!empty addressList}">
						<table id="selectedUserList" class="display" cellspacing="0"
							width="100%">
							<thead>
								<tr>
									<th width="90%"><spring:message code="label.message_from" /></th>
									<th width="10%">&nbsp;</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${addressList}" var="recipient">
									<tr>
										<td>${recipient.FIO}</td>
										<td><a class="btnLogin"
											href="delUserFromAB/${recipient.id}">
												<ul id="icons" class="ui-widget ui-helper-clearfix">
													<li class="ui-state-default ui-corner-all"
														title="Удалить из списка"><span
														class="ui-icon ui-icon-minusthick"></span></li>
												</ul>
										</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
				</div>
				<div style="clear: left"></div>
			</div>
		</div>
	</div>



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