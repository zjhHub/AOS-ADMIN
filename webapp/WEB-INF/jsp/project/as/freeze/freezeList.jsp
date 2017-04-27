<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="冻结解冻记录" base="http" lib="ext">
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
			<aos:textfield fieldLabel="冻结或解冻ID" name="id_" emptyText="填写冻结或解冻ID"
				columnWidth="0.33" />
			<aos:datefield fieldLabel="触发时间" name="start_trigger_time_" emptyText="开始日期"
				columnWidth="0.186" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_trigger_time_" emptyText="结束日期"
				columnWidth="0.126" />
			<aos:textfield fieldLabel="账户编码" name="account_code_" emptyText="填写账户编码" columnWidth="0.33" />
			<aos:textfield fieldLabel="操作金额" name="min_amount_" emptyText="起始数"
				columnWidth="0.186" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:textfield fieldLabel="" name="max_amount_" emptyText="截止数"
				columnWidth="0.126" />
			<aos:combobox fieldLabel="操作类别" name="type_" editable="false"
				columnWidth="0.33" dicField="freeze_operation_type_" />
			<aos:textfield fieldLabel="Post请求起源" name="request_uuid_" emptyText="填写Post请求起源" columnWidth="0.33" />
			
		
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_api_request" url="freezeService.initPage" onrender="_g_loan_query" pageSize="30" autoScroll="true" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="冻结&解冻列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="快照ID" dataIndex="snapshot_id_" celltip="true" width="30" align="center" hidden="true"/>
			<aos:column header="冻结|解冻ID" dataIndex="id_" celltip="true" width="30" align="center"/>
			<aos:column header="目标账户编码" dataIndex="account_code_" celltip="true" width="30" align="center"/>
			<aos:column header="操作类型" dataIndex="type_" width="35" rendererField="freeze_operation_type_" celltip="true" align="center"/>
			<aos:column header="操作金额" dataIndex="amount_" width="45" align="center"/>
			<aos:column header="触发者" dataIndex="trigger_by_" width="35" align="center"/>
			<aos:column header="触发时间" dataIndex="trigger_time_" width="30" align="center"/>
			<aos:column header="Post请求起源" dataIndex="request_uuid_" width="60" align="center"/>
			<aos:column header="备注" dataIndex="remark_" width="70" align="center"/>
			<aos:column header="操作" align="center" fixedWidth="200" rendererFn="fn_bt_chargebackacceptDedail" />
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
			return '<input type="button" value="账户快照" class="cbtn" onclick="_btn_trans_onclick();" />&nbsp;&nbsp;<input type="button" value="交易溯源" class="cbtn" onclick="_btn_response_onclick();" />';
		}
	</script>
</aos:onready>

<script type="text/javascript">
	//交易溯源
	function _btn_response_onclick(){
		var record = AOS.selectone(Ext.getCmp('_g_api_request'));
		var uuid_ = record.data.request_uuid_;
		parent.fnaddtab('apiRequestMinitorService.findDetail&uuid_=' + uuid_, 'Post请求'+uuid_+'的详情', uuid_);
	}
	
	//账户快照
	function _btn_trans_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_api_request'));
		var snapshot_id_ = record.data.snapshot_id_;
		var type_ = record.data.type_;
		if(type_==1){
			type_="冻结";
		}else if(type_==2){
			type_="解冻";
		}
		parent.fnaddtab('balanceTransService.balanceSnapshotDetail&snapshot_id_=' + snapshot_id_, type_+'账户余额快照'+snapshot_id_,snapshot_id_);
	}

</script>
