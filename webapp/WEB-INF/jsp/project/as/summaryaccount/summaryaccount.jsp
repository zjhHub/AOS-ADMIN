<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="账户汇总与层级关系" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border">
	<aos:hiddenfield name="juid" id="juid" value="${juid}" />
		<aos:panel region="west" width="250" bodyBorder="0 1 0 0">
			<aos:layout type="vbox" align="stretch" />
			<aos:docked forceBoder="0 1 1 0">
				<aos:dockeditem text="新建" icon="add.png" onclick="#w_add_account.show();" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:dockeditem text="删除" icon="del.png" onclick="_del_account"/>
			</aos:docked>
			<aos:layout type="hbox" align="stretch" />
			<aos:panel region="west" width="250" bodyBorder="0 0 0 0" >
			
				<aos:treepanel id="idTree" flex="1" singleClick="false" rootVisible="false" onitemclick="_g_query" expandAll="true" 
					url="summaryAccountService.getTreeData" nodeParam="parent_id_" bodyBorder="0 1 0 0" width="250"  rootExpanded="true">
					<aos:docked forceBoder="0 1 1 0">
						<aos:dockeditem xtype="tbtext" text="层级关系" />
						<aos:dockeditem xtype="tbfill" />
						<aos:checkbox boxLabel="级联显示" id="id_cascade_" onchang="_g_query" checked="true" />
					</aos:docked>
					<%-- 树节点右键菜单 --%>
					<aos:menu>
						<aos:menuitem text="新建" icon="add.png" onclick="#w_add_account.show();" />
						<aos:menuitem text="删除" icon="del.png" onclick="_del_account"/>
						<aos:menuitem text="刷新" icon="refresh.png" onclick="refresh" />
						
					</aos:menu>
				</aos:treepanel>
			</aos:panel>	
		</aos:panel>

	<%-- border布局嵌套：对外层boder布局的center区域再应用border布局 --%>
		<aos:panel region="center" border="false" layout="border">
			<aos:panel region="north" >			
			 <aos:formpanel id="_f_detail" rowSpace="10" bodyBorder="1 0 1 0" columnWidth="1" labelWidth="150">
			 <aos:docked forceBoder="0 1 0 0">
					<aos:dockeditem xtype="tbtext" text="摘要汇总" />
					<aos:dockeditem xtype="tbseparator" />
					<aos:dockeditem text="删除账户" icon="del.png" onclick="#w_change_account.show();"/>
					<aos:dockeditem xtype="tbseparator" />
					<aos:dockeditem text="新增账户" icon="add.png" onclick="#w_choose_account.show();"/>
				</aos:docked>
					<aos:textfield name="name_" fieldLabel="汇总名称" readOnly="true"  columnWidth="0.33" />
					<aos:textfield name="gather_purpose_" fieldLabel="汇总用途" readOnly="true" columnWidth="0.33" />
					<aos:textfield name="created_by_" fieldLabel="创建者"  readOnly="true" columnWidth="0.33" />
					<aos:textfield name="total_balance_" fieldLabel="账面总余额汇总"   readOnly="true" columnWidth="0.33" />
					<aos:textfield name="available_balance_" fieldLabel="可用余额汇总"   readOnly="true" columnWidth="0.33" />
					<aos:textfield name="froze_balance_" fieldLabel="冻结余额汇总"   readOnly="true" columnWidth="0.33" />
					<aos:textfield name="total_account_" fieldLabel="所有下级实体账户数"    readOnly="true" columnWidth="0.33" />
					<aos:textfield name="rows" fieldLabel="直属下级汇总账户数"   readOnly="true" columnWidth="0.33" />
					<aos:textfield name="created_time_" fieldLabel="创建时间"   readOnly="true" columnWidth="0.33" />
			</aos:formpanel> 
				
			</aos:panel>
		<aos:tabpanel id="id_tabpanel" region="center" activeTab="0" bodyBorder="0 0 0 0" tabBarHeight="30">
			<aos:tab title="所有下级账户" id="_tab_org" layout="border">
				<aos:gridpanel id="_g_org" url="summaryAccountService.queryAllDownInAccountPage" onrender="_g_query" region="center" pageSize="20" >
					<aos:column type="rowno" />
					<aos:column header="账户ID" dataIndex="account_id_" width="30" align="center"/>
					<aos:column header="账户码编" dataIndex="account_code_" width="80" align="center"/>
					<aos:column header="归属业务线" dataIndex="attach_platform_name_" celltip="true" width="50" align="center"/>
					<aos:column header="账户类型" dataIndex="account_type_" celltip="true" width="50" align="center" rendererField="account_type_"/>
					<aos:column header="账户用途" dataIndex="account_purpose_" width="50" align="center"/>
					<aos:column header="账面总余额" dataIndex="total_balance_" width="50" align="center"/>
					<aos:column header="创建时间" dataIndex="create_time_" width="50" align="center"/>
					<aos:column header="账户状态" dataIndex="account_status_" width="50" rendererField="accounts_status_" align="center"/>
				</aos:gridpanel>
			</aos:tab>

			<aos:tab title="所有下级汇总" id="_tab_param" onactivate="_g_param_query" layout="border">
				<aos:gridpanel id="_g_param" url="summaryAccountService.queryAllDownSummaryPage" pageSize="20" region="center">
					<aos:column type="rowno" />
					<aos:column header="汇总ID" dataIndex="summary_id_" width="70" align="center"/>
					<aos:column header="层级码" dataIndex="level_code_" width="50" align="center"/>
					<aos:column header="汇总用途" dataIndex="gather_purpose_" width="60" align="center"/>
					<aos:column header="账面总余额汇总" dataIndex="total_balance_" width="50" align="center"/>
					<aos:column header="直属下级汇总数" dataIndex="total_" width="80" align="center"/>
					<aos:column header="创建时间" dataIndex="created_time_" width="80" align="center"/>
					<aos:column header="创建者" dataIndex="created_by_" width="80" align="center"/>
				</aos:gridpanel>
			</aos:tab>
		</aos:tabpanel>
		</aos:panel>


	<aos:window id="w_add_account" title="新建业务线汇总账户"  width="500" layout="column" onshow="_w_add_onshow">	
		<aos:formpanel layout="column" columnWidth="1" region="north" labelWidth="150" border="false" id="f_add_">
			<aos:textfield name="up_name_" fieldLabel="所属层级" allowBlank="false" readOnly="true" columnWidth="0.8" />
			<aos:textfield fieldLabel="新建汇总层级名称" name="name_" emptyText="要求在汇总和实体账户都唯一" allowBlank="false" columnWidth="0.80" maxWidth="400"/>
			<aos:textfield fieldLabel="汇总用途" name="gather_purpose_" emptyText="要求在汇总账户内唯一" allowBlank="false" columnWidth="0.80" maxWidth="400"/>
		</aos:formpanel>
		
		<aos:formpanel layout="column" columnWidth="1" region="north" border="false" id="_add">
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="新增" icon="add.png" onclick="_g_add_account_onclick" />
				<aos:dockeditem text="重置" onclick="_add_account_reset" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
	</aos:window>
	

	<!-- 挑选账户加入汇总  窗口-->
	<aos:window id="w_choose_account" title="挑选账户加入汇总" onshow="_w_choose_onshow" width="1000" layout="column" >	
			<aos:formpanel layout="column" columnWidth="1" region="north" border="false" id="_account">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="筛选条件" />
			</aos:docked>
			<aos:textfield fieldLabel="账户编码" name="account_code_"  columnWidth="0.33" />
			<aos:combobox fieldLabel="账户类型" name="account_type_"  columnWidth="0.33" dicField="account_type_"/>
			<aos:textfield  fieldLabel="账户用途" name="account_purpose_" editable="false" columnWidth="0.33"  />
			<aos:combobox fieldLabel="归属业务线" name="attach_platform_name_" editable="false" columnWidth="0.33" url="summaryAccountService.platformCombobox" />
			<aos:combobox  fieldLabel="账户状态" name="account_status_" value="0" columnWidth="0.33">
				<aos:option value="1" display="启用" />
				<aos:option value="2" display="禁用" />
			</aos:combobox>	
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_account_query" />
				<aos:dockeditem text="重置" onclick="AOS.reset(_account);" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>

		<aos:gridpanel id="_g_choose_account" url="summaryAccountService.queryGatherAccountsPage" layout="column" onrender="_g_account_query" pageSize="10" columnWidth="1" height="400" region="center">
			<aos:docked forceBoder="1 0 1 0" >
				<aos:dockeditem xtype="tbtext" text="筛选结果" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:checkboxgroup fieldLabel="" columns="[0,0,0,0]">
					<aos:checkbox name="checkall2" id="checkall2" boxLabel="全选（包含所有分页中的账户）" inputValue="1" />
				</aos:checkboxgroup>
			</aos:docked>
			<aos:column type="rowno" />
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column header="账户ID" dataIndex="account_id_" hidden="true" width="80" align="center"/>
			<aos:column header="账户编码" dataIndex="account_code_" celltip="true" width="150" align="center"/>
			<aos:column header="账户类型" dataIndex="account_type_" celltip="true" width="100" align="center" rendererField="account_type_"/>
			<aos:column header="账户分组" dataIndex="group_type_" width="60" celltip="true" align="center"/>
			<aos:column header="归属业务线" dataIndex="attach_platform_name_" width="80" align="center"/>
			<aos:column header="账户用途" dataIndex="account_purpose_" width="80" align="center"/>
			<aos:column header="账面总余额" dataIndex="total_balance_" width="80" align="center"/>
			<aos:column header="创建时间" dataIndex="create_time_" width="130" align="center"/>
			<aos:column header="账户状态" dataIndex="account_status_" width="70" align="center" rendererField="accounts_status_"/>
		</aos:gridpanel>	
		
		<aos:formpanel layout="column" columnWidth="1" region="north" border="false" id="_choose">
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="新增" icon="add.png" onclick="_g_choose_account_add" />
				<aos:dockeditem text="取消" onclick="_choose_reset" icon="del2.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		</aos:window> 
		
		
		
		
		<aos:window id="w_change_account" title="修改账户加入汇总" onshow="_w_change_onshow" width="1000" layout="column" >
		
		<aos:formpanel layout="column" columnWidth="1" region="north" border="false" id="_f_del">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="筛选条件" />
			</aos:docked>
			<aos:textfield fieldLabel="账户编码" name="account_code_"  columnWidth="0.33" />
			<aos:combobox fieldLabel="账户类型" name="account_type_"  columnWidth="0.33" dicField="account_type_"/>
			<aos:textfield  fieldLabel="账户用途" name="account_purpose_" editable="false" columnWidth="0.33"  />
			<aos:combobox fieldLabel="归属业务线" name="attach_platform_name_" editable="false" columnWidth="0.33" url="summaryAccountService.platformCombobox" />
			<aos:combobox  fieldLabel="账户状态" name="account_status_" value="0" columnWidth="0.33">
				<aos:option value="1" display="启用" />
				<aos:option value="2" display="禁用" />
			</aos:combobox>	
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="查询" icon="query.png" onclick="_g_change_query" />
				<aos:dockeditem text="重置" onclick="AOS.reset(_f_del);" icon="refresh.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
		<aos:gridpanel id="_g_change_account" url="summaryAccountService.updateAccountPage" onrender="_g_change_query" pageSize="15" autoScroll="true" region="center" height="520" columnWidth="1" >
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="删除下级实体账户" />
				<aos:dockeditem xtype="tbseparator" />
				<aos:checkboxgroup fieldLabel="" columns="[0,0,0,0]">
					<aos:checkbox name="checkall" id="checkall" boxLabel="全选（包含所有分页中的账户）" inputValue="1" />
				</aos:checkboxgroup>
				
			</aos:docked>
			<aos:column type="rowno" />
			<aos:selmodel type="checkbox" mode="multi" />
			<aos:column header="账户ID" dataIndex="account_id_" hidden="true" width="80" align="center"/>
			<aos:column header="账户编码" dataIndex="account_code_" celltip="true" width="150" align="center"/>
			<aos:column header="账户类型" dataIndex="account_type_" celltip="true" width="80" align="center" rendererField="account_type_"/>
			<aos:column header="账户分组" dataIndex="group_type_" width="100" celltip="true" align="center"/>
			<aos:column header="归属业务线" dataIndex="attach_platform_name_" width="100" align="center" rendererField="reconciliation_type_"/>
			<aos:column header="账户用途" dataIndex="account_purpose_" width="80" align="center"/>
			<aos:column header="账面总余额" dataIndex="total_balance_" width="90" align="center"/>
			<aos:column header="创建时间" dataIndex="create_time_" width="120" align="center"/>
			<aos:column header="账户状态" dataIndex="account_status_" width="80" align="center" rendererField="accounts_status_"/>
		</aos:gridpanel>
	
		<aos:formpanel layout="column" columnWidth="1" region="north" border="false" id="_change">
			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem text="删除" icon="add.png" onclick="_g_change_account_onclick" />
				<aos:dockeditem onclick="#w_change_account.hide();" text="关闭" icon="close.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>
	
		</aos:window>
	</aos:viewport>

	<script type="text/javascript">

	//加载表格数据
	function _g_add_query() {	
		_g_add_account_store.loadPage(1);
	}
	

	//把treepanel属性rootExpanded="false"，则tree不会自动加载数据，需要调用这个api实现灵活的数据加载控制
	function fnLoad() {
		//在需要load的时候调用根节点的expand()方法，就会触发load()。
		idTree.getRootNode().expand();
	}
	
	//刷新树枝节点
	function refresh() {
		var refreshnode = AOS.selectone(idTree);
		if (!refreshnode) {
			refreshnode =idTree.getRootNode();
		}
		if (refreshnode.isLeaf()) {
			refreshnode = refreshnode.parentNode;
		}
		idTree_store.load({
			node : refreshnode,
			callback : function() {
				//收缩再展开才能在刷新时正确显示expanded=true的节点的子节点
				refreshnode.collapse();
				refreshnode.expand();
				idTree.getSelectionModel().select(refreshnode);
			}
		});
	}
	
	var f_change_adv='';
	var f_change_leaf = '';
	//1 加载【所有下级账户】 和刷新上面 form表单数据
	function _g_query() {
		var params = {
			cascade_ : id_cascade_.getValue()
		};
		var record = AOS.selectone(idTree);
		if(!AOS.empty(record)){
			//alert("点击的节点ID是："+record.raw.id+",层级码："+record.raw.cascade_id_); 
			params.id_ = record.raw.id;	
			params.level_code_ = record.raw.cascade_id_;
			f_change_adv= record.raw.id;
			f_change_leaf = record.raw.leaf;
		}
		
        AOS.ajax({
        	params : params ,
            url: 'summaryAccountService.getAccountInfo',
            ok: function (data) {
            	_f_detail.form.setValues(data);
            }
        });
        
		_g_param_store.getProxy().extraParams = params;
		_g_param_store.loadPage(1);
		_g_org_store.getProxy().extraParams = params;
		_g_org_store.loadPage(1);
	
	}

	
	//2 【所有下级汇总】
	function _g_param_query() {
		_g_param_store.loadPage(1);
	}
	
	//查询部门列表
	function _g_user_query() {
		var params = {
			cascade_ : id_cascade_.getValue()
		};
		var record = AOS.selectone(idTree);
		if(!AOS.empty(record)){
			params.org_id_ = record.raw.id;
			params.org_cascade_id_ = record.raw.cascade_id_;
		}
	}


	//新增业务线汇总账户
	function _g_add_account_onclick(){
		//首先判断上面三个字段不能为空	
		if (AOS.empty(f_add_.getValues().name_)) {
			AOS.tip('汇总账户名称不能为空。');
			return;
		}
		
		if (AOS.empty(f_add_.getValues().gather_purpose_)) {
			AOS.tip('汇总用途不能为空。');
			return;
		}
		
		var params = {
				name_ : f_add_.getValues().name_ ,
				gather_purpose_ : f_add_.getValues().gather_purpose_,
				id_: f_change_adv //选中的树节点id（汇总id）
		};
		
		AOS.ajax({
 	        	params : params,
				url:'summaryAccountService.createSummaryAccount',
	            ok: function (data) {
	            	AOS.tip(data.appmsg);	
	            	w_add_account.hide();
	            	f_add_.getForm().reset();
	            	refresh();	
	            }
	     });
		
	}
	
	//重置业务线汇总账户 窗口数据信息
	function _add_account_reset(){
		AOS.reset(f_add_);
		//删除新增的  已经选择的 配置下级实体账户 信息
		_g_add_account.getView().refresh(); //刷新
	}

	
    //弹出层级窗口
	function _w_add_onshow(){
		AOS.reset(f_add_);
		var record = AOS.selectone(idTree);
		
		if(!AOS.empty(record)){
			//AOS.setValue('f_add_.id_', record.raw.id); 
			AOS.setValue('f_add_.up_name_', record.raw.text); 
		}else{
			AOS.setValue('f_add_.up_name_', '根节点'); 
		}
	}
	
	

