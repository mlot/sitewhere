<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="sitewhere_title" value="${rb.getString('jsp.groups.list.managedevicegroups') }" />
<c:set var="sitewhere_section" value="devicegroups" />
<%@ include file="../includes/top.inc"%>

<style>
.sw-device-group-list {
	border: 0px;
}
</style>

<!-- Title Bar -->
<div class="sw-title-bar content k-header">
	<h1 class="ellipsis"><c:out value="${sitewhere_title}"/></h1>
	<div class="sw-title-bar-right">
		<a id="btn-filter-results" class="btn" href="javascript:void(0)">
			<i class="icon-search sw-button-icon"></i> ${rb.getString("jsp.groups.list.filterresults")}</a>
		<a id="btn-add-device-group" class="btn" href="javascript:void(0)">
			<i class="icon-plus sw-button-icon"></i> ${rb.getString("jsp.groups.list.addnewdevicegroup")}</a>
	</div>
</div>
<div id="groups" class="sw-device-group-list"></div>
<div id="pager" class="k-pager-wrap"></div>

<form id="view-device-group-detail" method="get" action="detail.html">
	<input id="detail-group-token" name="groupToken" type="hidden"/>
</form>

<%@ include file="../includes/templateRoleEntry.inc"%>
<%@ include file="../includes/deviceGroupCreateDialog.inc"%>
<%@ include file="../includes/templateDeviceGroupEntry.inc"%>
<%@ include file="../includes/commonFunctions.inc"%>

<script>
	/** Reference for device group list datasource */
	var deviceGroupsDS;
	
	/** Called when 'open' button on the group entry is pressed */
	function onDeviceGroupOpenClicked(e, token) {
		var event = e || window.event;
		event.stopPropagation();
		$('#detail-group-token').val(token);
		$('#view-device-group-detail').submit();
	}
	
	/** Called when 'edit' button on the group entry is pressed */
	function onDeviceGroupEditClicked(e, token) {
		var event = e || window.event;
		event.stopPropagation();
		dguOpen(token, onDeviceGroupEditComplete)
	}
	
	/** Called when 'delete' button on the group entry is pressed */
	function onDeviceGroupDeleteClicked(e, token) {
		var event = e || window.event;
		event.stopPropagation();
		swDeviceGroupDelete(token, onDeviceGroupDeleteComplete);
	}
   
    /** Called after a device group is added */
	function onDeviceGroupAdded() {
		deviceGroupsDS.read();
    }
    
    /** Called after a device group is edited */
	function onDeviceGroupEditComplete() {
		deviceGroupsDS.read();
    }
    
    /** Called after a device group is deleted */
	function onDeviceGroupDeleteComplete() {
		deviceGroupsDS.read();
    }
	
    $(document).ready(function() {
		/** Create AJAX datasource for device groups list */
		deviceGroupsDS = new kendo.data.DataSource({
			transport : {
				read : {
					url : "${pageContext.request.contextPath}/api/devicegroups",
					dataType : "json",
				}
			},
			schema : {
				data: "results",
				total: "numResults",
				parse:function (response) {
				    $.each(response.results, function (index, item) {
				    	parseDeviceGroupData(item);
				    });
				    return response;
				}
			},
            serverPaging: true,
            serverSorting: true,
            pageSize: 15,
		});
		
		/** Create the list of devices */
		$("#groups").kendoListView({
			dataSource : deviceGroupsDS,
			template : kendo.template($("#tpl-device-group-entry").html()),
		});
		
		/** Pager for device list */
        $("#pager").kendoPager({
            dataSource: deviceGroupsDS
        });
		
	    $("#btn-add-device-group").click(function(event) {
	    	dgcOpen(event, onDeviceGroupAdded)
	    });
	});
</script>

<%@ include file="../includes/bottom.inc"%>