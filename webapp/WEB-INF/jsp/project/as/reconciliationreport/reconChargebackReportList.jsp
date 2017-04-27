<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="划扣（代收）对账报表" base="http" lib="ext">
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
			<aos:combobox fieldLabel="交易渠道" id="routed_third_channel_id_" name="routed_third_channel_id_" editable="false"
				columnWidth="0.33" url="comboboxService.thirdChannelCombobox"/>
			<aos:textfield fieldLabel="借款合同编号" name="contract_code_" emptyText="填写借款合同编号"
				columnWidth="0.33" />
			<aos:combobox fieldLabel="归属业务线" id="platform_id_" name="platform_id_" editable="false"
				columnWidth="0.33" url="comboboxService.platformCombobox" />
			<aos:textfield fieldLabel="渠道订单号" name="third_channel_order_id_" emptyText="填写渠道订单号" columnWidth="0.33" />
			<aos:textfield fieldLabel="借款人姓名" name="customer_name_" emptyText="填写借款人姓名" columnWidth="0.33" />
			<aos:textfield fieldLabel="展业途径" name="channel_" emptyText="填写展业途径" columnWidth="0.33" />
			<aos:datefield fieldLabel="订单完成时段" id="start_response_time_" name="start_response_time_" emptyText="开始日期"
				columnWidth="0.186" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" id="end_response_time_" name="end_response_time_" emptyText="结束日期"
				columnWidth="0.126" />
			<aos:textfield fieldLabel="借款人身份证" name="customer_idcard_" emptyText="填写借款人身份证" columnWidth="0.33" />
			<aos:textfield fieldLabel="产品名称" name="product_name_" emptyText="填写产品名称" columnWidth="0.33" />
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem text="导出Excel" id="btn_export" icon="icon70.png" onclick="fn_exportexcel" /> 
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_api_request" url="reconChargebackReportService.reconChargebackReportPage" 
		onrender="_g_loan_query" pageSize="30" forceFit="false" autoScroll="true" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="划扣（代收）对账列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="划扣指令ID" dataIndex="order_id_" celltip="true" width="100" align="center"/>
			<aos:column header="划扣受理ID" dataIndex="accepted_id_" celltip="true" width="100" align="center"/>
			<aos:column header="归属业务线" dataIndex="platform_name_" width="100" align="center"/>
			<aos:column header="业务线借款合同编号" dataIndex="contract_code_" width="200" align="center"/>
			<aos:column header="展业途径" dataIndex="channel_" width="100" align="center"/>
			<aos:column header="借款人姓名" dataIndex="customer_name_" width="100" align="center"/>
			<aos:column header="借款人身份证" dataIndex="customer_idcard_" width="200" align="center"/>
			<aos:column header="借款人手机号" dataIndex="customer_cellphone_" width="100" align="center"/>
			<aos:column header="产品编号" dataIndex="product_code_" width="70" align="center"/>
			<aos:column header="产品名称" dataIndex="product_name_" width="70" align="center"/>
			<aos:column header="借款方式" dataIndex="loan_pattern_" width="70" align="center"/>
			<aos:column header="借款期数" dataIndex="loan_staging_amount_" width="70" align="center"/>
			<aos:column header="借款期数单位" dataIndex="loan_staging_duration_" width="70" align="center"/>
			<aos:column header="年化利率" dataIndex="annualized_rate_" width="70" align="center"/>
			<aos:column header="合同金额" dataIndex="contract_amount_" width="70" align="center"/>
			<aos:column header="交易渠道" dataIndex="routed_third_channel_name_" width="100" align="center"/>
			<aos:column header="渠道订单号" dataIndex="third_channel_order_id_" width="200" align="center"/>
			<aos:column header="划扣要素账号" dataIndex="chargeback_account_" width="200" align="center"/>
			<aos:column header="划扣要素户名" dataIndex="chargeback_name_" width="70" align="center"/>
			<aos:column header="划扣要素身份证" dataIndex="chargeback_idcard_" width="100" align="center"/>
			<aos:column header="划扣要素手机号" dataIndex="chargeback_cellphone_" width="100" align="center"/>
			<aos:column header="交易金额（收款金额）" dataIndex="chargeback_amount_" width="70" align="center"/>
			<aos:column header="我方发给第三方的时间" dataIndex="request_time" width="200" align="center"/>
			<aos:column header="第三方完成指令的时间" dataIndex="response_time_" width="200" align="center"/>
			<aos:column header="银行响应第三方的时间" dataIndex="bank_echo_time_" width="200" align="center"/>
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
		
		//生成XLS报表
		function fn_exportexcel() {
			
			var params = _loan.getValues();
			
			if(params.routed_third_channel_id_ == ""
					|| params.platform_id_ == ""
					|| params.end_response_time_ == ""
					|| params.start_response_time_ == ""){
				AOS.tip("导出至少需要选择交易渠道、归属业务线、订单完成时等3个条件");
				return;
			}
			
			if(((Date.parse(params.end_response_time_.replace(/-/g, "/")) 
					- Date.parse(params.start_response_time_.replace(/-/g, "/"))) / (24*3600*1000) < 0)
					||
				((Date.parse(params.end_response_time_.replace(/-/g, "/")) 
						- Date.parse(params.start_response_time_.replace(/-/g, "/"))) / (24*3600*1000) > 31)){
				AOS.tip("订单完成时的开始时间需小于结束时间，且订单完成时等须在31天内");
				return;
			}
			
			AOS.ajax({
				params: params,
				url:'reconChargebackReportService.isEqualCondition',
				ok:function(data){
					if(data.appmsg == 'true'){
						AOS.file('do.jhtml?router=reconChargebackReportService.exportExcel&juid=${juid}');
					}else{
						AOS.tip("您目前导出选择的条件和查询的条件不一致!");						
					}
				}
			});
			
		}
	</script>
</aos:onready>
