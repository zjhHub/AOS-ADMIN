<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="登账&动账权限管理" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:hiddenfield name="platform_id_" id="platform_id_" value="${param['platform_id_'] }"/>
		<aos:formpanel id="rsp_info" layout="column" region="north">
					<aos:textfield name="uuid_" fieldLabel="目标业务线" value="${param['name_']}" readOnly="true" columnWidth="0.3" />
		</aos:formpanel>			
		<aos:gridpanel id="_g_add_account" url="privilegeManagerService.initPlatformPage" idProperty="id_" onrender="_g_loan_query"  pageSize="10"  region="center" height="600" columnWidth="1" >
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="配置附加登&动账权限" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="保存" icon="save.png" onclick="saveBusinessPermission();" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column header="业务线ID" dataIndex="id_" width="80" align="center"/>
			<aos:column header="业务线名称" dataIndex="name_" celltip="true" width="80" align="center"/>
		</aos:gridpanel>
	</aos:viewport>

	<script type="text/javascript">
		AOS.job(function(){
			var form_id = platform_id_.getValue();
			var params = {
					platform_id_ : form_id
			};
			AOS.ajax({
	           url: 'privilegeManagerService.findAllPlatform',
	           params : params,
	           ok: function (data) {
	        	   var records =new Array();
	        	   var array = data.appmsg.split(",");
	        	   for(var i=0;i<array.length;i++){
	        		   var index =parseInt(array[i]);
	        		   var record = _g_add_account_store.getById(index);
	        		   records[i]=record;
	        	   }
	        	   _g_add_account.getSelectionModel().select(records); 
	           }
	       });
		},50);

		function _g_loan_query(){
			_g_add_account_store.loadPage(1);
			
		}
		
		function saveBusinessPermission(){
			var records = AOS.select(_g_add_account);
		 	if (AOS.empty(records)) {
				AOS.tip('最少也得选择一行');
				return;
			}
		 	var ids ="";
		 	for(var i=0;i<records.length;i++){
		 		var record =records[i];
		 		if(i<(records.length-1)){
		 			ids += record.data.id_ +",";
		 		}else{
		 			ids += record.data.id_;
		 		}
		 	}
		 	var form_id = platform_id_.getValue();
		 	var params = {
					platform_id_ : form_id,
					extauth_ids_ : ids
			};
		 	AOS.ajax({
	           url: 'privilegeManagerService.saveBusinessPermission',
	           params : params,
	           ok: function (data) {
	        	   AOS.tip(data.appmsg);
	           }
	       });
		}
	</script>
</aos:onready>

<script type="text/javascript">
	

</script>
