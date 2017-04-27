<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="警报处理" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">

		<aos:formpanel layout="column" columnWidth="1" region="north" border="false" id="_alarm">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="查询条件" />
			</aos:docked>
			<aos:textfield fieldLabel="引用指令ID" name="reference_order_"  columnWidth="0.33" />
			<aos:textfield fieldLabel="订单号" name="third_order_id_"  columnWidth="0.33" />
			<aos:combobox  fieldLabel="警报类型" name="alarm_type_" editable="false" columnWidth="0.33" url="alarmService.alarmTypeName" />
			<aos:combobox fieldLabel="指令类型" name="reference_type_" editable="false" columnWidth="0.33" dicField="reconciliation_type_" />
			<aos:textfield fieldLabel="受理ID" name="accepted_id_"  columnWidth="0.33" />
			<aos:combobox fieldLabel="警报状态" name="alarm_status_" editable="false" columnWidth="0.33" dicField="alarm_status_" />
			<aos:datefield fieldLabel="警报时间" name="start_time_" emptyText="开始日期" columnWidth="0.186" />
			<aos:displayfield value="-" width="20" margin="0 0 0 10" />
			<aos:datefield fieldLabel="" name="end_time_" emptyText="结束日期" columnWidth="0.126" />	

			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_alarm_query" />
				<aos:dockeditem text="重置" onclick="_alarm_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>

		<aos:gridpanel id="_g_alarm" url="alarmService.alarmListPage" onrender="_g_alarm_query" pageSize="30" autoScroll="true" region="center" forceFit="false">
			<aos:docked forceBoder="1 0 1 0" >
				<aos:dockeditem xtype="tbtext" text="警报处理列表" />
				<aos:dockeditem xtype="tbseparator" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="自增主键" dataIndex="id_" hidden="true" width="80" align="center"/>
			<aos:column header="警报类型" dataIndex="name_" celltip="true" width="80" align="center"/>
			<aos:column header="引用指令ID" dataIndex="reference_order_" celltip="true" width="100" align="center"/>
			<aos:column header="订单号" dataIndex="third_order_id_" width="200" celltip="true" align="center"/>
			<aos:column header="指令类型" dataIndex="reference_type_" width="100" align="center" rendererField="reconciliation_type_"/>
			<aos:column header="受理ID" dataIndex="accepted_id_" width="70" align="center"/>
			<aos:column header="渠道名称" dataIndex="channel_name_" width="80" align="center"/>
			<aos:column header="渠道ID" dataIndex="channel_id_" width="70" align="center"/>
			
			<aos:column header="警报时间" dataIndex="alarm_time_" width="100" align="center"/>
			<aos:column header="警报原因" dataIndex="alarm_reason_" width="160" align="center"/>
			<aos:column header="警报处理人" dataIndex="processing_people_" width="70" align="center"/>
			<aos:column header="警报消除时间" dataIndex="processing_time_" width="100" align="center"/>
			<aos:column header="处理描述" dataIndex="processing_content_" width="100" align="center" />
			<aos:column header="警报状态" dataIndex="alarm_status_"  width="80" align="center" rendererField="alarm_status_"/>
			<aos:column header="已警报次数" dataIndex="alarm_count_"  width="80" align="center"/>
			<aos:column header="下次警报时间" dataIndex="alarm_next_" width="100" celltip="true" align="center"/>
			<aos:column header="操作" align="center" width="200"  rendererFn="fn_bt_alarm" />
		</aos:gridpanel>
		
		<aos:window id="_w_alarm_status_no" title="警告处理" onshow="_w_alarm_status" >
				<aos:formpanel id="_f_alarm_status_no" width="450" layout="anchor" labelWidth="90">
					<aos:hiddenfield name="id_" />
