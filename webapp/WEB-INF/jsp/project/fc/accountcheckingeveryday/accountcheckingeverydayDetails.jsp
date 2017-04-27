<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="对账明细" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:hiddenfield name="acceptID" id="acceptID" value="${acceptID}" />
		<aos:hiddenfield name="type_" id="type_" value="${type_}" />
		<aos:formpanel id="_f_counts" layout="column" autoScroll="true" region="north" height="160" onrender="_f_query">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="对账摘要" />
			</aos:docked>
			<aos:textfield name="third_channel_id_"  fieldLabel="对账渠道" readOnly="true" columnWidth="0.33" />
			<aos:textfield name="reconciliation_date_"  fieldLabel="对账日期" readOnly="true" columnWidth="0.33" />
			<aos:textfield name="status_" fieldLabel="对账状态" readOnly="true" columnWidth="0.33" />
			<aos:textfield name="today_order_counts_"  fieldLabel="当日订单笔数" readOnly="true" columnWidth="0.33" />
			<%-- <aos:dockeditem id="btn_export" text="导出Excel" icon="icon70.png" onclick="fn_exportexcel()" columnWidth="0.09"/> --%>
			<aos:textfield name="succeed_counts_" fieldLabel="对账成功笔数" readOnly="true" columnWidth="0.33" />
			<aos:textfield name="only_our_side_counts_" fieldLabel="我方单边笔数" readOnly="true" columnWidth="0.33" />
			<aos:textfield name="unbalance_counts_" fieldLabel="对账金额不同笔数" readOnly="true" columnWidth="0.33" />
			<aos:textfield name="only_third_side_counts_"  fieldLabel="第三方单边笔数" readOnly="true" columnWidth="0.33" />
			<aos:textfield name="patch_before_counts_"  fieldLabel="补录前日笔数" readOnly="true" columnWidth="0.33" />
			<aos:textfield name="our_sumtrans_amount"  fieldLabel="我方成功金额" readOnly="true" columnWidth="0.33" />
			<aos:textfield name="they_sumtrans_amount"  fieldLabel="三方成功金额" readOnly="true" columnWidth="0.33" />
		</aos:formpanel>
		
		<aos:formpanel  layout="column" columnWidth="1"  region="north" border="false" id="_g_org_result" >
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
<%-- 				<aos:combobox fieldLabel="对账结果" name="result_"  dicField="reconciliation_result_" dicFilter="1,2,3,4"  editable="false" columnWidth="0.20" />	 --%>
				<aos:combobox  fieldLabel="对账结果" name="result_" value="0" columnWidth="0.33">
					<aos:option value="" display="全部" />
					<aos:option value="5" display="对账异常" />
					<aos:option value="1" display="我方单边" />
					<aos:option value="2" display="第三方单边" />
					<aos:option value="3" display="金额不平" />
					<aos:option value="4" display="对账成功" />
					
				</aos:combobox>
				
				<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem text="查询" icon="query.png" onclick="_g_org_query"/>
					<aos:dockeditem text="重置" onclick="AOS.reset(_g_org_result);" icon="refresh.png" />
					<aos:dockeditem text="导出Excel" id="btn_export" icon="icon70.png" onclick="fn_exportexcel" /> 
					<aos:dockeditem xtype="tbfill" />
			    </aos:docked>	
		</aos:formpanel>
		
		<aos:tabpanel id="id_tabpanel" region="center" activeTab="0" bodyBorder="0 0 0 0" tabBarHeight="30">
			<aos:tab title="当日订单" id="_tab_org" layout="border">
				<aos:gridpanel id="_g_org" url="accountCheckingEverydayService.reconciliationDetails" onrender="_g_org_query" region="center" forceFit="false">
					<aos:column type="rowno" />
					<aos:column header="对账明细id" align="center" hidden="true" dataIndex="id_"/>	
					<aos:column header="指令ID" align="center" hidden="true" dataIndex="order_id_"/>
					<aos:column header="对账ID" dataIndex="reconciliation_id_" width="50" align="center"/>
					<aos:column header="对账类型" align="center" dataIndex="type_" width="90" rendererField="reconciliation_type_" celltip="true"/>
					<aos:column header="对账结果" dataIndex="result_"  width="90" rendererField="reconciliation_result_" align="center"  celltip="true"/>
					<aos:column header="我方订单号" dataIndex="our_order_id_" celltip="true" rendererField="target_value_" width="200" align="center"/>
					<aos:column header="我方订单发起时间" dataIndex="our_sent_time_" width="150" align="center"  celltip="true"/>
					<aos:column header="我方交易金额" dataIndex="our_trans_amount_" width="100" align="center" />
					<aos:column header="我方手续费" dataIndex="our_third_channel_fee_" width="90" align="center"/>
					<aos:column header="第三方订单号" dataIndex="they_order_id_" width="200" align="center"  celltip="true"/>
					<aos:column header="第三方订单清结算时间" dataIndex="they_settled_time_" width="150" align="center" celltip="true"/>
					<aos:column header="第三方交易金额" dataIndex="they_trans_amount_" width="110" align="center"/>
					<aos:column header="第三方手续费" dataIndex="they_third_channel_fee_" width="110" align="center"/>
					<aos:column header="财务人员干涉状态" dataIndex="interference_status_" rendererField="interference_status_" width="110" align="center" />
					<aos:column header="操作" align="center" fixedWidth="200" rendererFn="fn_button" />
				</aos:gridpanel>
				
				
			<aos:window id="_w_account" title="干涉差错账" onshow="_w_account_onshow" >
				<aos:formpanel id="_f_account" width="450" layout="anchor" labelWidth="90">
					<aos:hiddenfield name="id_" />
					<aos:combobox name="error_reason" fieldLabel="差错原因" dicField="error_reason" allowBlank="false" />
					<aos:textareafield name="error_description" fieldLabel="差错原因详述" />
					<aos:textfield name="correction_person" fieldLabel="纠错负责人" allowBlank="false" />
					<aos:textareafield name="correction_solution" fieldLabel="纠错方案" />
					<aos:textareafield name="remark" fieldLabel="干涉备注" />
				</aos:formpanel>
				<aos:docked dock="bottom" ui="footer">
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem onclick="_f_account_save" text="执行干涉" icon="ok.png" />
					<aos:dockeditem onclick="#_w_account.hide();" text="取消" icon="close.png" />
				</aos:docked>
		</aos:window>
		
		<aos:window id="_w_accountquery" title="干涉结果" onshow="_w_account_query">
				<aos:formpanel id="_f_accountquery" width="450" layout="anchor" labelWidth="90" >
					<aos:hiddenfield name="id_" />
					<aos:textfield name="error_reason" fieldLabel="差错原因" allowBlank="false" />
					<aos:textareafield name="error_description" fieldLabel="差错原因详述" />
					<aos:textfield name="correction_person" fieldLabel="纠错负责人" allowBlank="false" />
					<aos:textareafield name="correction_solution" fieldLabel="纠错方案" />
					<aos:textareafield name="remark" fieldLabel="干涉备注" />
				</aos:formpanel>
		</aos:window>
		
		
			</aos:tab>

			<aos:tab title="补录前日" id="_tab_param" onactivate="_g_param_query" layout="border">
				<aos:gridpanel id="_g_param" url="accountCheckingEverydayService.formerReconciliationDetailsPage"
					pageSize="20" region="center" forceFit="false">
					<aos:column type="rowno" />
					<aos:column header="对账明细id" align="center" hidden="true" dataIndex="id_"/>
					<aos:column header="对账类型" align="center" hidden="true" dataIndex="type_" rendererField="reconciliation_type_"/>
					<aos:column header="指令ID" align="center" hidden="true" dataIndex="order_id_"/>
					<aos:column header="对账ID" dataIndex="reconciliation_id_" width="110" align="center"/>
					<aos:column header="补录账期" dataIndex="reconciliation_date_" width="100" align="center" celltip="true"/>
					<aos:column header="对账结果" dataIndex="result_"  width="100" rendererField="reconciliation_result_" align="center" celltip="true"/>
					<aos:column header="我方订单号" dataIndex="our_order_id_" width="200" align="center" celltip="true"/>
					<aos:column header="我方订单发起时间" dataIndex="our_sent_time_" width="140" align="center" celltip="true"/>
					<aos:column header="我方交易金额" dataIndex="our_trans_amount_" width="100" align="center"/>
					<aos:column header="我方手续费" dataIndex="our_third_channel_fee_" width="100" align="center"/>
					<aos:column header="第三方订单号" dataIndex="they_order_id_" width="200" align="center"/>
					<aos:column header="第三方订单清结算时间" dataIndex="they_settled_time_" width="140" align="center" celltip="true"/>
					<aos:column header="第三方交易金额" dataIndex="they_trans_amount_" width="100" align="center"/>
					<aos:column header="第三方手续费" dataIndex="they_third_channel_fee_" width="100" align="center"/>
					<aos:column header="财务人员干涉状态" dataIndex="interference_status_" rendererField="interference_status_" width="100" align="center"/>
					<aos:column header="操作" align="center" fixedWidth="200" rendererFn="fn_button_supply" />
				</aos:gridpanel>
			</aos:tab>
			
			<!-- 补录昨日干涉情况 -->
			<aos:window id="_w_account_supply" title="干涉差错账" onshow="_w_account_onshow_supply" >
				<aos:formpanel id="_f_account_supply" width="450" layout="anchor" labelWidth="90">
					<aos:hiddenfield name="id_" />
					<aos:combobox name="error_reason" fieldLabel="差错原因" dicField="error_reason" allowBlank="false" />
					<aos:textareafield name="error_description" fieldLabel="差错原因详述" />
					<aos:textfield name="correction_person" fieldLabel="纠错负责人" allowBlank="false" />
					<aos:textareafield name="correction_solution" fieldLabel="纠错方案" />
					<aos:textareafield name="remark" fieldLabel="干涉备注" />
				</aos:formpanel>
				<aos:docked dock="bottom" ui="footer">
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem onclick="_f_account_save_supply" text="执行干涉" icon="ok.png" />
					<aos:dockeditem onclick="#_w_account_supply.hide();" text="取消" icon="close.png" />
				</aos:docked>
		</aos:window>
		<!-- 补录昨日干涉情况 -->
		<aos:window id="_w_accountquery_supply" title="干涉结果" onshow="_w_account_query_supply">
				<aos:formpanel id="_f_accountquery_supply" width="450" layout="anchor" labelWidth="90" >
					<aos:hiddenfield name="id_" />
					<aos:textfield name="error_reason" fieldLabel="差错原因" allowBlank="false" />
					<aos:textareafield name="error_description" fieldLabel="差错原因详述" />
					<aos:textfield name="correction_person" fieldLabel="纠错负责人" allowBlank="false" />
					<aos:textareafield name="correction_solution" fieldLabel="纠错方案" />
					<aos:textareafield name="remark" fieldLabel="干涉备注" />
				</aos:formpanel>
		</aos:window>
		
			
			
			
			<aos:tab title="被后日补录" id="_tab_paramed" onactivate="_g_param_queryed" layout="border">
				<aos:gridpanel id="_g_paramed" url="accountCheckingEverydayService.reconciliationDetailsedPage" pageSize="20" region="center">
					<aos:column type="rowno" />
					<aos:column header="被补录对账ID" dataIndex="reconciliation_detail_id_" width="70" />
					<aos:column header="补录前对账结果" dataIndex="origin_result_" width="70"  rendererField="reconciliation_result_"/>
					<aos:column header="补录后对账结果" dataIndex="next_result_" width="70" rendererField="reconciliation_result_"/>
					<aos:column header="补录来源账期" dataIndex="they_settled_time_" width="70" />
				</aos:gridpanel>
			</aos:tab>
			
		</aos:tabpanel>
		
		
	</aos:viewport>

	<script type="text/javascript">
