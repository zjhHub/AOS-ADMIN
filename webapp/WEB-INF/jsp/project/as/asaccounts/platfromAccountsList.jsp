<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="业务线" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border">

		<aos:formpanel id="_q_base" layout="column" columnWidth="1" region="north" border="false">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:textfield fieldLabel="账户编码" name="account_code_" emptyText="填写账户编码" columnWidth="0.33" />
			<aos:textfield fieldLabel="业务线名称" name="attach_platform_name_" emptyText="填写业务线名称" columnWidth="0.33" />
			<aos:textfield fieldLabel="账户用途" name="purpose_" emptyText="填写账户用途" columnWidth="0.33" />
			<aos:combobox  fieldLabel="账户状态" name="status_" value="0" columnWidth="0.33">
				<aos:option value="1" display="启用" />
				<aos:option value="2" display="禁用" />
			</aos:combobox>
			<aos:datefield fieldLabel="创建起始时间" name="create_time_l_" emptyText="起始时间" columnWidth="0.16" />
			<aos:datefield fieldLabel="至" name="create_time_r_" emptyText="终止时间" columnWidth="0.17" />
			<aos:numberfield fieldLabel="账面余额" name="total_balance_l_" emptyText="" columnWidth="0.16" />
			<aos:numberfield fieldLabel="至" name="total_balance_r_" emptyText="" columnWidth="0.17" />
			
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" onclick="_g_query" icon="query.png" />
				<aos:dockeditem text="重置" onclick="_g_reset" icon="refresh.png" />
				<aos:dockeditem text="新增业务线账户" icon="add.png" onclick="#addFlatAccount.show();" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_base" url="accountsService.platFormInitPage" onrender="_g_query" pageSize="30" autoScroll="true" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="业务线账户列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="账户ID" dataIndex="id_" celltip="true" width="5" />
			<aos:column header="账户编码" dataIndex="account_code_" celltip="true" width="5" />
			<aos:column header="归属业务线" dataIndex="attach_platform_name_" celltip="true" width="5" />
			<aos:column header="账户用途" dataIndex="purpose_" celltip="true" width="10" />
			<aos:column header="账面总余额" dataIndex="total_balance_" celltip="true" width="5" />
			<aos:column header="创建时间" dataIndex="create_time_" celltip="true" width="10" />
			<aos:column header="账户状态" dataIndex="status_" celltip="true" width="5" rendererField="accounts_status_" />
			<aos:column header="操作" align="center" width="10" rendererFn="fn_bt_asAccountsHandle" />
		</aos:gridpanel>
	</aos:viewport>

	<%-- 新增业务线账户窗口 --%>
	<aos:window id="addFlatAccount" title="新增业务线账户">
		<aos:formpanel id="_f_account" width="450" border="false" layout="anchor" >
			<aos:textfield name="account_code" fieldLabel="账户编码" columnWidth="0.33" allowBlank="false"/>
			<aos:combobox name="attach_platform" fieldLabel="选择归属业务线" columnWidth="0.33" allowBlank="false" url="disposedThreePayService.queryFlatCombobox" />
			<aos:textfield name="purpose" fieldLabel="账户用途" columnWidth="0.33" allowBlank="false"/>
			<aos:radioboxgroup fieldLabel="账户初始状态" columns="[120,80]" columnWidth="0.33">
				<aos:radiobox name="status" boxLabel="启用" checked="true" inputValue="1" />
				<aos:radiobox name="status" boxLabel="禁用" inputValue="2" />
			</aos:radioboxgroup>
		</aos:formpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="_f_flat_save" text="保存" icon="ok.png" />
			<aos:dockeditem onclick="#addFlatAccount.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	</aos:window>

	<script type="text/javascript">
		//加载表格数据
		function _g_query() {
			var params = _q_base.getValues();
			_g_base_store.getProxy().extraParams = params;
			_g_base_store.loadPage(1);
		}
		
		//重置 
		function _g_reset() {
			AOS.reset(_q_base);
		}
		
		//列表操作按钮
		function fn_bt_asAccountsHandle(value, metaData, record, rowIndex, colIndex,store){
			if(record.data.status_==1){
				return '<input type="button" value="禁用" class="cbtn" onclick="_btn_updateStatusclick();" />  <input type="button" value="详情" class="cbtn" onclick="_btn_asaccounts_onclick();" /> <input type="button" value="增加余额" class="cbtn" onclick="_btn_addMOneyClick();" /> <input type="button" value="减少余额" class="cbtn" onclick="_btn_decreMoneyClick();" /> ';
			}else{
				return '<input type="button" value="启用" class="cbtn" onclick="_btn_updateStatusclick();" />  <input type="button" value="详情" class="cbtn" onclick="_btn_asaccounts_onclick();" /> <input type="button" value="增加余额" class="cbtn" onclick="_btn_MOneyClick();" /> <input type="button" value="减少余额" class="cbtn" onclick="_btn_MoneyClick_1();" /> ';
			}
			
		}
		

		
		//新增业务线账户
		function _f_flat_save(){
				AOS.ajax({
					forms : _f_account,
					url : 'accountsService.addPlatformAccounts',
					ok : function(data) {
						 AOS.tip(data.appmsg);
						 _g_base_store.reload();
						 _f_account.getForm().reset();
						 addFlatAccount.hide();
					}
			});
		}
	</script>
</aos:onready>
<script type="text/javascript">

	//列表启用禁用按钮
	function _btn_updateStatusclick(){
		var record = AOS.selectone(Ext.getCmp('_g_base'));
		var msg = AOS.merge('确认要修改账户状态么?');
		AOS.confirm(msg, function(btn) {
			if (btn === 'cancel') {
				AOS.tip('修改操作被取消。');
				return;
			}
			AOS.ajax({
				params : {
					id_ : record.data.id_,
					status : record.data.status_
				},
				url : 'accountsService.updateAccountStatus',

				ok : function(data) {
					AOS.tip(data.appmsg);
					Ext.getCmp('_g_base').getStore().reload();
				}
			});
		});
	}
	
	//详情
	function _btn_asaccounts_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_base'));
		var id_ = record.data.id_;
		parent.fnaddtab('accountsService.accountDetails&id_=' + id_, '业务线账户详情'+id_, '522'+id_);
	}
	
	//增加余额
	function _btn_addMOneyClick() {
		var record = AOS.selectone(Ext.getCmp('_g_base'));
		var id_ = record.data.id_;
		parent.fnaddtab('accountsService.balanceDetail&id_=' + id_ +'&plus_minus_id=' +1, '业务线账户详情'+id_, '521'+id_);
	}
	
	//减少余额
	function _btn_decreMoneyClick() {
		var record = AOS.selectone(Ext.getCmp('_g_base'));
		var id_ = record.data.id_;
		parent.fnaddtab('accountsService.balanceDetail&id_=' + id_ +'&plus_minus_id=' +2, '业务线账户详情'+id_, '520'+id_);

	}
	
	function _btn_MOneyClick(){
		AOS.tip("该账户禁用中,不能进行增减操作！");
	}
	
	function _btn_MoneyClick_1(){
		AOS.tip("该账户禁用中,不能进行增减操作！");
	}
	

</script>