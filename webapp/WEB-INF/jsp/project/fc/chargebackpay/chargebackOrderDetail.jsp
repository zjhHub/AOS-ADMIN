<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="指令明细记录" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="fit" id="_g_stock">
		<aos:hiddenfield name="chargeback_order_id_" id="chargeback_order_id_" value="${orderPo['id_']}" />
		<aos:tabpanel id="id_tabpanel" region="center" activeTab="0" bodyBorder="0 0 0 0" tabBarHeight="30">
			<aos:tab title="指令详情" id="_tab_detail" layout="border">
				<aos:panel border="false" region="center">
					<aos:panel>
						<aos:formpanel id="_f_user" width="650" labelWidth="65">
							<aos:fieldset title="指令内容" labelWidth="150" columnWidth="1">
								<aos:textfield name="id_" fieldLabel="划扣指令ID" value="${orderPo['id_']}" readOnly="true" columnWidth="0.4" />
								<aos:textfield name="chargeback_amount_" fieldLabel="划扣金额" value="${orderPo['chargeback_amount_']}" readOnly="true" columnWidth="0.4" />
								<aos:textfield name="chargeback_accepted_id_" fieldLabel="指令起源(划扣受理ID)" value="${orderPo['chargeback_accepted_id_']}" readOnly="true" columnWidth="0.4" />
								<aos:textfield name="chargeback_bank_id_" fieldLabel="划扣账号所在银行" value="${orderPo['chargeback_bank_id_']}" readOnly="true" columnWidth="0.4" />
								<aos:textfield name="chargeback_account_" fieldLabel="划扣账号所在银行号" value="${orderPo['chargeback_account_']}" readOnly="true" columnWidth="0.4" />
								<aos:combobox name="location_" fieldLabel="指令所在位置" value="${orderPo['location_']}" readOnly="true" columnWidth="0.4" dicField="order_location_"/>
								<aos:textfield name="chargeback_name_" fieldLabel="划扣账号户主姓名" value="${orderPo['chargeback_name_']}" readOnly="true" columnWidth="0.4" />
								<aos:textfield name="send_count_" fieldLabel="指令发送次数" value="${sendCount}" readOnly="true" columnWidth="0.4" />
								<aos:textfield name="chargeback_idcard_" fieldLabel="划扣账号户主身份证" value="${orderPo['chargeback_idcard_']}" readOnly="true" columnWidth="0.4" />
								<aos:textfield name="third_channel_order_id_" fieldLabel="第三方支付交互ID" value="${orderPo['third_channel_order_id_']}" readOnly="true" columnWidth="0.4" />
								<aos:textfield name="check_count_" fieldLabel="指令核查次数" value="${checkCount}" readOnly="true" columnWidth="0.4" />
								<aos:textfield name="chargeback_cellphone_" fieldLabel="划扣账号预留手机" value="${orderPo['chargeback_cellphone_']}" readOnly="true" columnWidth="0.4" />
								<aos:textfield name="created_time_" fieldLabel="数据创建时间" value="${orderPo['created_time_']}" readOnly="true" columnWidth="0.4" />
							</aos:fieldset>
							<c:if test="${result != null}">
							</c:if>
							<aos:fieldset title="指令结果" labelWidth="150" columnWidth="1">
								<c:if test="${result != null}">
									<aos:textfield name="status_" fieldLabel="指令结果状态" value="${result['status_']}" readOnly="true" columnWidth="0.4" />
									<aos:textfield name="amount_" fieldLabel="交易金额" value="${result['amount_']}" readOnly="true" columnWidth="0.4" />
									<aos:textfield name="third_channel_fee_" fieldLabel="第三方手续费" value="${result['third_channel_fee_']}" readOnly="true" columnWidth="0.4" />
									<aos:textfield name="request_time_" fieldLabel="我方发给第三方时间" value="${result['request_time_']}" readOnly="true" columnWidth="0.4" />
									<aos:textfield name="feedback_" fieldLabel="第三方反馈摘要" value="${result['feedback_']}" readOnly="true" columnWidth="0.4" />
									<aos:textfield name="response_time_" fieldLabel="第三方完成指令的时间" value="${result['response_time_']}" readOnly="true" columnWidth="0.4" />
									<aos:textfield name="return_code_" fieldLabel="第三方返回码" value="${result['return_code_']}" readOnly="true" columnWidth="0.4" />
									<aos:textfield name="bank_echo_time_" fieldLabel="银行响应第三方的时间" value="${result['bank_echo_time_']}" readOnly="true" columnWidth="0.4" />
								</c:if>
							</aos:fieldset>
						</aos:formpanel>
					</aos:panel>
				</aos:panel>
			</aos:tab>
			<aos:tab title="发送情况" id="_tab_send" onactivate="_g_send_query" layout="border">
				<aos:gridpanel id="_g_send" url="chargebackPayService.sendList"
					pageSize="20" region="center">
					<aos:column type="rowno" />
					<aos:column header="指令发送ID" dataIndex="id_" width="10" />
					<aos:column header="第三方支付交互ID" dataIndex="third_channel_order_id_" width="20" />
					<aos:column header="指令发送时间" dataIndex="sent_time_" width="20" />
					<aos:column header="指令发送状态" dataIndex="sent_status_" width="20" rendererFn="fn_send_status_render"/>
					<aos:column header="信息扩展" align="center" fixedWidth="80" rendererFn="fn_bt_Dedail" />
				</aos:gridpanel>
				
				
				
			<aos:window id="_w_ext_context_" title="信息扩展详情" onshow="_w_ext_context_show" width="640" height="600">
				<aos:formpanel id="ext_context_info" layout="column" >
					<aos:fieldset title="内容" labelWidth="70" columnWidth="1"
						border="true">
						<aos:textareafield name="ext_context_" height="500" columnWidth="0.99" readOnly="true"/>
					</aos:fieldset>
				</aos:formpanel>
				<aos:docked dock="bottom" ui="footer">
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem onclick="_window_hide" text="关闭" icon="close.png" />
				</aos:docked>
			</aos:window>
				
			</aos:tab>
			
			<aos:tab title="核查情况" id="_tab_query" onactivate="_g_query_query" layout="border">
				<aos:gridpanel id="_g_query" url="chargebackPayService.checkList"
					pageSize="20" region="center">
					<aos:column type="rowno" />
					<aos:column header="指令核查ID" dataIndex="id_" width="10" />
					<aos:column header="第三方直接付交互ID" dataIndex="third_channel_order_id_" width="20"/>
					<aos:column header="指令核查时间" dataIndex="checked_time" width="20" />
					<aos:column header="指令核查状态" dataIndex="checked_status_" width="20" rendererFn="fn_check_status_render"/>
					<aos:column header="信息扩展" align="center" fixedWidth="80" rendererFn="fn_bt_DedailTwo" />
				</aos:gridpanel>
				
				
				<aos:window id="_w_context_" title="信息扩展详情" onshow="_w_context_show" width="640" height="600">
				<aos:formpanel id="ext_contextTwo_info" layout="column">
					<aos:fieldset title="内容" labelWidth="70" columnWidth="1" border="true">
						<aos:textareafield name="ext_context_" height="500" columnWidth="0.99" readOnly="true"/>
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
	
	
	function _w_ext_context_show() {
		var record = AOS.selectone(_g_send, true);
		AOS.ajax({
			params : {
				id_ : record.data.id_
			},
			url : 'chargebackPayService.sendDetails',
			ok : function(data) {
				AOS.reset(ext_context_info);
				ext_context_info.form.setValues(data);
			}
		});
	}
	
	function _w_context_show() {
		var record = AOS.selectone(_g_query, true);
		AOS.ajax({
			params : {
				id_ : record.data.id_
			},
			url : 'chargebackPayService.checkDetails',
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
	
	
	//
	function fn_bt_DedailTwo(value, metaData, record, rowIndex, colIndex,
			store) {
		if (record.data.id_ == '${id_}') {
			return '--';
		} else {
			return '<input type="button" value="详情" class="cbtn" onclick="_btn_onclickTwo();" />';
		}
	}
	
	
		//重置 
		function _loan_reset() {
			AOS.reset(_loan);
		}
		function _g_send_query(){
			if (!_tab_send.isVisible()) {
				_tabpanel.setActiveTab(_tab_send);
			}
			var order_id_ = chargeback_order_id_.getValue();
			var params = {
				chargeback_order_id_ : order_id_
			};
			_g_send_store.getProxy().extraParams = params;
			_g_send_store.loadPage(1);
		}
		function _g_query_query(){
			if (!_tab_query.isVisible()) {
				_tabpanel.setActiveTab(_tab_query);
			}
			var order_id_ = chargeback_order_id_.getValue();
			var params = {
				chargeback_order_id_ : order_id_
			};
			_g_query_store.getProxy().extraParams = params;
			_g_query_store.loadPage(1);
		}
		//1：处理中   2：交易失败 3：交易完成  4：网络超时   
		function fn_send_status_render(value){
			if(value == 1) return "处理中";
			if(value == 2) return "交易失败 ";
			if(value == 3) return "交易完成";
			if(value == 4) return "网络超时";
			return value;
		}
		//4：查无此订单，1、完成交易  2、核查失败 3、网络超时  0、处理中
		function fn_check_status_render(value){
			if(value == 4) return "查无此订单";
			if(value == 1) return "完成交易";
			if(value == 2) return "核查失败";
			if(value == 3) return "网络超时";
			if(value == 0) return "处理中";
			return value;
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

