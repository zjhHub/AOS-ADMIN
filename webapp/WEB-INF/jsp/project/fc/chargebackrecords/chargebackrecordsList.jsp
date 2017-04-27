<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="单日划扣次数记录" base="http" lib="ext">
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
			<aos:textfield fieldLabel="针对划扣的账号" name="chargeback_account_" emptyText="填写针对划扣的账号"
				columnWidth="0.5" />
			<aos:textfield fieldLabel="已划扣失败的次数" name="start_chargeback_failed_times_" emptyText="起始数"
				columnWidth="0.25" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10"/>
			<aos:textfield fieldLabel="" name="end_chargeback_failed_times_" emptyText="截止数"
				columnWidth="0.25" />	
			<aos:combobox fieldLabel="第三方支付渠道" name="routed_third_channel_id_" editable="false" columnWidth="0.5"
				url="comboboxService.thirdChannelCombobox" />
			<aos:datefield fieldLabel="针对的日期" name="start_target_date_" emptyText="开始日期"
				columnWidth="0.25" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_target_date_" emptyText="结束日期"
				columnWidth="0.25" />
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_loan" url="chargebackrecordsService.chargebackrecordsPage"
			onrender="_g_loan_query" pageSize="30" autoScroll="true"
			region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="单日划扣次数记录" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="针对日期" dataIndex="target_date_"  width="80" />
			<aos:column header="针对的划扣账号" dataIndex="chargeback_account_" width="90" />
			<aos:column header="针对的第三方支付渠道" dataIndex="channel_name_"  width="90" />
			<aos:column header="已划扣失败的次数" dataIndex="chargeback_failed_times_" width="60" />
			<aos:column header="已划扣成功的次数" dataIndex="chargeback_succeed_times_" width="60" align="center"/>
			<aos:column header="当日已划扣的总金额" dataIndex="today_total_chargebacked_amount_" width="60" />
		</aos:gridpanel>

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
	
		
	</script>
</aos:onready>

