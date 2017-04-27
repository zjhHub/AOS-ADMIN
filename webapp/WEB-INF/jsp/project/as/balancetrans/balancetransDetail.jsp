<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="划拨详情" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border" >
		<aos:hiddenfield name="id_" id="id_" value="${id_}" />					
				 <aos:formpanel id="_f_detail"  region="north" rowSpace="20" labelWidth="100" >
					<aos:docked forceBoder="0 0 0 0">
						<aos:dockeditem xtype="tbtext" text="划拨信息摘要" />
					</aos:docked>
						<aos:textfield name="id_" fieldLabel="划拨ID" readOnly="true" columnWidth="0.33" value="${po['id_']}"/>
						<aos:textfield name="created_time_" fieldLabel="创建时间" readOnly="true" value="${po['created_time_']}" columnWidth="0.33" />
						<aos:textfield name="summary_" fieldLabel="划拨用途摘要" value="${po['summary_']}" readOnly="true" columnWidth="0.33" />
						<aos:textfield name="created_by_" fieldLabel="创建者" value="${po['created_by_']}"  readOnly="true" columnWidth="0.33" />
						<aos:textfield name="transfer_amount_" fieldLabel="划拨金额" value="${po['transfer_amount_']}"  readOnly="true" columnWidth="0.33" />
						<aos:textfield name="request_uuid_" fieldLabel="Post请求起源"  value="${po['request_uuid_']}"  readOnly="true" columnWidth="0.28" />
						<aos:button icon="search.png" text="交易溯源" columnWidth="0.05" onclick="_bn_uuid_show();"/>
						<aos:textareafield  name="remark_" fieldLabel="备注" readOnly="true" value="${po['remark_']}" columnWidth="0.99" height="50"/>			
				</aos:formpanel> 
				
				<aos:gridpanel id="_g_trans_in" url="balanceTransService.inTransAccountsDetailsPage" onactivate="_g_trans_open_in" onrender="_g_trans_query_in" pageSize="8" height="310" autoScroll="true" region="north" forceFit="false">
					<aos:docked forceBoder="0 0 1 0">
						<aos:dockeditem xtype="tbtext" text="所涉入金账户" />
						<aos:dockeditem xtype="tbseparator" />
					</aos:docked>
					<aos:column type="rowno" />
					<aos:column header="快照ID" dataIndex="snapshot_id_" hidden="true" width="150" align="center" />
					<aos:column header="账户ID" dataIndex="account_id_" hidden="true" width="150" align="center" />
					<aos:column header="入金ID" dataIndex="trans_accounts_id_" celltip="true" width="260" align="center" />
					<aos:column header="入金账户编码" dataIndex="account_code_" celltip="true" width="260" align="center" />
					<aos:column header="入金具体金额" dataIndex="amount_" width="260" align="center"/>
					<aos:column header="入金的位置" dataIndex="position_" celltip="true"  width="260" align="center" rendererField="position_"/>
					<aos:column header="入金的原由" dataIndex="involve_reason_" width="260" align="center" />
					<aos:column header="操作" align="center" fixedWidth="300" rendererFn="fn_in_bt_trans" />
				</aos:gridpanel>
				
				
				<aos:gridpanel id="_g_trans_out" url="balanceTransService.outTransAccountsDetailsPage" onactivate="_g_open_out" onrender="_g_query_out" pageSize="8" autoScroll="true" region="center" forceFit="false">
					<aos:docked forceBoder="1 0 1 0">
						<aos:dockeditem xtype="tbtext" text="所涉出金账户" />
						<aos:dockeditem xtype="tbseparator" />
					</aos:docked>
					<aos:column type="rowno" />
					<aos:column header="快照ID" dataIndex="snapshot_id_" hidden="true" width="150" align="center" />
					<aos:column header="账户ID" dataIndex="account_id_" hidden="true" width="150" align="center" />
					<aos:column header="出金ID" dataIndex="trans_accounts_id_" celltip="true" width="260" align="center" />
					<aos:column header="出金账户编码" dataIndex="account_code_" celltip="true" width="260" align="center" />
					<aos:column header="出金具体金额" dataIndex="amount_" width="260" align="center"/>
					<aos:column header="出金的位置" dataIndex="position_" celltip="true"  width="260" align="center" rendererField="position_"/>
					<aos:column header="出金的原由" dataIndex="involve_reason_" width="260" align="center" />
					<aos:column header="操作" align="center" fixedWidth="300" rendererFn="fn_out_bt_trans" />
				</aos:gridpanel>		
				
	</aos:viewport>

	<script type="text/javascript">
		
		//加载表格入金数据
		function _g_trans_query_in() {		
 			var transfer_id_ = id_.getValue();
			var params = {
					transfer_id_ : transfer_id_
			};
			_g_trans_in_store.getProxy().extraParams = params;
			_g_trans_in_store.loadPage(1);
		} 
			
		//加载入金数据
		function _g_trans_open_in() {
			_g_trans_in_store.loadPage(1);
		} 
		
		//加载表格出金数据
		function _g_query_out() {		
			var transfer_id_ = id_.getValue();
			var params = {
					transfer_id_ : transfer_id_
			};
			_g_trans_out_store.getProxy().extraParams = params;
			_g_trans_out_store.loadPage(1);
		} 
		
		//加载出金数据
		function _g_open_out() {
			_g_trans_out_store.loadPage(1);
		} 
		
		//账户快照
		function fn_in_bt_trans(value, metaData, record, rowIndex, colIndex,store) {
			return '<input type="button" value="账户快照" class="cbtn" onclick="_btn_in_trans_onclick();" />';
		}
		
		
		//账户快照
		function fn_out_bt_trans (value, metaData, record, rowIndex, colIndex,store) {
			return '<input type="button" value="账户快照" class="cbtn" onclick="_btn_out_trans_onclick();" />';
		}
		
		//交易溯源
		function _bn_uuid_show() {
			var uuid_ = _f_detail.getValues().request_uuid_;
			parent.fnaddtab('apiRequestMinitorService.findDetail&uuid_=' + uuid_, 'Post请求'+uuid_+'的详情', uuid_);
		} 
		
	</script>

</aos:onready>
<script type="text/javascript">

	function _btn_in_trans_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_trans_in'));
		var snapshot_id_ = record.data.snapshot_id_;
		parent.fnaddtab('balanceTransService.balanceSnapshotDetail&snapshot_id_=' + snapshot_id_, '快照：'+ snapshot_id_+'的详情', snapshot_id_+"11");
	}
	
	function _btn_out_trans_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_trans_out'));
		var snapshot_id_ = record.data.snapshot_id_;
		parent.fnaddtab('balanceTransService.balanceSnapshotDetail&snapshot_id_=' + snapshot_id_, '快照：'+ snapshot_id_+'的详情',snapshot_id_+"00");
	}


</script>