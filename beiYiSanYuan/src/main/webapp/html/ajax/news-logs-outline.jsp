<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title  txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 新闻
			<span>> 日志大纲 </span>
		</h1>
	</div>
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8" style="text-align:right;height: 45px;line-height: 62px;">
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
				日志大纲列表
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
	
					<table id="news_logs_outline_table"
						class="table table-striped table-bordered table-hover smart-form has-tickbox" 
						width="100%">
						<thead>
							<tr>
								<th>
									开始时间
								</th>
								<th>
									结束时间
								</th>
								<th>
									策略
								</th>
								<th>
									持续时间
								</th>
								<th>
									任务数
								</th>
								<th>
									触发类型
								</th>
								<th>
									操作
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
<div id="news_logs_summary_dialog_div" style="display:none;"></div>
<script src="/resources/js/news-common.js"></script>
<script type="text/javascript">
 	//初始化加载一些参数
	pageSetUp();
	
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	var news_logs_outline_table = null;
	var news_logs_summary_dialog;
	
	// pagefunction	
	var pagefunction = function() {
		loadRuleTable();
		function loadRuleTable(){
			if(news_logs_outline_table!=null){
		        	$("#news_logs_outline_table tbody tr").remove();
		        	news_logs_outline_table.fnDestroy();
			}
			news_logs_outline_table = $("#news_logs_outline_table").dataTable({
					"bProcessing" : true,//加载数据时候是否显示进度条
					"bServerSide" : true,//是否从服务加载数据 
					"sAjaxSource" : "/news/getNewsLogsOutlinePagedList"+"?timeStamp="+new Date().getTime()+"&orderBy=startTime-desc",//如果从服务器端加载数据,这个属性用于指定加载的路径 
					"sPaginationType" : "full_numbers",
					"bSort":false,
					"columns": [
						{"sWidth" : "15%","data": function ( row, type, set ){
							return row.startTime;
				        }},
				        {"sWidth" : "15%","data": function ( row, type, set ){
							return row.endTime;
				        }},
				        {"data": function ( row, type, set ){
							return row.strategy;
				        }},
				        {"data": function ( row, type, set ){
							return row.duration;// 持续时间
				        }},
				        {"data": function ( row, type, set ){
							return row.taskCount;// 任务数
				        }},
				        {"data": function ( row, type, set ){
							return row.caller==0?"实时入库":"定时器触发";// 0实时入库 1定时器触发
				        }},
				        {"sWidth" : "4%","data": function ( row, type, set ){
				        	var htm = '<button title="日志摘要" log_outline_id="'+row.uniquelyNo+'" onclick="lookNewsLogsSummary(this)" class="lookNewsLogsSummary btn btn-xs btn-default"><i class="fa  fa-search"></i></button>';
							return htm;
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
	function lookNewsLogsSummary(ele){
		var log_outline_id = $(ele).attr("log_outline_id");
		loadingShow();
		$('#news_logs_summary_dialog_div').load("/news/news-logs-summary-dialog?id="+log_outline_id,function(){
			news_logs_summary_dialog = window.top.art.dialog({
					title: "异常日志摘要",
					content: $("#news_logs_summary_dialog_div")[0],
					width:"850px",
					padding: '0px 0px',
					lock:true
				});
			$(".aui_content").css("width","100%");
			news_logs_summary_dialog.hide();
		});
		
		/*
		这种写法有问题
		$('#news_logs_summary_dialog_div').load("news/news-logs-summary-dialog");
		news_logs_summary_dialog();
		*/
	}
	/*
	function news_logs_summary_dialog(){
		news_logs_summary_dialog = art.dialog({
				id:"news_logs_summary_dialog",
			    title: '日志摘要',
			    width: 'auto',    // 内容宽度
 				height: 'auto',    // 内容高度
			    content: $('#news_logs_summary_dialog_div')[0],
			    padding: '0px 0px',
			    lock:true,
			    button:[{
			    	name:"&nbsp; 取消",
			    	callback:function(){
			    	}
			    }],
			    init: function () {
			    	changeArtdialogButtonCss();
			    	$(".aui_content").css("width","100%");
			    	$('#news_logs_summary_dialog_div').html("");
			    }
		});
	}
	*/
	function initButtons(){
		var ipt_s_time = '<div class="btn-group margin_R5"><input type="text" class="form-control dtp" name="s_start_time"  placeholder="开始时间第一部分"></div>';
		var ipt_s_time2 = '<div class="btn-group margin_R5"><input type="text" class="form-control dtp " name="e_start_time" placeholder="开始时间第二部分"></div>';
		var ipt_s_time_all = ''+ipt_s_time+ipt_s_time2;
		
		var ipt_e_time = '<div class="btn-group margin_R5"><input type="text" class="form-control dtp" name="s_end_time"  placeholder="结束时间第一部分"></div>';
		var ipt_e_time2 = '<div class="btn-group margin_R5"><input type="text" class="form-control dtp " name="e_end_time" placeholder="结束时间第二部分"></div>';
		var ipt_e_time_all = ''+ipt_e_time+ipt_e_time2;
		var ipt_s_duration = '<div class="btn-group margin_R5"><input type="text" class="form-control " name="s_duration" placeholder="开始持续时长"></div>';
		var ipt_e_duration = '<div class="btn-group margin_R5"><input type="text" class="form-control " name="e_duration" placeholder="结束持续时长"></div>';
		var ipt_duration_all = ''+ipt_s_duration+ipt_e_duration;
		var search_btn = '<a class="btn btn-default"  id="sub_button" href="javascript:void(0);">查询</a><a></a>';
		$("#news_logs_outline_table_wrapper .dt-toolbar")
				.addClass("padding_B5")
				.append(ipt_s_time_all)
				.append(ipt_e_time_all)
				.append(ipt_duration_all)
				.append(search_btn);
		$(".dtp").datepicker();
		
		$("#sub_button").click(function(){
			    	var url = "/news/getNewsLogsOutlinePagedList?t="+new Date().getTime();
			    	var s_start_time = $("input[name='s_start_time']").val();
			    	var e_start_time = $("input[name='e_start_time']").val();
			    	var s_end_time = $("input[name='s_end_time']").val();
			    	var e_end_time = $("input[name='e_end_time']").val();
			    	
			    	var s_duration = $("input[name='s_duration']").val();
			    	var e_duration = $("input[name='e_duration']").val();
			    	var params = {"s_startTime":s_start_time,"e_startTime":e_start_time,
			    				  "s_endTime":s_end_time,"e_endTime":e_end_time,
			    				  "s_duration":s_duration,"e_duration":e_duration
			    				 };
			    	url = addQueryParams(url,params);
			   	 	news_logs_outline_table.fnSettings().sAjaxSource=url;
			   	 	news_logs_outline_table.fnDraw(); //重新加载数据
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