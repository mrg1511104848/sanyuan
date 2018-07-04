<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/js/plugin/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<style>
	.forms{display:none;}
	.primaryKeyForms{display:none;}
	.over500hidden{
		max-height:500px;overflow-y:scroll;
	}
	.over600hidden{
		max-height:600px;overflow-y:scroll;
	}
	.page2,.page3{
		display:none;
	}
	.input{
		margin-bottom:10px;
	}
	.ztree{
		font-style:normal;
	}
	.ztree li span.button{
		padding:0;
	}
	.menuContent {
		border: 1px solid #ccc;
		background: #f0f6e4;
		box-shadow: -5px 5px 20px 5px rgba(0,0,0,.2);
		height: 360px;
		overflow-y: scroll;
		overflow-x: auto;
		scrollbar-face-color: green; 
		scrollbar-hightLight-color: red; 
		scrollbar-3dLight-color: orange; 
		scrollbar-darkshadow-color:blue; 
		scrollbar-shadow-color:yellow; 
		scrollbar-arrow-color:purple; 
		scrollbar-track-color:black; 
		scrollbar-base-color:pink; 
	}
	.senior-write{
		cursor:pointer;
	}
</style>

<div class="page1 over600hidden">
	<div class="modal-header">
		<h4 class="modal-title" id="myModalLabel">
			分发策略编辑
		</h4>
	</div>
	<div class="modal-body">
		<div class="row">
			<div class="col-md-12">
				<form id="frmApp" name="frmApp" class="smart-form">
					<input type="hidden" name="id" id="txt_id"
						value="${distributionStrategy.id }" />
					<input type="hidden" name="columnId" id="txt_columnId"
						value="${distributionStrategy.columnId }" />
					<input type="hidden" name="siteId" id="txt_siteId"
						value="${distributionStrategy.siteId }" />	
					<input type="hidden" name="userId" id="txt_userId"
						value="${distributionStrategy.userId }" />
					<input type="hidden" name="formName" id="txt_formName"
						value="${distributionStrategy.formName }" />
					<input type="hidden"  id="txt_propertyMapping"
						value="${distributionStrategy.propertyMapping }" />	
					<input type="hidden"  id="txt_filter"
						value="${distributionStrategy.filter }" />
					<input type="hidden" name="lastArticleTimestamp" id="txt_lastArticleTimestamp"
						value="${distributionStrategy.lastArticleTimestamp==null?0:distributionStrategy.lastArticleTimestamp }" />
					<input type="hidden" name="siteDeepIds" id="siteDeepIds" value="${distributionStrategy.siteDeepIds }"/>
					<input type="hidden" name="columnDeepIds" id="columnDeepIds" value="${distributionStrategy.columnDeepIds }"/>
					<input type="hidden"  id="selectGroupId" value="${selectGroupId }"/>
					<label class="label">
						名称
					</label>
					<label class="input">
						<input type="text" name="name" id="txt_name"
						value="${distributionStrategy.name}" />
					</label>	
					<label class="label" style="display:none;">
						分组
					</label>
					<label class="input" style="display:none;">
						<select name="groupId" class="form-control" value="${distributionStrategy.groupId }">
							<option value=" ">请选择</option>
							<c:forEach items="${groups }" var="group">
								<option value="${group.id }">${group.name }</option>
							</c:forEach>
						</select>
					</label>
					
					
					<div class="row">
						<section class="col col-10" style="margin:0px;">
						<label class="label">
							应用
						</label>
						<label class="input">
							<select name="appId" class="form-control" value="${distributionStrategy.appId }" >
								<option value=" ">请选择</option>
								<c:forEach items="${apps }" var="app">
									<option value="${app.id }">${app.name }</option>
								</c:forEach>
							</select>
						</label>
						</section>
						<section class="col col-2">
							<label class="label">&nbsp;</label>
							<label class="input">
								<a href="javascript:;" title="添加应用" class="btn btn-primary btn-circle" onclick="addApp(this)"><i class="fa fa-plus"></i></a>
							</label>
						</section>
					</div>
					<label class="label" style="display:none;">
						时间戳
					</label>
					<label class="input"  style="display:none;">
						<input type="text" id="lastArticleTimestamp" class="form-control"  disabled="disabled" id="txt_lastArticleTimestamp"
						value="${distributionStrategy.lastArticleTimestamp }" />
					</label>
					<label class="label notdb">
						站点
					</label>
					<label class="input notdb">
						<!--<select name="siteId" class="form-control" value="${distributionStrategy.siteId}">
						</select>
						-->
						<input type="text" name="siteName" relationName="siteId" trigger="getAllColumns" value="${distributionStrategy.siteName}"  id="txtKeyword" readonly="readonly" placeholder="点击此处可选择关键词" class="form-control txtClassBox selectBox" style="cursor: pointer" onclick="showMenu(this,'menuContent');"/>
					</label>
					
					<label class="label notdb">
						栏目
					</label>
					<label class="input notdb">
						<input type="text" name="columnName" relationName="columnId" trigger="getAllForms" value="${distributionStrategy.columnName}"  id="txtKeyword2" readonly="readonly" placeholder="点击此处可选择关键词" class="form-control txtClassBox selectBox" style="cursor: pointer" onclick="showMenu(this,'menuContent2');"/>
					</label>
					
					<label class="label ">
						表单
					</label>
					<label class="input ">
						<select name="formId" class="form-control"
						 value="${distributionStrategy.formId}"
						 formKey="${distributionStrategy.formKey}"
						 >
						</select>
					</label>
					<div id="primaryKeyForms" primaryKeyName="${distributionStrategy.primaryKeyName }">
						<label class="label">主键</label>
						<label class="input">
							<select class="form-control" name="primaryKeyName" value="${distributionStrategy.primaryKeyName }">
								<option value="">请选择</option>
							</select>
						</label>
					</div>
					<div id="forms">
					</div>
					
			</div>
			</form>
		</div>
	</div>
