<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="借款端，划扣请求" base="http" lib="ext">
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
			<aos:textfield fieldLabel="划扣请求ID" name="uuid_" emptyText="填写登账请求ID"
				columnWidth="0.33" />
			<aos:combobox fieldLabel="归属业务线" name="platformId" editable="false"
				columnWidth="0.34" url="comboboxService.platformCombobox" />
			<aos:textfield fieldLabel="IP地址" name="ip_address_"
				emptyText="填写IP地址" columnWidth="0.33" />
			<aos:combobox fieldLabel="划扣接口" name="service_code_" editable="false"
				columnWidth="0.33" dicField="service_codes_" />
			<aos:datefield fieldLabel="请求时间" name="start_time_" emptyText="开始日期"
				columnWidth="0.198" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_time_" emptyText="结束日期"
				columnWidth="0.118" />
			<aos:datefield fieldLabel="响应时间" name="start_response_time_"
				emptyText="开始日期" columnWidth="0.189" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_response_time_"
				emptyText="结束日期" columnWidth="0.118" />
			<aos:combobox fieldLabel="响应码" name="response_code"
				columnWidth="0.33" url="comboboxService.FcCodeCombobox" />
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_loan" url="chargebackRequestService.chargebackRequestPage"
			onrender="_g_loan_query" pageSize="30" autoScroll="true"
			region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="划扣请求列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />

			<aos:column dataIndex="request_uuid_" hidden="true" header="划扣请求ID"
				width="80" />
			<aos:column header="划扣请求ID" dataIndex="uuid_" celltip="true"
				width="80" />
			<aos:column header="归属业务线" dataIndex="platformName" celltip="true"
				width="80" />
			<aos:column header="IP地址" dataIndex="ip_address_" width="90" />
			<aos:column header="划扣接口" dataIndex="service_code_" celltip="true" rendererField="service_codes_" 
				width="120" />
			<aos:column header="请求时间" dataIndex="time_" width="80" />
			<aos:column header="响应时间" dataIndex="response_time_" width="80" align="center"/>
			<aos:column header="响应码" dataIndex="response_code" width="80" align="center"/>
			<aos:column header="响应码摘要" dataIndex="summary" width="80" align="center"/>
			<aos:column header="请求内容" align="center" fixedWidth="80"
				rendererFn="fn_bt_loanDedail" />
			<aos:column header="响应内容" align="center" fixedWidth="80"
				rendererFn="fn_bt_loanDedail2" />
		</aos:gridpanel>


		<aos:window id="_w_req" title="划扣请求的请求内容" onshow="_w_req_onshow"
			width="640" height="490">
			<aos:formpanel id="req_info" layout="column" 
				labelWidth="800" width="750">
				<aos:fieldset title="摘要" labelWidth="70" columnWidth="1"
					margin="0 10 0 0">
					<aos:textfield name="uuid_" fieldLabel="划扣请求" maxLength="50"
						readOnly="true" columnWidth="0.5" />
					<aos:textfield name="platformName" fieldLabel="归属业务线" readOnly="true"
						columnWidth="0.44" />
					<aos:textfield name="ip_address_" fieldLabel="IP地址" readOnly="true"
						columnWidth="0.5" />
					<aos:combobox name="service_code_" fieldLabel="划扣接口" dicDataType="number" dicField="service_codes_" editable="false"
						readOnly="true" columnWidth="0.44" />
				</aos:fieldset>
				
				<aos:fieldset title="请求内容" labelWidth="70" columnWidth="1"
					border="true">
					<aos:textareafield name="content_" height="300" columnWidth="0.99" />
				</aos:fieldset>

			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="_window_hide" text="关闭" icon="close.png" />
			</aos:docked>
		</aos:window>


		<aos:window id="_w_resp" title="划扣请求的响应内容" onshow="_w_rsp_onshow"
			width="640" height="490">
			<aos:formpanel id="rsp_info" layout="column" 
				labelWidth="800" width="750">
				<aos:fieldset title="摘要" labelWidth="70" columnWidth="1"
					margin="0 10 0 0">
					<aos:textfield name="request_uuid_" fieldLabel="划扣请求"
						maxLength="50" readOnly="true" columnWidth="0.5" />
					<aos:textfield name="platformName" fieldLabel="归属业务线" readOnly="true"
						columnWidth="0.44" />
					<aos:textfield name="ip_address_" fieldLabel="IP地址" readOnly="true"
						columnWidth="0.5" />
					<aos:combobox name="service_code_" fieldLabel="划扣接口" dicDataType="number" dicField="service_codes_" editable="false"
						readOnly="true" columnWidth="0.44" />
				</aos:fieldset>

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
					uuid_ : record.data.uuid_
				},
				url : 'chargebackRequestService.chargebackDetails',
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
					request_uuid_ : record.data.request_uuid_
				},
				url : 'chargebackRequestService.chargebackDetails',
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
			if (record.data.uuid_ == '${uuid_}') {
				return '--';
			} else {
				return '<input type="button" value="调阅" class="cbtn" onclick="_btn_request_onclick();" />';
			}
		}

		//调阅 
		function fn_bt_loanDedail2(value, metaData, record, rowIndex, colIndex,store) {
			if (record.data.request_uuid_ == '${request_uuid_}') {
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
