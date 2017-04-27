<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="API请求监控" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:formpanel layout="column" columnWidth="1" region="north"
			border="false" id="_loan">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:textfield fieldLabel="Post请求ID" name="uuid_" emptyText="填写Post请求ID"
				columnWidth="0.33" />
			<aos:combobox fieldLabel="归属业务线" name="platform_id_" editable="false"
				columnWidth="0.33" url="comboboxService.platformCombobox"/>
			<aos:textfield fieldLabel="IP地址" name="ip_" emptyText="填写IP地址" columnWidth="0.33" />
			<aos:combobox fieldLabel="API接口" name="service_code_" editable="false"
				columnWidth="0.33" dicField="api_interface_" />
			<aos:datefield fieldLabel="请求时间" name="start_request_time_" emptyText="开始日期"
				columnWidth="0.186" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_request_time_" emptyText="结束日期"
				columnWidth="0.126" />
			
			<aos:datefield fieldLabel="响应时间" name="start_response_time_" emptyText="开始日期"
				columnWidth="0.186" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_response_time_" emptyText="结束日期"
				columnWidth="0.126" />
				
			<%-- <aos:combobox fieldLabel="响应码" name="response_code_" editable="false"
				columnWidth="0.33" dicField="response_code_"/> --%>
		
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_api_request" url="apiRequestMinitorService.apiRequestPage" onrender="_g_loan_query" pageSize="30" autoScroll="true" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="Post请求列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="Post请求ID" dataIndex="uuid_" celltip="true" width="30" align="center"/>
			<aos:column header="归属业务线" dataIndex="platform_id_" celltip="true" width="60" align="center"/>
			<aos:column header="IP地址" dataIndex="ip_" width="35" rendererField="loan_location_" celltip="true" align="center"/>
			<aos:column header="API接口" dataIndex="service_code_" width="45" align="center" rendererField="api_interface_"/>
			<aos:column header="请求时间" dataIndex="time_" width="35" align="center"/>
			<aos:column header="响应时间" dataIndex="response_time_" width="30" align="center" rendererField="third_channel_id_"/>
			<aos:column header="响应码" dataIndex="response_code_" width="60" align="center"/>
			<aos:column header="响应码摘要" dataIndex="summary_" width="70" align="center"/>
			<aos:column header="操作" align="center" fixedWidth="80" rendererFn="fn_bt_chargebackacceptDedail" />
		</aos:gridpanel>
	</aos:viewport>

	<script type="text/javascript">
		
		//加载表格数据
		function _g_loan_query() {
			var params = _loan.getValues();
			_g_api_request_store.getProxy().extraParams = params;
			_g_api_request_store.loadPage(1);
		}
		//重置 
		function _loan_reset() {
			AOS.reset(_loan);
		}
		
		//详情
		function fn_bt_chargebackacceptDedail(value, metaData, record, rowIndex, colIndex,
				store) {
			return '<input type="button" value="详情" class="cbtn" onclick="_btn_detail_onclick();" />';
		}
	</script>
</aos:onready>

<script type="text/javascript">
	//详情单击按钮事件
	function _btn_detail_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_api_request'));
		var uuid_ = record.data.uuid_;
		parent.fnaddtab('apiRequestMinitorService.findDetail&uuid_=' + uuid_, 'Post请求'+uuid_+'的详情', uuid_);
	}
</script>
