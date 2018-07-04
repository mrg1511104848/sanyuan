<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-2">
		<h1 class="page-title txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 概览
			<span>> 新闻任务未审核 </span>
		</h1>
	</div>
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-10" style="text-align:right;">
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
					<table id="news_group_rule_requirement_list"
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
	
			</div>
			<!-- end widget div -->
	
		</div>
		<!-- end widget -->
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
</section>
<div id="group-rule-boxs" style="display:none;"></div>
<div id="audit-boxs" style="display:none;"></div>
<script type="text/javascript">
 	//初始化加载一些参数
	pageSetUp();
	var news_group_rule_requirement_list_table;
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	var pagefunction = function() {
		loadFailureRecordTable();
	}
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
	function loadFailureRecordTable(){
		news_group_rule_requirement_list_table = $("#news_group_rule_requirement_list").dataTable({
			"bProcessing" : true,//加载数据时候是否显示进度条
			"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/newsGroupRule/getNewsGroupRuleRequirementList?eq_state="+'${state}',//如果从服务器端加载数据,这个属性用于指定加载的路径 
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
		        {"data": function ( row, type, set ){
		        	var id = row.id;
		        	var adminBtns = "<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRule(\""+id+"\",true)'><i class='fa fa-eye'></i></button>&nbsp&nbsp"
					+ "<button onclick='addOrEditNewsGroupRule(\""+id+"\",false)'  class='lookDataForThis btn btn-xs btn-default' news_group_rule_id='"+id+"' rule_id='"+row.ruleId+"' group_id='"+row.groupId+"' title='查看数据'><i class='fa fa-search'></i></button>&nbsp&nbsp"
					+ "<button class='delAll btn btn-xs btn-default'  title='删除' site_id='"+ id
					+ "' onclick='deletePageRule(\""+id+"\")'><i class='fa fa-times'></i></button>";
					var notAdminBtns_pass = "<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRule(\""+id+"\",true)'><i class='fa fa-smile-o'></i></button>";
					var notAdminBtns_notPass = "<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRule(\""+id+"\",true)'><i class='fa fa-frown-o'></i></button>";
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
				initFailureRecordTableButton();
		     },
		     "sDom":'<"dt-toolbar"<"col-xs-12 col-sm-6"f><"col-xs-12 col-sm-6">'+ 
					'"t"'+'<"dt-toolbar-footer"<"col-xs-6"il><p>> >'//
					//"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>"
	    });
	}	
	function initFailureRecordTableButton(){
		$("#failure_record_list_filter label").remove();
		var s_site_btn = '<input type="text" name="l_site" class="form-control ng-valid ng-dirty" placeholder="站点名称">';
		var s_section_btn = '<input type="text" name="l_section" class="form-control ng-valid ng-dirty" placeholder="版块名称">';
		var s_submit_btn = '<a class="btn btn-default" id="failure_record_search">查询 </a>';
		$("#failure_record_list_filter").append($(s_site_btn)).append($(s_section_btn)).append($(s_submit_btn));

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
	var newsGroupRuledialog;
	function addOrEditNewsGroupRule(id,lookOnlyFlag){
		$('#group-rule-boxs').load("/newsGroupRule/editNewsGroupRuleRequirement?eq_id="+id+"&lookOnly="+lookOnlyFlag,function(){
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
	function getCurrentUserIsAdmin(){
		$.ajax({
			url:'/user/getCurrentUserIsAdmin',
			dataType:'json',
			async:false,
			success:function(d){
				return d.result;
			}			
		})
	}
	function startAudit(){
		$('#audit-boxs').load("/newsGroupRule/startAudit",function(){
			loadRuleDialog();
		});
	}
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
					    	name:'保存为新模块',
					    	callback:function(){
								var rId = saveNewRule();
								$(".aui_buttons button:eq(2)").show();
								if(rId){
									MessageBoxShow('保存成功!',true);
									//art.dialog.tips('保存成功!');
								}
								return false;
					    	}
					    },{
					    	name:'测试',
					    	callback:function(){
								getListPageInfo();
								return false;
							}
					    }],
					    init: function () {
					    	changeArtdialogButtonCss();
					    }
				});
			$(".aui_content").css("width","100%");
	}
	function loadPublicHtmlListRuleModelOnlySelect(){
		commonLoadPublicHtmlListRuleModelTable(true);
	}
	var public_html_list_rule_model_table = null;
	function commonLoadPublicHtmlListRuleModelTable(isCopyOrExtends){//isSelect:是否是将要 复制或者继承
		if(public_html_list_rule_model_table!=null){
	        	//$("#rule_list tbody tr").remove();
	        	public_html_list_rule_model_table.fnDestroy();
		}
		var sectionUrl = $("div[name='sectionUrl'] input").val();
		public_html_list_rule_model_table = $("#public_html_list_rule_model").dataTable({
				"bProcessing" : true,//加载数据时候是否显示进度条
				//"bServerSide" : true,//是否从服务加载数据 
				"sAjaxSource" : "/news/newsPublicRankListRules?listDataType=2",//如果从服务器端加载数据,这个属性用于指定加载的路径
				"fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {

			        aoData.push( { "name": "sectionUrl", "value": sectionUrl } );      

			        oSettings.jqXHR = $.ajax( {
			            "dataType": 'json',
			            "type": "POST",
			            "url": sSource,
			            "data": aoData,
			            "success": fnCallback
			        } );
			    }, 
				"sPaginationType" : "full_numbers",
				"columns": [
		            {"data": function ( row, type, set ){
		            	return genHtmlByObject(row.name);
				    }},
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
	/**
	** 获取根据规则进行过滤的列表
	*/
	function getListPageInfo(){
		var url = "/news/getListPageInfo";
		$.ajax({
			url:url,
			type:'POST',
			data:buildFormData("#leftEditBox"),
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
			    	var title = data[i].title?data[i].title:nodata;
			    	var url = data[i].url;
			    	var realUrl = data[i].realUrl;
			    	var short_url = "";
			    	var time = data[i].time?data[i].time:nodata;
			    	var additionalAttribute = data[i].additionalAttribute?data[i].additionalAttribute:nodata;
			    	var additionalAttributeStr = "";
			    	if(url){
				    	if(url.length>80){
				    		short_url = url.substring(0,80)+"...";
					    }else{
					    	short_url = url;
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
				    	var titleStr = '  <div><b>标题</b>:<a target="blank_" href='+url+'>'+title+'</a></div>';
				    	if(realUrl){
				    		titleStr = '  <div><b>标题</b>:<a target="blank_" href='+realUrl+'>'+title+'</a></div>';
					    }
			    		strs+=titleStr+
						    ' <div style="width:100%;"><b>URL</b>:<span title="'+url+'">'+short_url+'</span></div>'+
						    ' <div><b>时间</b>:'+time+'</div>'+
						    ' <div><b>列表页额外字段</b>:'+additionalAttributeStr+'</div>'+
						    ' <div>'+
						    ' 	<a class="btn btn-primary btn-xs" to-url="'+url+'" href="javascript:void(0);" onclick="testContent(this)" style="display: block;width: 80px;margin:10px 0;">测试内容</a>'+
						    ' 	<span class="test-content-progress" style="display:none;">'+
							'     	<a href="javascript:void(0);" class="bg-color-white txt-color-teal test_content" ><i class="fa fa-gear fa-2x fa-spin"></i>'+
							'		</a>&nbsp;&nbsp;&nbsp;正在处理...'+
							'	</span>'+
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
		formData['newsGroupRuleRequirementId'] = $("#group-rule-boxs div[name='id'] input").val();
		formData['auditOpinion'] = $("#group-rule-boxs div[name='auditOpinion'] textarea").val();
		formData['groupId'] = $("#groupId").val();
		formData['groupName'] = $("#groupId option:selected").text();
		$.ajax({
			url:'/newsGroupRule/auditPass',
			dataType:'json',
			data:formData,
			success:function(d){
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
	
