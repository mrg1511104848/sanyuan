<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>


.userBox {
	border-left: 5px solid rgba(0, 0, 0, 0.15);
	box-sizing: content-box;
	overflow: hidden;
	padding: 10px 10px 5px;
	box-sizing: content-box;
	margin-bottom: 10px;
	margin-right: 10px;
	margin-top: 10px;
	}
.input-prepend{
width: 200px;
float: left;
margin-right:5px;
}
.btn-prepend{
float: left;
margin-right:5px;
}
.marginR5{
margin-right:5px;
}
</style>
<script src="/resources/js/news-common.js"></script>
<div class="row">
	
	<!-- col -->
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title  txt-color-blueDark">
			
			<!-- PAGE HEADER -->
			<i class="fa-fw fa fa-home"></i> 
				系统管理
			<span>>  
				采集任务
			</span>
		</h1>
	</div>
	<!-- end col -->
	
	<!-- right side of the page with the sparkline graphs -->
	<!-- col -->
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8">
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
								<div class="col-sm-12 col-lg-12">
													<div class="well well-sm well-light">
														<table>
															<tr>
																<td class="col-md-6 col-lg-6 col-xs-6">
																		
																		<div class="btn-group">
																		<div class=" input-prepend input-group">
																		<select type="text" class="form-control" placeholder="例如：及时渔"
																			name="txtState" id="user_requirment_state"
																			>
																			<option value="">所有</option>
																			<option value="0">未审核</option>
																			<option value="1">已通过</option>
																			<option value="2">被驳回</option>
																		</select>
																		</div>
																		<div class="input-prepend input-group">
																		<input type="text" class="form-control" placeholder="例如：张三"
																			name="txtKeyword" id="user_name"
																			ng-model="keyWord">
																		</div>
																		</div>
																		<div class="btn-group">
																		<button type="button" class="btn btn-default btn-prepend"
																			onClick="getUserList(1)">
																			查 询
																		</button>
																		</div>
																</td>
															</tr>
														</table>
													</div>
												</div>
												<div class="superbox col-sm-12 col-lg-12">
													
												</div>
									<div class="text-center" id="pageInfo">
										<ul id="pager" class="pagination pagination-sm"></ul>
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

		

</div>
<!-- end widget -->


<div id="group-rule-boxs" style="display:none;"></div>
<div id="divContent"></div>
<div id="audit-boxs" style="display:none;"></div>
 <script type="text/javascript" src="/resources/js/plugin/jquery-tmpl/jquery.tmpl.min.js"></script> 
<script type="text/javascript" src="/resources/js/bootstrap/bootstrap-paginator.min.js"></script>
<script id="myTemplate" type="text/x-jquery-tmpl"> 
	<div class="userBox col-lg-2 col-sm-12 bg-color-lighten ">
		{{if requirementSurplus>0}}
		<div class="badge bg-color-red" style="padding: 5px;font-size: 14px;border-radius: 50%;font-weight: 400;min-width: 24px;text-align: center!important;position: absolute;z-index: 10000;left: 0;top: 0;">
				{{html requirementSurplus}}
		</div>
		{{/if}}
						<div class="col-xs-4 col-sm-4 col-lg-4">
							<a href="javascript:;" target="_blank"><img
									src="http://tp1.sinaimg.cn/5356414944/50/40072464262/1" /> </a>
						</div>
						<div class="col-xs-8 col-sm-8 col-lg-8">
							<ul class="list-unstyled">
								<li>
									<p class="txt-color-purple">
										<span><a 
											href="javascript:;" onclick="toRequirement('{{html id}}','{{html userName}}')"
											 title="{{html userName}}"> {{html userName}}
											</a></span>
										<i class="W_icon "></i>
									</p>
								</li>
								<li>
									<p style="margin-bottom: 0px;">
										<label style="width:80px;display:inline-block;">总添加：</label>{{html collectPageCount}}
										<i class=""></i>
									</p>
								</li>
								<li>
									<p style="margin-bottom: 0px;">
										<label style="width:80px;display:inline-block;">本渠道添加：</label>{{html newsPageCount}}
										<i class=""></i>
									</p>
								</li>
								<li>
									<p>
										<label style="width:80px;display:inline-block;">剩余：</label>{{html collectPageLimit-collectPageCount}}
									</p>
								</li>
							</ul>
						</div>
	</div>
