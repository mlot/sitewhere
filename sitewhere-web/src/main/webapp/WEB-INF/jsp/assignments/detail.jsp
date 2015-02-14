<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="sw-body">
<head>
	<script src="${pageContext.request.contextPath}/scripts/jquery-1.10.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/charts/media/js/flyjsonp.js"></script>
	<script src="${pageContext.request.contextPath}/charts/media/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/charts/media/js/jquery.flot.js"></script>
	<script type="text/javascript"
			src="${pageContext.request.contextPath}/charts/media/js/jquery.flot.time.js"></script>

	<script type="text/javascript" src="${pageContext.request.contextPath}/charts/media/js/json2.js"></script>
	<link href="${pageContext.request.contextPath}/charts/media/css/style.css" rel="stylesheet" type="text/css"/>
</head>

<c:set var="sitewhere_title" value="${rb.getString('jsp.assignments.detial.viewassignment') }" />
<c:set var="sitewhere_section" value="sites" />
<%@ include file="../includes/top.inc"%>

<style>
	.chart {
		overflow: hidden;
		height: 300px;
	}
.event-pager {
	margin-top: 10px;
}
</style>

<!-- Title Bar -->
<div class="sw-title-bar content k-header" style="margin-bottom: -1px;">
	<h1 class="ellipsis"><c:out value="${sitewhere_title}"/></h1>
	<div class="sw-title-bar-right">
		<a id="btn-emulator" class="btn" href="emulator.html?token=<c:out value="${assignment.token}"/>">
			<i class="icon-bolt sw-button-icon"></i> ${rb.getString("jsp.assignments.detail.emulateassignment")}</a>
		<a id="btn-edit-assignment" class="btn" href="javascript:void(0)">
			<i class="icon-edit sw-button-icon"></i> ${rb.getString("jsp.assignments.detail.editassignment")}</a>
	</div>
</div>

<!-- Detail panel for selected assignment -->
<div id="assignment-details" style="line-height: normal;"></div>

