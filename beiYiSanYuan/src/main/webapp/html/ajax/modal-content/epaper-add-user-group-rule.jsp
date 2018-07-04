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
<div class="superbox-list" style="width:13%">
	<img src="/news/showRuleImage?id={{html id}}"  width="110px" height="110px"
     data-img="/news/showRuleImage?id={{html id}}"
     url="{{html paperUrl}}" 
     alt="{{html frequency}}" 
     title="{{html site}}" class="superbox-img">
	<div class="well" style="padding:2px;">
		<span class="section_name_cut" title="{{html paper==""?"&nbsp;":paper}}">{{html paper==""?"&nbsp;":paper}}</span>
	</div>
	<div class="actions"><div class="right"><a class="btn btn-primary btn-xs" href="javascript:void(0);" onclick="addOrCancelRules(this,{{html epaperGroupRuleFlag}},'{{html id}}')">{{html epaperGroupRuleFlag==true?"取消":"添加"}}</a></div></div>
</div>
</script>