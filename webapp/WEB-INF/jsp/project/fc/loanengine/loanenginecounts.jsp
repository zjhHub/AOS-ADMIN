<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="监控放款引擎" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="fit">

		<aos:panel layout="border" border="false">  
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="监控放款引擎" />
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="刷新监控数据" icon="refresh.png" onclick="_g_d_b_refresh" />
			</aos:docked>

            <aos:panel region="north" border="false">
			<aos:formpanel id="_f_query" layout="column" labelWidth="150" header="false" border="false">
				<aos:docked forceBoder="0 0 1 0">
					<aos:dockeditem xtype="tbtext" text="划扣受理监控" />
					<aos:dockeditem xtype="tbfill" />
					<%-- <aos:dockeditem text="MQ损坏后的补偿" onclick="f_chargeback_accepted_" /> --%>
				</aos:docked>
				<aos:textfield fieldLabel="待发的划扣受理指令数" name="rows1" readOnly="true" columnWidth="0.2" value="${rows1}"/>
				<aos:textfield fieldLabel="在途的划扣受理指令数" name="rows2" readOnly="true" columnWidth="0.2" value="${rows2}"/>
				<aos:textfield fieldLabel="已处理划扣受理指令数" name="rows3" readOnly="true" columnWidth="0.2" value="${rows3}"/>
				<aos:textfield fieldLabel="已反馈划扣受理指令数" name="rows4" readOnly="true" columnWidth="0.2" value="${rows4}"/>
				<aos:textfield fieldLabel="超时的划扣受理指令数" name="rows5" readOnly="true" columnWidth="0.2" value="${rows5}"/>
			</aos:formpanel>
			</aos:panel>
			
			<aos:formpanel layout="column" columnWidth="150" region="north" border="false" id="_loan">
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="查询条件" />
				</aos:docked>
				<aos:combobox  fieldLabel="所在位置" name="location_" value="0" columnWidth="0.33">
					<aos:option value="" display="全部" />
					<aos:option value="1" display="待发指令库" />
					<aos:option value="2" display="在途指令库" />
				</aos:combobox>
				<aos:textfield fieldLabel="订单编号" name="third_channel_order_id_" emptyText="填写订单编号" columnWidth="0.34" />
				
				<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
					<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
					<aos:dockeditem xtype="tbfill" />
				</aos:docked>
			</aos:formpanel>
			
			<aos:gridpanel id="_g_loan" url="loanengineService.fcLoanAccOrderPage" onrender="_g_loan_query"  autoScroll="true" region="center">
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbtext" text="划扣受理条件列表" />
					<aos:dockeditem xtype="tbseparator" />
				</aos:docked>
				<aos:column type="rowno" />
				<aos:column header="id_" dataIndex="id_" width="80" align="center"/>
				<aos:column header="三方支付渠道编码" dataIndex="routed_third_channel_code_" width="80" align="center"/>
				<aos:column header="三方路由去向" dataIndex="routed_third_channel_name" width="80" align="center"/>
				<aos:column header="订单号" dataIndex="third_channel_order_id_" width="80" align="center"/>
				<aos:column header="业务摘要" dataIndex="biz_summary" width="80" align="center"/>
				<aos:column header="放款金额" dataIndex="loan_amount_" width="80" align="center"/>
				<aos:column header="银行编码" dataIndex="bank_code_" width="80" align="center"/>
				<aos:column header="放款账号" dataIndex="loan_account_" width="80" align="center"/>
				<aos:column header="放款账号户主姓名" dataIndex="loan_name_" width="80" align="center"/>
				<aos:column header="放款账号户主身份证" dataIndex="loan_idcard_" width="80" align="center"/>
				<aos:column header="放款账号预留手机" dataIndex="loan_cellphone_" width="80" align="center"/>
				<aos:column header="操作" align="center" fixedWidth="80" rendererFn="fn_bt_buchang" />
		  </aos:gridpanel>
		</aos:panel>
		
		
	</aos:viewport>

	<script type="text/javascript">
		function _g_d_b_refresh() {
			window.location.href = 'do.jhtml?router=loanengineService.init&juid=${juid}';
		}
		
		//重置 
		function _loan_reset() {
			AOS.reset(_loan);
		}
		
		function _g_loan_query() {
			var params = _loan.getValues();
			_g_loan_store.getProxy().extraParams = params;
			_g_loan_store.loadPage(1);
		}
		
		function fn_bt_buchang(value, metaData, record, rowIndex, colIndex,store) {
			if (record.data.id_ == '${id_}') {
				return '--';
			} else {
				return '<input type="button" value="补偿" class="cbtn" onclick="_btn_chargebackaccept_onclick();" />';
			}
		}
		/* function f_chargeback_accepted_() {
			//将划扣受理库中的所有待路由的指令重新发送到mq中
			var msg = AOS.merge('确认要进行MQ损坏后的补偿吗？');
			AOS.confirm(msg,function(btn){
				if (btn === 'cancel') {
 					AOS.tip('启用操作被取消。');
 					return;
 				}
				AOS.ajax({
					url : 'loanengineService.pushcceptedOrderToMQ',
					ok : function(data) {
						AOS.tip('MQ损坏后的补偿刷新成功');
					}
				});
			});
		} */
	</script>
</aos:onready>
	<script type="text/javascript">
		function _btn_chargebackaccept_onclick() {
			var msg = AOS.merge('确认要进行划扣指令MQ损坏后的补偿吗？');
			var record = AOS.selectone(Ext.getCmp('_g_loan'));
			var orderId = record.data.third_channel_order_id_;
			AOS.confirm(msg,function(btn){
				if (btn === 'cancel') {
					AOS.tip('补偿操作被取消。');
					return;
				}
				AOS.ajax({
					params : {
						id_: record.data.id_
					},
					url : 'loanengineService.updateAcceptOrders',
					ok : function(data) {
						AOS.tip(data.appmsg);
						Ext.getCmp('_g_loan').getStore().reload();
						getResetLocation();
					}
				});
			});
		}
		
		function getResetLocation(){
			AOS.ajax({
				url : 'loanengineService.getResetLocation',
				ok : function(data) {
					AOS.setValues(Ext.getCmp('_f_query'),data);
				}
			});
		}
		
	</script>


