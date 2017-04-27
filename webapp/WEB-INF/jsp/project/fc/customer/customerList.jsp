<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="在册客户清单" base="http" lib="ext">
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
			<aos:textfield fieldLabel="客户名称" name="customerName"
				emptyText="填写客户名称" columnWidth="0.33" />
			<aos:textfield fieldLabel="客户身份证" name="idcard_" emptyText="填写客户身份证"
				columnWidth="0.33" />
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_loan" url="customerService.customerPage"
			onrender="_g_loan_query" pageSize="30" autoScroll="true"
			region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="客户列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="客户ID" dataIndex="customerId" celltip="true"
				width="80" />
			<aos:column header="客户姓名" dataIndex="customerName" celltip="true"
				width="80" />
			<aos:column header="客户身份证" dataIndex="idcard_" width="90" />
			<aos:column header="客户手机号" dataIndex="cellphone_" celltip="true"
				width="120" />
			<%-- <aos:column header="客户来源(开户业务线)" dataIndex="name_" width="80" /> --%>
			<aos:column header="数据创建时间" dataIndex="created_time_" width="80" />
			<aos:column header="数据创建者" dataIndex="ip_address_" width="80" />
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

