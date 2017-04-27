<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="警报发送配置" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border" >		
		<aos:gridpanel id="_g_sendconfig" url="alarmService.sendConfigListPage" onrender="_g_sendconfig_query" pageSize="30" autoScroll="true" region="center">
			<aos:docked forceBoder="1 0 1 0"    >
				<aos:dockeditem xtype="tbseparator" />
			    <aos:dockeditem text="新增警报发送配置信息" icon="add.png" onclick="#_w_add_sendconfig.show();" /> 
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="主键ID" align="center" dataIndex="id_"  width="40"/>
			<aos:column header="报警类型ID" hidden="true" dataIndex="alarm_type_"  width="40"/>
			<aos:column header="警报类型" align="center" dataIndex="name_" width="40" />
			<aos:column header="联系地址或手机号" align="center" dataIndex="address_" width="40" />
			<aos:column header="发送方式" align="center" dataIndex="send_status_" width="40" rendererField="send_type_" />
			<aos:column header="发送人姓名" align="center" dataIndex="send_name_" width="50" />
			<aos:column header="发送人职务" align="center" dataIndex="send_position_" width="40" />
			<aos:column header="创建时间" align="center" dataIndex="create_time_" width="40" />
			<aos:column header="操作" align="center" width="50" rendererFn="fn_bt_alarm" />
		</aos:gridpanel>
		
		<aos:window id="_w_update_sendconfig" title="修改警报发送配置信息" onshow="_w_org_onshow">	
		<aos:formpanel  layout="column" columnWidth="1"  region="north" border="false" id="_f_update" width="350" height="210" any="standardSubmit:true">
				<aos:hiddenfield name="id_" />
			    <aos:combobox id="id_alarm_type" name="alarm_type_"  allowBlank="false" fieldLabel="警报类型" columnWidth="0.9" value="1"  url="alarmService.alarmTypeName" />
			    <aos:textfield name="address_" allowBlank="false" fieldLabel="联系地址或手机号" columnWidth="0.9" />
			    <aos:combobox id="id_send_status_" name="send_status_" allowBlank="false" fieldLabel="发送方式" columnWidth="0.9" value="1" dicField="send_type_"/>
			    
			    <aos:textfield name="send_name_" allowBlank="false" fieldLabel="发送人姓名" columnWidth="0.9"  />	
			    <aos:textfield name="send_position_" allowBlank="false" fieldLabel="发送人职务" columnWidth="0.9"  />	
				<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="修改" icon="save.png" onclick="_f_update_sendconfig"/>
				<aos:dockeditem text="重置" onclick="AOS.reset(_f_update);" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		</aos:window> 
		
		<aos:window id="_w_add_sendconfig" title="新增警报发送配置信息" >	
		<aos:formpanel layout="column" columnWidth="1"  region="north" border="false" id="_f_add" width="370" height="220" any="standardSubmit:true">
			    <aos:combobox name="alarm_type_" allowBlank="false" fieldLabel="警报类型" columnWidth="0.9"  url="alarmService.alarmTypeName"/>
			    <aos:textfield name="address_" allowBlank="false" fieldLabel="联系地址或手机号" columnWidth="0.9" />
			     <aos:combobox name="send_status_" allowBlank="false" fieldLabel="发送方式" columnWidth="0.9" dicField="send_type_"/>
			    <aos:textfield name="send_name_" allowBlank="false" fieldLabel="发送人姓名" columnWidth="0.9" />		    
			    <aos:textfield name="send_position_" allowBlank="false" fieldLabel="发送人职务" columnWidth="0.9" />		    
			    
				<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="新增" icon="save.png" onclick="_f_add_sendconfig"/>
				<aos:dockeditem text="重置" onclick="AOS.reset(_f_add);" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		</aos:window> 
		
	</aos:viewport>


	<script type="text/javascript">
 		//加载表格数据
		function _g_sendconfig_query() {
			_g_sendconfig_store.loadPage(1);
		} 	
 		
 		
		//窗口弹出事件监听，获取当前行所有数据
		function _w_org_onshow() {
			id_alarm_type_store.load({
					callback:function(){
						var record = AOS.selectone(_g_sendconfig, true);
						_f_update.loadRecord(record);			
// 						AOS.setValue('_f_update.alarm_type_',record.data.alarm_type_);
					}
			});
			
// 			id_send_status_store.load({
// 				callback:function(){
// 					var record = AOS.selectone(_g_sendconfig, true);
// 					_f_update.loadRecord(record);
// 				}
// 			});
		}
		
		
		//窗口弹出事件监听，获取当前行所有数据
// 		function _w_org_onshow() {
// 			id_send_status_store.load({
// 				callback:function(){
// 					var record = AOS.selectone(_g_sendconfig, true);
// 					_f_update.loadRecord(record);
// 				}
// 			});
// 		}
 		
		
 		//修改
     	function _f_update_sendconfig() {			
     		AOS.ajax({
				forms : _f_update,
				url : 'alarmService.updateSendConfig',
				ok : function(data) {
					 AOS.tip(data.appmsg);
					 _g_sendconfig_store.reload();
					 _w_update_sendconfig.hide();
				}
			});
		}  
     	
 		//新增
     	function _f_add_sendconfig() {		
    		AOS.ajax({
				forms : _f_add,
				url : 'alarmService.addSendConfig',
				ok : function(data) {
					 AOS.tip(data.appmsg);
					 _g_sendconfig_store.reload();
					 _f_add.getForm().reset();
					 _w_add_sendconfig.hide();
				
				}
			});
		} 
 		
	    
		function fn_bt_alarm (value, metaData, record, rowIndex, colIndex, store){	
			return '<input type="button" value="修改" class="cbtn" onclick="_w_update_sendconfig();" />' ;
		}

	</script>
</aos:onready>

<script type="text/javascript">
	function _w_update_sendconfig(){
		Ext.getCmp('_w_update_sendconfig').show();
	}
	
</script>