/* 	function  fn_exportexcel() {
		AOS.ajax({
			params : {
			},
			url : 'accountCheckingEverydayService.exportExcel',
			ok : function(data) {
				alert(1);
			}
		});
	} */
	
	//生成XLS报表
	function fn_exportexcel() {
		AOS.file('do.jhtml?router=accountCheckingEverydayService.exportExcel&juid=${juid}');
	} 
	
 		//对账摘要
		function _f_query() {
			var aId = acceptID.getValue();
			AOS.ajax({
				params : {
					acceptID : aId
				},
				url : 'accountCheckingEverydayService.accountDetail',
				ok : function(data) {
					_f_counts.form.setValues(data);
				}
			});
		} 
		
	
		
		
 		//对账摘要
		function _f_query() {
			var aId = acceptID.getValue();
			AOS.ajax({
				params : {
					acceptID : aId
				},
				url : 'accountCheckingEverydayService.accountDetail',
				ok : function(data) {
					_f_counts.form.setValues(data);
				}
			});
		} 
		
 		
		//窗口弹出事件监听，获取当前行所有数据
		function _w_account_onshow() {
			var record = AOS.selectone(_g_org, true);
         AOS.ajax({
         	params : {
         		id_: record.data.id_
         	},
             url: 'accountCheckingEverydayService.toGetId',
             ok: function (data) {
            	_f_account.form.setValues(data);
            	//_f_accountquery.form.setValues(data);
             }
         });
		}
 		
		
		
		//窗口弹出事件监听，获取当前行所有数据(当前订单)
		function _w_account_onshow() {
			var record = AOS.selectone(_g_org, true);
         AOS.ajax({
         	params : {
         		id_: record.data.id_
         	},
             url: 'accountCheckingEverydayService.toGetId',
             ok: function (data) {
            	_f_account.form.setValues(data);
            	//_f_accountquery.form.setValues(data);
             }
         });
		}
 		
		
		//窗口弹出事件监听，获取当前行所有数据(补录昨日)
		function _w_account_onshow_supply() {
			var record = AOS.selectone(_g_param, true);
         AOS.ajax({
         	params : {
         		id_: record.data.id_
         	},
             url: 'accountCheckingEverydayService.toGetId',
             ok: function (data) {
            	_f_account_supply.form.setValues(data);
            	//_f_accountquery.form.setValues(data);
             }
         });
		}
		
		
		
		
		
		//执行当前订单干涉(新增)
		function _f_account_save(){
			AOS.ajax({
				forms : _f_account,
				url : 'accountCheckingEverydayService.accountAdd',
				ok : function(data) {
					_w_account.hide();
					 AOS.hide();
					 AOS.tip(data.appmsg);
					 AOS.reset(_f_account);
					 Ext.getCmp('_g_org').getStore().reload(); 			 
				}
		});
		}
 			
		//执行补录订单干涉(新增)
		function _f_account_save_supply(){
			AOS.ajax({
				forms : _f_account_supply,
				url : 'accountCheckingEverydayService.accountAdd',
				ok : function(data) {
					_w_account_supply.hide();
					 AOS.hide();
					 AOS.tip(data.appmsg);
					 AOS.reset(_f_account_supply);
					 Ext.getCmp('_g_param').getStore().reload(); 			 
				}
		});
		}
 		
	

		//1当日订单
		function _g_org_query() {
			if (!_tab_org.isVisible()) {
				_tabpanel.setActiveTab(_tab_org);
			}
			var businessId = acceptID.getValue();
			var params = {
				acceptID : '${acceptID}',
				type_: '${type_}',
				result_:_g_org_result.getValues().result_
			};
			_g_org_store.getProxy().extraParams = params;
			_g_org_store.loadPage(1);
		}

		//2补录前日
		function _g_param_query() {
			if (!_tab_param.isVisible()) {
				_tabpanel.setActiveTab(_tab_param);
			}
			var businessId = acceptID.getValue();
			var params = {
					acceptID : businessId
			};
			_g_param_store.getProxy().extraParams = params;
			_g_param_store.loadPage(1);
		}
		
		//3 被后日补录
		function _g_param_queryed() {
			if (!_tab_paramed.isVisible()) {
				_tabpanel.setActiveTab(_tab_paramed);
			}
			var businessId = acceptID.getValue();
			var params = {
					acceptID : businessId
			};
			_g_paramed_store.getProxy().extraParams = params;
			_g_paramed_store.loadPage(1);
		}
		
