<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Bread crumb is created dynamically -->
<!-- row -->
<style>

</style>
<script src="/resources/js/news-common.js"></script>
<div class="row">
	
	<!-- col -->
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title  txt-color-blueDark">
			
			<!-- PAGE HEADER -->
			<i class="fa-fw fa fa-tasks"></i> 
				新闻
			<span>>  
				<c:if test="${currentUser.isAdmin==1}">用户任务</c:if>
				<c:if test="${currentUser.isAdmin!=1}">采集任务</c:if>
			</span>
		</h1>
	</div>
	<!-- end col -->
	
	<!-- right side of the page with the sparkline graphs -->
	<!-- col -->
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8">
		<!-- sparks -->
		<!-- end sparks -->
	</div>
	<!-- end col -->
	
</div>
<!-- end row -->
<!-- Widget ID (each widget will need unique ID)-->
<div class="jarviswidget" id="wid-id-7" data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-custombutton="false" data-widget-sortable="false">
				<header>
					<ul class="nav nav-tabs pull-left in">

						<li class="active">
							<a data-toggle="tab" href="#hr1"> <i class="fa fa-lg fa-arrow-circle-o-down"></i> <span class="hidden-mobile hidden-tablet">
							<c:if test="${currentUser.isAdmin!=1}">采集任务</c:if>
							<c:if test="${currentUser.isAdmin==1}">用户任务组</c:if>
							</span> 
							</a>
						</li>
						<li class="tab2">
							<a data-toggle="tab" href="#hr2"> <i class="fa fa-lg "></i> <span class="hidden-mobile hidden-tablet">审核情况 </span> </a>
						</li>
					</ul>
				</header>

				<!-- widget div-->
				<div>

					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body">

						<div class="tab-content">
							<div class="tab-pane active" id="hr1">
								<div id="inbox-content" class="row" style="min-height: 520px;padding:0 10px;">
									<!-- widget div-->
									
									<div>
										<div class="jarviswidget-editbox">
										</div>
										<div class="widget-body">
											<table id="tbTask"
												class="table table-striped table-bordered table-hover" width="100%">
											</table>
										</div>
									</div>
								</div>
							</div>
							<div class="tab-pane tab2" id="hr2">
								<table id="news_group_rule_requirement_list_"
										class="table table-striped table-bordered table-condensed table-hover" width="100%">
										<thead style="width:100%;">
											<tr>
												<!-- <th><input type="checkbox" >测试选项</th> -->
												<th>
													需求方
												</th>
												<th>
													所属采集任务
												</th>
												<th>
													页面名称
												</th>
												<th>
													页面URL
												</th>
												<th>
													状态
												</th>
												<th>
													提交时间
												</th>
												<th>
													操作
												</th>
											</tr>
										</thead>
									</table>

							</div>
						</div>

					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

		<!-- 这里是公共html列表模板表格 -->
		<article class="col-sm-12 col-md-12 col-lg-8" id="public-html-list-rule-model-boxs" style="display:none;">
			<div class="jarviswidget jarviswidget-color-darken col-sm-12 col-lg-12" class="
				data-widget-editbutton="false" data-widget-colorbutton="false" style="width:100%;" >
				<!-- widget div-->
				<div style="width:100%;">
		
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->
		
					</div>
					<!-- end widget edit box -->
		
					<!-- widget content -->
					<div class="widget-body no-padding">
						<table id="public_html_list_rule_model"
							class="table table-striped table-bordered table-condensed" width="100%">
							<thead style="width:100%;">
								<tr>
									<th>
										自定义名称
									</th>
									<th>
										操作
									</th>
								</tr>
							</thead>
						</table>
		
					</div>
					<!-- end widget content -->
		
				</div>
				<!-- end widget div -->
		
			</div>
		</article>
		<!-- 这里是公共正文模板表格 -->
		<article class="col-sm-12 col-md-12 col-lg-8" id="public-html-text-rule-model-boxs" style="display:none;">
			<div class="jarviswidget jarviswidget-color-darken col-sm-12 col-lg-12" class="
				data-widget-editbutton="false" data-widget-colorbutton="false" style="width:100%;" >
				<!-- widget div-->
				<div style="width:100%;">
		
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->
		
					</div>
					<!-- end widget edit box -->
		
					<!-- widget content -->
					<div class="widget-body no-padding">
						<table id="public_html_text_rule_model"
							class="table table-striped table-bordered table-condensed" width="100%">
							<thead style="width:100%;">
								<tr>
									<th>
										自定义名称
									</th>
									<th>
										操作
									</th>
								</tr>
							</thead>
						</table>
		
					</div>
					<!-- end widget content -->
		
				</div>
				<!-- end widget div -->
		
			</div>
		</article>