<!-- Tab panel -->
<div id="tabs">
	<ul>
		<li class="k-state-active">${rb.getString("jsp.assignments.detail.locations")}</li>
		<li>${rb.getString("jsp.assignments.detail.measurements")}</li>
		<li>${rb.getString("jsp.assignments.detail.alerts")}</li>
		<li>${rb.getString("jsp.assignments.detail.commandinvocations")}</li>
		<li>CPU Charts</li>
		<li>Memory Charts</li>
	</ul>
	<div>
		<div class="k-header sw-button-bar">
			<div class="sw-button-bar-title">${rb.getString("jsp.assignments.detail.devicelocations")}</div>
			<div>
				<a id="btn-filter-locations" class="btn" href="javascript:void(0)">
					<i class="icon-search sw-button-icon"></i> ${rb.getString("jsp.assignments.detail.filterresults")}</a>
				<a id="btn-refresh-locations" class="btn" href="javascript:void(0)">
					<i class="icon-refresh sw-button-icon"></i> ${rb.getString("jsp.assignments.detail.refresh")}</a>
			</div>
		</div>
		<table id="locations">
			<colgroup>
				<col style="width: 20%;"/>
				<col style="width: 20%;"/>
				<col style="width: 20%;"/>
				<col style="width: 20%;"/>
			</colgroup>
			<thead>
				<tr>
					<th>${rb.getString("jsp.assignments.detail.latitude")}</th>
					<th>${rb.getString("jsp.assignments.detail.longitude")}</th>
					<th>${rb.getString("jsp.assignments.detail.elevation")}</th>
					<th>${rb.getString("jsp.assignments.detail.eventdate")}</th>
				</tr>
			</thead>
			<tbody>
				<tr><td colspan="5"></td></tr>
			</tbody>
		</table>
		<div id="locations-pager" class="k-pager-wrap event-pager"></div>
	</div>
	<div>
		<div class="k-header sw-button-bar">
			<div class="sw-button-bar-title">${rb.getString("jsp.assignments.detail.devicemeasurements")}</div>
			<div>
				<a id="btn-filter-measurements" class="btn" href="javascript:void(0)">
					<i class="icon-search sw-button-icon"></i> ${rb.getString("jsp.assignments.detail.filterresults")}</a>
				<a id="btn-refresh-measurements" class="btn" href="javascript:void(0)">
					<i class="icon-refresh sw-button-icon"></i> ${rb.getString("jsp.assignments.detail.refresh")}</a>
			</div>
		</div>
		<table id="measurements">
			<colgroup>
				<col style="width: 37%;"/>
				<col style="width: 20%;"/>
			</colgroup>
			<thead>
				<tr>
					<th>${rb.getString("jsp.assignments.detail.measurements")}</th>
					<th>${rb.getString("jsp.assignments.detail.eventdate")}</th>
				</tr>
			</thead>
			<tbody>
				<tr><td colspan="3"></td></tr>
			</tbody>
		</table>
		<div id="measurements-pager" class="k-pager-wrap event-pager"></div>
	</div>
	<div>
		<div class="k-header sw-button-bar">
			<div class="sw-button-bar-title">${rb.getString("jsp.assignments.detail.devicealerts")}</div>
			<div>
				<a id="btn-filter-alerts" class="btn" href="javascript:void(0)">
					<i class="icon-search sw-button-icon"></i> ${rb.getString("jsp.assignments.detail.filterresults")}</a>
				<a id="btn-refresh-alerts" class="btn" href="javascript:void(0)">
					<i class="icon-refresh sw-button-icon"></i> ${rb.getString("jsp.assignments.detail.refresh")}</a>
			</div>
		</div>
		<table id="alerts">
			<colgroup>
				<col style="width: 10%;"/>
				<col style="width: 20%;"/>
				<col style="width: 10%;"/>
				<col style="width: 20%;"/>
			</colgroup>
			<thead>
				<tr>
					<th>${rb.getString("jsp.assignments.detail.type")}</th>
					<th>${rb.getString("jsp.assignments.detail.message")}</th>
					<th>${rb.getString("jsp.assignments.detail.source")}</th>
					<th>${rb.getString("jsp.assignments.detail.eventdate")}</th>
				</tr>
			</thead>
			<tbody>
				<tr><td colspan="5"></td></tr>
			</tbody>
		</table>
		<div id="alerts-pager" class="k-pager-wrap event-pager"></div>
	</div>
	<div>
		<div class="k-header sw-button-bar">
			<div class="sw-button-bar-title">${rb.getString("jsp.assignments.detail.devicecommandinvocations")}</div>
			<div>
				<a id="btn-filter-invocations" class="btn" href="javascript:void(0)">
					<i class="icon-search sw-button-icon"></i> ${rb.getString("jsp.assignments.detail.filterresults")}</a>
				<a id="btn-refresh-invocations" class="btn" href="javascript:void(0)">
					<i class="icon-refresh sw-button-icon"></i> ${rb.getString("jsp.assignments.detail.refresh")}</a>
				<a id="btn-create-invocation" class="btn" href="javascript:void(0)">
					<i class="icon-bolt sw-button-icon"></i> ${rb.getString("jsp.assignments.detail.invokecommand")}</a>
			</div>
		</div>
		<table id="invocations">
			<colgroup>
				<col style="width: 32%;"/>
				<col style="width: 15%;"/>
				<col style="width: 12%;"/>
				<col style="width: 20%;"/>
				<col style="width: 8%;"/>
			</colgroup>
			<thead>
				<tr>
					<th>${rb.getString("jsp.assignments.detail.command")}</th>
					<th>${rb.getString("jsp.assignments.detail.source")}</th>
					<th>${rb.getString("jsp.assignments.detail.target")}</th>
					<th>${rb.getString("jsp.assignments.detail.eventdate")}</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr><td colspan="5"></td></tr>
			</tbody>
		</table>
		<div id="invocations-pager" class="k-pager-wrap event-pager"></div>
	</div>


	<div style="padding:30px 0 ">
		<div id="charts_1" style="width:900px;height:500px;margin:0 auto"></div>

	</div>
	<div style="padding:30px 0 ">
		<div id="memory_1" style="width:900px;height:500px;margin:0 auto"></div>

	</div>


</div>

<%@ include file="../includes/assignmentUpdateDialog.inc"%>
<%@ include file="../includes/commandInvokeDialog.inc"%>
<%@ include file="../includes/invocationViewDialog.inc"%>
<%@ include file="../includes/templateAssignmentEntry.inc"%>
<%@ include file="../includes/templateInvocationEntry.inc"%>
<%@ include file="../includes/templateInvocationSummaryEntry.inc"%>
<%@ include file="../includes/templateResponseSummaryEntry.inc"%>
<%@ include file="../includes/templateLocationEntry.inc"%>
<%@ include file="../includes/templateMeasurementsEntry.inc"%>
<%@ include file="../includes/templateAlertEntry.inc"%>
<%@ include file="../includes/commonFunctions.inc"%>

