<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="划扣指令表" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border" id="_g_stock">

		<aos:formpanel layout="column" columnWidth="1" region="north" border="false" id="_loan">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="筛选条件" />
			</aos:docked>
			<aos:textfield fieldLabel="划扣指令ID" name="chargeback_order_id_" emptyText="填写划扣指令ID" columnWidth="0.33" />
			<aos:textfield fieldLabel="划扣受理ID" name="chargeback_accepted_id_" emptyText="填写划扣受理ID" columnWidth="0.33" />
			<aos:textfield fieldLabel="请求来源" name="request_id_" emptyText="填写划扣请求来源ID" columnWidth="0.33" />
			<aos:combobox  fieldLabel="指令结果状态" name="result_status_" value="0" columnWidth="0.33">
				<aos:option value="" display="全部" />
				<aos:option value="-1" display="处理中" />
				<aos:option value="1" display="成功" />
				<aos:option value="2" display="失败" />
			</aos:combobox>
			<aos:combobox  fieldLabel="所在位置" name="location_" value="0" columnWidth="0.33">
				<aos:option value="" display="全部" />
				<aos:option value="1" display="代发指令库" />
				<aos:option value="2" display="在途指令库" />
				<aos:option value="3" display="已处理指令库" />
				<aos:option value="4" display="已反馈指令库" />
			</aos:combobox>
			<aos:textfield fieldLabel="借款合同编号" name="conctract_no_" emptyText="填写借款合同编号ID" columnWidth="0.33" />
			<aos:combobox fieldLabel="路由去向" name="third_channel_" editable="false" columnWidth="0.33" url="comboboxService.thirdChannelCombobox" />
			<aos:textfield fieldLabel="订单号" name="third_channel_order_id_"  columnWidth="0.33" />
			<aos:textfield fieldLabel="划扣账号姓名" name="chargeback_name_" emptyText="划扣账号户主姓名" columnWidth="0.33" />
			<aos:datefield fieldLabel="指令创建时间" name="create_time_start_" emptyText="开始日期" columnWidth="0.188" editable="false"/>
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="create_time_end_" emptyText="结束日期" columnWidth="0.118" editable="false"/>
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem text="导出Excel" onclick="fn_exportexcel()" icon="icon70.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>

		<aos:gridpanel id="_g_loan" url="chargebackPayService.chargebackOrdersPage"
			onrender="_g_loan_query" pageSize="30" autoScroll="true" border="true"  forceFit="false"
			region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="划扣指令表" />
			</aos:docked>

			<aos:column type="rowno" />
			<aos:column header="划扣指令ID" dataIndex="id_" align="center" width="110"/>
			<aos:column header="指令创建时间" dataIndex="created_time_" align="center" width="150" />
			<aos:column header="路由去向" dataIndex="routed_third_channel_id_" align="center" width="100" />
			<aos:column header="指令位置" dataIndex="location_" align="center" width="110" rendererField="order_location_"/>
			<aos:column header="划扣受理ID" dataIndex="chargeback_accepted_id_" align="center" width="100"/>
			<aos:column header="划扣金额" dataIndex="chargeback_amount_" align="center" width="100" type="number" format="0,000.00" />
			<aos:column header="划扣账号所在银行" dataIndex="chargeback_bank_id_" align="center" width="140"/>
			<aos:column header="划扣账号" dataIndex="chargeback_account_" align="center" width="100"/>
			<aos:column header="划扣账号户主姓名" dataIndex="chargeback_name_" align="center" width="140"/>
			<aos:column header="划扣账号户主身份证" dataIndex="chargeback_idcard_" align="center" width="140"/>
			<aos:column header="第三方支付交互订单号" dataIndex="third_channel_order_id_" align="center" width="190" celltip="true" rendererFn="fn_button_blank_render"/>
			<aos:column header="指令结果状态" dataIndex="status_" align="center" width="120" rendererFn="fn_button_status_render"/>
			<aos:column header="操作" rendererFn="fn_button_operation_render" align="center" width="100" />
 		</aos:gridpanel>
	</aos:viewport>


	<script type="text/javascript">
		//加载表格数据
		function _g_loan_query() {
			var params = _loan.getValues();
			_g_loan_store.getProxy().extraParams = params;
			_g_loan_store.loadPage(1);
		}
		
		//生成XLS报表
		function fn_exportexcel() {
	        AOS.ajax({
 	        	params : {},
 	        	//先判断是否是根据条件进行查询的
				url:'chargebackPayService.judgeInfo',
	            ok: function (data) {
	            	var msg = data.appmsg;         	
	            	if(msg == "ok"){
	            		AOS.file('do.jhtml?router=chargebackPayService.exportExcel&juid=${juid}');		         		
	            	}else{
	            		AOS.tip(msg);
	            	}            	
	            }
	        });
	
		}

		//重置 
		function _loan_reset() {
			AOS.reset(_loan);
		}
		
		function fn_button_blank_render(value){
			if(value) return value;
			return "---";
		}
		
		function fn_button_status_render(value){
			if(value){
				if(value == 1) return "成功";
				if(value == 2) return "失败";
			}
			return "---";
		}
		
		//资金明细按钮
		function fn_button_operation_render(value, metaData, record, rowIndex, colIndex, store) {
			return '<input type="button" value="调阅" class="cbtn" onclick="_btn_order_onclick();" />';
		}
	</script>
</aos:onready>
<script type="text/javascript">
	function _btn_order_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_loan'));
		var order_id_ = record.data.id_;
		parent.fnaddtab('chargebackPayService.orderDetail&chargeback_order_id_=' + order_id_, '划扣指令'+order_id_+'的详情', order_id_);
	}
</script>