</div>
<!-- end widget -->



<div id="group_dialog_div" style="display:none;"></div>
<div id="group-rule-boxs" style="display:none;"></div>
<div id="news-search-boxs" style="display:none;"></div>
<div id="audit-boxs" style="display:none;"></div>
<!-- end widget grid -->
<script type="text/javascript" src="/resources/js/plugin/jquery-tmpl/jquery.tmpl.min.js"></script> 
<script type="text/javascript" src="/resources/js/bootstrap/bootstrap-paginator.min.js"></script>
<script type="text/javascript"><!--
//初始化加载一些参数
pageSetUp();
$( "#tabs" ).tabs();
function deleteGroup(id)
{
		art.dialog.confirm('你确定要删除这个任务吗？', function () {
			$.ajax({
				type: "post",
			    url: "/news/deleteGroup?id="+id,
			    dataType:"json",
			    success: function(data){
			    	if(data.result)
	    			{
			    		art.dialog.tips('删除成功!');
	    			}else{
			    		art.dialog.tips('删除失败!');
	    			}	
			    	//loadTbTask();
			    	tbTask.oTable.fnDraw(); //重新加载数据
	        	}
			});
		}, function () {});
		changeArtdialogButtonCss();
}
var pagefunction = function() {
	var isAdmin = '${currentUser.isAdmin}';
	if(isAdmin==1){
		$(".tab2").hide();
		$("#admin_oprate_box").show();
	}else{
		$("#user_oprate_box").show();
	}
	loadTbTask();
	//InitList();
	//InitAppList();
	loadNewsGroupRuleRequirementTable();
	//console.log($("#ul_group .active a").attr("site_id"));
	//$("#span_group_id").text();
}
var tbTask;
function loadTbTask(){
	var tbId = "tbTask";
	var tbURL = "news/getAllGroupList.html";
	
	tbTask=new InfoEdit();
	tbTask.oTable=$("#"+tbId).dataTable({
		"oLanguage" : common_data_table_config.oLanguage,
		"sDom": "<'dt-toolbar'<'col-xs-6 tools-bar'><'col-xs-6'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
		"oColVis": {
            "buttonText": "表格列显示 / 隐藏"
        },
        "bSort":false,
		"bPaginate" : true,
		"bProcessing" : false,
		"bServerSide" : true,
		"sAjaxSource" : tbURL,
		"fnServerData" : function(sSource, aoData, fnCallback, oSettings) {
				oSettings.jqXHR = $.ajax( {
					"dataType" : 'json',
					"type" : "POST",
					"url" : sSource,
					"beforeSend" : function() {
						//ZENG.msgbox.show(" 正在加载中，请稍后...", 6, 100000);
					},
					"complete" : function() {
						
					},
					"data" : aoData,
					"success" : fnCallback
				});
			},
		"aoColumns" : [{
			"sTitle": "任务名称", "sClass": "center", "data" : "name"
		},{
			"sTitle": "用户名", "sClass": "center", "data" : "userName"
		}, {
			"sWidth":'140px',
            "sTitle": "操作",
            "sClass": "center",
            "data": function ( row, type, set ){
            	var lookRuleResource = "<button  onclick=\"lookRuleResource('groupId="+row.id+"&groupName="+row.name+"');\" title=\"查看数据源\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-database\"></i></button>&nbsp;";
            	var lookDistributionStrategy = "<button  onclick=\"lookDistributionStrategy('groupId="+row.id+"');\" title=\"查看分发策略\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-list-ul\"></i></button>&nbsp;";
				var editBtn = "<button  onclick=\"addGroup(1,'"+row.name+"','"+row.id+"','"+row.userId+"');\" title=\"编辑\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></button>&nbsp;";
            	var deleteBtn = "<button  onclick=\"deleteGroup('"+row.id+"');\" title=\"删除\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-times\"></i></button>&nbsp;";
            	
            	
            	return lookRuleResource+lookDistributionStrategy+editBtn+deleteBtn;
	        } 
        }],
        "fnInitComplete": function(oSettings, json) {
			initTbTaskButton(tbId,tbURL);
		 },
	});
}
function initTbTaskButton(tbId,tbURL){
	$("#"+tbId+"_filter label").remove();
	$("#"+tbId+"_wrapper .dt-toolbar").addClass("padding_B5");
	
	var s_appname_btn = '<input type="text" name="'+tbId+'_l_name" class="form-control ng-valid ng-dirty margin_R5" placeholder="任务名称">';
	var s_submit_btn = '<a class="btn btn-default"  onclick=\'search_tb("'+tbId+'","'+tbURL+'")\'>查询 </a>';
	
	
	var look_runing_timer = '<a class="btn btn-default" name="toAdd"  style="float:right;" onclick="lookRuningTimer()" href="javascript:void(0);"><i class="fa fa-exchange"></i>&nbsp;查看正在运行的作业</a>';
	var right_btns = '<div class="btn-group margin_L5"><button class="btn btn-primary margin_R5 " onclick="addGroup(-1)">新增</button>'+look_runing_timer+'</div>';
	$("#"+tbId+"_wrapper .dt-toolbar div:eq(0)").append($(s_appname_btn)).append($(s_submit_btn));
	$("#"+tbId+"_wrapper .dt-toolbar").css("padding","0 0 5px 0");
	$("#"+tbId+"_wrapper .tools-bar").next().css("text-align","right").css("float","right").append(right_btns);
}
function lookRuningTimer(){
	var buttons = [{
					name:"<i class='pRed'></i>一键删除",
					callback:function(){
						if($("#running_timer_list").text().indexOf("没有找到记录")>-1){
							confirm('操作确认','<div style=padding:10px>当前无数据</div>');
						}else{
						confirm('操作确认','<div style=padding:10px><font color=red>确定要删除吗(一旦删除，数据将无法恢复!)</font></div>',killTimer,'','','delAll')
						}
						return false;
					}
				},{
					name:"取消",
					callback:function(){
					}
				}];
	callDialog("/distribution-strategies/lookRuningTimer","runingTimerModal","正在运行的作业","700",buttons);
}
function search_tb(tbId,tbURL){
	tbURL+="?"; 
	$("[name^="+tbId+"_]").each(function(){
		var this_name = $(this).attr("name");
		if(this_name!=tbId+"_length"){
			var filter_name = this_name.replace(tbId+"_","");
			tbURL+= filter_name+"="+$("[name="+this_name+"]").val()+"&";
		}
	});
	$('#'+tbId).dataTable().fnSettings().sAjaxSource=tbURL;
	$('#'+tbId).dataTable().fnDraw();
}
function lookRuleResource(params){
	params = $.trim(params);
	var buttons = [];
	callDialog("/newsGroupRule/toNewsGroupRuleList?"+params,"newsGroupRuleList_","数据源","600",buttons);
}
function lookDistributionStrategy(params){
	var buttons = [];
	callDialog("/distribution-strategies/toNewsDistributionStrategies?"+params,"distributionStrategies","分发策略","800",buttons);
}
function addGroup(t,txtName,id,userId){
	if(t==-1)
	{
		txtName = '';
		id = '';
	}
	var d=art.dialog({
		title:t==-1?"新增任务":"编辑任务",
	    content: '<div id="divAddGroup"><form id="frmGroup" class="smart-form">'+
	    	'<section><label class="label">名称：</label><label class="input">'+
	    	'<input type="text" id="txtName" name="name" value="'+txtName+'"/></label>'+
	    	'<input type="hidden" name="userId" id="txtUserId" value="'+userId+'">'+
	    	'<input type="hidden" name="id" id="txtId" value="'+id+'">'+
	    	'</section></form></div>',
    	lock:true,
	    button:[{
	    	name:"保存",
	    	callback:function(){
	    		if($("#txtName").val()!="")
	    		{
	    			var requestUrl="/news/saveGroup";
	    			if(t!=-1)
	    			{
	    				requestUrl="/news/editGroup";
	    			}
		    		$.ajax({
						type: "post",
					    url: "/news/saveGroup",
					    data: $("#frmGroup").serialize(),
					    success: function(data){
					    	d.close();
					    	if(t!=-1)
			    			{
					    		art.dialog.tips('保存成功!');
			    			}else{
					    		art.dialog.tips('保存成功!');
			    			}	
					    	//loadTbTask();
					    	tbTask.oTable.fnDraw(); //重新加载数据
			        	}
					});
	    		}else
	    		{
	    			art.dialog.tips('名称不能为空!');
	    		}
				return false;
	    	}
	    },{
	    	name:"取消",
	    	callback:function(){
	    	}
	    }],
	    init: function () {
	    	changeArtdialogButtonCss();
	    }
	});
}
var distributionStrategy;
function InitAppList()
{
	distributionStrategy=new InfoEdit();
	distributionStrategy.requestUrl="distribution-strategies";
	distributionStrategy.oTable=$("#tbAppTable").dataTable({
		"oLanguage" : {
		"oPaginate" : {
			"sNext" : "下一页",
			"sPrevious" : "上一页",
			"sLast" : "尾页",
			"sFirst" : "首页"
		},
		"sEmptyTable" : "无数据",
		"sLengthMenu": "每页 _MENU_ 条 ",
		"sInfo" : "总数<span class='text-primary'>_TOTAL_</span>显示<span class='txt-color-darken'>_START_</span>至<span class='txt-color-darken'>_END_</span>",
		},
		"sDom": "<'dt-toolbar'<'col-xs-6 tools-bar'><'col-xs-6'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
		"oColVis": {
            "buttonText": "表格列显示 / 隐藏"
        },
        "bSort":false,
		"bPaginate" : true,
		"bProcessing" : false,
		"bServerSide" : true,
		"sAjaxSource" : "/distribution-strategies/getPagedList.html",
		"fnServerData" : function(sSource, aoData, fnCallback, oSettings) {
				oSettings.jqXHR = $.ajax( {
					"dataType" : 'json',
					"type" : "POST",
					"url" : sSource,
					"beforeSend" : function() {
						//ZENG.msgbox.show(" 正在加载中，请稍后...", 6, 100000);
					},
					"complete" : function() {
						
					},
					"data" : aoData,
					"success" : fnCallback
				});
			},
		
		"aoColumns" : [{
			"sTitle": "名称", "sClass": "center", "data" : function ( row, type, set ){
				var s_name = cut_str(row.name, 30,"...");
				if(!s_name) s_name='暂无';
				return s_name;
			}
		}, {
			"sTitle": "站点名称", "sClass": "center", "data" : "siteName"
		},{
			"sTitle": "栏目名称", "sClass": "center", "data" : "columnName"
		},{
			"sTitle": "表单名称", "sClass": "center", "data" : "formName"
		}, {
			"sWidth":'140px',
            "sTitle": "操作",
            "sClass": "center",
            "data": function ( row, type, set ){
            	var pushBtn = "<button  onclick=\"push(this,'"+row.id+"');\" title=\"推送\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-play\"></i></button>&nbsp;";
            	var resetTimeStampBtn = "<button  onclick=\"resetCollection('"+row.id+"');\" title=\"重新采集\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-refresh\"></i></button>&nbsp;";
            	var lookRuningLogsBtn = "<button  onclick=\"lookRuningRecords('"+row.id+"');\" title=\"查看运行日志\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-book\"></i></button>&nbsp;";
				var editBtn = "<button  onclick=\"openDistributionDialog(this,'"+row.id+"');\" title=\"编辑\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></button>&nbsp;";
            	var deleteBtn = "<button  onclick=\"distributionStrategy.deleteRow('"+row.id+"');\" title=\"删除\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-times\"></i></button>&nbsp;";
            	return pushBtn+resetTimeStampBtn+lookRuningLogsBtn+editBtn+deleteBtn;
	        } 
        }],
        "fnInitComplete": function(oSettings, json) {
				initAppListTableButton();
		 },
	});
}
function InitFilter() {
	$("#filter a").hover(function() {
		$(this).addClass("seled");
	}, function() {
		$(this).removeClass("seled");
	});
	$("#filter p a").bind("click",function(){
		$(this).parent("p").children("a").each(function() {
			$(this).removeClass("web_list_ra1");
		});
		$(this).addClass("web_list_ra1");
	});
}
function deleteRequirementPageRule(id){
	$.ajax( {
		type : "POST",
		dataType : 'json',
		cache : false,
		url : "/newsGroupRule/deleteRequirementPageRule?id="+id,
		success : function(data) {
			if(data.result){
				 MessageBoxShow("保存成功！",true);
				 news_group_rule_requirement_list_table.fnDraw();
			}else MessageBoxShow("保存失败！");
		},
		error:function(){
			MessageBoxShow("保存失败！");
		}
	});
}
function deletePageRule(id)
{
	var ids="";
	if(id!="0")
	{
		ids=id;
	}else{
		var ckd_len = $("input[name='pageRule']:checked").length;
		if(ckd_len==0){
			art.dialog.tips('请至少选择一条记录删除');
			return false;
		}
		var id_array=new Array();
		$("#news_group_rule_list tr input[name='pageRule']").each(function() {
             if($(this).is(':checked'))
             {
             	id_array.push($(this).val());
             }
        });
        ids=id_array.join(',');
	}
	art.dialog.confirm('你确定要删除这个规则吗？', function () {
		if($("#_groupId").val())
	    {
		   	var data = {"ruleId":ids,"groupId":$("#_groupId").val()};
	        $.ajax( {
				type : "POST",
				dataType : 'json',
				cache : false,
				url : "/newsGroupRule/deleteAllNewsGroupRules",
				data:data,
				beforeSend : function() {
				},
				success : function(result) {
					oTable.fnDraw();
				},
				complete : function() {
				}
			});
	    }
	},function(){});
	changeArtdialogButtonCss();
}
var pageIndex = 1, pageSize = 10, pageCount = 0
var container; 
var options = null;
function getRuleList(index)
{
	var query = "/news/getSitePagedListByGroupId?timeStamp="+new Date().getTime()+
		"&iDisplayLength=" +pageSize+
		"&iDisplayStart=" + (index-1) * pageSize+
		"&eq_groupId="+$("#_groupId").val()+
		//"&l_section="+$("#ruleName").val()+
		//"&l_site="+$("#siteName").val();		
		"&l_name="+$("#siteName").val();								
	pageIndex = index;
	$.ajax({
		dataType: "json",
		beforeSend:function(){
			loadingTip("正在加载中,请耐心等待...","#divContent");
		},
		type: "GET",
		url: query,
		success: showData
	});
}
function addOrCancelRules(ele,flag,id)
{
	
	if($(ele).text()=='取消'){
		deleteNewsGroupRule(ele,id);
	}else{
		addNewsGroupRule(ele,id);
	}
	event.stopPropagation();
}
//这里--
function addNewsGroupRulesForSite(ele,rule_id,group_id,group_name){
	$.ajax({
		url:'/newsGroupRule/canAddNewsGroupRule',
		type:'post',
		dataType:'json',
		success:function(data){
			if(data.result==0){
				MessageBoxShow('对不起，页面数量超出限制!');
			}else if(data.result==-1){
				MessageBoxShow('服务器异常，请稍后重试!');
			}else{
				var url = "/newsGroupRule/addNewsGroupRules";
				$.ajax({
					url:url,
					data:{"ruleId":rule_id,groupId:group_id,groupName:group_name},
					success:function(data){
					   data = eval('('+data+')');
					   var html_ = $(ele).html();
						if(html_=="添加"){
							$(ele).html("取消");
			   			}else{
			   				$(ele).html("添加");
				   		}
						oTable.fnDraw();
					}
				});
				MessageBoxShow('保存成功!',true);
				$(".superbox div.active .actions a").text("取消");
			}
		}
	})
}
function addOrCancelSiteRules(ele,site_id){
	var html_ = $(ele).html();
	if(html_=="添加"){
		var group_id =  $("#_groupId").val();
		var group_name = $("#_groupName").val();
		var url = "/newsGroupRule/addNewsGroupRulesOfSite";
		$.ajax({
			url:url,
			data:{"siteId":site_id,groupId:group_id,groupName:group_name},
			success:function(data){
			   data = eval('('+data+')');
			   if(data.result==0){
				   //eee
				   MessageBoxShow('添加失败！页面数量超出限制!当前剩余'+data.count+"个页面");
				   return;
			   }
				$(ele).html("取消");
				$(".superbox-show").find(".superbox-list .actions a ").text("取消");
				oTable.fnDraw();
				MessageBoxShow('保存成功!',true);
			}
		});
	}else{
		var url = "/newsGroupRule/deleteNewsGroupRulesOfSite";
		$.ajax({
			url:url,
			data:{"siteId":site_id},
			success:function(data){
			   data = eval('('+data+')');
	   			$(ele).html("添加");
	   			$(".superbox-show").find(".superbox-list .actions a ").text("添加");
				oTable.fnDraw();
			}
		});
	}
}
//添加用户规则
function addNewsGroupRule(ele,rid) {
	var rule_id = rid +"";
	var group_id= $("#_groupId").val();
	var group_name= $("#_groupName").val();
	addNewsGroupRulesForSite(ele,rule_id,group_id,group_name);
	
};

