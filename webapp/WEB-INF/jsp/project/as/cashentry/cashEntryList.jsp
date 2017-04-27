<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="充值&提现登账管理" base="http" lib="ext">
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
			<aos:textfield fieldLabel="受理ID" name="id_" emptyText="填写受理ID"
				columnWidth="0.33" />
			<aos:textfield fieldLabel="第三方订单号" name="order_id_" emptyText="填写第三方订单号"
				columnWidth="0.33" />
			<aos:datefield fieldLabel="受理时间" name="start_accepted_time_" emptyText="开始日期"
				columnWidth="0.186" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_accepted_time_" emptyText="结束日期"
				columnWidth="0.118" />
			<aos:combobox fieldLabel="登账类别" name="type_" editable="false"
				columnWidth="0.33" dicField="entry_type_" />
			<aos:textfield fieldLabel="第三方交易账户" name="target_" emptyText="填写第三方交易账户" columnWidth="0.33" />
			<aos:combobox fieldLabel="受理执行结果" name="status_" editable="false"
				columnWidth="0.33" dicField="entry_accept_result_" />
			<aos:combobox fieldLabel="第三方渠道" name="third_channel_" editable="false"
				columnWidth="0.33" dicField="third_channel_id_" />
			<aos:textfield fieldLabel="第三方交易金额" name="min_amount_" emptyText="起始数"
				columnWidth="0.186" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:textfield fieldLabel="" name="max_amount_" emptyText="截止数"
				columnWidth="0.118" />
			<aos:combobox fieldLabel="真实性校验方式" name="proving_way_" editable="false"
				columnWidth="0.33" dicField="real_check_way_" />
			<aos:textfield fieldLabel="Post请求起源" name="request_uuid_" emptyText="填写Post请求起源" columnWidth="0.33" />
			<aos:combobox fieldLabel="受理状态" name="accepted_status_" editable="false"
				columnWidth="0.33" dicField="cash_accept_status_" value="1"/>
		
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_api_request" url="cashEntryService.initPage" onrender="_g_loan_query" pageSize="30" autoScroll="true" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="受理列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="受理ID" dataIndex="id_" celltip="true" width="30" align="center"/>
			<aos:column header="充值提现标记" dataIndex="type_" celltip="true" rendererField="entry_type_" width="30" align="center"/>
			<aos:column header="第三方渠道" dataIndex="third_channel_" width="35" rendererField="third_channel_id_" celltip="true" align="center"/>
			<aos:column header="第三方订单号" dataIndex="order_id_" width="45" align="center"/>
			<aos:column header="第三方交易账户" dataIndex="target_" width="35" align="center"/>
			<aos:column header="第三方交易金额" dataIndex="amount_" width="30" align="center"/>
			<aos:column header="受理时间" dataIndex="accepted_time_" width="60" align="center"/>
			<aos:column header="真实性校验方式" dataIndex="proving_way_" rendererField="real_check_way_"  width="30" align="center"/>
			<aos:column header="受理执行结果" dataIndex="status_" width="30" align="center" rendererField="entry_accept_result_"/>
			<aos:column header="受理状态" dataIndex="accepted_status_" rendererField="cash_accept_status_" width="30" align="center"/>
			<aos:column header="Post请求起源" dataIndex="request_uuid_" width="30" align="center"/>
			<aos:column header="操作" align="center" fixedWidth="250" rendererFn="fn_bt_chargebackacceptDedail" />
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
			var html ="<input type='button' value='详情' class='cbtn' onclick='_btn_detail_onclick();' />";
			html +="&nbsp;&nbsp;<input type='button' value='交易溯源' class='cbtn' onclick='_btn_business_original_onclick();' />";
			var proving_way_ =record.data.proving_way_;
			if(proving_way_==2){//财务手动校验
				html +="&nbsp;&nbsp;<input type='button' value='手动校验' class='cbtn' onclick='_btn_proving_manual_onclick();' />";
			}
			return html;
		}
	</script>
</aos:onready>

<script type="text/javascript">
	//详情单击按钮事件
	function _btn_detail_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_api_request'));
		var acceptID = record.data.id_;
		var type_ = record.data.type_;
		parent.fnaddtab('cashEntryService.findDetail&id_=' + acceptID+'&operation_type_='+type_, '受理'+acceptID+'的详情', acceptID);
	}
	
	//交易溯源
	function _btn_business_original_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_api_request'));
		var uuid_ = record.data.request_uuid_;
		parent.fnaddtab('apiRequestMinitorService.findDetail&uuid_=' + uuid_, 'Post请求'+uuid_+'的详情', uuid_);
	}
	
	//手动校验
	function _btn_proving_manual_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_api_request'));
		var acceptID = record.data.id_;
		var type_ = record.data.type_;
		parent.fnaddtab('cashEntryService.provingMaual&id_=' + acceptID+'&operation_type_='+type_, '财务手动校验受理'+acceptID+'的登账', acceptID+"zyy");
	} 
</script>
