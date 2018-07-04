<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="superbox" id="ruledivContent">
			
</div>
<div class="superbox-float"></div>
<div class="text-center" id="pageInfo">
	<ul id="rulepage" class="pagination pagination-sm"></ul>
</div>
<script id="myRuleTemplate" type="text/x-jquery-tmpl"> 
<div class="superbox-list">
	<img src="{{html imageUrl}}"   width="85" height="110"
     data-img="{{html imageUrl}}"
     url="{{html sectionUrl}}" 
     alt="{{html frequency}}" 
     title="{{html site}}" class="superbox-img">
	<div class="well" style="padding:2px;">
		<span class="section_name_cut" title="{{html section==""?"&nbsp;":section}}">{{html section==""?"&nbsp;":section}}</span>
	</div>
	<div class="actions"><div class="right"><a class="btn btn-primary btn-xs" href="javascript:void(0);" onclick="addOrCancelRules(this,{{html newsGroupRuleFlag}},'{{html id}}')">{{html newsGroupRuleFlag==true?"取消":"添加"}}</a></div></div>
</div>
</script>