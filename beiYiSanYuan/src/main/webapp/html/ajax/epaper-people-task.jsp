<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- Bread crumb is created dynamically -->
<!-- row -->
<script type="text/javascript" src="/resources/js/epaper-common.js"></script>
<div class="row">
	
	<!-- col -->
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title txt-color-blueDark">
			
			<!-- PAGE HEADER -->
			<i class="fa-fw fa fa-home"></i> 
				采集任务
			<span>>  
				报刊任务管理
			</span>
		</h1>
	</div>
	<!-- end col -->
	
	<!-- right side of the page with the sparkline graphs -->
	<!-- col -->
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8">
		<!-- sparks -->
		<!-- end sparks -->
	</div>
	<!-- end col -->
	
</div>
<!-- end row -->
<!-- Widget ID (each widget will need unique ID)-->
<div class="jarviswidget" id="wid-id-7" data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-custombutton="false" data-widget-sortable="false">
				<header>
					<ul class="nav nav-tabs pull-left in">

						<li class="active">
							<a data-toggle="tab" href="#hr1"> <i class="fa fa-lg fa-arrow-circle-o-down"></i> <span class="hidden-mobile hidden-tablet">采集任务</span> </a>
						</li>

						<li>
							<a data-toggle="tab" href="#hr2"> <i class="fa fa-lg "></i> <span class="hidden-mobile hidden-tablet">审核情况 </span> </a>
						</li>
					</ul>
				</header>

				<!-- widget div-->
				<div>

					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body">

						<div class="tab-content">
							<div class="tab-pane active" id="hr1">
								<div id="inbox-content" class="row" style="min-height: 520px;padding:0 10px;">
										<div style="width: 14.5%;float:left;margin-right: 5px;" >
											<h6>
											<span style="padding-left:5px;display:inline-block;">所有任务</span>
											<a href="javascript:deleteGroup();" rel="tooltip" title="" data-placement="right"
														data-original-title="删除" class="pull-right txt-color-darken margin_LR5">
												<i class="fa fa-trash-o"></i>
											</a>
											<a href="javascript:addGroup(1);" rel="tooltip" title="" data-placement="right"
														data-original-title="修改" class="pull-right txt-color-darken margin_LR5">
												<i class="fa fa-pencil "></i>
											</a>
											<a href="javascript:addGroup(-1);" rel="tooltip" title="" 
													data-placement="right" data-original-title="添加" class="pull-right txt-color-darken margin_LR5" >
												<i class="fa fa-plus"></i>
											</a>
											
											</h6>
											<ul id="ul_group" class="inbox-menu-lg">
											</ul>
								</div>
								<div style="width:85%;float:left;" >
											<table id="site_list"
												class="table table-striped table-bordered table-hover smart-form"
												width="100%">
											</table>
								</div>
								</div>

							</div>
							<div class="tab-pane" id="hr2">
								<table id="news_group_rule_requirement_list_"
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
						</div>

					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->
			<!-- 这里是公共正文模板表格 -->
		<article class="col-sm-12 col-md-12 col-lg-8" id="epaper-public-section-rule-model-boxs" style="display:none;">
			<div class="jarviswidget jarviswidget-color-darken col-sm-12 col-lg-12" class="
				data-widget-editbutton="false" data-widget-colorbutton="false" style="width:100%;" >
				<!-- widget div-->
				<div style="width:100%;">
		
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->
		
					</div>
					<!-- end widget edit box -->
		
					<!-- widget content -->
					<div class="widget-body no-padding">
						<table id="public_section_rule_model_table"
							class="table table-striped table-bordered table-condensed" width="100%">
							<thead style="width:100%;">
								<tr>
									<th>
										自定义名称
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
		</article>
		<!-- 这里是公共正文模板表格 -->
		<article class="col-sm-12 col-md-12 col-lg-8" id="public-html-text-rule-model-boxs" style="display:none;">
			<div class="jarviswidget jarviswidget-color-darken col-sm-12 col-lg-12" class="
				data-widget-editbutton="false" data-widget-colorbutton="false" style="width:100%;" >
				<!-- widget div-->
				<div style="width:100%;">
		
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->
		
					</div>
					<!-- end widget edit box -->
		
					<!-- widget content -->
					<div class="widget-body no-padding">
						<table id="public_html_text_rule_model"
							class="table table-striped table-bordered table-condensed" width="100%">
							<thead style="width:100%;">
								<tr>
									<th>
										自定义名称
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
		</article>
		
		
		<!-- 这里是公共html列表模板表格 -->
		<article class="col-sm-12 col-md-12 col-lg-8" id="public-html-list-rule-model-boxs" style="display:none;">
			<div class="jarviswidget jarviswidget-color-darken col-sm-12 col-lg-12" class="
				data-widget-editbutton="false" data-widget-colorbutton="false" style="width:100%;" >
				<!-- widget div-->
				<div style="width:100%;">
		
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->
		
					</div>
					<!-- end widget edit box -->
		
					<!-- widget content -->
					<div class="widget-body no-padding">
						<table id="public_html_list_rule_model"
							class="table table-striped table-bordered table-condensed" width="100%">
							<thead style="width:100%;">
								<tr>
									<th>
										自定义名称
									</th>
									<!-- 
									<th>
										列表循环域
									</th>
									<th>
										列表字符集
									</th>
									<th>
										抓取页数
									</th>
									<th>
										URL
									</th>
									<th>
										标题
									</th>
									<th>
										发布时间
									</th>
									<th>
										列表下一页
									</th>
									<th>
										额外字段
									</th> 
									 -->
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
		</article>
		

</div>
<!-- end widget -->

<div id="group_dialog_div" style="display:none;"></div>
<div id="group-rule-boxs" style="display:none;"></div>
<div id="epaper-search-boxs" style="display:none;"></div>
<div id="audit-boxs" style="display:none;"></div>
<!-- end widget grid -->
<script type="text/javascript" src="/resources/js/plugin/jquery-tmpl/jquery.tmpl.min.js"></script> 
<script type="text/javascript" src="/resources/js/bootstrap/bootstrap-paginator.min.js"></script>
<script type="text/javascript">
//初始化加载一些参数
pageSetUp();
$( "#tabs" ).tabs();
//根据规则创建参数------开始----------------------------
function buildFormData(eleClass){
	if(!eleClass){
		eleClass='';
	}
	var formData = {};
	$(eleClass+" div.form-group").not(".tmp").each(function(){
		var key = $(this).attr("name");
		var elements = $(this).find("div>input");
		if(elements.length==1){
			var value0 = elements.attr("placeholder");
			if(value0=="selector"||value0=="locator"){
				value0 = "";
			}
			var value= elements.val().trim()==""?value0:elements.val().trim();
			
			if(value!=""||key=="id"){
				formData[key]=value;
			}
		}else if(elements.length>1&&elements.length<3){
			var innerFormData = {};
			elements.each(function(i){
				if(i%2==0){
					var value0 = $(this).attr("placeholder");
					if(value0=="selector"||value0=="locator"){
						value0 = "";
					}
					var thisVal = $(this).val().trim()==""?value0:$(this).val().trim();
					
					var value1 = $(elements[i+1]).attr("placeholder");
					if(value1=="selector"||value1=="locator"){
						value1 = "";
					}
					var elei1Val = $(elements[i+1]).val().trim()==""?value1:$(elements[i+1]).val().trim();
					//elei1Val = elei1Val.replace(/\s/g,'nbsp;')
					//elei1Val = elei1Val.replace(" ", "&nbsp;");
					console.log($(this));
					if(thisVal!=""&&elei1Val!=""){
						//当方括号：[] 出现在json的key中时，aaa[d[h=t]g]=vvv 这种写法的时候 会有一些小问题 右闭合部分会丢失 所以这里转义下 展示的时候 在java后端再反转义下
						innerFormData[thisVal.replace("[","@iamapresb@").replace("]","@iamarearsb@")]=elei1Val;
					}
				}
			});
			if(formData.hasOwnProperty(key)){
				var obj = formData[key];
				var props = "";
				for(var p in obj){   
				    // 方法  
				    if(typeof(obj[p])=="function"){   
				        //obj[p]();  
				    }else{   
				        // p 为属性名称，obj[p]为对应属性的值  
				        innerFormData[p+""] = obj[p];
				        //props += p + "=" + obj[p] + ";  ";  
				    }   
				}
			}
			formData[key]=innerFormData;
		}else if(elements.length>2&&elements.length<4){
			var innerFormData = {};
			
			var ele = elements[0];
			var value0 = $(ele).attr("placeholder");
			if(value0=="selector"||value0=="locator"){
				value0 = "";
			}
			var eleVal = $(ele).val().trim()==""?value0:$(ele).val().trim();
			
			var ele1 = elements[1];
			var value1 = $(ele1).attr("placeholder");
			if(value1=="selector"||value1=="locator"){
				value1 = "";
			}
			var ele1Val = $(ele1).val().trim()==""?value1:$(ele1).val().trim();
			
			var ele2 = elements[2];
			var value2 = $(ele2).attr("placeholder");
			if(value2=="selector"||value2=="locator"){
				value2 = "";
			}
			var ele2Val = $(ele2).val().trim()==""?value2:$(ele2).val().trim();
			
					if(eleVal!="" && ele1Val!=""){
						//当方括号：[] 出现在json的key中时，aaa[d[h=t]g]=vvv 这种写法的时候 会有一些小问题 右闭合部分会丢失 所以这里转义下 展示的时候 在java后端再反转义下
						var obj = {};
						obj[ele1Val.replace("[","@iamapresb@").replace("]","@iamarearsb@")]=ele2Val.replace("[","@iamapresb@").replace("]","@iamarearsb@");
						//console.log(obj);
						innerFormData[eleVal.replace("[","@iamapresb@").replace("]","@iamarearsb@")]=obj;
						//innerFormData[$(this).val().trim().replace(/\[/g,"@iamapresb@").replace(/\]/g,"@iamarearsb@")]=$(elements[i+1]).val().trim();
					}
			if(formData.hasOwnProperty(key)){
				var obj = formData[key];
				var props = "";
				for(var p in obj){   
				    // 方法  
				    if(typeof(obj[p])=="function"){   
				        //obj[p]();  
				    }else{   
				        // p 为属性名称，obj[p]为对应属性的值  
				        innerFormData[p+""] = obj[p];
				        //props += p + "=" + obj[p] + ";  ";  
				    }   
				}
			}
			formData[key]=innerFormData;
		}
	});
	console.log(formData);
	return formData;
};
//根据规则创建参数------结束----------------------------


