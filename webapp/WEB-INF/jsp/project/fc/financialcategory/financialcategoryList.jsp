<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="现有财务科目清单" base="http" lib="ext">
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
			<aos:textfield fieldLabel="科目名称" name="name_" emptyText="填写科目名称"
				columnWidth="0.33" />
			<aos:combobox fieldLabel="科目类型" name="type_" value="0"
				columnWidth="0.34">
				<aos:option value="1" display="冲销" />
				<aos:option value="2" display="截留" />
			</aos:combobox>
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_loan_query" />
				<aos:dockeditem text="重置" onclick="_loan_reset" icon="refresh.png" />
				<aos:dockeditem text="添加" onclick="fn_add_" icon="add.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_loan"
			url="financialCategoryService.financialCategoryPage"
			onrender="_g_loan_query" pageSize="30" autoScroll="true"
			region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="已授权IP地址列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="科目ID" dataIndex="id_" celltip="true" width="80" />
			<aos:column header="科目名称" dataIndex="name_" celltip="true" width="80" />
			<aos:column header="科目类别" dataIndex="type_" width="90" />
			<aos:column header="是否启用" dataIndex="enabled_" celltip="true"
				width="120" />
			<aos:column header="备注" dataIndex="remark_" width="80" />
			<aos:column header="操作" align="center" fixedWidth="80"
				rendererFn="fn_button_delete" />
		</aos:gridpanel>
		
		
		
		<aos:window id="_w_add_" title="新配置一个财务科目">
			<aos:formpanel id="_f_info" layout="column" height="350" width="500">
				<aos:textfield name="name_" fieldLabel="科目名称"
					columnWidth="0.5" />
				<aos:combobox fieldLabel="科目类型" name="type_" value="0" columnWidth="0.5">
					<aos:option value="1" display="冲销" />
					<aos:option value="2" display="截留" />
				</aos:combobox>
				<aos:combobox fieldLabel="是否启用" name="enabled_"  columnWidth="0.5">
					<aos:option value="1" display="启用" />
					<aos:option value="0" display="禁用" />
				</aos:combobox>
				<aos:textareafield fieldLabel="科目备注" name="remark_" width="50" height="50" columnWidth="0.5"/>
				<aos:docked dock="bottom" ui="footer">
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem xtype="button" text="新增" onclick="_f_add_" icon="ok.png" />
					<aos:dockeditem onclick="_window_hide" text="取消" icon="close.png" />
					<aos:dockeditem xtype="tbfill" />
				</aos:docked>
			</aos:formpanel>
		</aos:window>

	</aos:viewport>


	<script type="text/javascript">
	
	//添加 
	function _f_add_() {
		AOS.ajax({
			forms : _f_info,
			url : 'financialCategoryService.add',
			ok : function(data) {
				AOS.tip(data.appmsg);
				_w_add_.hide();
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
		function _window_hide() {
			_w_add_.hide();
		}
		
		//主页面 启用按钮
		function fn_button_delete(value, metaData, record, rowIndex, colIndex,
				store) {
			if(record.data.enabled_=='1'){
				return '<input type="button" value="禁用" class="cbtn" onclick="fn_delete();" />';
			}else{
				return '<input type="button" value="启用" class="cbtn" onclick="fn_update();" />' ;
			}
			
		}
		
		//加载添加 
		function fn_add_() {
			AOS.reset(_f_info);
			_w_add_.show();
		}
	</script>
</aos:onready>



<script type="text/javascript">
	//禁用
	function fn_delete() {
		var record = AOS.selectone(Ext.getCmp('_g_loan'));
		var msg = AOS.merge('确认要禁用此财务科目吗？');
		AOS.confirm(msg, function(btn) {
			if (btn === 'cancel') {
				AOS.tip('禁用操作被取消。');
				return;
			}
			AOS.ajax({
				params : {
					id_ : record.data.id_
				},
				url : 'financialCategoryService.delete',

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
		var msg = AOS.merge('确认要启用此财务科目吗？');
		AOS.confirm(msg, function(btn) {
			if (btn === 'cancel') {
				AOS.tip('启用操作被取消。');
				return;
			}
			AOS.ajax({
				params : {
					id_ : record.data.id_
				},
				url : 'financialCategoryService.update',
				ok : function(data) {
					AOS.tip(data.appmsg);
					Ext.getCmp('_g_loan').getStore().reload();
				}
			});
		});
	}
</script>