<script>
	/** Assignment token */
	var token = '<c:out value="${assignment.token}"/>';
	
	/** Device specification token */
	var specificationToken = '<c:out value="${assignment.device.specificationToken}"/>';
	
	/** Datasource for invocations */
	var invocationsDS;
	
	/** Datasource for locations */
	var locationsDS;
	
	/** Datasource for measurements */
	var measurementsDS;
	
	/** Datasource for alerts */
	var alertsDS;
	
	/** Reference to tab panel */
	var tabs;
	
	/** Size of pages from server */
	var pageSize = 100;
	
	/** Height of event grids */
	var gridHeight = 350;
	
	/** Called when 'edit assignment' is clicked */
	function onEditAssignment(e, token) {
		var event = e || window.event;
		event.stopPropagation();
		auOpen(token, onEditAssignmentComplete);
	}
	
	/** Called after successful edit assignment */
	function onEditAssignmentComplete() {
		// Handle reload.
	}
	
	/** Called when 'release assignment' is clicked */
	function onReleaseAssignment(e, token) {
		var event = e || window.event;
		event.stopPropagation();
		swReleaseAssignment(token, onReleaseAssignmentComplete);
	}
	
	/** Called after successful release assignment */
	function onReleaseAssignmentComplete() {
		loadAssignment();
	}
	
	/** Called when 'missing assignment' is clicked */
	function onMissingAssignment(e, token) {
		var event = e || window.event;
		event.stopPropagation();
		swAssignmentMissing(token, onMissingAssignmentComplete);
	}
	
	/** Called after successful missing assignment */
	function onMissingAssignmentComplete() {
		loadAssignment();
	}
	
	/** Called to view an invocation */
	function onViewInvocation(id) {
		ivOpen(id);
	}
	
	$(document).ready(function() {
		
		/** Create AJAX datasource for locations list */
		locationsDS = new kendo.data.DataSource({
			transport : {
				read : {
					url : "${pageContext.request.contextPath}/api/assignments/" + token + "/locations",
					dataType : "json",
				}
			},
			schema : {
				data: "results",
				total: "numResults",
				parse: parseEventResults,
			},
            serverPaging: true,
            serverSorting: true,
            pageSize: pageSize,
		});
		
		/** Create the location list */
        $("#locations").kendoGrid({
			dataSource : locationsDS,
            rowTemplate: kendo.template($("#tpl-location-entry").html()),
            scrollable: true,
            height: gridHeight,
        });
		
	    $("#locations-pager").kendoPager({
	        dataSource: locationsDS
	    });
		
	    $("#btn-refresh-locations").click(function() {
	    	locationsDS.read();
	    });
	    $('#btn-filter-locations').attr('disabled', true);
	    
		/** Create AJAX datasource for measurements list */
		measurementsDS = new kendo.data.DataSource({
			transport : {
				read : {
					url : "${pageContext.request.contextPath}/api/assignments/" + token + "/measurements",
					dataType : "json",
				}
			},
			schema : {
				data: "results",
				total: "numResults",
				parse: parseEventResults,
			},
            serverPaging: true,
            serverSorting: true,
            pageSize: pageSize,
		});
		
		/** Create the measurements list */
        $("#measurements").kendoGrid({
			dataSource : measurementsDS,
            rowTemplate: kendo.template($("#tpl-measurements-entry").html()),
            scrollable: true,
            height: gridHeight,
        });
		
	    $("#measurements-pager").kendoPager({
	        dataSource: measurementsDS
	    });
		
	    $("#btn-refresh-measurements").click(function() {
	    	measurementsDS.read();
	    });
	    $('#btn-filter-measurements').attr('disabled', true);
		/** Create charts_1 */

		var cpu = [];
		var dataset;
		var totalPoints = 100;
		var updateInterval = 1000;
		var now = new Date().getTime();

		var options = {
			series: {
				lines: {
					lineWidth: 1.2
				}
			},
			xaxis: {
				mode: "time",
				timezone: "browser",
				timeformat: "%Y/%m/%d %H:%M:%S",
				tickLength: 0,

				tickSize: [10, "second"],

				axisLabelUseCanvas: true,
				axisLabelFontSizePixels: 12,
				axisLabelFontFamily: 'Verdana, Arial',
				axisLabelPadding: 10
			},
			yaxes: [
				{
					min: 0,
					max: 100,
					tickSize: 10,
					tickFormatter: function (v, axis) {
						if (v % 10 == 0) {
							return v + "%";
						} else {
							return "";
						}
					},
					position: "right",
					axisLabelUseCanvas: true,
					axisLabelFontSizePixels: 12,
					axisLabelFontFamily: 'Verdana, Arial',
					axisLabelPadding: 6
				}
			],
			legend: {

				labelBoxBorderColor: "#117dbb",
				noColumns: 0,
				position: "nw"
			},
			grid: {
				color: "#117dbb",
				tickColor: "#d9eaf4",
				backgroundColor: "#ffffff"
			}
		};

		function initData() {
			for (var i = 0; i < totalPoints; i++) {
				var temp = [now += updateInterval, 0];
				cpu.push(temp);
			}
		}

		function GetData() {
			FlyJSONP.init({debug: true});
			FlyJSONP.get({
				url: "${pageContext.request.contextPath}/api/assignments/" + token + "/measurements?page=1&pageSize=1",
				success: update,
				error: function () {
					setTimeout(GetData, updateInterval);
				}
			});
		}


		function update(_data) {
			var cpu_data = Math.round(_data.results[0].measurements['cpu.utils']);
			cpu.shift();
			now += updateInterval

			temp = [now, cpu_data];
			cpu.push(temp);


			dataset = [
				{label: "CPU:" + cpu_data + "%", data: cpu, lines: {fill: true, lineWidth: 0.5}, color: "#f1f6fa"}
			];

			$.plot($("#charts_1"), dataset, options);
			setTimeout(GetData, updateInterval);
		}


		$(document).ready(function () {
			initData();

			dataset = [
				{label: "CPU", data: cpu, lines: {fill: true, lineWidth: 0.5}, color: "#f1f6fa"}
			];

			$.plot($("#charts_1"), dataset, options);
			setTimeout(GetData, updateInterval);

		});

		/** Create memory_1 */

		var memory = [];
		var memory_dataset;
		var memory_totalPoints = 100;
		var memory_updateInterval = 1000;
		var memory_now = new Date().getTime();

		var options = {
			series: {
				lines: {
					lineWidth: 1.2
				}
			},
			xaxis: {
				mode: "time",
				timezone: "browser",
				timeformat: "%Y/%m/%d %H:%M:%S",
				tickLength: 0,

				tickSize: [10, "second"],

				axisLabelUseCanvas: true,
				axisLabelFontSizePixels: 12,
				axisLabelFontFamily: 'Verdana, Arial',
				axisLabelPadding: 10
			},
			yaxes: [
				{
					min: 0,
					max: 100,
					tickSize: 10,
					tickFormatter: function (v, axis) {
						if (v % 10 == 0) {
							return v + "%";
						} else {
							return "";
						}
					},
					position: "right",
					axisLabelUseCanvas: true,
					axisLabelFontSizePixels: 12,
					axisLabelFontFamily: 'Verdana, Arial',
					axisLabelPadding: 6
				}
			],
			legend: {

				labelBoxBorderColor: "#117dbb",
				noColumns: 0,
				position: "nw"
			},
			grid: {
				color: "#117dbb",
				tickColor: "#d9eaf4",
				backgroundColor: "#ffffff"
			}
		};

		function memory_initData() {
			for (var i = 0; i < memory_totalPoints; i++) {
				var memory_temp = [memory_now += memory_updateInterval, 0];
				memory.push(memory_temp);
			}
		}

		function memory_GetData() {
			FlyJSONP.init({debug: true});
			FlyJSONP.get({
				url: "${pageContext.request.contextPath}/api/assignments/" + token + "/measurements?page=1&pageSize=1",
				success: memory_update,
				error: function () {
					setTimeout(memory_GetData, memory_updateInterval);
				}
			});
		}


		function memory_update(_data) {
			var memory_data = Math.round(_data.results[0].measurements['mem.utils']);
			memory.shift();
			memory_now += memory_updateInterval

			memory_temp = [now, memory_data];
			memory.push(memory_temp);


			memory_dataset = [
				{
					label: "Memory:" + memory_data + "%",
					data: memory,
					lines: {fill: true, lineWidth: 0.5},
					color: "#f1f6fa"
				}
			];

			$.plot($("#memory_1"), memory_dataset, options);
			setTimeout(memory_GetData, memory_updateInterval);
		}


		$(document).ready(function () {
			memory_initData();

			memory_dataset = [
				{label: "Memory", data: memory, lines: {fill: true, lineWidth: 0.5}, color: "#f1f6fa"}
			];

			$.plot($("#memory_1"), memory_dataset, options);
			setTimeout(memory_GetData, memory_updateInterval);

		});

		/** Create AJAX datasource for alerts list */
		alertsDS = new kendo.data.DataSource({
			transport : {
				read : {
					url : "${pageContext.request.contextPath}/api/assignments/" + token + "/alerts",
					dataType : "json",
				}
			},
			schema : {
				data: "results",
				total: "numResults",
				parse: parseEventResults,
			},
            serverPaging: true,
            serverSorting: true,
            pageSize: pageSize,
		});
		
		/** Create the alerts list */
        $("#alerts").kendoGrid({
			dataSource : alertsDS,
            rowTemplate: kendo.template($("#tpl-alert-entry").html()),
            scrollable: true,
            height: gridHeight,
        });
		
	    $("#alerts-pager").kendoPager({
	        dataSource: alertsDS
	    });
		
	    $("#btn-refresh-alerts").click(function() {
	    	alertsDS.read();
	    });
	    $('#btn-filter-alerts').attr('disabled', true);
	    
		/** Create AJAX datasource for invocations list */
		invocationsDS = new kendo.data.DataSource({
			transport : {
				read : {
					url : "${pageContext.request.contextPath}/api/assignments/" + token + "/invocations",
					dataType : "json",
				}
			},
			schema : {
				data: "results",
				total: "numResults",
				parse: parseEventResults,
			},
            serverPaging: true,
            serverSorting: true,
            pageSize: pageSize,
		});
		
		/** Create the invocations list */
        $("#invocations").kendoGrid({
			dataSource : invocationsDS,
            rowTemplate: kendo.template($("#tpl-invocation-entry").html()),
            scrollable: true,
            height: gridHeight,
        });
		
	    $("#btn-refresh-invocations").click(function() {
	    	invocationsDS.read();
	    });
	    $('#btn-filter-invocations').attr('disabled', true);
		
	    $("#btn-create-invocation").click(function() {
			ciOpen(token, specificationToken, onInvokeCommandSuccess);
	    });
		
	    $("#invocations-pager").kendoPager({
	        dataSource: invocationsDS
	    });
		
	    $("#btn-edit-assignment").click(function() {
			auOpen(token, onAssignmentEditSuccess);
	    });
		
		/** Create the tab strip */
		tabs = $("#tabs").kendoTabStrip({
			animation: false,
			activate: onActivate
		}).data("kendoTabStrip");
		
		loadAssignment();
	});
	
	/** Force grid refresh on first tab activate (KendoUI bug) */
	function onActivate(e) {
		var tabName = e.item.textContent;
		if (!e.item.swInitialized) {
			if (tabName =="Locations") {
				locationsDS.read();
				e.item.swInitialized = true;
			} else if (tabName =="Measurements") {
				measurementsDS.read();
				e.item.swInitialized = true;
			} else if (tabName =="Alerts") {
				alertsDS.read();
				e.item.swInitialized = true;
			} else if (tabName =="Command Invocations") {
				invocationsDS.read();
				e.item.swInitialized = true;
			}
		}
	};
	
	/** Loads information for the selected assignment */
	function loadAssignment() {
		$.getJSON("${pageContext.request.contextPath}/api/assignments/" + token, 
			loadGetSuccess, loadGetFailed);
	}
    
    /** Called on successful assignment load request */
    function loadGetSuccess(data, status, jqXHR) {
		var template = kendo.template($("#tpl-assignment-entry").html());
		parseAssignmentData(data);
		data.inDetailView = true;
		$('#assignment-details').html(template(data));
    }
    
	/** Handle error on getting assignment data */
	function loadGetFailed(jqXHR, textStatus, errorThrown) {
		handleError(jqXHR, "Unable to load assignment data.");
	}
	
	/** Parses event response records to format dates */
	function parseEventResults(response) {
	    $.each(response.results, function (index, item) {
			parseEventData(item);
	    });
	    return response;
	}
	
	/** Called after successful edit of assignment */
	function onAssignmentEditSuccess() {
		loadAssignment();
	}
	
	/** Called after successful edit of assignment */
	function onInvokeCommandSuccess() {
    	invocationsDS.read();
	}
</script>

<%@ include file="../includes/bottom.inc"%>