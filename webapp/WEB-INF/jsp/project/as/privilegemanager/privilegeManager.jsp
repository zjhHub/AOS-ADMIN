<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="登账&动账权限管理" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:gridpanel id="_g_api_request" url="privilegeManagerService.initPage" onrender="_g_loan_query" pageSize="30" autoScroll="true" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="现有登&动账权限清单" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="业务线ID" dataIndex="platform_id_" celltip="true" width="30" align="center"/>
			<aos:column header="业务线名称" dataIndex="name_" celltip="true" width="30" align="center"/>
			<aos:column header="登&动账附加权" dataIndex="all_platform_name_" width="35" rendererField="freeze_operation_type_" celltip="true" align="center"/>
			<aos:column header="操作" align="center" fixedWidth="200" rendererFn="fn_bt_chargebackacceptDedail" />
		</aos:gridpanel>
	</aos:viewport>

	<script type="text/javascript">
		
		//加载表格数据
		function _g_loan_query() {
			_g_api_request_store.loadPage(1);
		}
		//详情
		function fn_bt_chargebackacceptDedail(value, metaData, record, rowIndex, colIndex,
				store) {
			return '<input type="button" value="附加权配置" class="cbtn" onclick="_btn_trans_onclick();" />';
		}
	</script>
</aos:onready>

<script type="text/javascript">
	//附加权配置
	function _btn_trans_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_api_request'));
		var platform_id_ = record.data.platform_id_;
		var name_ = record.data.name_;
		parent.fnaddtab('privilegeManagerService.editBusinessPermission&platform_id_=' + platform_id_+'&name_='+name_, '新建登&动账权限到'+name_,platform_id_);
	}

</script>