/* 		function fn_button(value, metaData, record, rowIndex, colIndex, store) {
			if((record.data.interference_status_=='1') ){
				return '<input type="button" value="执行干涉" class="cbtn" onclick="_btn_bankxeset_onclick();" />  <input type="button" value="划扣指令详情" class="cbtn" onclick="_btn_instructionSetDetails_onclick();" />';
			}else if(record.data.interference_status_ == '2'){
				return '<input type="button" value="查看干涉结果" class="cbtn" onclick="fn_update();" />  <input type="button" value="划扣指令详情" class="cbtn" onclick="_btn_instructionSetDetails_onclick();" />' ;
			}
		} */
		
		<!-- 当前订单干涉情况 -->
		function fn_button(value, metaData, record, rowIndex, colIndex, store) {
			if((record.data.interference_status_=='1') && (record.data.type_=='1')){
				return '<input type="button" value="执行干涉" class="cbtn" onclick="_btn_bankxeset_onclick();" />  <input type="button" value="划扣指令详情" class="cbtn" onclick="_btn_instructionSetDetails_onclick_1();" />';
			}else if((record.data.interference_status_=='1') && (record.data.type_=='2')){
				return '<input type="button" value="执行干涉" class="cbtn" onclick="_btn_bankxeset_onclick();" />  <input type="button" value="放款指令详情" class="cbtn" onclick="_btn_instructionSetDetails_onclick_2();" />';
			}else if((record.data.interference_status_ == '2') && (record.data.type_=='1')){
				return '<input type="button" value="查看干涉结果" class="cbtn" onclick="fn_update();" />  <input type="button" value="划扣指令详情" class="cbtn" onclick="_btn_instructionSetDetails_onclick_1();" />' ;
			}else if((record.data.interference_status_ == '2') && (record.data.type_=='2') ){
				return '<input type="button" value="查看干涉结果" class="cbtn" onclick="fn_update();" />  <input type="button" value="放款指令详情" class="cbtn" onclick="_btn_instructionSetDetails_onclick_2();" />' ;		
			}
		}
		
		<!-- 补录昨日干涉情况 -->
		function fn_button_supply(value, metaData, record, rowIndex, colIndex, store) {
			
			if((record.data.interference_status_=='1') && (record.data.type_=='1')){
				return '<input type="button" value="执行干涉" class="cbtn" onclick="_btn_bankxeset_onclick_supply();" />  <input type="button" value="划扣指令详情" class="cbtn" onclick="_btn_instructionSetDetails_onclick_supply_3();" />';
			}else if((record.data.interference_status_=='1') && (record.data.type_=='2')){
				return '<input type="button" value="执行干涉" class="cbtn" onclick="_btn_bankxeset_onclick_supply();" />  <input type="button" value="放款指令详情" class="cbtn" onclick="_btn_instructionSetDetails_onclick_supply_4();" />';
			}else if((record.data.interference_status_ == '2') && (record.data.type_=='1')){
				return '<input type="button" value="查看干涉结果" class="cbtn" onclick="fn_update_supply();" />  <input type="button" value="划扣指令详情" class="cbtn" onclick="_btn_instructionSetDetails_onclick_supply_3();" />' ;
			}else if((record.data.interference_status_ == '2') && (record.data.type_=='2') ){
				return '<input type="button" value="查看干涉结果" class="cbtn" onclick="fn_update_supply();" />  <input type="button" value="放款指令详情" class="cbtn" onclick="_btn_instructionSetDetails_onclick_supply_4();" />' ;		
			}
		}
		
		
		//查看当前订单干涉结果
		function _w_account_query() {
			var record = AOS.selectone(_g_org, true);
	        AOS.ajax({
	        	params : {
	        		reconciliation_detail_id_: record.data.id_
	        	},
	            url: 'accountCheckingEverydayService.accountDetailquery',
	            ok: function (data) {
	            	_f_accountquery.form.setValues(data);
	            }
	        });
		} 
		
		
		//查看当前补录订单干涉结果
		function _w_account_query_supply() {
			var record = AOS.selectone(_g_param, true);
	        AOS.ajax({
	        	params : {
	        		reconciliation_detail_id_: record.data.id_
	        	},
	            url: 'accountCheckingEverydayService.accountDetailquery',
	            ok: function (data) {
	            	_f_accountquery_supply.form.setValues(data);
	            }
	        });
		} 
		
		
