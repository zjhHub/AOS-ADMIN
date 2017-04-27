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
			<aos:tab title="受理指令详情" id="_tab_details" layout="border">
				 <aos:formpanel id="_f__detail"  region="center">
					<aos:fieldset title="受理内容" labelWidth="150" columnWidth="1">
						<aos:textfield name="id_" fieldLabel="放款受理ID" readOnly="true" columnWidth="0.4" value="${po['id_']}"/>
						<aos:textfield name="loan_amount_" fieldLabel="放款金额" readOnly="true" value="${po['loan_amount_']}" columnWidth="0.4"  />
						<aos:textfield name="request_id_" fieldLabel="请求起源ID" value="${po['request_id_']}" readOnly="true" columnWidth="0.4" />
						<aos:textfield name="full_name_" fieldLabel="放款账号所在银行" value="${po['full_name_']}"  readOnly="true" columnWidth="0.4" />
						<aos:textfield name="loan_account_" fieldLabel="放款账号" value="${po['loan_account_']}"  readOnly="true" columnWidth="0.4" />
						<aos:textfield name="contract_id_" fieldLabel="清结算借款合同ID"  value="${po['contract_id_']}"  readOnly="true" columnWidth="0.4" />
						<aos:textfield name="loan_name_" fieldLabel="放款账号户主姓名" value="${po['loan_name_']}" readOnly="true" columnWidth="0.4" />
						<aos:combobox name="location_" fieldLabel="受理所在位置" value="${po['location_']}" readOnly="true" columnWidth="0.4" dicField="loan_location_"/>
						<aos:textfield name="loan_idcard_" fieldLabel="放款账号户主身份证" value="${po['loan_idcard_']}" readOnly="true" columnWidth="0.4" />
						<aos:textfield name="name_" fieldLabel="业务线" readOnly="true" value="${po['name_']}" columnWidth="0.4" />
						<aos:textfield name="loan_cellphone_" fieldLabel="放款账号预留手机" value="${po['loan_cellphone_']}"  readOnly="true" columnWidth="0.4"  />
						<aos:textfield name="biz_summary" fieldLabel="业务摘要" value="${po['biz_summary']}"  readOnly="true" columnWidth="0.4" />
						<aos:textfield name="created_time_" fieldLabel="数据创建时间" value="${po['created_time_']}" readOnly="true" columnWidth="0.4" />
						<aos:textfield name="contract_code_" fieldLabel="业务线借款编号" value="${po['contract_code_']}"  readOnly="true" columnWidth="0.4" />
						<aos:textfield name="reference_" fieldLabel="业务线引用数据" value="${po['reference_']}" readOnly="true" columnWidth="0.4" />
						<aos:textfield name="async_callback_" fieldLabel="异步回调地址" value="${po['async_callback_']}" readOnly="true" columnWidth="0.4" />
						<aos:textfield name="remark_" fieldLabel="业务线备注" readOnly="true" value="${po['remark_']}" columnWidth="0.4" />
					</aos:fieldset>
					
					<aos:fieldset title="第三方指令处理结果" labelWidth="150" columnWidth="1">
						<aos:textfield name="sendrows" fieldLabel="指令发送次数" value="${sendrows}" readOnly="true" columnWidth="0.4" />
						<aos:textfield name="third_channel_fee_" fieldLabel="第三方手续费" value="${po['third_channel_fee_']}" readOnly="true" columnWidth="0.4" />
						<aos:textfield name="order_result_status_" fieldLabel="指令结果状态" value="${po['order_result_status_']}" readOnly="true" columnWidth="0.4" />
						<aos:textfield name="trans_amount" fieldLabel="交易金额" readOnly="true" value="${po['trans_amount']}" columnWidth="0.4" />
						<aos:textfield name="checkrows" fieldLabel="指令核查次数" readOnly="true" value="${po['interact_times_']}" columnWidth="0.4" />
						<aos:textfield name="request_time" fieldLabel="我方发给第三方的时间" readOnly="true" value="${po['request_time']}" columnWidth="0.4" />
						<aos:textfield name="third_channel_feedback_" fieldLabel="第三方反馈摘要" readOnly="true" value="${po['third_channel_feedback_']}" columnWidth="0.4" />
						<aos:textfield name="response_time_" fieldLabel="第三方完成指令的时间" readOnly="true" value="${po['response_time_']}" columnWidth="0.4" />
						<aos:textfield name="third_channel_return_code_" fieldLabel="第三方返回码" readOnly="true" value="${po['third_channel_return_code_']}" columnWidth="0.4" />
						<aos:textfield name="bank_echo_time_" fieldLabel="银行响应第三方的时间" readOnly="true" value="${po['bank_echo_time_']}" columnWidth="0.4" />
						<aos:textfield name="first_callback_time_" fieldLabel="初次回调时间" readOnly="true" value="${po['first_callback_time_']}" columnWidth="0.4" />
						<aos:textareafield name="callback_content_" fieldLabel="回调内容" readOnly="true" value="${po['callback_content_']}" columnWidth="0.4"/>
					</aos:fieldset>
					
				</aos:formpanel> 
			</aos:tab>
			
			<aos:tab title="回调记录" id="_tab_param" onactivate="_g_param_query" layout="border">
				<aos:gridpanel id="_g_param" url="loanAcceptService.loan_accepted_callbackList" pageSize="20" region="center">
					<aos:column type="rowno" />
					<aos:column header="回调ID" dataIndex="id_" width="50" />
					<aos:column header="回调状态" dataIndex="callback_status_" rendererField="callback_status_" width="60" />
					<aos:column header="回调时间" dataIndex="callback_time_" width="80" />
					<aos:column header="对方应答HTTP状态码" dataIndex="response_http_code_" width="50" />
				</aos:gridpanel>
			</aos:tab>
			
			<aos:tab title="指令发送情况" id="_tab_send" layout="border" onactivate="_g_send_query">
				<aos:gridpanel id="_g_send" url="loanAcceptService.sendList" region="center" >
					<aos:column type="rowno" />
					<aos:column header="指令发送ID" dataIndex="id_" width="50" />
					<aos:column header="第三方支付交互ID" dataIndex="third_channel_order_id_" width="60" />
					<aos:column header="指令发送时间" dataIndex="sent_time_" celltip="true" width="100" />
					<aos:column header="指令发送状态" dataIndex="sent_status_" width="100" rendererField="sent_status_"/>
					<aos:column header="信息扩展" align="center" fixedWidth="80" rendererFn="fn_bt_Dedail" />
				</aos:gridpanel>
				
				<aos:window id="_w_ext_context_" title="信息扩展详情" onshow="_w_ext_context_show" width="640" height="600">
					<aos:formpanel id="ext_context_info" layout="column" >
						<aos:fieldset title="内容" labelWidth="70" columnWidth="1"
							border="true">
							<aos:textareafield name="ext_content_" height="500" columnWidth="0.99" readOnly="true"/>
						</aos:fieldset>
					</aos:formpanel>
					<aos:docked dock="bottom" ui="footer">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem onclick="_window_hide" text="关闭" icon="close.png" />
					</aos:docked>
				</aos:window>
			</aos:tab>
			
			<aos:tab title="指令核查情况" id="_tab_org" layout="border" onactivate="_g_org_query">
				<aos:gridpanel id="_g_org" url="loanAcceptService.checkList" region="center" >
					<aos:column type="rowno" />
					<aos:column header="指令核查ID" dataIndex="id_" width="80" />
					<aos:column header="第三方支付交互ID" dataIndex="third_channel_order_id_" width="120" />
					<aos:column header="指令核查发送时间" dataIndex="checked_time" celltip="true" width="100" />
					<aos:column header="指令核查发送状态" dataIndex="checked_status_" width="100" rendererField="checked_status_"/>