function deleteNewsGroupRule(ele,rid){
	var rule_id = rid +"";
	var group_id= $("#ul_group li.active a").attr("site_id")+"";
	var group_name=$("#ul_group li.active a").html()+"";
	deleteToUserRuleOfRule(ele,rule_id,group_id);
}
function deleteToUserRuleOfRule(ele,rule_id,group_id){
	var url = "/newsGroupRule/deleteNewsGroupRules";
   	var data = {"ruleId":rule_id,"groupId":group_id};
   	var type = "POST";
   	$.ajax({
   		url:url,
   		data:data,
   		type:type,
   		beforeSend:function(){
			//这里是开始执行方法，显示效果
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
		},
   		success:function(data){
   			data = eval('('+data+')');
   			if(data.result){
   				//site_table.fnDraw();
   				//dialog.close();
   				var html_ = $(ele).html();
   				if(html_=="添加"){
   					$(ele).html("取消");
	   			}else{
	   				$(ele).html("添加");
		   		}
   			}
   			var this_site_has_rule = false;
   			$(".superbox-show .superbox-list").each(function(){
   	   			if($(this).find(".actions a").text()=='取消'){
	   	   			this_site_has_rule = true;
	   	   			return;
   	   	   		}
   	   		})
   	   		if(!this_site_has_rule){
   	   		$(".superbox div.active .actions a").text("添加");
   	   	   	}
   			MessageBoxShow('保存成功!',true);
   		}
   	});
}
function saveNewsGroupRule(){
	
}
var groupRuleRequirementDialog;
function toAddNewsGroupRuleRequirement(){
	$.ajax({
		url:'/newsGroupRule/canAddNewsGroupRule',
		type:'post',
		dataType:'json',
		success:function(data){
			if(data.result==0){
				MessageBoxShow('对不起，页面数量超出限制!');
			}else if(data.result==-1){
				MessageBoxShow('服务器异常，请稍后重试!');
			}else{
				$('#group-rule-boxs').load("/newsGroupRule/toAddNewsGroupRuleRequirement",function(){
					groupRuleRequirementDialog = window.top.art.dialog({
						title: "详情",
						content: $("#group-rule-boxs")[0],
						width:"850px",
						lock:true
					});
					$(".aui_content").css("width","100%");
				});
				$("#group-rule-boxs").html("");
			}
		}
	})
	
	
	
}
function closeGroupRuleRequirementDialog(){
	groupRuleRequirementDialog.close();
}
function addOrEditNewsGroupRule(id){
	$('#group-rule-boxs').load("/newsGroupRule/edit?eq_id="+id,function(){
	    var dialog = window.top.art.dialog({
			title: "详情",
			content: $("#group-rule-boxs")[0],
			width:"850px",
			lock:true
		});
		$(".aui_content").css("width","100%");
	});
	$("#group-rule-boxs").html("");
}
var newsArticleSearchDialog;
function lookDataForThis(ele){
	$("#news-search-boxs").html("");
	var rule_id = $(ele).attr("rule_id");
	var group_id = $(ele).attr("group_id");
	
	loadingShow();
			
	$('#news-search-boxs').load("/news/newsArticleSearch?eq_ruleId="+rule_id,function(){
		newsArticleSearchDialog = window.top.art.dialog({
				title: "详情",
				content: $("#news-search-boxs")[0],
				width:"850px",
				padding: '0px 0px',
				lock:true
			});
		$(".aui_content").css("width","100%");
		newsArticleSearchDialog.hide();
	});
	
}
function showData(data)
{
	pageCount = Math.ceil( data.iTotalRecords/pageSize ),lists = data.aaData;
	if(pageCount>0)
	{
   	  	options = {
   	  		bootstrapMajorVersion:3,
           	currentPage:pageIndex, 
           	numberOfPages: 10, 
           	totalPages:pageCount,
           	itemTexts:function(type, page, current){
           		  switch (type) {
		            case "first":
		                return "首页";
		            case "prev":
		                return "上一页";
		            case "next":
		                return "下一页";
		            case "last":
		                return "尾页";
		            case "page":
		                return page;
		           }
           	}, 
           	tooltipTitles: function (type, page, current) {
	            switch (type) {
	            case "first":
	                return "首页";
	            case "prev":
	                return "上一页";
	            case "next":
	                return "下一页";
	            case "last":
	                return "尾页";
	            case "page":
	                return (page === current) ? "当前页 " + page : "当前页 " + page;
	            }
    		},
    		size:"small",
           	onPageClicked:null, 
           	onPageChanged:function(e, oldPage, newPage){
           		getRuleList(newPage);
           	}
        };
        container.bootstrapPaginator(options);
	}
	$("#divContent").empty();
	$('#myTemplate').tmpl(lists).appendTo('#divContent');
	$('.superbox').SuperBox();

	$("span[class$=_name_cut]").each(function(){
		var this_html = $(this).html();
		var this_html_cut = cut_str(this_html, 8,"...");
		$(this).html(this_html_cut);
	});
	loadingHide();
	dialogCenterScreen(addPageRuleDialog);
}
var addPageRuleDialog;
function addPageRule()
{
	addPageRuleDialog = art.dialog({id: 'addPageRuleDialog',title: "新增页面规则", top: '10%',width:"900px",lock:true});
	addPageRuleDialog.hide();
	loadingShow();
	$.ajax({
	    url: '/news/addPageRule',
	    complete:function(){
	    	InitFilter();
	    	container=$('#pager');
	    	getRuleList(pageIndex);
	    },
	    success: function (data) {
	        addPageRuleDialog.content(data);
	    },
	    cache: false
	});
	$(addPageRuleDialog).css("width","100%").css("height","600px").css("overflow-y","scroll");
}