</div>
<div class="page2 over500hidden">
	<div class="modal-header">
		<h4 class="modal-title" id="myModalLabel">
			过滤条件<font style="font-size:12px;color:#b94a48;">(注:多值间可用逗号区分)</font>
		</h4>
	</div>
	<div class="modal-body">
		<div class="row">
			<div class="col-md-12">
				<form id="frmApp2" name="frmApp2" class="smart-form">
					<div class="row">
						<section class="col col-5">
							<label class="toggle state-error"><input type="checkbox" name="andOrFlag" value="${distributionStrategy.andOrFlag }" class="andOrFlag"><i data-swchon-text="AND" data-swchoff-text="OR"></i>开关(AND/OR)</label>
						</section>
					</div>
					<div class="row">
						<section class="col col-3">
							<label class="label">字段名</label>
							<label class="input">
								<select class="form-control mongofields" name="mongofields">
								</select>
							</label>
						</section>
						<section class="col col-3">
							<label class="label">条件</label>
							<label class="input">
								<select class="form-control conditions" name="coditions">
									<option value="">请选择</option>
									<option value="eq_">等于</option>
									<option value="l_">包含</option>
									<option value="s_">大于</option>
									<option value="e_">小于</option>
									<option value="sw_">以..开始</option>
									<option value="ew_">以..结束</option>
									<option value="i_">在范围中</option>
									<option value="o_l_">多值包含(或者)</option>
									<option value="o_eq_">多值等于(或者)</option>
								</select>
							</label>
						</section>
						<section class="col col-3">
							<label class="label">值</label>
							<label class="input">
								<input type="text" class="form-control values" name="values"/>
							</label>
						</section>
						<section class="col col-2">
							<label class="label">&nbsp;</label>
							<label class="input">
								<a href="javascript:;" class="btn btn-primary btn-circle" onclick="addNewRow(this,'cloned3')"><i class="fa fa-plus"></i></a>
							</label>
						</section>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="page3 over500hidden">
	<div class="modal-header">
		<h4 class="modal-title">
			定时采集设置
		</h4>
	</div>
	<div class="modal-body" style="padding-top: 0px;">
		<div class="row">
			<div class="col-md-12">
				<form id="frmApp3" name="frmApp3" class="smart-form">
					<fieldset style="padding-top: 20px;border: 0;">
						<div class="row">
							<section class="col col-4">
								<label class="toggle state-error"　style="width:100px;"><input type="checkbox" name="timerOnOffFlag" value="${distributionStrategy.timerOnOffFlag }" class="timerOnOffFlag"><i data-swchon-text="开启" data-swchoff-text="关闭"></i>状态　　</label>
							</section>
						</div>
					</fieldset>
					
					<fieldset id="collect_plan"  style="padding-top: 10px;border: 0;" timerMode="${distributionStrategy.timerMode }" timerExpression="${distributionStrategy.timerExpression }" >
						<div class="row">
							<section class="col col-4">
								<label class="toggle state-error" 　style="width:100px;"><input type="checkbox" name="tmp_timerMode" value="${distributionStrategy.timerMode }" onclick="collect_plan_change(this)" class="ckbox_mode"><i data-swchon-text="高级" data-swchoff-text="基本"></i>采集模式</label>
							</section>
						</div>
						<div class="row">
							<div class="col-6 ">
									<select class="form-control collect_plan" >
										<option value="">请选择</option>
										<option value="0 */10 * * * ?">每10分钟</option>
										<option value="0 */20 * * * ?">每20分钟</option>
										<option value="0 */30 * * * ?">每30分钟</option>
										<option value="0 */40 * * * ?">每40分钟</option>
										<option value="0 */50 * * * ?">每50分钟</option>
										<option value="0 0 */1 * * ?">每60分钟</option>
									</select>				
							</div>
							<div class="col col-2 senior-write">
								<a href="/distribution-strategies/api.html"  target="_blank">
									<i class="fa fa-question-circle fa-2x"  style="    margin-top: 13px;" title="点击查看帮助文档" ></i>
								</a>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="row cloned1" style="display:none;">
	<section class="col col-5">
		<label class="label">源表单(云采集平台)</label>
		<label class="input">
			<select class="form-control mongofields sourcePropertys">
				<option></option>
			</select>
		</label>
	</section>
	<section class="col col-5">
		<label class="label">目标表单(非云采集平台)</label>
		<label class="input">
			<select class="form-control targetPropertys">
				<option></option>
			</select>
		</label>
	</section>
	<section class="col col-2">
		<label class="label">&nbsp;</label>
		<label class="input">
			<a href="javascript:;" class="btn btn-primary btn-circle" onclick="addNewRow(this,'cloned2')"><i class="fa fa-plus"></i></a>
		</label>
	</section>
