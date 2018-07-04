<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">
.dt-toolbar{
	padding: 10px;
}
.btn-group{
	padding-right: 5px;
}
</style>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-2">
		<h1 class="page-title txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 采集任务
		</h1>
	</div>
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-10"
		style="text-align:right;"></div>
</div>

<!-- widget grid -->
<section id="widget-grid" class="">
	<!-- row -->
	<div class="row">
		<article class="col-sm-12 col-md-12 col-lg-12" id="user-rule-boxs">
			<div
				class="jarviswidget jarviswidget-color-darken col-sm-12 col-lg-12"
				id="wid-id-failure-record" data-widget-editbutton="false" data-widget-colorbutton="false"
				style="width:100%;">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i>
					</span>
					<h2>采集任务列表</h2>

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
						<div id="inbox-content" class="inbox-body" style="min-height: 520px">
							<div class="inbox-side-bar" >
								<div class="inbox-checkbox-triggered">
									<div class="btn-group" style="margin-top: 10px;">
										<a href="javascript:addGroup(-1);" rel="tooltip" title=""
											data-placement="bottom" data-original-title="增加"
											class="btn btn-default"><strong><i
												class="fa fa-plus"></i></strong></a> <a href="javascript:addGroup(1);"
											rel="tooltip" title="" data-placement="bottom"
											data-original-title="修改" class="btn btn-default"><strong><i
												class="fa fa-pencil "></i></strong></a> <a href="javascript:deleteGroup();"
											rel="tooltip" title="" data-placement="bottom"
											data-original-title="删除" class="btn btn-default"><strong><i
												class="fa fa-trash-o"></i></strong></a>
									</div>
								</div>
								<ul id="ul_group" class="inbox-menu-lg">
								</ul>
							</div>
							<div class="table-wrap custom-scroll animated fast fadeInRight">
								<table id="site_list"
									class="table table-striped table-bordered table-hover smart-form"
									width="100%">
								</table>
							</div>
						</div>
					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
			<!-- end widget -->
		</article>
	</div>
</section>
<div id="group_dialog_div"></div>
<div id="group-rule-boxs" style="display:none;"></div>
<div id="news-search-boxs" style="display:none;"></div>

 <script type="text/javascript" src="/resources/js/plugin/jquery-tmpl/jquery.tmpl.min.js"></script> 
