<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
.web_list_rform p {
	padding: 3px 0;
	border-bottom: 1px dotted #a4b4bc;
}

.web_list_rform {
	margin-left: 10px;
	
}

.web_list_rform p a.web_list_ra1 {
	color: #ffffff;
	background-color: #A9CF58;
}

.seled {
	color: #ffffff;
	background-color: #A9CF58;
}
.web_list_rform p a {
	color: #000;
	text-decoration: none;
	outline: none;
	cursor: pointer;
	line-height: 22px;
	display: block;
	float: left;
	margin-right: 10px;
	padding-left: 5px;
	padding-right: 5px;
	height: 22px;
	text-align: center;
}

.web_list_rform p span {
	display: block;
	float: left;
	line-height: 22px;
	padding-right: 10px;
}
#pager a{
	cursor: pointer;
}
#imgInfoBox{
	width:50%;
}
.actions{
  display: block;
  position: absolute;
  z-index: 50;
  top: 6px;
  right: 6px;
  left: 6px;
}
.actions .right{
	right:0;
	position: absolute;
}
</style>
<div class="row">
	<div class="web_list_rform col-md-8" id="search" style="margin-bottom: 5px;">
		<div class="btn-group"><input type="text" class="form-control" placeholder="站点名称(例如：人民网)" id="siteName" style="200px;"></div>
		<!-- <div class="btn-group"><input type="text" class="form-control" placeholder="规则名称(例如：反腐倡廉)" id="ruleName" style="200px;"></div> -->
		<div class="btn-group"><button class="btn btn-default " onclick="getRuleList(1);">查 询 </button></div>
	</div>
	<!-- 
	<div class="web_list_rform col-md-12 dataSource" id="filter">
		<p class="clearfix">
			<span id="sp_dataSource">数据来源</span>
			<a class="web_list_ra1" v="0">新闻</a>
			<a v="1">博客</a>
			<a v="2">论坛</a>
			<a v="3">平媒</a>
			<a v="3">微信</a>
			<a v="3">微博</a>
			<a v="3">视频</a>
		</p>
		<p class="clearfix p_weibo dataIndustry">
			<span id="sp_dataIndustry">数据行业</span>
				<a class="web_list_ra1" v="0"
				ng-click="getArticleList(0)">全部</a>
				<a v="1"
				ng-click="getArticleList(1)"><i class="icon_xina"></i>政府政务</a><a
				v="2" ng-click="getArticleList(2)"><i class="icon_tencent"></i>媒体媒介</a><a
				v="3" ng-click="getArticleList(3)"><i class="icon_twitter"></i>电子商务</a><a
				v="4" ng-click="getArticleList(4)"><i class="icon_freeweibo"></i>工业制造业</a><a
				v="5" ng-click="getArticleList(5)"><i class="icon_163weibo"></i>信息软件</a>
		</p>
	</div>
	 -->
	<div class="col-sm-12">
		<div class="superbox" id="divContent">
			
		</div>
		<div class="superbox-float"></div>
		<div class="text-center" id="pageInfo">
			<ul id="pager" class="pagination pagination-sm"></ul>
		</div>
		<div class="pull-right">
		<a href="javascript:toAddNewsGroupRuleRequirement();" class="btn btn-labeled btn-primary"> 
		<span class="btn-label"><i class="fa fa-plus-square-o"></i></span>
		没有我需要的，我想采集其他内容 </a></div>
	</div>
	<!-- /SuperBox -->
	
	<div class="superbox-show" style="height:300px; display: none"></div>
</div>
<script id="myTemplate" type="text/x-jquery-tmpl"> 
<div class="superbox-list" >
	<img src="{{html imageUrl}}" width="146" height="122"
     data-img="{{html imageUrl}}"
     url="{{html url}}" 
     title="{{html name}}" class="superbox-img">
	<div class="well" style="padding:2px;">
		<span class="site_name_cut" title="{{html name==""?"&nbsp;":name}}">{{html name==""?"&nbsp;":name}}</span><br />
	</div>
	<input type="hidden" name="id" value="{{html id}}"/>
	<input type="hidden" name="type" value="news"/>
<div class="actions"><div class="right"><a class="btn btn-primary btn-xs" href="javascript:void(0);" onclick="addOrCancelSiteRules(this,'{{html id}}')">{{html newsGroupRuleCountForThisSite>0==true?"取消":"添加"}}</a></div></div>
</div>
</script>
