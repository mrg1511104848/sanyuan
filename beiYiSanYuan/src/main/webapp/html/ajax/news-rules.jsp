<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.smart-form .tooltip{opacity:1;min-width:400px;background:none;}
.smart-form .tooltip-inner{min-width:388px;}
.dropdown-menu{min-width:0;width: 95px;}

</style>
<script src="/resources/js/news-common.js"></script>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title  txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 新闻
			<span>> 抓取规则 </span>
		</h1>
	</div>
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8" style="text-align:right;height: 45px;line-height: 62px;">
		<div class="btn-group dropdown" style="text-align:left;">
							<button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
								公共模板 <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" >
								<li>
									<a class=" public-html-list-rule-model" href="javascript:void(0);" >html列表</a>
								</li>
								<li>
									<a class=" public-html-text-rule-model" href="javascript:void(0);">html正文</a>
								</li>
								<li class="divider"></li>
								<li>
									<a class=" public-json-list-rule-model" href="javascript:void(0);">json列表</a>
								</li>
								<li>
									<a class=" public-json-text-rule-model" href="javascript:void(0);">json正文</a>
								</li>
							</ul>
		</div>
		<!-- 
		<a class=" public-html-list-rule-model underline" href="javascript:void(0);" >html列表模板</a>
		<a class=" public-json-list-rule-model underline" href="javascript:void(0);">json列表模板</a>
		<a class=" public-html-text-rule-model underline" href="javascript:void(0);">html正文模板</a>
		<a href="javascript:void(0);" class=" public-json-text-rule-model underline">json正文模板</a>
		 -->
		<a href="javascript:void(0);" class=" look-user-rules underline" style="display:none;" params="">查看用户规则</a>
		 
		<!-- 
		<a class="btn btn-warning btn-lg public-html-list-rule-model" href="javascript:void(0);" >html列表模板</a>
		<a class="btn btn-warning btn-lg public-json-list-rule-model" href="javascript:void(0);">json列表模板</a>
		<a class="btn btn-warning btn-lg public-html-text-rule-model" href="javascript:void(0);">html正文模板</a>
		<a href="javascript:void(0);" class="btn btn-warning btn-lg public-json-text-rule-model">json正文模板</a>
		<a href="javascript:void(0);" class="btn btn-warning btn-lg look-user-rules" params="">查看用户规则</a>
		 -->
	</div>
</div>

<!-- widget grid -->
<section id="widget-grid" class="">

<!-- row -->
<div class="row">
	<!-- 这是站点表格 -->
	<article class="col-sm-12 col-md-12 col-lg-12">
		<div class="jarviswidget jarviswidget-color-darken"
			data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-custombutton="false" data-widget-sortable="false">
			<header>
			<span class="widget-icon"> <i class="fa fa-table"></i> </span>
			<h2>
				站点列表
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
	
					<table id="site_list"
						class="table table-striped table-bordered table-hover smart-form has-tickbox" 
						width="100%">
						<thead>
							<tr>
								<th>
									<label class="checkbox">
										<input type="checkbox"  id="all_sites">
										<i></i>
									</label>
								</th>
								<th>
									
									站点名称
								</th>
								<th>
									URL
								</th>
								<th>
									用户对应规则数量
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
    
	<!-- 这是规则表格 -->
	<article class="col-sm-12 col-md-12 col-lg-8" id="rule-boxs" style="display:none;">
		<div class="jarviswidget jarviswidget-color-darken col-sm-12 col-lg-12" id="wid-id-rule" class="
			data-widget-editbutton="false" data-widget-colorbutton="false" style="width:100%;">
			<!-- widget div-->
			<div style="width:100%;">
	
				<!-- widget edit box -->
				<div class="jarviswidget-editbox">
					<!-- This area used as dropdown edit box -->
	
				</div>
				<!-- end widget edit box -->
	
				<!-- widget content -->
				<div class="widget-body no-padding">
					<table id="rule_list"
						class="table table-striped table-bordered table-condensed table-hover smart-form has-tickbox" width="100%">
						<thead style="width:100%;">
							<tr>
								<!-- <th><input type="checkbox" >测试选项</th> -->
								<th>
									<label class="checkbox">
										<input type="checkbox"  id="all_rules">
										<i></i>
									</label>
								</th>
								<th>
									版块名称
								</th>
								<th>
									版块URL
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
	
	<!-- 这里是公共json列表模板表格 -->
	<article class="col-sm-12 col-md-12 col-lg-8" id="public-json-list-rule-model-boxs" style="display:none;">
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
					<table id="public_json_list_rule_model"
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
	<!-- 这里是公共正文模板表格 -->
	<article class="col-sm-12 col-md-12 col-lg-8" id="public-json-text-rule-model-boxs" style="display:none;">
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
					<table id="public_json_text_rule_model"
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
	
	
	<!-- 这里用户规则表格 -->
	<article class="col-sm-12 col-md-12 col-lg-8" id="user-rule-boxs" style="display:none;">
		<!-- Widget ID (each widget will need unique ID)-->
		<div class="jarviswidget jarviswidget-color-darken col-sm-12 col-lg-12" id="wid-id-user-rule" class="
			data-widget-editbutton="false" data-widget-colorbutton="false" style="width:100%;margin:0;">
			<!-- 
			<header>
			<span class="widget-icon"> <i class="fa fa-table"></i> </span>
			<h2>
				子版块列表
			</h2>
	
			</header>
	 -->
			<!-- widget div-->
			<div style="width:100%;">
	
				<!-- widget edit box -->
				<div class="jarviswidget-editbox">
					<!-- This area used as dropdown edit box -->
	
				</div>
				<!-- end widget edit box -->
	
				<!-- widget content -->
				<div class="widget-body no-padding">
					<table id="user_rule_list"
						class="table table-striped table-bordered table-condensed table-hover" width="100%">
						<thead style="width:100%;">
							<tr>
								<!-- <th><input type="checkbox" >测试选项</th> -->
								<th>
									用户名
								</th>
								<th>
									任务名
								</th>
								<th>
									站点名称
								</th>
								<th>
									版块名称
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
</div>
<!-- end row -->

<!-- end row -->