</div>
<div class="row cloned2" style="display:none;">
	<section class="col col-5">
		<label class="input">
			<select class="form-control mongofields sourcePropertys" >
			</select>
		</label>
	</section>
	<section class="col col-5">
		<label class="input">
			<select class="form-control targetPropertys">
			</select>
		</label>
	</section>
	<section class="col col-2">
		<label class="input">
			<a href="javascript:;" class="btn btn-primary btn-circle" onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
		</label>
	</section>
</div>
<div class="row cloned3" style="display:none;">
	<section class="col col-3">
		<label class="input">
			<select class="form-control mongofields" name="mongofields">
			</select>
		</label>
	</section>
	<section class="col col-3">
		<label class="input">
			<select class="form-control conditions" name="coditions">
				<option value="">请选择</option>
				<option value="eq_">等于</option>
				<option value="l_">包含</option>
				<option value="s_">大于</option>
				<option value="e_">小于</option>
				<option value="sw_">以..开始</option>
				<option value="ew_">以..结束</option>
				<option value="i_">在范围中</option>
				<option value="o_l_">多值包含(或者)</option>
				<option value="o_eq_">多值等于(或者)</option>
			</select>
		</label>
	</section>
	<section class="col col-3">
		<label class="input">
			<input type="text" class="form-control values"  name="values"/>
		</label>
	</section>
	<section class="col col-2">
		<label class="input">
			<a href="javascript:;" class="btn btn-primary btn-circle" onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
		</label>
	</section>
</div>
<div class="row cloned4"  style="display:none;">
	<section class="col col-3">
		<label class="label">字段名</label>
		<label class="input">
			<select class="form-control mongofields" name="mongofields">
				<option value=" ">请选择</option>
			</select>
		</label>
	</section>
	<section class="col col-3">
		<label class="label">条件</label>
		<label class="input">
			<select class="form-control conditions" name="coditions">
				<option value="">请选择</option>
				<option value="eq_">等于</option>
				<option value="l_">包含</option>
				<option value="s_">大于</option>
				<option value="e_">小于</option>
				<option value="sw_">以..开始</option>
				<option value="ew_">以..结束</option>
				<option value="i_">在范围中</option>
				<option value="o_l_">多值包含(或者)</option>
				<option value="o_eq_">多值等于(或者)</option>
			</select>
		</label>
	</section>
	<section class="col col-3">
		<label class="label">值</label>
		<label class="input">
			<input type="text" class="form-control values" name="values"/>
		</label>
	</section>
	<section class="col col-2">
		<label class="label">&nbsp;</label>
		<label class="input">
			<a href="javascript:;" class="btn btn-primary btn-circle" onclick="addNewRow(this,'cloned3')"><i class="fa fa-plus"></i></a>
			</label>
	</section>
</div>
<div class="row cloned5" style="display:none;">
	<div class="col col-6 " style="padding-top:10px;">
		<select class="form-control collect_plan">
			<option value="">请选择</option>
			<option value="0 */10 * * * ?">每10分钟</option>
			<option value="0 */20 * * * ?">每20分钟</option>
			<option value="0 */30 * * * ?">每30分钟</option>
			<option value="0 */40 * * * ?">每40分钟</option>
			<option value="0 */50 * * * ?">每50分钟</option>
			<option value="0 0 */1 * * ?">每60分钟</option>
		</select>
	</div>
	<a href="/distribution-strategies/api.html"  target="_blank">
		<i class="fa fa-question-circle fa-2x"  style="    margin-top: 13px;" title="点击查看帮助文档" ></i>
	</a>
</div>
<div class="row cloned6" style="display:none;">
	<div class="col col-6 "  style="padding-top:10px;">
		<input type="text" class="form-control collect_plan"/>			
	</div>
	<a href="/distribution-strategies/api.html" target="_blank">
		<i class="fa fa-question-circle fa-2x"  style="    margin-top: 13px;" title="点击查看帮助文档" ></i>
	</a>
