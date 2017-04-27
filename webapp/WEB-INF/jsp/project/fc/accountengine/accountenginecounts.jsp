<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="监控路由划扣引擎" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="fit">

		<aos:panel layout="border" border="false">  
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="监控路由划扣引擎" />
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="刷新监控数据" icon="refresh.png" onclick="_g_d_b_refresh" />
			</aos:docked>
			<aos:panel region="north" border="false">
			<aos:formpanel id="_f_query" layout="column" labelWidth="120" header="false" >
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="划扣受理监控" />
					<aos:dockeditem xtype="tbfill" />
<%-- 					<aos:dockeditem text="划扣受理MQ损坏后的补偿" onclick="f_chargeback_accepted_" /> --%>
				</aos:docked>
				<aos:textfield name="awaitlocation_" fieldLabel="待路由划扣受理数" readOnly="true" columnWidth="0.25" value="${rows1}"/>
				<aos:textfield name="failedlocation_" fieldLabel="已路由划扣受理数" readOnly="true" columnWidth="0.25" value="${rows2}"/>
				<aos:textfield name="overlocation_" fieldLabel="失败划扣受理数" readOnly="true" columnWidth="0.25" value="${rows3}"/>
				<aos:textfield name="feedbackedlocation_" fieldLabel="已反馈划扣受理数" readOnly="true" columnWidth="0.25" value="${rows4}"/>
			</aos:formpanel>
			</aos:panel>
			<aos:panel region="north" border="false">
			<aos:formpanel id="_f_query1" layout="column" labelWidth="120" header="false" >
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="划扣指令监控" />
					<aos:dockeditem xtype="tbfill" />
<%-- 					<aos:dockeditem text="划扣指令MQ损坏后的补偿" onclick="f_chargeback_order_"/> --%>
				</aos:docked>
				<aos:textfield name="sendinglocation_" fieldLabel="待发划扣指令数" readOnly="true" columnWidth="0.25" value="${orderCount1}"/>
				<aos:textfield name="roadinglocation_" fieldLabel="在途划扣指令数" readOnly="true" columnWidth="0.25" value="${orderCount2}"/>
				<aos:textfield name="handledlocation_" fieldLabel="已处理划扣指令数" readOnly="true" columnWidth="0.25" value="${orderCount3}"/>
				<aos:textfield name="backedlocation_" fieldLabel="已反馈划扣指令数" readOnly="true" columnWidth="0.25" value="${orderCount4}"/>
			</aos:formpanel>
			</aos:panel>
			
			<aos:formpanel id="_f_query2" layout="column" labelWidth="70" header="false" border="false" region="north" >
					<aos:docked forceBoder="1 0 1 0">
						<aos:dockeditem xtype="tbtext" text="查询条件" />
					</aos:docked>
