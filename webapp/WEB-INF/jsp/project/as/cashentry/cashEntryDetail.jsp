<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="充值提现明细" base="http" lib="ext">
<aos:body>
<div id="div_tab2" class="x-hidden">
	<c:forEach items="${As_proofPOList}" var="As_proofPO">
		<p>凭证名称:${As_proofPO.proof_name_ }</p>
		<p><img src="${As_proofPO.proof_file_path_ }"></p>
	</c:forEach>
</div>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border" >
				 <aos:formpanel id="_f_detail"  region="north" labelWidth="150">
				 	<aos:docked forceBoder="0 0 1 0">
						<aos:dockeditem xtype="tbtext" text="${type }登账摘要" />
					</aos:docked>
					<aos:textfield name="id_" id="id_" fieldLabel="受理ID" readOnly="true" columnWidth="0.33" value="${po['id_']}"/>
					<aos:textfield name="reason_" fieldLabel="第三方交易账户" readOnly="true" value="${po['target_']}" columnWidth="0.33" />
					<aos:combobox name="response_code_" fieldLabel="充值提现标记" value="${po['type_']}" dicField="entry_type_" editable="false"
					readOnly="true" columnWidth="0.33" />
					<aos:textfield name="account_code_" fieldLabel="第三方交易金额" value="${po['amount_']}"  readOnly="true" columnWidth="0.33" />
					<fmt:formatDate value="${po['accepted_time_']}" pattern='yyyy-MM-dd HH:mm:ss' var="accepted_time_"/>
					<aos:textfield name="customer_code_" fieldLabel="受理时间" value="${accepted_time_}"  readOnly="true" columnWidth="0.33" />
					<aos:textfield name="idcard_" fieldLabel="第三方手续费"  value="${po['third_channel_fee_']}"  readOnly="true" columnWidth="0.33" />
					
					<aos:combobox name="response_code_" fieldLabel="第三方渠道" value="${po['third_channel_']}" dicField="third_channel_id_" editable="false"
					readOnly="true" columnWidth="0.33" />
					<aos:textfield name="name_" fieldLabel="实际到账金额"  value="${po['arrived_amount_']}"  readOnly="true" columnWidth="0.33" />
					<aos:textfield name="name_" fieldLabel="第三方订单号"  value="${po['order_id_']}"  readOnly="true" columnWidth="0.33" />
					<fmt:formatDate value="${po['arrived_time_']}" pattern='yyyy-MM-dd HH:mm:ss' var="arrived_time_"/>
					<aos:textfield name="name_" fieldLabel="到账时间"  value="${arrived_time_}"  readOnly="true" columnWidth="0.33" />
					
					<fmt:formatDate value="${po['request_time_']}" pattern='yyyy-MM-dd HH:mm:ss' var="request_time_"/>
					<aos:textfield name="name_" fieldLabel="第三方订单请求时间"  value="${request_time_}"  readOnly="true" columnWidth="0.33" />
					
					<aos:textfield name="name_" fieldLabel="扩展引用"  value="${po['ext_reference_']}"  readOnly="true" columnWidth="0.33" />
					
					<fmt:formatDate value="${po['response_time_']}" pattern='yyyy-MM-dd HH:mm:ss' var="response_time_"/>
					<aos:textfield name="name_" fieldLabel="第三方订单请求响应时间"  value="${response_time_}"  readOnly="true" columnWidth="0.33" />
					<aos:textfield name="name_" fieldLabel="资金流水备注"  value="${po['recharge_remark_']}"  readOnly="true" columnWidth="0.33" />
					
					<aos:combobox name="response_code_" fieldLabel="真实性校验方式" value="${po['proving_way_']}" dicField="real_check_way_" editable="false"
					readOnly="true" columnWidth="0.33" />
					<aos:textfield name="name_" fieldLabel="业务流水备注"  value="${po['business_remark_']}"  readOnly="true" columnWidth="0.33" />
					<aos:combobox  fieldLabel="受理执行结果" value="${po['status_']}" dicField="entry_accept_result_" editable="false"
						readOnly="true" columnWidth="0.33" />	
				</aos:formpanel> 
				
				<aos:formpanel id="_f_detail_2" region="north" labelWidth="150">
						<aos:docked forceBoder="0 0 1 0">
							<aos:dockeditem xtype="tbtext" text="${type }受理执行结果" />
						</aos:docked>
						<aos:combobox name="response_code_" fieldLabel="充值结果" value="${po['status_']}" dicField="entry_accept_result_" editable="false"
						readOnly="true" columnWidth="0.33" />
						<aos:textfield name="reason_" fieldLabel="响应码" readOnly="true" value="${po['response_code_']}" columnWidth="0.33" />
						<aos:textfield name="created_time_" fieldLabel="充值金额" value="${po['actual_amount_']}" readOnly="true" columnWidth="0.33" />
						<aos:textfield name="account_code_" fieldLabel="响应摘要" value="${po['response_summary_']}"  readOnly="true" columnWidth="0.33" />
						<aos:textfield name="customer_code_" fieldLabel="响应消息模板" value="${po['response_msg_templet_']}"  readOnly="true" columnWidth="0.33" />
				</aos:formpanel> 
				
				<aos:formpanel id="_f_detail_2_22" region="north" labelWidth="150">
					<aos:docked forceBoder="0 0 1 0">
								<aos:dockeditem xtype="tbtext" text="${type }详情" />
					</aos:docked>
				</aos:formpanel> 
				<aos:tabpanel id="_tabpanel" region="center" activeTab="0" bodyBorder="0 0 0 0" tabBarHeight="30">
					
					<aos:tab title="动账类信息" id="_tab_param0" layout="border" >
						<aos:gridpanel id="_g_trans" url="cashEntryService.initInMoneyPage" onrender="_g_trans_query" height="150" region="north" hidePagebar="true">
							<aos:docked forceBoder="1 0 1 0">
								<aos:dockeditem xtype="tbtext" text="充值相关的入金账户" />
								<aos:dockeditem xtype="tbseparator" />
							</aos:docked>
							<aos:column header="快照ID" dataIndex="snap_id_" celltip="true" width="150"  align="center" hidden="true"/>
							<aos:column header="入金流水ID" dataIndex="id_" celltip="true" width="150"  align="center"/>
							<aos:column header="入金账户编码" dataIndex="account_code_" celltip="true" width="260" align="center" />
							<aos:column header="入金账户客户身份证" dataIndex="idcard_" width="260" align="center"/>
							<aos:column header="入金账户客户" dataIndex="name_" celltip="true"  width="260" align="center"/>
							<aos:column header="入金具体金额" dataIndex="amount_" celltip="true"  width="260" align="center"/>
							<aos:column header="入金位置" dataIndex="position_" celltip="true"  width="260" align="center"/>
							<aos:column header="入金原由" dataIndex="involve_reason_" celltip="true"  width="260" align="center"/>
							<aos:column header="操作"  celltip="true"  width="260" align="center" rendererFn="_g_trans_operation"/>
						</aos:gridpanel>
						<aos:gridpanel id="_g_trans_two" url="cashEntryService.initOutMoneyPage" onrender="_g_trans_two_query"  region="center" hidePagebar="true">
							<aos:docked forceBoder="1 0 1 0">
								<aos:dockeditem xtype="tbtext" text="充值相关的出金账户" />
								<aos:dockeditem xtype="tbseparator" />
							</aos:docked>
							<aos:column header="快照ID" dataIndex="snap_id_" celltip="true" width="150"  align="center" hidden="true"/>
							<aos:column header="出金流水ID" dataIndex="id_" celltip="true" width="150"  align="center"/>
							<aos:column header="出金账户编码" dataIndex="account_code_" celltip="true" width="260" align="center" />
							<aos:column header="出金账户客户身份证" dataIndex="idcard_" width="260" align="center"/>
							<aos:column header="出金账户客户" dataIndex="name_" celltip="true"  width="260" align="center"/>
							<aos:column header="出金具体金额" dataIndex="amount_" celltip="true"  width="260" align="center"/>
							<aos:column header="出金位置" dataIndex="position_" celltip="true"  width="260" align="center"/>
							<aos:column header="出金原由" dataIndex="involve_reason_" celltip="true"  width="260" align="center"/>
							<aos:column header="操作"  celltip="true"  width="260" align="center" rendererFn="_g_trans_two_operation"/>
						</aos:gridpanel>
					</aos:tab>
		
					<aos:tab title="相关凭证" id="_tab_param1" contentEl="div_tab2" autoScroll="true">
					</aos:tab>
					
					<c:if test="${isShowProvingAuto==true}">
					<aos:tab title="系统自动校验结果" id="_tab_param2" layout="border" >
						<aos:panel border="false" region="north">
							<aos:formpanel id="_f_query1" layout="column" labelWidth="70" header="false" border="false"  >
								<aos:textfield name="name_" fieldLabel="校验URL源" readOnly="true" columnWidth="1" value="${as_proving_autoPO['proving_url_']}"/>
								<aos:button text="查看请求报文" margin="0 0 0 30" icon="query.png" width="120" onclick="_btn_request_content_onclick();"/>
								
							</aos:formpanel>
						</aos:panel>
						<aos:gridpanel id="_g_trans_proving_auto" url="cashEntryService.initProvingAutoPage" onrender="_g_trans_proving_auto_query" region="center">
							<aos:docked forceBoder="1 0 1 0">
								<aos:dockeditem xtype="tbtext" text="校验的响应" />
								<aos:dockeditem xtype="tbseparator" />
							</aos:docked>
							<aos:column header="校验响应" dataIndex="response_content_" celltip="true" width="150"  align="center" hidden="true"/>
							<aos:column header="校验ID" dataIndex="id_" celltip="true" width="150"  align="center"/>
							<aos:column header="校验请求发出时间" dataIndex="request_time_" celltip="true" width="260" align="center" />
							<aos:column header="校验响应接受时间" dataIndex="response_time_" width="260" align="center"/>
							<aos:column header="校验结果" dataIndex="proving_result_" rendererField="proving_result_" celltip="true"  width="260" align="center"/>
							<aos:column header="操作" celltip="true"  width="260" align="center" rendererFn="_g_trans_proving_auto_operation"/>
						</aos:gridpanel>
							
					</aos:tab>
					</c:if>
					
					<c:if test="${isShowProvingManual==true}">
						<aos:tab title="财务手动校验结果" id="_tab_param3">
							<aos:formpanel id="_f_detail_88"  region="north" labelWidth="150">
								<aos:textfield  fieldLabel="校验财务员" readOnly="true" columnWidth="0.99" value="${as_proving_manualPO['proving_by_']}"/>
								<aos:combobox  fieldLabel="校验结果" value="${as_proving_manualPO['proving_result_']}" dicField="proving_result_" editable="false"
								readOnly="true" columnWidth="0.99" />
								<aos:textfield  fieldLabel="校验时间" value="${as_proving_manualPO['proving_time_']}"  readOnly="true" columnWidth="0.99" />
								<aos:textareafield value="${as_proving_manualPO['remark_']}" fieldLabel="校验备注" readOnly="true" columnWidth="0.99"/>
								
							</aos:formpanel> 
						</aos:tab>
					</c:if>
					<aos:tab title="回调记录" id="_tab_param4" layout="border">
						<aos:panel border="false" region="north">
							<aos:formpanel id="_f_query111" layout="column" labelWidth="90" header="false" border="false"  >
								<fmt:formatDate value="${po['first_callback_time_']}" pattern='yyyy-MM-dd HH:mm:ss' var="first_callback_time_"/>
								<aos:textfield name="name_" fieldLabel="初次回调时间" readOnly="true" columnWidth="1" value="${first_callback_time_}"/>
								<aos:button text="查看回调报文" margin="0 0 0 30" icon="query.png" width="120" onclick="_btn_callback_onclick();"/>
								
							</aos:formpanel>
						</aos:panel>
						<aos:gridpanel id="_g_trans_callback" url="cashEntryService.initCallbackPage" onrender="_g_trans_callback_query" region="center">
							<aos:docked forceBoder="1 0 1 0">
								<aos:dockeditem xtype="tbtext" text="回调记录" />
								<aos:dockeditem xtype="tbseparator" />
							</aos:docked>
							<aos:column header="回调ID" dataIndex="id_" celltip="true" width="150"  align="center"/>
							<aos:column header="回调状态" dataIndex="callback_status_" rendererField="callback_status_" celltip="true" width="260" align="center" />
							<aos:column header="回调时间" dataIndex="callback_time_" width="260" align="center"/>
							<aos:column header="对方应答HTTP状态码" dataIndex="response_http_code_" celltip="true"  width="260" align="center"/>
						</aos:gridpanel>
					</aos:tab>
				</aos:tabpanel>
				
		 
	</aos:viewport>
	
	<aos:window id="_w_request_content" title="报文明细" onshow="_w_request_content_onshow">
			<aos:formpanel layout="column" width="500" height="300">
			   <aos:textareafield value="${as_proving_autoPO['request_content_']}" fieldLabel="" readOnly="true" columnWidth="1" height="300"/>
			</aos:formpanel>
			
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="_window_hide" text="关闭" icon="close.png" />
			</aos:docked>
	</aos:window>
	
	<aos:window id="_w_response_content" title="响应报文" onshow="_w_response_content_onshow">
			<aos:formpanel layout="column" width="500" height="300">
			   <aos:textareafield id="response_content_2" fieldLabel="" readOnly="true" columnWidth="1" height="300"/>
			</aos:formpanel>
			
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="_window_hide2" text="关闭" icon="close.png" />
			</aos:docked>
	</aos:window>
	
	<aos:window id="_w_callback_content" title="回调报文" onshow="_w_callback_content_onshow">
			<aos:formpanel layout="column" width="500" height="300">
			   <aos:textareafield value="${po['callback_content_'] }" fieldLabel="" readOnly="true" columnWidth="1" height="300"/>
			</aos:formpanel>
			
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="_window_hide3" text="关闭" icon="close.png" />
			</aos:docked>
	</aos:window>

	<script type="text/javascript">
	/**window弹窗部分**/
	function _window_hide(){
		_w_request_content.hide();
	}
	
	function _window_hide2(){
		_w_response_content.hide();
	}
	
	function _window_hide3(){
		_w_callback_content.hide();
	}
	
	function _w_request_content_onshow() {
		
	}
	
	function _w_response_content_onshow(){
		var record = AOS.selectone(_g_trans_proving_auto, true);
		var response_content_=record.data.response_content_;
		response_content_2.setValue(response_content_);
	}
	
	function _w_callback_content_onshow(){
		var record = AOS.selectone(_g_trans_proving_auto, true);
		var response_content_=record.data.response_content_;
		response_content_2.setValue(response_content_);
	}
	/**window弹窗部分**/
	
	//入金账户分页
	function _g_trans_query(){
		var acId_ = id_.getValue();
		var params={accepted_id_:acId_};
		_g_trans_store.getProxy().extraParams = params;
		_g_trans_store.loadPage(1);
	}
	
	
	//出金账户分页
	function _g_trans_two_query(){
		var acId_ = id_.getValue();
		var params={accepted_id_:acId_};
		_g_trans_two_store.getProxy().extraParams = params;
		_g_trans_two_store.loadPage(1);
	}
	
	//系统自动校验分页
	function _g_trans_proving_auto_query(){
		var acId_ = id_.getValue();
		var params={accepted_id_:acId_};
		_g_trans_proving_auto_store.getProxy().extraParams = params;
		_g_trans_proving_auto_store.loadPage(1);
	}
	
	//回调记录分页
	function _g_trans_callback_query(){
		var acId_ = id_.getValue();
		var params={accepted_id_:acId_};
		_g_trans_callback_store.getProxy().extraParams = params;
		_g_trans_callback_store.loadPage(1);
	}
	
	function _g_trans_two_operation(value, metaData, record, rowIndex, colIndex,
			store){
		return '<input type="button" value="账户快照" class="cbtn" onclick="_btn_g_trans_two_onclick();" />';
	}
	
	function _g_trans_operation(value, metaData, record, rowIndex, colIndex,
			store){
		return '<input type="button" value="账户快照" class="cbtn" onclick="_btn_g_trans_onclick();" />';
	}
	
	function _g_trans_proving_auto_operation(value, metaData, record, rowIndex, colIndex,
			store){
		return '<input type="button" value="查看响应报文" class="cbtn" onclick="_btn_response_content_onclick();" />';
	}
	
	function _btn_request_content_onclick() {
		_w_request_content.show();
	}
	</script>

</aos:onready>
<script type="text/javascript">
function _btn_g_trans_onclick() {
	var record = AOS.selectone(Ext.getCmp('_g_trans'));
	var snapshot_id_ = record.data.snap_id_;
	if(snapshot_id_==undefined || snapshot_id_==null || snapshot_id_==""){
		AOS.tip("不存在快照!");
	}else{
		parent.fnaddtab('balanceTransService.balanceSnapshotDetail&snapshot_id_=' + snapshot_id_, '账户余额快照'+snapshot_id_,snapshot_id_);
	}
	
}

function _btn_g_trans_two_onclick() {
	var record = AOS.selectone(Ext.getCmp('_g_trans_two'));
	var snapshot_id_ = record.data.snap_id_;
	if(snapshot_id_==undefined || snapshot_id_==null || snapshot_id_==""){
		AOS.tip("不存在快照!");
	}else{
		parent.fnaddtab('balanceTransService.balanceSnapshotDetail&snapshot_id_=' + snapshot_id_, '账户余额快照'+snapshot_id_,snapshot_id_);
	}
}

function _btn_response_content_onclick() {
	Ext.getCmp('_w_response_content').show();
}

function _btn_callback_onclick(){
	Ext.getCmp('_w_callback_content').show();
}

</script>