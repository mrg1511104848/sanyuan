<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!-- widget grid -->
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" data-widget-editbutton="false" data-widget-colorbutton="false" style="margin:0;">

				<!-- widget div-->
				<div>
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body no-padding">
						<table id="news_logs_detail_table"
						class="table table-striped table-bordered table-hover smart-form has-tickbox" 
						width="100%">
						<thead>
							<tr>
								<th>
									主站
								</th>
								<th>
								版块
								</th>
								<th>
								抓取时间
								</th>
								<th>
								页码
								</th>
								<th>
								页面类型
								</th>
								<th>
								问题编号
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
			<!-- end widget -->


		</article>
		<!-- WIDGET END -->

	</div>

	<!-- end row -->

	<!-- end row -->

</section>
<!-- end widget grid -->	
<div id="edit_logs_detail_dialog_div" style="display:none;"></div>
<script src="/resources/js/news-common.js"></script>
<script type="text/javascript"><!--
 	//初始化加载一些参数
	pageSetUp();
	
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	var news_logs_detail_table = null;
	var news_logs_detail_dialog;
	
	// pagefunction	
	var pagefunction = function() {
		loadRuleTable();
		function loadRuleTable(){
			if(news_logs_detail_table!=null){
		        	$("#news_logs_detail_table tbody tr").remove();
		        	news_logs_detail_table.fnDestroy();
			}
			news_logs_detail_table = $("#news_logs_detail_table").dataTable({
					"bProcessing" : true,//加载数据时候是否显示进度条
					"bServerSide" : true,//是否从服务加载数据 
					"sAjaxSource" : "/news/getNewsLogsDetailPagedList"+"?eq_newsLogsOutlineUniquelyNo=${id}&eq_ruleId=${ruleId}&timeStamp="+new Date().getTime(),//如果从服务器端加载数据,这个属性用于指定加载的路径 
					"sPaginationType" : "full_numbers",
					"bSort":false,
					"columns": [
						{"sWidth" : "15%","data": function ( row, type, set ){
							return "<a href='"+row.siteUrl+"'>"+row.site+"</a>";// 主站
				        }},
				        {"sWidth" : "15%","data": function ( row, type, set ){
				        	return "<a href='"+row.sectionUrl+"'>"+row.section+"</a>";// 主站
				        }},
				        {"sWidth" : "10%","data": function ( row, type, set ){
							return row.time;// 时间
				        }},
				        {"sWidth" : "10%","data": function ( row, type, set ){
							return row.pageNo;//页码
				        }},
				        {"sWidth" : "10%","data": function ( row, type, set ){
				        	if(row.pageType==1) return "列表页";
				        	if(row.pageType==2) return "正文页";
				        }},
				        {"sWidth" : "10%","data": function ( row, type, set ){
							return row.abnormityDescriptionNo;//问题编号
				        }},
				        {"sWidth" : "8%","data": function ( row, type, set ){
				        	var htm="";
				        	htm+="<button logs_detail_id='"+row.id+"' onclick='editNewsLogsDetail(this)' class='editNewsLogsDetail btn btn-xs btn-default' title='编辑' ><i class='fa fa-pencil'></i></button>";
							return htm;
				        }}
					],
					"oLanguage" : common_data_table_config.oLanguage,
					"fnInitComplete": function(oSettings, json) {
						loadingHide();
						dialogCenterScreen(news_logs_detail_dialog);
						//$('.lookNewsLogsDetail').bind('click',lookNewsLogsDetail);
						initButtons();
				     },
				     "fnDrawCallback": function( oSettings ) {
				     	
					 },
				     "sDom": "<'dt-toolbar'<'col-xs-6 tools-bar'><'col-xs-6'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
			    });
		}
	}
	function editNewsLogsDetail(ele){
		var id = $(ele).attr("logs_detail_id");
		$("#edit_logs_detail_dialog_div").load("/news/editNewsLogsDetail?id="+id,function(){
			var dialog = window.top.art.dialog({
					title: "异常日志详细细节 - 详情",
					content: $("#edit_logs_detail_dialog_div").html(),
					width:"850px",
					padding: '0px 0px',
					lock:true
			});
			$(".aui_content").css("width","100%");
		});
	}
	function initButtons(){
		var l_site = '<div class="btn-group margin_R5"><input type="text" class="form-control" name="l_site"  placeholder="主站"></div>';
		var l_section = '<div class="btn-group margin_R5"><input type="text" class="form-control" name="l_section" placeholder="版块"></div>';
		var search_btn = '<a class="btn btn-default"  id="sub_button" href="javascript:void(0);">查询</a><a></a>';
		$("#news_logs_detail_table_wrapper .dt-toolbar")
				.addClass("padding_B5")
				.append(l_site)
				.append(l_section)
				.append(search_btn);
		
		$("#sub_button").click(function(){
			    	var url = "/news/getNewsLogsDetailPagedList?eq_newsLogsOutlineUniquelyNo=${id}&eq_ruleId=${ruleId}&t="+new Date().getTime();
			    	var l_site = $("input[name='l_site']").val();
			    	var l_section = $("input[name='l_section']").val();
			    	var params = {"l_site":l_site,"l_section":l_section
			    				 };
			    	url = addQueryParams(url,params);
			   	 	news_logs_detail_table.fnSettings().sAjaxSource=url;
			   	 	news_logs_detail_table.fnDraw(); //重新加载数据
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