<script type="text/javascript" src="/resources/js/bootstrap/bootstrap-paginator.min.js"></script>
<script type="text/javascript">
	//初始化加载一些参数
	pageSetUp();
	//根据规则创建参数------开始----------------------------
	function buildFormData(){
		var formData = {};
		$("div.form-group").each(function(){
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
	function getAllGroupList(){
		$.ajax({
		   	url:"news/getAllGroupList.html",
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
// 				oTable.fnSettings().aoServerParams[0].fn=function(aoData){
// 					aoData.push( { "name": "eq_groupId", "value": id } );
// 				}
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
				    url: "/news/deleteGroup?id="+id,
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
		    			var requestUrl="/news/saveGroup";
		    			if(t!=-1)
		    			{
		    				requestUrl="/news/editGroup";
		    			}
			    		$.ajax({
							type: "post",
						    url: "/news/saveGroup",
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
								"sEmptyTable" : "无数据",
								"sLengthMenu" : "&nbsp;&nbsp;_MENU_",
							},
							"sDom": "<'dt-toolbar'<'col-xs-8 tools-bar'><'col-xs-4'C>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
							"oColVis" : {
								"buttonText" : "表格列显示 / 隐藏"
							},
							"bSort" : false,
							"bPaginate" : true,
							"bProcessing" : false,
							"bServerSide" : true,
							"sAjaxSource" : "/epaperGroupRule/getNewsGroupRuleList"
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
											return "<span title='"+row.section+"'>"
													+ cut_str(row.section, 110,
															"...") + "</span>";
										}
									},
									{
										"sWidth" : "50%",
										"sTitle" : "页面URL",
										"sClass" : "center",
										"data" : function(row, type, set) {
											return "<a href='"+row.sectionUrl+"' target='_blank'>"
													+ row.sectionUrl + "</a>";
										}
									},
									{
										"sWidth" : "15%",
										"sTitle" : "操作",
										"sClass" : "center",
										"data" : function(row, type, set) {
											var id = row.id;
											return "<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRule(\""+id+"\")'><i class='fa fa-eye'></i></button>&nbsp&nbsp"
													+ "<button onclick='lookDataForThis(this)'  class='lookDataForThis btn btn-xs btn-default' news_group_rule_id='"+id+"' rule_id='"+row.ruleId+"' group_id='"+row.groupId+"' title='查看数据'><i class='fa fa-search'></i></button>&nbsp&nbsp"
													+ "<button class='delAll btn btn-xs btn-default'  title='删除' site_id='"+ id
													+ "' onclick='deletePageRule(\""+id+"\")'><i class='fa fa-times'></i></button>";

										}
									} ]
						});
		var tools_html='<div class="btn-group"><button class="btn btn-primary" onclick="addPageRule()">新增</button></div>'+
		'<div class="btn-group"><button class="btn btn-danger" onclick="deletePageRule(0)">批量删除</button></div>'+
		'<div class="btn-group"><div class="icon-addon  pull-left">'+
		'<input type="text" class="form-control" placeholder="例如：及时渔"	id="txtContent" style="200px;">'+
		'<label title="" rel="tooltip" class="glyphicon glyphicon-search" for="email" data-original-title="email"></label>'+
		'</div></div><div class="btn-group">'+
		'<button class="btn btn-default" onclick="searchResult();">查 询 </button></div>';
		$(".tools-bar").append(tools_html);	
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
    			url : "/epaperGroupRule/deleteAllNewsGroupRules",
    			data:data,
    			beforeSend : function() {
    			},
    			success : function(result) {
   					if($("#site_list input[name='chkAll']").is(':checked'))
   					{
   						$("#site_list input[name='chkAll']").removeAttr("checked");
   					}
   					oTable.fnClearTable();
    			},
    			complete : function() {
    			}
    		});
        }
	}
	var pageIndex = 1, pageSize = 8, pageCount = 0
	var container; 
    var options = null;
	function getRuleList(index)
	{
		var query = "/epaper/getRulePagedList?timeStamp="+new Date().getTime()+
			"&iDisplayLength=" +pageSize+
			"&iDisplayStart=" + (index-1) * pageSize+
			"&eq_groupId="+$("#ul_group li.active a").attr("site_id")					
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
			deleteEpaperGroupRule(ele,id);
		}else{
			addEpaperGroupRule(ele,id);
		}
		event.stopPropagation();
	}
	//这里--
	function addEpaperGroupRulesForSite(ele,rule_id,group_id,group_name){
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
	function addEpaperGroupRule(ele,rid) {
		var rule_id = rid +"";
		var group_id= $("#ul_group li.active a").attr("site_id")+"";
		var group_name=$("#ul_group li.active a").html()+"";
		addEpaperGroupRulesForSite(ele,rule_id,group_id,group_name);
	};

	function deleteEpaperGroupRule(ele,rid){
		var rule_id = rid +"";
		var group_id= $("#ul_group li.active a").attr("site_id")+"";
		var group_name=$("#ul_group li.active a").html()+"";
		deleteToUserRuleOfRule(ele,rule_id,group_id);
	}
	function deleteToUserRuleOfRule(ele,rule_id,group_id){
		var url = "/epaperGroupRule/deleteEpaperGroupRules";
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
	function addEpaperGroupRuleRequirement(){
		var formData = buildFormData();
		formData['state'] = 0;
		formData['groupId'] = $("#groupId").val();
		formData['groupName'] = $("#groupId option:selected").text();
		formData['collectionContent'] = $("div[name='collectionContent'] textarea").val();
		$.ajax({
			url:'/epaperGroupRule/addEpaperGroupRuleRequirement',
			type:'POST',
			data:formData,
			dataType:'json',
			success:function(d){
				if(d.result){
					var html = '您的采集页面已成功提交，管理员审核后会将结果及时反馈给您！<br/>'+
					  			'详细审核状态和结果可在采集任务的“审核中”与“已审核”中查看。';
					MessageBoxShow(html,true);
				}else{
					MessageBoxShow("提交失败！");
				}
			}
		})
		
	}
	function lookDataForThis(ele){
		$("#news-search-boxs").html("");
		var rule_id = $(ele).attr("rule_id");
		var group_id = $(ele).attr("group_id");
		$('#news-search-boxs').load("/news/newsArticleSearch?eq_ruleId="+rule_id,function(){
			 var dialog = window.top.art.dialog({
					title: "详情",
					content: $("#news-search-boxs")[0],
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
