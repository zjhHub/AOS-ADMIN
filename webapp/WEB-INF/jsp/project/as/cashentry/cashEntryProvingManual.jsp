<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="充值提现手动校验" base="http" lib="ext">
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
	<aos:viewport layout="fit" >
	<aos:panel layout="auto" autoScroll="true" border="false">
	<aos:panel layout="column" width="-4" border="false">
				 <aos:formpanel id="_f_detail"  labelWidth="150" columnWidth="1">
				 	<aos:docked forceBoder="0 0 1 0">
						<aos:dockeditem xtype="tbtext" text="待校验的${type }登账摘要" />
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
				</aos:formpanel>
				
				<aos:tabpanel id="_tabpanel" activeTab="0" bodyBorder="0 0 0 0" tabBarHeight="30" columnWidth="1" height="400">
					<aos:tab title="动账类信息" id="_tab_param0" layout="anchor" >
						<aos:gridpanel id="_g_trans" url="cashEntryService.initInMoneyPage" onrender="_g_trans_query"  anchor="100% 50%"  hidePagebar="true">
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
						</aos:gridpanel>
						<aos:gridpanel id="_g_trans_two" url="cashEntryService.initOutMoneyPage" onrender="_g_trans_two_query"  anchor="100% 50%" hidePagebar="true">
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
						</aos:gridpanel>
					</aos:tab>
		
					<aos:tab title="相关凭证" id="_tab_param1" contentEl="div_tab2" autoScroll="true">
					</aos:tab>
					
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
						</aos:gridpanel>
							
					</aos:tab>
				</aos:tabpanel>
				
			<c:if test="${po['accepted_status_']==1 }">
			<aos:panel border="false" columnWidth="1">
 				<aos:formpanel id="_f_detail_jiaoyan" labelWidth="100">
					 	<aos:docked forceBoder="0 0 1 0">
							<aos:dockeditem xtype="tbtext" text="填写校验结果" />
						</aos:docked>
						<aos:hiddenfield name="accept_id_" fieldLabel="受理ID" readOnly="true" columnWidth="0.33" value="${po['id_']}"/>
						<aos:combobox fieldLabel="校验结果" name="proving_result_" allowBlank="false" editable="false" onselect="hideOrShow"
					columnWidth="0.33" dicField="proving_result_manual_" />
					
					<aos:combobox fieldLabel="拒绝原因" name="response_code_" editable="true"
					columnWidth="0.33" dicField="response_code_manual_proving_" />
					<aos:textareafield name="remark_" allowBlank="false" fieldLabel="校验备注" columnWidth="50" height="100"/>
						<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
							<aos:dockeditem xtype="tbfill" />
							<aos:dockeditem xtype="button" text="完成校验" onclick="finish_proving" icon="query.png"/>
							<aos:dockeditem xtype="button" text="取消" onclick="AOS.reset(_f_detail_jiaoyan);" icon="refresh.png" />
							<aos:dockeditem xtype="tbfill" />
						</aos:docked>
				</aos:formpanel>
			</aos:panel>
			</c:if>
		</aos:panel>		
	</aos:panel>			
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
	
	

	<script type="text/javascript">
	
	AOS.hides(_f_detail_jiaoyan,'response_code_');
	
	function hideOrShow(obj){
		if(obj.getValue()==2){
			AOS.shows(_f_detail_jiaoyan,'response_code_');
		}else{
			AOS.hides(_f_detail_jiaoyan,'response_code_');
		}
	}
	
	function _window_hide(){
		_w_request_content.hide();
	}
	
	function _w_request_content_onshow() {
		
	}
	
	function _g_trans_query(){
		var acId_ = id_.getValue();
		var params={accepted_id_:acId_};
		_g_trans_store.getProxy().extraParams = params;
		_g_trans_store.loadPage(1);
	}
	
	function _g_trans_two_query(){
		var acId_ = id_.getValue();
		var params={accepted_id_:acId_};
		_g_trans_two_store.getProxy().extraParams = params;
		_g_trans_two_store.loadPage(1);
	}
	
	function _g_trans_proving_auto_query(){
		var acId_ = id_.getValue();
		var params={accepted_id_:acId_};
		_g_trans_proving_auto_store.getProxy().extraParams = params;
		_g_trans_proving_auto_store.loadPage(1);
	}
	
	//完成校验
	function finish_proving(){
       AOS.ajax({
           url: 'cashEntryService.finishProvingMaual',
           forms:_f_detail_jiaoyan,
           ok: function (data) {
               AOS.tip(data.appmsg);
               location.reload();
           }
       });
	}
	</script>

</aos:onready>
<script type="text/javascript">
function _btn_request_content_onclick() {
	Ext.getCmp('_w_request_content').show();
}
</script>