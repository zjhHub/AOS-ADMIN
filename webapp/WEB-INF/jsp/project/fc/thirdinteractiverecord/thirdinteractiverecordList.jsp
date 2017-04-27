<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="借款端，第三方交互记录" base="http" lib="ext">
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
			<aos:combobox fieldLabel="交互对象" name="third_channel_id_" editable="false" columnWidth="0.4"
				url="comboboxService.thirdChannelCombobox" />
			<aos:datefield fieldLabel="请求时间" name="start_sent_time_"
				emptyText="开始日期" columnWidth="0.25" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_sent_time_!="
				emptyText="结束日期" columnWidth="0.15" />
			<aos:textfield fieldLabel="订单编号" name="order_id_" emptyText="填写订单编号"
				columnWidth="0.4" />
			<aos:datefield fieldLabel="响应时间" name="start_response_time_"
				emptyText="开始日期" columnWidth="0.25" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_response_time_"
				emptyText="结束日期" columnWidth="0.15" />	
			 <aos:combobox fieldLabel="交互第三方接口" name="interface_code_" editable="false"
				columnWidth="0.4" dicField="interface_code_" /> 
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_loan" url="thirdInteractiveRecordService.chargebackRequestPage"
			onrender="_g_loan_query" pageSize="30" autoScroll="true"
			region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="划扣请求列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="交互ID" dataIndex="id_" celltip="true" width="50" />
			<aos:column header="交互对象（第三方支付）" dataIndex="name_" celltip="true" width="70" />
			<aos:column header="订单编号" dataIndex="order_id_" width="90" />
			<aos:column header="交互第三方接口" dataIndex="interface_code_" celltip="true" rendererField="interface_code_" width="60" />
			<aos:column header="交互第三方URL" dataIndex="interface_url_" width="80" />
			<aos:column header="我方请求时间" dataIndex="sent_time_" width="80" align="center"/>
			<aos:column header="第三方响应时间" dataIndex="response_time_" width="80" align="center"/>
			<aos:column header="请求内容" align="center" fixedWidth="80" rendererFn="fn_bt_loanDedail" />
			<aos:column header="响应内容" align="center" fixedWidth="80" rendererFn="fn_bt_loanDedail2" />
		</aos:gridpanel>

		<aos:window id="_w_req" title="划扣请求的请求内容" onshow="_w_req_onshow"
			width="640" height="420">
			<aos:formpanel id="req_info" layout="column"
				labelWidth="800" width="750">
				<aos:fieldset title="请求内容" labelWidth="70" columnWidth="1"
					border="true">
					<aos:textareafield name="sent_content_" height="300" columnWidth="0.99" />
				</aos:fieldset>

			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="_window_hide" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>

		<aos:window id="_w_resp" title="划扣请求的响应内容" onshow="_w_rsp_onshow"
			width="640" height="300">
			<aos:formpanel id="rsp_info" layout="column"
				labelWidth="800" width="750">
				<aos:fieldset title="响应内容" labelWidth="70" columnWidth="1"
					border="true">
					<aos:textareafield name="response_content_" height="300"
						columnWidth="0.99" />
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="_window_hide2" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>

	</aos:viewport>

	<script type="text/javascript">
		//窗口弹出事件监听
		function _w_req_onshow() {
			var record = AOS.selectone(_g_loan, true);
			AOS.ajax({
				params : {
					id_ : record.data.id_
				},
				url : 'thirdInteractiveRecordService.thirdinteractiverecordDetail',
				ok : function(data) {
					AOS.reset(req_info);
					req_info.form.setValues(data);
				}
			});
		}

		function _w_rsp_onshow() {
			var record = AOS.selectone(_g_loan, true);
			AOS.ajax({
				params : {
					id_ : record.data.id_
				},
				url : 'thirdInteractiveRecordService.thirdinteractiverecordDetail',
				ok : function(data) {
					AOS.reset(rsp_info);
					rsp_info.form.setValues(data);
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
		//关闭 
		function _window_hide() {
			_w_req.hide();
		}

		function _window_hide2() {
			_w_resp.hide();
		}

		//调阅 
		function fn_bt_loanDedail(value, metaData, record, rowIndex, colIndex,
				store) {
			if (record.data.id_ == '${id_}') {
				return '--';
			} else {
				return '<input type="button" value="调阅" class="cbtn" onclick="_btn_request_onclick();" />';
			}
		}

		//调阅 
		function fn_bt_loanDedail2(value, metaData, record, rowIndex, colIndex,store) {
			if (record.data.id_ == '${id_}') {
				return '--';
			} else {
				return '<input type="button" value="调阅" class="cbtn" onclick="_btn_response_onclick();" />';
			}
		}
	</script>
</aos:onready>

<script type="text/javascript">
	function _btn_request_onclick() {
		Ext.getCmp('_w_req').show();
	}

	function _btn_response_onclick() {
		Ext.getCmp('_w_resp').show();
	}
</script>
