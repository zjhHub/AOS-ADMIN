<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="个人账户详情" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:hiddenfield name="id_" id="id_" value="${id_}" />
		<aos:hiddenfield name="request_uuid_" id="request_uuid_" value="${request_uuid_}" />
		<aos:formpanel id="pri_info" region="north">
			 	<aos:fieldset title="个人账户信息摘要" labelWidth="90" columnWidth="1">
					<aos:textfield name="account_code_" value="${po['account_code_']}" fieldLabel="账户编码" readOnly="true" columnWidth="0.33" />
					<aos:textfield name="purpose_" value="${po['purpose_']}" fieldLabel="账户用途" readOnly="true" columnWidth="0.33" />
					<aos:textfield name="name_" value="${po['name_']}" fieldLabel="归属业务线" readOnly="true" columnWidth="0.33" />
					<aos:textfield name="create_time_" value="${po['create_time_']}" fieldLabel="创建时间" readOnly="true" columnWidth="0.33" />
					<aos:textfield name="total_balance_" value="${po['total_balance_']}" fieldLabel="账面总余额" readOnly="true" columnWidth="0.33" />
					<aos:textfield name="available_balance_" value="${po['available_balance_']}" fieldLabel="可用余额" readOnly="true" columnWidth="0.33" />
					<aos:textfield name="froze_balance_" value="${po['froze_balance_']}" fieldLabel="冻结余额" readOnly="true" columnWidth="0.33" />
					<aos:textfield name="customer_code_" value="${po['customer_code_']}" fieldLabel="客户CRM编码" readOnly="true" columnWidth="0.33" />
					<aos:textfield name="custName" value="${po['custName']}" fieldLabel="客户姓名" readOnly="true" columnWidth="0.33" />
					<aos:textfield name="idcard_" value="${po['idcard_']}" fieldLabel="客户身份证" readOnly="true" columnWidth="0.33" />
					<aos:textfield name="request_uuid_" value="${po['request_uuid_']}" fieldLabel="API请求来源" readOnly="true" columnWidth="0.27" />
					<aos:dockeditem text="查看" columnWidth="0.06" icon="query.png" onclick="fn_bt_checkRequest"/>
				</aos:fieldset>
		</aos:formpanel>
		
		<aos:tabpanel id="id_tabpanel" region="center"  tabBarHeight="30">
			<aos:tab title="收支流水" id="_tab_balaninout" layout="border">
				<aos:gridpanel id="_g_inout" url="accountsService.accBalanceInOutPage" onrender="_g_inout_query" pageSize="20" region="center">
					<aos:column type="rowno" />
					<aos:column header="快照ID" dataIndex="snapshot_id_" hidden="true"/>
					<aos:column header="收支流水ID" dataIndex="id_" width="50" />
					<aos:column header="收支时间" dataIndex="time_"  width="60" />
					<aos:column header="收入" dataIndex="sramount" width="50" />
					<aos:column header="支出" dataIndex="zcamount" width="50" />
					<aos:column header="收支位置" dataIndex="position_" width="50" rendererField="position_"/>
					<aos:column header="收支备注" dataIndex="remark_" width="80" />
					<aos:column header="操作" align="center" fixedWidth="100" rendererFn="fn_bt_inOutDedail"/>
				</aos:gridpanel>
			</aos:tab>
			
			<aos:tab title="内迁流水" id="_tab_balaninside" onactivate="_g_inside_query" layout="border">
				<aos:gridpanel id="_g_inside" url="accountsService.accBalanceInside" pageSize="20" region="center">
					<aos:column type="rowno" />
					<aos:column header="快照ID" dataIndex="snapshot_id_" hidden="true"/>
					<aos:column header="内迁流水ID" dataIndex="id_" width="50" />
					<aos:column header="内迁时间" dataIndex="time_" width="60" />
					<aos:column header="迁出位置" dataIndex="out_" rendererField="move_position_" width="50" />
					<aos:column header="迁入位置" dataIndex="in_" rendererField="move_position_" width="50" />
					<aos:column header="内迁备注" dataIndex="remark_" width="90" />
					<aos:column header="内迁类型" dataIndex="type_" rendererField="move_record_type_" width="50" />
					<aos:column header="操作" align="center" fixedWidth="100" rendererFn="fn_bt_insideDedail"/>
				</aos:gridpanel>
			</aos:tab>
			
			<aos:tab title="状态切换历史" id="_tab_statusswitch" onactivate="_g_status_query" layout="border">
				<aos:gridpanel id="_g_status" url="accountsService.accountStatusSwitch" pageSize="20" region="center">
					<aos:column type="rowno" />
					<aos:column header="切换时间" dataIndex="switch_time_" width="60" />
					<aos:column header="切换前" dataIndex="status_before_" rendererField="accounts_status_" width="50" />
					<aos:column header="切换后" dataIndex="status_after_" rendererField="accounts_status_" width="50" />
					<aos:column header="切换起因" dataIndex="switch_reason_" rendererField="switchs_reason" width="90" />
					<aos:column header="切换者" dataIndex="switch_by_" width="50" />
				</aos:gridpanel>
			</aos:tab>
			
		</aos:tabpanel>
		
	</aos:viewport>

	<script type="text/javascript">
		//加载表格数据
		function _g_inout_query() {	
			var accountId = id_.getValue();
			var params = {
					id_ : accountId
			};
			_g_inout_store.getProxy().extraParams = params;
			_g_inout_store.loadPage(1);
		} 

		//内迁记录
		function _g_inside_query() {
			if (!_tab_balaninside.isVisible()) {
				_tabpanel.setActiveTab(_tab_balaninside);
			}
			var account_Id = id_.getValue();
			var params = {
					id_ : account_Id
			};
			_g_inside_store.getProxy().extraParams = params;
			_g_inside_store.loadPage(1);
		}
		
		//状态切换历史
		function _g_status_query() {
			if (!_tab_statusswitch.isVisible()) {
				_tabpanel.setActiveTab(_tab_statusswitch);
			}
			var account_ID = id_.getValue();
			var params = {
					id_ : account_ID
			};
			_g_status_store.getProxy().extraParams = params;
			_g_status_store.loadPage(1);
		}
		
		//收支流水操作 
		function fn_bt_inOutDedail(value, metaData, record, rowIndex, colIndex, store) {
			return '<input type="button" value="账户快照" class="cbtn" onclick="_btn_inoutonclick();" />';
		}
		
		//内迁流水操作 
		function fn_bt_insideDedail(value, metaData, record, rowIndex, colIndex, store) {
			return '<input type="button" value="账户快照" class="cbtn" onclick="_btn_insideonclick();" />';
		}
		
		//API请求来源--查看
		function fn_bt_checkRequest() {
			var request_uuid = request_uuid_.getValue();
			parent.fnaddtab('apiRequestMinitorService.findDetail&uuid_=' + request_uuid, 'Post请求'+request_uuid+'的详情', request_uuid);
		}
		
	</script>

</aos:onready>

<script type="text/javascript">

	//收支流水--账户快照
	function _btn_inoutonclick(){
		var record = AOS.selectone(Ext.getCmp('_g_inout'));
		var snapshot_id_ = record.data.snapshot_id_;
		parent.fnaddtab('balanceTransService.balanceSnapshotDetail&snapshot_id_=' + snapshot_id_, '快照：'+ snapshot_id_+'的详情','776'+snapshot_id_);
	}
	
	//内迁流水--账户快照
	function _btn_insideonclick(){
		var record = AOS.selectone(Ext.getCmp('_g_inside'));
		var snapshot_id_ = record.data.snapshot_id_;
		parent.fnaddtab('balanceTransService.balanceSnapshotDetail&snapshot_id_=' + snapshot_id_, '快照：'+ snapshot_id_+'的详情','773'+snapshot_id_);
	}
	
</script>