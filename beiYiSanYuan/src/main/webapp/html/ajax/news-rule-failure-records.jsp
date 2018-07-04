<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 概览
			<span>> 错误信息 </span>
		</h1>
	</div>
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8" style="text-align:right;">
	</div>
</div>

<!-- widget grid -->
<section id="widget-grid" class="">
	
<!-- row -->
<div class="row">
	<!-- 这里错误信息表格 -->
	<article class="col-sm-12 col-md-12 col-lg-12" id="user-rule-boxs">
		<!-- Widget ID (each widget will need unique ID)-->
		<div class="jarviswidget jarviswidget-color-darken col-sm-12 col-lg-12" id="wid-id-failure-record" class="
			data-widget-editbutton="false" data-widget-colorbutton="false" style="width:100%;">
			<header>
			<span class="widget-icon"> <i class="fa fa-table"></i> </span>
			<h2>
				错误信息列表
			</h2>
	
			</header>
			<!-- widget div-->
			<div style="width:100%;">
	
				<!-- widget edit box -->
				<div class="jarviswidget-editbox">
					<!-- This area used as dropdown edit box -->
	
				</div>
				<!-- end widget edit box -->
	
				<!-- widget content -->
				<div class="widget-body no-padding">
					<table id="failure_record_list"
						class="table table-striped table-bordered table-condensed table-hover" width="100%">
						<thead style="width:100%;">
							<tr>
								<!-- <th><input type="checkbox" >测试选项</th> -->
								<th>
									主站
								</th>
								<th>
									版块
								</th>
								<th>
									失败代码
								</th>
								<th>
									失败信息
								</th>
								<th>
									插入时间
								</th>
								<th>
									渠道
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
</div>
</section>

<script type="text/javascript">
 	//初始化加载一些参数
	pageSetUp();
	var failure_record_table;
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	var pagefunction = function() {
		loadFailureRecordTable();
	}
	
	function loadFailureRecordTable(){
		failure_record_table = $("#failure_record_list").dataTable({
			"bProcessing" : true,//加载数据时候是否显示进度条
			"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/news/getFailureRecordsPagedList",//如果从服务器端加载数据,这个属性用于指定加载的路径 
			"sPaginationType" : "full_numbers",
			"bSort":false,
			"columns": [
	            {"data": function ( row, type, set ){
				        return '<a target="blank_" href="'+row.siteUrl+'">'+row.site+'</a>';
			    }},
			    {"data": function ( row, type, set ){
			        return '<a target="blank_" href="'+row.sectionUrl+'">'+row.section+'</a>';
		    	}},
		        {"data": function ( row, type, set ){
		    		return genHtmlByObject(row.code);
		        }},
		        {"data": function ( row, type, set ){
		            return genHtmlByObject(row.message);
		        }},
		        {"data": function ( row, type, set ){
		            return genHtmlByObject(row.insertTime);
		        }},
		        {"data": function ( row, type, set ){
		            return genHtmlByObject(row.channel);
		        }}
			],
			"oLanguage" : { //主要用于设置各种提示文本
				"sProcessing" : "<a href=\"javascript:void(0);\" class=\"bg-color-white txt-color-teal\"><i class=\"fa fa-gear fa-3x fa-spin\"></i></a>&nbsp;&nbsp;&nbsp;正在处理...", //设置进度条显示文本
<%--				"sLengthMenu" : "每页_MENU_行",//显示每页多少条记录--%>
				"sEmptyTable" : "没有找到记录",//没有记录时显示的文本
				"sZeroRecords" : "没有找到记录",//没有记录时显示的文本
				"sInfo" : "总数<span class='text-primary'>_TOTAL_</span>显示<span class='txt-color-darken'>_START_</span>至<span class='txt-color-darken'>_END_</span>",
				"sInfoEmpty" : "",//没记录时,关于记录数的显示文本
<%--				"sSearch" : "搜索:",//搜索框前的文本设置--%>
				"oPaginate" : {
					"sFirst" : "首页",
					"sLast" : "未页",
					"sNext" : "下页",
					"sPrevious" : "上页"
				}
			},
			"fnInitComplete": function(oSettings, json) {
				initFailureRecordTableButton();
		     },
		     "sDom": "<'dt-toolbar'<'col-xs-6 tools-bar'><'col-xs-6'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
	    });
	}	
	function initFailureRecordTableButton(){
		$("#failure_record_list_filter label").remove();
		var s_site_btn = '<input type="text" name="l_site" class="form-control ng-valid ng-dirty margin_R5" placeholder="站点名称">';
		var s_section_btn = '<input type="text" name="l_section" class="form-control ng-valid ng-dirty margin_R5" placeholder="版块名称">';
		var s_submit_btn = '<a class="btn btn-default" id="failure_record_search">查询 </a>';
		$("#failure_record_list_wrapper .tools-bar").append($(s_site_btn)).append($(s_section_btn)).append($(s_submit_btn));
		 $("#failure_record_list_wrapper .dt-toolbar").addClass("padding_B5");
		$("#failure_record_search").click(function(){
			var url = "/news/getFailureRecordsPagedList";
	    	var l_site = $("input[name='l_site']").val();
	    	var l_section = $("input[name='l_section']").val();
	    	var params = {"l_site":l_site,"l_section":l_section};
	    	url = addQueryParams(url,params);
	    	failure_record_table.fnSettings().sAjaxSource=url;
	    	failure_record_table.fnDraw(); //重新加载数据
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
	