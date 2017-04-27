<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="业务线" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border">

		<aos:formpanel id="_q_base" layout="column" columnWidth="1" region="north" border="false">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:textfield fieldLabel="业务线ID" name="id_" emptyText="填写业务线ID" columnWidth="0.33" />
			<aos:textfield fieldLabel="业务线名称" name="name_" emptyText="填写业务线名称" columnWidth="0.33" />
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" onclick="_g_query" icon="query.png" />
				<aos:dockeditem text="重置" onclick="_g_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_base" url="platformService.initPage" onrender="_g_query" pageSize="30" autoScroll="true" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="业务线列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="业务线ID" dataIndex="id_" celltip="true" width="20" />
			<aos:column header="业务线名称" dataIndex="name_" celltip="true" width="20" />
		</aos:gridpanel>
	</aos:viewport>

	<script type="text/javascript">
		//加载表格数据
		function _g_query() {
			var params = _q_base.getValues();
			_g_base_store.getProxy().extraParams = params;
			_g_base_store.loadPage(1);
		}
		
		//重置 
		function _g_reset() {
			AOS.reset(_q_base);
		}
	</script>
</aos:onready>

