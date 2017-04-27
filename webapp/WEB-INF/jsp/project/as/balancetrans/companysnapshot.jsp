<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="账户余额快照" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border" >
		<aos:hiddenfield name="id_" id="id_" value="${snapshot_id_}" />
			
				 <aos:formpanel id="_f_detail"  region="north" rowSpace="25" labelWidth="200">
				 	<aos:docked forceBoder="0 0 0 0">
						<aos:dockeditem xtype="tbtext" text="快照详情" />
					</aos:docked>
					<aos:textfield name="id_" fieldLabel="快照ID" readOnly="true" columnWidth="0.33" value="${po['id_']}"/>
					<aos:textfield name="origin_id_" fieldLabel="回溯来源" columnWidth="0.33"  value="${po['origin_id_']}"/>
					<aos:textfield name="reason_" fieldLabel="快照起因" readOnly="true" value="${po['reason_']}" columnWidth="0.33" />
					<aos:textfield name="created_time_" fieldLabel="快照时间" value="${po['created_time_']}" readOnly="true" columnWidth="0.33" />
					<aos:textfield name="account_code_" fieldLabel="归属账户编码" value="${po['account_code_']}"  readOnly="true" columnWidth="0.33" />
				</aos:formpanel> 
				
				<aos:gridpanel id="_g_trans" url="balanceTransService.totalBalance" onactivate="_g_trans_open" onrender="_g_trans_query"  region="north" hidePagebar="true" height="250">
					<aos:docked forceBoder="0 0 1 0">
						<aos:dockeditem xtype="tbtext" text="账面总余额快照" />
						<aos:dockeditem xtype="tbseparator" />
					</aos:docked>
					<aos:column header="快照对象" dataIndex="total_balance_" celltip="true" width="150"  align="center"/>
					<aos:column header="变动金额" dataIndex="total_balance_changing_" celltip="true" width="260" align="center" />
					<aos:column header="变动前金额" dataIndex="total_balance_before_" width="260" align="center"/>
					<aos:column header="变动后金额" dataIndex="total_balance_after_" celltip="true"  width="260" align="center"/>
				</aos:gridpanel>
				
				<aos:gridpanel id="_g_balance" url="balanceTransService.availableOrFrozeBalance" onactivate="_g_balance_open" onrender="_g_balance_query"  region="center" hidePagebar="true">
					<aos:docked forceBoder="1 0 1 0">
						<aos:dockeditem xtype="tbtext" text="可用&冻结余额快照" />
						<aos:dockeditem xtype="tbseparator" />
					</aos:docked>
					<aos:column header="快照对象" dataIndex="total_balance_" celltip="true" width="150" align="center" />
					<aos:column header="变动金额" dataIndex="balance_changing_" celltip="true" width="260" align="center" />
					<aos:column header="变动前金额" dataIndex="balance_before_" width="260" align="center"/>
					<aos:column header="变动后金额" dataIndex="balance_after_" celltip="true"  width="260" align="center"/>
				</aos:gridpanel>
				
				
	</aos:viewport>

	<script type="text/javascript">
	
		//加载表格数据
		function _g_trans_open() {
			_g_trans_store.loadPage(1);
		} 
		
		
		//加载表格数据
		function _g_trans_query() {		
 			var snapshot_id_ = id_.getValue();
			var params = {
					snapshot_id_ : snapshot_id_
			};
			_g_trans_store.getProxy().extraParams = params;
			_g_trans_store.loadPage(1);
		} 
			
		
		//加载表格数据
		function _g_balance_open() {
			_g_balance_store.loadPage(1);
		} 
		
		
		//加载表格数据
		function _g_balance_query() {
 			var snapshot_id_ = id_.getValue();
 			var params = _f_detail.getValues();
 			var origin_id_ = params.origin_id_;
 			var reason = params.reason_;
			var params = {
					snapshot_id_ : snapshot_id_,
					origin_id_ : origin_id_,
					reason_ : reason
			};
			_g_balance_store.getProxy().extraParams = params;
			_g_balance_store.loadPage(1);
		} 

	</script>

</aos:onready>
<script type="text/javascript">
</script>