</section>
<!-- end widget grid -->
<div id="rule_dialog_div" class="row" style="display:none;"></div>
<div id="site_dialog_div" class="row" style="display:none;" style="width:200px;"></div>
<div id="group_dialog_div" style="display:none;" style="width:200px;"></div>
<div id="public_html_list_rule_dialog_div" class="row" style="display:none;"></div>
<div id="public_json_list_rule_dialog_div" class="row" style="display:none;"></div>
<div id="public_html_text_rule_dialog_div" class="row" style="display:none;"></div>
<div id="public_json_text_rule_dialog_div" class="row" style="display:none;"></div>
<script type="text/javascript">
 	//初始化加载一些参数
	pageSetUp();
	
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	// Needed if you are rendering multiple tables in ajax version
	//var tableDestroyer = [];
	//根据规则创建参数------开始----------------------------
	
	function buildFormData2(){
		$("#rule_dialog_div").html("");
		$("#site_dialog_div").html("");
		$("#public_html_list_rule_dialog_div").html("");
		$("#public_json_list_rule_dialog_div").html("");
		$("#public_html_text_rule_dialog_div").html("");
		$("#public_json_text_rule_dialog_div").html("");
		var listDataType = $("div[name='listDataType']").length;
		//console.log("listDataTypeLength"+listDataType);
		var formData = {};
		var len = $(".aui_content").length;
		$("div.form-group").each(function(){
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
	
	
	//根据规则创建参数------开始----------------------------
	function buildFormData(){
		$("#rule_dialog_div").html("");
		$("#site_dialog_div").html("");
		$("#public_html_list_rule_dialog_div").html("");
		$("#public_json_list_rule_dialog_div").html("");
		$("#public_html_text_rule_dialog_div").html("");
		$("#public_json_text_rule_dialog_div").html("");
		var listDataType = $("div[name='listDataType']").length;
		//console.log("listDataTypeLength"+listDataType);
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
		return formData;
	};
	//根据规则创建参数------结束----------------------------
	
	
	
	//根据map创建内容------结束----------------------------
	
	var rule_table = null;
	var user_rule_table = null;
	var news_group_table = null;
	var public_html_list_rule_model_table = null;
	var public_json_list_rule_model_table = null;
	var public_html_text_rule_model_table = null;
	var public_json_text_rule_model_table = null;
	
	
	/*
	function loadPublicHtmlListRuleModelOnlySelect(){
		commonLoadPublicHtmlListRuleModelTable(true);
	}*/
	
	
	function loadPublicJsonListRuleModel(){
		commonLoadPublicJsonListRuleModelTable();
	}
	function loadPublicJsonListRuleModelOnlySelect(){
		commonLoadPublicJsonListRuleModelTable(true);
	}
	
	
	function loadPublicHtmlTextRuleModel(){	
		commonLoadPublicHtmlTextRuleModelTable();
	}
	function loadPublicHtmlTextRuleModelOnlySelect(){	
		commonLoadPublicHtmlTextRuleModelTable(true);
	}
	
	function loadPublicJsonTextRuleModel(){	
		commonLoadPublicJsonTextRuleModelTable();
	}
	function loadPublicJsonTextRuleModelOnlySelect(){	
		commonLoadPublicJsonTextRuleModelTable(true);
	}
	var public_html_list_rule_model_dialog;
	var public_html_text_rule_model_dialog;
	var public_json_list_rule_model_dialog;
	var public_json_text_rule_model_dialog;
	// pagefunction	
	var pagefunction = function() {
		$("a.public-html-list-rule-model").click(function(){//公共html列表模板
			loadingShow();
			loadPublicHtmlListRuleModel();
			public_html_list_rule_model_dialog = window.top.art.dialog({
				title: "公共列表模板列表",
				content:  $("#public-html-list-rule-model-boxs div:eq(0)")[0],
				width:"900px",
				padding: '0px 0px',
				lock:true
			});
			public_html_list_rule_model_dialog.hide();
			$(".aui_content").css("width","100%");
		});
		$("a.public-json-list-rule-model").click(function(){//公共json列表模板
			loadingShow();
			loadPublicJsonListRuleModel();
			public_json_list_rule_model_dialog = window.top.art.dialog({
				title: "公共列表模板列表",
				content:  $("#public-json-list-rule-model-boxs div:eq(0)")[0],
				width:"900px",
				padding: '0px 0px',
				lock:true
			});
			public_json_list_rule_model_dialog.hide();
			$(".aui_content").css("width","100%");
		});
		$("a.public-html-text-rule-model").click(function(){//公共正文模板
			loadingShow();
			loadPublicHtmlTextRuleModel();
			public_html_text_rule_model_dialog = window.top.art.dialog({
				title: "公共正文模板列表",
				content:  $("#public-html-text-rule-model-boxs div:eq(0)")[0],
				width:"900px",
				padding: '0px 0px',
				lock:true
			});
			public_html_text_rule_model_dialog.hide();
			$(".aui_content").css("width","100%");
		});
		$("a.public-json-text-rule-model").click(function(){//公共正文模板
			loadingShow();
			loadPublicJsonTextRuleModel();
			public_json_text_rule_model_dialog = window.top.art.dialog({
				title: "公共正文模板列表",
				content:  $("#public-json-text-rule-model-boxs div:eq(0)")[0],
				width:"900px",
				padding: '0px 0px',
				lock:true
			});
			public_json_text_rule_model_dialog.hide();
			$(".aui_content").css("width","100%");
		});
		$("a.look-user-rules").click(function(){
			var params = $(this).attr("params");
			loadUserRuleTable(params);
			var dialog = window.top.art.dialog({
				title: "用户对应规则数量",
				content:  $("#user-rule-boxs div:eq(0)")[0],
				width:"900px",
				padding: '0px 0px',
				lock:true
			});
			$("#wid-id-user-rule [role=content],#user_rule_list_wrapper .dt-toolbar").css("border","none");
			$(".aui_content").css("width","100%");
		});
		//console.log("cleared");
		//待优化。。。
		$("#all_sites").click(function(){
			if($(this).is(':checked')){
				$("input[name='sites']").each(function(){
					$(this)[0].checked = true;
				})
			}else{
				$("input[name='sites']").each(function(){
					$(this)[0].checked = false;
				})
			}
		});
		$("#all_rules").click(function(){
			if($(this).is(':checked')){
				$("input[name='rules']").each(function(){
					$(this)[0].checked = true;
				})
			}else{
				$("input[name='rules']").each(function(){
					$(this)[0].checked = false;
				})
			}
		});
		
		loadSiteTable();
		$('#site_list tbody').on( 'click', 'button.lookDetail', function () {
			loadingShow();
		   	var site_id = $(this).attr("site_id");
			$('#site_dialog_div').load("news/toSiteDialog?id="+site_id,function(){
			});
			loadEditSiteDialog();
			$('#site_dialog_div').html("");
		});
		$('#site_list tbody').on( 'click', 'button.lookChild', function () {
			if($("#all_rules").is(':checked')){$("#all_rules")[0].checked = false;};
	        var data = site_table.fnGetData($(this).parents('tr'));
		    var dialog = window.top.art.dialog({
					    title: "子版块列表  - "+data.name+" - "+data.url,
					    content: $("#rule-boxs #wid-id-rule")[0],
					    width:"850px",
					    padding: '0px 0px',
					    lock:true
					});
			loadingShow();
			dialog.hide();
			loadRuleTable(data,dialog);
			$(".aui_content").css("width","100%");
	    });
	   
	    function changeIconClassByReturnCode(site_child_name_ele,code){
	    	switch(code){
			   case "0" ://通过
			    	site_child_name_ele.attr("class","badge bg-color-greenLight");
			   break;
			   case "1" ://未能正确得到HTML,请检查版块URL是否有误
			    	site_child_name_ele.attr("class","badge bg-color-red");
			   break;
			   case "2" ://列表循环域为空
			    	site_child_name_ele.attr("class","badge bg-color-greenDark");
			   break;
			   case "3" ://列表循环域填写有误或不合法
			    	site_child_name_ele.attr("class","badge bg-color-purple");
			   break;
			   case "4" ://某些属性未填充,可能解析器填写有误
			    	site_child_name_ele.attr("class","badge bg-color-pink");
			   break;
			}
	    }
	    
		
		
		$('#site_list tbody').on( 'click', 'button.saveToUserRule', function () {
			$("#group_dialog_div").html("");
		   	//hehe
		   	var idx = $(this).index("button.saveToUserRule");
		   	$.ajax({
			   	url:"news/getAllGroupList.html",
			   	success:function(data){
				   	data = eval('('+data+')');
				   	for(var i = 0 ; i < data.length; i++){
					   	var name = data[i].name;
					   	var id =  data[i].id;
				   		var btn = '<a class="btn btn-primary add_group_site_rules" onclick="add_group_site_rules('+idx+',this)" group_id="'+id+'" group_name="'+name+'" style="margin:5px;" href="javascript:void(0);">'+name+'</a>';
				   		$("#group_dialog_div").append(btn);
					}
			   	}
			});
			
		   	//$('#group_dialog_div').load();
		   	var dialog = window.top.art.dialog({
				title: "公共正文模板列表",
				content:  $("#group_dialog_div")[0],
				width:"400px",
				padding: '0px 0px',
				lock:true
			});
			$(".aui_main").css("text-align","left");
		});
		
		$('#site_list tbody').on( 'click', 'button.deleteToUserRule', function () {
		   	var site_id = $(this).attr("site_id");
		   	var url = "/newsGroupRule/deleteNewsGroupRulesOfSite";
		   	var data = {siteId:site_id};
		   	var ele = $(this);
		   	var type = "POST";
		   	$.ajax({
		   		url:url,
		   		data:data,
		   		type:type,
		   		beforeSend:function(){
					//这里是开始执行方法，显示效果
					$(ele).attr("disabled","disabled");
					$(ele).find("i").attr("class","fa fa-gear fa-1x fa-spin")
				},
				complete:function(){
					//方法执行完毕，效果自己可以关闭，或者隐藏效果
					$(ele).removeAttr("disabled");
					$(ele).find("i").attr("class","fa  fa-chain-broken");
				},
		   		success:function(data){
		   			data = eval('('+data+')');
		   			if(data.result){
		   				//ggg
		   				site_table.fnDraw();
		   			}
		   		},
		   		error:function(){}
		   	});
		});
		
		/*
		 * CONVERT DIALOG TITLE TO HTML
		 * REF: http://stackoverflow.com/questions/14488774/using-html-in-a-dialogs-title-in-jquery-ui-1-10
		 */
		$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
			_title : function(title) {
				if (!this.options.title) {
					title.html("&#160;");
				} else {
					title.html(this.options.title);
				}
			}
		}));

	};
	function delRule(ele){
		var dialog = art.dialog({
					id:"rule_del_dialog",
				    title: '删除确认框',
				    content: "确认要删除吗? <div style='display:none;'><input name='del_id' id='rule_del_id'/></div>",
				    padding: '0px 0px',
				    lock:true,
				    button:[{
				    	name:"确认",
				    	callback:function(){
				    		var url = "news/deleteRule";
							var id = $('#rule_del_id').val();
							var data= {"id":id};
							$.ajax({
								url:url,
								data:data,
								type:"POST",
								success:function(data){
									if(data){
										//aaaaaaaa
										rule_table.fnDraw();//重新加载数据
									}
								}
							})
							MessageBoxShow('删除成功!',true);
							
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
		var rule_id = $(ele).attr("rule_id");
		$("#rule_del_id").val(rule_id);
	}
	function delAllOfSite(ele){
		var dialog = art.dialog({
					id:"rule_dialog",
				    title: '删除确认框',
				    width: 'auto',    // 内容宽度
	 				height: 'auto',    // 内容高度
				    content: "<div style='padding:10px;'>确认要删除吗?<br/>(<font style='color:red;'>警告:此删除操作会导致相关联的一切信息永久丢失!</font>) <div style='display:none;'><input name='del_id' id='site_allrule_del_id'/></div></div>",
				    padding: '0px 0px',
				    lock:true,
				    button:[{
				    	name:"确认",
				    	callback:function(){
					    	var url = "news/deleteSite";
							var id = $('#site_allrule_del_id').val();
							var data= {"id":id};
							$.ajax({
								url:url,
								data:data,
								type:"POST",
								success:function(data){
									if(data){
										
		            					site_table.fnDraw(); //重新加载数据
									}
								}
							})
							MessageBoxShow('删除成功!',true);
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
		var site_id = $(ele).attr("site_id");
		$("#site_allrule_del_id").val(site_id);
	}
	function saveNewRule(){
		var ipt_id = $("div[name='id'] input");
		ipt_id.val(""); //新增id置为""
		$.ajax({
			type: "post",
			url: "/news/saveRule",
			data: buildFormData2(),
			async: false,
			success: function(data){
				data = eval('('+data+')');
				var id  = data.id;
				var url  = data.url;
				$("div[name='id'] input").attr("value",id);
				$("div[name='id'] input").val(id);
				rule_table.fnDraw();

				saveImage(id,url);
			}
		});
		return ipt_id;
	}
	function loadEditRuleDialog(type){//1 : edit ,2 : add
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
				    content: $("#rule_dialog_div").html(),
				    follow: document.getElementById('btn2'),
				    padding: '0px 0px',
				    lock:true,
				    button:[{
				    	name:'开启更新任务',
				    	callback:function(){
							saveFatchListToDBRightNow(1);
							return false;
						}
				    },{
				    	name:'测试第一页',
				    	callback:function(){
							getListPageInfo(1);
							return false;
						}
				    },{
				    	name:'测试全部页',
				    	callback:function(){
							getListPageInfo(0);
							return false;
						}
				    },{
				    	name:'保存为新模块<i class="hideflag"></i>',
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
				    	name:'更新<i class="hideflag"></i>',
				    	callback:function(){
				    		updateToRule();
							return false;
				    	}
				    },{
				    	name:"<i class='fa  fa-play'></i>&nbsp; 实时入库",
				    	callback:function(){
				    		saveFatchListToDBRightNow();
				    		return false;
				    	}
				    }],
				    init: function () {
					    var isAdmin = '${currentUser.isAdmin}';
					    if(isAdmin==0) $(".hideflag").parent().hide();
				    	changeArtdialogButtonCss();
				    	getNewsUpdateTaskState();//看当前更新任务是否执行完毕
				    }
			});
		
		if(type&&type==2){
			$(".aui_buttons button:eq(4)").hide();
		}
		$(".aui_content").css("width","100%");
	}
	/**
	* //看当前更新任务是否执行完毕
	*/
	function getNewsUpdateTaskState(){
		var ruleId = $("div[name='id'] input").val();
		ajax_('/news/getNewsUpdateTask.html',{id:ruleId},'getNewsUpdateTaskStateBack');
	}
	function getNewsUpdateTaskStateBack(d){
		if(d.newsUpdateTask){
			$(".aui_buttons button:eq(0)").attr("disabled",true);
		}
	}
	/**
	** 实时入库
	*/
	function saveFatchListToDBRightNow(isUpdate){
		var ruleId = $("div[name='id'] input").val();
		if(ruleId==""){
			ruleId = saveNewRule();
		}
		saveFatchListToDB(".aui_buttons button:eq("+($(".aui_buttons button").length-1)+")",ruleId,isUpdate);	
	}
	
	function ruleDetail(id){
		$(".fetch-content").html("");
		loadingShow();
		$('#rule_dialog_div').load("news/toRuleDialog?id="+id,function(){
			loadingHide();
			loadEditRuleDialog();
			$('#rule_dialog_div').html("");
			getListPageInfo(1);
		});
		return false;
	}
	//列表事件--start
	function toAddPublicListRuleModel(type){
		$('#public_'+type+'_list_rule_dialog_div').load("/news/toPublicListRuleDialog.html?type="+type,function(){
			var dialog = art.dialog({
				title: '公共列表模板编辑',
				width: 'auto',    // 内容宽度
	 			height: 'auto',    // 内容高度
				content: $("#public_"+type+"_list_rule_dialog_div").html(),
				padding: '0px 0px',
				lock:true,
				button:[{
					  name:"保存",
					  callback:function(){
					  	savePublicListRuleModel(type,dialog);
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
		$('#public_'+type+'_list_rule_dialog_div').html("");
	}
	function checkForm(){
		var page = $("div[name='page'] input").val();
		var result = /^\d+$/g.exec(page);
		if(!result&&page!=-1){
			MessageBoxShow('抓取页数只能填写数字!');
			//art.dialog.tips('抓取页数只能填写数字!');
			return false;
		}
		return true;
	}
	function savePublicListRuleModel(type,dialog){
		if(!checkForm()){
			return false;
		}
		
		var url = "/news/saveNewsPublicListRule.html";
		$.ajax({
			url:url,
			type:'POST',
			data:buildFormData(),
			beforeSend:function(){
				//这里是开始执行方法，显示效果
			},
			complete:function(){
				//方法执行完毕，效果自己可以关闭，或者隐藏效果
			},
			success:function(data){
				if(type=="html"){
					public_html_list_rule_model_table.DataTable().ajax.reload();
				}else{
					public_json_list_rule_model_table.DataTable().ajax.reload();
				}
				MessageBoxShow('保存成功!',true);
				dialog.close();
			}
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
	
	function updateToRule(){
			var r = false;
			$.ajax({
				type: "post",
				url: "/news/saveRule",
				async:true,
				data: buildFormData2(),
				success: function(data){
					r = true;
					data = eval('('+data+')');
					if(data.result){
						var id = data.id;
						var url = data.url;
						$("div[name='id'] input").attr("value",data.id);
						$("div[name='id'] input").val(data.id);
						MessageBoxShow('保存成功!',true);
						//art.dialog.tips('更新成功!');
		    		 	rule_table.fnDraw();
		    		 	saveImage(id,url);
					}else{
						MessageBoxShow('保存失败!',true);
					}
	    		 	

				}
			});
			return r;
	}
	function editPublicListRuleModel(ele,type){
		var list_model_id = $(ele).attr("list_model_id");
		$('#public_'+type+'_list_rule_dialog_div').load("/news/toPublicListRuleDialog.html?id="+list_model_id+"&type="+type,function(){
		var dialog = art.dialog({
			title: '公共'+type+'列表模板编辑',
			width: '600px',    // 内容宽度
		 	height: '500px',    // 内容高度
			content: $("#public_"+type+"_list_rule_dialog_div").html(),
			padding: '0px 0px',
			lock:true,
			button:[{
				 name:"保存",
				 callback:function(){
				savePublicListRuleModel(type,dialog);
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
		$('#public_'+type+'_list_rule_dialog_div').html("");
		
	}
	function delPublicListRuleModel(ele,type){
		var dialog = art.dialog({
				    title: '删除确认框',
				    width: 'auto',    // 内容宽度
	 				height: 'auto',    // 内容高度
				    content: "确认要删除吗? <div style='display:none;'><input name='del_id' id='public_html_list_rule_model_del_id'/></div>",
				    padding: '0px 0px',
				    lock:true,
				    button:[{
				    	name:"确认",
				    	callback:function(){
				    		var url = "news/deleteNewsPublicListRule";
							var id = $('#public_html_list_rule_model_del_id').val();
							var data= {"id":id};
							$.ajax({
								url:url,
								data:data,
								type:"POST",
								success:function(data){
									if(data=="true"){
										if(type=="html"){
											var del_tr = $(ele).parents("tr:eq(0)");
											public_html_list_rule_model_table.fnDeleteRow(del_tr);
										}else{
											var del_tr = $(ele).parents("tr:eq(0)");
											public_json_list_rule_model_table.fnDeleteRow(del_tr);
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
		var list_model_id = $(ele).attr("list_model_id");
		$("#public_html_list_rule_model_del_id").val(list_model_id);
	}
	//列表事件--end
	//正文事件--start
	function toAddPublicTextRuleModel(type){
		$('#public_'+type+'_text_rule_dialog_div').load("/news/toPublicTextRuleDialog.html?type="+type,function(){
			var dialog = art.dialog({
				title: '公共列表模板编辑',
				width: 'auto',    // 内容宽度
	 			height: 'auto',    // 内容高度
				content: $("#public_"+type+"_text_rule_dialog_div").html(),
				padding: '0px 0px',
				lock:true,
				button:[{
					  name:"保存",
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
		$("#public_"+type+"_text_rule_dialog_div").html("")
	}
	function savePublicTextRuleModel(type,dialog){
		
		var url = "/news/saveNewsPublicTextRule.html";
		$.ajax({
			url:url,
			type:'POST',
			data:buildFormData(),
			beforeSend:function(){
				//这里是开始执行方法，显示效果
			},
			complete:function(){
				//方法执行完毕，效果自己可以关闭，或者隐藏效果
			},
			success:function(data){
				if(type=="html"){
					//需要
					public_html_text_rule_model_table.DataTable().ajax.reload();
				}else{
					public_json_text_rule_model_table.DataTable().ajax.reload();
				}
				dialog.close();
			}
		});
	}
	
	/**
	** 继承正文模板
	*/
	function extendsPublicTextRuleModel(ele){
		var id = $("div[name='id'] input").attr("value");
		//if(!id) {art.dialog.tips('请保存后再继承，或直接使用复制!');return false;}
		var text_model_id = $(ele).attr("text_model_id");
		var text_model_name = $(ele).attr("text_model_name");
		$("#mainFrm div[name='publicTextRuleId'] input").val(text_model_id);
		//var r = updateToRule();
		//if(r){
			$("#mainFrm a.extends_flag:eq(1)").attr("title","继承模板【"+text_model_name+"】,点击取消继承");
			$("#mainFrm a.extends_flag:eq(1)").attr("flag_title","继承模板【"+text_model_name+"】");
			$("#mainFrm a.extends_flag:eq(1)").css("color","#3276b1").css("text-decoration","none");
			//art.dialog.tips('继承成功!请记得保存哦');
			MessageBoxShow('继承成功!请记得保存哦');
		//}
		var url = "/news/editNewsPublicTextRule.html";
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
				commonCopyPublicTextRuleModel(data,"extends");
			}
		});
	}
	function editPublicTextRuleModel(ele,type){
		var text_model_id = $(ele).attr("text_model_id");
		$('#public_'+type+'_text_rule_dialog_div').load("/news/toPublicTextRuleDialog.html?id="+text_model_id+"&type="+type,function(){
			var dialog = art.dialog({
				title: '公共'+type+'正文模板编辑',
				width: 'auto',    // 内容宽度
	 			height: 'auto',    // 内容高度
				content: $("#public_"+type+"_text_rule_dialog_div").html(),
				padding: '0px 0px',
				lock:true,
				button:[{
					  name:"保存",
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
				    		var url = "news/deleteNewsPublicTextRule";
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
										}else{
											var del_tr = $(ele).parents("tr:eq(0)");
											public_json_text_rule_model_table.fnDeleteRow(del_tr);
											//public_json_text_rule_model_table.fnDraw();//重新加载数据
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
	function deleteRow(ele){
		$(ele).parent().parent().remove();
	}
	function showOther(ele){
		$(ele).parent().next().show();
	}
	
	function commonLoadPublicJsonTextRuleModelTable(isCopyOrExtends){//isSelect:是否是将要 复制或者继承
		if(public_json_text_rule_model_table!=null){
	        	//$("#rule_list tbody tr").remove();
	        public_json_text_rule_model_table.fnDestroy();
		}
		var sectionUrl = $("div[name='sectionUrl'] input").val();
		var listListKey = $("div[name='listListKey'] input").val();
		var listUrlKey = $("div[name='listUrlKey'] input").val();
		var listReplaceStr = $("div[name='listReplaceStr'] input").val();
		var listUrlParserMapKey = $("div[name='listUrlParserMap'] input:eq(0)").val();
		var listUrlParserMapValue = $("div[name='listUrlParserMap'] input:eq(1)").val();
		var tmpListUrlParserMapKey = "listUrlParserMap["+listUrlParserMapKey+"]";
		//公共正文模板
	    public_json_text_rule_model_table = $("#public_json_text_rule_model").dataTable({
			"bProcessing" : true,//加载数据时候是否显示进度条
			//"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/news/newsPublicRankTextRules?textDataType=1&"+tmpListUrlParserMapKey+"="+listUrlParserMapValue,//如果从服务器端加载数据,这个属性用于指定加载的路径 
			"fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {
		        var aoData = { "listListKey":listListKey,"sectionUrl":sectionUrl,"listUrlKey":listUrlKey,"listReplaceStr":listReplaceStr};      
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
	            {"sWidth" : "60px","data": function ( row, type, set ){
	            	if(isCopyOrExtends){
	            		return "<button class='btn btn-xs btn-default' text_model_id='"+row.id+"' title='点击复制'   onclick='copyPublicTextRuleModel(this)'><i class='glyphicon glyphicon-book'></i></button>&nbsp&nbsp"+
		            				"<button class='btn btn-xs btn-default' text_model_id='"+row.id+"' text_model_name='"+row.name+"' title='点击继承'  onclick='extendsPublicTextRuleModel(this)'><i class='glyphicon glyphicon-flag'></i></button>&nbsp&nbsp";
	            	}else{
	            		return "<button class='btn btn-xs btn-default' text_model_id='"+row.id+"' title='编辑'  onclick=\"editPublicTextRuleModel(this,'json')\"><i class='fa fa-pencil'></i></button>&nbsp&nbsp"+
				        	   "<button class='btn btn-xs btn-default'  title='删除' text_model_id='"+row.id+"' onclick=\"delPublicTextRuleModel(this,'json')\"><i class='fa fa-times'></i></button>";
	            	}
			    }}
			],
			"oLanguage" : common_data_table_config.oLanguage,

			"fnInitComplete": function(oSettings, json) {
				loadingHide();
	    		dialogCenterScreen(public_json_text_rule_model_dialog);
				if(!isCopyOrExtends){
					var button_html = '	<a class="btn btn-primary" id="add_public_json_text_rule_model" onclick=\'toAddPublicTextRuleModel("json")\' style="float:right;" href="javascript:void(0);">添加公共正文模板</a>&nbsp;&nbsp;';
				    $("#public_json_text_rule_model_wrapper .dt-toolbar>div:eq(1)").append($(button_html)).css("padding-right",0);
	    			$("#public_json_text_rule_model_wrapper .dt-toolbar").addClass("padding_B5");
				}
			 },
			"sDom":common_data_table_config.searchSDom
	    });
	}
	
	function commonLoadPublicJsonListRuleModelTable(isCopyOrExtends){
		if(public_json_list_rule_model_table!=null){
	        	//$("#rule_list tbody tr").remove();
	       public_json_list_rule_model_table.fnDestroy();
		}
		var sectionUrl = $("div[name='sectionUrl'] input").val();
		public_json_list_rule_model_table = $("#public_json_list_rule_model").dataTable({
				"bProcessing" : true,//加载数据时候是否显示进度条
				//"bServerSide" : true,//是否从服务加载数据 
				"sAjaxSource" : "/news/newsPublicRankListRules?listDataType=1",//如果从服务器端加载数据,这个属性用于指定加载的路径 
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
		            {"sWidth" : "60px","data": function ( row, type, set ){
		            	if(isCopyOrExtends){//yes
		            		return "<button class='btn btn-xs btn-default' list_model_id='"+row.id+"' title='点击复制'   onclick='copyPublicListRuleModel(this)'><i class='glyphicon glyphicon-book'></i></button>&nbsp&nbsp"+
		            				"<button class='btn btn-xs btn-default' list_model_id='"+row.id+"' list_model_name='"+row.name+"' title='点击继承'  onclick='extendsPublicListRuleModel(this)'><i class='glyphicon glyphicon-flag'></i></button>&nbsp&nbsp";
		            	}else{
		            		return "<button class='btn btn-xs btn-default' list_model_id='"+row.id+"' title='编辑'  onclick=\"editPublicListRuleModel(this,'json')\"><i class='fa fa-pencil'></i></button>&nbsp&nbsp"+
					        	   "<button class='btn btn-xs btn-default'  title='删除' list_model_id='"+row.id+"' onclick=\"delPublicListRuleModel(this,'json')\"><i class='fa fa-times'></i></button>";
		            	}
		            		
				    }}
				],
				"oLanguage" : common_data_table_config.oLanguage,
				"fnInitComplete": function(oSettings, json) {
					loadingHide();
	    			dialogCenterScreen(public_json_list_rule_model_dialog);
					if(!isCopyOrExtends){
						var button_html = '	<a class="btn btn-primary" id="add_public_json_list_rule_model" onclick=\'toAddPublicListRuleModel("json")\' style="float:right;" href="javascript:void(0);">添加公共列表模板</a>&nbsp;&nbsp;';
						$("#public_json_list_rule_model_wrapper .dt-toolbar>div:eq(1)").append($(button_html)).css("padding-right",0);
	    				$("#public_json_list_rule_model_wrapper	 .dt-toolbar").addClass("padding_B5");
					}
				},
				"sDom":common_data_table_config.searchSDom
		    });
	}
	var site_table;
	function loadSiteTable(){
		if(site_table!=null){
        	site_table.fnDestroy();
		}
		
		site_table = $("#site_list").dataTable({
			"bProcessing" : true,//加载数据时候是否显示进度条
			"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/news/getSitePagedList",//如果从服务器端加载数据,这个属性用于指定加载的路径 
			"fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {
			//post防止某些浏览器下的编码问题
				var l_name = $("[name=l_name]").val();
				var l_url = $("input[name='l_url']").val();
				if(l_url) aoData+='&l_url='+l_url;
				if(l_name) aoData+='&l_name='+l_name;
		        oSettings.jqXHR = $.ajax( {
		            "dataType": 'json',
		            "type": "POST",
		            "url": sSource,
		            "data": aoData,
		            "success": fnCallback
		        } );
			},
			"sPaginationType" : "full_numbers",
			"sServerMethod":'post',
			"bSort":false,
			"columns": [
				{"data": function ( row, type, set ){
						var html_ = '<label class="checkbox">'+
										'<input type="checkbox" name="sites" value="'+row.id+'">'+
										'<i></i>'+
									'</label>';
						return html_;
			    }},
	            {"data": "name"},
	            {"data": function ( row, type, set ){
	            	var s_url = cut_str(row.url, 50,"...");
				        return '<a target="blank_" href="'+row.url+'" title="'+row.url+'">'+s_url+'</a>';
			    }},
			    {"data":function ( row, type, set ){
				        return '<a  href="javascript:;" site_id="'+row.id+'" title="查看拥有规则" onclick="loadFilteredUserRule(this)">'+row.newsGroupRuleCountForThisSite+'</a>';
			    }},
			    
	            {"sWidth" : "85px","data": function ( row, type, set ){
	            		var id = row.id;
	            		var isAdmin = '${currentUser.isAdmin}';
				        var btns = "<button class='lookChild btn btn-xs btn-default' title='查看子版块'><i class='fa  fa-search'></i></button>&nbsp";
				        if(isAdmin==1){
				         btns+="<button class='lookDetail btn btn-xs btn-default' site_id='"+id+"' title='编辑'><i class='fa fa-pencil'></i></button>&nbsp"+
				        	   "<button class='delAll btn btn-xs btn-default'  title='删除' site_id='"+id+"' onclick='delAllOfSite(this)'><i class='fa fa-times'></i></button>&nbsp";
				        }	   
				        	   
				        	   //"<button class='saveToUserRule btn btn-xs btn-default' site_id='"+id+"' title='加入该站点的所有用户拥有规则'><i class='fa  fa-chain'></i></button>&nbsp"+
				        	  // "<button class='deleteToUserRule btn btn-xs btn-default' site_id='"+id+"' title='删除该站点用户拥有的所有规则'><i class='fa  fa-chain-broken'></i></button>&nbsp";
				        return 	btns;   
			    }}
			],
			"oLanguage":common_data_table_config.oLanguage,
			"fnInitComplete": function(oSettings, json) {
				initSiteTableButton();
		     },
		     "sDom":common_data_table_config.sDom
	    });
	}
	function initSiteTableButton(){
		$("#site_list_wrapper .dt-toolbar div:eq(0)").empty();
		$("#site_list_wrapper .dt-toolbar div:eq(1)").empty();
		var s_zdmc_btn = '<input type="text" name="l_name" class="form-control ng-valid ng-dirty margin_R5" placeholder="站点名称">';
		var s_url_btn = '<input type="text" name="l_url" class="form-control ng-valid ng-dirty margin_R5" placeholder="URL">&nbsp;';
		var s_submit_btn = '<a class="btn btn-default" id="site_search">查询 </a>';
		$("#site_list_wrapper .dt-toolbar").addClass("padding_B5");
		$("#site_list_wrapper .dt-toolbar div:eq(0)").append($(s_zdmc_btn)).append($(s_url_btn)).append($(s_submit_btn));
		$("input[name='sites']").on('click',function(){
			var ck_rules_ele_len = $("input[name='sites']").length;
			var ckd_len = $("input[name='sites']:checked").length;
			if(ckd_len == ck_rules_ele_len){
				$("#all_sites")[0].checked = true;
			}else{
				$("#all_sites")[0].checked = false;
			}
		});
		var addSiteBtn = '	<a class="btn btn-primary margin_L5" id="add_site" style="float:right;" href="javascript:void(0);">添加站点</a>';
		var addUserRuleOfSiteBtn = '	<a class="btn btn-primary margin_L5" id="add_user_rules_of_site" style="float:right;" href="javascript:void(0);" title="添加所选站点下用户对应规则">添加用户对应规则</a>';
		var addUserGroup = '	<a class="btn btn-primary margin_L5" id="add_user_group" style="float:right;" href="javascript:void(0);" title="添加所选站点下用户对应规则">添加用户对应组</a>';    
		$("#site_list_length").css("float","left");
		$("#site_list_wrapper .dt-toolbar>div:eq(1) ").append($(addSiteBtn))
		//	.append($(addUserRuleOfSiteBtn)).append($(addUserGroup))
			.css("padding-right","0");
		
		//$("#site_list_wrapper .dt-toolbar>div:eq(1) ");
		$('#add_site').on( 'click',  function () {
			loadingShow();
		    $('#site_dialog_div').load("news/toSiteDialog");
		    loadEditSiteDialog();
		    $('#site_dialog_div').html("");
			return false;
		});
		//添加用户规则
		$('#add_user_rules_of_site').on( 'click',  function () {
			var ckd_len = $("input[name='sites']:checked").length;
			if(ckd_len==0){
				MessageBoxShow('请至少选择一项进行添加');
				//art.dialog.tips('请至少选择一项进行添加');
				return false;
			}
			//hehe
			$("#group_dialog_div").html("");
		   	//var idx = $(this).index("button.saveToUserRule");
		   	$.ajax({
			   	url:"news/getAllGroupList.html",
			   	success:function(data){
				   	data = eval('('+data+')');
				   	for(var i = 0 ; i < data.length; i++){
					   	var name = data[i].name;
					   	var id =  data[i].id;
				   		var btn = '<a class="btn btn-primary add_group_site_rules" onclick="addNewsGroupRulesForSite(this)" group_id="'+id+'" group_name="'+name+'" style="margin:5px;" href="javascript:void(0);">'+name+'</a>';
				   		$("#group_dialog_div").append(btn);
					}
			   	}
			});
			
		   	//$('#group_dialog_div').load();
		   	var dialog = window.top.art.dialog({
				title: "公共正文模板列表",
				content:  $("#group_dialog_div")[0],
				width:"400px",
				padding: '0px 0px',
				lock:true
			});
			$(".aui_main").css("text-align","left");
		});
		
		//用户对应组
		$("#add_user_group").click(function(){
			$('#group_dialog_div').html("");
			$('#group_dialog_div').load("news/toGroupDialog");
			loadEditGroupDialog();
		    $('#group_dialog_div').html("");
		});
		$("#site_search").click(function(){
			var url = "/news/getSitePagedList";
	    	//var l_name = $("input[name='l_name']").val();
	    	//var l_url = $("input[name='l_url']").val();
	    	//var params = {"l_name":l_name,"l_url":l_url};
	    	//url = addQueryParams(url,params);
	    	//site_table.fnSettings().sAjaxSource=url;
	    	site_table.fnDraw(); //重新加载数据
		});
	}
	function initRuleTableButton(data){
		var s_bkmc_btn = '<input type="text" name="l_section" class="form-control ng-valid ng-dirty margin_R5" placeholder="版块名称">';
		var s_url_btn = '<input type="text" name="l_sectionUrl" class="form-control ng-valid ng-dirty margin_R5" placeholder="URL">';
		var s_submit_btn = '<a class="btn btn-default" id="rule_search">查询 </a>';
			$("#rule_list_filter label").remove();
			$("#rule_list_wrapper .dt-toolbar>div:eq(0)").append($(s_bkmc_btn)).append($(s_url_btn)).append($(s_submit_btn));
			var btn_add_rule_html = '	<a class="btn btn-primary margin_L5" id="add_rule" style="float:right;" siteId='+data.id+' href="javascript:void(0);">添加规则</a>';
		    var btn_test_rule_html = '	<a class="btn btn-success margin_L5" id="test_rule" style="float:right;" siteId='+data.id+' href="javascript:void(0);">测试所选规则</a>';
		    var btn_add_user_rules = '	<a style="display:none" class="btn btn-primary margin_L5" id="btn_add_user_rules" style="float:right;" siteId='+data.id+' href="javascript:void(0);" title="添加所选规则">添加所选规则</a>';
		    $("#rule_list_wrapper .dt-toolbar>div:eq(1)").append($(btn_add_rule_html)).append($(btn_add_user_rules)).append($(btn_test_rule_html)).css("padding-right","0");
		    $("#rule_list_wrapper .dt-toolbar").addClass("padding_B5");
			$('#add_rule').on("click",  function () {
			    	var siteId = $(this).attr("siteId");
			    	$("#rule_list_fieldset").hide();
			    	$('#rule_dialog_div').load("news/toRuleDialog?siteId="+siteId,function(){
						loadEditRuleDialog(2);
					});
					$('#rule_dialog_div').html("");
					return false;
			});
			//待优化
			$('#test_rule').on("click",  function () {	
				var ckd_len = $("input[name='rules']:checked").length;
				if(ckd_len==0){
					MessageBoxShow('请至少选择一项进行添加');
					//art.dialog.tips('请至少选择一项进行测试');
				   	return false;
				}
				$("table#rule_list tr").each(function(){
					var ck = $(this).find(":checkbox:checked");
					if(ck.length){
						$(this).find(".span-tip-box:eq(0)").css("display","inline-block");
						$(this).find(".span-tip-box:eq(0)").attr("data-original-title","正在加载...");
					}
				});
				var rule_testing_ids = "";
			    $("input[name='rules']").each(function(){
			    	if($(this).is(":checked")){
			    		rule_testing_ids+=$(this).val()+",";
			    	}
			    });
			    if(rule_testing_ids.indexOf(",")>-1) rule_testing_ids = rule_testing_ids.substring(0,rule_testing_ids.length-1);
			   	var ruleIdArray = rule_testing_ids.split(",");
			    testRule(ruleIdArray,0);
			   
				return false;
			});
			$('#btn_add_user_rules').on("click",  function () {
				var ckd_len = $("input[name='rules']:checked").length;
				if(ckd_len==0){
					MessageBoxShow('请至少选择一项进行添加');
				//	art.dialog.tips('请至少选择一项进行添加');
				   	return false;
				}
				//hehe
				$("#group_dialog_div").html("");
			   	//var idx = $(this).index("button.saveToUserRule");
			   	$.ajax({
				   	url:"news/getAllGroupList.html",
				   	success:function(data){
					   	data = eval('('+data+')');
					   	for(var i = 0 ; i < data.length; i++){
						   	var name = data[i].name;
						   	var id =  data[i].id;
					   		var btn = '<a class="btn btn-primary add_group_site_rules" onclick="addNewsGroupRulesForRule(this)" group_id="'+id+'" group_name="'+name+'" style="margin:5px;" href="javascript:void(0);">'+name+'</a>';
					   		$("#group_dialog_div").append(btn);
						}
				   	}
				});
				
			   	//$('#group_dialog_div').load();
			   	var dialog = window.top.art.dialog({
					title: "公共正文模板列表",
					content:  $("#group_dialog_div")[0],
					width:"400px",
					padding: '0px 0px',
					lock:true
				});
				$(".aui_main").css("text-align","left");

				
				return false;
			});
			$("#rule_search").click(function(){
				var url = "/news/getRulePagedList";
		    	var l_section = $("input[name='l_section']").val();
		    	var l_sectionUrl = $("input[name='l_sectionUrl']").val();
		    	var site_id = $("#add_rule").attr("siteid");
		    	var params = {"eq_siteId":site_id,"l_section":l_section,"l_sectionUrl":l_sectionUrl};
		    	url = addQueryParams(url,params);
		    	rule_table.fnSettings().sAjaxSource=url;
		    	rule_table.fnDraw(); //重新加载数据
			});
			
	}
	function loadRuleTable(data,dialog){
		if(rule_table!=null){
	        	$("#rule_list tbody tr").remove();
	        	rule_table.fnDestroy();
		}
		rule_table = $("#rule_list").dataTable({
				"bProcessing" : true,//加载数据时候是否显示进度条
				"bServerSide" : true,//是否从服务加载数据 
				"sAjaxSource" : "/news/getRulePagedList"+"?timeStamp="+new Date().getTime()+"&eq_siteId="+data.id,//如果从服务器端加载数据,这个属性用于指定加载的路径 
				"sPaginationType" : "full_numbers",
				"bSort":false,
				"columns": [
					{"data": function ( row, type, set ){
						//如果用户拥有此规则，则添加背景色
						var newsGroupRuleFlagStr = "";
						if(row.newsGroupRuleFlag==true){
							newsGroupRuleFlagStr+='<span class="userRuleFlag" style="display:none;"></span>';
						}
						var html_ = newsGroupRuleFlagStr+
									'<label class="checkbox">'+
										'<input type="checkbox" name="rules" value="'+row.id+'">'+
										'<i></i>'+
									'</label>';
						return html_;
			        }},
		            {"data":  function ( row, type, set ){
		            	var tip_content ="<p>无数据 </p>  ";
		            	var tooltip = "<span class='badge bg-color-gray span-tip-box' rel='tooltip'  data-html='true' data-placement='top'  data-original-title='"+tip_content+"' style='width: 20px;height: 20px;display: none;'></span>";
		            	var section = cut_str(row.section, 30,"...");
				        return tooltip+section;
			        }},
		            {"data": function ( row, type, set ){
			        	var sectionUrl =  cut_str(row.sectionUrl, 70,"...");
				        return '<a target="blank_" href="'+row.sectionUrl+'">'+sectionUrl+'</a>';
			        }},
		            {"sWidth" : "85px","data": function ( row, type, set ){
		            	var isAdmin = '${currentUser.isAdmin}';
		            	var btns = "<button class=' btn btn-xs btn-default' onclick=\"ruleDetail('"+row.id+"');\" title=\"查看解析器\"><i class='fa  fa-search'></i></button>&nbsp;"+
		            	"<button class=' btn btn-xs btn-default' onclick=\"saveFatchListToDB(this,'"+row.id+"');\" title=\"实时入库\"><i class='fa  fa-play'></i></button>&nbsp;";
				        if(isAdmin==1){
				        	btns+="<button class='delAll btn btn-xs btn-default' title='删除' rule_id="+row.id+" onclick='delRule(this)'><i class='fa fa-times'></i></button>&nbsp;";
				        }
				        return btns;
			        }}//hehe
				],
				"oLanguage" : common_data_table_config.oLanguage,
				"fnInitComplete": function(oSettings, json) {
					$("input[name='rules']").on('click',function(){
						var ck_rules_ele_len = $("input[name='rules']").length;
						var ckd_len = $("input[name='rules']:checked").length;
						if(ckd_len == ck_rules_ele_len){
							$("#all_rules")[0].checked = true;
						}else{
							$("#all_rules")[0].checked = false;
						}
					})
					$("table#rule_list tr").each(function(){
						if($(this).find("span.userRuleFlag").length>0){
							$(this).find("td").css("background","#dff0d8");
						}
					});
					$("[rel=tooltip]").tooltip();
					loadingHide();
					dialogCenterScreen(dialog);
					//alert(main_left+"."+main_top);
			     },
			     "fnDrawCallback": function( oSettings ) {
				      $("table#rule_list tr").each(function(){
						if($(this).find("span.userRuleFlag").length>0){
							$(this).find("td").css("background","#dff0d8");
						}
					});
				 },
				//语法结构
			        /*
			            <> 表示一个闭合div
			            例：<> = <div></div>
			            
			            <"类名称"> 表示一个带类名称的闭合div
			            例：<"top"> = <div class="top"></div>
			            
			            l - 每行显示的记录数
			            f - 搜索框
			            t - 表格
			            i - 表格信息
			            p - 分页条
			            r - 加载时的进度条
			        */
			        "sDom": "<'dt-toolbar'<'col-xs-6 tools-bar'><'col-xs-6'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
		    });
		initRuleTableButton(data);
		
		
	}
	function loadUserRuleTable(params){
		if(user_rule_table!=null){
	       user_rule_table.fnDestroy();
		}
		user_rule_table = $("#user_rule_list").dataTable({
				"bProcessing" : true,//加载数据时候是否显示进度条
				"bServerSide" : true,//是否从服务加载数据 
				"sAjaxSource" : "/newsGroupRule/getNewsGroupRuleList"+"?timeStamp="+new Date().getTime()+params,//如果从服务器端加载数据,这个属性用于指定加载的路径 
				"sPaginationType" : "full_numbers",
				"bSort":false,
				"columns": [
					{"data": function ( row, type, set ){
						return row.userName;
			        }},
			        {"data": function ( row, type, set ){
						return row.groupName;
			        }},
		            {"data":  function ( row, type, set ){
		            	return '<a href="'+row.siteUrl+'">'+row.site+'</a>';
			        }},
		            {"data": function ( row, type, set ){
				       return '<a href="'+row.sectionUrl+'">'+row.section+'</a>';
			        }},
		            {"data": function ( row, type, set ){
				        return "<button class='delAll btn btn-xs btn-default' title='删除' rule_id="+row.ruleId+" group_id="+row.groupId+" onclick='deleteToUserRuleOfRule(this,2,1000)'><i class='fa fa-times'></i></button>&nbsp&nbsp";
			        }}
				],
				"oLanguage" : common_data_table_config.oLanguage,
				"fnInitComplete": function(oSettings, json) {
			     },
			     "fnDrawCallback": function( oSettings ) {
				 },
				//语法结构
			        /*
			            <> 表示一个闭合div
			            例：<> = <div></div>
			            
			            <"类名称"> 表示一个带类名称的闭合div
			            例：<"top"> = <div class="top"></div>
			            
			            l - 每行显示的记录数
			            f - 搜索框
			            t - 表格
			            i - 表格信息
			            p - 分页条
			            r - 加载时的进度条
			        */
				"sDom":'<"dt-toolbar"<"col-xs-12 col-sm-10"fr><"col-xs-12 col-sm-2"l>'+ 
					'"t"'+'<"dt-toolbar-footer"<p>> >'//
		    });
		initUserRuleTableButton();
	}
	function initUserRuleTableButton(){}
	function obj2str(o){
	   var r = [];
	   if(typeof o == "string" || o == null) {
	     return o;
	   }
	   if(typeof o == "object"){
	     if(!o.sort){
	       r[0]="{"
	       for(var i in o){
	         r[r.length]="<b>"+i.replace("W_","")+"</b>";
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
	function testRule(ruleIdArray,idx){
	    	var url = "/news/inspectValidity";
			$.ajax({
				url:url,
			    data:{"rule_id":ruleIdArray[idx]},
			    success:function(data){
			    	data = 	eval('('+data+')');

			    	var nodata = "无";
			    	var title = data.title?data.title:nodata;
			    	var url = data.url?data.url:nodata;
			    	var time = data.time?data.time:nodata;
			    	var content = data.content?data.content:nodata;
			    	var code = data.code;
			    	var msg = data.msg;
			    	var state_class= "badge bg-color-gray";
			    	if(content.length>30) content = content.substring(0,30);
			    	var site_child_name_ele;
			    	$("input[name='rules']").each(function(){
					    var rid = $(this).val();
					    if(ruleIdArray[idx]==rid){
					    	var h = $(this).parents("tr").html();
					    	site_child_name_ele = $(this).parents("tr:eq(0)").find("td:eq(1) span");
					    	return;
						}
					});
			    	
			    	//var site_child_name_ele = $("#rule_list tbody>tr:eq("+idx+") td:eq(1) span ");
			    	//console.log(code);
			    	switch(code){
			    		case "0" ://通过
			    			site_child_name_ele.attr("class","badge bg-color-greenLight span-tip-box");
			    			break;
			    		case "1" ://未能正确得到HTML,请检查版块URL是否有误
			    			site_child_name_ele.attr("class","badge bg-color-red  span-tip-box");
			    			break;
			    		case "2" ://列表循环域为空
			    			site_child_name_ele.attr("class","badge bg-color-greenDark  span-tip-box");
			    			break;
			    		case "3" ://列表循环域填写有误或不合法
			    			site_child_name_ele.attr("class","badge bg-color-purple span-tip-box ");
			    			break;
			    		case "4" ://某些属性未填充,可能解析器填写有误
			    			site_child_name_ele.attr("class","badge bg-color-pink  span-tip-box");
			    			break;
			    	}
					var tip_content ="<div style='text-align:left;'>"+
									"<p>标题:"+title+"</p>  "+
		            			     "<p>链接:"+url+"</p>  "+
		            				 "<p>时间:"+time+"</p> "+
		            				 "<p>内容:"+content+"</p> "+
		            				 "<p>状态:"+msg+"</p> </div> ";
					
					$(site_child_name_ele).attr("data-original-title",tip_content);
			    	//continue
			    	if(ruleIdArray.length<=idx+1){
			    		return;
			    	}
			    	idx++;
			    	testRule(ruleIdArray,idx);
			    },
			    error:function(data){
				    $("input[name='rules']").each(function(){
					    var rid = $(this).val();
					    if(ruleIdArray[idx]==rid){
					    	$(this).parents("tr:eq(0)").find("td:eq(1) span").attr("data-original-title","对不起，系统异常，加载失败");
					    	return;
						};
					});
				  	//continue
			    	if(ruleIdArray.length<=idx+1){
			    		return;
			    	}
			    	idx++;
			    	testRule(ruleIdArray,idx);
				}
			});
	};
	function addUserRulesOfSite(siteIdArray,idx,ele){
	    	//console.log(siteIdArray);
	    	var url = "/newsGroupRule/addNewsGroupRulesOfSite";

			var group_id = $(ele).attr("group_id");
			var group_name = $(ele).attr("group_name");

			$.ajax({
				url:url,
			    data:{"siteId":siteIdArray[idx],groupId:group_id,groupName:group_name},
			    success:function(data){
			    	data = 	eval('('+data+')');
			    	
			    	//continue
			    	if(siteIdArray.length<=idx+1){
			    		//gggggg
			    		MessageBoxShow('保存成功!',true);
			    		//art.dialog.tips('保存成功!');
			    		site_table.fnDraw();
			    		return;
			    	}
			    	idx++;
			    	addUserRulesOfSite(siteIdArray,idx,ele);
			    }
			});
	};
	function addUserRules(ruleIdArray,idx,ele){
		var url = "/newsGroupRule/addNewsGroupRules";
		var group_id = $(ele).attr("group_id");
		var group_name = $(ele).attr("group_name");

			$.ajax({
				url:url,
			    data:{"ruleId":ruleIdArray[idx],groupId:group_id,groupName:group_name},
			    success:function(data){
			    	data = 	eval('('+data+')');
			    	$("#rule_list tbody input[name='rules']").each(function(){
			    		if($(this).val()==ruleIdArray[idx]){
			    			$(this).parents("#rule_list tr").find("td").css("background","#dff0d8");
			    		}
			    	});
			    	//continue
			    	if(ruleIdArray.length<=idx+1){
			    		site_table.fnDraw();
			    		return;
			    	}
			    	idx++;
			    	addUserRules(ruleIdArray,idx,ele);
			    }
			});
	}
	//加
	var dialog ;
	function saveToUserRuleOfRule(ele,idx) {
		if(idx>-1){
			var rule_id = $(".saveToUserRuleOfRule:eq("+idx+")").attr("rule_id");
			var group_id = $(ele).attr("group_id");
			var group_name = $(ele).attr("group_name");
		   	var url = "/newsGroupRule/addNewsGroupRules";
		   	var data = {"ruleId":rule_id,"groupId":group_id,"groupName":group_name};
		   	var type = "POST";
		   	$.ajax({
		   		url:url,
		   		data:data,
		   		type:type,
		   		beforeSend:function(){
					//这里是开始执行方法，显示效果
					$(ele).attr("disabled","disabled");
					$(ele).find("i").attr("class","fa fa-gear fa-1x fa-spin")
				},
				complete:function(){
					//方法执行完毕，效果自己可以关闭，或者隐藏效果
					$(ele).removeAttr("disabled");
					$(ele).find("i").attr("class","fa  fa-chain");
				},
		   		success:function(data){
		   			data = eval('('+data+')');
		   			if(data.result){
		   				//ggg
		   				rule_table.fnDraw();
		   				site_table.fnDraw();
		   				dialog.close();
		   			}
		   		}
		   	});
		}else{
			$("#group_dialog_div").html("");
			idx = $(ele).index(".saveToUserRuleOfRule");
			$.ajax({
			   	url:"news/getAllGroupList.html",
			   	success:function(data){
				   	data = eval('('+data+')');
				   	for(var i = 0 ; i < data.length; i++){
					   	var name = data[i].name;
					   	var id =  data[i].id;
				   		var btn = '<a class="btn btn-primary add_group_site_rules" onclick="saveToUserRuleOfRule(this,'+idx+')" group_id="'+id+'" group_name="'+name+'" style="margin:5px;" href="javascript:void(0);">'+name+'</a>';
				   		$("#group_dialog_div").append(btn);
					}
			   	}
			});
		   	//$('#group_dialog_div').load();
		   	dialog = window.top.art.dialog({
				title: "公共正文模板列表",
				content:  $("#group_dialog_div")[0],
				width:"400px",
				padding: '0px 0px',
				lock:true
			});
			$(".aui_main").css("text-align","left");
		} 
			
	};
	
	function deleteToUserRuleOfRule(ele,del_type,idx){
		if(del_type>-2){
			var rule_id = $(".deleteToUserRuleOfRule:eq("+idx+")").attr("rule_id");
			var group_id = "";
			if(del_type==2){
				rule_id = $(ele).attr("rule_id");
				group_id = $(ele).attr("group_id");
			}else{
				group_id = $(ele).attr("group_id");
			}
		   	var url = "/newsGroupRule/deleteNewsGroupRules";
		   	var data = {"ruleId":rule_id,"groupId":group_id};
		   	var type = "POST";
		   	$.ajax({
		   		url:url,
		   		data:data,
		   		type:type,
		   		beforeSend:function(){
					//这里是开始执行方法，显示效果
					$(ele).attr("disabled","disabled");
					$(ele).find("i").attr("class","fa fa-gear fa-1x fa-spin")
				},
				complete:function(){
					//方法执行完毕，效果自己可以关闭，或者隐藏效果
					$(ele).removeAttr("disabled");
					$(ele).find("i").attr("class","fa  fa-chain-broken");
				},
		   		success:function(data){
		   			data = eval('('+data+')');
		   			if(data.result){
		   				//ggg
		   				if(del_type==2){
		   					user_rule_table.fnDraw();
		   				}else{
		   					rule_table.fnDraw();
		   				}
		   				site_table.fnDraw();
		   				dialog.close();
		   			}
		   		}
		   	});
		}else{
			$("#group_dialog_div").html("");
			idx = $(ele).index(".deleteToUserRuleOfRule");
			$.ajax({
			   	url:"news/getAllGroupList.html",
			   	success:function(data){
				   	data = eval('('+data+')');
				   	for(var i = 0 ; i < data.length; i++){
					   	var name = data[i].name;
					   	var id =  data[i].id;
				   		var btn = '<a class="btn btn-primary add_group_site_rules" onclick="deleteToUserRuleOfRule(this,-1,'+idx+')" group_id="'+id+'" group_name="'+name+'" style="margin:5px;" href="javascript:void(0);">'+name+'</a>';
				   		$("#group_dialog_div").append(btn);
					}
			   	}
			});
		   	//$('#group_dialog_div').load();
		   	dialog = window.top.art.dialog({
				title: "公共正文模板列表",
				content:  $("#group_dialog_div")[0],
				width:"400px",
				padding: '0px 0px',
				lock:true
			});
			$(".aui_main").css("text-align","left");
		}
	}
	function loadFilteredUserRule(ele){
		var site_id = $(ele).attr("site_id");
		$("a.look-user-rules").attr("params","&eq_siteId="+site_id+"&isOr=1");
		$('a.look-user-rules').trigger("click");
	}
	function loadEditGroupDialog(){
    	var dialog = art.dialog({
			    title: '添加站点',
			    width: 'auto',    // 内容宽度
 				height: 'auto',    // 内容高度
			    content: $('#group_dialog_div')[0],
			    padding: '0px 0px',
			    lock:true,
			    button:[{
			    	name:"保存",
			    	callback:function(){
			    		$.ajax({
							type: "post",
						    url: "/news/saveGroup",
						    data: $("#frmGroup").serialize(),
						    success: function(data){
				                dialog.close();
				                MessageBoxShow('保存成功!',true);
				        	}
						});
						return false;
			    	}
			    },{
			    	name:"&nbsp; 取消",
			    	callback:function(){
			    	}
			    }],
			    init: function () {
			    	changeArtdialogButtonCss();
			    }
		}); 
    }
    //aaaa
    var editSiteDialog;
	function loadEditSiteDialog(){
    	editSiteDialog = art.dialog({
				id:"site_dialog",
			    title: '添加站点',
			    width: '400px',    // 内容宽度
 				height: 'auto',    // 内容高度
			    content: $('#site_dialog_div')[0],
			    padding: '0px 0px',
			    lock:true,
			    button:[{
			    	name:"保存",
			    	callback:function(){
			    		$.ajax({
							type: "post",
						    url: "/news/saveSite",
						    data: $("#frmSite").serialize(),
						    dataType:'json',
						    success: function(data){
						    	if(data.result>0){
					                site_table.fnDraw();
					                editSiteDialog.close();
					                MessageBoxShow('保存成功!',true);
					                saveImage(data.id,data.url);
						    	}else if(data.result==-2){
						    		MessageBoxShow('保存失败!名称重复');
							    }else{
							    	MessageBoxShow('保存失败!服务器异常');
							    }
				        	}
						});
						return false;
			    	}
			    },{
			    	name:"&nbsp; 取消",
			    	callback:function(){
			    	}
			    }],
			    init: function () {
			    	changeArtdialogButtonCss();
			    }
		});
		editSiteDialog.hide(); 
    }
    function saveImage(id,_url){
    	/*
    	
        $.ajax({
            url:'/news/saveImage',
            type:'post',
            data:{id:id,url:_url},
            success:function(data){},
            error:function(){}
        })
        */
    }
	function addNewsGroupRulesForSite(ele){
		$(".span-tip-box").css("display","inline-block");
		var site_addting_ids = "";
		$("input[name='sites']").each(function(){
		   if($(this).is(":checked")){
		    	site_addting_ids+=$(this).val()+",";
		   }
		});
		if(site_addting_ids.indexOf(",")>-1) site_addting_ids = site_addting_ids.substring(0,site_addting_ids.length-1);
		var siteIdArray = site_addting_ids.split(",");
		addUserRulesOfSite(siteIdArray,0,ele);
	}
	function addNewsGroupRulesForRule(ele){
		var rule_adding_ids = "";
	    $("input[name='rules']").each(function(){
	    	if($(this).is(":checked")){
	    		rule_adding_ids+=$(this).val()+",";
	    	}
	    });
	    if(rule_adding_ids.indexOf(",")>-1) rule_adding_ids = rule_adding_ids.substring(0,rule_adding_ids.length-1);
	   	var ruleIdArray = rule_adding_ids.split(",");
	    addUserRules(ruleIdArray,0,ele);
	   	
		return false;
	}
	function add_group_site_rules(idx,this_){
		var ele = $("button.saveToUserRule:eq("+idx+")");
	   	var site_id = $(ele).attr("site_id");
	   	
		var group_id = $(this_).attr("group_id");
		var group_name = $(this_).attr("group_name");

		
		var url = "/newsGroupRule/addNewsGroupRulesOfSite";
	   	var data = {siteId:site_id,groupId:group_id,groupName:group_name};
	   	
	   	
	   	var type = "POST";
	   	
	   	$.ajax({
	   		url:url,
	   		data:data,
	   		type:type,
	   		beforeSend:function(){
				//这里是开始执行方法，显示效果
				$(ele).attr("disabled","disabled");
				$(ele).find("i").attr("class","fa fa-gear fa-1x fa-spin")
			},
			complete:function(){
				//方法执行完毕，效果自己可以关闭，或者隐藏效果
				$(ele).removeAttr("disabled");
				$(ele).find("i").attr("class","fa  fa-chain");
			},
	   		success:function(data){
	   			data = eval('('+data+')');
	   			if(data.result){
	   				//ggg
	   				site_table.fnDraw();
	   			}
	   		},
	   		error:function(){}
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
