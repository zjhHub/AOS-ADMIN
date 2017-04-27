<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>

<aos:html title="借款合同（菜单项）" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>

<aos:onready>
	<aos:viewport layout="border">
		<aos:formpanel id="_f_query" layout="column" labelWidth="100" header="false" region="north" border="false">
			<aos:docked forceBoder="0 0 1 0">
				<aos:dockeditem xtype="tbtext" text="筛选条件" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:textfield name="contract_id_" fieldLabel="借款合同ID" columnWidth="0.3" />
			<aos:combobox name="platform_id_" fieldLabel="归属业务线" url="comboboxService.platformCombobox" columnWidth="0.3" />
			<aos:numberfield name="contract_amount_start_" fieldLabel="合同金额起始数" columnWidth="0.15" />
			<aos:numberfield name="contract_amount_end_" fieldLabel="截止数" columnWidth="0.15" />
			<aos:textfield name="contract_code_" fieldLabel="借款合同编号" columnWidth="0.3" />
			<aos:combobox name="contract_status_" fieldLabel="合同状态" dicField="contract_status_" columnWidth="0.3" />
			<aos:textfield name="customer_name_" fieldLabel="借款人姓名" columnWidth="0.3" />
			<aos:textfield name="product_name_" fieldLabel="产品名称" columnWidth="0.3" />
			<aos:textfield name="channel_" fieldLabel="展业途径 " columnWidth="0.3" />
			<aos:textfield name="idcard_" fieldLabel="借款人身份证" columnWidth="0.3" />

			<aos:docked dock="bottom" ui="footer" margin="0 0 8 0">
				<aos:dockeditem xtype="tbfill" />
				<aos:dockeditem xtype="button" text="重置" onclick="AOS.reset(_f_query);" icon="refresh.png" />
				<aos:dockeditem xtype="button" text="筛选" onclick="_g_borrowcontract_query" icon="query.png" />
				<aos:dockeditem xtype="tbfill" />
			</aos:docked>
		</aos:formpanel>

		<aos:gridpanel id="_g_contract" forceFit="false" url="borrowContractService.listBorrowContract"
			onrender="_g_borrowcontract_query" region="center">
			<aos:docked forceBoder="1 0 1 0">
				<aos:dockeditem xtype="tbtext" text="借款合同列表" />
			</aos:docked>
			<aos:column type="rowno" />
			<aos:column header="清结算借款合同ID" dataIndex="contract_id_" width="150" />
			<aos:column header="归属业务线" dataIndex="platform_name_" width="150" />
			<aos:column header="业务线借款合同编号" dataIndex="contract_code_" width="180" />
			<aos:column header="展业途径" dataIndex="channel_" fixedWidth="150" />
			<aos:column header="借款人姓名" dataIndex="customer_name_" width="150" />
			<aos:column header="借款人身份证" dataIndex="customer_idcard_" width="180" />
			<aos:column header="产品名称" dataIndex="product_name_" width="150" />
			<aos:column header="合同金额" dataIndex="contract_amount_" type="number" width="150" />
			<aos:column header="合同状态" dataIndex="contract_status_" rendererField="contract_status_" width="100" />
			<aos:column header="状态记录" rendererFn="fn_contract_status_render" align="center" width="100" />
			<aos:column header="截留信息" rendererFn="fn_button_cut_render" align="center" width="100" />
			<aos:column header="期供信息" rendererFn="fn_button_staging_render" align="center" width="100" />
			<aos:column header="合同详情" rendererFn="fn_button_contract_render" align="center" width="100" />
		</aos:gridpanel>



		<%-- 合同状态记录 --%>
		<aos:window id="_w_contract_status" layout="border" onshow="_w_contract_status_onshow" width="500" height="600">
			<aos:panel layout="fit" region="north" border="false">
				<aos:formpanel id="_f_contract_status" layout="column" header="false" border="false">
					<aos:textfield name="contract_code_" fieldLabel="合同编号" labelAlign="left" columnWidth="0.3" labelWidth="60"
						readOnly="true" />
					<aos:combobox name="contract_status_" dicDataType="number" labelAlign="left" fieldLabel="当前状态" labelWidth="60"
						columnWidth="0.3" readOnly="true" dicField="contract_status_" />
				</aos:formpanel>
			</aos:panel>
			<aos:gridpanel id="_g_contract_status" region="center" forceFit="false"
				url="borrowContractService.listContractStatusPage">
				<aos:column type="rowno" />
				<aos:column header="变动时间" dataIndex="changing_date_" fixedWidth="180" />
				<aos:column header="变动前" dataIndex="before_" rendererField="contract_status_" width="120" />
				<aos:column header="变动后" dataIndex="after_" rendererField="contract_status_" width="120" />
			</aos:gridpanel>
		</aos:window>


		<%-- 截留窗口--%>
		<aos:window id="_w_cut_status" layout="border" onshow="_w_cut_status_onshow" width="700" height="600">
			<!-- 现状 -->
			<aos:panel id="_w_p_adv" region="north" layout="fit" height="90">
			</aos:panel>

			<!--历史 -->
			<aos:gridpanel id="_g_cut_history_status" forceFit="false" url="borrowContractService.listHistoryCutStatusPage"
				region="center">
				<aos:column type="rowno" />
				<aos:column header="截留科目" dataIndex="name_" fixedWidth="120" />
				<aos:column header="变动前" dataIndex="before_amount_" type="number" width="120" />
				<aos:column header="变动金额" dataIndex="changing_amount_" type="number" width="120" />
				<aos:column header="变动后" dataIndex="after_amount_" type="number" width="120" />
				<aos:column header="变动时间" dataIndex="changing_date_" width="150" />
			</aos:gridpanel>
		</aos:window>

		<%-- 期供窗口--%>
		<aos:window id="_w_staging" layout="fit" onshow="_w_staging_onshow" width="700" height="600">
		</aos:window>



		<%-- 应收已收流水记录 --%>
		<aos:window id="_w_receivable_amount" layout="fit" width="450" height="500">
			<aos:gridpanel id="_g_receivable_amount" url="borrowContractService.subjectHistoryPage" forceFit="false">

				<aos:column header="变动前" dataIndex="before_amount_" width="180" />
				<aos:column header="变动金额" dataIndex="changing_amount_" width="180" />
				<aos:column header="变动后" dataIndex="after_amount_" width="180" />
				<aos:column header="变动时间" dataIndex="changing_date_" width="180" />
				<aos:column header="变动起因" dataIndex="flow_biz_id_" width="180" />
			</aos:gridpanel>
		</aos:window>

		<%-- 分期状态记录 --%>
		<aos:window id="_w_staging_status" layout="border" width="500" height="600">
			<aos:panel layout="fit" region="north" border="false">
				<aos:formpanel id="_f_staging_status" layout="column" header="false" border="false">

					<aos:textfield name="field_fixed_3" labelAlign="left" fieldLabel="当前状态" labelWidth="60" columnWidth="0.3"
						readOnly="true" />
				</aos:formpanel>
			</aos:panel>

			<aos:gridpanel id="_g_staging_status" forceFit="false" region="center"
				url="borrowContractService.listStagingStatusPage">
				<aos:column type="rowno" />
				<aos:column header="变动时间" dataIndex="changing_date_" fixedWidth="180" />
				<aos:column header="变动前" dataIndex="before_" rendererField="staging_status_" width="120" />
				<aos:column header="变动后" dataIndex="after_" rendererField="staging_status_" width="120" />
			</aos:gridpanel>


		</aos:window>


		<!-- 		合同详情 -->
		<aos:window id="_w_contract_detail"  autoScroll="true" onshow="_w_contract_detail_onshow" layout="border" width="850"
			height="800">
			<aos:panel layout="fit" region="north">
				<aos:formpanel id="_f_ontract_detail">
					<aos:fieldset title="合同摘要" labelWidth="90" columnWidth="1">
						<aos:textfield name="id_" fieldLabel="借款合同ID" readOnly="true" columnWidth="0.5" />
						<aos:combobox name="status_" fieldLabel="合同状态" readOnly="true" columnWidth="0.5" dicField="contract_status_"
							dicDataType="number" />
						<aos:textfield name="contract_code_" fieldLabel="借款合同编号" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="settle_count_" fieldLabel="已结清期数" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="platform_name_" fieldLabel="归属业务线"  readOnly="true" columnWidth="0.5" />
						<aos:textfield name="overdue_day_" fieldLabel="当前逾期天数" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="channel_" fieldLabel="展业途径" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="overdue_count_" fieldLabel="历史逾期次数" readOnly="true" columnWidth="0.5" />
					</aos:fieldset>
					<aos:fieldset title="借款人信息" labelWidth="90" columnWidth="1">
						<aos:textfield name="customer_code_" fieldLabel="借款人编号" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="customer_idcard_" fieldLabel="借款人身份证" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="customer_name_" fieldLabel="借款人姓名" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="customer_cellphone_" fieldLabel="借款人手机号" readOnly="true" columnWidth="0.5" />
					</aos:fieldset>
					<aos:fieldset title="产品信息" labelWidth="90" columnWidth="1">
						<aos:textfield name="product_code_" fieldLabel="产品ID" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="annualized_rate_" fieldLabel="年华利率" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="product_name_" fieldLabel="产品名称" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="contract_amount_" fieldLabel="合同签约本金" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="loan_pattern_" fieldLabel="借款方式" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="expected_interest_" fieldLabel="预计可收利息" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="loan_staging_amount_" fieldLabel="借款期数" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="expected_fee_" fieldLabel="预计可收服务费" readOnly="true" columnWidth="0.5" />
						<aos:textfield name="loan_staging_duration_" fieldLabel="借款期数单位" readOnly="true" columnWidth="0.5" />
					</aos:fieldset>
				</aos:formpanel>
			</aos:panel>
			<aos:gridpanel id="_g_contract_count" url="borrowContractService.getContractCategoryPage" forceFit="false"
				region="center">
				<aos:column header="财务冲销科目" dataIndex="category_name_" width="180" />
				<aos:column header="应收合计" dataIndex="receivable_amount_" width="180" type="number" />
				<aos:column header="已收合计" dataIndex="received_amount_" width="180" type="number" />
				<aos:column header="未收合计" dataIndex="unreceived_amount_" width="180" type="number" />
				<aos:column header="剩余合计" dataIndex="remainder_amount_" width="180" type="number" />
			</aos:gridpanel>
		</aos:window>
	</aos:viewport>

	<script type="text/javascript">
		//加载主合同表格数据
		function _g_borrowcontract_query() {
			var params = AOS.getValue('_f_query');
			_g_contract_store.getProxy().extraParams = params;
			_g_contract_store.loadPage(1);
		}
		//监听合同状态窗口弹出表格刷新
		function _g_contract_status_query() {
			var record = AOS.selectone(_g_contract);
			var params = {
				contract_id_ : record.data.contract_id_
			}
			_g_contract_status_store.getProxy().extraParams = params;
			_g_contract_status_store.loadPage(1);
		}

		//监听截留状态窗口弹出表格刷新
		function _g_cut_query() {
			var record = AOS.selectone(_g_contract);
			var params = {
				contract_id_ : record.data.contract_id_
			}

			_g_cut_history_status_store.getProxy().extraParams = params;
			_g_cut_history_status_store.loadPage(1);

		}

		function createAdvCellGrid(data, contract_code_) {

			return Ext.create('Ext.grid.Panel', {
				selModel : Ext.create('Ext.selection.CellModel', {
					singleSelect : true
				}),
				stripeRows : true,
				// 				closeAction : 'destroy',
				store : Ext.create('Ext.data.Store', {
					fields : data.fields,
					data : data.data

				}),
				columns : data.columns,
				listeners : {

					'cellclick' : function(g, td, cellIndex, record, tr, rowIndex, e, eOpts) {
						var column = g.getHeaderAtIndex(cellIndex);
						var fieldName = column.dataIndex;

						if (column.adv_show != null && "" != column.adv_show) {

							if (column.adv_show == 'adv_show_receivedAndReceivable') {

								var subject_id = record.get("subject_id_"
										+ fieldName.substring(fieldName.lastIndexOf('_') + 1));

								var params = {
									fieldName : fieldName,
									subject_id : subject_id
								}

								_g_receivable_amount_store.getProxy().extraParams = params;
								_g_receivable_amount_store.loadPage(1);

								_w_receivable_amount.setTitle('借款合同 ' + contract_code_ + record.data.field_fixed_0
										+ column.adv_subject_name + "的变动记录");

								_w_receivable_amount.show();
								_w_receivable_amount.on('close',function(){
									_g_receivable_amount_store.removeAll();
								});
							} else if (column.adv_show == "adv_show_staging") {
								
								_f_staging_status.loadRecord(record);

								var params = {
									staging_id : record.raw.field_hidden_1
								}
								
								_g_staging_status_store.getProxy().extraParams = params;
								_g_staging_status_store.loadPage(1);

								_w_staging_status.setTitle('借款合同 ' + contract_code_ + record.data.field_fixed_0
										+ "的分期状态变动记录");

								_w_staging_status.show();
								_w_staging_status.on('close',function(){
									_g_staging_status_store.removeAll();
								});

							}

						}
					}
				}

			});

		}
		function createAdvGrid(data) {
			return Ext.create('Ext.grid.Panel', {
				// 				closeAction : 'destroy',
				store : Ext.create('Ext.data.Store', {
					fields : data.fields,
					data : data.data

				}),
				columns : data.columns
			});

		}

		//合同状态记录窗口
		function _w_contract_status_onshow() {
			var record = AOS.selectone(_g_contract);
			_f_contract_status.loadRecord(record);
			_g_contract_status_query();

		}

		//截留窗口
		function _w_cut_status_onshow() {
			var record = AOS.selectone(_g_contract);
			// 			alert(record.data.contract_status_);
			var contract_code_ = record.data.contract_code_;
			_w_cut_status.setTitle('借款合同 ' + contract_code_ + '的截留信息');

			_g_cut_query();

			//获取动态表格元素
			AOS.ajax({
				url : 'borrowContractService.listCurrentCutStatusPage',
				params : {
					contract_id_ : record.data.contract_id_
				},
				ok : function(data) {
					_w_p_adv.items.removeAll();
					_w_p_adv.items.add(createAdvGrid(data));
					_w_cut_status.doLayout();
					_w_cut_status.on('close',function(w){
						w.down('grid').store.removeAll();
					});
				}
			});
			//控制窗口大小改变刷新布局
			_w_cut_status.on('resize', function(w) {
				w.doLayout();
			});

		}
	
		//期供窗口
		function _w_staging_onshow() {
			var record = AOS.selectone(_g_contract);
			var contract_code_ = record.data.contract_code_;
			_w_staging.setTitle('借款合同 ' + contract_code_ + '的期供信息');

			//获取动态表格元素
			AOS.ajax({
				url : 'borrowContractService.listStaging',
				params : {
					contract_id_ : record.data.contract_id_
				},
				ok : function(data) {
										var colums = data.columns;
										var count=0;
										for (var i = 0; i < colums.length; i++) {
											if(!colums[i].hidden)
												count++;
										}
										
										for (var i = 0; i < colums.length; i++) {
											colums[i].renderer = function(value, cellmeta, record, rowIndex, colIndex) {
// 								
												
												if ((colIndex>=2&&colIndex<count-3)||colIndex==count-2) {
													
													return '<font style="TEXT-DECORATION: underline"  >'+ value + '</font>';

				
												}
												return value;
											}
										}
					_w_staging.items.removeAll();
					_w_staging.items.add(createAdvCellGrid(data, contract_code_));
					_w_staging.doLayout();
				}
			});
			//控制窗口大小改变刷新布局
			_w_staging.on('resize', function(w) {
				w.doLayout();
			});

		}

		//获取选中行，初始化合同详情
		function _w_contract_detail_onshow() {

			var record = AOS.selectone(_g_contract);
			_w_contract_detail.setTitle('借款合同 ' + record.data.contract_code_ + '的详情');
			AOS.ajax({
				params : {
					contract_id_ : record.data.contract_id_
				},
				url : 'borrowContractService.getContractDetail',
				ok : function(data) {
					_f_ontract_detail.form.setValues(data);
				}
			}); //合同状态记录窗口
			var params = {
				contract_id_ : record.data.contract_id_
			}
			_g_contract_count_store.getProxy().extraParams = params;
			_g_contract_count_store.loadPage(1);

		}
		//状态记录按钮
		function fn_contract_status_render(value, metaData, record, rowIndex, colIndex, store) {
			return '<input type="button" value="状态记录" class="cbtn" onclick="_w_contract_status_show();" />';
		}

		//截留按钮
		function fn_button_cut_render(value, metaData, record, rowIndex, colIndex, store) {
			return '<input type="button" value="截留" class="cbtn" onclick="_w_cut_show();" />';
		}

		//期供按钮
		function fn_button_staging_render(value, metaData, record, rowIndex, colIndex, store) {
			return '<input type="button" value="期供" class="cbtn" onclick="_w_staging_show();" />';
		}
		//调阅按钮
		function fn_button_contract_render(value, metaData, record, rowIndex, colIndex, store) {
			return '<input type="button" value="调阅" class="cbtn" onclick="_w_contract_detail_show();" />';
		}
	</script>
</aos:onready>

<script type="text/javascript">
	//状态记录
	function _w_contract_status_show() {
		Ext.getCmp('_w_contract_status').show();
	}
	//截留窗口
	function _w_cut_show() {
		Ext.getCmp('_w_cut_status').show();
	}
	//分期窗口
	function _w_staging_show() {
		Ext.getCmp('_w_staging').show();
	}
	//合同详情窗口
	function _w_contract_detail_show() {
		Ext.getCmp('_w_contract_detail').show();
	}
	//应收记录窗口
	function _w_receivable_amount_show(subject_id) {
		var _w_receivable_amount = Ext.getCmp('_w_receivable_amount');
		alert(subject_id);
		_w_receivable_amount.name = "_w_receivable_amount" + subject_id;
		_w_receivable_amount.show();
	}
</script>