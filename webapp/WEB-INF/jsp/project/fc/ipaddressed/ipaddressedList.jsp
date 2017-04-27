<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="已授权的业务线IP地址" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border">

		<aos:formpanel layout="column" columnWidth="1" region="north"
			border="false" id="_loan">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:textfield fieldLabel="IP地址" name="ip_address_"
				emptyText="填写IP地址" columnWidth="0.33" />
			<aos:combobox fieldLabel="归属业务线" name="id_" editable="false"
				columnWidth="0.34" url="comboboxService.platformCombobox" />
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem text="添加" onclick="fn_add_ip_" icon="add.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_loan" url="ipAddressedService.ipAddressedPage"
			onrender="_g_loan_query" pageSize="30" autoScroll="true"
			region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="已授权IP地址列表" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem xtype="button" text="缓存装载" icon="refresh.png"
					onclick="_g_d_b_refresh" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="ipID" dataIndex="id_" hidden="true" />
			<aos:column header="IP地址" dataIndex="ip_address_" celltip="true"
				width="80" />
			<aos:column header="归属业务线" dataIndex="name_" celltip="true"
				width="80" />
			<aos:column header="是否启用" dataIndex="deleted_" celltip="true"
				width="80" />
			<aos:column header="操作" align="center" fixedWidth="80"
				rendererFn="fn_button_delete" />
		</aos:gridpanel>



		<aos:window id="_w_add_plan_bid" title="授权新IP地址">
			<aos:formpanel id="_f_info" layout="column" height="350" width="500">
				<aos:textfield name="ip_address_" fieldLabel="被授权的新IP地址"
					columnWidth="0.5" />
				<aos:combobox name="platform_id_" fieldLabel="选择归属业务线"
					allowBlank="false" columnWidth="0.5"
					url="comboboxService.platformCombobox" />
				<aos:docked dock="bottom" ui="footer">
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem xtype="button" text="授权" onclick="_f_add_ip_"
						icon="ok.png" />
					<aos:dockeditem onclick="_window_hide2" text="取消" icon="close.png" />
					<aos:dockeditem xtype="tbfill" />
				</aos:docked>

			</aos:formpanel>
		</aos:window>

	</aos:viewport>

	<script type="text/javascript">
		//添加 
		function _f_add_ip_() {
			AOS.ajax({
				forms : _f_info,
				url : 'ipAddressedService.add',
				ok : function(data) {
					AOS.tip(data.appmsg);
					_w_add_plan_bid.hide();
					_g_loan_store.reload();
				}
			});
		}

		//加载表格数据
		function _g_loan_query() {
			var params = _loan.getValues();
			_g_loan_store.getProxy().extraParams = params;
			_g_loan_store.loadPage(1);
		}
		//重置 
		function _loan_reset() {
			AOS.reset(_loan);
		}

		//关闭 
		function _window_hide2() {
			_w_add_plan_bid.hide();
		}
		//关闭 
		function _g_d_b_refresh() {
			//IP地址缓存重载
			AOS.ajax({
				url : 'recordEntryService.initCacheIpList',
				ok : function(data) {
					AOS.tip('刷新成功');
				}
			});
		}

		//主页面 启用按钮
		function fn_button_delete(value, metaData, record, rowIndex, colIndex,
				store) {
			if(record.data.deleted_=='可用'){
				return '<input type="button" value="禁用" class="cbtn" onclick="fn_delete();" />';
			}else{
				return '<input type="button" value="启用" class="cbtn" onclick="fn_update();" />' ;
			}
			
		}

		//加载添加 
		function fn_add_ip_() {
			AOS.reset(_f_info);
			_w_add_plan_bid.show();

		}
	</script>
</aos:onready>

<script type="text/javascript">
	//禁用
	function fn_delete() {
		var record = AOS.selectone(Ext.getCmp('_g_loan'));
		var msg = AOS.merge('确认要禁用此ip吗？');
		AOS.confirm(msg, function(btn) {
			if (btn === 'cancel') {
				AOS.tip('禁用操作被取消。');
				return;
			}
			AOS.ajax({
				params : {
					id_ : record.data.id_
				},
				url : 'ipAddressedService.delete',

				ok : function(data) {
					AOS.tip(data.appmsg);
					Ext.getCmp('_g_loan').getStore().reload();
				}
			});
		});
	}
	
	
	//启用 
	function fn_update() {
		var record = AOS.selectone(Ext.getCmp('_g_loan'));
		var msg = AOS.merge('确认要启用此ip吗？');
		AOS.confirm(msg, function(btn) {
			if (btn === 'cancel') {
				AOS.tip('启用操作被取消。');
				return;
			}
			AOS.ajax({
				params : {
					id_ : record.data.id_
				},
				url : 'ipAddressedService.update',

				ok : function(data) {
					AOS.tip(data.appmsg);
					Ext.getCmp('_g_loan').getStore().reload();
				}
			});
		});
	}
</script>