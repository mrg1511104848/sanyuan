<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title  txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 系统管理
			<span>> 用户管理</span>
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
			用户列表
		</h2>
		</header>
		<!-- widget div-->
		<div>
			<div class="jarviswidget-editbox">
			</div>
			<div class="widget-body no-padding">
				<table id="tbUserTable"
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
<script type="text/javascript">
pageSetUp();
	var user_edit;
	
	function InitUserList()
	{
		user_edit=new InfoEdit();
		user_edit.requestUrl="user";
		user_edit.oTable=$("#tbUserTable").dataTable({
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
			"sDom": "<'dt-toolbar'<'col-xs-8 tools-bar'><'col-xs-4'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
			"oColVis": {
	            "buttonText": "表格列显示 / 隐藏"
	        },
	        "bSort":false,
			"bPaginate" : true,
			"bProcessing" : false,
			"bServerSide" : true,
			"sAjaxSource" : "/user/getPagedList.html",
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
				"sTitle": "用户名", "sClass": "center", "data" : "userName"
			},{
				"sTitle": "状态", "sClass": "center", "data" : function(row,type,set){
					return row.enabled=="1"?"启用":"禁用";
				}
			},{
				"sTitle": "采集页面上限", "sClass": "center", "data" : function(row,type,set){
					return row.collectPageLimit;
				}
			},{
				"sTitle": "采集数量上限", "sClass": "center", "data" : function(row,type,set){
					return row.collectCountLimit;
				}
			}, {
				"sWidth":'85px',
	            "sTitle": "操作",
	            "sClass": "center",
	            "data": function ( row, type, set ){
					var enableUserbtn = "<button  onclick=\"changeUserState(this,'"+row.id+"',1);\" title=\"启用\" id='statebtn' class=\"btn btn-xs btn-default\"><i class=\"glyphicon glyphicon-play\"></i></button>";
					var disableUserbtn = "<button  onclick=\"changeUserState(this,'"+row.id+"',0);\" title=\"停用\" id='statebtn' class=\"btn btn-xs btn-default\"><i class=\"glyphicon glyphicon-pause\"></i></button>";
					var enableDisabledUserBtn;
					if(row.enabled=="1"){
						enableDisabledUserBtn = disableUserbtn;
					}else{
						enableDisabledUserBtn = enableUserbtn;
					}

					var deleteBtn = "<button  onclick=\"user_edit.deleteRow('"+row.id+"');\" title=\"删除\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-times\"></i></button>&nbsp;";

					if(row.isAdmin==1){
						deleteBtn = "";
						enableDisabledUserBtn="";
					}

			        return "<button  onclick=\"openDialog(this,'"+row.id+"');\" title=\"编辑\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></button>&nbsp;"
			        +deleteBtn+enableDisabledUserBtn;
		        } 
	        }],
	        "fnInitComplete": function(oSettings, json) {
					initUserListTableButton();
			 },
		});
	}
	function initUserListTableButton(){
		$("#tbUserTable_filter label").remove();
		$("#tbUserTable_wrapper .dt-toolbar").addClass("padding_B5");
		var s_username_btn = '<input type="text" name="l_userName" class="form-control ng-valid ng-dirty margin_R5" placeholder="用户名">';
		var s_submit_btn = '<a class="btn btn-default" id="user_search" onclick="user_search()">查询 </a>';
		$("#tbUserTable_wrapper .dt-toolbar div:eq(0)").append($(s_username_btn)).append($(s_submit_btn));


		var add_btn = '<a class="btn btn-primary margin_L5" name="toAdd" id="weiboUser" style="float:right;" onclick="openDialog()" href="javascript:void(0);">添加用户</a>';
		$("#tbUserTable_wrapper .dt-toolbar div:eq(1)").append($(add_btn));
	}
	var pagefunction=function(){
		InitUserList();
	}
	function user_search(){
		var url = "/user/getPagedList.html";
		var l_userName = $("input[name='l_userName']").val();
		var params = {"l_userName":l_userName}
		url = addQueryParams(url,params);
		user_edit.oTable.fnSettings().sAjaxSource=url;
		user_edit.oTable.fnDraw(); //重新加载数据
	}
	function changeUserState(ele,id,state){
		$.ajax({
			url:"/user/changeState?id="+id+"&state="+state,
			dataType:'json',
			success:function(r){
				if(r.success==true){
					var c = $(ele).find("i").attr("class");
					if(state==0){
						$(ele).parent().append($("<button  onclick=\"changeUserState(this,'"+id+"',1);\" title=\"启用\" id='statebtn' class=\"btn btn-xs btn-default\"><i class=\"glyphicon glyphicon-play\"></i></button>"));
						$(ele).parents("tr:eq(0)").find("td:eq(1)").html("禁用");
						$(ele).remove();
					}else{
						$(ele).parent().append($("<button  onclick=\"changeUserState(this,'"+id+"',0);\" title=\"启用\" id='statebtn' class=\"btn btn-xs btn-default\"><i class=\"glyphicon glyphicon-pause\"></i></button>"));
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
	function openDialog(obj,id)
	{
		if(!id){id=""}
		loadingShow();
		$("#remoteModal").load("/user/edit?eq_id="+id,function(){
			var dialog = window.top.art.dialog({
				title: "详情",
				content: $("#remoteModal")[0],
				width:"850px",
				padding: '0px 0px',
				lock:true,
				button:[{
					name:"保存",
			    	callback:function(){
			    		if(!checkFrmIpt()){
			    			return false;
			    		}
						var url = "user/saveOrUpdate";
						var data= $("#frmUser").serialize();
						$.ajax({
								url:url,
								data:data,
								type:"POST",
								success:function(data){
									if(data){
										dialog.close();
										user_edit.oTable.fnDraw(); //重新加载数据
										MessageBoxShow('保存成功!',true);
									}
								}
						});
							
					}
				},{
					name:"取消",
					callback:function(){
					dialog.close();
					}
				}],
				init: function () {
			    	changeArtdialogButtonCss();
			    }
			});
			
			$(".aui_content").css("width","100%");
			
			loadingHide();
			dialogCenterScreen(dialog);
		});
		//$('#remoteModal').dialog("open");
		
	}
	function checkFrmIpt(){
		var result = true;
		var phoneNum = $("[name='phoneNum']").val();
		var email = $("[name='email']").val();
		var mobileRex = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0-9]|170)\d{8}$/;
		var emailRex  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		if(!phoneNum){
			MessageBoxShow('手机号必须填写!');
			result = false;
		}else if(!mobileRex.test(phoneNum)){
			MessageBoxShow('手机号格式错误!');
			result = false;
		}else if(!email){
			MessageBoxShow('邮箱必须填写!');
			result = false;
		}else if(!emailRex.test(email)){
			MessageBoxShow('邮箱格式错误!');
			result = false;
		}
		return result;
	}
	//初始化用户表单
    function initUserFormParam(){
        return $('#frmUser').validate({
            rules : {
                userName : {
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
                userName : {
                    required : '请输入用户名'
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
												loadScript("resources/js/custom-edit.js",pagefunction);
											});
								});
					});
		});
</script>