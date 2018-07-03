pageSetUp();
var pagefunction=function(){
	InitAppList();
}
var distributionStrategy;
function InitAppList()
{
	var params = "";
	if($("#groupId").val()){
		params+="eq_groupId="+$("#groupId").val();
	}
	distributionStrategy=new InfoEdit();
	distributionStrategy.requestUrl="distribution-strategies";
	distributionStrategy.oTable=$("#tbAppTable").dataTable({
		"oLanguage" : common_data_table_config.oLanguage,
		"sDom": "<'dt-toolbar'<'col-xs-6 tools-bar'><'col-xs-6'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
		"oColVis": {
            "buttonText": "表格列显示 / 隐藏"
        },
        "bSort":false,
		"bPaginate" : true,
		"bProcessing" : false,
		"bServerSide" : true,
		"sAjaxSource" : "/distribution-strategies/getPagedList.html?"+params,
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
				return genHtmlByObject(s_name);
			}
		}, {
			"sTitle": "站点名称", "sClass": "center", "data" : function ( row, type, set ){
				return genHtmlByObject(row.siteName);
			}
		}, {
			"sTitle": "栏目名称", "sClass": "center", "data" : function ( row, type, set ){
			return genHtmlByObject(row.columnName);
			}
		}, {
			"sTitle": "表单名称", "sClass": "center", "data" : function ( row, type, set ){
			return genHtmlByObject(row.formName);
			}
		}, {
			"sWidth":'140px',
            "sTitle": "操作",
            "sClass": "center",
            "data": function ( row, type, set ){
            	var pushBtn = "<button  onclick=\"push(this,'"+row.id+"','"+row.name+"');\" title=\"推送\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-play\"></i></button>&nbsp;";
            	var resetTimeStampBtn = "<button  onclick=\"resetCollection('"+row.id+"');\" title=\"重新采集\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-refresh\"></i></button>&nbsp;";
            	var lookRuningLogsBtn = "<button  onclick=\"lookRuningRecords('"+row.id+"');\" title=\"查看运行日志\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-book\"></i></button>&nbsp;";
				var editBtn = "<button  onclick=\"openDistributionDialog(this,'"+row.id+"');\" title=\"编辑\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></button>&nbsp;";
            	var deleteBtn = "<button  onclick=\"distributionStrategy.deleteRow('"+row.id+"','name="+row.name+"');\" title=\"删除\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-times\"></i></button>&nbsp;";
            	return pushBtn+resetTimeStampBtn+lookRuningLogsBtn+editBtn+deleteBtn;
	        } 
        }],
        "fnInitComplete": function(oSettings, json) {
				initAppListTableButton();
		 },
	});
}
/*推送数据*/
function push(ele,id,name){
	$.ajax({
		url:'/distribution-strategies/push.html?eq_id='+id,
		dataType:'json',
		beforeSend:function(){
			//这里是开始执行方法，显示效果
			$(ele).attr("disabled","disabled");
			$(ele).find("i").attr("class","fa fa-gear fa-1x fa-spin")
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
			$(ele).removeAttr("disabled");
			$(ele).find("i").attr("class","fa fa-play")
		},
		success:function(d){
			if(d.result==1){
				MessageBoxShow(name+'推送成功!',true);
			}
			else if(d.result==-1){MessageBoxShow(name+'推送失败，服务器异常!');}
			else if(d.result==0){MessageBoxShow(name+'推送失败，该记录已被删除!');}
		}
	})
	
}
function initAppListTableButton(){
	$("#tbAppTable_filter label").remove();
	$("#tbAppTable_wrapper .dt-toolbar").addClass("padding_B5");
	var s_appname_btn = '<input type="text" name="name" class="form-control ng-valid ng-dirty margin_R5" placeholder="策略名称">';
	var s_submit_btn = '<a class="btn btn-default" id="distribution_strategies_search" onclick="distribution_strategies_search()">查询 </a>';
	$("#tbAppTable_wrapper .dt-toolbar div:eq(0)").append($(s_appname_btn)).append($(s_submit_btn));
	
	
	/*var look_runing_logs = '<a class="btn btn-default margin_L5" name="toAdd"  style="float:right;" onclick="lookRuningRecords()" href="javascript:void(0);"><i class="fa fa-book"></i>&nbsp;查看运行日志</a>';
	$("#tbAppTable_wrapper .dt-toolbar div:eq(1)").append($(look_runing_logs));*/
	var add_btn = '<a class="btn btn-primary margin_L5" name="toAdd" id="weiboApp" style="float:right;" onclick="openDistributionDialog()" href="javascript:void(0);">添加分发策略</a>';
	$("#tbAppTable_wrapper .dt-toolbar div:eq(1)").append($(add_btn));
}

