<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title  txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 审单系统
			<span>> 待审处方</span>
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
			待审列表
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

    var timesRun;
    var interval = setInterval(function(){
        var url = "pendingRecipe/getMsg";
        var recipeIds = "";
        $("td[name=recipeId]").each(function(i){
            recipeIds += $(this).text()+",";

        });
        var data= {"recipeIds":recipeIds};
        $.ajax({
            url:url,
            data:data,
            type:"POST",
            success:function(d){
                var dd = $.parseJSON(d);
                if(dd.msg.length>0){
                    app_edit.oTable.fnDraw(); //重新加载数据
                }
            }
        });

        timesRun += 1;
        if(timesRun === 60){
//      clearInterval(interval);
        }
        //do whatever here..
    }, 2000);


    function InitAppList()
	{
		app_edit=new InfoEdit();
		app_edit.requestUrl="pendingRecipe";
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
			"sAjaxSource" : "/pendingRecipe/getPagedList.html",
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
                "sWidth":'120px',"sTitle": "操作", "sClass": "center", "data" : function (row,type,set) {
                    var editBtn = "<button  onclick=\"app_edit.changeRecipeState($(this),'"+row.recipeId+"','0');\" title=\"通过\" class=\"btn btn-xs btn-default\">通过</button>&nbsp;";
                    var deleteBtn = "<button  onclick=\"app_edit.changeRecipeState($(this),'"+row.recipeId+"','1');\" title=\"不通过\" class=\"btn btn-xs btn-default\">不通过</button>&nbsp;";
                    return editBtn+deleteBtn;
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
                    var d="<input type='hidden' class='key-state' name='drugNameState' value='"+row.drugNameState+"'/>";
                    var t ="<span class='nomal-clo'>"+row.drugName+" </span>"
                    if(row.drugNameState=="1"){
                       t ="<span class='warning-clo'>"+row.drugName+" </span>"
                    }
                    return d+t;
                }
            },{
                "sTitle": "单剂量", "sClass": "center", "data" : function(row,type,set){
                    var d="<input type='hidden' class='key-state' name='singleDoseState' value='"+row.singleDoseState+"'/>";
                    var t ="<span class='nomal-clo'>"+row.singleDose+" </span>"
                    if(row.singleDoseState=="1"){
                        t ="<span class='warning-clo'>"+row.singleDose+" </span>";

                    }
                    return d+t;
                }
            },{
                "sTitle": "频次", "sClass": "center", "data" : function(row,type,set){
                    var d="<input type='hidden'  class='key-state' name='frequencyState' value='"+row.frequencyState+"'/>";
                    var t ="<span class='nomal-clo'>"+row.frequency+" </span>"
                    if(row.frequencyState=="1"){
                        t ="<span class='warning-clo'>"+row.frequency+" </span>";

                    }
                    return d+t;
                }
            },{
                "sTitle": "途径", "sClass": "center", "data" : function(row,type,set){
                    var d="<input type='hidden' class='key-state' name='channelState' value='"+row.channelState+"'/>";
                    var t ="<span class='nomal-clo'>"+row.channel+" </span>"
                    if(row.channelState=="1"){
                        t ="<span class='warning-clo'>"+row.channel+" </span>";

                    }
                    return d+t;
                }
            },{
                "sTitle": "数量", "sClass": "center", "data" : function(row,type,set){
                    var d="<input type='hidden' class='key-state' name='amountState' value='"+row.amountState+"'/>";
                    var t ="<span class='nomal-clo'>"+row.amount+" </span>"
                    if(row.amountState=="1"){
                        t ="<span class='warning-clo'>"+row.amount+" </span>";

                    }
                    return d+t;
                }
            },{
                "sTitle": "单位", "sClass": "center", "data" : function(row,type,set){

                    return genHtmlByObject(row.unit);
                }
            }
	        ],
	        "fnInitComplete": function(oSettings, json) {
					initAppListTableButton();
                $('span[class$="-clo"]').bind("click",function () {

                    if( $(this).attr("class")=="nomal-clo"){
                        $(this).attr("class","warning-clo");
                        $(this).prev().attr("value","1");
                    }else{
                        $(this).attr("class","nomal-clo");
                        $(this).prev().attr("value","0");
                    }

                });
			 },
		});
	}
	function initAppListTableButton(){
		$("#tbAppTable_filter label").remove();
		$("#tbAppTable_wrapper .dt-toolbar").addClass("padding_B5");
		var s_appname_btn = '<input type="text" name="l_name" class="form-control ng-valid ng-dirty margin_R5" placeholder="姓名">';
		var s_submit_btn = '<a class="btn btn-default" id="app_search" onclick="app_search()" >查询 </a>';
		$("#tbAppTable_wrapper .dt-toolbar div:eq(0)").append($(s_appname_btn)).append($(s_submit_btn));


		//var add_btn = '<a class="btn btn-primary margin_L5" name="toAdd" id="weiboApp" style="float:right;" onclick="openDialog()" href="javascript:void(0);">添加应用</a>';
		//$("#tbAppTable_wrapper .dt-toolbar div:eq(1)").append($(add_btn));
		
	}
	var pagefunction=function(){
		InitAppList();
	}
	function app_search(){
		var url = "/pendingRecipe/getPagedList.html";
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
												//loadScript("resources/js/custom-edit.js",pagefunction);
                                                loadScript("resources/js/pending-recipe.js",pagefunction);
											});
								});
					});
		});
    /*window.onload = function(){
        obj_li = document.getElementsByTagName("span"); // 获取li对象数组
        for(k in obj_li)
            obj_li[k].onclick=function(){  // 为每个li注册单击事件
                if(this.className=="nomal-clo") {
                    this.className ="warning-clo";
                }
                if(this.className=="warning-clo") {
                    this.className ="nomal-clo";
                }
                app_edit.oTable.fnDraw(); //重新加载数据
            }
    }*/



</script>