</script>
<script type="text/javascript">
pageSetUp();
if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
}
var pagefunction = function() {
	// clears the variable if left blank
	loadFailureRecordTable();
};

// end pagefunction

//根据规则创建参数------开始----------------------------
	function buildFormData(eleClass){
		var formData = {};
		$(eleClass+" div.form-group").each(function(){
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


// run pagefunction
var pageIndex = 1, pageSize = 8, pageCount = 0
var container=$('#pager'); 
var options = null;
$( "#tabs" ).tabs();
getUserList(pageIndex);

function getUserList(index)
{
	var query = "/user/getPagedList?timeStamp="+new Date().getTime()+
		"&iDisplayLength=" +pageSize+
		"&iDisplayStart=" + (index-1) * pageSize+
		"&iDisplayStart=" + (index-1) * pageSize+
		"&type=news"+
		"&eq_state="+$("#user_requirment_state").val()+	
		"&l_userName="+$("#user_name").val();						
	pageIndex = index;
	$.ajax({
		dataType: "json",
		beforeSend:function(){
			//loadingTip("正在加载中,请耐心等待...","#divContent");
		},
		type: "GET",
		url: query,
		success: showData
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
           		getUserList(newPage);
           	}
        };
        container.bootstrapPaginator(options);
	}
	$(".superbox").empty();
	$('#myTemplate').tmpl(lists).appendTo('.superbox');
	
}
var news_group_rule_requirement_list_table ;
//根据规则创建参数------结束----------------------------
function loadFailureRecordTable(){
	news_group_rule_requirement_list_table = $("#news_group_rule_requirement_list_").dataTable({
		"bProcessing" : true,//加载数据时候是否显示进度条
		"bServerSide" : true,//是否从服务加载数据 
		"sAjaxSource" : "/newsGroupRule/getNewsGroupRuleRequirementList",//如果从服务器端加载数据,这个属性用于指定加载的路径 
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
		        return '<a target="blank_" href="'+row.sectionUrl+'">'+row.section+'</a>';
	    	}},
	        {"data": function ( row, type, set ){
	    		return row.sectionUrl;
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
	        {"sWidth":'70px',"data": function ( row, type, set ){
	        	var id = row.id;
	        	var adminBtns = "<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRule(\""+id+"\",true)'><i class='fa fa-eye'></i></button>&nbsp&nbsp"
				+ "<button onclick='addOrEditNewsGroupRule(\""+id+"\",false)'  class='lookDataForThis btn btn-xs btn-default' news_group_rule_id='"+id+"' rule_id='"+row.ruleId+"' group_id='"+row.groupId+"' title='查看数据'><i class='fa fa-search'></i></button>&nbsp&nbsp"
				//+ "<button class='delAll btn btn-xs btn-default'  title='删除' site_id='"+ id
				//+ "' onclick='deletePageRule(\""+id+"\")'><i class='fa fa-times'></i></button>";
				var notAdminBtns_pass = "<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRule(\""+id+"\",false)'><i class='fa fa-smile-o'></i></button>";
				var notAdminBtns_notPass = "<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRule(\""+id+"\",false)'><i class='fa fa-frown-o'></i></button>";
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
			$("#news_group_rule_requirement_list__wrapper .dt-toolbar").css("margin-bottom","5px");
			initFailureRecordTableButton();
	     },
	     "sDom": "<'dt-toolbar'<'col-xs-8 tools-bar'><'col-xs-4'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>"
    });
}

function initFailureRecordTableButton(){
	
	$("#news_group_rule_requirement_list__wrapper .dt-toolbar").css("border","none").css("padding","0px");
	var eq_state = '<select  name="eq_state" class="form-control marginR5">'+
						'<option value="">所有</option>'+
						'<option value="0">未审核</option>'+
						'<option value="1">已通过</option>'+
						'<option value="2">被驳回</option>'+
						'</select>';
	var l_userName = '<input type="text" name="l_userName" class="form-control ng-valid ng-dirty marginR5" placeholder="用户名">';					
	var l_section = '<input type="text" name="l_section" class="form-control ng-valid ng-dirty marginR5" placeholder="页面名称">';
	var search_btn = '<button type="button" class="btn btn-default marginR5" onclick="searchRequirement()">查 询</button>';
	$("#news_group_rule_requirement_list__wrapper .dt-toolbar div:eq(0)").append(eq_state).append(l_userName).append(l_section).append(search_btn);
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
				  name:"保存",
				  callback:function(){
				  	$(".aui_content #mainFrm div[name='publicListRuleId'] input").val("");
				  	$(".aui_content #mainFrm a.extends_flag:eq(0)").attr("title","当前无继承模板");
				  	$(".aui_content #mainFrm a.extends_flag:eq(0)").attr("flag_title","当前无继承模板");
					$(".aui_content #mainFrm a.extends_flag:eq(0)").css("color","#ccc").css("text-decoration","none");
				  	startToCopyPublicListRuleModel(ele);
				  	//var r = updateToRule();
				  	//if(r){
				  	MessageBoxShow('复制成功!',true);
				  	//	art.dialog.tips('复制成功!');
				  		
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
		//art.dialog.tips('复制成功!');
		MessageBoxShow('复制成功!',true);
	}
	
}
function startToCopyPublicListRuleModel(ele){
	var list_model_id = $(ele).attr("list_model_id");
		var url = "/news/editNewsPublicListRule.html";
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
function commonCopyPublicListRuleModel(data,type){
	data=eval("("+data+")");//转换为json对象
	var fetch_strategy = data.fetchStrategy?data.fetchStrategy:1;
	if(type!="extends"){
		$("div[name='fetchStrategy'] input").attr("value",fetch_strategy);
		$("div[name='fetchStrategy'] input").val(fetch_strategy);
	}else{
		$("div[name='fetchStrategy'] input").attr("value","");
		$("div[name='fetchStrategy'] input").val("");
		$("div[name='fetchStrategy'] input").attr("placeholder",fetch_strategy);
	}
	$("input[name='radio-fetch-strategy']").each(function(){
		console.log($(this).attr("t_value")+"===="+fetch_strategy);
		if($(this).attr("t_value")==fetch_strategy){
			$(this).prop("checked",true);
			//$(this)[0].checked = true;
		}else{
			$(this).prop("disabled",false);
		}
	});
	$("input[name='radio-fetch-strategy2']").each(function(){
		console.log($(this).attr("t_value")+"===="+fetch_strategy);
		if($(this).attr("t_value")==fetch_strategy){
			$(this).prop("checked",true);
		}else{
			$(this).prop("disabled",false);
		}
	});
	
	commonCopyPublicRuleModel(data,type);
	var listAdditionalParserMapKeys = getKey(data.listAdditionalParserMap);
	var listAdditionalParserMapValues = getValue(data.listAdditionalParserMap);
	console.log(listAdditionalParserMapKeys.length);
	$(".listAdditionalParserMap").remove();
	/*
	if(listAdditionalParserMapKeys.length>1){
		$(".listAdditionalParserMap").remove();
	}else{
		$(".listAdditionalParserMap:gt(0)").remove();
		$(".listAdditionalParserMap:eq(0) input").val("");
		$(".listAdditionalParserMap:eq(0)").hide();
	}*/
	for(var i = 0 ; i < listAdditionalParserMapKeys.length; i++){
			var str = ' <div class="form-group listAdditionalParserMap" name="listAdditionalParserMap">	'+
			 ' <label class="control-label col-md-2">	';
			 if(i<1){
			 	str+="其他";
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
				 ' 		<a href="javascript:;" class="btn btn-primary btn-circle" onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>	'+
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
				 ' 		<a href="javascript:;" class="btn btn-primary btn-circle" onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>	'+
				 ' 	</div>	'+
				 ' </div>	';
			 }
			 if(i<1){
			 	$("div.other:eq(0)").after($(str));
			 }else{
			 	$(".listAdditionalParserMap:last").after($(str));
			 }
			 if(type=="extends"){
				 $(".listAdditionalParserMap:last").find("input:eq(0)").attr("placeholder",listAdditionalParserMapKeys[i]+"");
				 $(".listAdditionalParserMap:last").find("input:eq(1)").attr("placeholder",getKey(listAdditionalParserMapValues[i]));
				 $(".listAdditionalParserMap:last").find("input:eq(2)").attr("placeholder",getValue(listAdditionalParserMapValues[i]));
			 }else{
				 $(".listAdditionalParserMap:last").find("input:eq(0)").val(listAdditionalParserMapKeys[i]);
				 $(".listAdditionalParserMap:last").find("input:eq(1)").val(getKey(listAdditionalParserMapValues[i]));
				 $(".listAdditionalParserMap:last").find("input:eq(2)").val(getValue(listAdditionalParserMapValues[i]));
			 }
	}
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
function deleteRow(ele){
	$(ele).parent().parent().remove();
}
function showOther(ele){
	$(ele).parent().next().show();
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

function testContent(ele){
	var textPageUrl = $(ele).attr("to-url");
	$("#mainFrm div[name='textPageUrl'] input").val(textPageUrl);
	var url = "news/getTextPageInfo";
	$.ajax({
		url:url,
		type:'POST',
		data:buildFormData("#leftEditBox"),
		beforeSend:function(){
			//这里是开始执行方法，显示效果
			$(ele).next().show();
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
			$(ele).next().hide();
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
	var imgUrls = data.imgUrls;
	var srcArry = imgUrls.split("---------rotarapes---------");
	var imgUrlEles = "";
	if(imgUrls){
		for(var i = 0 ; i < srcArry.length;i++){
			if(srcArry[i]){
				imgUrlEles+="<div style='text-align:center;'><img src='"+srcArry[i]+"' width='400' style='margin:10px 0'/></div>";
			}
			
		}
	}
	var content0 = '<div><b>作者</b>:'+author+'</div>'+
					'<div><b>来源</b>:'+source+'</div>'+
					'<div><b>发布时间</b>:'+time+'</div>'+
					'<div><b>回复</b>:'+reply+'</div>'+
					'<div><b>点击</b>:'+click+'</div>'+
					'<div><b>其他字段</b>:'+additionalAttributeStr+'</div>'+
					'<div><b>内容</b>:</div>';
	var content1 = content.substring(0,200);
	var content2 = "<span class='more-contents' style='display:none;'>"+content.substring(200)+"</span>";
	var totalContent = content0+content1+content2+"<a href='javascript:;' class='more-ele' onclick='openOrCloseContent(this)'>展开</a>";
	$(ele).parent().find(".fetch-content").html(imgUrlEles+totalContent);
	$(ele).parent().find(".fetch-content").show();
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
	formData['newsGroupRuleRequirementId'] = $("#group-rule-boxs div[name='id'] input").val();
	formData['auditOpinion'] = $("#group-rule-boxs div[name='auditOpinion'] textarea").val();
	formData['groupId'] = $("#groupId").val();
	formData['groupName'] = groupName;
	
	$.ajax({
		url:'/newsGroupRule/auditPass',
		dataType:'json',
		data:formData,
		success:function(d){
			if(d.result==1){
				var html = '页面审核完成！<br/>'+
				  			'该规则已添加到用户'+userName+' 的 '+groupName+' 任务中。';
				MessageBoxShow(html,true);
				//hehe
				news_group_rule_requirement_list_table.fnDraw();
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

loadScript("/resources/js/plugin/datatables/jquery.dataTables.min.js", function(){
	loadScript("/resources/js/plugin/datatables/dataTables.colVis.min.js", function(){
		loadScript("/resources/js/plugin/datatables/dataTables.tableTools.min.js", function(){
			loadScript("/resources/js/plugin/datatables/dataTables.bootstrap.min.js", pagefunction);
		});
	});
});
</script>