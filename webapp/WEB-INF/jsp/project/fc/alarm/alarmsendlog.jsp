<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="警报发送日志" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:formpanel layout="column" columnWidth="1" region="north" border="false" id="_sendlog">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:textfield fieldLabel="警报ID" name="alarm_id_"  columnWidth="0.33" />
<%-- 			<aos:textfield fieldLabel="警报类型" name="alarm_type_"  columnWidth="0.33" /> --%>
			<aos:combobox  fieldLabel="警报类型" name="alarm_type_" editable="false" columnWidth="0.33" url="alarmService.alarmTypeName" />
			<aos:textfield fieldLabel="发送姓名" name="send_name_"  columnWidth="0.33" />
			<aos:combobox fieldLabel="发送状态" name="send_status_" editable="false" columnWidth="0.33" dicField="send_status_" />
			<aos:datefield fieldLabel="发送时间" name="start_time_" emptyText="开始日期" columnWidth="0.186" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_time_" emptyText="结束日期" columnWidth="0.126" />	

			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_sendlog_query" />
				<aos:dockeditem text="重置" onclick="_sendlog_reset" icon="refresh.png" />
<%-- 				<aos:dockeditem text="导出Excel" onclick="fn_exportexcel()" icon="icon70.png"/> --%>
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_sendlog" url="alarmService.sendLogListPage" onrender="_g_sendlog_query" pageSize="30" autoScroll="true" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="警报发送日志列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="自增主键" dataIndex="id_" hidden="true" width="30" align="center"/>
			<aos:column header="警报ID" dataIndex="alarm_id_" celltip="true" width="30" align="center"/>
			<aos:column header="警报类型" dataIndex="name_" width="30" celltip="true" align="center"/>
			<aos:column header="发送地址" dataIndex="send_address" width="40" align="center"/>
			<aos:column header="发送姓名" dataIndex="send_name_" width="30" align="center"/>
			<aos:column header="发送时间" dataIndex="send_time_" width="40" align="center" />
			<aos:column header="发送状态" dataIndex="send_status_" width="30" align="center"  rendererField="send_status_"/>
			<aos:column header="发送信息" dataIndex="send_message" width="80" align="center" celltip="true"/>
			<aos:column header="发送描述" dataIndex="send_content" width="80" align="center" celltip="true"/>
		</aos:gridpanel>

	</aos:viewport>

	<script type="text/javascript">
		
		//加载表格数据
		function _g_sendlog_query() {
			var params = _sendlog.getValues();
			_g_sendlog_store.getProxy().extraParams = params;
			_g_sendlog_store.loadPage(1);
		}
		//重置 
		function _sendlog_reset() {
			AOS.reset(_sendlog);
		}	
		
	</script>
</aos:onready>

<script type="text/javascript">

</script>
