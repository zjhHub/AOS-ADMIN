<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="借款端，收款资金流水报表" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border" id="_g_stock">

		<aos:formpanel layout="column" columnWidth="1" region="north"
			border="false" id="_loan">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="筛选条件" />
			</aos:docked>
			<aos:combobox fieldLabel="交易渠道" name="third_channel_" editable="false" columnWidth="0.33" url="comboboxService.thirdChannelCombobox" />
			<aos:textfield fieldLabel="借款合同编号" name="contract_code_" emptyText="填写借款合同编号" columnWidth="0.33" />
			<aos:combobox fieldLabel="归属业务线" name="platform_id_" editable="false" columnWidth="0.33" url="comboboxService.platformCombobox" />
			
			<aos:textfield fieldLabel="渠道订单号" name="order_id_" emptyText="填写渠道订单号" columnWidth="0.33" />
			<aos:textfield fieldLabel="借款人姓名" name="name_" emptyText="填写借款人姓名" columnWidth="0.33" />
			<aos:textfield fieldLabel="展业途径" name="channel_" emptyText="填写展业途径" columnWidth="0.33" />
			
			
			<aos:datefield fieldLabel="资金到账日期" name="arrived_start_time_" emptyText="开始日期" columnWidth="0.188" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="arrived_end_time_" emptyText="结束日期" columnWidth="0.118" />
			<aos:textfield fieldLabel="借款人身份证" name="idcard_" emptyText="填写借款人身份证" columnWidth="0.33" />
			<aos:textfield fieldLabel="产品名称" name="product_name_" emptyText="填写产品名称" columnWidth="0.33" />
			
			<aos:datefield fieldLabel="流水登账日期" name="record_start_time_" emptyText="开始日期" columnWidth="0.188" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="record_end_time_" emptyText="结束日期" columnWidth="0.118" />
			
			<aos:combobox  fieldLabel="是否补录" name="isAdding" value="0" columnWidth="0.33">
				<aos:option value="0" display="全部" />
				<aos:option value="1" display="是" />
				<aos:option value="2" display="否" />
			</aos:combobox>
			<aos:combobox fieldLabel="借款合同状态" name="status_" editable="false" columnWidth="0.33" dicField="contract_status_"/>
			
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>

		<aos:gridpanel id="_g_loan" url="recoverBusinessService.recoverList"
			onrender="_g_loan_query" pageSize="30" autoScroll="true" border="true"  forceFit="false"
			region="center">
			
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="收款资金流水列表" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="导出Excel报表" icon="icon70.png" onclick="fn_xls" />
			</aos:docked>

			<aos:column type="rowno" />
			<aos:column dataIndex="flow_biz_id_" hidden="true"/>
			<aos:column header="收款资金流水ID" dataIndex="id_" align="center" width="140"/>
			<aos:column header="归属业务线" dataIndex="platform_id_" align="center" width="140"/>
			<aos:column header="清结算借款合同编号" dataIndex="contract_code_" align="center" width="140"/>
			<aos:column header="展业途径" dataIndex="channel_" align="center" width="140"/>
			<aos:column header="业务线内借款人编码" dataIndex="customer_id_" align="center" width="140"/>
			<aos:column header="借款人姓名" dataIndex="name_" align="center" width="140"/>
			<aos:column header="借款人身份证" dataIndex="idcard_" align="center" width="140"/>
			<aos:column header="借款人手机号" dataIndex="cellphone_" align="center" width="140"/>
			<aos:column header="业务线内产品ID" dataIndex="product_code_" align="center" width="140"/>
			<aos:column header="产品名称" dataIndex="product_name_" align="center" width="140"/>
			<aos:column header="借款方式" dataIndex="loan_pattern_" align="center" width="140"/>
			<aos:column header="借款期数" dataIndex="loan_staging_amount_" align="center" width="140"/>
			<aos:column header="借款期数单位" dataIndex="loan_staging_duration_" align="center" width="140"/>
			<aos:column header="年化利率" dataIndex="annualized_rate_" align="center" width="140" rendererFn="annualizedRate" />
			<aos:column header="约定放款日" dataIndex="contract_pay_date_" align="center" width="140" type="date" format="Y-m-d" />
			<aos:column header="合同金额" dataIndex="contract_amount_" align="center" width="140" type="number" format="0,000.00" />
			<aos:column header="预计可收利息" dataIndex="expected_interest_" align="center" width="140" type="number" format="0,000.00" />
			<aos:column header="预计可收服务费" dataIndex="expected_fee_" align="center" width="140" type="number" format="0,000.00" />
			<aos:column header="借款合同状态" dataIndex="status_" align="center" width="140" rendererField="contract_status_"/>
			<aos:column header="交易渠道" dataIndex="third_channel_" align="center" width="140"/>
			<aos:column header="渠道订单号" dataIndex="order_id_" align="center" width="140"/>
			<aos:column header="借款人付款账号" dataIndex="target_account_" align="center" width="140"/>
			<aos:column header="交易金额(收款金额)" dataIndex="trans_amount_" align="center" width="140" type="number" format="0,000.00" />
			<aos:column header="渠道手续费" dataIndex="third_channel_fee_" align="center" width="140" type="number" format="0,000.00" />
			<aos:column header="资金到账时间" dataIndex="arrived_time_" align="center" width="140"/>
			<aos:column header="流水登账时间" dataIndex="record_time_" align="center" width="140"/>
			<aos:column header="订单发出时间(实际放款日)" dataIndex="request_time_" align="center" width="140"/>
			<aos:column header="订单被响应时间" dataIndex="reponse_time_" align="center" width="140"/>
			<aos:column header="冲消明细" rendererFn="fn_button_subject_render" align="center" width="100" />
		</aos:gridpanel>
		<%-- 冲消科目窗口--%>
		<aos:window id="_w_staging" layout="fit" onshow="_w_staging_onshow" width="300" height="120">
		</aos:window>
	</aos:viewport>


	<script type="text/javascript">
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
		function annualizedRate(value) {
			return value + "%";
		}
		//生成XLS报表
		function fn_xls() {
			AOS.file('do.jhtml?router=recoverBusinessService.exprotExcel&juid=${juid}');
		}
		function createAdvGrid(data) {
			return Ext.create('Ext.grid.Panel', {
				forceFit : false,
				stripeRows : true,
				store : Ext.create('Ext.data.Store', {
					fields : data.fields,
					data : data.data
				}),
				columns : data.columns
			});
		}
		//资金明细按钮
		function fn_button_subject_render(value, metaData, record, rowIndex, colIndex, store) {
			return '<input type="button" value="冲消科目" class="cbtn" onclick="_w_staging_show();" />';
		}
		
		//资金明细窗口
		function _w_staging_onshow() {
			var record = AOS.selectone(_g_loan);
			_w_staging.setTitle('借款合同 ' + record.data.contract_code_ + '的冲消科目明细信息');
			//获取动态表格元素
			AOS.ajax({
				url : 'recoverBusinessService.subjectDynamicFiled',
				params : {
					flow_biz_id_ : record.data.flow_biz_id_
				},
				ok : function(data) {
					_w_staging.items.removeAll();
					_w_staging.items.add(createAdvGrid(data));
					_w_staging.doLayout();
				}
			});
			//控制窗口大小改变刷新布局
			_w_staging.on('resize', function(w) {
				w.doLayout();
			});
		}
	</script>
</aos:onready>
<script type="text/javascript">
	//冲消资金窗口
	function _w_staging_show() {
		Ext.getCmp('_w_staging').show();
	}
</script>