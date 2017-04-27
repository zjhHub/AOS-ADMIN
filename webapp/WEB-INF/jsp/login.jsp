<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="${app_title_}" base="http" lib="ext">
<style type="text/css">
.bodyclass {
	background-image:
		url('${cxt}/static/image/background/${login_back_img_}');
	background-size: 100%;
	background-color: #1BA3F9;
	background-repeat: no-repeat;
}

.north_el {
	height: 80px;
	padding-top: 8px;
	background-image:
		url('${cxt}/static/image/background/login/${north_back_img_}');
}
</style>
<aos:body class2="bodyclass">
	<div id="_north_el" class="x-hidden north_el">
		<table>
			<tr>
				<td align="left" width="360"><img src="${cxt}/static/image/logo/left-logo.png"></td>
			</tr>
		</table>
	</div>
	<div id="_div_vercode" class="x-hidden " align="center">
		<aos:vercode id="_vercode" uuid="${vercode_uuid_}" fontSize="28" characters="${vercode_characters_}"
			length="${vercode_length_}" />
	</div>
</aos:body>
</aos:html>

<aos:onready>
	<aos:window id="_w_login" title="欢迎使用${app_title_}" maximizable="false" autoShow="false" closable="false" modal="false"
		draggable="false" onshow="_w_login_onshow" resizable="false" opacity="0" y="0" width="550" layout="anchor"
		header="true">
		<aos:panel contentEl="_north_el" anchor="100%" />
		<aos:tabpanel id="_id_tabs" activeTab="0" plain="false" tabBarHeight="30" height="250" anchor="100%">
			<aos:formpanel id="_f_login" layout="column" labelWidth="90" border="false" title="身份认证" padding="${padding_} 0 0 0"
				msgTarget="qtip" rowSpace="${row_space_}">
				<aos:textfield fieldLabel="帐 号" name="account_" maxLength="25" allowBlank="false" star="false" height="28"
					onenterkey="fn_account_enter" columnWidth="1" margin="0 60 0 0" />
				<aos:textfield fieldLabel="密  码" name="password_" maxLength="20" allowBlank="false" star="false"
					onenterkey="fn_password_enter" inputType="password" height="28" columnWidth="1" margin="0 60 0 0" />
				<c:if test="${is_show_vercode_ == '1' }">
					<aos:textfield fieldLabel="验证码" name="vercode_" maxLength="${vercode_length_}" allowBlank="false" star="false"
						height="28" columnWidth="0.7" onenterkey="_fn_login" margin="0 15 0 0" />
					<aos:fieldset labelWidth="65" columnWidth="0.3" height="30" collapsible="false" contentEl="_div_vercode"
						border="false" margin="0 60 0 0" />
					<aos:hiddenfield name="vercode_uuid_" value="${vercode_uuid_}" />
				</c:if>
				<aos:toggle name="remberme" offText="忽略" onText="记住" state="true" columnWidth="0.4" resizeHandle="true"
					margin="0 65 0 95" />
			</aos:formpanel>
			<aos:panel title="系统公告" border="false">
			</aos:panel>
			<aos:panel title="关于" border="false">
			</aos:panel>
		</aos:tabpanel>
		<aos:docked dock="bottom" ui="footer">
			<aos:dockeditem xtype="tbfill" />
			<aos:dockeditem xtype="button" onclick="_fn_login" icon="user6.png" text="登 录" tooltip="登录系统" />
			<aos:dockeditem xtype="button" onclick="_fn_reset" icon="icon140.png" text="重 置" tooltip="重置身份认证表单" />
		</aos:docked>
	</aos:window>
	<script type="text/javascript">
		_w_login.show();
		//开发人员自动登录标志
		var login_dev_ = '${login_dev_}';
		//窗口显示监听事件
		function _w_login_onshow() {
			var cmp = AOS.get('_f_login.account_');
			cmp.focus();
		}

		//响应窗口变化事件
		Ext.EventManager.onWindowResize(function() {
			//_w_login.center();
			var left = (Ext.getBody().getViewSize().width - 550) / 2;
			var top = (Ext.getBody().getViewSize().height - 430) / 2;
			_w_login.setPosition(left, top, true)
		});

		//监听帐号输入框回车键
		function fn_account_enter(obj) {
			login_dev_ = '0'; //取消开发者快捷登录功能
			if (AOS.empty(obj.getValue())) {
				obj.validate();
			} else {
				AOS.get('_f_login.password_').focus();
			}
		}

		//监听密码输入框回车键
		function fn_password_enter(obj) {
			if (AOS.empty(obj.getValue())) {
				obj.validate();
			} else {
				if ('${vercode_show}' === '1') {
					AOS.get('_f_login.vercode').focus();
				} else {
					_fn_login();
				}
			}
		}

		//登录窗口动画
		Ext.create('Ext.fx.Animator', {
			target : _w_login,
			duration : 1000,
			easing : 'backOut',
			//easing : 'ease',
			delay : 0,
			keyframes : {
				0 : {
					opacity : 0,
					top : 0
				},
				100 : {
					opacity : 0.8,
					top : (Ext.getBody().getViewSize().height - 430) / 2
				}
			}
		});

		//验证码首次加载动画
		var _el_vercode = Ext.get('_vercode');
		var _vercode_task = new Ext.util.DelayedTask(function() {
			_el_vercode.switchOff();
			_el_vercode.fadeIn();
		});
		_vercode_task.delay(1000);

		//表单校验
		function _fn_check() {
			var flag = _f_login.isValid();
			//可以继续做其它检查，验证不通过则flag=false即可
			//
			return flag;
		}

		//登录提交
		function _fn_login() {
			if (!_fn_check()) {
				return;
			}
			AOS.mask('${login_wait_msg_}');
			AOS
					.ajax({
						forms : _f_login,
						url : 'homeService.login',
						wait : false,
						ok : function(data) {
							if (data.appcode === '1') {
								Ext.util.Cookies.set('juid', data.juid);
								_fn_login_success();
								window.location.href = 'do.jhtml?router=homeService.initIndex&juid='
										+ data.juid;
							} else {
								Ext.util.Cookies.clear('juid');
								AOS.unmask();
								AOS.info(data.appmsg, function() {
									if (data.appcode === '000') {
										//验证码错误
										AOS.get('_f_login.vercode').focus();
									} else if (data.appcode === '001') {
										//帐号错误
										AOS.get('_f_login.account_').focus();
									} else if (data.appcode === '002') {
										//密码错误
										AOS.get('_f_login.password_').reset();
										AOS.get('_f_login.password_').focus();
										AOS.get('_f_login.password_')
												.validate();
									}
								});
							}
						}
					});
		}

		//开发者快捷登录提交
		function _fn_login_dev() {
			AOS.mask('${login_wait_msg_}');
			AOS
					.ajax({
						params : {
							account_ : '${login_dev_account_}'
						},
						url : 'homeService.loginDev',
						wait : false,
						ok : function(data) {
							if (data.appcode == '1') {
								Ext.util.Cookies.set('juid', data.juid);
								_fn_login_success();
								window.location.href = 'do.jhtml?router=homeService.initIndex&juid='
										+ data.juid;
							} else {
								AOS.err('开发用户快捷登录发生错误。');
							}
						}
					});
		}

		//开发者快捷登录
		AOS.job(function() {
			if (login_dev_ == '1') {
				_fn_login_dev();
			}
		}, 1500);

		//登录成功动画
		function _fn_login_success() {
			Ext.create('Ext.fx.Animator', {
				target : _w_login,
				duration : 350,
				easing : 'ease',
				delay : 250,
				keyframes : {
					0 : {
						opacity : 0.8,
						top : (Ext.getBody().getViewSize().height - 430) / 2
					},
					100 : {
						opacity : 0,
						top : Ext.getBody().getViewSize().height - 430
					}
				}
			});
		}

		//登录窗口重置
		function _fn_reset() {
			_f_login.form.reset();
		}
	</script>
</aos:onready>