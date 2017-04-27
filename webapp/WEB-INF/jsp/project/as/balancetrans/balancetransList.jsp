<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="账户间余额划拨记录" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">

		<aos:formpanel id="_f_trans" layout="column" columnWidth="1" region="north" border="false" >
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:textfield fieldLabel="划拨ID" name="id_"  columnWidth="0.33" />
			<aos:textfield fieldLabel="划拨用途摘要" name="summary_"  columnWidth="0.33" />
 			<aos:textfield fieldLabel="所涉账户编码" name="account_code_" columnWidth="0.33" />
			
			<aos:textfield fieldLabel="划拨金额" name="little_amount_" emptyText="最小范围" columnWidth="0.193" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:textfield fieldLabel="" name="big_amount_" emptyText="最大范围" columnWidth="0.118" />
			
			<aos:textfield fieldLabel="Post请求起源" name="request_uuid_" columnWidth="0.33"  />
			
			<aos:datefield fieldLabel="划拨时间" name="start_time_" emptyText="开始日期" columnWidth="0.189" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_time_" emptyText="结束日期" columnWidth="0.122" />
			
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_trans_query" />
				<aos:dockeditem text="重置" icon="refresh.png" onclick="AOS.reset(_f_trans);" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		
		
		<aos:gridpanel id="_g_trans" url="balanceTransService.balanceTransPage" onrender="_g_trans_query" pageSize="30" autoScroll="true" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="划拨列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="账户编码" dataIndex="account_code_" hidden="true" width="200" align="center"/>
			<aos:column header="划拨ID" dataIndex="id_" celltip="true" width="80" align="center"/>
			<aos:column header="划拨用途摘要" dataIndex="summary_" celltip="true" width="120" align="center"/>
			<aos:column header="划拨金额" dataIndex="transfer_amount_" width="120" align="center"/>
			<aos:column header="创建者" dataIndex="created_by_" celltip="true"  width="120" align="center"/>
			<aos:column header="创建时间" dataIndex="created_time_" width="150" align="center"/>
			<aos:column header="Post请求起源" dataIndex="request_uuid_" width="150" align="center"/>
			<aos:column header="备注" dataIndex="remark_" width="200" align="center"/>
			<aos:column header="操作" align="center" width="200" rendererFn="fn_bt_transl" />
		</aos:gridpanel>

	</aos:viewport>


	<script type="text/javascript">
		//加载表格数据
		function _g_trans_query() {
			var params = _f_trans.getValues();
			_g_trans_store.getProxy().extraParams = params;
			_g_trans_store.loadPage(1);
		}
		
// 		//调阅 
// 		function fn_bt_transl(value, metaData, record, rowIndex, colIndex, store) {
// 			if(record.data.involve_type_=='2'){
// 				return '<input type="button" value="入金划拨详情" class="cbtn" onclick="_btn_in_onclick();" />  <input type="button" value="交易溯源" class="cbtn" onclick="_btn_origin_onclick();" />';
// 			}else if(record.data.involve_type_=='1'){
// 				return '<input type="button" value="出金划拨详情" class="cbtn" onclick="_btn_out_onclick();" />  <input type="button" value="交易溯源" class="cbtn" onclick="_btn_origin_onclick();" />';
// 			}	
// 		}

	//调阅 
		function fn_bt_transl(value, metaData, record, rowIndex, colIndex, store) {
			return '<input type="button" value="划拨详情" class="cbtn" onclick="_btn_onclick();" />  <input type="button" value="交易溯源" class="cbtn" onclick="_btn_origin_onclick();" />';
		}

	</script>
</aos:onready>

<script type="text/javascript">
	//入金划拨详情
	function _btn_in_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_trans'));
		var id_ = record.data.id_;
		parent.fnaddtab('balanceTransService.inBalanceTransDetail&id_=' + id_ , '划拨ID：'+ id_ +'的详情', id_);
	}
	
	//出金划拨详情
	function _btn_out_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_trans'));
		var id_ = record.data.id_;
		parent.fnaddtab('balanceTransService.outBalanceTransDetail&id_=' + id_ , '划拨ID：'+ id_ +'的详情', id_);
	}
	
	
	//出金划拨详情
	function _btn_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_trans'));
		var id_ = record.data.id_;
		parent.fnaddtab('balanceTransService.balanceTransDetail&id_=' + id_ , '划拨ID：'+ id_ +'的详情', id_);
	}
	
	
	//交易溯源  找建华
	function _btn_origin_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_trans'));	
		var uuid_ = record.data.request_uuid_;
		parent.fnaddtab('apiRequestMinitorService.findDetail&uuid_=' + uuid_, 'Post请求'+uuid_+'的详情', uuid_);
	}

</script>