<%-- 					<aos:column header="信息扩展" dataIndex="ext_content_" width="100" /> --%>
					<aos:column header="信息扩展" align="center" fixedWidth="80" rendererFn="fn_bt_DedailTwo" />
				</aos:gridpanel>
				
				
				<aos:window id="_w_context_" title="信息扩展详情" onshow="_w_context_show" width="640" height="600">
					<aos:formpanel id="ext_contextTwo_info" layout="column">
						<aos:fieldset title="内容" labelWidth="70" columnWidth="1" border="true">
							<aos:textareafield name="ext_content_" height="500" columnWidth="0.99" readOnly="true"/>
						</aos:fieldset>
					</aos:formpanel>
					<aos:docked dock="bottom" ui="footer">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem onclick="_window_hideTwo" text="关闭" icon="close.png" />
					</aos:docked>
				</aos:window>
			</aos:tab>
		</aos:tabpanel>
		
	</aos:viewport>

	<script type="text/javascript">

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
		
		//指令发送情况
		function _g_send_query() {
			if (!_tab_send.isVisible()) {
				_tabpanel.setActiveTab(_tab_send);
			}
			var accpId = id_.getValue();
			var params = {
					acceptedID : accpId
			};
			_g_send_store.getProxy().extraParams = params;
			_g_send_store.loadPage(1);
		}
		
		//指令核查情况
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
		
		
		function _w_ext_context_show() {
			var record = AOS.selectone(_g_send, true);
			AOS.ajax({
				params : {
					id_ : record.data.id_
				},
				url : 'loanAcceptService.sendDetails',
				ok : function(data) {
					AOS.reset(ext_context_info);
					ext_context_info.form.setValues(data);
				}
			});
		}
		
		
		function _w_context_show() {
			var record = AOS.selectone(_g_org, true);
			AOS.ajax({
				params : {
					id_ : record.data.id_
				},
				url : 'loanAcceptService.checkDetails',
				ok : function(data) {
					AOS.reset(ext_contextTwo_info);
					ext_contextTwo_info.form.setValues(data);
				}
			});
		}
		
		//关闭 
		function _window_hide() {
			_w_ext_context_.hide();
		}
		function _window_hideTwo() {
			_w_context_.hide();
		}
		
		
		//调阅 
		function fn_bt_Dedail(value, metaData, record, rowIndex, colIndex,
				store) {
			if (record.data.id_ == '${id_}') {
				return '--';
			} else {
				return '<input type="button" value="详情" class="cbtn" onclick="_btn_onclick();" />';
			}
		}
		
		function fn_bt_DedailTwo(value, metaData, record, rowIndex, colIndex,
				store) {
			if (record.data.id_ == '${id_}') {
				return '--';
			} else {
				return '<input type="button" value="详情" class="cbtn" onclick="_btn_onclickTwo();" />';
			}
		}
		
		
	</script>

</aos:onready>


<script type="text/javascript">
	function _btn_onclick() {
		Ext.getCmp('_w_ext_context_').show();
	}
	
	function _btn_onclickTwo() {
		Ext.getCmp('_w_context_').show();
	}

	
</script>



