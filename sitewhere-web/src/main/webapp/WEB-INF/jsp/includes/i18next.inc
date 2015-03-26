<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/i18next-1.7.7.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/i18next.amd.withJQuery-1.7.7.min.js"></script>
<script type="text/javascript">
   var i18next;
   var sitewhere_i18next = {
                             "sitewhere_title":"",
                             "title_arry":[],
                             "i18nextTitle":function(){
                                 var arry = this.title_arry;
                                 for(var i=0;i<arry.length;i++){
		                            $("input[title='"+arry[i].key+"']").attr("title",i18next(arry[i].value));
	                             }
                             },
                             "i18next_sitewhere_title":function(){
                                 var title = i18next(this.sitewhere_title);
                                 if((title != null) || title != ""){
                                     $("title").html("SiteWhere - " + title);
                                 }
                             },
                             "i18n":function(){
                                 this.i18nextTitle();
                                 this.i18next_sitewhere_title();
                             }
                           };
                           
   /** Get lng */                 
   var lng = window.navigator.language;
   if(lng != null && lng !=""){
      lng = lng.substring(0,2).toLowerCase();
   }else{
      lng = "dev";
   }
   
    /** I18n init */ 
   $(function(){
      i18nInit();
   });
   
   /** I18n init function */
   function i18nInit(){
      var option = {lng:lng,resGetPath:'${pageContext.request.contextPath}/locales/__lng__/translation.json',useLocalStorage:true,lowerCaseLng:true};
      i18n.init(option,function(t){
         $("body").i18n(); 
         i18next = t;
         /** I18n sitewhere (properties and tile lab)*/
         sitewhere_i18next.i18n();
      });
   }
   
   /** Arry Accumulate */
   function arryAccum(arry1,arry2){
       var tem_arry = [];
       var end = arry1.length;;
       for(var i=0;i<arry1.length;i++){
          tem_arry[i] = arry1[i];
       }
       for(var i=0;i<arry2.length;i++){
          tem_arry[end + i] = arry2[i];
       }
       return tem_arry;
   }
   
   /** I18n template */
   function kendoI18next(kendoID){
      var html = $("#"+kendoID).html();
      var arry = getArryBykendoID(kendoID);
	  for(var i=0;i<arry.length;i++){
		 html = html.replace(arry[i].key,arry[i].value);
	  }
      return html;
   }
   
   /** Super arry */
   function getArryBykendoID(kendoID){
      var arry = [];
      switch(kendoID){
         case "tpl-specification-entry":
            arry = [
		             {'key':/Edit Specification/g,'value':i18next("public.EditSpecification")},
		             {'key':/Delete Specification/g,'value':i18next("public.DeleteSpecification")},
		             {'key':/View Specification/g,'value':i18next("public.ViewSpecification")},
		             {'key':/Created:/g,'value':i18next("public.Created")+':'},
		             {'key':/Asset:/g,'value':i18next("public.Asset")+':'},
		             {'key':/Updated:/g,'value':i18next("public.Updated")+':'},
		             {'key':/Desc:/g,'value':i18next("includes.Desc")+':'}
		           ];
		    break;
		 case "tpl-site-entry":
		    arry = [
		             {'key':/Edit Site/g,'value':i18next("public.EditSite")},
		             {'key':/Delete Site/g,'value':i18next("public.DeleteSite")},
		             {'key':/View Site/g,'value':i18next("public.ViewSite")},
		             {'key':/Created:/g,'value':i18next("public.Created")+':'},
		             {'key':/Updated:/g,'value':i18next("public.Updated")+':'}
		           ];
		    break;
		 case "tpl-device-group-entry":
		    arry = [
                     {'key':/Edit Device Group/g,'value':i18next("public.EditDeviceGroup")},
                     {'key':/Delete Device Group/g,'value':i18next("includes.DeleteDeviceGroup")},
                     {'key':/View Device Group/g,'value':i18next("public.ViewDeviceGroup")},
                     {'key':/Created:/g,'value':i18next("public.Created")+':'},
                     {'key':/Updated:/g,'value':i18next("public.Updated")+':'},
                     {'key':/>Device Group</g,'value':'>'+i18next("public.DeviceGroup")+'<'},
                     {'key':/Roles:/g,'value':i18next("public.Roles")+':'},
                     {'key':/Desc:/g,'value':i18next("includes.Desc")+':'}
		           ];
            break;
         case "tpl-device-entry":
            arry = [
                     {'key':/Edit Device/g,'value':i18next("public.EditDevice")},
                     {'key':/Delete Device/g,'value':i18next("public.DeleteDevice")},
                     {'key':/View Device/g,'value':i18next("public.ViewDevice")},
                     {'key':/Created:/g,'value':i18next("public.Created")+':'},
                     {'key':/Updated:/g,'value':i18next("public.Updated")+':'},
                     {'key':/Assigned:/g,'value':i18next("public.Assigned")+':'},
                     {'key':/Status:/g,'value':i18next("public.Status")+':'},
                     {'key':/Spec:/g,'value':i18next("includes.i18next.Spec")+':'},
                     {'key':/Open Assignment/g,'value':i18next("includes.i18next.OpenAssignment")},
                     {'key':/Open Device/g,'value':i18next("includes.i18next.OpenDevice")},
                     {'key':/Release Assignment/g,'value':i18next("includes.ReleaseAssignment")},
                     {'key':/Report Missing/g,'value':i18next("includes.ReportMissing")},
                     {'key':/Report Device\/Asset Missing/g,'value':i18next("includes.i18next.RDAM")},
                     {'key':/>Active</g,'value':'>'+i18next("includes.Active")+'<'},
                     {'key':/>Missing</g,'value':'>'+i18next("includes.Missing")+'<'},
                     {'key':/>Asset</g,'value':'>'+i18next("public.Asset")+'<'},
                     {'key':/>Device</g,'value':'>'+i18next("public.Device")+'<'}
                   ];
            break;
         case "tpl-assignment-entry":
            arry = [
                     {'key':/Edit Assignment/g,'value':i18next("public.EditAssignment")},
                     {'key':/Delete Assignment/g,'value':i18next("public.DeleteAssignment")},
                     {'key':/View Assignment/g,'value':i18next("public.ViewAssignment")},
                     {'key':/Release Assignment/g,'value':i18next("includes.ReleaseAssignment")},
                     {'key':/Report Missing/g,'value':i18next("includes.ReportMissing")},
                     {'key':/Report Device\/Asset Missing/g,'value':i18next("includes.i18next.RDAM")},
                     {'key':/Assigned:/g,'value':i18next("public.Assigned")+':'},
                     {'key':/Released:/g,'value':i18next("public.Released")+':'},
                     {'key':/Status:/g,'value':i18next("public.Status")+':'},
                     {'key':/Open Assignment/g,'value':i18next("includes.i18next.OpenAssignment")},
                     {'key':/Open Device/g,'value':i18next("includes.i18next.OpenDevice")},
                     {'key':/View Assignment/g,'value':i18next("public.ViewAssignment")},
                     {'key':/>Active</g,'value':'>'+i18next("includes.Active")+'<'},
                     {'key':/>Missing</g,'value':'>'+i18next("includes.Missing")+'<'},
                     {'key':/>Asset</g,'value':'>'+i18next("public.Asset")+'<'},
                     {'key':/>Device</g,'value':'>'+i18next("public.Device")+'<'},
                     {'key':/Roles:/g,'value':i18next("public.Roles")+':'},
                     {'key':/Email:/g,'value':i18next("public.Email")+':'}
                   ];
            break;
         case "tpl-command-entry":
            arry = [
                     {'key':/Edit Command/g,'value':i18next("includes.i18next.EditCommand")},
                     {'key':/Delete Command/g,'value':i18next("includes.DeleteCommand")}
                   ];
            break;
         case "tpl-device-group-element-entry":
            arry = [
                     {'key':/Delete Group Element/g,'value':i18next("includes.i18next.DeleteGroupElement")}
                   ];
            break;
         case "tpl-user-entry":
            arry = [
                     {'key':/Edit User/g,'value':i18next("includes.EditUser")},
                     {'key':/Delete User/g,'value':i18next("public.DeleteUser")}
                   ];
            break;
         case "du-static-block":
            arry = [
                     {'key':/Created:/g,'value':i18next("public.Created")+':'},
                     {'key':/Specification:/g,'value':i18next("public.Specification")+':'},
                     {'key':/Updated:/g,'value':i18next("public.Updated")+':'},
                     {'key':/Hardware Id:/g,'value':i18next("public.HardwareId")+':'}
                   ];
            break;
         case "au-static-block":
            arry = [
                     {'key':/Assigned:/g,'value':i18next("public.Assigned")+':'},
                     {'key':/Released:/g,'value':i18next("public.Released")+':'},
                     {'key':/Status:/g,'value':i18next("public.Status")+':'},
                     {'key':/Device:/g,'value':i18next("public.Device")+':'},
                     {'key':/Hardware Id:/g,'value':i18next("public.HardwareId")+':'},
                     {'key':/Asset:/g,'value':i18next("public.Asset")+':'},
                     {'key':/Roles:/g,'value':i18next("public.Roles")+':'},
                     {'key':/Email:/g,'value':i18next("public.Email")+':'},
                     {'key':/>Asset</g,'value':'>'+i18next("public.Asset")+'<'},
                     {'key':/>Device</g,'value':'>'+i18next("public.Device")+'<'}
                   ];
            break;
         case "tpl-assignment-detail-header":
            arry = [
                     {'key':/Created Date:/g,'value':i18next("public.CreatedDate")+':'},
                     {'key':/Date assignment was created/g,'value':i18next("includes.i18next.DAWC")},
                     {'key':/Assigned Hardware/g,'value':i18next("includes.i18next.AssignedHardware")},
                     {'key':/Assigned hardware/g,'value':i18next("includes.i18next.Assignedhardware")},
                     {'key':/Assigned Device:/g,'value':i18next("includes.i18next.AssignedDevice")+':'},
                     {'key':/Device used by assignment/g,'value':i18next("includes.i18next.DUBA")},
                     {'key':/Updated Date:/g,'value':i18next("public.UpdatedDate")+':'},
                     {'key':/Date assignment was last updated/g,'value':i18next("includes.i18next.DAWLU")},
                     {'key':/Active Date:/g,'value':i18next("includes.i18next.ActiveDate")+':'},
                     {'key':/Date assignment became active/g,'value':i18next("includes.i18next.DABA")},
                     {'key':/Released Date:/g,'value':i18next("includes.i18next.ReleasedDate")+':'},
                     {'key':/Date assignment was released/g,'value':i18next("includes.i18next.DAWR")},
                     {'key':/Assignment Status/g,'value':i18next("includes.i18next.AssignmentStatus")},
                     {'key':/Assignment status/g,'value':i18next("includes.i18next.Assignmentstatus")},
                     {'key':/Unique assignment token/g,'value':i18next("includes.i18next.UAT")},
                     {'key':/Release Assignment/g,'value':i18next("includes.ReleaseAssignment")},
                     {'key':/Report Missing/g,'value':i18next("includes.ReportMissing")},
                     {'key':/Report Device\/Asset Missing/g,'value':i18next("includes.i18next.RDAM")},
                     {'key':/>Active</g,'value':'>'+i18next("includes.Active")+'<'},
                     {'key':/>Missing</g,'value':'>'+i18next("includes.Missing")+'<'},
                     {'key':/>Asset</g,'value':'>'+i18next("public.Asset")+'<'}
                   ];
            break;
         case "tpl-batch-command-invocation-entry":
            arry = [
                     {'key':/Created Date:/g,'value':i18next("public.CreatedDate")+':'}
                   ];
            break;
         case "tpl-device-detail-header":
            arry = [
                     {'key':/Created Date:/g,'value':i18next("public.CreatedDate")+':'},
                     {'key':/Date device was added to the system/g,'value':i18next("includes.i18next.DDWATTS")},
                     {'key':/Updated Date:/g,'value':i18next("public.UpdatedDate")+':'},
                     {'key':/Date device was last updated/g,'value':i18next("includes.i18next.DDWLU")},
                     {'key':/>Device</g,'value':'>'+i18next("public.Device")+'<'}
                   ];
            break;
         case "tpl-alert-entry":
            arry = [
                     {'key':/View Assignment/g,'value':i18next("public.ViewAssignment")}
                   ];
            break;
         case "tpl-location-entry":
            arry = [
                     {'key':/View Assignment/g,'value':i18next("public.ViewAssignment")}
                   ];
            break;
         case "tpl-measurements-entry":
            arry = [
                     {'key':/View Assignment/g,'value':i18next("public.ViewAssignment")}
                   ];
            break;
         case "tpl-invocation-entry":
            arry = [
                     {'key':/View Invocation/g,'value':i18next("includes.templateInvocationEntry.ViewInvocation")}
                   ];
            break;
         case "tpl-zone-entry":
            arry = [
                     {'key':/Edit Zone/g,'value':i18next("includes.EditZone")},
                     {'key':/Delete Zone/g,'value':i18next("includes.DeleteZone")}
                   ];
            break;
      }
      return arry;      
   };
</script>