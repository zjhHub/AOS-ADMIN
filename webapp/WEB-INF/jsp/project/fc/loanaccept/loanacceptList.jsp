<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="借款端，放款受理指令" base="http" lib="ext">
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
			<aos:textfield fieldLabel="放款受理ID" name="chargeback_acceptedID" emptyText="填写划扣受理ID"
				columnWidth="0.33" />
			<aos:textfield fieldLabel="借款合同ID" name="contract_id_" emptyText="填写借款合同ID"
				columnWidth="0.33" />
			<aos:textfield fieldLabel="请求来源" name="request_id_" emptyText="填写请求来源ID" columnWidth="0.33" />
			<aos:combobox fieldLabel="归属业务线" name="platformId" editable="false"
				columnWidth="0.33" url="comboboxService.platformCombobox" />
			<aos:combobox fieldLabel="所在位置" name="location_" editable="false" columnWidth="0.33" 
				dicField="loan_location_" />
			 <aos:textfield fieldLabel="借款合同编码" name="contract_code_" emptyText="填写借款合同编码"
				columnWidth="0.33" />
			<aos:datefield fieldLabel="受理创建时间" name="start_created_time_" emptyText="开始日期"
				columnWidth="0.186" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_created_time_" emptyText="结束日期"
				columnWidth="0.126" />
				
			<aos:textfield fieldLabel="订单号" name="third_channel_order_id_" emptyText="填写订单号"
				columnWidth="0.33" />
	
			<aos:combobox  fieldLabel="放款渠道" name="routed_third_channel_id_" value="0" columnWidth="0.33">
				<aos:option value="" display="全部" />
				<aos:option value="2" display="通联" />
				<aos:option value="4" display="银生宝" />
			</aos:combobox>
		
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem text="导出Excel" onclick="fn_exportexcel()" icon="icon70.png"/>
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_loan" url="loanAcceptService.loanacceptPage" onrender="_g_loan_query" pageSize="30" autoScroll="true" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="划扣受理列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="放款受理ID" dataIndex="chargeback_acceptedID" celltip="true" width="30" align="center"/>
			<aos:column header="请求来源" dataIndex="request_id_" celltip="true" width="60" align="center"/>
			<aos:column header="所在位置" dataIndex="location_" width="35" rendererField="loan_location_" celltip="true" align="center"/>
			<aos:column header="清结算借款合同ID" dataIndex="contract_id_" width="45" align="center"/>
			<aos:column header="所属业务线" dataIndex="platformName" width="35" align="center"/>
			<aos:column header="放款渠道" dataIndex="routed_third_channel_id_" width="30" align="center" rendererField="third_channel_id_"/>
			<aos:column header="业务线借款合同编码" dataIndex="contract_code_" width="60" align="center"/>
			<aos:column header="订单号" dataIndex="third_channel_order_id_" width="70" align="center"/>
			<aos:column header="放款账号" dataIndex="loan_account_" width="30" align="center"/>
			<aos:column header="指令结果状态" dataIndex="order_result_status_" width="35" align="center" rendererField="order_result_status_"/>
			<aos:column header="户主姓名" dataIndex="loan_name_" fixedWidth="80" align="center"/>
			<aos:column header="放款金额" dataIndex="loan_amount_" fixedWidth="80" align="center"/>
			<aos:column header="受理创建时间" dataIndex="created_time_" width="80" celltip="true" align="center"/>
			<aos:column header="操作" align="center" fixedWidth="80" rendererFn="fn_bt_chargebackacceptDedail" />
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
		
		//生成XLS报表
		function fn_exportexcel() {
			AOS.file('do.jhtml?router=loanAcceptService.exportExcel&juid=${juid}');
		}
		
		//调阅 
		function fn_bt_chargebackacceptDedail(value, metaData, record, rowIndex, colIndex,
				store) {
			if (record.data.id_ == '${chargeback_acceptedID}') {
				return '--';
			} else {
				return '<input type="button" value="调阅" class="cbtn" onclick="_btn_chargebackaccept_onclick();" />';
			}
		}
		
	</script>
</aos:onready>

<script type="text/javascript">
	function _btn_chargebackaccept_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_loan'));
		var acceptedID = record.data.chargeback_acceptedID;
		parent.fnaddtab('loanAcceptService.loanacceptAcceptDetails&acceptedID=' + acceptedID, '放款受理指令详情'+acceptedID, acceptedID);
	}

</script>
