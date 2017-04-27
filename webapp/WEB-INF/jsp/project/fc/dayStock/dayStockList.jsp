<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="借款端财务表表，每日存量表" base="http" lib="ext">
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
			<aos:textfield fieldLabel="借款合同ID" name="contract_id_"
				emptyText="填写借款合同ID" columnWidth="0.25" />
			<aos:combobox fieldLabel="归属业务线" name="platform_id_" editable="false"
				columnWidth="0.25" url="comboboxService.platformCombobox" />
			<aos:datefield fieldLabel="存量日期" name="snapshot_date_"
				emptyText="填写存量日期" columnWidth="0.25" />
			<aos:textfield fieldLabel="借款合同编号" name="contract_code_"
				emptyText="填写借款合同编号" columnWidth="0.25" />
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>

		<aos:gridpanel id="_g_loan" url="dayStockService.dayStockPage"
			onrender="_g_loan_query" pageSize="30" autoScroll="true" border="true"  forceFit="false"
			region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="每日存量列表" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="导出Excel报表" icon="icon70.png" onclick="fn_xls" />
			</aos:docked>

			<aos:column type="rowno" />
			<aos:column dataIndex="id_" hidden="true"/>
			<aos:column header="存量日期" dataIndex="snapshot_date_" align="center"
				width="140" type="date" format="Y-m-d" />
			<aos:column header="归属业务线" dataIndex="platform_id_" align="center"
				width="140" />
			<aos:column header="清结算借款合同ID" dataIndex="contract_id_"
				align="center" width="140" />
			<aos:column header="业务线内借款合同编号" dataIndex="contract_code_"
				align="center" width="140" />
			<aos:column header="展业途径" dataIndex="channel_" align="center"
				width="140" />
			<aos:column header="业务线内借款人ID" dataIndex="customer_id_"
				align="center" width="140" />
			<aos:column header="借款人姓名" dataIndex="name_" align="center"
				width="140" />
			<aos:column header="借款人身份证" dataIndex="idcard_" align="center"
				width="140" />
			<aos:column header="借款人手机号" dataIndex="cellphone_" align="center"
				width="140" />
			<aos:column header="业务线内产品ID" dataIndex="product_code_"
				align="center" width="140" />
			<aos:column header="产品名称" dataIndex="product_name_" align="center"
				width="140" />
			<aos:column header="借款方式" dataIndex="loan_pattern_" align="center"
				width="140" />
			<aos:column header="借款期数" dataIndex="loan_staging_amount_"
				align="center" width="140" />
			<aos:column header="借款期数单位" dataIndex="loan_staging_duration_"
				align="center" width="140" />
			<aos:column header="年化利率" dataIndex="annualized_rate_" align="center"
				width="140" rendererFn="annualizedRate" />
			<aos:column header="约定放款日" dataIndex="contract_pay_date_"
				align="center" width="140" type="date" format="Y-m-d" />
			<aos:column header="合同金额" dataIndex="contract_amount_" align="center"
				width="140" type="number" format="0,000.00" />
			<aos:column header="预计可收利息" dataIndex="expected_interest_"
				align="center" width="140" type="number" format="0,000.00" />
			<aos:column header="预计可收服务费" dataIndex="expected_fee_" align="center"
				width="140" type="number" format="0,000.00" />
			<aos:column header="借款合同状态" dataIndex="contract_status_"
				rendererField="contract_status_" align="center" width="140" />
			<aos:column header="已还期数" dataIndex="settle_count_" align="center"
				width="140" rendererFn="settleCount" />
			<aos:column header="当前逾期天数" dataIndex="overdue_day_" align="center"
				width="140" rendererFn="overdueDay" />
			<aos:column header="历史逾期次数" dataIndex="overdue_count_" align="center"
				width="140" rendererFn="overdueCount" />
			<aos:column header="资金明细" rendererFn="fn_button_amount_render" align="center" width="100" />
 		</aos:gridpanel>
 		
 		<%-- 资金明细窗口--%>
		<aos:window id="_w_staging" layout="fit" onshow="_w_staging_onshow" width="1230" height="100">
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
		function settleCount(value) {
			return "共" + value + "期";
		}
		function annualizedRate(value) {
			return value + "%";
		}
		function overdueDay(value) {
			return value + "天";
		}
		function overdueCount(value) {
			return value + "次";
		}
		//生成XLS报表
		function fn_xls() {
			var params = _loan.getValues();
			var json = JSON.stringify(params);
			AOS.file('do.jhtml?router=dayStockService.exprotExcel&juid=${juid}&json=' + json);
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
		function fn_button_amount_render(value, metaData, record, rowIndex, colIndex, store) {
			return '<input type="button" value="资金明细" class="cbtn" onclick="_w_staging_show();" />';
		}
		
		//资金明细窗口
		function _w_staging_onshow() {
			var record = AOS.selectone(_g_loan);
			_w_staging.setTitle('借款合同 ' + record.data.contract_code_ + '的资金明细信息');
			//获取动态表格元素
			AOS.ajax({
				url : 'dayStockService.dayStockDynamicFiled',
				params : {
					id_ : record.data.id_
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
	//资金明细窗口
	function _w_staging_show() {
		Ext.getCmp('_w_staging').show();
	}
</script>