<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title  txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 审单系统
			<span>> 已审处方</span>
		</h1>
	</div>
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8" style="text-align:right;">
	</div>
</div>
<section id="widget-grid" class="">
<div class="row">
	<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	<div class="jarviswidget jarviswidget-color-darken" id="wid-id-1"
		data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
		<header>
		<span class="widget-icon"> <i class="fa fa-table"></i> </span>
		<h2>
			已审列表
		</h2>
		</header>
		<!-- widget div-->
		<div>
			<div class="jarviswidget-editbox">
			</div>
			<div class="widget-body no-padding">
				<table id="tbAppTable"
					class="table table-striped table-bordered table-hover" width="100%">
				</table>
			</div>
		</div>
	</div>
	</article>
</div>
</section>
<div id="remoteModal" style="display: none;"></div>
<div id="divDialog"></div>
<script type="text/javascript" src="/resources/js/pending-recipe-common.js"></script>
<script type="text/javascript">
	pageSetUp();
	var app_edit;
	
	function InitAppList()
	{
		app_edit=new InfoEdit();
		app_edit.requestUrl="app";
		app_edit.oTable=$("#tbAppTable").dataTable({
			"oLanguage" : common_data_table_config.oLanguage,
			"sDom": "<'dt-toolbar'<'col-xs-8 tools-bar'><'col-xs-4'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
			"oColVis": {
	            "buttonText": "表格列显示 / 隐藏"
	        },
	        "bSort":false,
			"bPaginate" : true,
			"bProcessing" : false,
			"bServerSide" : true,
			"sAjaxSource" : "/alreadyRecipe/getPagedList.html",
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
			
			"aoColumns" : [ {
                "sTitle": "操作", "sClass": "center", "data" : function (row,type,set) {
                    var deleteBtn = "<button  onclick=\"app_edit.getMessageInfo('"+row.recipeId+"');\" title=\"查看消息\" class=\"btn btn-xs btn-default\">查看消息</button>&nbsp;";
                    return deleteBtn;
                }
            },{
                "sTitle": "姓名", "sClass": "center", "data" : function(row,type,set){
                    var nameBtn = "<button  onclick=\"app_edit.getPatientInfo('"+row.patientId+"');\" title=\"姓名\" class=\"btn btn-xs btn-default\">"+row.name+"</button>&nbsp;";
                    return nameBtn;
                }
            },{
                "sTitle": "处方号", "sClass": "center", "data" : function(row,type,set){
                    return genHtmlByObject(row.recipeId);
                }
            },{
                "sTitle": "科别", "sClass": "center", "data" : function(row,type,set){

                    return genHtmlByObject(row.category);
                }
            },{
                "sTitle": "药品名称", "sClass": "center", "data" : function(row,type,set){
                    if(row.drugNameState=="1"){

                    }
                    return genHtmlByObject(row.drugName);
                }
            },{
                "sTitle": "单剂量", "sClass": "center", "data" : function(row,type,set){
                    if(row.singleDoseState=="1"){

                    }
                    return genHtmlByObject(row.singleDose);
                }
            },{
                "sTitle": "频次", "sClass": "center", "data" : function(row,type,set){
                    if(row.frequencyDoseState=="1"){

                    }

                    return genHtmlByObject(row.frequency);
                }
            },{
                "sTitle": "途径", "sClass": "center", "data" : function(row,type,set){
                    if(row.channelDoseState=="1"){

                    }
                    return genHtmlByObject(row.channel);
                }
            },{
                "sTitle": "数量", "sClass": "center", "data" : function(row,type,set){
                    if(row.amountDoseState=="1"){

                    }

                    return genHtmlByObject(row.amount);
                }
            },{
                "sTitle": "单位", "sClass": "center", "data" : function(row,type,set){

                    return genHtmlByObject(row.unit);
                }
            }
            ],
	        "fnInitComplete": function(oSettings, json) {
					initAppListTableButton();
			 },
		});
	}
	function initAppListTableButton(){
		$("#tbAppTable_filter label").remove();
		$("#tbAppTable_wrapper .dt-toolbar").addClass("padding_B5");
		var s_appname_btn = '<input type="text" name="l_name" class="form-control ng-valid ng-dirty margin_R5" placeholder="应用名">';
		var s_submit_btn = '<a class="btn btn-default" id="app_search" onclick="app_search()" >查询 </a>';
		$("#tbAppTable_wrapper .dt-toolbar div:eq(0)").append($(s_appname_btn)).append($(s_submit_btn));


		//var add_btn = '<a class="btn btn-primary margin_L5" name="toAdd" id="weiboApp" style="float:right;" onclick="openDialog()" href="javascript:void(0);">添加应用</a>';
		//$("#tbAppTable_wrapper .dt-toolbar div:eq(1)").append($(add_btn));
		
	}
	var pagefunction=function(){
		InitAppList();
	}
	function app_search(){
		var url = "/alreadyRecipe/getPagedList.html";
		var l_name = $("input[name='l_name']").val();
		var params = {"l_name":l_name}
		url = addQueryParams(url,params);
		app_edit.oTable.fnSettings().sAjaxSource=url;
		app_edit.oTable.fnDraw(); //重新加载数据
	}
	function changeAppState(ele,id,state){
		$.ajax({
			url:"/app/changeState?id="+id+"&state="+state,
			dataType:'json',
			success:function(r){
				if(r.success==true){
					var c = $(ele).find("i").attr("class");
					if(state==0){
						$(ele).parent().append($("<button  onclick=\"changeAppState(this,'"+id+"',1);\" title=\"启用\" id='statebtn' class=\"btn btn-xs btn-default\"><i class=\"glyphicon glyphicon-play\"></i></button>"));
						$(ele).parents("tr:eq(0)").find("td:eq(1)").html("禁用");
						$(ele).remove();
					}else{
						$(ele).parent().append($("<button  onclick=\"changeAppState(this,'"+id+"',0);\" title=\"启用\" id='statebtn' class=\"btn btn-xs btn-default\"><i class=\"glyphicon glyphicon-pause\"></i></button>"));
						$(ele).parents("tr:eq(0)").find("td:eq(1)").html("启用");
						$(ele).remove();
					}
					MessageBoxShow('保存成功!',true);
				}else{
					MessageBoxShow('保存失败!');
				}
			},
			error:function(){
				MessageBoxShow('保存失败!');
			}
		})
	}
	
	function checkFrmIpt(){
		var result = true;
		return result;
	}
	//初始化应用表单
    function initAppFormParam(){
        return $('#frmApp').validate({
            rules : {
                appName : {
                    required : true,
                    minlength : 3,
					maxlength : 20,
					illegal:true
                },
                weixinId : {
                    required : true,
                    illegal:true
                },
                passWord:{
                    required:true,
					minlength : 3,
					maxlength : 20,
					illegal:true
                },
                phoneNum:{
                    required:true,
                    mobile:true
                }
            },
            messages : {
                appName : {
                    required : '请输入应用名'
                },
                weixinId : {
                    required : '请输入微信号'
                },
                passWord : {
                    required : '请输入密码'
                },
                phoneNum:{
                    required:'请输入电话号码'
                }
            },
            errorPlacement : function(error, element) {
                error.insertAfter(element.parent());
            }
        }).form();
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
												loadScript("resources/js/pending-recipe.js",pagefunction);
											});
								});
					});
		});
</script>