/* 		//加载表格数据
		//1 加载
	function _g_org_query() {
		var acceptID = acceptID.getValue();
		var params = {
				acceptID : acceptID,
				
				};
		alert(params);
		_g_org_store.getProxy().extraParams = params;
		_g_org_store.loadPage(1);
	}
		 */
		
	</script>
	

</aos:onready>
<script type="text/javascript">
	function _btn_bankxeset_onclick() {
		Ext.getCmp('_w_account').show();
	}
	
	
	function fn_update() {
		Ext.getCmp('_w_accountquery').show();
	}
	
	
	function _btn_bankxeset_onclick_supply() {
		Ext.getCmp('_w_account_supply').show();
	}
	
	
	function fn_update_supply() {
		Ext.getCmp('_w_accountquery_supply').show();
	}
	
	
	
	function _btn_instructionSetDetails_onclick_1() {
		var rec = AOS.selectone(Ext.getCmp('_g_org'));
		var order_id_ = rec.data.order_id_;
		if(order_id_ ==null || order_id_ ==""){
			 AOS.tip('第三方单边数据，没有对应的指令ID');
	            return;
		}
		parent.fnaddtab('chargebackPayService.orderDetail&chargeback_order_id_=' + order_id_, '划扣指令'+order_id_+'的详情', order_id_);
		//var our_order_id_ = rec.data.our_order_id_;
		//parent.fnaddtab('accountCheckingEverydayService.instructionSetDetails&our_order_id_=' + our_order_id_, '划扣指令详情'+our_order_id_, our_order_id_);
	}
	
	function _btn_instructionSetDetails_onclick_2() {
		var rec = AOS.selectone(Ext.getCmp('_g_org'));
		var acceptedID = rec.data.order_id_;
		if(acceptedID ==null || acceptedID ==""){
			 AOS.tip('第三方单边数据，没有对应的指令ID');
	            return;
		}
		parent.fnaddtab('loanAcceptService.loanacceptAcceptDetails&acceptedID=' + acceptedID, '放款受理指令详情'+acceptedID, acceptedID);
	}
	
	
	
	function _btn_instructionSetDetails_onclick_supply_1() {
		var rec = AOS.selectone(Ext.getCmp('_g_param'));
		var order_id_ = rec.data.order_id_;
		if(order_id_ ==null || order_id_ ==""){
			 AOS.tip('第三方单边数据，没有对应的指令ID');
	            return;
		}
		parent.fnaddtab('chargebackPayService.orderDetail&chargeback_order_id_=' + order_id_, '划扣指令'+order_id_+'的详情', order_id_);
		//var our_order_id_ = rec.data.our_order_id_;
		//parent.fnaddtab('accountCheckingEverydayService.instructionSetDetails&our_order_id_=' + our_order_id_, '划扣指令详情'+our_order_id_, our_order_id_);
	}
	
	function _btn_instructionSetDetails_onclick_supply_2() {
		var rec = AOS.selectone(Ext.getCmp('_g_param'));
		var acceptedID = rec.data.order_id_;
		if(acceptedID ==null || acceptedID ==""){
			 AOS.tip('第三方单边数据，没有对应的指令ID');
	            return;
		}
		parent.fnaddtab('loanAcceptService.loanacceptAcceptDetails&acceptedID=' + acceptedID, '放款受理指令详情'+acceptedID, acceptedID);
	}
	
	
