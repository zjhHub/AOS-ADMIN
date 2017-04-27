<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="配置第三方支付渠道" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:gridpanel id="_g_loan" url="disposedThreePayService.threePayListPage"
			onrender="_g_loan_query" pageSize="30" autoScroll="true"
			region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="现有支持的第三方支付渠道列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />

			<aos:column dataIndex="id_" hidden="true" header="第三方支付渠道ID"
				width="30" />
			<aos:column header="第三方支付渠道名称" dataIndex="name_" celltip="true"
				width="30" />
			<aos:column header="第三方支付渠道编号" dataIndex="code_" width="30" />
			<aos:column header="路由优先级" dataIndex="route_priority" width="30" />
			<aos:column header="每日许可划扣失败的次数" dataIndex="failure_permission_times_" width="30" />
			<aos:column header="每日许可划扣成功的次数" dataIndex="success_permission_times_" width="30" />
			<aos:column header="操作" align="center" fixedWidth="350"
				rendererFn="fn_bt_loanDedail" />
		</aos:gridpanel>
	</aos:viewport>
	
	<aos:window id="_w_req" title="" onshow="showbankinfo" width="940" height="410">
			<aos:gridpanel id="_g_loan1" url="disposedThreePayService.bankListPage" region="center" pageSize="10" autoScroll="true">
				<aos:column type="rowno" />
				<aos:docked forceBoder="1 0 1 0">
					<aos:dockeditem xtype="tbseparator" />
					<aos:dockeditem text="新增银行信息" icon="add.png" onclick="#w_add_bank_.show();" />
				</aos:docked>
				<aos:column dataIndex="id_" hidden="true" header="ID" width="30" />
				<aos:column dataIndex="bank_id_" hidden="true" header="银行ID" width="30" />
				<aos:column dataIndex="third_channel_id_" hidden="true" header="第三方ID" width="30" />
				<aos:column header="银行名称" dataIndex="full_name_" width="30" />
				<aos:column header="银行在第三方支付的编码" dataIndex="third_channel_bank_code_" width="60" />
				<aos:column header="单笔划扣额度上限" dataIndex="single_chargeback_max_limit_" width="50" />
				<aos:column header="单日划扣额度上限" dataIndex="single_date_max_limit_" width="50" />
				<aos:column header="是否可用" dataIndex="is_enabled_" width="40" />
				<aos:column header="操作" align="center" fixedWidth="80" rendererFn="fn_bt_loanDedail2" />
			</aos:gridpanel>
			<aos:docked dock="bottom" ui="footer">
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem onclick="#_w_req.hide();" text="关闭" icon="close.png" />
			</aos:docked>
	</aos:window>
	
	<!--新增银行信息 -->
	<aos:window id="w_add_bank_" title="新增银行信息" width="500" height="250" onshow="showaddbank">
			<aos:formpanel id="f_add_bank" layout="column" autoScroll="true" labelWidth="150" >
				<aos:hiddenfield fieldLabel="第三方渠道id" name="id_" />
				<aos:combobox name="full_name_" fieldLabel="银行全称"  editable="false" columnWidth="0.8" url="disposedThreePayService.bankList" />
				<aos:combobox name="bank_code_" fieldLabel="银行编码"  editable="false" columnWidth="0.8" url="disposedThreePayService.bankcodeList" />
				<aos:textfield name="third_channel_bank_code_" fieldLabel="银行简称" emptyText="如：CCB" columnWidth="0.8" allowBlank="false"/>
				<aos:textfield name="single_chargeback_max_limit_" fieldLabel="单笔划扣额度上限" columnWidth="0.8" allowBlank="false"/>
				<aos:textfield name="single_date_max_limit_" fieldLabel="单日划扣额度上限" columnWidth="0.8" allowBlank="false"/>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="fn_add_bank" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#w_add_bank_.hide();" text="关闭" icon="close.png" />
			</aos:docked>
	</aos:window>
	
	
	
	<aos:window id="bankset" title="" onshow="showbankset" width="940" height="410">
			<aos:formpanel id="req_info" layout="column" autoScroll="true">
			 	<aos:fieldset title="当前限额及可用状态" labelWidth="170" columnWidth="1" margin="0 10 0 0">
					<aos:textfield name="single_chargeback_max_limit_" fieldLabel="单笔划扣额度上限" maxLength="50" readOnly="true" columnWidth="0.5" />
					<aos:textfield name="single_date_max_limit_" fieldLabel="单日划扣额度上限" readOnly="true" columnWidth="0.44" />
					<aos:textfield name="is_enabled_" fieldLabel="是否可用" readOnly="true" columnWidth="0.5" />
				</aos:fieldset>
				
				<aos:fieldset title="设置新限额及可用状态" labelWidth="170" columnWidth="1" margin="0 10 0 0">
					<aos:hiddenfield fieldLabel="ID" name="id_" />
					<aos:numberfield name="single_chargeback_max_limit_new" fieldLabel="单笔划扣额度上限" columnWidth="0.49" />
					<aos:numberfield name="single_date_max_limit_new" fieldLabel="单日划扣额度上限" columnWidth="0.5" />
					<aos:combobox name="is_enabled_new" fieldLabel="是否可用" dicField="is_" value="1" columnWidth="0.49" />
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="bankinfosave" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#bankset.hide();" text="关闭" icon="close.png" />
			</aos:docked>
	</aos:window>
	
	<aos:window id="priorityallow" title="" onshow="showpriority" width="1240" height="410">
			<aos:formpanel id="pri_info" layout="column" autoScroll="true">
			 	<aos:fieldset title="当前优先级与许可" labelWidth="170" columnWidth="1" margin="0 10 0 0">
					<aos:textfield name="failure_permission_times_" fieldLabel="每日许可的划扣失败次数" maxLength="50"
						readOnly="true" columnWidth="0.5" />
					<aos:textfield name="success_permission_times_" fieldLabel="每日许可的划扣成功次数" readOnly="true" columnWidth="0.44" />
					<aos:textfield name="route_priority" fieldLabel="优先级（越大越高）" readOnly="true" columnWidth="0.5" />
				</aos:fieldset>
				
				<aos:fieldset title="设置新限额及可用状态" labelWidth="170" columnWidth="1" margin="0 10 0 0">
					<aos:hiddenfield fieldLabel="ID" name="id_" />
					<aos:numberfield name="failure_permission_times__new" fieldLabel="每日许可的划扣失败次数" columnWidth="0.49" />
					<aos:numberfield name="success_permission_times__new" fieldLabel="每日许可的划扣成功次数" columnWidth="0.5" />
					<aos:numberfield name="route_priority_new" fieldLabel="优先级（越大越高）" columnWidth="0.5" />
				</aos:fieldset>
			</aos:formpanel>
			<aos:docked dock="bottom" ui="footer">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem onclick="priorityinfosave" text="保存" icon="ok.png" />
				<aos:dockeditem onclick="#priorityallow.hide();" text="关闭" icon="close.png" />
			</aos:docked>
	</aos:window>

	<aos:window id="flatInfo" title="" layout="border" onshow="showflatinfo" width="640" height="430">
		<aos:gridpanel id="fiel_flat" title="" hidePagebar="true" region="center" url="disposedThreePayService.flatSetList">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="新增业务线" icon="add.png" onclick="#addFlat.show();" />
			</aos:docked>
			<aos:column header="配置Id" dataIndex="id_" hidden="true" />
			<aos:column header="业务线名称" dataIndex="name_"/>
			<aos:column header="操作" rendererFn="fn_bt_flatset" />
		</aos:gridpanel>
	</aos:window>
	
	<%-- 新增窗口 --%>
	<aos:window id="addFlat" title="新增业务线">
		<aos:formpanel id="_f_account" width="450" border="false" layout="anchor" >
			<aos:hiddenfield name="id_" fieldLabel="第三方ID"/>
			<aos:combobox fieldLabel="业务线名称" allowBlank="false" columnWidth="0.33" name="name_" url="disposedThreePayService.queryFlatCombobox" />
		</aos:formpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="_f_flat_save" text="保存" icon="ok.png" />
			<aos:dockeditem onclick="#addFlat.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	</aos:window>
	

	<script type="text/javascript">
		//窗口弹出事件监听
		function showbankinfo(){
			var record = AOS.selectone(_g_loan, true);
			var param = {
				third_channel_id_ : record.data.id_
			};
			_g_loan1_store.getProxy().extraParams=param;
			_g_loan1_store.loadPage(1);
			_w_req.setTitle('<span class="app-container-title-normal">'+ record.data.name_ +'的银行及限额调配'+ '</span>');
		}
		
		function showbankset() {
			var record2 = AOS.selectone(_g_loan1, true);
			bankset.setTitle('<span class="app-container-title-normal">设置'+record2.data.full_name_+'的限额</span>');
			AOS.ajax({
				params : {
					third_channel_id_ : record2.data.third_channel_id_,
					bank_id_ : record2.data.bank_id_
				},
				url : 'disposedThreePayService.thirdBankInfo',
				ok : function(data) {
					AOS.reset(req_info);
					req_info.form.setValues(data);
				}
			});
		}
		
		function showpriority() {
			var record3 = AOS.selectone(_g_loan, true);
			priorityallow.setTitle('<span class="app-container-title-normal">'+record3.data.name_+'的优先级与许可</span>');
			AOS.ajax({
				params : {
					id_ : record3.data.id_
				},
				url : 'disposedThreePayService.thirdPriorityInfo',
				ok : function(data) {
					AOS.reset(pri_info);
					pri_info.form.setValues(data);
				}
			});
		}
		
		function showflatinfo() {
			var record4 = AOS.selectone(_g_loan, true);
			var param = {
					third_channel_id_ : record4.data.id_
				};
			fiel_flat_store.getProxy().extraParams=param;
			fiel_flat_store.loadPage(1);
			_f_account.loadRecord(record4);
			flatInfo.setTitle('<span class="app-container-title-normal">'+record4.data.name_+'的业务线配置</span>');
			fiel_flat.setTitle('<span class="app-container-title-normal">可使用'+record4.data.name_+'的业务线</span>');			
		}
		
		//限额修改数据
		function bankinfosave(){
				AOS.ajax({
				forms : req_info,
				url : 'disposedThreePayService.updateThirdBankInfo',
				ok : function(data) {
					if(data.appcode == '1'){
						bankset.hide();
						_g_loan1_store.reload();
						AOS.tip(data.appmsg);
					}else{
						AOS.err(data.appmsg);
					}
				}
			});
		}
		
		//3th-pay优先级修改数据
		function priorityinfosave(){
				AOS.ajax({
				forms : pri_info,
				url : 'disposedThreePayService.updateThirdPriAllow',
				ok : function(data) {
					if(data.appcode == '1'){
						priorityallow.hide();
						_g_loan_store.reload();
						AOS.tip(data.appmsg);
					}else{
						AOS.err(data.appmsg);
					}
				}
			});
		}
		
		//新增业务线
		function _f_flat_save(){
				AOS.ajax({
					forms : _f_account,
					url : 'disposedThreePayService.saveFlatInfo',
					ok : function(data) {
						if(data.appcode == '1'){
							 AOS.tip(data.appmsg);
							 fiel_flat_store.reload();
							 addFlat.hide();
						}else{
							AOS.err(data.appmsg);
						}
						
					}
			});
		}
		
		
		
		function showaddbank() {
			var record5 = AOS.selectone(_g_loan, true);
			priorityallow.setTitle('<span class="app-container-title-normal">'+record5.data.name_+'的优先级与许可</span>');
			AOS.ajax({
				params : {
					id_ : record5.data.id_
				},
				url : 'disposedThreePayService.thirdPriorityInfo',
				ok : function(data) {
					AOS.reset(f_add_bank);
					f_add_bank.form.setValues(data);
				}
			});
		}
		
		//新增银行信息
		function fn_add_bank(){
// 			var record = AOS.selectone(_g_loan);
// 			AOS.setValue('f_add_bank.third_channel_id_',record.data.id_);
				AOS.ajax({
					forms : f_add_bank,
					url : 'disposedThreePayService.addThirdBank',
					ok : function(data) {
						 AOS.tip(data.appmsg);
						 _g_loan1_store.reload();
						 w_add_bank_.hide();
					}
			});
		}
	
		//加载表格数据
		function _g_loan_query() {
			_g_loan_store.getProxy().extraParams = {};
			_g_loan_store.loadPage(1);
		}
		
		function fn_bt_loanDedail(value, metaData, record, rowIndex, colIndex,
				store) {
			if (record.data.id_ == '${id_}') {
				return '--';
			} else {
				return '<input type="button" value="银行限额调配" class="cbtn" onclick="_btn_bankxeset_onclick();" />  <input type="button" value="业务线配置" class="cbtn" onclick="_btn_flatset_onclick1();" />  <input type="button" value="优先级与许可" class="cbtn" onclick="_btn_priallow_onclick();" />';
			}
		}
		
		function fn_bt_loanDedail2(value, metaData, record, rowIndex, colIndex,store) {
			if (record.data.id_ == '${id_}') {
				return '--';
			} else {
				return '<input type="button" value="设置" class="cbtn" onclick="_btn_bankset_onclick();" />';
			}
		}
		
		function fn_bt_flatset(value, metaData, record, rowIndex, colIndex,store) {
			if (record.data.id_ == '${id_}') {
				return '--';
			} else {
				return '<input type="button" value="解配" class="cbtn" onclick="_btn_flatdelete_onclick();" />';
			}
		}
		
	</script>
</aos:onready>
<script type="text/javascript">
	function _btn_bankxeset_onclick() {
		Ext.getCmp('_w_req').show();
	}
	function _btn_bankset_onclick() {
		Ext.getCmp('bankset').show();
	}
	function _btn_priallow_onclick() {
		Ext.getCmp('priorityallow').show();
	}
	function _btn_flatset_onclick1() {
		Ext.getCmp('flatInfo').show();
	}
	
	function _btn_flatdelete_onclick() {
		var record5 = AOS.selectone(AOS.get('fiel_flat'));
		var msg =  AOS.merge('确认要解配【{0}】吗？', record5.data.name_);
		AOS.confirm(msg, function(btn){
			if(btn === 'cancel'){
				AOS.tip('解配操作被取消。');
				return;
			}
		AOS.ajax({
			params : {
				id_ : record5.data.id_
			},
			url : 'disposedThreePayService.deleteFlat',
			ok : function(data) {
				AOS.tip(data.appmsg);
				AOS.get('fiel_flat').getStore().reload();
			}
		});
	   });
	}
</script>