function searchResult(){
	/*
	var section = $("#txtPageName").val();
	var sectionUrl = $("#txtPageUrl").val();
	var groupId = $("#ul_group .active a").attr("site_id");
	var url = "/newsGroupRule/getNewsGroupRuleList";
	var pdata = {"l_section":section};
	if($("#user_oprate_box").css("display")=='block'){
		url+="&eq_groupId="+groupId;
	}
	*/
	//var params = {"l_section":section,"eq_groupId":groupId};
	//addQueryParams(url,params);
	//oTable.fnSettings().sAjaxSource=url;
	oTable.fnDraw(); //重新加载数据
}


// sb==============================================================this is a longer line===================================================================


function searchRequirement(){
	var url = "/newsGroupRule/getNewsGroupRuleRequirementList";
	var eq_state = $("select[name='eq_state']").val();
	var l_section = $("input[name='l_section']").val();
	var params = {"eq_state":eq_state,"l_section":l_section};
	url = addQueryParams(url,params);
	news_group_rule_requirement_list_table.fnSettings().sAjaxSource=url;
	news_group_rule_requirement_list_table.fnDraw(); //重新加载数据
}

loadScript(
		"resources/js/plugin/datatables/jquery.dataTables.min.js",
		function() {
			loadScript(
					"resources/js/plugin/datatables/dataTables.colVis.min.js",
					function() {
						loadScript(
								"resources/js/plugin/datatables/dataTables.tableTools.min.js",
								function() {
									loadScript(
											"resources/js/plugin/datatables/dataTables.bootstrap.min.js",
											function() {
												loadScript("resources/js/custom-edit.js",function(){
													loadScript("/resources/js/plugin/superbox/superbox.js",pagefunction);
												});
											});
								});
					});
});
--></script>
