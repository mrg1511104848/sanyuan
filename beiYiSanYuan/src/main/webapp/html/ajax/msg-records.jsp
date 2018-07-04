<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title  txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 消息管理
			<span>> 消息列表 </span>
		</h1>
	</div>
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8" style="text-align:right;height: 45px;line-height: 62px;">
		<button class="btn btn-default" onclick="setting()">
             <i class="fa fa-gears"></i> <span class="hidden-mobile">设置</span>
        </button>
	</div>
</div>

<!-- widget grid -->
<section id="widget-grid" class="">

<!-- row -->
<div class="row">
	<!-- 这是站点表格 -->
	<article class="col-sm-12 col-md-12 col-lg-12">
		<div class="jarviswidget jarviswidget-color-darken"
			data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
			<header>
			<span class="widget-icon"> <i class="fa fa-table"></i> </span>
			<h2>
				消息设置
			</h2>
	
			</header>
	
			<!-- widget div-->
			<div>
	
				<!-- widget edit box -->
				<div class="jarviswidget-editbox">
					<!-- This area used as dropdown edit box -->
				</div>
				<!-- end widget edit box -->
	
				<!-- widget content -->
				<div class="widget-body no-padding">
	
					<table id="msg_records_table"
						class="table table-striped table-bordered table-hover smart-form has-tickbox" 
						width="100%">
						<thead>
							<tr>
								<th>
									标题
								</th>
								<th>
									内容
								</th>
								<th>
									收信方
								</th>
								<th>
									发送时间
								</th>
								<th>
									发送方式
								</th>
							</tr>
						</thead>
						</tbody>
					</table>
	
				</div>
				<!-- end widget content -->
			</div>
			<!-- end widget div -->
		</div>
    </article>
</div>
<div id="msg_set_dialog" style="display:none;"></div>
<script src="/resources/js/news-common.js"></script>
<script type="text/javascript"><!--
 	//初始化加载一些参数
	pageSetUp();
	
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	var msg_records_table = null;
	var msg_set_dialog;
	
	// pagefunction	
	var pagefunction = function() {
		loadRuleTable();
		function loadRuleTable(){
			if(msg_records_table!=null){
		        	$("#msg_records_table tbody tr").remove();
		        	msg_records_table.fnDestroy();
			}
			msg_records_table = $("#msg_records_table").dataTable({
					"bProcessing" : true,//加载数据时候是否显示进度条
					"bServerSide" : true,//是否从服务加载数据 
					"sAjaxSource" : "/msg/getMessageRecordsPagedList"+"?timeStamp="+new Date().getTime()+"&orderBy=sendTime-desc",//如果从服务器端加载数据,这个属性用于指定加载的路径 
					"sPaginationType" : "full_numbers",
					"bSort":false,
					"columns": [
						{"sWidth" : "15%","data": function ( row, type, set ){
							return row.title;
				        }},
				        {"sWidth" : "15%","data": function ( row, type, set ){
				        var content = row.content;
				        	var scontent = cut_str(content, 20,"...");
							return "<span title='"+content+"'>"+scontent+"</span>";
				        }},
				        {"data": function ( row, type, set ){
							return row.toUserName;
				        }},
				        {"data": function ( row, type, set ){
							return row.sendTime;// 
				        }},
				        {"data": function ( row, type, set ){
				        	if(row.sendWay==1) return "短信" ;
				        	if(row.sendWay==2) return "邮件" ;
				        	if(row.sendWay==3) return "微信" ;
				        }}
					],
					"oLanguage" : common_data_table_config.oLanguage,
					"fnInitComplete": function(oSettings, json) {
						initButtons();
				     },
				     "fnDrawCallback": function( oSettings ) {
				     	
					 },
				     "sDom": "<'dt-toolbar'<'col-xs-6 tools-bar'><'col-xs-6'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
			    });
		}
	}
	function initButtons(){
		var l_toUserName = '<div class="btn-group margin_R5"><input type="text" class="form-control" name="l_toUserName"  placeholder="收信方"></div>';
		var search_btn = '<a class="btn btn-default"  id="sub_button" href="javascript:void(0);">查询</a><a></a>';
		$("#msg_records_table_wrapper .dt-toolbar")
				.addClass("padding_B5")
				.append(l_toUserName)
				.append(search_btn);
		$("#sub_button").click(function(){
			    	var url = "/msg/getMessageRecordsPagedList?t="+new Date().getTime();
			    	var l_toUserName = $("input[name='l_toUserName']").val();
			    	var params = {"l_toUserName":l_toUserName
			    				 };
			    	url = addQueryParams(url,params);
			   	 	msg_records_table.fnSettings().sAjaxSource=url;
			   	 	msg_records_table.fnDraw(); //重新加载数据
		});
	}
	function setting(){
		loadingShow();
		$('#msg_set_dialog').load("/msg/msg-set-dialog",function(){
			msg_set_dialog = art.dialog({
				    title: '添加站点',
				    width:"850px",    // 内容宽度
	 				height: 'auto',    // 内容高度
				    content: $("#msg_set_dialog")[0],
				    padding: '0px 0px',
				    lock:true,
				    button:[{
				    	name:"保存",
				    	callback:function(){
				    		var params = '';
				    		var id = $("#frmSetting [name=id]").val();
				    		var idx = $(".sendType:checked").index(".sendType");
				    		var sendWayCheckd = $(".sendWay:checked");
				    		var state = $("#frmSetting #state .state");
				    		
				    		if(sendWayCheckd.length==0){
				    			art.dialog.tips('发送方式至少选中一项!');
				    			return false;
				    		}
				    		for(var i = 0 ; i < sendWayCheckd.length; i++){
				    			var sendWay = $(sendWayCheckd[i]).attr("sendWay");
				    			params += "sendWay="+sendWay+"&";
				    		}
				    		if(state[0].checked){
				    			state = 1;
				    		}else{
				    			state = 0;
				    		}
				    		params += "&sendType="+(idx+1);
				    		params += "&state="+state;
				    		params += "&id="+id;
				    		$.ajax({
					             type:"get",
					             url: "/msg/saveMessageSet.html",
					             dataType:"json",
					             data:params,
					             cache: false,
					             success: function(msg){
					             	if(msg.result==1){
					             		art.dialog.tips('保存成功!');
					             		return true;
					             	}else{
					             		art.dialog.tips('保存失败，服务器异常!');
					             		return false;
					             	}
					             }
					         });
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
		
			
			loadingHide();
			$(".aui_content").css("width","100%");
		});
	}
	loadScript("/resources/js/plugin/datatables/jquery.dataTables.min.js", function(){
		loadScript("/resources/js/plugin/datatables/dataTables.colVis.min.js", function(){
			loadScript("/resources/js/plugin/datatables/dataTables.tableTools.min.js", function(){
				loadScript("/resources/js/plugin/datatables/dataTables.bootstrap.min.js", pagefunction);
			});
		});
	});
</script>