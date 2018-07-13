<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.smart-form .tooltip{opacity:1;min-width:400px;background:none;}
.smart-form .tooltip-inner{min-width:388px;}
.bg_f1fedd{background: #f1fedd;}
</style>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-2">
		<h1 class="page-title txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 新闻
			<span>> 抓取规则 </span>
		</h1>
	</div>
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-10" style="text-align:right;">
	</div>
</div>

<!-- widget grid -->
<section id="widget-grid" class="">

<!-- row -->
<div class="row">
	<!-- 这是站点表格 -->
	<article class="col-sm-12 col-md-12 col-lg-12">
		<div class="jarviswidget jarviswidget-color-darken"
			data-widget-editbutton="false" data-widget-colorbutton="false">
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
						class="table table-striped table-bordered table-hover smart-form has-tickbox" width="100%">
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
			data-widget-editbutton="false" data-widget-colorbutton="false" style="width:100%;">
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
									组名
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
<!-- <div id="site_del_dialog" class="row" title="删除站点" style="text-align:center;">确定要删除吗?<input type="hidden" name="del_id"/></div> -->
<!-- <div id="rule_del_dialog" class="row" title="删除规则" style="text-align:center;">确定要删除吗?<input type="hidden" name="del_id"/></div> -->
<script type="text/javascript"><!--
 	//初始化加载一些参数
	pageSetUp();
	//提示
	artDialog.tips = function(content, time) {  
		return artDialog({  
				id: 'Tips',  
				title: false,  
				cancel: false,  
				fixed: true,  
				lock: true,  
				opacity: 0.3  
		}).content('<div style="padding: 0 1em;">' + content + '</div>').time(time || 0.5);  
	};  
	/*
	 * ALL PAGE RELATED SCRIPTS CAN GO BELOW HERE
	 * eg alert("my home function");
	 * 
	 * var pagefunction = function() {
	 *   ...
	 * }
	 * loadScript("js/plugin/_PLUGIN_NAME_.js", pagefunction);
	 * 
	 */
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
		console.log(formData);
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
	
	function loadPublicHtmlListRuleModel(){
		commonLoadPublicHtmlListRuleModelTable();
	}
	function loadPublicHtmlListRuleModelOnlySelect(){
		commonLoadPublicHtmlListRuleModelTable(true);
	}
	
	
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
	// pagefunction	
	var pagefunction = function() {
		$("a.public-html-list-rule-model").click(function(){//公共html列表模板
			loadPublicHtmlListRuleModel();
			var dialog = window.top.art.dialog({
				title: "公共列表模板列表",
				content:  $("#public-html-list-rule-model-boxs div:eq(0)")[0],
				width:"900px",
				padding: '0px 0px',
				lock:true
			});
			$(".aui_content").css("width","100%");
		});
		$("a.public-json-list-rule-model").click(function(){//公共json列表模板
			loadPublicJsonListRuleModel();
			var dialog = window.top.art.dialog({
				title: "公共列表模板列表",
				content:  $("#public-json-list-rule-model-boxs div:eq(0)")[0],
				width:"900px",
				padding: '0px 0px',
				lock:true
			});
			$(".aui_content").css("width","100%");
		});
		$("a.public-html-text-rule-model").click(function(){//公共正文模板
			loadPublicHtmlTextRuleModel();
			var dialog = window.top.art.dialog({
				title: "公共正文模板列表",
				content:  $("#public-html-text-rule-model-boxs div:eq(0)")[0],
				width:"900px",
				padding: '0px 0px',
				lock:true
			});
			$(".aui_content").css("width","100%");
		});
		$("a.public-json-text-rule-model").click(function(){//公共正文模板
			loadPublicJsonTextRuleModel();
			var dialog = window.top.art.dialog({
				title: "公共正文模板列表",
				content:  $("#public-json-text-rule-model-boxs div:eq(0)")[0],
				width:"900px",
				padding: '0px 0px',
				lock:true
			});
			$(".aui_content").css("width","100%");
		});
		$("a.look-user-rules").click(function(){
			var params = $(this).attr("params");
			loadUserRuleTable(params);
			var dialog = window.top.art.dialog({
				title: "公共正文模板列表",
				content:  $("#user-rule-boxs div:eq(0)")[0],
				width:"900px",
				padding: '0px 0px',
				lock:true
			});
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
		   	var site_id = $(this).attr("site_id");
			$('#site_dialog_div').load("bdzd/toSiteDialog?id="+site_id);
			loadEditSiteDialog();
			$('#site_dialog_div').html("");
		});
		$('#site_list tbody').on( 'click', 'button.lookChild', function () {
			var site_id = $(this).attr("site_id");
			//var site_id = $("button.lookChild").attr("site_id");
			siteDetail(site_id);
			/*
			if($("#all_rules").is(':checked')){$("#all_rules")[0].checked = false;};
	        var data = site_table.fnGetData($(this).parents('tr'));
	        loadRuleTable(data);
	        
		    var dialog = window.top.art.dialog({
					    title: "子版块列表  - "+data.name+" - "+data.url,
					    content: $("#rule-boxs #wid-id-rule")[0],
					    width:"850px",
					    padding: '0px 0px',
					    lock:true
					});
			$(".aui_content").css("width","100%");
			*/
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
		   	console.log(site_id);
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
										rule_table.fnDraw();//重新加载数据
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
		var rule_id = $(ele).attr("rule_id");
		$("#rule_del_id").val(rule_id);
	}
	function delAllOfSite(ele){
		var dialog = art.dialog({
					id:"rule_dialog",
				    title: '删除确认框',
				    width: 'auto',    // 内容宽度
	 				height: 'auto',    // 内容高度
				    content: "确认要删除吗? <div style='display:none;'><input name='del_id' id='site_allrule_del_id'/></div>",
				    padding: '0px 0px',
				    lock:true,
				    button:[{
				    	name:"确认",
				    	callback:function(){
					    	var url = "bdzd/deleteSite";
							var id = $('#site_allrule_del_id').val();
							var data= {"id":id};
							$.ajax({
								url:url,
								data:data,
								type:"POST",
								success:function(data){
									if(data){
										//data_table.fnClearTable(); //清空数据
		            					site_table.fnDraw(); //重新加载数据
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
		var site_id = $(ele).attr("site_id");
		$("#site_allrule_del_id").val(site_id);
	}
	function saveNewRule(){
		var ipt_id = $("div[name='id'] input");
		ipt_id.val(""); //新增id置为""
		$.ajax({
			type: "post",
			url: "/bdzd/saveRule",
			data: buildFormData2(),
			async: false,
			success: function(data){
				data = eval('('+data+')');
				var id  = data.id;
				$("div[name='id'] input").attr("value",id);
				$("div[name='id'] input").val(id);
				rule_table.fnDraw();
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
				    	name:"<i class='fa  fa-play'></i>&nbsp; 实时入库",
				    	callback:function(){
				    		saveFatchListToDBRightNow();
				    		//art.dialog.tips('入库成功!');
				    		return false;
				    	}
				    },{
				    	name:'保存为新模块',
				    	callback:function(){
							var rId = saveNewRule();
							$(".aui_buttons button:eq(2)").show();
							if(rId){
								art.dialog.tips('保存成功!');
							}
							return false;
				    	}
				    },{
				    	name:'更新',
				    	callback:function(){
				    		updateToRule();
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
		
		if(type&&type==2){
			$(".aui_buttons button:eq(2)").hide();
		}
		$(".aui_content").css("width","100%");
	}
	/**
	** 实时入库
	*/
	function saveFatchListToDBRightNow(){
		var ruleId = $("div[name='id'] input").val();
		/*
		if(ruleId==""){
			ruleId = saveNewRule();
		}*/
		saveFatchListToDB(".aui_buttons button:eq(0)",ruleId);	
	}
	
	function siteDetail(id){
		$(".fetch-content").html("");
		$('#rule_dialog_div').load("bdzd/toRuleDialog?site_id="+id,function(){
			loadEditRuleDialog();
			$('#rule_dialog_div').html("");
			getListPageInfo();
		});
		return false;
	}
	/**
	** 获取根据规则进行过滤的列表
	*/
	function getListPageInfo(){
		var url = "/bdzd/getListPageInfo";
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
			    	var type = data[i].type;
			    	var thisPageNoData = data[i].thisPageNoData;
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
			    		 
			    		strs+='<div style="font-size: 31px;text-align: center;">第'+page+'页('+type+')</div>';
			    		if(thisPageNoData==1){
			    			strs+='<hr style="border-top: 1px solid #3276b1"/>';
			    			strs+='<div style="text-align:center;"><b style="color:red;font-size: 26px">数据偷偷的溜走了~~~~</b></div>';
				    	}
			    		
			    	}else{
				    	var titleStr = '  <div><b>标题</b>:<a target="blank_" href='+url+'>'+title+'</a></div>';
				    	if(realUrl){
				    		titleStr = '  <div><b>标题</b>:<a target="blank_" href='+realUrl+'>'+title+'</a></div>';
					    }
			    		strs+='<hr style="border-top: 1px solid #3276b1"></hr>'+titleStr+
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
						    ' ';
			    	}
			    	
			    }
			    //console.log(strs);
			    $("#rule_list_fieldset div:eq(0)").html(strs);
			}
		})
	}
	function testContent(ele){
		var textPageUrl = $(ele).attr("to-url");
		var url = "bdzd/getTextPageInfo";
		var post_data = buildFormData();
		post_data['textPageUrl'] = textPageUrl;
		$.ajax({
			url:url,
			type:'POST',
			data:post_data,
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
		var question = data[0];
		var answers = question.answers;
		var html_strs = "";
		var class_bg_f1fedd = "bg_f1fedd";
		var class_str = "";
		
		var additionalAttributeStr = obj2str(question.additionalAttribute)==null?"":obj2str(question.additionalAttribute); 
		for(var i = 0 ; i < answers.length; i++){
			var ans = answers[i];
			var content = ans.content;
			var bestFlag = ans.bestFlag==1?"是":"否";
			var businessFlag = ans.businessFlag==1?"是":"否";
			var askPeople = ans.askPeople;
			var askTime = ans.askTime;
			var answerPeople = ans.answerPeople;
			var answerTime = ans.answerTime;
			
			if(bestFlag=="是"){
				class_str=class_bg_f1fedd;
			}else{
				class_str="";
			}
			html_strs+='<legend></legend><div style="" class="'+class_str+'">'+
							'<div><b>提问人:</b>'+askPeople+'</div>'+
							'<div><b>提问时间:</b>'+askTime+'</div>'+
							'<div><b>回答人:</b>'+answerPeople+'</div>'+
							'<div><b>回答时间:</b>'+answerTime+'</div>'+
							'<div><b>是否为最佳回答:</b>'+bestFlag+'</div>'+
							'<div><b>是否为企业回答:</b>'+businessFlag+'</div>'+
							'<div><b>内容:</b>'+content+'</div>'+
						'</div>';
			
		}
		$(ele).parent().find(".fetch-content").html("<div><b>答案页额外字段:</b>"+additionalAttributeStr+"</div>"+html_strs);
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
	/**
	* 实时入库
	*/
	function saveFatchListToDB(ele,ruleId){
		var siteId = $(".siteId input").val();
		var url = "bdzd/saveFatchList?id="+ruleId+"&siteId="+siteId;
		$.ajax({
			url:url,
			type:'POST',
			beforeSend:function(){
				//这里是开始执行方法，显示效果
				$(ele).attr("disabled","disabled");
				$(ele).find("i").attr("class","fa fa-gear fa-1x fa-spin")
			},
			complete:function(){
				//方法执行完毕，效果自己可以关闭，或者隐藏效果
				$(ele).removeAttr("disabled");
				$(ele).find("i").attr("class","fa fa-play")
			},
			success:function(data){
				art.dialog.tips('入库成功!');
			}
		})
	}
	//列表事件--start
	function toAddPublicListRuleModel(type){
		console.log("you trigger add");
		
		$('#public_'+type+'_list_rule_dialog_div').load("/news/toPublicListRuleDialog.html?type="+type,function(){
			var dialog = art.dialog({
				title: '公共列表模板编辑',
				width: 'auto',    // 内容宽度
	 			height: 'auto',    // 内容高度
				content: $("#public_"+type+"_list_rule_dialog_div").html(),
				padding: '0px 0px',
				lock:true,
				button:[{
					  name:"<i class='fa  fa-play'></i>&nbsp; 保存",
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
		if(!result){
			art.dialog.tips('抓取页数只能填写数字!');
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
				dialog.close();
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
					  		art.dialog.tips('复制成功!');
					  		
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
			art.dialog.tips('复制成功!');
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
	function commonCopyPublicRuleModel(data,type){
		
		var mainFrm = $("#mainFrm");
				for(var key in data){
					console.log("---------------------"+key);
						if(typeof(data[key])=="object"){
							
							if(key!="textAdditionalParserMap"&&key!="listAdditionalParserMap"){
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
									mainFrm.find("div[name='"+key+"'] input:eq(0)").val(data[key]);
								}
								
							}
							//console.log("-----str---end----------------");
						}
					}
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
						 	$("div.other:eq(1)").after($(str));
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
	/**
	** 继承列表模板
	*/
	function extendsPublicListRuleModel(ele){
		var id = $("div[name='id'] input").attr("value");
		//if(!id) {art.dialog.tips('请保存后再继承，或直接使用复制!');return false;}
		var list_model_id = $(ele).attr("list_model_id");
		var list_model_name = $(ele).attr("list_model_name");
		$("#mainFrm div[name='publicListRuleId'] input").val(list_model_id);
		//var r = updateToRule();
		//if(r){
			$("#mainFrm a.extends_flag:eq(0)").attr("title","继承模板【"+list_model_name+"】,点击取消继承");
			$("#mainFrm a.extends_flag:eq(0)").attr("flag_title","继承模板【"+list_model_name+"】");
			$("#mainFrm a.extends_flag:eq(0)").css("color","#3276b1").css("text-decoration","none");
			art.dialog.tips('继承成功!请记得保存哦');
		//}
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
				
				commonCopyPublicListRuleModel(data,"extends");
			}
		});
		
		return false;
	}
	function updateToRule(){
			var r = false;
			$.ajax({
				type: "post",
				url: "/bdzd/saveRule",
				async:true,
				data: buildFormData2(),
				success: function(data){
					r = true;
					data = eval('('+data+')');
					$("div[name='id'] input").attr("value",data.id);
					$("div[name='id'] input").val(data.id);
					
					art.dialog.tips('更新成功!');
				}
			});
			
			return r;
	}
	function editPublicListRuleModel(ele,type){
		console.log("you trigger edit");
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
				 name:"<i class='fa  fa-play'></i>&nbsp; 保存",
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
		console.log("you trigger del"+type);
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
		console.log("you trigger add");
		$('#public_'+type+'_text_rule_dialog_div').load("/news/toPublicTextRuleDialog.html?type="+type,function(){
			var dialog = art.dialog({
				title: '公共列表模板编辑',
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
				console.log("over");
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
		复制正文模板
	*/
	function copyPublicTextRuleModel(ele){
		var publicTextRuleId = $(".aui_content #mainFrm div[name='publicTextRuleId'] input").val();
		console.log("8:51----------------------log----------------"+publicTextRuleId);
		if(publicTextRuleId){
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
					  	$(".aui_content #mainFrm div[name='publicTextRuleId'] input").val("");
					  	$(".aui_content #mainFrm a.extends_flag:eq(1)").attr("title","当前无继承模板");
					  	$(".aui_content #mainFrm a.extends_flag:eq(1)").attr("flag_title","当前无继承模板");
						$(".aui_content #mainFrm a.extends_flag:eq(1)").css("color","#ccc").css("text-decoration","none");
					  	startToCopyPublicTextRuleModel(ele);
					  	//var r = updateToRule();
					  	//if(r){
					  	//	art.dialog.tips('复制成功!');
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
			//art.dialog.tips('复制成功!');
		}
		
	}
	
	/**
		开始复制正文模板
	*/
	function startToCopyPublicTextRuleModel(ele){
		var text_model_id = $(ele).attr("text_model_id");
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
				commonCopyPublicTextRuleModel(data);
		}
		});
		art.dialog.tips('复制成功!');
		return false;
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
			art.dialog.tips('继承成功!请记得保存哦');
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
		$('#public_'+type+'_text_rule_dialog_div').load("/news/toPublicTextRuleDialog.html?id="+text_model_id+"&type="+type,function(){
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
	function commonLoadPublicHtmlTextRuleModelTable(isCopyOrExtends){//isSelect:是否是将要 复制或者继承
		if(public_html_text_rule_model_table!=null){
	        	//$("#rule_list tbody tr").remove();
	        public_html_text_rule_model_table.fnDestroy();
		}
		var sectionUrl = $("div[name='sectionUrl'] input").val();
		var everyArticleSelector = $("div[name='everyArticleSelector'] input").val();
		var listUrlParserMapKey = $("div[name='listUrlParserMap'] input:eq(0)").val();
		var listUrlParserMapValue = $("div[name='listUrlParserMap'] input:eq(1)").val();
		var tmpListUrlParserMapKey = "listUrlParserMap["+listUrlParserMapKey+"]";
		//公共正文模板
	    public_html_text_rule_model_table = $("#public_html_text_rule_model").dataTable({
			"bProcessing" : true,//加载数据时候是否显示进度条
			//"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/news/newsPublicRankTextRules?textDataType=2&"+tmpListUrlParserMapKey+"="+listUrlParserMapValue,//如果从服务器端加载数据,这个属性用于指定加载的路径 
			"fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {
		        var aoData = { "everyArticleSelector":everyArticleSelector,"sectionUrl":sectionUrl};      
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
	            {"data": function ( row, type, set ){
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
				if(!isCopyOrExtends){
					var button_html = '	<a class="btn btn-primary" id="add_public_json_text_rule_model" onclick=\'toAddPublicTextRuleModel("json")\' style="float:right;" href="javascript:void(0);">添加公共正文模板</a>&nbsp;&nbsp;';
				    $("#public_json_text_rule_model_wrapper .dt-toolbar>div:eq(1)").append($(button_html)).css("padding-right","0px");
				}
			 },
			"sDom":common_data_table_config.sDom
	    });
	}
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
		            {"data": function ( row, type, set ){
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
					if(!isCopyOrExtends){
						var button_html = '	<a class="btn btn-primary" id="add_public_json_list_rule_model" onclick=\'toAddPublicListRuleModel("json")\' style="float:right;" href="javascript:void(0);">添加公共列表模板</a>&nbsp;&nbsp;';
						$("#public_json_list_rule_model_wrapper .dt-toolbar>div:eq(1)").append($(button_html)).css("padding-right","0px");
					}
				},
				"sDom":common_data_table_config.sDom
		    });
	}
	function loadSiteTable(){
		site_table = $("#site_list").dataTable({
			"bProcessing" : true,//加载数据时候是否显示进度条
			"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/bdzd/getSitePagedList",//如果从服务器端加载数据,这个属性用于指定加载的路径 
			"sPaginationType" : "full_numbers",
			"bSort":false,
			"columns": [
				{"data": function ( row, type, set ){
						var html_ = '<label class="checkbox">'+
										'<input type="checkbox" name="sites" value="'+row.id+'">'+
										'<i></i>'+
									'</label>';
						return html_;
			    }},
	            {"data": "siteName"},
	            {"data": function ( row, type, set ){
				        return '<a target="blank_" href="'+row.siteUrl+'">'+row.siteUrl+'</a>';
			    }},
			    
			    {"data": function ( row, type, set ){
            		var id = row.id;
			        return "<button class='lookChild btn btn-xs btn-default' site_id='"+id+"' title='查看子版块'><i class='fa  fa-search'></i></button>&nbsp&nbsp"+
			        	   "<button class='lookDetail btn btn-xs btn-default' site_id='"+id+"' title='编辑'><i class='fa fa-pencil'></i></button>&nbsp&nbsp"+
			        	   "<button class='delAll btn btn-xs btn-default'  title='删除' site_id='"+id+"' onclick='delAllOfSite(this)'><i class='fa fa-times'></i></button>&nbsp&nbsp";
			        	   
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
		$("#site_list_filter label").remove();
		var s_zdmc_btn = '<input type="text" name="l_siteName" class="form-control ng-valid ng-dirty" placeholder="站点名称">';
		var s_url_btn = '<input type="text" name="l_siteUrl" class="form-control ng-valid ng-dirty" placeholder="URL">';
		var s_submit_btn = '<a class="btn btn-default" id="site_search">查询 </a>';
		
		$("#site_list_filter").append($(s_zdmc_btn)).append($(s_url_btn)).append($(s_submit_btn));
		$("input[name='sites']").on('click',function(){
			var ck_rules_ele_len = $("input[name='sites']").length;
			var ckd_len = $("input[name='sites']:checked").length;
			if(ckd_len == ck_rules_ele_len){
				$("#all_sites")[0].checked = true;
			}else{
				$("#all_sites")[0].checked = false;
			}
		});
		var addSiteBtn = '	<a class="btn btn-warning" id="add_site" style="float:right;margin-right:5px;" href="javascript:void(0);">添加站点</a>';
		//var addUserRuleOfSiteBtn = '	<a class="btn btn-primary" id="add_user_rules_of_site" style="float:right;margin-right:5px;" href="javascript:void(0);" title="添加所选站点下用户对应规则">添加用户对应规则</a>';
		$("#site_list_length").css("float","left");
		$("#site_list_wrapper .dt-toolbar>div:eq(1) ").append($(addSiteBtn))
			.css("padding-right","0");
		
		//$("#site_list_wrapper .dt-toolbar>div:eq(1) ");
		$('#add_site').on( 'click',  function () {
		    $('#site_dialog_div').load("bdzd/toSiteDialog");
		    loadEditSiteDialog();
		    $('#site_dialog_div').html("");
			return false;
		});
		//添加用户规则
		$('#add_user_rules_of_site').on( 'click',  function () {
			var ckd_len = $("input[name='sites']:checked").length;
			if(ckd_len==0){
				art.dialog.tips('请至少选择一项进行添加');
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
			var url = "/bdzd/getSitePagedList";
	    	var l_siteName = $("input[name='l_siteName']").val();
	    	var l_siteUrl = $("input[name='l_siteUrl']").val();
	    	var params = {"l_siteName":l_siteName,"l_siteUrl":l_siteUrl};
	    	url = addQueryParams(url,params);
	    	site_table.fnSettings().sAjaxSource=url;
	    	site_table.fnDraw(); //重新加载数据
		});
	}
	function initRuleTableButton(data){
		var s_bkmc_btn = '<input type="text" name="l_section" class="form-control ng-valid ng-dirty" placeholder="版块名称">';
		var s_url_btn = '<input type="text" name="l_sectionUrl" class="form-control ng-valid ng-dirty" placeholder="URL">';
		var s_submit_btn = '<a class="btn btn-default" id="rule_search">查询 </a>';
			$("#rule_list_filter label").remove();
			$("#rule_list_filter").append($(s_bkmc_btn)).append($(s_url_btn)).append($(s_submit_btn));
			var btn_add_rule_html = '	<a class="btn btn-warning" id="add_rule" style="float:right;" siteId='+data.id+' href="javascript:void(0);">添加规则</a>';
		    var btn_test_rule_html = '	<a class="btn btn-primary" id="test_rule" style="float:right;" siteId='+data.id+' href="javascript:void(0);">测试所选规则</a>';
		    var btn_add_user_rules = '	<a class="btn btn-success" id="btn_add_user_rules" style="float:right;" siteId='+data.id+' href="javascript:void(0);" title="添加所选用户对应规则">添加所选用户规则</a>';
		    $("#rule_list_wrapper .dt-toolbar>div:eq(1)").append($(btn_add_rule_html)).append($(btn_test_rule_html)).append($(btn_add_user_rules)).css("padding-right","0");
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
					art.dialog.tips('请至少选择一项进行测试');
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
					art.dialog.tips('请至少选择一项进行添加');
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

				
				/*			
				var rule_adding_ids = "";
			    $("input[name='rules']").each(function(){
			    	if($(this).is(":checked")){
			    		rule_adding_ids+=$(this).val()+",";
			    	}
			    });
			    if(rule_adding_ids.indexOf(",")>-1) rule_adding_ids = rule_adding_ids.substring(0,rule_adding_ids.length-1);
			   	var ruleIdArray = rule_adding_ids.split(",");
			    addUserRules(ruleIdArray,0);
			   	*/
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
	function loadRuleTable(data){
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
				        return tooltip+row.section;
			        }},
		            {"data": function ( row, type, set ){
				        return '<a target="blank_" href="'+row.sectionUrl+'">'+row.sectionUrl+'</a>';
			        }},
		            {"data": function ( row, type, set ){
				        return "<button class=' btn btn-xs btn-default' onclick=\"ruleDetail('"+row.id+"');\" title=\"查看解析器\"><i class='fa  fa-search'></i></button>&nbsp;&nbsp;"+
				        		"<button class=' btn btn-xs btn-default' onclick=\"saveFatchListToDB(this,'"+row.id+"');\" title=\"实时入库\"><i class='fa  fa-play'></i></button>&nbsp;&nbsp;"+
				        	   "<button class='delAll btn btn-xs btn-default' title='删除' rule_id="+row.id+" onclick='delRule(this)'><i class='fa fa-times'></i></button>&nbsp&nbsp"+
				        	   "<button class='saveToUserRuleOfRule btn btn-xs btn-default' rule_id='"+row.id+"' title='加入到拥有规则' onclick='saveToUserRuleOfRule(this)'><i class='fa  fa-chain'></i></button>&nbsp&nbsp"+
				        	   "<button class='deleteToUserRuleOfRule btn btn-xs btn-default' rule_id='"+row.id+"' title='删除拥有规则' onclick='deleteToUserRuleOfRule(this)'><i class='fa  fa-chain-broken'></i></button>&nbsp&nbsp";
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
			        "sDom":'<"dt-toolbar"<"col-xs-12 col-sm-7"fr><"col-xs-12 col-sm-5">'+ 
					'"t"'+'<"dt-toolbar-footer"<"col-xs-6"il><p>> >'//
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
	function testRule(ruleIdArray,idx){
	    	//console.log(ruleIdArray);
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
			    	//console.log("完成-----"+(idx+1));
			    	
			    	/*
			    	$("#site_list tbody input[name='sites']").each(function(){
			    		if($(this).val()==siteIdArray[idx]){
			    			$(this).parents("tr").find("td").css("background","#dff0d8");
			    		}
			    	});
			    	*/
			    	
			    	//$("#site_list tbody tr:eq("+idx+") td").css("background","#dff0d8");
			    	
			    	//continue
			    	if(siteIdArray.length<=idx+1){
			    		//gggggg
			    		art.dialog.tips('保存成功!');
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
		console.log("idx=============================="+idx);
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
		$("a.look-user-rules").attr("params","&eq_siteId="+site_id);
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
				                art.dialog.tips('保存成功!');
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
	function loadEditSiteDialog(){
    	var dialog = art.dialog({
				id:"site_dialog",
			    title: '添加站点',
			    width: 'auto',    // 内容宽度
 				height: 'auto',    // 内容高度
			    content: $('#site_dialog_div')[0],
			    padding: '0px 0px',
			    lock:true,
			    button:[{
			    	name:"保存",
			    	callback:function(){
			    		$.ajax({
							type: "post",
						    url: "/bdzd/saveSite",
						    data: $("#frmSite").serialize(),
						    success: function(data){
				                site_table.fnDraw();
				                dialog.close();
				                art.dialog.tips('保存成功!');
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
	loadScript("/resources/js/plugin/datatables/jquery.dataTables.min.js", function(){
		loadScript("/resources/js/plugin/datatables/dataTables.colVis.min.js", function(){
			loadScript("/resources/js/plugin/datatables/dataTables.tableTools.min.js", function(){
				loadScript("/resources/js/plugin/datatables/dataTables.bootstrap.min.js", pagefunction);
			});
		});
	});
	

--></script>