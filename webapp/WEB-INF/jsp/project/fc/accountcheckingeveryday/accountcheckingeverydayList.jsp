<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="借款端，每日划扣对账" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:formpanel id="_f_counts" layout="column" autoScroll="true" region="north" onrender="_f_query">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="对账摘要" />
			</aos:docked>
			<aos:textfield name="kk_oursumtrans_amount"  fieldLabel="我方昨日扣款金额" readOnly="true" columnWidth="0.24" />
			<aos:textfield name="kk_thirdsumtrans_amount"  fieldLabel="三方昨日扣款金额" readOnly="true" columnWidth="0.24" />
			<aos:textfield name="fk_oursumtrans_amount"  fieldLabel="我方昨日放款金额" readOnly="true" columnWidth="0.24" />
			<aos:textfield name="fk_thirdsumtrans_amount"  fieldLabel="三方昨日放款金额" readOnly="true" columnWidth="0.24" />
		</aos:formpanel>
		<aos:formpanel layout="column" columnWidth="1" region="north" border="false" id="_loan">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:datefield fieldLabel="对账日期" name="start_created_time_" emptyText="开始日期" columnWidth="0.15" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_created_time_" emptyText="结束日期" columnWidth="0.09" />
			<aos:combobox fieldLabel="对账状态" name="status_" editable="false" columnWidth="0.24" dicField="reconciliation_status_"  />
			<%-- <aos:combobox fieldLabel="第三方支付渠道" name="third_channel_id_" editable="false" columnWidth="0.34" url="comboboxService.thirdChannelCombobox" /> --%>
			<aos:combobox fieldLabel="第三方支付渠道" name="third_channel_id_" editable="false" columnWidth="0.24" dicDataType="number"  dicField="third_channel_id_"/>
<%-- 			<aos:combobox fieldLabel="存在特定情况" name="result_" editable="false" columnWidth="0.297" dicField="reconciliation_details_result_" /> --%>
			<aos:combobox fieldLabel="对账类别" name="type_" editable="false" columnWidth="0.24" dicField="reconciliation_type_" />
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_loan" url="accountCheckingEverydayService.accountcheckingeverydayPage"
			onrender="_g_loan_query" pageSize="30" autoScroll="true" region="center" forceFit="false" >
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="每日划扣对账列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="对账id" dataIndex="id_" width="50" hidden="true"/>
			<aos:column header="对账文件路径" dataIndex="file_path_" width="120" hidden="true"/>
			<aos:column header="对账日期" dataIndex="reconciliation_date_" celltip="true" width="120" align="center"/>
			<aos:column header="第三方支付渠道" dataIndex="third_channel_id_" celltip="true" rendererField="third_channel_id_" width="120" align="center"/>
			<aos:column header="对账类别" dataIndex="type_" width="120"  rendererField="reconciliation_type_" celltip="true" align="center"/>
			<aos:column header="对账状态" dataIndex="status_" width="120"  rendererField="reconciliation_status_" celltip="true" align="center"/>
			<aos:column header="当日订单笔数" dataIndex="today_order_counts_" width="120" align="center" celltip="true"/>
			<aos:column header="我方交易总金额" dataIndex="our_sumtrans_amount" width="120" align="center" celltip="true"/>
			<aos:column header="三方交易总金额" dataIndex="they_sumtrans_amount" width="120" align="center" celltip="true"/>
			<aos:column header="对账成功笔数" dataIndex="succeed_counts_" width="120" align="center" celltip="true"/>
			<aos:column header="金额不平笔数" dataIndex="unbalance_counts_" width="120" align="center" celltip="true"/>
			<aos:column header="我方单边笔数" dataIndex="only_our_side_counts_" width="120" align="center" celltip="true"/>
			<aos:column header="第三方单边笔数" dataIndex="only_third_side_counts_" width="120" align="center" celltip="true"/>
			<aos:column header="对先前补录笔数" dataIndex="patch_before_counts_" width="120" align="center"/>
			
			<aos:column header="操作" align="center" width="200" rendererFn="fn_bt_chargebackacceptDedail" />
		</aos:gridpanel>

	</aos:viewport>

	<script type="text/javascript">
		
		//对账摘要
		function _f_query() {
			AOS.ajax({
				url : 'accountCheckingEverydayService.accountCheckSumAmount',
				ok : function(data) {
					_f_counts.form.setValues(data);
				}
			});
		}					
	
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
		function fn_bt_chargebackacceptDedail(value, metaData, record, rowIndex, colIndex,
				store) {
			if (record.data.id_ == '${id_}') {
				return '--';
			} else {
				/* return '<input type="button" value="对账明细" class="cbtn" onclick="_btn_chargebackaccept_onclick();" />'; */
 				return '<input type="button" value="对账明细" class="cbtn" onclick="_btn_chargebackaccept_onclick();" />   <input type="button" value="对账报文下载" class="cbtn" onclick="_btn_flatset_onclick_download();" />'; 
			}
		}
		
	</script>
</aos:onready>

<script type="text/javascript">
	function _btn_chargebackaccept_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_loan'));
		var acceptID = record.data.id_;
		var type_ = record.data.type_;
		parent.fnaddtab('accountCheckingEverydayService.accountcheckingeverydayDetails&acceptID=' + acceptID+'&type_=' + type_  , '对账明细：'+acceptID, acceptID);
	}
	function _btn_flatset_onclick_download() {
		var record = AOS.selectone(Ext.getCmp('_g_loan'));
		var file_url = record.data.file_path_;
		if(file_url == null || file_url == "" ){
			 AOS.tip('没有对账文件可以下载');
            return;
		}
		var fastdfs_url="${fastdfs_url}"
		window.open(fastdfs_url+file_url);
	}
	
	

</script>
