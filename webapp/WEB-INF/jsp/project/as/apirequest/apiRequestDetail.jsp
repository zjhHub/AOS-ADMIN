<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tags.jsp"%>
<aos:html title="API请求监控详情" base="http" lib="ext">
<aos:body>
</aos:body>
</aos:html>
<aos:onready>
	<aos:viewport layout="border">
		<aos:panel region="north">
			<aos:formpanel id="rsp_info" layout="column" 
				labelWidth="800">
				<aos:fieldset title="Post请求信息摘要" labelWidth="100" columnWidth="1"
					margin="0 10 0 0">
					<aos:textfield name="uuid_" fieldLabel="请求ID" value="${po['uuid_']}"
						maxLength="50" readOnly="true" columnWidth="0.5" />
					<fmt:formatDate value="${po['response_time_']}" pattern='yyyy-MM-dd HH:mm:ss' var="response_time_"/>
					<aos:textfield name="response_time_" fieldLabel="响应时间" readOnly="true" value="${response_time_ }"
						columnWidth="0.44" />
					<fmt:formatDate value="${po['time_']}" pattern='yyyy-MM-dd HH:mm:ss' var="time_"/>
					<aos:textfield name="time_" fieldLabel="请求时间" readOnly="true" value="${time_ }"  
						columnWidth="0.5" />
					<aos:textfield  fieldLabel="响应码" readOnly="true" value="${po['response_code_']}"
						columnWidth="0.5" />
					<aos:textfield  fieldLabel="归属业务线" readOnly="true" value="${po['platform_id_']}"
						columnWidth="0.5" />
					<aos:textfield name="summary_" fieldLabel="响应摘要" readOnly="true" value="${po['summary_']}"
						columnWidth="0.44" />
					<aos:combobox name="service_code_" fieldLabel="所调API接口" value="${po['service_code_']}" dicField="api_interface_" editable="false"
						readOnly="true" columnWidth="0.5" />
					<aos:textfield name="message_" fieldLabel="响应消息" readOnly="true" value="${po['message_']}"
						columnWidth="0.44" />
					<aos:textfield name="process_duration_" fieldLabel="处理时长" readOnly="true" value="${po['process_duration_']}ms"
						columnWidth="0.5" />
				</aos:fieldset>
			</aos:formpanel>
		</aos:panel>
			
		<aos:tabpanel id="_tabpanel" region="center" activeTab="0" bodyBorder="0 0 0 0" tabBarHeight="30">
			<aos:tab title="请求内容" id="_tab_org">
				<aos:textareafield value='${po["content_"]}' fieldLabel="" readOnly="true" />
			</aos:tab>

			<aos:tab title="响应内容" id="_tab_param">
				<aos:textareafield value='${po["response_content_"]}' fieldLabel="" readOnly="true" />
			</aos:tab>
		</aos:tabpanel>
	</aos:viewport>
</aos:onready>