<%-- 					<aos:combobox  fieldLabel="所在位置" name="location_" value="0" columnWidth="0.33"> --%>
<%-- 						<aos:option value="" display="全部" /> --%>
<%-- 						<aos:option value="1" display="待发指令库" /> --%>
<%-- 						<aos:option value="2" display="在途指令库" /> --%>
<%-- 					</aos:combobox> --%>
					<aos:textfield fieldLabel="订单号" name="third_channel_order_id_" emptyText="第三方支付交互订单号" columnWidth="0.34" />
					<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
						<aos:dockeditem xtype="tbfill" />
						<aos:dockeditem xtype="button" text="查询" onclick="_g_account_query" icon="query.png" />
						<aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(_f_query2);" icon="refresh.png" />
						<aos:dockeditem xtype="tbfill" />
					</aos:docked>
			</aos:formpanel>
	
		<aos:tabpanel id="id_tabpanel" region="center" activeTab="0" bodyBorder="0 0 0 0" tabBarHeight="30">
		
		<aos:tab title="划扣补偿" id="_tab_org" layout="border">
		
		<aos:gridpanel id="_g_loan" url="accountengineService.chargebackOrdersPage"  onrender="_g_account_query" pageSize="15" autoScroll="true"  forceFit="false"
			region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="划扣指令表" />
			</aos:docked>

			<aos:column type="rowno" />
			<aos:column header="划扣指令ID" dataIndex="id_" align="center" width="80"/>
			<aos:column header="指令创建时间" dataIndex="created_time_" align="center" width="140" />
			<aos:column header="路由去向" dataIndex="routed_third_channel_id_" align="center" width="80" />
			<aos:column header="指令位置" dataIndex="location_" align="center" width="100" rendererField="order_location_"/>
			<aos:column header="划扣受理ID" dataIndex="chargeback_accepted_id_" align="center" width="80"/>
			<aos:column header="划扣金额" dataIndex="chargeback_amount_" align="center" width="80" type="number" format="0,000.00" />
			<aos:column header="划扣账号所在银行" dataIndex="chargeback_bank_id_" align="center" width="140"/>
			<aos:column header="划扣账号" dataIndex="chargeback_account_" align="center" width="80"/>
			<aos:column header="划扣账号户主姓名" dataIndex="chargeback_name_" align="center" width="140"/>
			<aos:column header="划扣账号户主身份证" dataIndex="chargeback_idcard_" align="center" width="140"/>
			<aos:column header="第三方支付交互订单号" dataIndex="third_channel_order_id_" align="center" width="200"/>
			<aos:column header="指令结果状态" dataIndex="order_result_status_" align="center" width="140" rendererField="order_result_status_"/>
			<aos:column header="操作" rendererFn="fn_button_operation_render" align="center"  width="200" />
 		</aos:gridpanel>
		</aos:tab>
		
		<aos:tab title="受理补偿" id="_tab_param" onactivate="_g_param_query"   layout="border">
		<aos:gridpanel id="_g_param" url="accountengineService.chargebackWaitRoutedPage"  autoScroll="true"  pageSize="15"  forceFit="false" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="划扣指令表" />
			</aos:docked>

			<aos:column type="rowno" />
			<aos:column header="划扣请求ID" dataIndex="id_" align="center" width="100"/>
			<aos:column header="路由去向" dataIndex="routed_third_channel_id_" align="center" width="150" rendererField="third_channel_id_"/>
			<aos:column header="受理请求位置" dataIndex="location_" align="center" width="200" rendererField="location_"/>
			<aos:column header="划扣金额" dataIndex="chargeback_amount_" align="center" width="150" type="number" format="0,000.00" />
<%-- 			<aos:column header="划扣账号所在银行" dataIndex="chargeback_bank_id_" align="center" width="140"/> --%>
			<aos:column header="借款合同编码" dataIndex="contract_code_" align="center" width="200"/>
			<aos:column header="划扣账号预留手机" dataIndex="chargeback_cellphone_" align="center" width="140"/>

			<aos:column header="划扣账号" dataIndex="chargeback_account_" align="center" width="170"/>
			<aos:column header="划扣账号户主姓名" dataIndex="chargeback_name_" align="center" width="150"/>
			<aos:column header="划扣账号户主身份证" dataIndex="chargeback_idcard_" align="center" width="170"/>
			<aos:column header="操作" rendererFn="fn_button_routed" align="center"  width="200" />
 		</aos:gridpanel>
		</aos:tab>
			
		</aos:tabpanel>
			
		</aos:panel>
		
	</aos:viewport>

	<script type="text/javascript">
// 		function _g_d_b_refresh() {
// 			AOS.ajax({
// 				url : 'accountengineService.init',
// 				ok : function(data) {
// 					AOS.tip('刷新成功');
// 				}
// 			});
// 		}

		function _g_d_b_refresh() {
				window.location.href = 'do.jhtml?router=accountengineService.init&juid=${juid}';
		}
		
		//加载表格数据
		function _g_account_query() {
			var params = _f_query2.getValues();
			_g_loan_store.getProxy().extraParams = params;
			_g_loan_store.loadPage(1);
		}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
		
		
		//2补录前日
		function _g_param_query() {
			var params = {
					location_ : 1
			};
			_g_param_store.getProxy().extraParams = params;
			_g_param_store.loadPage(1);
		}
		
		
// 		alter(111);
// 		//将划扣受理库中的所有待路由的指令重新发送到mq中
// 		function f_chargeback_accepted_() {
// 			var record = AOS.selectone(Ext.getCmp('_f_query'));
// 			var msg = AOS.merge('确认要进行划扣受理MQ损坏后的补偿吗？');
// 			AOS.confirm(msg, function(btn) {
// 				if (btn === 'cancel') {
// 					AOS.tip('启用操作被取消。');
// 					return;
// 				}
// 				AOS.ajax({
// 					url : 'accountengineService.pushChargebackOrderToMQ',
// 					ok : function(data) {
// 						AOS.tip('划扣受理MQ损坏后的补偿成功');
// 					}
// 				});
// 			});
// 		}
		
