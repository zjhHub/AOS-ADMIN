<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="划扣受理详情" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:hiddenfield name="id_" id="id_" value="${acceptedID}" />
		<aos:tabpanel id="id_tabpanel" region="center" activeTab="0" bodyBorder="0 0 0 0" tabBarHeight="30">
			<aos:tab title="受理详情" id="_tab_details" layout="border">
				 <aos:formpanel id="_f__detail"  region="center"> <!-- onrender="fn_form_detail"  -->
					<aos:fieldset title="受理内容" labelWidth="90" columnWidth="1">
						<aos:textfield name="id_" fieldLabel="划扣受理ID" readOnly="true" columnWidth="0.33" value="${po['id_']}"/>
						<aos:textfield name="chargeback_amount_" fieldLabel="划扣金额" readOnly="true" value="${po['chargeback_amount_']}" columnWidth="0.33"  />
						<aos:textfield name="request_id_" fieldLabel="请求起源ID" value="${po['request_id_']}" readOnly="true" columnWidth="0.33" />
						<aos:textfield name="chargeback_account_" fieldLabel="划扣账号银行号" value="${po['chargeback_account_']}"  readOnly="true" columnWidth="0.33" />
						<aos:textfield name="chargeback_bank_id_" fieldLabel="划扣账号银行" value="${po['chargeback_bank_id_']}"  readOnly="true" columnWidth="0.33" />
						<aos:textfield name="contract_id_" fieldLabel="借款合同ID"  value="${po['contract_id_']}"  readOnly="true" columnWidth="0.33" />
						<aos:textfield name="chargeback_name_" fieldLabel="户主姓名" value="${po['chargeback_name_']}" readOnly="true" columnWidth="0.33" />
						<aos:combobox name="location_" fieldLabel="受理所在位置" value="${po['location_']}" readOnly="true" columnWidth="0.33" dicField="location_"/>
						<aos:textfield name="chargeback_idcard_" fieldLabel="户主身份证" value="${po['chargeback_idcard_']}" readOnly="true" columnWidth="0.33" />
						<aos:textfield name="name_" fieldLabel="业务线" readOnly="true" value="${po['name_']}" columnWidth="0.33" />
						<aos:textfield name="chargeback_cellphone_" fieldLabel="预留手机" value="${po['chargeback_cellphone_']}"  readOnly="true" columnWidth="0.33"  />
						<aos:textfield name="biz_summary_" fieldLabel="业务摘要" value="${po['biz_summary_']}"  readOnly="true" columnWidth="0.33" />
						<aos:textfield name="created_time_" fieldLabel="数据创建时间" value="${po['created_time_']}" readOnly="true" columnWidth="0.33" />
						<aos:textfield name="contract_code_" fieldLabel="业务线借款编号" value="${po['contract_code_']}"  readOnly="true" columnWidth="0.33" />
						<aos:textfield name="fcocount" fieldLabel="下级划扣指令数" value="${po['fcocount']}" readOnly="true" columnWidth="0.33" />
						<aos:textfield name="reference_" fieldLabel="业务线引用数据" value="${po['reference_']}" readOnly="true" columnWidth="0.33" />
						<aos:textfield name="async_callback_" fieldLabel="异步回调地址" value="${po['async_callback_']}" readOnly="true" columnWidth="0.33" />
						<aos:textfield name="remark_" fieldLabel="业务线备注" readOnly="true" value="${po['remark_']}" columnWidth="0.33" />
						<aos:textfield name="thirdName" fieldLabel="路由名称" readOnly="true" value="${po['thirdName']}" columnWidth="0.33" />
					</aos:fieldset>
					<aos:fieldset title="受理结果" labelWidth="90" height="400" columnWidth="1">
						<aos:combobox name="chargeback_status_" fieldLabel="划扣状态" value="${po['chargeback_status_']}" readOnly="true" columnWidth="0.33" dicField="chargeback_status_"/>
						<aos:textfield name="chargebacked_amount_" fieldLabel="划扣成功金额" value="${po['chargebacked_amount_']}" readOnly="true" columnWidth="0.33" />
						<aos:textfield name="response_code_" fieldLabel="响应码" readOnly="true" value="${po['response_code_']}" columnWidth="0.33" />
						<aos:textfield name="first_callback_time_" fieldLabel="初次回调时间" readOnly="true" value="${po['first_callback_time_']}" columnWidth="0.33" />
						<aos:textfield name="response_summary_" fieldLabel="响应摘要" readOnly="true" value="${po['response_summary_']}" columnWidth="0.33" />
						<aos:textfield name="response_msg_templet_" fieldLabel="响应消息模板" readOnly="true" value="${po['response_msg_templet_']}" columnWidth="0.33" />
						<aos:textareafield  name="callback_content_" fieldLabel="回调内容" readOnly="true" value="${po['callback_content_']}" columnWidth="0.99" height="350"/>
					</aos:fieldset>
				</aos:formpanel> 
			</aos:tab>
			
			<aos:tab title="划扣指令" id="_tab_org" layout="border" onactivate="_g_org_query">
				<aos:gridpanel id="_g_org" url="chargebackAcceptService.chargebackOrderList" region="center" forceFit="false">
					<aos:column type="rowno" />
					<aos:column header="受理指令ID" dataIndex="id_" width="80" />
					<aos:column header="指令创建时间" dataIndex="created_time_" width="120" />
					<aos:column header="路由去向" dataIndex="name_" celltip="true" width="100" />
					<aos:column header="指令位置" dataIndex="location_" width="100" rendererField="order_location_"/>
					<aos:column header="划扣金额" dataIndex="chargeback_amount_" width="100" />
					<aos:column header="划扣账号所在银行" dataIndex="full_name_" width="150" />
					<aos:column header="划扣账号" dataIndex="chargeback_account_" width="100" />
					<aos:column header="划扣账号户主姓名" dataIndex="chargeback_name_" width="150" />
					<aos:column header="划扣账号户主身份证" dataIndex="chargeback_idcard_" width="150" />
					<aos:column header="划扣账号预留手机" dataIndex="chargeback_cellphone_" width="150" />
					<aos:column header="第三方支付交互订单号" dataIndex="third_channel_order_id_" width="150" />
					<aos:column header="第三方支付交互次数" dataIndex="interact_times_" width="150" />
					<aos:column header="指令结果" dataIndex="order_result_status_" rendererField="order_result_status_" width="100" />
					<aos:column header="交易金额" dataIndex="trans_amount" width="100" />
					<aos:column header="第三方支付手续费" dataIndex="third_channel_fee_" width="120" />
					<aos:column header="第三方支付反馈摘要" dataIndex="third_channel_feedback_" width="120" />
					<aos:column header="第三方支付返回码" dataIndex="third_channel_return_code_" width="120" />
					<aos:column header="我方发给第三方支付的时间" dataIndex="request_time" width="180" />
					<aos:column header="第三方支付完成指令时间" dataIndex="response_time_" width="180" />
					<aos:column header="银行响应第三方支付时间" dataIndex="bank_echo_time_" width="180" />
					<aos:column header="操作" align="center" fixedWidth="80" rendererFn="fn_bt_shouliDedail" />
				</aos:gridpanel>
			</aos:tab>

			<aos:tab title="回调记录" id="_tab_param" onactivate="_g_param_query" layout="border">
				<aos:gridpanel id="_g_param" url="chargebackAcceptService.chargebackAcceptedCallbackList" pageSize="20" region="center">
					<aos:column type="rowno" />
					<aos:column header="回调ID" dataIndex="id_" width="50" />
					<aos:column header="回调状态" dataIndex="callback_status_" rendererField="callback_status_" width="60" />
					<aos:column header="回调时间" dataIndex="callback_time_" width="80" />
					<aos:column header="对方应答HTTP状态码" dataIndex="response_http_code_" width="50" />
				</aos:gridpanel>
			</aos:tab>
		</aos:tabpanel>
	</aos:viewport>

	<script type="text/javascript">
	
		//受理详情
		function fn_bt_shouliDedail(value, metaData, record, rowIndex, colIndex,store) {
			if (record.data.id_ == '${id_}') {
				return '--';
			} else {
				return '<input type="button" value="详情" class="cbtn" onclick="_btn_chargebackaccept_onclick();" />';
			}
		}

	
		//划扣指令
		function _g_org_query() {
			if (!_tab_org.isVisible()) {
				_tabpanel.setActiveTab(_tab_org);
			}
			var accpId = id_.getValue();
			var params = {
					acceptedID : accpId
			};
			_g_org_store.getProxy().extraParams = params;
			_g_org_store.loadPage(1);
		}

		//回调记录
		function _g_param_query() {
			if (!_tab_param.isVisible()) {
				_tabpanel.setActiveTab(_tab_param);
			}
			var accpid = id_.getValue();
			var params = {
					acceptedID : accpid
			};
			_g_param_store.getProxy().extraParams = params;
			_g_param_store.loadPage(1);
		}
	</script>

</aos:onready>
<script type="text/javascript">
	function _btn_chargebackaccept_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_org'));
		var order_id_ = record.data.id_;
		parent.fnaddtab('chargebackPayService.orderDetail&chargeback_order_id_=' + order_id_, '划扣指令'+order_id_+'的详情', order_id_);
	}

</script>