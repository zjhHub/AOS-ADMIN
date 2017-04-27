<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="配置第三方放款渠道" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:gridpanel id="_g_loan" url="disposedThreeLoanService.threePayListPage"
			onrender="_g_loan_query" pageSize="30" autoScroll="true"
			region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="现有支持的第三方放款渠道列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />

			<aos:column dataIndex="id_"  header="第三方放款渠道ID" width="30" />
			<aos:column header="第三方放款渠道名称" dataIndex="name_" celltip="true" width="30" />
			<aos:column header="第三方放款渠道编号" dataIndex="code_" width="30" />
			<aos:column header="操作" align="center" fixedWidth="350"
				rendererFn="fn_bt_loanDedail" />
		</aos:gridpanel>
	</aos:viewport>
	
	<aos:window id="flatInfo" title="" layout="border" onshow="showflatinfo" width="640" height="430">
		<aos:gridpanel id="fiel_flat" title="" hidePagebar="true" region="center" url="disposedThreeLoanService.flatSetList">
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
			<aos:combobox fieldLabel="业务线名称" allowBlank="false" columnWidth="0.33" name="name_" url="disposedThreeLoanService.queryFlatCombobox" />
		</aos:formpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem onclick="_f_flat_save" text="保存" icon="ok.png" />
			<aos:dockeditem onclick="#addFlat.hide();" text="关闭" icon="close.png" />
		</aos:docked>
	</aos:window>
	

	<script type="text/javascript">
		//窗口弹出事件监听
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
		
		
		//新增业务线
		function _f_flat_save(){
				AOS.ajax({
					forms : _f_account,
					url : 'disposedThreeLoanService.saveFlatInfo',
					ok : function(data) {
						 AOS.tip(data.appmsg);
						 fiel_flat_store.reload();
						 addFlat.hide();
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
				return ' <input type="button" value="业务线配置" class="cbtn" onclick="_btn_flatset_onclick();" />  ';
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
	
	function _btn_flatset_onclick() {
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
			url : 'disposedThreeLoanService.deleteFlat',
			ok : function(data) {
				AOS.tip(data.appmsg);
				AOS.get('fiel_flat').getStore().reload();
			}
		});
	   });
	}
</script>