function buildFormData2(eleClass){
		$("#audit-boxs").html("");
		$("#rule_dialog_div").html("");
		$("#site_dialog_div").html("");
		$("#public_html_list_rule_dialog_div").html("");
		$("#public_html_text_rule_dialog_div").html("");
		$("#public_html_text_rule_dialog_div").html("");
		$("#public_epaper_section_rule_dialog_div").html("");
		var listDataType = $("div[name='listDataType']").length;
		//console.log("listDataTypeLength"+listDataType);
		
		if(!eleClass){
			eleClass='';
		}
		
		var formData = {};
		var len = $(".aui_content").length;
		$(eleClass+" div.form-group").not(".tmp").each(function(){
			var key = $(this).attr("name");
			var elements = $(this).find("div>input");
			if(elements.length==1){
				var value= elements.val().trim();
				//console.log(key+"_____"+value);
				if(value!=""||key=="id"){
					formData[key]=value;
				}
			}else if(elements.length>1&&elements.length<3){
				var innerFormData = {};
				elements.each(function(i){
					if(i%2==0){
						if($(this).val().trim()!=""&&$(elements[i+1]).val().trim()!=""){
							//当方括号：[] 出现在json的key中时，aaa[d[h=t]g]=vvv 这种写法的时候 会有一些小问题 右闭合部分会丢失 所以这里转义下 展示的时候 在java后端再反转义下
							innerFormData[$(this).val().trim().replace(/\[/g,"@iamapresb@").replace(/\]/g,"@iamarearsb@")]=$(elements[i+1]).val().trim();
						}
					}
				});
				if(formData.hasOwnProperty(key)){
					var obj = formData[key];
					var props = "";
					for(var p in obj){   
					    // 方法  
					    if(typeof(obj[p])=="function"){   
					        //obj[p]();  
					    }else{   
					        // p 为属性名称，obj[p]为对应属性的值  
					        innerFormData[p+""] = obj[p];
					        //props += p + "=" + obj[p] + ";  ";  
					    }   
					}
				}
				formData[key]=innerFormData;
			}else if(elements.length>2&&elements.length<4){
				var innerFormData = {};
				var ele = elements[0];
						if($(ele).val().trim()!=""&&$(elements[1]).val().trim()!=""){
							//当方括号：[] 出现在json的key中时，aaa[d[h=t]g]=vvv 这种写法的时候 会有一些小问题 右闭合部分会丢失 所以这里转义下 展示的时候 在java后端再反转义下
							var obj = {};
							obj[$(elements[1]).val().trim().replace("[","@iamapresb@").replace("]","@iamarearsb@")]=$(elements[2]).val().trim().replace("[","@iamapresb@").replace("]","@iamarearsb@");
							//console.log(obj);
							innerFormData[$(ele).val().trim().replace("[","@iamapresb@").replace("]","@iamarearsb@")]=obj;
							//innerFormData[$(this).val().trim().replace(/\[/g,"@iamapresb@").replace(/\]/g,"@iamarearsb@")]=$(elements[i+1]).val().trim();
						}
				if(formData.hasOwnProperty(key)){
					var obj = formData[key];
					var props = "";
					for(var p in obj){   
					    // 方法  
					    if(typeof(obj[p])=="function"){   
					        //obj[p]();  
					    }else{   
					        // p 为属性名称，obj[p]为对应属性的值  
					        innerFormData[p+""] = obj[p];
					        //props += p + "=" + obj[p] + ";  ";  
					    }   
					}
				}
				formData[key]=innerFormData;
			}
		});
		return formData;
	};


	//根据规则创建参数------结束----------------------------	
