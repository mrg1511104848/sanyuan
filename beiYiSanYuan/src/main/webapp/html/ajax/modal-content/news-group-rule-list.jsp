<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style>
	.dataTables_filter{display:none;}
	.ColVis{display:none;}
	
</style>

<!-- widget grid -->
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="height:100%">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" style="margin:0px;height:100%;" data-widget-editbutton="false" data-widget-colorbutton="false">

				<!-- widget div-->
				<div style="padding-top:10px;">
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body   no-padding">

						<table id="news_group_rule_list"
												class="table table-striped table-bordered table-hover smart-form"
												width="100%">
						</table>

					</div>
					<div id="dialog_edit" title="编辑文章" style=""></div>
					<div id="dialog_delete"  title="删除文章" style="text-align:center;"></div>
					<!-- end widget content -->
					<input type="hidden" id="_groupId" value="${groupId}"/>
					<input type="hidden" id="_groupName" value="${groupName}"/>
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
<script type="text/javascript" src="/resources/js/app-common.js"></script>
<script type="text/javascript">
	
	pageSetUp();
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	// pagefunction	
	var pagefunction = function() {
		$('[role="content"]').css("border","none");
		loadDataTable();
	};
	var oTable;
	function loadDataTable() {
		oTable = $("#news_group_rule_list").dataTable(
						{
							"fnInitComplete" : function(oSettings, json) {
								//isSessionInvalid(O2String(json));
							},
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
							"sDom": "<'dt-toolbar'<'tools-bar'><''>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
							"oColVis" : {
								"buttonText" : "表格列显示 / 隐藏"
							},
							"bSort" : false,
							"bPaginate" : true,
							"bProcessing" : false,
							"bServerSide" : true,
							"sAjaxSource" : "/newsGroupRule/getNewsGroupRuleList"
									+ "?timeStamp=" + new Date().getTime()+"&"
									+"eq_groupId=${groupId}",
							
							"fnServerParams":function(aoData){
								if($("#user_oprate_box").css("display")=='none'&&$("#ul_group .active").size()>0)
								{
									
									aoData.push({"name":"eq_groupId","value":$("#ul_group .active").find("a").attr("site_id")});
								}else{
									var section = $("#txtPageName").val();
									var sectionUrl = $("#txtPageUrl").val();
									aoData.push({"name":"l_section","value":section});
									aoData.push({"name":"l_sectionUrl","value":sectionUrl});
								}
							},
							"fnServerData" : function(sSource, aoData,
									fnCallback, oSettings) {
								oSettings.jqXHR = $.ajax({
									"dataType" : 'json',
									"type" : "POST",
									"url" : sSource,
									"beforeSend" : function() {
	
									},
									"complete" : function() {
	
									},
									"data" : aoData,
									"success" : fnCallback
								});
							},
							
							"aoColumns" : [
									{
										"sWidth" : "19px",
										"sTitle" : "<label class='checkbox'><input type='checkbox'  id='all_sites'><i></i></label>",
										"sClass" : "center",
										"data" : function(row, type, set) {
											var html_ = '<label class="checkbox">'
													+ '<input type="checkbox" name="pageRule" value="'+row.id+'">'
													+ '<i></i>' + '</label>';
											return html_;
										}
									},
									{
										"sWidth" : "110px",
										"sTitle" : "页面名称",
										"sClass" : "center",
										"data" : function(row, type, set) {
											return "<span title='"+row.section+"'>"
													+ cut_str(row.section, 110,
															"...") + "</span>";
										}
									},
									{
										"sTitle" : "页面URL",
										"sClass" : "center",
										"data" : function(row, type, set) {
											return "<a href='"+row.sectionUrl+"' target='_blank' title='"+row.sectionUrl+"'>"
													+ cut_str(row.sectionUrl, 45,
													"...") + "</a>";
													
										}
									},
									{
										"sWidth" : "75px",
										"sTitle" : "操作",
										"sClass" : "center",
										"data" : function(row, type, set) {
											var id = row.id;
											var isAdmin = '${currentUser.isAdmin}';
											//"<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRule(\""+id+"\")'><i class='fa fa-eye'></i></button>&nbsp&nbsp"
											if(isAdmin!=1){
											return "<button onclick='lookDataForThis(this)'  class='lookDataForThis btn btn-xs btn-default' news_group_rule_id='"+id+"' rule_id='"+row.ruleId+"' group_id='"+row.groupId+"' title='查看数据'><i class='fa fa-search'></i></button>&nbsp"
													+ "<button class='delAll btn btn-xs btn-default'  title='删除' site_id='"+ id
													+ "' onclick='deletePageRule(\""+id+"\")'><i class='fa fa-times'></i></button>";
											}else{
												return "<button onclick='lookDataForThis(this)'  class='lookDataForThis btn btn-xs btn-default' news_group_rule_id='"+id+"' rule_id='"+row.ruleId+"' group_id='"+row.groupId+"' title='查看数据'><i class='fa fa-search'></i></button>";
											}
											
										}
									} ]
						});
		var tools_html='<div class="btn-group margin_R5">'+
		'<input type="text" class="form-control" placeholder="页面名称(例如：人民网)"	id="txtPageName" style="200px;">'+
		'</div>'+
		'<div class="btn-group margin_R5">'+
		'<input type="text" class="form-control" placeholder="页面url"	id="txtPageUrl" style="200px;">'+
		'</div>'+
		'<div class="btn-group">'+
		'<button class="btn btn-default" onclick="searchResult();">查 询 </button></div><span id="span_group_id"></span>';
		var isAdmin = '${currentUser.isAdmin}';
		var buttons = '<div class="btn-group margin_L5"><button class="btn btn-primary" onclick="addPageRule()">新增</button></div>'+
		'<div class="btn-group margin_L5"><button class="btn btn-danger" onclick="deletePageRule(0)">批量删除</button></div>';
		
		$("#news_group_rule_list_wrapper .tools-bar").css("float","left").append(tools_html);	
		if(isAdmin!=1){
		$("#news_group_rule_list_wrapper .tools-bar").next().css("text-align","right").css("float","right").append(buttons);
		}	
	
		$("#all_sites").click(function() {
			if ($(this).is(':checked')) {
				$("input[name='pageRule']").each(function() {
					$(this)[0].checked = true;
				})
			} else {
				$("input[name='pageRule']").each(function() {
					$(this)[0].checked = false;
				})
			}
		});
		$("#news_group_rule_list_wrapper .dt-toolbar").css("padding-bottom","5px");
		$("#inbox-content .inbox-side-bar").css("padding","0");
	}
	// load related plugins
	loadScript(
		"/resources/js/plugin/datatables/jquery.dataTables.min.js",
		function() {
			loadScript(
					"/resources/js/plugin/datatables/dataTables.colVis.min.js",
					function() {
						loadScript(
								"/resources/js/plugin/datatables/dataTables.tableTools.min.js",
								function() {
									loadScript(
											"/resources/js/plugin/datatables/dataTables.bootstrap.min.js",
											function(){loadScript("/resources/js/plugin/superbox/superbox.js",pagefunction);}
											);
								});
					});
});


</script>
