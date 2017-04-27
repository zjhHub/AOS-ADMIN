<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="短信授权增加余额" base="http" lib="ext" >
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="column" >
		<aos:hiddenfield name="id_" id="id_" value="${id_}" />
		<aos:hiddenfield name="juid" id="juid" value="${juid}" />
					
			 <aos:formpanel id="_f_detail" rowSpace="10" bodyBorder="1 0 1 0" columnWidth="1">
			 <aos:docked forceBoder="0 1 0 0">
					<aos:dockeditem xtype="tbtext" text="业务线账户信息摘要" />
				</aos:docked>
					<aos:textfield name="account_code_" fieldLabel="账户编码" readOnly="true" columnWidth="0.33" value="${po['account_code_']}"/>
					<aos:textfield name="purpose_" fieldLabel="账户用途" readOnly="true" value="${po['purpose_']}" columnWidth="0.33" />
					<aos:textfield name="attach_platform_" fieldLabel="归属业务线" value="${po['attach_platform_']}" readOnly="true" columnWidth="0.33" />
					<aos:textfield name="total_balance_" fieldLabel="账面总余额" value="${po['total_balance_']}"  readOnly="true" columnWidth="0.33" />
					<aos:textfield name="available_balance_" fieldLabel="可用余额" value="${po['available_balance_']}"  readOnly="true" columnWidth="0.33" />
					<aos:textfield name="froze_balance_" fieldLabel="冻结余额"  value="${po['froze_balance_']}"  readOnly="true" columnWidth="0.33" />
			</aos:formpanel> 
			
			<aos:formpanel id="_f_trans" layout="column" columnWidth="1" border="false" rowSpace="30" >
				<aos:docked forceBoder="0 1 1 0">
					<aos:dockeditem xtype="tbtext" text="减少余额操作" />
				</aos:docked>
			
				<aos:combobox name="position_" fieldLabel="减少到目标位置" columnWidth="0.60" allowBlank="false" dicField="position_" />
				<aos:textfield name="amount_" fieldLabel="减少余额数" columnWidth="0.60" allowBlank="false"  regex="/^\d*\.{0,2}\d{0,2}$/" emptyText="请输入数字和小数点"/>
				<aos:filefield name="upfile_" fieldLabel="附件" buttonText="浏览" allowBlank="false" emptyText="请选择图片..." columnWidth="0.60"/>
	 			<aos:textareafield name="remark_" fieldLabel="财务备注" columnWidth="0.60" allowBlank="false"/>
				<aos:textfield name="msg_code_" fieldLabel="短信授权码" columnWidth="0.41" id="msg_code_" allowBlank="false" regex="/\d{6}/" emptyText="请输入6位数字验证码"/>
				<aos:button text="获取手机验证码" id="rTime" columnWidth="0.19" margin="0 0 0 20" onclick="_bn_sms_show();"/>
				<aos:docked dock="bottom" ui="footer" margin="0 0 8 0" >
					<aos:dockeditem xtype="tbfill" />
					<aos:dockeditem text="减少余额" icon="add.png" onclick="_g_add" />
					<aos:dockeditem text="取消" icon="refresh.png" onclick="AOS.reset(_f_trans);" />
					<aos:dockeditem xtype="tbfill" />
				</aos:docked>
		   </aos:formpanel>
				
	</aos:viewport>

	<script type="text/javascript">

		
		//点击提交添加
		function _g_add() {
		   var form = _f_trans.getForm();
		   var position_ = _f_trans.getValues().position_;
		   var amount_ = _f_trans.getValues().amount_;
		   var available_balance_ = _f_detail.getValues().available_balance_;
		   var froze_balance_ = _f_detail.getValues().froze_balance_;
	   
		   if( position_ == '1' ){
			   if(Number(amount_)> Number(available_balance_)){
				   AOS.tip("可用余额不足，不能进行减少余额操作");
				   return;
			   }
		   }else{
			   if(Number(amount_)> Number(froze_balance_) ){
				   AOS.tip("冻结余额不足，不能进行减少余额操作");
				   return;
			   }
		   }
	        //AOS.wait();
		    var account_id_ = id_.getValue();
			var params = {
		    	account_id_ : account_id_,
		    	plus_minus_id : 2 //1增加，2 减少
			};
			
	        form.submit({
	            timeout: 3000, 
	            url: '${cxt}/as/balance/updateBalance.jhtml',
	            params: params,
	            success: function (form, action) {
	                AOS.tip(action.result.appmsg);
	                window.location.href = 'do.jhtml?router=accountsService.balanceDetail&juid=${juid}&id_=${id_}&plus_minus_id=2';
	            }
	        }); 
		} 
		
		//时间更变
		var countdown=60;
		function showTime() {
			if(countdown >= 0){
				rTime.setText("重新发送(" + countdown + "s)");
				rTime.setDisabled(true);
				countdown--
			}else{
				rTime.setText("获取手机验证码");
				rTime.setDisabled(false);
				countdown=60;
			}	
		}
		
		//AOS.task(showTime, 1000);
		
		//点击发送短信
		function _bn_sms_show() {	
	        AOS.ajax({
 	        	params : {},
				url:'smsBalanceService.smsSent',
	            ok: function (data) {
	            	AOS.tip(data.appmsg);  
	            	rTime.setText("重新发送(60s)");
	            	AOS.task(showTime, 1000);
	            }
	        });
		} 
		
		

		
		
		
		
	</script>

</aos:onready>
<script type="text/javascript">



</script>