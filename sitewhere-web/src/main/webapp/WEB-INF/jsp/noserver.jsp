<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="sitewhere_title" value="${rb.getString('jsp.noserver.serverstartupfailed') }" />
<c:set var="sitewhere_section" value="sites" />
<%@ include file="includes/top.inc"%>

<style>
</style>

<!-- Title Bar -->
<div class="sw-title-bar content k-header">
	<h1>
		<c:out value="${sitewhere_title}" />
	</h1>
</div>
<div class="alert alert-error">
	${rb.getString("jsp.noserver.loaderrorms")}
</div>
<%@ include file="includes/bottom.inc"%>