function lookRuningRecords(distributionStrategyId){
	var buttons = [{
				name:"<i class='pRed'></i>一键删除",
				callback:function(){
					if($("#running_record_list").text().indexOf("没有找到记录")>-1){
						confirm('操作确认','<div style=padding:10px>当前无数据</div>');
					}else{
						confirm('操作确认','<div style=padding:10px><font color=red>确定要删除吗(一旦删除，数据将无法恢复!)</font></div>','deleteRecord','','','delAll')
					}
					return false;
				}
			},{
				name:"取消",
				callback:function(){
				}
			}];
	callDialog("/distribution-record/lookRuningRecords?distributionStrategyId="+distributionStrategyId,"runingRecordModal","作业运行日志","700",buttons);
}
function distribution_strategies_search(){
	var url = "/distribution-strategies/getPagedList.html";
	
	var name = $("input[name='name']").val();
	var params = {"l_name":name,"eq_groupId":$("#groupId").val()};
	url = addQueryParams(url,params);
	distributionStrategy.oTable.fnSettings().sAjaxSource=url;
	distributionStrategy.oTable.fnDraw(); //重新加载数据
}

function resetAfter(id){
	$.ajax({
		url:'/distribution-strategies/resetTimestamp.html?id='+id,
		type:'post',
		dataType:'json',
		success:function(d){
			if(d.result>0){
				MessageBoxShow('重置成功!',true);
			}else{
				MessageBoxShow('重置失败，服务器异常!',true);
			}
		}
	})
	
}
function openDistributionDialog(obj,id)
{
	var groupId = $("#groupId").val();
	if(!id){id=""}
	callDialog("/distribution-strategies/edit?eq_id="+id+"&selectGroupId="+groupId,"distributionModal","详情","550",[],'','afterOpenDistributionDialog');
	
}
function afterOpenDistributionDialog(dialog){
	var buttons = [{
				name:"下一页",
				callback:function(){
					nextPage();
					return false;
				}
			},{
				name:"保存",
		    	callback:function(){
					saveDistributionStrategy(dialog);
					return false;
				}
			},{
				name:"取消",
				callback:function(){
				}
	}];
	dialog.button(buttons);
}
function nextPage(){
	var clazz = $("[class^=page]:visible").attr("class").split(" ")[0];
	var reg = /[1-9][0-9]*/g;  
	var numList = clazz.match(reg); 
	var currPage = numList[0];
	if(currPage==3){
		currPage = 1;
	}else{
		currPage++;
	}
	$("[class^=page]:visible").hide();
	$(".page"+currPage).show();
}
function resetCollection(id){
	var title = '重置确认';
	var htm = "<div style='padding:10px;'>确认要重置吗?<br/>(<font style='color:red;'>警告:此操作会导致数据重复，请到系统中删除数据后操作!</font>) <div style='display:none;'><input name='del_id' id='site_allrule_del_id'/></div></div>";
	confirm(title,htm,'resetAfter','',id);
}
function getParentNodeIds(childNode){
	console.log("##开始构建##");
	var pnode_tree;
	var pnode_ids = [];
	do{
		pnode_ids.push(childNode.id);
		pnode_tree = childNode.getParentNode();
		if(pnode_tree!=null){
			pnode_ids.push(pnode_tree.id);
			childNode = pnode_tree;
		}
	}while(pnode_tree!=null)
	pnode_ids.reverse();
	pnode_ids = pnode_ids.join();
	console.log("##结束构建##");
	return pnode_ids;
}
function dealFormDeepIds(){
	try{
		var arr = ['tree','tree2'];
		var obj_deepIds = ['siteDeepIds','columnDeepIds'];
		for(var i = 0 ; i < arr.length; i++){
			var obj_tree = $.fn.zTree.getZTreeObj(arr[i]);
			var nodes_tree = obj_tree.getSelectedNodes();
			if(nodes_tree.length>0){
				var deepIds = getParentNodeIds(nodes_tree[0]);
				$("#"+obj_deepIds[i]).val(deepIds); 
			}
		}
	}catch(e){}
}