</div>
<div class="row cloned7" style="display:none;">
	<label class="label ">
		主键
	</label>
	<label class="input ">
		<select class="form-control select_primaryKey">
		</select>
	</label>
</div>

<div id="remoteModal" style="display: none;"></div>
<script type="text/javascript" src="/resources/js/app-common.js"></script>
<script type="text/javascript" src="/resources/js/plugin/ztree/js/jquery.ztree.core-3.5.js"></script>
<script>
	$(function() {	
		init();
	});
	var setting = {
		async:{
            autoParam:["id=pId", "name"],
            enable:true,
            url:getAsyncUrl,
            type:'post'
        } ,
		view: {
			dblClickExpand: false,
			showLine: true,
			selectedMulti: false
		},
		data: {
			simpleData: {
				enable:true,
				idKey: "id",
				pIdKey: "pId",
				rootPId: ""
			}
		},
		callback: {
			onClick : onClick,
			onAsyncSuccess: asyncSuccess
		}
	};
	function getAppType(){
		var appid = $("select[name='appId']").val();
		var url = '/app/getById?id='+appid;
		var appProductCategory;
		$.ajax({
			url:url,
			dataType:'json',
			async:false,
			success:function(d){
				if(d&&d.app){
					appProductCategory = d.app.productCategory;
				}
			}
			})
		return appProductCategory;
	}
	function getAsyncUrl(treeId, treeNode) {
		var currClickTreeUrl;
		if(treeId=="tree2"){
			currClickTreeUrl = "/distribution-strategies/getColumnsByParentColumnId.html";
		}else{
			currClickTreeUrl = "/distribution-strategies/getSitesByParentSiteId.html";
		}
		return currClickTreeUrl+'?appId='+$("[name=appId]").val()+"&siteId="+$("[name=siteId]").val();
	};
	function showMenu(obj,menuId) {
		$(".txtClassBox").removeClass("selectBox");
		var keyObj = $(obj);
		keyObj.addClass("selectBox");// 为获得焦点的控件增加样式
		var cityOffset = keyObj.offset();
		$("#"+menuId).css( {
			left : cityOffset.left + "px",
			top : cityOffset.top + keyObj.outerHeight() + "px"
		}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	}
	function hideMenu() {
		$(".menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	//异步展开全部
	function asyncSuccess(event, treeId, treeNode, msg){
		try{
			var deepObj = "siteDeepIds";
			if(treeId=="tree2"){
				deepObj = "columnDeepIds";
			}
			var treeObj = $.fn.zTree.getZTreeObj(treeId);
			var nodes = treeNode.children;
	        for(var i=0;i<nodes.length;i++){
	        	var nid = nodes[i].id;
	        	var deepIds = $("#"+deepObj).val();
	        	deepIds = deepIds.split(",");
	        	var lastDeepId = deepIds[deepIds.length-1];
	        	if(nid==lastDeepId){
	        		treeObj.selectNode(nodes[i],false);
	        		break;
	        	}
	            treeObj.expandNode(nodes[i],true,false,true,true);
	        }
        }catch(e){}
	}
	function onClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj(treeId),
		nodes = zTree.getSelectedNodes(),cityObj = null,v = "";
		nodes.sort(function compare(a,b){return a.id-b.id;});
		for (var i=0, l=nodes.length; i<l; i++) {
			v += nodes[i].name + ",";
		}
		if (v.length > 0 ) v = v.substring(0, v.length-1);
		
		if(treeId=="tree2"){
			cityObj = $("#txtKeyword2");
		}else{
			cityObj = $("#txtKeyword");
		}
		var relationName = cityObj.attr("relationName");
		$("[name="+relationName+"]").val(treeNode.id);
		var trigger = cityObj.attr("trigger");
		callFunction(trigger);
		cityObj.val(v);
	}
	function onBodyDown(event) {
		if (!(event.target.id == "txtKeyword" 
			|| event.target.id == "txtKeyword2" 
					|| event.target.id == "menuContent" 
							|| $(event.target).parents("#menuContent").length > 0
							|| $(event.target).parents("#menuContent2").length > 0)){
			hideMenu();
		}
	}
	
	function init(){
		
		initFormValues();
		
		dealTree();
		//根据appId获取sites
		getAllSites();
		//appId change事件
		$("select[name='appId']").change(function(){
			$("[name=formId]").val("");
			$("[name=formId]").empty();
			$("[name=siteName]").val("");
			$("[name=columnName]").val("");
			$(".hide_forms").hide();
			$("#txt_propertyMapping").val("");
			initItemsWidthApp();
		})
		$("input[name='siteName']").change(function(){
			//genOptionV('siteId','txt_siteName');
			//getAllColumns();
		})
		$("select[name='columnId']").change(function(){
			genOptionV('columnId','txt_columnName');
			getAllForms();
		})
		$("select[name='formId']").change(function(){
			genOptionV('formId','txt_formName');
			var idx = $(this).find("option:selected").index("select[name='formId'] option")-1;//之所以-1是为了去掉请选择那个选项
			showFormDetail(idx);
			
			if(getAppType()=='db'){
				showDBForm();
				showPrimaryKeyForm(idx);
			}
		})
		
		
	}
	
	/**
	*   选择应用后的一些初始化工作
	*/
	function initItemsWidthApp(){
		var appid = $("select[name='appId']").val();
		var url = '/app/getById?id='+appid;
		var appProductCategory;
		$.ajax({
			url:url,
			dataType:'json',
			async:false,
			success:function(d){
				if(d&&d.app){
					appProductCategory = d.app.productCategory;
					if(appProductCategory=='db'){
						$(".notdb").hide();
						return;
					}else{
						$(".notdb").show();
					} 
					if(appProductCategory=='hy'){
						$(".label:contains(站点)").text("单位");
						$(".label:contains(栏目)").text("分类");
						$(".label:contains(表单)").hide();
						$(".label:contains(表单)").next(".input").hide();
						$("#forms").hide();
					}else{
						$(".label:contains(单位)").text("站点 ");
						$(".label:contains(分类)").text("栏目 ");
						$(".label:contains(表单)").show();
						$(".label:contains(表单)").next(".input").show();
						$("#forms").show();
					}
				}
			}
		});
		
		if(appProductCategory!='db'){
			$("#primaryKeyForms").hide();//隐藏主键表单
			getAllSites();
		}else{
			$("#primaryKeyForms").show();//隐藏主键表单
			
			getAllForms(1);
		}
	}
	function dealTree(){
		$("#tree").unbind("click");
		$("#tree2").unbind("click");
		$("#tree").empty();
		$("#tree2").empty();
	}
	function initFormValues(){
		$.ajax({
			url:'/distribution-strategies/getArticleFields.html',
			dataType:'json',
			data:{groupId:$("[name=groupId]").val()},
			async :false,
			success:function(d){
				var options = '<option value="">请选择</option>';
				for(var i = 0 ; i < d.fields.length ; i++){
					var opTxt = d.fields[i];
					var opVal = d.fields[i].split("【")[0].replace('----','');
					options+='<option value="'+opVal+'">'+opTxt+'</option>';
				}
				$(".mongofields").html(options);
			}
		});
		//如果是新增，则默认选中一个分组 
		if($("#selectGroupId").val()&&$("#selectGroupId").val()!="undefined"){
			$("[name=groupId]").attr("value",$("#selectGroupId").val());
		}
		
		
		
		initSelect('groupId');
		initSelect('appId');
		
		//如果应用是互有，则隐藏表单
		initItemsWidthApp();
		//初始化过滤条件and/or开关
		initCheckBox('andOrFlag');
		//初始化采集计划开关
		initCheckBox('timerOnOffFlag');
		//初始化采集计划
		var timerMode = $("#collect_plan").attr("timerMode");
		var timerExpression = $("#collect_plan").attr("timerExpression");
		
		initCheckBox('tmp_timerMode');
		if(timerMode==0){
			changeTab("cloned5");//普通模式（直接选择表达式）
		}else{
			changeTab("cloned6");//1:高级模式(手动填入表达式)
		}
		$("#collect_plan :input").val(timerExpression);
		/*初始化filter*/
		var id = $("#txt_id").val();
		$.ajax({
			url:'/distribution-strategies/getById.html?eq_id='+id,
			dataType:'json',
			success:function(d){
				var filter = d.distributionStrategy.filter;
				if(filter.length>0) $("#frmApp2 .row:gt(0)").remove();
				for(var i = 0 ; i < filter.length ;i++){
					var filter_each = filter[i];
					if(i==0){
						var clone4 = $(".cloned4").clone();
						var htm = '<div class="row first_row">'+$(clone4).html()+'</div>';
						$("#frmApp2 .row:eq(0)").after(htm);
						$("#frmApp2 .first_row").find("select:eq(0)").val(filter_each[0]);
						$("#frmApp2 .first_row").find("select:eq(1)").val(filter_each[1]);
						$("#frmApp2 .first_row").find("input:eq(0)").val(filter_each[2]);
					}else{
						var clone3 = $(".cloned3").clone();
						var htm = '<div class="row other_row'+i+'">'+$(clone3).html()+'</div>';
						var h = $("#frmApp2 .row").last().after(htm);
						$("#frmApp2 .row:eq("+(i+1)+")").find("select:eq(0)").val(filter_each[0]);
						$("#frmApp2 .row:eq("+(i+1)+")").find("select:eq(1)").val(filter_each[1]);
						$("#frmApp2 .row:eq("+(i+1)+")").find("input:eq(0)").val(filter_each[2]);
					}
				}	
			}
		})
	}
	function initAppValues(d){
		$("select[name='appId'] option:last").attr('selected','selected');
		getAllSites();
	}
	function initSiteValues(){
		$("select[name='siteId']").val($("select[name='siteId']").attr("value"));
		getAllColumns();
	}
	function initColumnValues(){
		$("select[name='columnId']").val($("select[name='columnId']").attr("value"));
		getAllForms();
	}
	
	function genOptionV(selectName,toEleId){
		var v = $("select[name='"+selectName+"']").find("option:selected").text();
		$('#'+toEleId).val(v);
	}
	function getAllApps(functionName,otherParam0,otherParam1,otherParam2){
		var url = '/app/getPagedList.html?iDisplayStart=0&iDisplayLength=1000';
		common(url,'aaData','appId','id','name',functionName,otherParam0);
	}
	function getAllSites(){
		var appId = $("select[name='appId']").val();
		var attrAppId = $("select[name='appId']").attr("value");
		var t = $("#tree");
		$.ajax({
			url:'/distribution-strategies/getAllSites.html?appId='+appId,
			type:'post',
			dataType:'json',
			success:function(d){
				if(!d){ //返回数据错误
					return;
				}
				t = $.fn.zTree.init(t, setting, d.sites);
				var curId = $("#txt_siteId").val();
				var siteDeepIds = $("#siteDeepIds").val().split(",");
				var firstId = siteDeepIds[0];
			   	var _node = t.getNodeByParam("id",firstId,null);
			   	if(firstId==curId){
			        t.selectNode(_node,false);
			   	}else{
			   		t.expandNode(_node,true,true);
			   	}
			}
		});
		getAllColumns();
		//var url = '/distribution-strategies/getAllSites.html?appId='+appId;
		//common(url,'sites','siteId','id','siteName',"initSiteValues");
	}
	function getAllColumns(){
		var appId = $("select[name='appId']").val();
		var siteId = $("input[name='siteId']").val();
		var url = '/distribution-strategies/getColumnsBySiteId.html?appId='+appId+"&siteId="+siteId;
		var t = $("#tree2");
		$.ajax({
			url:url,
			type:'post',
			dataType:'json',
			success:function(d){
				t = $.fn.zTree.init(t, setting, d.columns);
				
				var curId = $("#txt_columnId").val();
				var columnDeepIds = $("#columnDeepIds").val().split(",");
				var firstId = columnDeepIds[0];
			   	var _node = t.getNodeByParam("id",firstId,null);
			   	if(firstId==curId){
			        t.selectNode(_node,false);
			   	}else{
			   		t.expandNode(_node,true,true);
			   	}
			}
		});
		getAllForms();
		//var url = '/distribution-strategies/getColumnsBySiteId.html?appId='+appId+"&siteId="+siteId;
		//common(url,'columns','columnId','id','pageName','initColumnValues');
	}
	function getAllForms(isDBForm){
		var url;
		var appId = $("select[name='appId']").val();
		if(!isDBForm){
			var columnId = $("input[name='columnId']").val();
			url = '/distribution-strategies/getFormsByPageId.html?appId='+appId+"&columnId="+columnId;
			common(url,'forms','formId','id','formName',"initForms",isDBForm);
		}else{
			url = '/distribution-strategies/getDBForms.html?appId='+appId;
			common(url,'forms','formId','id','formName',"initForms",isDBForm);
		}
		
	}
	function initForms(data,isDBForm){
		initSelect('formId');
		if(isDBForm){
			showDBForm();
			return;
		}
		//$("select[name='formId']").val($("select[name='formId']").attr("value"));
		//$("select[name='formId']").attr("formKey",data.formKey);
		var htm = '';
		var htm2 = '';
		for(var i = 0 ; i < data.forms.length; i++){
			var thisFormKey = data.forms[i].formKey;
			htm+='<div class="forms" formKey="'+thisFormKey+'">';
			var each = data.forms[i];
			var fields = each.fields;
			
			//开始根据返回的forms初始化选项 
			var x =0;
			var options = '<option value="">请选择</option>';		
			for (var key in fields) {
				var val = fields[key];
				options+='<option value="'+key+'">'+key+"【"+val+'】</option>';
				x++;
			}
			$(".cloned1 select:eq(1)").html(options);//cloned1是第一行
			$(".cloned2 select:eq(1)").html(options);//cloned2是第二行
			
			//开始复制表单到 源表单(云采集平台) 和  目标表单(非云采集平台)
			var cloned1 = $(".cloned1").clone();
			htm+='<div class="row hide_forms">'+cloned1.html()+'</div>';
			
			var idx = $('option:selected', 'select[name=formId]').index()-1; //-1是为了去掉 "请选择"
			if(i!=idx||!$("#txt_propertyMapping").val()){
				x = 2;//如果是新增或者当前选中并不是数据库中已存的表单，默认初始化两个。。
			}else{
				x = $("#txt_propertyMapping").val().split(",").length;//否则，显示与数据库表单同步
			}
			for(var j = 0 ; j < x-1 ; j++){//减1是上面已经加了一行了
				var cloned2 = $(".cloned2").clone();
				htm+='<div class="row hide_forms">'+cloned2.html()+'</div>';
			}
			
			htm+='</div >';
		}
		$("#forms").html(htm);
		
		initFormsSubItems();
	}
	/*
	function initPrimaryKeyForm(data){
		var htm = '';
		for(var i = 0 ; i < data.forms.length; i++){
			var thisFormKey = data.forms[i].formKey;
			htm+='<div class="primaryForms" style="display:none;" formKey="'+thisFormKey+'">';
			var each = data.forms[i];
			var fields = each.fields;
			
			//开始根据返回的forms初始化选项 
			var x =0;
			var options = '<label class="label">主键</label><label class="input"><select class="form-control mongofields sourcePropertys"><option value="">请选择</option>';		
			for (var key in fields) {
				var val = fields[key];
				options+='<option value="'+key+'">'+key+"【"+val+'】</option>';
				x++;
			}
			htm+= options + '</select></label></div >';
		}
		$("#primaryKeyForms").html(htm);
	}
	*/
	/*
	function initPrimaryKeyForm(data){
		var htm = '';
		var thisFormKey = data.formKey;
		htm+='<div class="primaryForms" formKey="'+thisFormKey+'">';
		var fields = data.fields;
		
		//开始根据返回的forms初始化选项 
		var options = '<label class="label">主键</label><label class="input"><select class="form-control" name="primaryKeyName"><option value="">请选择</option>';
		console.log();		
		for (var key in fields) {
			var val = fields[key];
			options+='<option value="'+key+'">'+key+"【"+val+'】</option>';
		}
		htm+= options + '</select></label></div >';
		console.log("#########");
		console.log(htm);
		console.log("#########");
		$("#primaryKeyForms").html(htm);
		
		initSelect('formId');
		
	}*/
	/*初始化propertyMapping*/
	function initFormsSubItems(){
		if($("select[name=formId]").val()){
			var idx = $('option:selected', 'select[name=formId]').index()-1; //-1是为了去掉 "请选择"
			showFormDetail(idx);
			showPrimaryKeyForm(idx);
			/*初始化propertyMapping*/
			var visibleForm;
			$("#forms .forms").each(function(){
				if($(this).css("display")=='block'){//因为切换到第二页通过:visible属性获取不到。所以得通过block
					visibleForm = $(this);
				}
			})
			var propertyMapping = $("#txt_propertyMapping").val();
			propertyMapping = propertyMapping.replace('{','').replace('}','').split(",");
			for(var i = 0 ; i < propertyMapping.length ;i++){
				var part0 = propertyMapping[i].split("=")[0].trim();
				var part1 = propertyMapping[i].split("=")[1].trim();
				$(visibleForm).find(".sourcePropertys:eq("+i+")").attr("hehe",part0);
				$(visibleForm).find(".targetPropertys:eq("+i+")").attr("hehe",part1);
				$(visibleForm).find(".sourcePropertys:eq("+i+") option[value='"+part0+"']").attr("selected",true);
				$(visibleForm).find(".targetPropertys:eq("+i+") option[value='"+part1+"']").attr("selected",true);
			}
		}
	}
	function showFormDetail(idx){
		$(".forms").hide();
		$(".forms:eq("+idx+")").show();
		if($("select[name=formId]").val()!=$("select[name=formId]").attr("value")
			&&$(".forms:eq("+idx+")>div").length>2){
			$(".forms:eq("+idx+")>div:gt(1)").remove();
		}
	}
	/**
		显示数据库的表单 
	*/
	function showDBForm(){
		var appId = $("[name=appId]").val();
		var dbTableMetaDataName = $("[name=formId]").find("option:selected").text();
		var url = '/distribution-strategies/getDBTableByFormId.html?appId='+appId+'&dbTableMetaDataName='+dbTableMetaDataName;//aaaaaaaaaaaaaaaaaa
		var thisFormKey = dbTableMetaDataName;
		
		var propertyMapping = $("#txt_propertyMapping").val();
		var initCount = 2; //如果有的话，初始化一下。没有的话，默认是两行
		if(propertyMapping){
			propertyMapping = propertyMapping.replace('{','').replace('}','').split(",");
			initCount = propertyMapping.length;
		}
		
		var htm = '';
		var dataName = 'fields';
		var optionVal = 'value';
		var optionTxt = 'text';
		
		$.ajax({
			url:url,
			type:'post',
			dataType:"json",
			success:function(d){
				htm+='<div class="forms" style="display:block" formKey="'+thisFormKey+'">';
				var options = '<option value=" ">请选择</option>';
				for(var i = 0; i<d[dataName].length; i++){
					var each = d[dataName][i];
					options+='<option value="'+each[optionVal]+'">'+each[optionTxt]+'</option>';
				}
				$("select[name=primaryKeyName]").html(options);
				$("select.targetPropertys").html(options);
				//开始复制表单到 源表单(云采集平台) 和  目标表单(非云采集平台)
				var cloned1 = $(".cloned1").clone();
				htm+='<div class="row">'+cloned1.html()+'</div>';
				for(var j = 0 ; j < initCount ; j++){
					var cloned2 = $(".cloned2").clone();
					htm+='<div class="row">'+cloned2.html()+'</div>';
				}
				htm+='</div >';
				$("#forms").html(htm);
				
				$("[name='formId']").parent().show().prev("label").show();
				$("#forms").show();
				$("#forms label").show();
				if(propertyMapping&&propertyMapping.length>0){
					initDBForm();
				}
			}
		})
		
	}
	/**
	* 初始化数据库的表单。
	*/
	function initDBForm(){
	
		initSelect('primaryKeyName');
		var propertyMapping = $("#txt_propertyMapping").val();
		var initCount = 1; //如果有的话，初始化一下。没有的话，默认是两行
		if(propertyMapping){
			propertyMapping = propertyMapping.replace('{','').replace('}','').split(",");
		}
		/*初始化propertyMapping*/
		var visibleForm;
		$("#forms .forms").each(function(){
			if($(this).css("display")=='block'){//因为切换到第二页通过:visible属性获取不到。所以得通过block
				visibleForm = $(this);
			}
		})
		var propertyMapping = $("#txt_propertyMapping").val();
		propertyMapping = propertyMapping.replace('{','').replace('}','').split(",");
		//多余的行全部移除
		if(propertyMapping.length<$(".forms .sourcePropertys").length){
			var needCount = propertyMapping.length;
			$(".forms .row:gt("+(needCount-1)+")").remove();
		}
		for(var i = 0 ; i < propertyMapping.length;i++){
			var part0 = propertyMapping[i].split("=")[0].trim();
			var part1 = propertyMapping[i].split("=")[1].trim();
			$(visibleForm).find(".sourcePropertys:eq("+i+")").attr("hehe",part0);
			$(visibleForm).find(".targetPropertys:eq("+i+")").attr("hehe",part1);
			$(visibleForm).find(".sourcePropertys:eq("+i+") option[value='"+part0+"']").attr("selected",true);
			$(visibleForm).find(".targetPropertys:eq("+i+") option[value='"+part1+"']").attr("selected",true);
		}
	}
	function showPrimaryKeyForm(idx){
		/*
		$(".primaryForms").hide();
		$(".primaryForms:eq("+idx+")").show();
		var primaryKeyName = $("#primaryKeyForms").attr("primaryKeyName");//初始化主键名称
		$(".primaryForms:eq("+idx+") select").val(primaryKeyName);
		*/
	}
	function addNewRow(ele,clonedClass){
		var cloned = $("."+clonedClass).clone();
		var htm='<div class="row">'+cloned.html()+'</div>';
		$(ele).parents("div.row:eq(0)").parent().find("div:last").after(htm);
	}
	function deleteRow(ele){
		$(ele).parents(".row:eq(0)").remove();
	}
	function collect_plan_change(ele){
		if($("#collect_plan section").parent().siblings(".biaodashi").length>0){
			changeTab("cloned5");
		}else{
			changeTab("cloned6");
		}
	}
	function changeTab(eleClass){
		var clonedEle = $("."+eleClass).clone();
		var tmpClass = "biaodashi";
		if(eleClass!='cloned6'){
			tmpClass = "";
		}
		var tab2 = "<div class='row "+tmpClass+"'>"+clonedEle.html()+"</div>";
		$("#collect_plan section").parent().siblings(".row").remove();
		$("#collect_plan  section").parent().after(tab2);
		
		
		var timerExpression = $("#collect_plan").attr("timerExpression");
		if(timerExpression=='请选择') timerExpression='';
		$("#collect_plan :input").val(timerExpression);
	}
	function addApp(){
		openDialog('','','confirm','','确认','保存成功,需要应用到当前分发策略吗?','sureApp','notSureApp');
	}
	function sureApp(){
		getAllApps('initAppValues');
	}
	function notSureApp(){
		getAllApps();
	}
	function common(url,dataName,selectName,optionVal,optionTxt,functionName,otherParam0,otherParam1,otherParam2){
		
			$.ajax({
				url:url,
				type:'post',
				dataType:"json",
				success:function(d){
					try{
						var options = '<option value=" ">请选择</option>';
						for(var i = 0; i<d[dataName].length; i++){
							var each = d[dataName][i];
							options+='<option value="'+each[optionVal]+'">'+each[optionTxt]+'</option>';
						}
						$("select[name='"+selectName+"']").html(options);
						if(functionName){
							callFunction(functionName,d,otherParam0,otherParam1,otherParam2);
						}
					}catch(e){}
				}
			})
		
	}
</script>