// 	//---------------------------------------------------------------------------------------------------------
    //监听修改用户窗口弹出事件
	function _w_choose_onshow(){
	
		if(!f_change_leaf){
			//AOS.tip("只能修改叶子节点");
			w_choose_account.hide();
			return;
		}
		var params = {
				id_ : f_change_adv
		};
		_g_choose_account_store.getProxy().extraParams = params;
		_g_choose_account_store.loadPage(1);
	}
	
	
	//加载账户加入汇总窗口表格数据
	function _g_account_query() {
		params ={
			id_ : f_change_adv,
			account_code_ : _account.getValues().account_code_,
			account_type_ : _account.getValues().account_type_,
			account_purpose_ : _account.getValues().account_purpose_,
			attach_platform_name_ : _account.getValues().attach_platform_name_,
			account_status_ : _account.getValues().account_status_
		},
		_g_choose_account_store.getProxy().extraParams = params;
		_g_choose_account_store.loadPage(1);	
	}
	
    
    
	//关闭挑选账户加入汇总窗口
	function _choose_reset(){
		w_choose_account.hide();
	}
	
	
	function _w_change_onshow(){
		if(!f_change_leaf){
			//AOS.tip("只能修改叶子节点");
			w_change_account.hide();
			return;
		}
		var params = {
				id_ : f_change_adv
		};
		_g_change_account_store.getProxy().extraParams = params;
 		_g_change_account_store.loadPage(1);
	}
	
	//加载修改添加账户汇总窗口
	function _g_change_query() {
		
		params ={
				id_ : f_change_adv,
				account_code_ : _f_del.getValues().account_code_,
				account_type_ : _f_del.getValues().account_type_,
				account_purpose_ : _f_del.getValues().account_purpose_,
				attach_platform_name_ : _f_del.getValues().attach_platform_name_,
				account_status_ : _f_del.getValues().account_status_
		},
		_g_change_account_store.getProxy().extraParams = params;
		_g_change_account_store.loadPage(1);
	}

	
	//选配修改页面的信息
	//获取账户加入汇总窗口数据表选择行的所有字段集合[JSON]
	function _g_choose_account_add() {		
		var selection = AOS.selection(_g_choose_account, 'account_id_');
		var params = {
				checkall :checkall2.getValue(),
				ids : selection,//选中的账户id
				id_ : f_change_adv //树结构节点 id（汇总id）
		};	
		AOS.ajax({
	        	params : params,
			url:'summaryAccountService.addSummaryAccount',
            ok: function (data) {
            	AOS.tip(data.appmsg);
            	w_change_account.hide();
            	_g_org_store.reload();
            }
    	 });
		
		//隐藏子窗口
		w_choose_account.hide();
	}
	
	
	//新增业务线汇总账户
	function _g_change_account_onclick(){
		var selection = AOS.selection(_g_change_account, 'account_id_');
		var params = {
				checkall :checkall.getValue(),
				ids : selection,//选中的账户id
				id_ : f_change_adv //树结构节点 id（汇总id）
		};
		
		AOS.ajax({
 	        	params : params,
				url:'summaryAccountService.deleteAccounts',
	            ok: function (data) {
	            	AOS.tip(data.appmsg);
	            	w_change_account.hide();
	            	_g_org_store.reload();
	            	refresh();
	            }
	     });	
	}
	
	
	//删除业务线汇总账户 窗口数据信息
	function _del_account(){
		if(AOS.empty(f_change_adv)){
			AOS.tip('请先选择需要删除的层级账户！');
			return;
		}
		
		//删除新增的  已经选择的 配置下级实体账户 信息
		var msg = AOS.merge('确认要进行删除？');
		AOS.confirm(msg,function(btn){
			if (btn === 'cancel') {
					AOS.tip('删除操作取消！');
					return;
			}	
		});	
		
		AOS.ajax({ 
			params : {
				id_: f_change_adv
			},
			url : 'summaryAccountService.deleteSummaryAccount',
			ok : function(data) {
				AOS.tip(data.appmsg);
				//刷新
				//refresh();
				//刷新页面
				window.location.href = 'do.jhtml?router=summaryAccountService.init&juid=${juid}';
			}
		});
	}
	
	</script>
</aos:onready>
