<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="警报类型" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border" >		
		<aos:gridpanel id="_g_alarmtype" url="alarmService.alarmTypeListPage" onrender="_g_alarmtype_query" pageSize="30" autoScroll="true" region="center">		
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="新增警报类型信息" icon="add.png" onclick="#_w_add_alarmtype.show();" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="主键ID" align="center" dataIndex="id_"  width="40"/>
			<aos:column header="父ID" align="center" dataIndex="pid_"  width="40"/>
			<aos:column header="警报名称" align="center" dataIndex="name_" width="40"/>
			<aos:column header="警报周期" align="center" dataIndex="cycle_" width="40" />
			<aos:column header="警报信息模板" align="center" dataIndex="templet_" width="60" />
			<aos:column header="创建时间" align="center" dataIndex="create_time_" width="40" />
			<aos:column header="创建人" align="center" dataIndex="creator_" width="40" />
			<aos:column header="操作" align="center" width="50" rendererFn="fn_bt_alarm" />
		</aos:gridpanel>
		
		<aos:window id="_w_update_alarmtype" title="修改警报类型信息" onshow="_w_org_onshow">	
		<aos:formpanel  layout="column" columnWidth="1"  region="north" border="false" id="_f_update" width="350" height="250" any="standardSubmit:true">
				<aos:hiddenfield name="id_" />
			    <aos:textfield name="name_" allowBlank="false" fieldLabel="警报名称" columnWidth="0.9" emptyText="请输入警报名称" />
			    <aos:textfield name="pid_" allowBlank="false" fieldLabel="父ID" columnWidth="0.9" emptyText="请输入父ID" />
			    <aos:textfield name="cycle_" allowBlank="false" fieldLabel="警报周期" columnWidth="0.9" emptyText="请输入警报周期"/>
<%-- 			    <aos:textfield name="templet_" allowBlank="false" fieldLabel="警报信息模板" columnWidth="0.9" emptyText="请输入警报信息模板"/> --%>
			     <aos:textareafield name="templet_" fieldLabel="处理描述" allowBlank="false" emptyText="请输入警报信息模板"  columnWidth="0.9"/>
			    <aos:textfield name="creator_" allowBlank="false" fieldLabel="创建人" columnWidth="0.9" emptyText="请输入创建人姓名" />	
				<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="修改" icon="save.png" onclick="_f_update_alarmtype"/>
				<aos:dockeditem text="重置" onclick="AOS.reset(_f_update);" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		</aos:window> 
		
		<aos:window id="_w_add_alarmtype" title="新增警报类型信息" >	
		<aos:formpanel  layout="column" columnWidth="1"  region="north" border="false" id="_f_add" width="350" height="250" any="standardSubmit:true">
			    <aos:textfield name="name_" allowBlank="false" fieldLabel="警报名称" columnWidth="0.9" emptyText="请输入警报名称" />
			    <aos:textfield name="pid_" allowBlank="false" fieldLabel="父ID" columnWidth="0.9" emptyText="请输入父ID" />
			    <aos:textfield name="cycle_" allowBlank="false" fieldLabel="警报周期" columnWidth="0.9" emptyText="请输入数字"/>
<%-- 			    <aos:textfield name="templet_" allowBlank="false" fieldLabel="警报信息模板" columnWidth="0.9" emptyText="请输入警报信息模板"/> --%>
			    <aos:textareafield name="templet_" fieldLabel="处理描述" allowBlank="false" emptyText="请输入警报信息模板"  columnWidth="0.9"/>
			    <aos:textfield name="creator_" allowBlank="false" fieldLabel="创建人" columnWidth="0.9" emptyText="请输入创建人姓名" />		    
			    
				<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="新增" icon="save.png" onclick="_f_add_alarmtype"/>
				<aos:dockeditem text="重置" onclick="AOS.reset(_f_add);" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		</aos:window> 
		
	</aos:viewport>


	<script type="text/javascript">
 		//加载表格数据
		function _g_alarmtype_query() {
			_g_alarmtype_store.loadPage(1);
		} 	
 		
 		
		//窗口弹出事件监听，获取当前行所有数据
		function _w_org_onshow() {
			var record = AOS.selectone(_g_alarmtype, true);
            AOS.ajax({
            	params : {
            		id_: record.data.id_
            	},
                url: 'alarmService.getAlarmTypeInfo',
                ok: function (data) {
                	_f_update.form.setValues(data);
                }
            });
		}
 		
		
 		//修改
     	function _f_update_alarmtype() {			
			
     		AOS.ajax({
				forms : _f_update,
				url : 'alarmService.updateAlarmType',
				ok : function(data) {
					 AOS.tip(data.appmsg);
					 _g_alarmtype_store.reload();
					 _w_update_alarmtype.hide();
				}
			});
		}  
     	
 		//新增
     	function _f_add_alarmtype() {	
     		AOS.ajax({
				forms : _f_add,
				url : 'alarmService.addAlarmType',
				ok : function(data) {
					 AOS.tip(data.appmsg);
					 _g_alarmtype_store.reload();
					 _f_add.getForm().reset();
					 _w_add_alarmtype.hide();
				}
			});
		} 
 		
	    
		function fn_bt_alarm (value, metaData, record, rowIndex, colIndex, store){	
			return '<input type="button" value="修改" class="cbtn" onclick="_w_update_alarmtype();" />' ;
		}

	</script>
</aos:onready>

<script type="text/javascript">
	function _w_update_alarmtype(){
		Ext.getCmp('_w_update_alarmtype').show();
	}
	
	
</script>