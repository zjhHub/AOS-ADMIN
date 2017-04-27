<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="借款端，业务流水" base="http" lib="ext">
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
			<aos:textfield fieldLabel="业务流水ID" name="flow_businessId"
				emptyText="填写业务流水ID" columnWidth="0.33" />
			<aos:combobox fieldLabel="归属业务线" name="id_" editable="false"
				columnWidth="0.34" url="comboboxService.platformCombobox" />
			<aos:textfield fieldLabel="登账请求ID" name="request_uuid_"
				emptyText="填写登账请求ID" columnWidth="0.33" />
			<aos:textfield fieldLabel="业务摘要" name="summary_" emptyText="填写业务摘要"
				columnWidth="0.33" />
			<aos:textfield fieldLabel="所涉资金流水ID" name="flow_moneyId"
				emptyText="填写所涉资金流水ID" columnWidth="0.34" />
			<aos:datefield fieldLabel="流水发生时间" name="start_time_"
				emptyText="开始日期" columnWidth="0.198" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_time_" emptyText="结束日期"
				columnWidth="0.110" />
			<aos:textfield fieldLabel="借款合同ID" name="contractId"
				emptyText="填写借款合同ID" columnWidth="0.33" />
			<aos:textfield fieldLabel="借款合同编号" name="contract_code_"
				emptyText="填写借款合同编号" columnWidth="0.34" />
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_loan" url="flowService.flowPage"
			onrender="_g_loan_query" pageSize="30" autoScroll="true"
			region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="业务流水列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="业务流水ID" dataIndex="flow_businessId"
				celltip="true" width="50" />
			<aos:column header="归属业务线" dataIndex="name_" celltip="true"
				width="80" />
			<aos:column header="借款合同ID" dataIndex="contractId" width="50" />
			<aos:column header="借款合同编号" dataIndex="contract_code_" celltip="true"
				width="60" />
			<aos:column header="业务摘要" dataIndex="summary_" width="80" />
			<aos:column header="所涉资金流水ID" dataIndex="flow_moneyId" width="60" />
			<aos:column header="业务流水发生时间" dataIndex="occured_time_" width="100" />
			<aos:column header="登账请求ID" dataIndex="request_uuid_" width="100"
				celltip="true" />
			<aos:column header="流水创建者IP" dataIndex="ip_address_" width="80" />
			<aos:column header="流水登入时间" dataIndex="created_time_" width="100" />
			<aos:column header="动账明细" align="center" fixedWidth="80"
				rendererFn="fn_bt_flowDedail" />
		</aos:gridpanel>


	</aos:viewport>

	<script type="text/javascript">
		//加载表格数据
		function _g_loan_query() {
			var params = _loan.getValues();
			_g_loan_store.getProxy().extraParams = params;
			_g_loan_store.loadPage(1);
		}
		//重置 
		function _loan_reset() {
			AOS.reset(_loan);
		}

		//调阅 
		function fn_bt_flowDedail(value, metaData, record, rowIndex, colIndex,
				store) {
			if (record.data.id_ == '${flow_businessId}') {
				return '--';
			} else {
				return '<input type="button" value="调阅" class="cbtn" onclick="_btn_flow_onclick();" />';
			}
		}
	</script>
</aos:onready>

<script type="text/javascript">
	function _btn_flow_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_loan'));
		var businessId = record.data.flow_businessId;
		parent.fnaddtab('flowService.flowDatail&businessId=' + businessId, '动账明细', businessId);
	}
</script>