function saveDistributionStrategy(dialog){
	
	
	var url = "/distribution-strategies/saveOrUpdate",data,propertyMapping = '',formKey = '',visibleForm;
	//开始处理ztree deep nodes
	dealFormDeepIds();
	
	data= $("#frmApp").serialize();
	
	$("#forms .forms").each(function(){
		if($(this).css("display")=='block'){//因为切换到第二页通过:visible属性获取不到。所以得通过block
			visibleForm = $(this);
		}
	});
	//判断所有非空字段是否已经选择(除主键外)
	var isprimaryKeyFormsShow = $("#primaryKeyForms").css("display")=='block';
	if(isprimaryKeyFormsShow){
		var notBlankArr = [];
		var selectNotBlankArr = [];
		var alreadySelectedVal = $("#primaryKeyForms").find("select").val();
		$("#primaryKeyForms").find("option").each(function(){
			var optionText = $(this).text();
			if(optionText.indexOf('非空')>-1&&alreadySelectedVal!=$(this).val()){
				notBlankArr.push($(this).attr("value"));
			}
		})
		if(alreadySelectedVal){//如果已选择，保存时，扫描非主键外的全部的非空字段
			$(visibleForm).find(".targetPropertys").each(function(){
				var opSelect = $(this).val();
				if(notBlankArr.indexOf(opSelect)>-1
						&&selectNotBlankArr.indexOf(opSelect)==-1){
					selectNotBlankArr.push(opSelect);
				}
			});
		}
		if(notBlankArr.length>selectNotBlankArr.length){
			MessageBoxShow('请确保目标表单中所有非空字段全部选中!');
			return;
		}
	}
	if(getAppType()!='hy'&&(!visibleForm)){
		MessageBoxShow('请确保源表单目标表单选择是否正确!');
		return;
	}
	if(visibleForm){
		var propertyInvalidCount = 0;//检测用户选择元表单和目标表单是否正确 
		//开始处理 formKey
		formKey = "formKey="+$(visibleForm).attr("formkey");
		for(var i = 0 ; i < $(visibleForm).find(".sourcePropertys").length; i++){
			var sorPro = $(visibleForm).find(".sourcePropertys:eq("+i+")").val();
			var tarPro = $(visibleForm).find(".targetPropertys:eq("+i+")").val();
			if(!sorPro||!tarPro){
				propertyInvalidCount++;
				continue;
			}
			propertyMapping+='propertyMapping['+sorPro+']='+tarPro+"&";
		}
		if(propertyInvalidCount==$(visibleForm).find(".sourcePropertys").length){//表示用户根本没选择源表单和目标表单
			MessageBoxShow('请确保源表单目标表单选择是否正确!');
			return;
		}
	}
	var isFilterValid = true;//验证过滤条件的完整性
	var filter = "";
	for(var i = 0 ; i < $("#frmApp2 .row:gt(0)").length; i++){
		var mongofields = $("#frmApp2 .row:gt(0) .mongofields:eq("+i+")").val().trim();
		var coditions = $("#frmApp2 .row:gt(0) .conditions:eq("+i+")").val().trim();
		var values = $("#frmApp2 .row:gt(0) .values:eq("+i+")").val().trim();
		filter+='filter['+i+']='+mongofields+"&";
		filter+='filter['+i+']='+coditions+"&";
		filter+='filter['+i+']='+values+"&";
		if((!mongofields||!coditions||!values)&&!(!mongofields&&!coditions&&!values)){
			isFilterValid = false;
		}
	}
	if(!isFilterValid){//过滤条件选的有问题
		MessageBoxShow('请确保过滤条件选择是否正确!');
		return;
	}
	
	var andOrIsChecked = $(".andOrFlag:checked").length>0?1:0;
	var timerOnOffIsChecked = $(".timerOnOffFlag:checked").length>0?1:0;
	var andOrFlag = "andOrFlag="+andOrIsChecked;
	var timerOnOffFlag = "timerOnOffFlag="+timerOnOffIsChecked;
	var timerMode = "timerMode="+($("#collect_plan select").length>0?0:1);//定时器模式             0:普通模式（直接选择表达式）      1:高级模式(手动填入表达式)
	var timerExpression = "timerExpression="+$(".collect_plan").val();//定时器表达式
	
	data+="&"+propertyMapping+"&"+filter+"&"+andOrFlag+"&"+timerOnOffFlag+"&"+timerMode+"&"+timerExpression+"&"+formKey;
	$.ajax({
			url:url,
			data:data,
			type:"POST",
			success:function(data){
				if(data){
					dialog.close();
					distributionStrategy.oTable.fnDraw(); //重新加载数据
					MessageBoxShow('保存成功!',true);
				}
			}
	});
}
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
//初始化分发策略表单
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
											loadScript("resources/js/custom-edit.js",pagefunction);
										});
							});
				});
	});