<%-- 					<aos:combobox name="alarm_status_" fieldLabel="警报状态" dicField="alarm_status_" allowBlank="false" /> --%>
<%-- 					<aos:textfield name="processing_people_" fieldLabel="警报处理人" />	 --%>
					<aos:textareafield name="processing_content_" fieldLabel="处理描述" />
				</aos:formpanel>
				<aos:docked dock="bottom" ui="footer">
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem onclick="_f_alarm_status" text="处理" icon="ok.png" />
					<aos:dockeditem onclick="#_w_alarm_status_no.hide();" text="取消" icon="close.png" />
				</aos:docked>
		</aos:window>

	</aos:viewport>

	<script type="text/javascript">
		
		//加载表格数据
		function _g_alarm_query() {
			var params = _alarm.getValues();
			_g_alarm_store.getProxy().extraParams = params;
			_g_alarm_store.loadPage(1);
		}
		//重置 
		function _alarm_reset() {
			AOS.reset(_alarm);
		}
		
	
		
		//窗口弹出事件监听，获取当前行所有数据
		function _w_alarm_status() {
			var record = AOS.selectone(_g_alarm, true);
			AOS.setValue('_f_alarm_status_no.id_',record.data.id_);
			
// 			AOS.ajax({
// 				url : 'alarmService.getUser',
// 				ok : function(datas) {
// 					_f_alarm_status_no.form.setValues(datas);
// 				}
// 			});
		}
		
		
		

		//执行处理
		function _f_alarm_status(){

			AOS.ajax({
				forms : _f_alarm_status_no,
				url : 'alarmService.updateAlarmInfo',
				ok : function(data) {
					_w_alarm_status_no.hide();
					 AOS.hide();
					 AOS.tip(data.appmsg);
					 AOS.reset(_f_alarm_status_no);
					 Ext.getCmp('_g_alarm').getStore().reload(); 			 
				}
		});
		}
		
		//调阅 
		function fn_bt_alarm (value, metaData, record, rowIndex, colIndex, store) {	
			if( (record.data.reference_type_=='1') && (record.data.alarm_status_!='2')){
				return '<input type="button" value="未处理" class="cbtn" onclick="_btn_status_onclick_1();" /> <input type="button" value="划扣指令详情" class="cbtn" onclick="_btn_pay_onclick();" /> ' ;
			}else if( (record.data.reference_type_=='2') && (record.data.alarm_status_!='2')){
				return '<input type="button" value="未处理" class="cbtn" onclick="_btn_status_onclick_1();" /> <input type="button" value="放款指令详情" class="cbtn" onclick="_btn_loan_onclick();" /> ' ;		
			}else if( (record.data.reference_type_=='1') && (record.data.alarm_status_=='2')){
				return '<input type="button" value="已处理" class="cbtn" onclick="_btn_status_onclick_2();" /> <input type="button" value="划扣指令详情" class="cbtn" onclick="_btn_pay_onclick();" /> ' ;
			}else if( (record.data.reference_type_=='2') && (record.data.alarm_status_=='2')){
				return '<input type="button" value="已处理" class="cbtn" onclick="_btn_status_onclick_2();" /> <input type="button" value="放款指令详情" class="cbtn" onclick="_btn_loan_onclick();" /> ' ;		
			}
		}
		
	</script>
</aos:onready>

<script type="text/javascript">

	function _btn_pay_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_alarm'));
		var order_id_ = record.data.reference_order_;
		parent.fnaddtab('chargebackPayService.orderDetail&chargeback_order_id_=' + order_id_, '划扣指令'+order_id_+'的详情', order_id_);
	}
	
	function _btn_loan_onclick() {
		var record = AOS.selectone(Ext.getCmp('_g_alarm'));
		var acceptedID = record.data.reference_order_;
		parent.fnaddtab('loanAcceptService.loanacceptAcceptDetails&acceptedID=' + acceptedID, '放款受理指令详情'+acceptedID, acceptedID);
	}

	
	function _btn_status_onclick_1() {
		Ext.getCmp('_w_alarm_status_no').show();
	}
	
	
</script>
