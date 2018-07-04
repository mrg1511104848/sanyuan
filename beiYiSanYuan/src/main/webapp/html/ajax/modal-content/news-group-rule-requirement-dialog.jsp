<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="widget-body" id="">
				<table id="dialog_news_group_rule_requirement_list_"
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
			<!-- end widget content -->
<script type="text/javascript">
var dialog_news_group_rule_requirement_list_table_;
var pagefunction=function(){
	var state = '${state}';
	newsGroupRuleRequirementList(state);
}
	//根据规则创建参数------结束----------------------------
	function newsGroupRuleRequirementList(state){
		if(dialog_news_group_rule_requirement_list_table_!=null){
        	//$("#rule_list tbody tr").remove();
        	dialog_news_group_rule_requirement_list_table_.fnDestroy();
		}
		dialog_news_group_rule_requirement_list_table_  = $("#dialog_news_group_rule_requirement_list_").dataTable({
			"bProcessing" : true,//加载数据时候是否显示进度条
			"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/newsGroupRule/getNewsGroupRuleRequirementList?eq_state="+state,//如果从服务器端加载数据,这个属性用于指定加载的路径 
			"sPaginationType" : "full_numbers",
			"bSort":false,
			"columns": [
				{"data": function ( row, type, set ){
				    return row.userName;
				}},
	          {"data": function ( row, type, set ){
				        return row.groupName;
			    }},
			    {"data": function ( row, type, set ){
			        return '<a target="blank_" href="'+row.sectionUrl+'"  title="'+row.section+'">'+cut_str(row.section, 15,"...")+'</a>';
		    	}},
		        {"data": function ( row, type, set ){
		    		return '<a target="blank_" href="'+row.sectionUrl+'" title="'+row.sectionUrl+'">'+cut_str(row.sectionUrl, 30,"...")+'</a>';
		        }},
		        {"data": function ( row, type, set ){
			        if(row.state==0){
				        return"未审核";
				    }else if(row.state==1){
				    	return"已通过";
					}else if(row.state==2){
						return"被驳回";
					}
		    		return row.state;
		        }},
		        {"data": function ( row, type, set ){
		            return row.insertTime;
		        }},
		        {"data": function ( row, type, set ){
		        	var id = row.id;
		        	var readOnly = true;
		        	if(row.state==0||row.state==2){
		        		readOnly = false;
			        }
			        //"<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRuleRequirement(\""+id+"\",true)'><i class='fa fa-eye'></i></button>&nbsp&nbsp"
		        	var adminBtns = "<button onclick='addOrEditNewsGroupRuleRequirement(\""+id+"\","+readOnly+")'  class='lookDataForThis btn btn-xs btn-default' news_group_rule_id='"+id+"' rule_id='"+row.ruleId+"' group_id='"+row.groupId+"' title='查看数据'><i class='fa fa-search'></i></button>"
					
					var notAdminBtns_pass = "<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRuleRequirement(\""+id+"\","+readOnly+")'><i class='fa fa-smile-o'></i></button>";
					var notAdminBtns_notPass = "<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRuleRequirement(\""+id+"\","+readOnly+")'><i class='fa fa-frown-o'></i></button>"
					+ "<button class='delAll btn btn-xs btn-default'  title='删除' site_id='"+ id
					+ "' onclick='deleteRequirementPageRule(\""+id+"\")'><i class='fa fa-times'></i></button>";
					if(row.state==0||row.state==2){
						return adminBtns
						+ "&nbsp;<button class='delAll btn btn-xs btn-default'  title='删除' site_id='"+ id
						+ "' onclick='deleteRequirementPageRule(\""+id+"\")'><i class='fa fa-times'></i></button>";
					}
		        	if(row.tempAdminFlag){
			        	return adminBtns;
			        }else{
				        if(row.state==1){
							return notAdminBtns_pass;
				        }else {
					        return notAdminBtns_notPass;
				        }
			        }
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
				console.log(json);
				console.log("================");
				$("#dialog_news_group_rule_requirement_list___wrapper .dt-toolbar").css("margin-bottom","5px")
				.css('padding',"0").css("border","0");
				//initNewsGroupRuleRequirementListTableButton();
		     },
		     "sDom": "<'dt-toolbar'<'col-xs-8 tools-bar'><'col-xs-4'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>"
	  });
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
													loadScript(
															"resources/js/custom-edit.js",
															function() {
																loadScript(
																		"resources/js/plugin/morris/raphael.min.js", 
																		function(){
																			loadScript(
																					"resources/js/plugin/morris/morris.min.js", 
																					pagefunction
																					);
																		});		
															});	
												});
									});
						});
			});
</script>