// 		// 消息队列损毁补偿
// 		// 将待发指令捞出来放入队列
// 		alter(111);
// 		function f_chargeback_order_() {
// 			alter(111);
// 			var record = AOS.selectone(Ext.getCmp('_g_loan'));
// 			var msg = AOS.merge('确认要进行划扣指令MQ损坏后的补偿吗？');
// 			AOS.confirm(msg, function(btn) {
// 				if (btn === 'cancel') {
// 					AOS.tip('启用操作被取消。');
// 					return;
// 				}
// 				AOS.ajax({
// 					url : 'accountengineService.pushChargebackOrderToMQ',
// 					ok : function(data) {
// 						AOS.tip('划扣指令MQ损坏后的补偿成功');
// 					}
// 				});
// 			});
// 		}
		
		function f_chargeback_accepted_() {
			//将划扣受理库中的所有待路由的指令重新发送到mq中
			var msg = AOS.merge('确认要进行划扣受理MQ损坏后的补偿吗？');
			AOS.confirm(msg,function(btn){
				if (btn === 'cancel') {
 					AOS.tip('启用操作被取消。');
 					return;
 				}
				AOS.ajax({
					url : 'accountengineService.pushChargebackAcceptToMQ',
					ok : function(data) {
						AOS.tip('划扣受理MQ损坏后的补偿刷新成功');
					}
				});
			});
		}
		
		function f_chargeback_order_() {
			// 消息队列损毁补偿
			// 将待发指令捞出来放入队列
			var msg = AOS.merge('确认要进行划扣指令MQ损坏后的补偿吗？');
			AOS.confirm(msg,function(btn){
				if (btn === 'cancel') {
 					AOS.tip('启用操作被取消。');
 					return;
 				}
				AOS.ajax({
					url : 'accountengineService.pushChargebackOrderToMQ',
					ok : function(data) {
						AOS.tip('划扣指令MQ损坏后的补偿刷新成功');
					}
				});
			});
		}
		
		
		
		//待划扣补偿
		function fn_button_operation_render(value, metaData, record, rowIndex, colIndex, store) {
			
			if((record.data.location_=='1')){
				return '<input type="button" value="补偿" class="cbtn" onclick="_btn_order_onclick();" /> <input type="button" value="扣款队列补偿" class="cbtn" onclick="_btn_pay_onclick();" /> ';
			}
			
		}
		
	//待受理补偿	
	function fn_button_routed(value, metaData, record, rowIndex, colIndex, store) {
		return '<input type="button" value="补偿" class="cbtn" onclick="_btn_routed_onclick();" /> ';
	}
		
	</script>
</aos:onready>

<script type="text/javascript">
	function _btn_order_onclick() {
		var msg = AOS.merge('确认要进行划扣指令补偿吗？');
		var rec = AOS.selectone(Ext.getCmp('_g_loan'));
		AOS.confirm(msg,function(btn){
			if (btn === 'cancel') {
					AOS.tip('启用补偿操作被取消。');
					return;
			}
			AOS.ajax({ 
				params : {
					location_:rec.data.location_,
					id_: rec.data.id_
				},
				url : 'accountengineService.pushChargebackOrderToMQByOne',
				ok : function(data) {
					AOS.tip('划扣指令MQ损坏后的补偿刷新成功！');
					Ext.getCmp('_g_loan').getStore().reload();
				}
			});
		});
	}
	
	function _btn_pay_onclick() {
		var msg = AOS.merge('确认要进行扣款队列的补偿吗？');
		var rec = AOS.selectone(Ext.getCmp('_g_loan'));
		AOS.confirm(msg,function(btn){
			if (btn === 'cancel') {
					AOS.tip('启用补偿操作被取消。');
					return;
			}
			AOS.ajax({ 
				params : {
					id_: rec.data.id_
				},
				url : 'accountengineService.pushChargebackOrderToMQById',
				ok : function(data) {
					AOS.tip('扣款队列补偿刷新成功！');
					Ext.getCmp('_g_loan').getStore().reload();
				}
			});
		});
	}
	
	
	function _btn_routed_onclick() {
		var msg = AOS.merge('确认要进行划扣受理补偿吗？');
		var rec = AOS.selectone(Ext.getCmp('_g_param'));
		AOS.confirm(msg,function(btn){
			if (btn === 'cancel') {
					AOS.tip('启用补偿操作被取消。');
					return;
			}
			AOS.ajax({ 
				params : {
					id_: rec.data.id_
				},
				url : 'accountengineService.pushChargebackWaitRoutedById',
				ok : function(data) {
					AOS.tip('划扣受理补偿刷新成功！');
					Ext.getCmp('_g_param').getStore().reload();
				}
			});
		});
	}
	
</script>

