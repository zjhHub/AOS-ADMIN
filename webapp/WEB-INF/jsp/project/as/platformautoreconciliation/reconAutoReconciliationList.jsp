<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="每日对账，清结算与业务线" base="http" lib="ext">
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
			<aos:combobox fieldLabel="归属业务线" name="platform_id_" editable="false"
				columnWidth="0.33" url="comboboxService.platformCombobox" />
			<aos:datefield fieldLabel="对账日期" id="start_reconciliation_date_" name="start_reconciliation_date_" emptyText="开始日期"
				columnWidth="0.186" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" id="end_reconciliation_date_" name="end_reconciliation_date_" emptyText="结束日期"
				columnWidth="0.126" />
			<aos:combobox  fieldLabel="对账类型" name="type_" value="0" columnWidth="0.33">
				<aos:option value="" display="请选择" />
				<aos:option value="2" display="放款（代付）" />
				<aos:option value="1" display="划扣（代收）" />
			</aos:combobox>
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_request" url="platformAutoReconciliationService.reconAutoReconciliationPage" 
		onrender="_g_loan_query" pageSize="30" forceFit="false" autoScroll="true" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="放款（代付）日对账单列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column dataIndex="file_path_" hidden="true"/>
			<aos:column dataIndex="reconciliation_date_" hidden="true"/>
			<aos:column header="放款对账单ID" dataIndex="id_" celltip="true" width="100" align="center"/>
			<aos:column header="归属业务线" dataIndex="name_" width="100" align="center"/>
			<aos:column header="对账类型" rendererField="reconciliation_type_" dataIndex="type_" width="100" align="center"/>
			<aos:column header="对账日期" rendererFn="fn_date_format" width="200" align="center"/>
			<aos:column header="成功总笔数" dataIndex="success_count"  width="100" align="center"/>
			<aos:column header="成功总金额" dataIndex="success_all_amount_" width="200" align="center"/>
			
			<aos:column header="操作" align="center" width="200" rendererFn="fn_bt_addInput" />
		</aos:gridpanel>
	</aos:viewport>

	<script type="text/javascript">
		
		//加载表格数据
		function _g_loan_query() {
			var params = _loan.getValues();
			if((Date.parse(params.end_reconciliation_date_.replace(/-/g, "/")) 
					- Date.parse(params.start_reconciliation_date_.replace(/-/g, "/"))) / (24*3600*1000) < 0){
				AOS.tip("对账日期的开始时间需小于结束时间");
				return;
			}
			
			_g_request_store.getProxy().extraParams = params;
			_g_request_store.loadPage(1);
		}
		//重置 
		function _loan_reset() {
			AOS.reset(_loan);
		}
		
		function fn_date_format(value, metaData, record, rowIndex, colIndex,
				store){
			return record.data.reconciliation_date_.split(" ")[0];
		}
		
		function fn_bt_addInput(value, metaData, record, rowIndex, colIndex,
				store) {
			if (record.data.id_ == '${id_}') {
				return '--';
			} else {
 				return '<input type="button" value="对账单下载" class="cbtn" onclick="fn_bt_downFile();" />'; 
			}
		}
		
	</script>
</aos:onready>

<script type="text/javascript">

	function fn_bt_downFile(){
		
		var record = AOS.selectone(Ext.getCmp('_g_request'));
		var file_url = record.data.file_path_;
		if(file_url == null || file_url == "" ){
			 AOS.tip('没有对账文件可以下载');
	        return;
		}
		var fastdfs_url="${fastdfs_url}"
		window.open(fastdfs_url+file_url);
	}

</script>