function getAllGroupList(){
	$.ajax({
	   	url:"epaper/getAllGroupList.html",
	   	dataType:"json",
	   	success:function(data){
	   		var htm="";
	   		$.each(data,function(i,n){
	   			htm+="<li class='"+(i==0?"active":"")+"'><a href='javascript:;' site_id='"+n.id+"' onclick='selectGroup(\""+n.id+"\",this)'>"+n.name+"</a></li>";
	   		});
	   		$("#ul_group").html(htm);
	   	}
	});
}
function selectGroup(id,obj)
{
	$("#ul_group li").removeClass("active");
	if(id==-1)
	{
		if(site_table)
		{
			oTable.fnClearTable();
		}
	}else{
		$(obj).parent().addClass("active");
		if(oTable)
		{
//				oTable.fnSettings().aoServerParams[0].fn=function(aoData){
//					aoData.push( { "name": "eq_groupId", "value": id } );
//				}
			oTable.fnDraw();
		}
	}
}
function deleteGroup()
{
	if($("#ul_group .active").size()>0)
	{
		var id=$("#ul_group .active").find("a").attr("site_id");
		art.dialog.confirm('你确定要删除这个任务吗？', function () {
			$.ajax({
				type: "post",
			    url: "/epaper/deleteGroup?id="+id,
			    dataType:"json",
			    success: function(data){
			    	if(data.result)
	    			{
			    		art.dialog.tips('删除成功!');
	    			}else{
			    		art.dialog.tips('删除失败!');
	    			}	
			    	getAllGroupList();
			    	oTable.fnDraw(); //重新加载数据
	        	}
			});
		}, function () {
		    
		});
		changeArtdialogButtonCss();
	}else{
		art.dialog.tips('请选择至少一个组删除!',1);
	}	
}
function addGroup(t){
	var txtName="";
	var id="";
	if(t==1)
	{
		if($("#ul_group .active").size()>0)
		{
			txtName=$("#ul_group .active").find("a").text();
			id=$("#ul_group .active").find("a").attr("site_id");
		}else
		{
			art.dialog.tips('请选择至少一个任务编辑!',1);
			return;
		}
	}
	var d=art.dialog({
		title:t==-1?"新增任务":"编辑任务",
	    content: '<div id="divAddGroup"><form id="frmGroup" class="smart-form">'+
	    	'<section><label class="label">名称：</label><label class="input">'+
	    	'<input type="text" id="txtName" name="name" value="'+txtName+'"/></label>'+
	    	'<input type="hidden" name="id" id="txtId" value="'+id+'">'+
	    	'</section></form></div>',
    	lock:true,
	    button:[{
	    	name:"保存",
	    	callback:function(){
	    		if($("#txtName").val()!="")
	    		{
	    			var requestUrl="/epaper/saveGroup";
	    			if(t!=-1)
	    			{
	    				requestUrl="/epaper/editGroup";
	    			}
		    		$.ajax({
						type: "post",
					    url: "/epaper/saveGroup",
					    data: $("#frmGroup").serialize(),
					    success: function(data){
					    	d.close();
					    	if(t!=-1)
			    			{
					    		art.dialog.tips('保存成功!');
			    			}else{
					    		art.dialog.tips('保存成功!');
			    			}	
					    	getAllGroupList();
			        	}
					});
	    		}else
	    		{
	    			art.dialog.tips('名称不能为空!');
	    		}
				return false;
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
}
var pagefunction = function() {
	getAllGroupList();
	InitList();
	loadFailureRecordTable();
}

var oTable;
function InitList() {
	oTable = $("#site_list").dataTable(
					{
						"fnInitComplete" : function(oSettings, json) {
							//isSessionInvalid(O2String(json));
						},
						"oLanguage" : {
							"oPaginate" : {
								"sNext" : "下一页",
								"sPrevious" : "上一页",
								"sLast" : "尾页",
								"sFirst" : "首页"
							},
							"sEmptyTable" : "没有找到记录",
							"sLengthMenu" : "&nbsp;&nbsp;_MENU_",
						},
						"sDom": "<'dt-toolbar'<'col-xs-8 tools-bar'><'col-xs-4'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
						"oColVis" : {
							"buttonText" : "表格列显示 / 隐藏"
						},
						"bSort" : false,
						"bPaginate" : true,
						"bProcessing" : false,
						"bServerSide" : true,
						"sAjaxSource" : "/epaperGroupRule/getEpaperGroupRuleList"
								+ "?timeStamp=" + new Date().getTime(),
						"fnInfoCallback" : function(oSettings, iStart,
								iEnd, iMax, iTotal, sPre) {
							return "总共"
									+ iTotal
									+ "条 ,当前"
									+ (iTotal == 0 ? "无记录" : "(" + iStart
											+ " 到 " + iEnd + ")");
						},
						"fnServerParams":function(aoData){
							if($("#ul_group .active").size()>0)
							{
								aoData.push({"name":"eq_groupId","value":$("#ul_group .active").find("a").attr("site_id")});
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
									"sWidth" : "5%",
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
									"sWidth" : "10%",
									"sTitle" : "创建人",
									"sClass" : "center",
									"data" : function(row, type, set) {
										return row.userName;
									}
								},
								{
									"sWidth" : "20%",
									"sTitle" : "页面名称",
									"sClass" : "center",
									"data" : function(row, type, set) {
										return "<span title='"+row.paper+"'>"
												+ cut_str(row.paper, 110,
														"...") + "</span>";
									}
								},
								{
									"sWidth" : "50%",
									"sTitle" : "页面URL",
									"sClass" : "center",
									"data" : function(row, type, set) {
										return "<a href='"+row.paperUrl+"' target='_blank'>"
												+ row.paperUrl + "</a>";
									}
								},
								{
									"sWidth" : "15%",
									"sTitle" : "操作",
									"sClass" : "center",
									"data" : function(row, type, set) {
										var id = row.id;
										//"<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRule(\""+id+"\")'><i class='fa fa-eye'></i></button>&nbsp&nbsp"
										return "<button onclick='lookDataForThis(this)'  class='lookDataForThis btn btn-xs btn-default' news_group_rule_id='"+id+"' rule_id='"+row.ruleId+"' group_id='"+row.groupId+"' title='查看数据'><i class='fa fa-search'></i></button>&nbsp"
												+ "<button class='delAll btn btn-xs btn-default'  title='删除' site_id='"+ id
												+ "' onclick='deletePageRule(\""+id+"\")'><i class='fa fa-times'></i></button>";

									}
								} ]
					});
	var tools_html='<div class="btn-group margin_R5">'+
	'<input type="text" class="form-control" placeholder="例如：及时渔"	id="txtContent" style="200px;">'+
	'</div>'+
	'<div class="btn-group">'+
	'<button class="btn btn-default" onclick="searchResult();">查 询 </button></div>';

	var buttons = '<div class="btn-group margin_L5"><button class="btn btn-primary" onclick="addPageRule()">新增</button></div>'+
	'<div class="btn-group margin_L5"><button class="btn btn-danger" onclick="deletePageRule(0)">批量删除</button></div>';
	
	$(".tools-bar").append(tools_html);	
	$(".tools-bar").next().css("text-align","right").append(buttons);	

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

	$("#site_list_wrapper .dt-toolbar").css("padding","0px 0px 5px");
	$("#inbox-content .inbox-side-bar").css("padding","0");
}
function InitFilter() {
	$("#filter a").hover(function() {
		$(this).addClass("seled");
	}, function() {
		$(this).removeClass("seled");
	});
	$("#filter p a").bind("click",function(){
		$(this).parent("p").children("a").each(function() {
			$(this).removeClass("web_list_ra1");
		});
		$(this).addClass("web_list_ra1");
		
	});
}
function deletePageRule(id)
{
	var ids="";
	if(id!="0")
	{
		ids=id;
	}else{
		var ckd_len = $("input[name='pageRule']:checked").length;
		console.log(ckd_len);
		if(ckd_len==0){
			art.dialog.tips('请至少选择一条记录删除');
			return false;
		}
		var id_array=new Array();
		$("#site_list tr input[name='pageRule']").each(function() {
             if($(this).is(':checked'))
             {
             	id_array.push($(this).val());
             }
        });
        ids=id_array.join(',');
	}
	
    if($("#ul_group .active").find("a").length>0)
    {
	   	var data = {"ruleId":ids,"groupId":$("#ul_group .active").find("a").attr("site_id")};
        $.ajax( {
			type : "POST",
			dataType : 'json',
			cache : false,
			url : "/epaperGroupRule/deleteAllEpaperGroupRules",
			data:data,
			beforeSend : function() {
			},
			success : function(result) {
					if($("#site_list input[name='chkAll']").is(':checked'))
					{
						$("#site_list input[name='chkAll']").removeAttr("checked");
					}
					//oTable.fnClearTable();
					//aaaa
					oTable.fnDraw();
			},
			complete : function() {
			}
		});
    }
}
var pageIndex = 1, pageSize = 12, pageCount = 0
var container; 
var options = null;
function getRuleList(index)
{
	/*
	var query = "/epaper/getRulePagedList?timeStamp="+new Date().getTime()+
		"&iDisplayLength=" +pageSize+
		"&iDisplayStart=" + (index-1) * pageSize+
		"&eq_groupId="+$("#ul_group li.active a").attr("site_id")+
		"&l_paper="+$("#ruleName").val()+
		"&l_site="+$("#siteName").val();		
	*/			

	var query = "/epaper/getSitePagedList?timeStamp="+new Date().getTime()+
	"&iDisplayLength=" +pageSize+
	"&iDisplayStart=" + (index-1) * pageSize;
	
		
	pageIndex = index;
	$.ajax({
		dataType: "json",
		beforeSend:function(){
			loadingTip("正在加载中,请耐心等待...","#divContent");
		},
		type: "GET",
		url: query,
		success: showData
	});
}
function addOrCancelRules(ele,flag,id)
{
	if(flag){
		deleteNewsGroupRule(ele,id);
	}else{
		addNewsGroupRule(ele,id);
	}
	event.stopPropagation();
}
//这里--
function addNewsGroupRulesForSite(ele,rule_id,group_id,group_name){
	var url = "/epaperGroupRule/addEpaperGroupRules";
	$.ajax({
		url:url,
		data:{"ruleId":rule_id,groupId:group_id,groupName:group_name},
		success:function(data){
		   data = eval('('+data+')');
		   var html_ = $(ele).html();
				if(html_=="添加"){
					$(ele).html("取消");
   			}else{
   				$(ele).html("添加");
	   		}
		}
	});
}
//添加用户规则
function addNewsGroupRule(ele,rid) {
	var rule_id = rid +"";
	var group_id= $("#ul_group li.active a").attr("site_id")+"";
	var group_name=$("#ul_group li.active a").html()+"";
	addNewsGroupRulesForSite(ele,rule_id,group_id,group_name);
};

function deleteNewsGroupRule(ele,rid){
	var rule_id = rid +"";
	var group_id= $("#ul_group li.active a").attr("site_id")+"";
	var group_name=$("#ul_group li.active a").html()+"";
	deleteToUserRuleOfRule(ele,rule_id,group_id);
}
function deleteToUserRuleOfRule(ele,rule_id,group_id){
	var url = "/epaperGroupRule/deleteNewsGroupRules";
   	var data = {"ruleId":rule_id,"groupId":group_id};
   	var type = "POST";
   	$.ajax({
   		url:url,
   		data:data,
   		type:type,
   		beforeSend:function(){
			//这里是开始执行方法，显示效果
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
		},
   		success:function(data){
   			data = eval('('+data+')');
   			if(data.result){
   				//site_table.fnDraw();
   				//dialog.close();
   				var html_ = $(ele).html();
   				if(html_=="添加"){
   					$(ele).html("取消");
	   			}else{
	   				$(ele).html("添加");
		   		}
   			}
   		}
   	});
}
function saveNewsGroupRule(){
	
}
var groupRuleRequirementDialog;
function toAddEpaperGroupRuleRequirement(){
	$('#group-rule-boxs').load("/epaperGroupRule/toAddEpaperGroupRuleRequirement",function(){
		groupRuleRequirementDialog = window.top.art.dialog({
			title: "提交需求给管理员",
			content: $("#group-rule-boxs")[0],
			width:"850px",
			lock:true
		});
		$(".aui_content").css("width","100%");
	});
	$("#group-rule-boxs").html("");
}
function closeGroupRuleRequirementDialog(){
	groupRuleRequirementDialog.close();
}
function addOrEditNewsGroupRule(id){
	$('#group-rule-boxs').load("/epaperGroupRule/edit?eq_id="+id,function(){
	    var dialog = window.top.art.dialog({
			title: "详情",
			content: $("#group-rule-boxs")[0],
			width:"850px",
			lock:true
		});
		$(".aui_content").css("width","100%");
	});
	$("#group-rule-boxs").html("");
}
function lookDataForThis(ele){
	var rule_id = $(ele).attr("rule_id");
	var group_id = $(ele).attr("group_id");
	$('#epaper-search-boxs').load("/epaper/epaperArticleSearch?eq_ruleId="+rule_id,function(){
		var dialog = window.top.art.dialog({
				title: "详情",
				content: $("#epaper-search-boxs")[0],
				width:"850px",
				padding: '0px 0px',
				lock:true
			});
		$(".aui_content").css("width","100%");
	});
}
function showData(data)
{
	pageCount = Math.ceil( data.iTotalRecords/pageSize ),lists = data.aaData;
	if(pageCount>0)
	{
   	  	options = {
   	  		bootstrapMajorVersion:3,
           	currentPage:pageIndex, 
           	numberOfPages: 10, 
           	totalPages:pageCount,
           	itemTexts:function(type, page, current){
           		  switch (type) {
		            case "first":
		                return "首页";
		            case "prev":
		                return "上一页";
		            case "next":
		                return "下一页";
		            case "last":
		                return "尾页";
		            case "page":
		                return page;
		           }
           	}, 
           	tooltipTitles: function (type, page, current) {
	            switch (type) {
	            case "first":
	                return "首页";
	            case "prev":
	                return "上一页";
	            case "next":
	                return "下一页";
	            case "last":
	                return "尾页";
	            case "page":
	                return (page === current) ? "当前页 " + page : "当前页 " + page;
	            }
    		},
    		size:"small",
           	onPageClicked:null, 
           	onPageChanged:function(e, oldPage, newPage){
           		getRuleList(newPage);
           	}
        };
        container.bootstrapPaginator(options);
	}
	$("#divContent").empty();
	$('#myTemplate').tmpl(lists).appendTo('#divContent');
	$('.superbox').SuperBox();
	/*
	$("span[class$=_name_cut]").each(function(){
		var this_html = $(this).html();
		var this_html_cut = cut_str(this_html, 8,"...");
		$(this).html(this_html_cut);
	})
	*/
}

function addPageRule()
{
	var dialog = art.dialog({id: 'addPageRuleDialog',title: "新增页面规则", top: '10%',width:"70%",lock:true});
	$.ajax({
	    url: '/epaper/addPageRule',
	    complete:function(){
	    	InitFilter();
	    	container=$('#pager');
	    	getRuleList(pageIndex);
	    },
	    success: function (data) {
	        dialog.content(data);
	    },
	    cache: false
	});
	$(".aui_content").css("width","100%");
}

function searchResult(){
	var section = $("#txtContent").val();
	var groupId = $("#ul_group .active a").attr("site_id");
	var url = "/epaperGroupRule/getNewsGroupRuleList?l_section="+section+"&eq_groupId="+groupId;
	//var params = {"l_section":section,"eq_groupId":groupId};
	//addQueryParams(url,params);
	oTable.fnSettings().sAjaxSource=url;
	oTable.fnDraw(); //重新加载数据
}


// sb==============================================================this is a longer line===================================================================

var epaper_group_rule_requirement_list_table ;
//根据规则创建参数------结束----------------------------
function loadFailureRecordTable(){
	epaper_group_rule_requirement_list_table = $("#news_group_rule_requirement_list_").dataTable({
		"bProcessing" : true,//加载数据时候是否显示进度条
		"bServerSide" : true,//是否从服务加载数据 
		"sAjaxSource" : "/epaperGroupRule/getEpaperGroupRuleRequirementList",//如果从服务器端加载数据,这个属性用于指定加载的路径 
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
		        return '<a target="blank_" href="'+row.paperUrl+'">'+row.paper+'</a>';
	    	}},
	        {"data": function ( row, type, set ){
	    		return row.paperUrl;
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
	        	var adminBtns = "<button onclick='addOrEditNewsGroupRuleRequirement(\""+id+"\","+readOnly+")'  class='lookDataForThis btn btn-xs btn-default' news_group_rule_id='"+id+"' rule_id='"+row.ruleId+"' group_id='"+row.groupId+"' title='查看数据'><i class='fa fa-search'></i></button>&nbsp&nbsp"
				+ "<button class='delAll btn btn-xs btn-default'  title='删除' site_id='"+ id
				+ "' onclick='deletePageRule(\""+id+"\")'><i class='fa fa-times'></i></button>";
				var notAdminBtns_pass = "<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRuleRequirement(\""+id+"\","+readOnly+")'><i class='fa fa-smile-o'></i></button>";
				var notAdminBtns_notPass = "<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRuleRequirement(\""+id+"\","+readOnly+")'><i class='fa fa-frown-o'></i></button>";
				if(row.state==0){
					return adminBtns;
				}
	        	if(row.tempAdminFlag){
		        	return adminBtns;
		        }else{
			        if(row.state==1){
						return notAdminBtns_pass;
			        }else return notAdminBtns_notPass;
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
			console.log("================");
			$("#news_group_rule_requirement_list__wrapper .dt-toolbar").css("margin-bottom","5px");
			initFailureRecordTableButton();
	     },
	     "sDom": "<'dt-toolbar'<'col-xs-8 tools-bar'><'col-xs-4'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>"
    });
}


function initFailureRecordTableButton(){
	$("#news_group_rule_requirement_list__wrapper .dt-toolbar").css("border","none").css("padding","0px");
	var s_section = '<select  name="eq_state" class="form-control margin_R5">'+
						'<option value="">所有</option>'+
						'<option value="0">未审核</option>'+
						'<option value="1">已通过</option>'+
						'<option value="2">被驳回</option>'+
						'</select>';
	var s_site = '<input type="text" name="l_section" class="form-control ng-valid ng-dirty margin_R5" placeholder="页面名称">';
	var search_btn = '<button type="button" class="btn btn-default marginR5" onclick="searchRequirement()">查 询</button>';
	$("#news_group_rule_requirement_list__wrapper .dt-toolbar div:eq(0)").append(s_section).append(s_site).append(search_btn);
}





var newsGroupRuledialog;
function addOrEditNewsGroupRuleRequirement(id,lookOnlyFlag){
	$('#group-rule-boxs').load("/epaperGroupRule/editEpaperGroupRuleRequirement?eq_id="+id+"&lookOnly="+lookOnlyFlag,function(){
	    newsGroupRuledialog = window.top.art.dialog({
			title: "详情",
			content: $("#group-rule-boxs")[0],
			width:"850px",
			lock:true
		});
		$(".aui_content").css("width","100%");
	});
	$("#group-rule-boxs").html("");
}
function closeDialog(){
	newsGroupRuledialog.close();
}
function searchRequirement(){
	var url = "/epaperGroupRule/getNewsGroupRuleRequirementList";
	var eq_state = $("select[name='eq_state']").val();
	var l_section = $("input[name='l_section']").val();
	var params = {"eq_state":eq_state,"l_section":l_section};
	url = addQueryParams(url,params);
	epaper_group_rule_requirement_list_table.fnSettings().sAjaxSource=url;
	epaper_group_rule_requirement_list_table.fnDraw(); //重新加载数据
	
}
function startAudit(){
	$('#audit-boxs').load("/epaperGroupRule/startAudit",function(){
		loadRuleDialog();
		$(".my_datepicker").datepicker({ dateFormat: 'yy-mm-dd' });
	});
}

function loadRuleDialog(type){//1 : edit ,2 : add
		//console.log($("#rule_dialog_div").html());
		var paper = $("#group-rule-boxs div[name='paper'] input").val();
		var paperUrl = $("#group-rule-boxs div[name='paperUrl'] input").val();
		$("#leftEditBox div[name='paper'] input").val(paper);
		$("#leftEditBox div[name='paperUrl'] input").val(paperUrl);

		
		var left = 541/2+"px";
		var top = 570/2+"px";
		var screen_width = $(document).width();
		$(".fatch_processing").css({"position":"absolute","top":top,"left":left});
		var dialog = art.dialog({
					id:"audit-boxs",
				    title: '欢迎',
				    width: screen_width,    // 内容宽度
	 				height: 'auto',    // 内容高度
				    content: $("#audit-boxs")[0],
				    padding: '0px 0px',
				    lock:true,
				    button:[{
				    	name:"测试历史报刊",
				    	callback:function(){
				    		testHistoricalData();
				    		//MessageBoxShow('入库成功!');
				    		return false;
				    	}
				    },{
				    	name:'测试',
				    	callback:function(){
				    		getSectionPageInfo();
							return false;
						}
				    },{
				    	name:'审核通过',
				    	callback:function(){
				    		//updateToRule();
				    		auditPass();
							return false;
				    	}
				    }],
				    init: function () {
				    	changeArtdialogButtonCss();
				    }
			});
		
		if(type&&type==2){
			$(".aui_buttons button:eq(4)").hide();
		}
		$(".aui_content").css("width","100%");
	}
/*
function loadRuleDialog(){
	//console.log($("#rule_dialog_div").html());
		var left = 541/2+"px";
		var top = 570/2+"px";
		var screen_width = $(document).width();
		$(".fatch_processing").css({"position":"absolute","top":top,"left":left});
		var dialog = art.dialog({
					id:"rule_dialog",
				    title: '欢迎',
				    width: screen_width,    // 内容宽度
	 				height: 'auto',    // 内容高度
				    content: $("#audit-boxs").html(),
				    padding: '0px 0px',
				    lock:true,
				    button:[{
				    	name:"<i class='fa  fa-play'></i>&nbsp; 审核通过",
				    	callback:function(){
				    		auditPass();
				    		return false;
				    	}
				    },{
				    	name:'测试',
				    	callback:function(){
							getListPageInfo();
							return false;
						}
				    }]
			});
		$(".aui_content").css("width","100%");
}
*/
/**
** 获取根据规则进行过滤的列表
*/
function getSectionPageInfo(){
	var url = "/epaper/getSectionPageInfo";
	$.ajax({
		url:url,
		type:'POST',
		data:buildFormData(),
		beforeSend:function(){
			//这里是开始执行方法，显示效果
			$("#rule_list_fieldset").hide();
			$(".fatch_processing").show();
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
			$(".fatch_processing").hide();
			$("#rule_list_fieldset").show();
		},
		success:function(data){
			data=eval("("+data+")");//转换为json对象
			var nodata = "无";
			var strs = "";
		    for(var i = 0 ; i < data.length;i++){
		    	var id = data[i].id;
		    	var section = data[i].section?data[i].section:nodata;
		    	var sectionUrl = data[i].sectionUrl;
		    	var section_short_url = "";
		    	var time = data[i].time?data[i].time:nodata;
		    	var additionalAttribute = data[i].additionalAttribute?data[i].additionalAttribute:nodata;
		    	var additionalAttributeStr = "";
		    	if(sectionUrl){
			    	if(sectionUrl.length>80){
			    		section_short_url = sectionUrl.substring(0,80)+"...";
				    }else{
				    	section_short_url = sectionUrl;
					}
			    }
		    	if(additionalAttribute){
		    		additionalAttributeStr = obj2str(additionalAttribute); 
		    	}
		    	if(id){
		    		var page = id.split(":")[1];
		    		strs+='<div style="font-size: 31px;text-align: center;">第'+page+'页</div>'+
		    			  ' <legend></legend>';
		    	}else{
		    		strs+='  <div><b>标题</b>:<a target="blank_" href='+sectionUrl+'>'+section+'</a></div>'+
					    ' <div style="width:100%;"><b>URL</b>:<span title="'+sectionUrl+'">'+section_short_url+'</span></div>'+
					    ' <div><b>时间</b>:'+time+'</div>'+
					    ' <div><b>版块列表页额外字段</b>:'+additionalAttributeStr+'</div>'+
					    ' <div class="fetch-result">'+
					    ' 	<a class="btn btn-primary btn-xs" to-url="'+sectionUrl+'" href="javascript:void(0);" onclick="testListPageInfo(this)" style="display: block;width: 127px;margin:10px 0;"><i class="fa fa-play fa-1x"></i>测试报刊列表</a>'+
					    ' 	<span class="test-content-progress" style="display:none;">'+
						'     	<a href="javascript:void(0);" class="bg-color-white txt-color-teal test_content" ><i class="fa fa-gear fa-2x fa-spin"></i>'+
						'		</a>&nbsp;&nbsp;&nbsp;正在处理...'+
						'	</span>'+
						'	<div class="fetch-list" style="display:none;">'+
						'	</div>'+
						'	<div class="fetch-content" style="display:none;">'+
						'	</div>'+
					    ' </div>'+
					    ' <legend></legend>';
		    	}
		    	
		    }
		    //console.log(strs);
		    $("#rule_list_fieldset div:eq(0)").html(strs);
		}
	})
}

var public_html_list_rule_model_table = null;
var public_html_text_rule_model_table = null;
var public_section_rule_model_table = null;
function loadPublicHtmlListRuleModel(){
	commonLoadPublicHtmlListRuleModelTable(false,true);
}
function loadPublicHtmlListRuleModelOnlySelect(){
	commonLoadPublicHtmlListRuleModelTable(true);
}

function loadPublicHtmlTextRuleModel(){	
	commonLoadPublicHtmlTextRuleModelTable(false,true);
}
function loadPublicHtmlTextRuleModelOnlySelect(){	
	commonLoadPublicHtmlTextRuleModelTable(true);
}

function loadEpaperPublicSectionRuleModel(){	
	commonLoadEpaperPublicSectionRuleModelTable();
}
function loadEpaperPublicSectionRuleModelOnlySelect(){	
	commonLoadEpaperPublicSectionRuleModelTable(true);
}
function commonLoadEpaperPublicSectionRuleModelTable(isCopyOrExtends){//isSelect:是否是将要 复制或者继承
	if(public_section_rule_model_table!=null){
        	//$("#rule_list tbody tr").remove();
        public_section_rule_model_table.fnDestroy();
	}
	
	var paperUrl = $("div[name='paperUrl'] input").val();
	//公共正文模板
    public_section_rule_model_table = $("#public_section_rule_model_table").dataTable({
		"bProcessing" : true,//加载数据时候是否显示进度条
		"sAjaxSource" : "/epaper/epaperPublicSectionRules", 
		"fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {
	        var aoData = {"paperUrl":paperUrl };      
	        oSettings.jqXHR = $.ajax( {
	            "dataType": 'json',
	            "type": "POST",
	            "url": sSource,
	            "data": aoData,
	            "success": function(data){
	            	//uuu
	            	if(data.iTotalRecords==0){
		            	$("#public_section_rule_model_table_processing").hide();
		            }else{
		            	fnCallback(data);
			            }
	        		
	           	}
	        } );
	    }, 
		"sPaginationType" : "full_numbers",
		"columns": [
            {"data": function ( row, type, set ){
            	return genHtmlByObject(row.name);
			}},
            {"data": function ( row, type, set ){
            	if(isCopyOrExtends){
            		return "<button class='btn btn-xs btn-default' public_section_rule_id='"+row.id+"' title='点击复制'   onclick='copyEpaperPublicSectionRuleModel(this)'><i class='glyphicon glyphicon-book'></i></button>&nbsp&nbsp"+
	            				"<button class='btn btn-xs btn-default' public_section_rule_id='"+row.id+"' text_model_name='"+row.name+"' title='点击继承'  onclick='extendsEpaperPublicSectionRuleModel(this)'><i class='glyphicon glyphicon-flag'></i></button>&nbsp&nbsp";
            	}else{
            		return "<button class='btn btn-xs btn-default' public_section_rule_id='"+row.id+"' title='编辑'  onclick=\"editEpaperPublicSectionRuleModel(this,'html')\"><i class='fa fa-pencil'></i></button>&nbsp&nbsp"+
			        	   "<button class='btn btn-xs btn-default'  title='删除' public_section_rule_id='"+row.id+"' onclick=\"delEpaperPublicSectionRuleModel(this,'html')\"><i class='fa fa-times'></i></button>";
            	}
		    }}
		],
		"oLanguage" : common_data_table_config.oLanguage,

		"fnInitComplete": function(oSettings, json) {
			if(!isCopyOrExtends){
				var button_html = '	<a class="btn btn-primary" id="add_public_html_text_rule_model" onclick=\'toAddEpaperPublicSectionRule("epaper")\' style="float:right;" href="javascript:void(0);">添加版块模板</a>&nbsp;&nbsp;';
				$("#public_section_rule_model_table_wrapper .dt-toolbar>div:eq(1)").append($(button_html)).css("padding-right","0px");
			}
		},
		"sDom":common_data_table_config.sDom
    });
}


function deleteRow(ele){
	$(ele).parent().parent().remove();
}
function showOther(ele){
	$(ele).parent().next().show();
}

/**
复制正文模板
*/
function copyEpaperPublicSectionRuleModel(ele){
var publicSectionRuleId = $(".aui_content #mainFrm div[name='publicSectionRuleId'] input").val();
console.log("8:51----------------------log----------------"+publicSectionRuleId);
if(publicSectionRuleId){
	var extends_html = $(".aui_content #mainFrm a.extends_flag:eq(1)").attr("flag_title");
	var dialog = art.dialog({
		title: '取消继承确认',
		width: 'auto',    // 内容宽度
			height: 'auto',    // 内容高度
		content: "<div>您当前"+extends_html+"，您确认要取消继承吗?</div>",
		padding: '0px 0px',
		lock:true,
		button:[{
			  name:"<i class='fa  fa-play'></i>&nbsp; 保存",
			  callback:function(){
			  	$(".aui_content #mainFrm div[name='publicSectionRuleId'] input").val("");
			  	$(".aui_content #mainFrm a.extends_flag:eq(1)").attr("title","当前无继承模板");
			  	$(".aui_content #mainFrm a.extends_flag:eq(1)").attr("flag_title","当前无继承模板");
				$(".aui_content #mainFrm a.extends_flag:eq(1)").css("color","#ccc").css("text-decoration","none");
			  	startToCopyEpaperPublicSectionRuleModel(ele);
			  	//var r = updateToRule();
			  	//if(r){
			  		MessageBoxShow('复制成功!',true);
			  //	}
				//return false;
			  }
		  },{
		    name:'取消',
		    callback:function(){
		  	}
		  }],
		    init: function () {
		    	changeArtdialogButtonCss();
		    }
	});
}else{
	startToCopyEpaperPublicSectionRuleModel(ele);
	MessageBoxShow('复制成功!',true);
}

}

/**
开始复制正文模板
*/
function startToCopyEpaperPublicSectionRuleModel(ele){
var public_section_rule_id = $(ele).attr("public_section_rule_id");
var url = "/epaper/editEpaperPublicSectionRule.html";
$.ajax({
	url:url,
	type:'POST',
	data:{"id":public_section_rule_id},
	beforeSend:function(){
		//这里是开始执行方法，显示效果
	},
	complete:function(){
		//方法执行完毕，效果自己可以关闭，或者隐藏效果
	},
	success:function(data){
		commonCopyEpaperPublicSectionRuleModel(data);
	}
});
MessageBoxShow('复制成功!',true);
return false;
}
/**
** 继承正文模板
*/
function extendsEpaperPublicSectionRuleModel(ele){
var id = $("div[name='id'] input").attr("value");
//if(!id) {MessageBoxShow('请保存后再继承，或直接使用复制!');return false;}
var public_section_rule_id = $(ele).attr("public_section_rule_id");
var text_model_name = $(ele).attr("text_model_name");
$("#mainFrm div[name='publicSectionRuleId'] input").val(public_section_rule_id);
//var r = updateToRule();
//if(r){
	$("#mainFrm a.extends_flag:eq(0)").attr("title","继承模板【"+text_model_name+"】,点击取消继承");
	$("#mainFrm a.extends_flag:eq(0)").attr("flag_title","继承模板【"+text_model_name+"】");
	$("#mainFrm a.extends_flag:eq(0)").css("color","#3276b1").css("text-decoration","none");
	MessageBoxShow('继承成功!请记得保存哦');
//}
var url = "/epaper/editEpaperPublicSectionRule.html";
$.ajax({
	url:url,
	type:'POST',
	data:{"id":public_section_rule_id},
	beforeSend:function(){
		//这里是开始执行方法，显示效果
	},
	complete:function(){
		//方法执行完毕，效果自己可以关闭，或者隐藏效果
	},
	success:function(data){
		console.log("over");
		console.log("11:54"+data);
		commonCopyEpaperPublicSectionRuleModel(data,"extends");
	}
});
}

function commonCopyEpaperPublicSectionRuleModel(data,type){
	data = 	eval('('+data+')');
			commonCopyPublicRuleModel(data,type);
			var sectionAdditionalParserMapKeys = getKey(data.sectionAdditionalParserMap);
			var sectionAdditionalParserMapValues = getValue(data.sectionAdditionalParserMap);
			console.log(sectionAdditionalParserMapKeys);
			$(".sectionAdditionalParserMap").remove();
			/*
			if(textAdditionalParserMapKeys.length>1){
				$(".textAdditionalParserMap").remove();
			}else{
				$(".textAdditionalParserMap:gt(0)").remove();
				$(".textAdditionalParserMap:eq(0) input").val("");
				$(".textAdditionalParserMap:eq(0)").hide();
			}
			*/
			//$(".textAdditionalParserMap").remove();
			for(var i = 0 ; i < sectionAdditionalParserMapKeys.length; i++){
				console.log("当前----->"+sectionAdditionalParserMapKeys[i]);
					var str = ' <div class="form-group sectionAdditionalParserMap" name="sectionAdditionalParserMap">	'+
					 ' <label class="control-label col-md-2">	';
					 var addStr = '<a href="javascript:;" class="btn btn-primary btn-circle" onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>';
					 var minusStr = '<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>';
					 var minusOrAddStr = '';
					 if(i<1){
					 	str+="其他";
					 	minusOrAddStr=addStr;
					 }else{
					 	minusOrAddStr=minusStr;
					 }
					 if(type=="extends"){
						 str+=' </label>	'+
						 ' <div class="col-md-2">	'+
						 ' 	<input class="form-control" placeholder="" type="text" value="">	'+
						 ' </div>	'+
						 ' 	<div class="col-md-3">	'+
						 ' 		<input class="form-control" placeholder="" type="text" value="">	'+
						 ' 	</div>	'+
						 ' 	<div class="col-md-3">	'+
						 ' 		<input class="form-control" placeholder="" type="text" value="">	'+
						 ' 	</div>	'+
						 ' 	<div class="col-md-2">	'+
						 minusOrAddStr+
						 ' 	</div>	'+
						 ' </div>	';
					 }else{
					 	str+=' </label>	'+
						 ' <div class="col-md-2">	'+
						 ' 	<input class="form-control" placeholder="selector" type="text" value="">	'+
						 ' </div>	'+
						 ' 	<div class="col-md-3">	'+
						 ' 		<input class="form-control" placeholder="locator" type="text" value="">	'+
						 ' 	</div>	'+
						 ' 	<div class="col-md-3">	'+
						 ' 		<input class="form-control" placeholder="locator" type="text" value="">	'+
						 ' 	</div>	'+
						 
						 ' 	<div class="col-md-2">	'+
						 minusOrAddStr+
						 ' 	</div>	'+
						 ' </div>	';
					 }
					 if(i<1){
					 	$("div.other:eq(0)").after($(str));
					 }else{
					 	$(".sectionAdditionalParserMap:last").after($(str));
					 }
					 if(type=="extends"){
						 $(".sectionAdditionalParserMap:last").find("input:eq(0)").attr("placeholder",sectionAdditionalParserMapKeys[i]+"");
						 $(".sectionAdditionalParserMap:last").find("input:eq(1)").attr("placeholder",getKey(sectionAdditionalParserMapValues[i]));
						 $(".sectionAdditionalParserMap:last").find("input:eq(2)").attr("placeholder",getValue(sectionAdditionalParserMapValues[i]));
					 }else{
						 $(".sectionAdditionalParserMap:last").find("input:eq(0)").val(sectionAdditionalParserMapKeys[i]+"");
						 $(".sectionAdditionalParserMap:last").find("input:eq(1)").val(getKey(sectionAdditionalParserMapValues[i]));
						 $(".sectionAdditionalParserMap:last").find("input:eq(2)").val(getValue(sectionAdditionalParserMapValues[i]));
					 }
			}
}
function commonCopyPublicRuleModel(data,type){
	var mainFrm = $("#mainFrm");
			for(var key in data){
				console.log("---------------------"+key);
					if(typeof(data[key])=="object"){
						if(key!="textAdditionalParserMap"&&key!="listAdditionalParserMap"&&key!="sectionAdditionalParserMap"){
							//console.log("--------start-----"+key+"-----------");
							$(".tem_copy_flag").removeClass("tem_copy_flag");
							//console.log(data[key]);
							var tem_dataKey = data[key];
							var keys = getKey(data[key]);
							//console.log("hehehe"+tem_dataKey);
								var values = getValue(tem_dataKey);
								for(var i = 0 ; i < keys.length; i++){
									console.log("this----->  key="+keys[i]+"   value="+values[i]);
									var old = mainFrm.find("div[name='"+key+"']:first");
									var copyd = old.clone();
									copyd.find("input:eq(0)").attr("placeholder","");
									copyd.find("input:eq(1)").attr("placeholder","");
									if(type=="extends"){
										copyd.find("input:eq(0)").attr("placeholder",keys[i]);
										copyd.find("input:eq(1)").attr("placeholder",values[i]);
										copyd.find("input:eq(0)").val("");
										copyd.find("input:eq(1)").val("");
									}else{
										copyd.find("input:eq(0)").val(keys[i]);
										copyd.find("input:eq(1)").val(values[i]);
									}
									
									if(i==0){
										old.after(copyd);
									}else{
										mainFrm.find("div[name='"+key+"']:last").after(copyd);
										copyd.find("label:first").empty();
									}
									copyd.addClass("tem_copy_flag");
								}
								
								if(keys.length>0){
									$("div[name='"+key+"']").not(".tem_copy_flag").remove();
								}else{
									$("div[name='"+key+"']:gt(0)").remove();
									$("div[name='"+key+"'] input").val("");
								}
							//console.log("--------end----------------");
						}
					}else if(((typeof(data[key])=="string"||typeof(data[key])=="number"))&&mainFrm.find("div[name='"+key+"']").css("display")!="none"){
						//console.log("-----str---start----------------");
						if(key!="id"){
							mainFrm.find("div[name='"+key+"'] input:eq(0)").attr("placeholder","");
							if(type=="extends"){
								mainFrm.find("div[name='"+key+"'] input:eq(0)").attr("placeholder",data[key]);
								mainFrm.find("div[name='"+key+"'] input:eq(0)").val("");
							}else{
								console.log("qqqqqqqqq"+"div[name='"+key+"'] input:eq(0)");
								mainFrm.find("div[name='"+key+"'] input:eq(0)").val(data[key]);
							}
							
						}
						//console.log("-----str---end----------------");
					}
				}
}
function commonLoadPublicHtmlListRuleModelTable(isCopyOrExtends,isAll){//isSelect:是否是将要 复制或者继承
	if(public_html_list_rule_model_table!=null){
        	//$("#rule_list tbody tr").remove();
        	public_html_list_rule_model_table.fnDestroy();
	}
	var paperUrl = $("div[name='paperUrl'] input").val();
	var everySectionSelector = $("div[name='everySectionSelector'] input").val();
	public_html_list_rule_model_table = $("#public_html_list_rule_model").dataTable({
			"bProcessing" : true,//加载数据时候是否显示进度条
			//"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/epaper/epaperPublicRankListRules",//如果从服务器端加载数据,这个属性用于指定加载的路径
			"fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {

		        var aoData = buildFormData();
		        if(isAll) aoData['isAll'] = isAll;
		        
		        oSettings.jqXHR = $.ajax( {
		            "dataType": 'json',
		            "type": "POST",
		            "url": sSource,
		            "data": aoData,
		            "success": function(data){
		            	//uuu
		            	if(data.iTotalRecords==0){
			            	$("#public_html_list_rule_model_processing").hide();
			            }else{
		            	fnCallback(data);
			            }
		        		
		           	}
		        } );
		    }, 
			"sPaginationType" : "full_numbers",
			"columns": [
	            {"data": function ( row, type, set ){
	            	return genHtmlByObject(row.name);
			    }},
			   /*
	            {"data": function ( row, type, set ){
	            	return genHtmlByObject(row.everyArticleSelector);
			    }},
	            {"data": function ( row, type, set ){
	            	return genHtmlByObject(row.listCharset);
			    }},
	            {"data": function ( row, type, set ){
	            	return genHtmlByObject(row.page);
			    }},
	            {"data": function ( row, type, set ){
	            	return genHtmlByObject(row.listUrlParserMap);
			    }},
	            {"data": function ( row, type, set ){
	            	return genHtmlByObject(row.listTitleParserMap);
			    }},
	            {"data": function ( row, type, set ){
	            	return genHtmlByObject(row.listTimeParserMap);
			    }},
	            {"data":  function ( row, type, set ){
	            	return genHtmlByObject(row.listNextPageParserMap);
			    }},
	            {"data":   function ( row, type, set ){
	            	return genHtmlByObject(row.listAdditionalParserMap,2);
			    }},
			    */
	            {"data": function ( row, type, set ){
	            	if(isCopyOrExtends){//yes
	            		return "<button class='btn btn-xs btn-default' list_model_id='"+row.id+"' title='点击复制'   onclick='copyPublicListRuleModel(this)'><i class='glyphicon glyphicon-book'></i></button>&nbsp&nbsp"+
	            				"<button class='btn btn-xs btn-default' list_model_id='"+row.id+"' list_model_name='"+row.name+"' title='点击继承'  onclick='extendsPublicListRuleModel(this)'><i class='glyphicon glyphicon-flag'></i></button>&nbsp&nbsp";
	            	}else{
	            		return "<button class='btn btn-xs btn-default' list_model_id='"+row.id+"' title='编辑'  onclick=\"editPublicListRuleModel(this,'html')\"><i class='fa fa-pencil'></i></button>&nbsp&nbsp"+
				        	   "<button class='btn btn-xs btn-default'  title='删除' list_model_id='"+row.id+"' onclick=\"delPublicListRuleModel(this,'html')\"><i class='fa fa-times'></i></button>";
	            	}
			    }}
			],
			"oLanguage" : common_data_table_config.oLanguage,
			"fnInitComplete": function(oSettings, json) {
				if(!isCopyOrExtends){
					var button_html = '	<a class="btn btn-primary" id="add_public_html_list_rule_model" onclick=\'toAddPublicListRuleModel("html")\' style="float:right;" href="javascript:void(0);">添加公共列表模板</a>&nbsp;&nbsp;';
		    		$("#public_html_list_rule_model_wrapper .dt-toolbar>div:eq(1)").append($(button_html)).css("padding-right","0px");
				}
		     },
		     "sDom":common_data_table_config.sDom
	    });
}

/**
复制列表模板
*/
function copyPublicListRuleModel(ele){
var publicListRuleId = $(".aui_content #mainFrm div[name='publicListRuleId'] input").val();

if(publicListRuleId){
	var extends_html = $(".aui_content #mainFrm a.extends_flag:eq(0)").attr("flag_title");
	var dialog = art.dialog({
		title: '取消继承确认',
		width: 'auto',    // 内容宽度
			height: 'auto',    // 内容高度
		content: "<div>您当前"+extends_html+"，您确认要取消继承吗?</div>",
		padding: '0px 0px',
		lock:true,
		button:[{
			  name:"<i class='fa  fa-play'></i>&nbsp; 保存",
			  callback:function(){
			  	$(".aui_content #mainFrm div[name='publicListRuleId'] input").val("");
			  	$(".aui_content #mainFrm a.extends_flag:eq(0)").attr("title","当前无继承模板");
			  	$(".aui_content #mainFrm a.extends_flag:eq(0)").attr("flag_title","当前无继承模板");
				$(".aui_content #mainFrm a.extends_flag:eq(0)").css("color","#ccc").css("text-decoration","none");
			  	startToCopyPublicListRuleModel(ele);
			  	//var r = updateToRule();
			  	//if(r){
			  		MessageBoxShow('复制成功!',true);
			  		
			  	//}
			  }
		  },{
		    name:'取消',
		    callback:function(){
		  	}
		  }],
		    init: function () {
		    	changeArtdialogButtonCss();
		    }
	});
}else{
	startToCopyPublicListRuleModel(ele);
	MessageBoxShow('复制成功!',true);
}

}
function startToCopyPublicListRuleModel(ele){
var list_model_id = $(ele).attr("list_model_id");
	var url = "/epaper/editEpaperPublicListRule.html";
	$.ajax({
		url:url,
		type:'POST',
		data:{"id":list_model_id},
		beforeSend:function(){
			//这里是开始执行方法，显示效果
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
		},
		success:function(data){
			commonCopyPublicListRuleModel(data);
		}
	});
}
function commonLoadPublicHtmlTextRuleModelTable(isCopyOrExtends,isAll){//isSelect:是否是将要 复制或者继承
	if(public_html_text_rule_model_table!=null){
        	//$("#rule_list tbody tr").remove();
        public_html_text_rule_model_table.fnDestroy();
	}
	/*
	var sectionUrl = $("div[name='sectionUrl'] input").val();
	var everyArticleSelector = $("div[name='everyArticleSelector'] input").val();
	var listUrlParserMapKey = $("div[name='listUrlParserMap'] input:eq(0)").val();
	var listUrlParserMapValue = $("div[name='listUrlParserMap'] input:eq(1)").val();
	var tmpListUrlParserMapKey = "listUrlParserMap["+listUrlParserMapKey+"]";
	*/
	//公共正文模板
    public_html_text_rule_model_table = $("#public_html_text_rule_model").dataTable({
		"bProcessing" : true,//加载数据时候是否显示进度条
		//"bServerSide" : true,//是否从服务加载数据 
		"sAjaxSource" : "/epaper/epaperPublicRankTextRules",//如果从服务器端加载数据,这个属性用于指定加载的路径 
		"bSort":false,
		"fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {
	        var aoData = buildFormData();     
	        if(isAll) aoData['isAll'] = isAll; 
	        oSettings.jqXHR = $.ajax( {
	            "dataType": 'json',
	            "type": "POST",
	            "url": sSource,
	            "data": aoData,
	            "success": function(data){
	            	//uuu
	            	if(data.iTotalRecords==0){
		            	$("#public_html_text_rule_model_processing").hide();
		            }else{
		            	fnCallback(data);
		            }
	           	},
	            "error":function(data){
	           		$("#public_html_text_rule_model_processing").hide();
		        }
	        } );
	    }, 
		"sPaginationType" : "full_numbers",
		"columns": [
            {"data": function ( row, type, set ){
            	return genHtmlByObject(row.name);
			}},
            {"data": function ( row, type, set ){
            	if(isCopyOrExtends){
            		return "<button class='btn btn-xs btn-default' text_model_id='"+row.id+"' title='点击复制'   onclick='copyPublicTextRuleModel(this)'><i class='glyphicon glyphicon-book'></i></button>&nbsp&nbsp"+
	            				"<button class='btn btn-xs btn-default' text_model_id='"+row.id+"' text_model_name='"+row.name+"' title='点击继承'  onclick='extendsPublicTextRuleModel(this)'><i class='glyphicon glyphicon-flag'></i></button>&nbsp&nbsp";
            	}else{
            		return "<button class='btn btn-xs btn-default' text_model_id='"+row.id+"' title='编辑'  onclick=\"editPublicTextRuleModel(this,'html')\"><i class='fa fa-pencil'></i></button>&nbsp&nbsp"+
			        	   "<button class='btn btn-xs btn-default'  title='删除' text_model_id='"+row.id+"' onclick=\"delPublicTextRuleModel(this,'html')\"><i class='fa fa-times'></i></button>";
            	}
		    }}
		],
		"oLanguage" : common_data_table_config.oLanguage,

		"fnInitComplete": function(oSettings, json) {
			if(!isCopyOrExtends){
				var button_html = '	<a class="btn btn-primary" id="add_public_html_text_rule_model" onclick=\'toAddPublicTextRuleModel("html")\' style="float:right;" href="javascript:void(0);">添加公共正文模板</a>&nbsp;&nbsp;';
				$("#public_html_text_rule_model_wrapper .dt-toolbar>div:eq(1)").append($(button_html)).css("padding-right","0px");
			}
		},
		"sDom":common_data_table_config.sDom
    });
}

/**
复制正文模板
*/
function copyPublicTextRuleModel(ele){
var publicTextRuleId = $(".aui_content #mainFrm div[name='publicTextRuleId'] input").val();
console.log("8:51----------------------log----------------"+publicTextRuleId);
if(publicTextRuleId){
	var extends_html = $(".aui_content #mainFrm a.extends_flag:eq(2)").attr("flag_title");
	var dialog = art.dialog({
		title: '取消继承确认',
		width: 'auto',    // 内容宽度
			height: 'auto',    // 内容高度
		content: "<div>您当前"+extends_html+"，您确认要取消继承吗?</div>",
		padding: '0px 0px',
		lock:true,
		button:[{
			  name:"<i class='fa  fa-play'></i>&nbsp; 保存",
			  callback:function(){
			  	$(".aui_content #mainFrm div[name='publicTextRuleId'] input").val("");
			  	$(".aui_content #mainFrm a.extends_flag:eq(1)").attr("title","当前无继承模板");
			  	$(".aui_content #mainFrm a.extends_flag:eq(1)").attr("flag_title","当前无继承模板");
				$(".aui_content #mainFrm a.extends_flag:eq(1)").css("color","#ccc").css("text-decoration","none");
			  	startToCopyPublicTextRuleModel(ele);
			  	//var r = updateToRule();
			  	//if(r){
			  		MessageBoxShow('复制成功!',true);
			  //	}
				//return false;
			  }
		  },{
		    name:'取消',
		    callback:function(){
		  	}
		  }],
		    init: function () {
		    	changeArtdialogButtonCss();
		    }
	});
}else{
	startToCopyPublicTextRuleModel(ele);
	MessageBoxShow('复制成功!',true);
}

}

/**
开始复制正文模板
*/
function startToCopyPublicTextRuleModel(ele){
var text_model_id = $(ele).attr("text_model_id");
var url = "/epaper/editEpaperPublicTextRule.html";
$.ajax({
	url:url,
	type:'POST',
	data:{"id":text_model_id},
	beforeSend:function(){
		//这里是开始执行方法，显示效果
	},
	complete:function(){
		//方法执行完毕，效果自己可以关闭，或者隐藏效果
	},
	success:function(data){
		commonCopyPublicTextRuleModel(data);
}
});
MessageBoxShow('复制成功!',true);
return false;
}
/**
** 继承正文模板
*/
function extendsPublicTextRuleModel(ele){
var id = $("div[name='id'] input").attr("value");
//if(!id) {MessageBoxShow('请保存后再继承，或直接使用复制!');return false;}
var text_model_id = $(ele).attr("text_model_id");
var text_model_name = $(ele).attr("text_model_name");
$("#mainFrm div[name='publicTextRuleId'] input").val(text_model_id);
//var r = updateToRule();
//if(r){
	$("#mainFrm a.extends_flag:eq(1)").attr("title","继承模板【"+text_model_name+"】,点击取消继承");
	$("#mainFrm a.extends_flag:eq(1)").attr("flag_title","继承模板【"+text_model_name+"】");
	$("#mainFrm a.extends_flag:eq(1)").css("color","#3276b1").css("text-decoration","none");
	MessageBoxShow('继承成功!请记得保存哦');
//}
var url = "/epaper/editEpaperPublicTextRule.html";
$.ajax({
	url:url,
	type:'POST',
	data:{"id":text_model_id},
	beforeSend:function(){
		//这里是开始执行方法，显示效果
	},
	complete:function(){
		//方法执行完毕，效果自己可以关闭，或者隐藏效果
	},
	success:function(data){
		console.log("over");
		console.log("11:54"+data);
		commonCopyPublicTextRuleModel(data,"extends");
	}
});
}
function editPublicTextRuleModel(ele,type){
console.log("you trigger edit");
var text_model_id = $(ele).attr("text_model_id");
console.log("eidt"+text_model_id);
$('#public_'+type+'_text_rule_dialog_div').load("/epaper/toPublicTextRuleDialog.html?id="+text_model_id+"&type="+type,function(){
	var dialog = art.dialog({
		title: '公共'+type+'正文模板编辑',
		width: 'auto',    // 内容宽度
			height: 'auto',    // 内容高度
		content: $("#public_"+type+"_text_rule_dialog_div").html(),
		padding: '0px 0px',
		lock:true,
		button:[{
			  name:"<i class='fa  fa-play'></i>&nbsp; 保存",
			  callback:function(){
			  	savePublicTextRuleModel(type,dialog);
				return false;
			  }
		  },{
		    name:'取消',
		    callback:function(){
		  	}
		  }],
		    init: function () {
		    	changeArtdialogButtonCss();
		    }
	});
});
$('#public_'+type+'_text_rule_dialog_div').html("");
}
function delPublicTextRuleModel(ele,type){
console.log("you trigger del");
var dialog = art.dialog({
		    title: '删除确认框',
		    width: 'auto',    // 内容宽度
				height: 'auto',    // 内容高度
		    content: "确认要删除吗? <div style='display:none;'><input name='del_id' id='public_text_rule_model_del_id'/></div>",
		    padding: '0px 0px',
		    lock:true,
		    button:[{
		    	name:"确认",
		    	callback:function(){
		    		var url = "epaper/deleteEpaperPublicTextRule";
					var id = $('#public_text_rule_model_del_id').val();
					var data= {"id":id};
					$.ajax({
						url:url,
						data:data,
						type:"POST",
						success:function(data){
							if(data){
								if(type=="html"){
									var del_tr = $(ele).parents("tr:eq(0)");
									public_html_text_rule_model_table.fnDeleteRow(del_tr);
									//public_html_text_rule_model_table.fnDraw();//重新加载数据
								}
								dialog.close();
							}
						}
					})
					return false;
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
var text_model_id = $(ele).attr("text_model_id");
$("#public_text_rule_model_del_id").val(text_model_id);
}

function commonCopyPublicTextRuleModel(data,type){
	data = 	eval('('+data+')');
			commonCopyPublicRuleModel(data,type);
			var textAdditionalParserMapKeys = getKey(data.textAdditionalParserMap);
			var textAdditionalParserMapValues = getValue(data.textAdditionalParserMap);
			console.log(textAdditionalParserMapKeys);
			$(".textAdditionalParserMap").remove();
			/*
			if(textAdditionalParserMapKeys.length>1){
				$(".textAdditionalParserMap").remove();
			}else{
				$(".textAdditionalParserMap:gt(0)").remove();
				$(".textAdditionalParserMap:eq(0) input").val("");
				$(".textAdditionalParserMap:eq(0)").hide();
			}
			*/
			//$(".textAdditionalParserMap").remove();
			for(var i = 0 ; i < textAdditionalParserMapKeys.length; i++){
				console.log("当前----->"+textAdditionalParserMapKeys[i]);
					var str = ' <div class="form-group textAdditionalParserMap" name="textAdditionalParserMap">	'+
					 ' <label class="control-label col-md-2">	';
					 var addStr = '<a href="javascript:;" class="btn btn-primary btn-circle" onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>';
					 var minusStr = '<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>';
					 var minusOrAddStr = '';
					 if(i<1){
					 	str+="其他";
					 	minusOrAddStr=addStr;
					 }else{
					 	minusOrAddStr=minusStr;
					 }
					 if(type=="extends"){
						 str+=' </label>	'+
						 ' <div class="col-md-2">	'+
						 ' 	<input class="form-control" placeholder="" type="text" value="">	'+
						 ' </div>	'+
						 ' 	<div class="col-md-3">	'+
						 ' 		<input class="form-control" placeholder="" type="text" value="">	'+
						 ' 	</div>	'+
						 ' 	<div class="col-md-3">	'+
						 ' 		<input class="form-control" placeholder="" type="text" value="">	'+
						 ' 	</div>	'+
						 ' 	<div class="col-md-2">	'+
						 minusOrAddStr+
						 ' 	</div>	'+
						 ' </div>	';
					 }else{
					 	str+=' </label>	'+
						 ' <div class="col-md-2">	'+
						 ' 	<input class="form-control" placeholder="selector" type="text" value="">	'+
						 ' </div>	'+
						 ' 	<div class="col-md-3">	'+
						 ' 		<input class="form-control" placeholder="locator" type="text" value="">	'+
						 ' 	</div>	'+
						 ' 	<div class="col-md-3">	'+
						 ' 		<input class="form-control" placeholder="locator" type="text" value="">	'+
						 ' 	</div>	'+
						 
						 ' 	<div class="col-md-2">	'+
						 minusOrAddStr+
						 ' 	</div>	'+
						 ' </div>	';
					 }
					 if(i<1){
					 	$("div.other:eq(2)").after($(str));
					 }else{
					 	$(".textAdditionalParserMap:last").after($(str));
					 }
					 if(type=="extends"){
						 $(".textAdditionalParserMap:last").find("input:eq(0)").attr("placeholder",textAdditionalParserMapKeys[i]+"");
						 $(".textAdditionalParserMap:last").find("input:eq(1)").attr("placeholder",getKey(textAdditionalParserMapValues[i]));
						 $(".textAdditionalParserMap:last").find("input:eq(2)").attr("placeholder",getValue(textAdditionalParserMapValues[i]));
					 }else{
						 $(".textAdditionalParserMap:last").find("input:eq(0)").val(textAdditionalParserMapKeys[i]+"");
						 $(".textAdditionalParserMap:last").find("input:eq(1)").val(getKey(textAdditionalParserMapValues[i]));
						 $(".textAdditionalParserMap:last").find("input:eq(2)").val(getValue(textAdditionalParserMapValues[i]));
					 }
			}
}
function updateToRule(){
	var r = false;
	$.ajax({
		type: "post",
		url: "/epaper/saveRule",
		async:true,
		data: buildFormData2(),
		success: function(data){
			r = true;
			data = eval('('+data+')');
			$("div[name='id'] input").attr("value",data.id);
			$("div[name='id'] input").val(data.id);
			
			MessageBoxShow('更新成功!',true);
		 	//rule_table.fnDraw();
		}
	});
	
	return r;
}
function testHistoricalData(){
	
	var url = "/epaper/testHistoricalData.html";
	var post_data = buildFormData2();
	var start_date = $("#start_date").val();
	var end_date = $("#end_date").val();
	post_data['startDate'] = start_date; 
	post_data['endDate'] = end_date; 
	
	$.ajax({
		url:url,
		type:'post',
		data:post_data,
		beforeSend:function(){
			//这里是开始执行方法，显示效果
			$("#rule_list_fieldset").hide();
			$(".fatch_processing").show();
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
			$(".fatch_processing").hide();
			$("#rule_list_fieldset").show();
		},
		success:function(data){
			data=eval("("+data+")");//转换为json对象
			var result_str = '';
			var nodata = "无";
			for(var i = 0 ; i < data.length ; i++){
				var title = data[i].title?data[i].title:nodata;
				var time = data[i].time?data[i].time:nodata;
				var url = data[i].url;
				var oldContent = data[i].content?data[i].content:nodata;
				
				var content1 = oldContent.substring(0,200);
				var content2 = "<span class='more-contents' style='display:none;'>"+oldContent.substring(200)+"</span>"+"<a href='javascript:;' class='more-ele' onclick='openOrCloseContent(this)'>展开</a>";
				content1 += content2;
				result_str += '<div><b>标题</b>:<a href="'+url+'"  target="blank_">'+title+'</a></div>'+
								 '<div><b>时间</b>:'+time+'</div>'+
								 '<div><b>内容</b>:'+content1+'</div>'+'<legend></legend>';
			}
			console.log(result_str);
			$("#rule_list_fieldset div:eq(0)").html(result_str);
		}
	});
}
function getKey(map){
	var arr_k =  new Array();
	if(map){
		for(var key in map){  
			arr_k.push(key);
        }  
    }else{}
    return arr_k;
}
function getValue(map){
	var arr_v =  new Array();
	if(map){
		for(var key in map){
			arr_v.push(map[key]);
        }  
    }else{}
    return arr_v;
}

//正文事件--end
function addNewRow(ele,type){
		var parent = $(ele).parents(".form-group");
		var name = $(ele).parents(".form-group").attr("name");
		var deleteHtml = '	<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>';
		var cloneParent = parent.clone();
		$(cloneParent).find("label").html("");
		$(cloneParent).find("div:eq(0) input").val("");
		$(cloneParent).find("div:eq(1) input").val("");
		if(!(type&&type==2)){
			$(cloneParent).find("div:eq(2)").html(deleteHtml);
		}else{
			$(cloneParent).find("div:eq(2) input").val("");
			$(cloneParent).find("div:eq(3)").html(deleteHtml);
		}
		$(".aui_content div[name='"+name+"']:last").after(cloneParent);
}
function testListPageInfo(ele){
	var listPageUrl = $(ele).attr("to-url");
	//$("#mainFrm div[name='listPageUrl'] input").val(listPageUrl);
	var url = "epaper/getListPageInfo";
	var formData = buildFormData();
	formData['listPageUrl'] = listPageUrl;
	$.ajax({
		url:url,
		type:'POST',
		data:formData,
		beforeSend:function(){
			//这里是开始执行方法，显示效果
			$(ele).find("i").attr("class","fa fa-gear fa-1x fa-spin");
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
			$(ele).find("i").attr("class","fa fa-play fa-1x");
		},
		success:function(data){
			doAfterTestListPageInfoSuccess(data,ele);
		}
	});
}
function doAfterTestListPageInfoSuccess(data,ele){
	data=eval("("+data+")");//转换为json对象
	var nodata = "无";
	var div_str = "";
	var sectionThumbnailUrl = data[0].sectionThumbnailUrl;
	if(sectionThumbnailUrl) div_str += "<img src='"+sectionThumbnailUrl+"'/>";
	for(var i = 0 ; i < data.length; i++){
		var url = data[i].url;
		var test_content_btn = '<a class="btn btn-primary btn-xs" to-url="'+url+'" href="javascript:void(0);" onclick="testContent(this)" style=""><i class="fa fa-play fa-1x"></i>测试内容</a>';
		div_str += "<div style='margin-bottom: 5px;'><a href='"+url+"' target='_blank' style='margin-right:5px;'>"+url+"</a>"+test_content_btn+"</div>";
		url = null;
		test_content_btn = null;
	}
	$(ele).parent().find(".fetch-list:eq(0)").html(div_str);
	$(ele).parent().find(".fetch-list:eq(0)").show();
}
function testContent(ele){
	var textPageUrl = $(ele).attr("to-url");
	var url = "epaper/getTextPageInfo";
	var formData = buildFormData();
	formData['textPageUrl'] = textPageUrl;
	$.ajax({
		url:url,
		type:'POST',
		data:formData,
		beforeSend:function(){
			//这里是开始执行方法，显示效果
			$(ele).find("i").attr("class","fa fa-gear fa-1x fa-spin");
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
			$(ele).find("i").attr("class","fa fa-play fa-1x");
		},
		success:function(data){
			doAfterTestContentSuccess(data,ele);
		}
	})
}
function doAfterTestContentSuccess(data,ele){
	data=eval("("+data+")");//转换为json对象
	var nodata = "无";
	var content = data.content;
	var imgUrls = data.imgUrls;
	var title = data.title?data.title:nodata;
	var author = data.author?data.author:nodata;
	var source = data.source?data.source:nodata;
	var time = data.time?data.time:nodata;
	var reply = data.reply?data.reply:nodata;
	var click = data.click?data.click:nodata;
	var additionalAttribute = data.additionalAttribute?data.additionalAttribute:nodata;
		    	var additionalAttributeStr = "";
		    	if(additionalAttribute){
		    		additionalAttributeStr = obj2str(additionalAttribute); 
		    	}
	//var imgUrls = data.imgUrls;
	var srcArry = imgUrls.split("---------rotarapes---------");
	var imgUrlEles = "";
	if(imgUrls){
		for(var i = 0 ; i < srcArry.length;i++){
			imgUrlEles+="<div style='text-align:center;'><img src='"+srcArry[i]+"' width='400' style='margin:10px 0'/></div>";
		}
	}
	var content0 =  '<div><b>标题</b>:'+title+'</div>'+
					'<div><b>作者</b>:'+author+'</div>'+
					'<div><b>来源</b>:'+source+'</div>'+
					'<div><b>发布时间</b>:'+time+'</div>'+
					'<div><b>回复</b>:'+reply+'</div>'+
					'<div><b>点击</b>:'+click+'</div>'+
					'<div><b>其他字段</b>:'+additionalAttributeStr+'</div>'+
					'<div><b>内容</b>:</div>';
	var content1 = content.substring(0,200);
	var content2 = "<span class='more-contents' style='display:none;'>"+content.substring(200)+"</span>";
	var totalContent = content0+content1+content2+"<a href='javascript:;' class='more-ele' onclick='openOrCloseContent(this)'>展开</a>";
	$(ele).parents(".fetch-result:eq(0)").find(".fetch-content").html(imgUrlEles+totalContent);
	$(ele).parents(".fetch-result:eq(0)").find(".fetch-content").show();
}
// load related plugins
function openOrCloseContent(more_ele){
	var $more_ele = $(more_ele);
	var $content_ele = $more_ele.parent();
	var $more_contents = $content_ele.find(".more-contents");
	
	if($more_ele.html()=="展开"){
		$more_contents.show();
		$more_ele.html("收起");	
	}else{
		$more_contents.hide();
		$more_ele.html("展开");	
	}
}
function auditPass(){
	var formData = buildFormData("#leftEditBox");
	var userName = $("#group-rule-boxs div[name='userName'] input").val();
	var groupName = $("#groupId option:selected").text();
	formData['epaperGroupRuleRequirementId'] = $("#group-rule-boxs div[name='id'] input").val();
	formData['auditOpinion'] = $("#group-rule-boxs div[name='auditOpinion'] textarea").val();
	formData['groupId'] = $("#groupId").val();
	formData['groupName'] = groupName;
	
	$.ajax({
		url:'/epaperGroupRule/auditPass',
		dataType:'json',
		data:formData,
		success:function(d){
			if(d.result==1){
				var html = '页面审核完成！<br/>'+
				  			'该规则已添加到用户'+userName+' 的 '+groupName+' 任务中。';
				MessageBoxShow(html,true);
			}else if(d.result==-1){
				MessageBoxShow("审核失败！服务器异常");
			}else if(d.result==2){
				MessageBoxShow("审核失败！页面数量超出限制!");
			}
		},error:function(){
			MessageBoxShow("审核失败！服务器异常");
		}
	})
}
function obj2str(o){
	   var r = [];
	   if(typeof o == "string" || o == null) {
	     return o;
	   }
	   if(typeof o == "object"){
	     if(!o.sort){
	       r[0]="{"
	       for(var i in o){
	         r[r.length]="<b>"+i+"</b>";
	         r[r.length]=":";
	         r[r.length]=obj2str(o[i]);
	         r[r.length]=",";
	       }
	       r[r.length-1]="}"
	     }else{
	       r[0]="["
	       for(var i =0;i<o.length;i++){
	         r[r.length]=obj2str(o[i]);
	         r[r.length]=",";
	       }
	       r[r.length-1]="]"
	     }
	     return r.join("");
	   }
	   return o.toString();
	}

var common_data_table_config = {
		//查看子版块
		"oLanguage" : { //主要用于设置各种提示文本
			"sProcessing" : "<a href=\"javascript:void(0);\" class=\"bg-color-white txt-color-teal\"><i class=\"fa fa-gear fa-2x fa-spin\"></i></a>&nbsp;&nbsp;&nbsp;正在处理...", //设置进度条显示文本
			"sEmptyTable" : "没有找到记录",//没有记录时显示的文本
			"sZeroRecords" : "没有找到记录",//没有记录时显示的文本
			"sInfo" : "总数<span class='text-primary'>_TOTAL_</span>显示<span class='txt-color-darken'>_START_</span>至<span class='txt-color-darken'>_END_</span>",
			"sInfoEmpty" : "",//没记录时,关于记录数的显示文本
			"oPaginate" : {
				"sFirst" : "首页",
				"sLast" : "未页",
				"sNext" : "下页",
				"sPrevious" : "上页"
			}
		},
		"sDom":'<"dt-toolbar"<"col-xs-12 col-sm-6"fr><"col-xs-12 col-sm-6">'+ 
		       '"t"'+'<"dt-toolbar-footer"<"col-xs-6"il><p>> >'//
}
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
