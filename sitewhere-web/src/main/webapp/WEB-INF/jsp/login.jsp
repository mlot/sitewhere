<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="sw-body">
<head>
<title>SiteWhere - ${rb.getString("jsp.login.login") }</title>
<script src="${pageContext.request.contextPath}/scripts/jquery.js"></script>
<script src="${pageContext.request.contextPath}/scripts/jquery.validity.js"></script>
<script src="${pageContext.request.contextPath}/scripts/kendo.web.js"></script>
<script src="${pageContext.request.contextPath}/scripts/sitewhere.js"></script>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
<link href="${pageContext.request.contextPath}/css/kendo.common.min.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/kendo.bootstrap.min.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet" media="screen">
<link href="${pageContext.request.contextPath}/css/jquery.validity.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/sitewhere.css" rel="stylesheet" />
</head>

<style>
	.login-wrapper {
		width: 500px;
		color: rgb(51, 51, 51);
		margin-left: auto;
		margin-right: auto;
		border: 1px solid rgb(221, 221, 221);
		margin-top: 50px;
		padding: 50px 50px 30px;
	}
	
	.logo-image {
		margin-bottom: 25px;
	}
	
	.login-submit-button {
		width: 70px;
		font-size: 16px;
		margin-top: 10px;	
	}
</style>

<script>

$(document).ready(function() {
    /** Handle location create dialog submit */
	$('#login-submit').click(function(event) {
		$('#login-form').submit();
	});
});
</script>

<body class="sw-body">
	<div class="sw-container">
		<div class="k-content container sw-content">
			<div>
				<div class="login-wrapper k-header">
					<img class="logo-image" src="${pageContext.request.contextPath}/img/admin_console.png"/>
					<form id="login-form" class="form-horizontal" style="padding-top: 20px; padding-left: 20px;"
						method="POST" action="login.html">
						<div class="control-group">
							<label class="control-label" for="login-username">${rb.getString("jsp.login.username")}</label>
							<div class="controls">
								<input type="text" id="login-username" name="j_username" class="input-large" title="Username">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="login-password">${rb.getString("jsp.login.password")}</label>
							<div class="controls">
								<input type="password" id="login-password" name="j_password" class="input-large" 
									title="Password">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label"></label>
							<div class="controls">
								<a id="login-submit" href="javascript:void(0)" class="btn btn-sw-red login-submit-button">
									${rb.getString("jsp.login.login")}</a>
							</div>
						</div>
						<div style="text-align: center; font-size: 16pt; color: #c00">
<c:if test="${loginFailed == true}">
							${rb.getString("jsp.login.loginerrorms")}
</c:if>
						</div>
					</form>
				</div>
			</div>
			<div class="alert alert-info" style="width: 550px; margin-left: auto; margin-right: auto; text-align: center; margin-top: 10px;">
				${rb.getString("jsp.login.defaultms")} <b>admin</b>:<b>password</b>.
			</div>
		</div>
		<div style="height: 10px;"></div>
		<div class="sw-footer">
			<span style="position: absolute; right: 10px; color: #999;">
				${version.versionIdentifier}.${version.buildTimestamp} (${version.editionIdentifier})
			</span>
			Copyright © 2009-2014 SiteWhere, LLC.
		</div>
	</div>
</body>