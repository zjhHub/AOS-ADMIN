<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="业务流水动账明细" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:hiddenfield name="flow_biz_id_" id="flow_biz_id_"
			value="${businessId}" />
		<aos:formpanel id="_f_counts" layout="column" autoScroll="true"
			region="north" height="180" onrender="_f_query_count">
			<aos:textfield name="jscount" fieldLabel="冲消账簿动账条数" readOnly="true"
				columnWidth="0.33" />
			<aos:textfield name="cscount" fieldLabel="截留账簿动账条数" readOnly="true"
				columnWidth="0.33" />
		</aos:formpanel>
		<aos:tabpanel id="id_tabpanel" region="center" activeTab="0"
			bodyBorder="0 0 0 0" tabBarHeight="30">
			<aos:tab title="冲消账簿" id="_tab_org" layout="border">
				<aos:gridpanel id="_g_org" url="flowService.subjectflowDetailPage"
					onrender="_g_org_query" region="center">
					<aos:column type="rowno" />
					<aos:column header="借款分期" dataIndex="no_" width="50" />
					<aos:column header="冲消科目" dataIndex="name_" width="50" />
					<aos:column header="科目部分" dataIndex="target_" celltip="true" rendererField="target_value_" width="50" />
					<aos:column header="变动前" dataIndex="before_amount_" width="50" />
					<aos:column header="变动金额" dataIndex="changing_amount_" width="50" />
					<aos:column header="变动后" dataIndex="after_amount_" width="50" />
					<aos:column header="变动时间" dataIndex="changing_date_" width="70" />
				</aos:gridpanel>
			</aos:tab>

			<aos:tab title="截留账簿" id="_tab_param" onactivate="_g_param_query"
				layout="border">
				<aos:gridpanel id="_g_param" url="flowService.cutflowDetailPage"
					pageSize="20" region="center">
					<aos:column type="rowno" />
					<aos:column header="截留科目" dataIndex="name_" width="70" />
					<aos:column header="变动前" dataIndex="before_amount_" width="50" />
					<aos:column header="变动金额" dataIndex="changing_amount_" width="60" />
					<aos:column header="变动后" dataIndex="after_amount_" width="50" />
					<aos:column header="变动时间" dataIndex="changing_date_" width="80" />
				</aos:gridpanel>
			</aos:tab>
		</aos:tabpanel>
	</aos:viewport>

	<script type="text/javascript">
		//统计条数 
		function _f_query_count() {
			var businessId = flow_biz_id_.getValue();
			AOS.ajax({
				params : {
					b_id_ : businessId
				},
				url : 'flowService.queryCount',
				ok : function(data) {
					_f_counts.form.setValues(data);
				}
			});
		}

		//1 加载冲销账簿 
		function _g_org_query() {
			if (!_tab_org.isVisible()) {
				_tabpanel.setActiveTab(_tab_org);
			}
			var businessId = flow_biz_id_.getValue();
			//alert(businessId);
			var params = {
				b_id_ : businessId
			};
			_g_org_store.getProxy().extraParams = params;
			_g_org_store.loadPage(1);
		}

		//2 加载截留 
		function _g_param_query() {
			if (!_tab_param.isVisible()) {
				_tabpanel.setActiveTab(_tab_param);
			}
			var businessId = flow_biz_id_.getValue();
			var params = {
				b_id_ : businessId
			};
			_g_param_store.getProxy().extraParams = params;
			_g_param_store.loadPage(1);
		}
	</script>

</aos:onready>