// 	##################################
	
	function _btn_instructionSetDetails_onclick_3() {
		var rec = AOS.selectone(Ext.getCmp('_g_param'));
		var order_id_ = rec.data.order_id_;
		parent.fnaddtab('chargebackPayService.orderDetail&chargeback_order_id_=' + order_id_, '划扣指令'+order_id_+'的详情', order_id_);
	}
	
	function _btn_instructionSetDetails_onclick_4() {
		var rec = AOS.selectone(Ext.getCmp('_g_param'));
		var acceptedID = rec.data.order_id_;
		parent.fnaddtab('loanAcceptService.loanacceptAcceptDetails&acceptedID=' + acceptedID, '放款受理指令详情'+acceptedID, acceptedID);
	}
	
	
	
	function _btn_instructionSetDetails_onclick_supply_3() {
		var rec = AOS.selectone(Ext.getCmp('_g_param'));
		var order_id_ = rec.data.order_id_;
		parent.fnaddtab('chargebackPayService.orderDetail&chargeback_order_id_=' + order_id_, '划扣指令'+order_id_+'的详情', order_id_);
	}
	
	function _btn_instructionSetDetails_onclick_supply_4() {
		var rec = AOS.selectone(Ext.getCmp('_g_param'));
		var acceptedID = rec.data.order_id_;
		parent.fnaddtab('loanAcceptService.loanacceptAcceptDetails&acceptedID=' + acceptedID, '放款受理指令详情'+acceptedID, acceptedID);
	}
	
</script>




