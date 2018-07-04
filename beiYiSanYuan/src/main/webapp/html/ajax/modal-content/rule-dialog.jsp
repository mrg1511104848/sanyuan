<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.toggle input:checked+i:before {
		right: 40px;
	}
	.toggle i:before {
		right:1px;
	}
	.toggle:last-child {
		margin-bottom: 0;
	}
	.toggle {
		margin-bottom: 4px;
		padding-right: 61px;
		font-size: 15px;
		line-height: 25px;
		color: #404040;
		cursor: pointer;
	}
	.toggle {
		position: relative;
		display: block;
		font-weight: 400;
	}
	:after,:before {
	margin: 0;
	padding: 0;
	box-sizing: content-box;
	-moz-box-sizing: content-box;
	}
	label {
font-weight: 400;
}
:after, :before {
margin: 0;
padding: 0;
box-sizing: content-box;
-moz-box-sizing: content-box;
}
.toggle input {
position: absolute;
left: -9999px;
}
.toggle i {
content: '';
position: absolute;
top: 4px;
right: 0;
display: block;
width: 49px;
height: 17px;
border-width: 1px;
border-style: solid;
border-radius: 12px;
background: #fff;
}
.toggle i:before {
background-color: #3276B1;
}
.toggle i:before {
content: '';
position: absolute;
z-index: 1;
top: 4px;
right: 4px;
display: block;
width: 9px;
height: 9px;
border-radius: 50%;
opacity: 1;
transition: right .2s;
-o-transition: right .2s;
-ms-transition: right .2s;
-moz-transition: right .2s;
-webkit-transition: right .2s;
}
:after, :before {
margin: 0;
padding: 0;
box-sizing: content-box;
-moz-box-sizing: content-box;
}
.toggle i:after {
content: attr(data-swchoff-text);
position: absolute;
top: 2px;
right: 5px;
left: 8px;
font-style: normal;
font-size: 9px;
line-height: 13px;
font-weight: 700;
text-align: left;
color: #5f5f5f;
}
.toggle {
margin-bottom: 4px;
padding-right: 61px;
font-size: 15px;
line-height: 25px;
color: #404040;
cursor: pointer;
}
.toggle input:checked+i:after {
content: attr(data-swchon-text);
text-align: right;
}
</style>
<script type="text/javascript">
		$(function(){
			var publicListRuleId = $("div[name='publicListRuleId'] input").val();
			if(publicListRuleId){
				$(".html-box:eq(0) .form-group").each(function(){
					var pre = $(this).find("input:last").prev();
					if(pre){
						var v = pre.text().trim();
						if($(this).find("input:last").val()!=""){
							$(this).find("input:last").val(v);
							$(this).find("input:last").attr("value",v);
						}else{
							$(this).find("input:last").attr("placeholder",v);
						}
					}
				});
			}else{
				$(".html-box:eq(0) .form-group").each(function(){
					var pre = $(this).find("input:last").prev();
					if(pre){
						var v = pre.text().trim();
						$(this).find("input:last").val(v);
						$(this).find("input:last").attr("value",v);
					}
				});
			}
			var fetch_strategy = $("div[name='fetchStrategy'] input").val();
			if(!fetch_strategy){
				$("div[name='fetchStrategy'] input").attr("value",1);
				$("div[name='fetchStrategy'] input").val(1);
				fetch_strategy = 1;
			}
			$("input[name='radio-fetch-strategy']").each(function(){
				if($(this).attr("t_value")==fetch_strategy){
					$(this).prop("checked",true);
				}
			});
			
			var publicTextRuleId = $("div[name='publicTextRuleId'] input").val();
			if(publicTextRuleId){
				$(".html-box:eq(1) .form-group").each(function(){
					var pre = $(this).find("input:last").prev();
					if(pre){
						var v = pre.text().trim();
						if($(this).find("input:last").val()!=""){
							$(this).find("input:last").val(v);
							$(this).find("input:last").attr("value",v);
						}else{
							$(this).find("input:last").attr("placeholder",v);
						}
					}
				});
			}else{
				$(".html-box:eq(1) .form-group").each(function(){
					var pre = $(this).find("input:last").prev();
					if(pre){
						var v = pre.text().trim();
						$(this).find("input:last").val(v);
						$(this).find("input:last").attr("value",v);
					}
				});
			}
		})
		$(function(){
			var listAdditionalShowFlagLength = $("#listAdditionalShowFlag").length;
			if(listAdditionalShowFlagLength>0){
				$(".listAdditionalParserMap").hide();
			}
			var textAdditionalShowFlagLength = $("#textAdditionalShowFlag").length;
			if(textAdditionalShowFlagLength>0){
				$(".textAdditionalParserMap").hide();
			}
			//$(".control-label").css("text-align","center").css("padding","0");
			
			//$(".col-md-4,.col-md-5,.smart-form *, .smart-form :after, .smart-form :before").not("a,i").css("padding","0px 13px").css("box-sizing","border-box");
			
			
			
			//var isCheck = $("input[name='open-list-type-flag']");
			//$(".form-control").css("padding","6px 12px");
		})
		function use_list_model(){
			var listDataType = $("#mainFrm div[name='listDataType'] input").val();
			var type = listDataType==2?"html":"json";
			if(listDataType==2){
				loadPublicHtmlListRuleModelOnlySelect();
			}else{
				loadPublicJsonListRuleModelOnlySelect();
			}
			var dialog = window.top.art.dialog({
					title: "公共列表模板列表",
					content:  $("#public-"+type+"-list-rule-model-boxs div:eq(0)")[0],
					width:"900px",
					padding: '0px 0px',
					lock:true
			});
			$(".aui_content").css("width","100%");
		}
		function ready_to_create_list_model(){
			var section = $("#leftEditBox div[name=section] input").val();
			var dialog = window.top.art.dialog({
					title: "创建列表模板",
					content:  "自定义名称: <input name='zdy_list_name' value="+section+"/>",
					width:"500px",
					padding: '0px 0px',
					lock:true,
					button:[{
				    	name:"确认",
				    	callback:function(){
				    		
				    		var h = $("div.html-box:eq(0) input");
				    		var j = $("div.json-box:eq(0) input");
				    		h.each(function(){
				    			var hv = $(this).val();
				    			if(hv!=""){
				    				$(this).attr("placeholder",hv);
				    			}
				    		});
				    		j.each(function(){
				    			var jv = $(this).val();
				    			if(jv!=""){
				    				$(this).attr("placeholder",jv);
				    			}
				    		});
				    		h.val("");
				    		j.val("");
				    		
				    		create_list_model();
				    		dialog.close();
							return false;
				    	}
				    },{
				    	name:"取消",
				    	callback:function(){
				    		dialog.close();
				    	}
				    }],
				    init: function () {
				    	changeArtdialogButtonCss();
				    }
			});
		}
		function create_list_model(){
			var zdy_list_name = $(".aui_content input[name='zdy_list_name']").val();
			console.log(zdy_list_name);
			var url = "/news/saveNewsPublicListRule.html?type=new&zdy_list_name="+zdy_list_name;
			$.ajax({
				url:url,
				data:buildFormData(),
				success:function(data){
					data = 	eval('('+data+')');
					if(data.result){
						$(".aui_content #mainFrm div[name='publicListRuleId'] input").val(data.id);
						//var r = updateToRule();
						//if(r){
							art.dialog.tips('生成模板成功!');
							var name = data.name;
							$(".aui_content #mainFrm a.extends_flag:eq(0)").attr("title","继承模板【"+name+"】,点击取消继承");
							$(".aui_content #mainFrm a.extends_flag:eq(0)").attr("flag_title","继承模板【"+name+"】");
							$(".aui_content #mainFrm a.extends_flag:eq(0)").css("color","#3276b1").css("text-decoration","none");
						//}
					}
				}
			})
		}
		function ready_to_create_text_model(){
			var dialog = window.top.art.dialog({
					title: "创建正文模板",
					content:  "自定义名称: <input name='zdy_text_name' />",
					width:"500px",
					padding: '0px 0px',
					lock:true,
					button:[{
				    	name:"确认",
				    	callback:function(){
				    		var h = $("div.html-box:eq(1) input");
				    		var j = $("div.json-box:eq(1) input");
				    		h.each(function(){
				    			var hv = $(this).val();
				    			if(hv!=""){
				    				$(this).attr("placeholder",hv);
				    			}
				    		});
				    		j.each(function(){
				    			var jv = $(this).val();
				    			if(jv!=""){
				    				$(this).attr("placeholder",jv);
				    			}
				    		});
				    		h.val("");
				    		j.val("");
				    		
				    		create_text_model();
				    		dialog.close();
				    	}
				    },{
				    	name:"取消",
				    	callback:function(){
				    		dialog.close();
				    	}
				    }],
				    init: function () {
				    	changeArtdialogButtonCss();
				    }
			});
		}
		function create_text_model(){
			var zdy_text_name = $(".aui_content input[name='zdy_text_name']").val();
			var url = "/news/saveNewsPublicTextRule.html?type=new&zdy_text_name="+zdy_text_name;
			$.ajax({
				url:url,
				data:buildFormData(),
				success:function(data){
					data = 	eval('('+data+')');
					if(data.result){
						$(".aui_content #mainFrm div[name='publicTextRuleId'] input").val(data.id);
						//var r = updateToRule();
						var name = data.name;
						//if(r){
							art.dialog.tips('生成模板成功!');
							$(".aui_content #mainFrm a.extends_flag:eq(1)").attr("title","继承模板【"+name+"】,点击取消继承");
							$(".aui_content #mainFrm a.extends_flag:eq(1)").attr("flag_title","继承模板【"+name+"】");
							$(".aui_content #mainFrm a.extends_flag:eq(1)").css("color","#3276b1").css("text-decoration","none");
						//}
					}
				}
			})
		}
		
		function use_text_model(){
			var textDataType = $("#mainFrm div[name='textDataType'] input").val();
			console.log(textDataType);
			var type = textDataType==2?"html":"json";
			if(textDataType==2){
				loadPublicHtmlTextRuleModelOnlySelect();
			}else{
				loadPublicJsonTextRuleModelOnlySelect();
			}
				var dialog = window.top.art.dialog({
					title: "公共列表模板列表",
					content:  $("#public-"+type+"-text-rule-model-boxs div:eq(0)")[0],
					width:"900px",
					padding: '0px 0px',
					lock:true
				});
			$(".aui_content").css("width","100%");
		}
		function cancelExtends(ele,type){
			var public_id;
			//var param = {};
			
			var id = $(".aui_content #mainFrm div[name='id'] input").val();
			if(type==0){
				public_id = $(".aui_content #mainFrm div[name='publicListRuleId'] input").val();
				if(!public_id){
					return;
				}else{
					$(".aui_content #mainFrm div[name='publicListRuleId'] input").val("");
					//param = {"id":id,"publicListRuleId":""};
				}
			}else{
				public_id = $("#mainFrm div[name='publicTextRuleId'] input").val();
				if(!public_id){
					return;
				}else{
					$(".aui_content #mainFrm div[name='publicTextRuleId'] input").val("");
					//param = {"id":id,"publicTextRuleId":""};
				}
			}
			startToCancelExtends(ele,type);
			
		}
		function startToCancelExtends(ele,type){
			var url = "/news/saveRule.html";
			$.ajax({
				url:url,
				type:'POST',
				data:buildFormData(),
				success:function(data){
					data = eval('('+data+')');
					if(data.result){
						art.dialog.tips('取消继承成功!');
						$("#mainFrm a.extends_flag:eq("+type+")").css("color","#ccc").css("text-decoration","none");
						$("#mainFrm a.extends_flag:eq("+type+")").attr("title","当前无继承模板");
						$("#mainFrm a.extends_flag:eq("+type+")").attr("flag_title","当前无继承模板");
					}
				}
			})
		}
		function changeListType(ele){
			var isCheck = ele.checked;
			console.log("isCheck---------------"+isCheck);
			var flag_index = $(ele).index(".open-type-flag");
			console.log("flag_index------------"+flag_index);
			if(isCheck){//html
				$(".html-box:eq("+flag_index+")").css("display","block");
				$(".json-box:eq("+flag_index+")").css("display","none");
				
				if(flag_index==0){
					$("#mainFrm div[name='listDataType'] input").val("2");
					$("#mainFrm div[name='listDataType'] input").attr("value","2");
					//$("#mainFrm div[name='listCharset']:eq(0) input").val($("#mainFrm div[name='listCharset']:eq(1) input").val());
					$("#mainFrm div[name$='listCharset']:eq(0)").attr("name","listCharset");
					$("#mainFrm div[name$='listCharset']:eq(1)").attr("name","_invalid_listCharset");
					
					$("#mainFrm div[name$='page']:eq(0)").attr("name","page");
					$("#mainFrm div[name$='page']:eq(1)").attr("name","_invalid_page");

					
				}else{
					$("#mainFrm div[name='textDataType'] input").val("2");
					$("#mainFrm div[name='textDataType'] input").attr("value","2");
				}
			}else{//json
				$(".json-box:eq("+flag_index+")").css("display","block");
				$(".html-box:eq("+flag_index+")").css("display","none");
				
				if(flag_index==0){
					$("#mainFrm div[name='listDataType'] input").val("1");
					$("#mainFrm div[name='listDataType'] input").attr("value","1");
					$("#mainFrm div[name$='listCharset']:eq(1)").attr("name","listCharset");
					$("#mainFrm div[name$='listCharset']:eq(0)").attr("name","_invalid_listCharset");
					
					$("#mainFrm div[name$='page']:eq(1)").attr("name","page");
					$("#mainFrm div[name$='page']:eq(0)").attr("name","_invalid_page");
				}else{
					$("#mainFrm div[name='textDataType'] input").val("1");
					$("#mainFrm div[name='textDataType'] input").attr("value","1");
				}
			}
			
		}
		function miaodian(ele){
			var tab = $(ele).find("a").attr("href");
			$('#leftEditBox').animate({scrollTop: $(tab).position().top}, 500);

			
		}
		$(function(){
			setTimeout("bindScroll()", 1000);
		})
		function bindScroll(){
			var tabTop1 = $("#tab1").position().top;
			var tabTop2 = $("#tab2").position().top;
			var tabTop3 = $("#tab3").position().top;
			$('#leftEditBox').bind('scroll', function() { 
				
				var top = $('#leftEditBox').scrollTop();
				var i = -1;
				if(top>=0&&top<247){
					i = 0;
					$(".bootstrapWizard li:eq(0)").addClass("active");
				}else if(top>=247&&top<600){
					i = 1;
					$(".bootstrapWizard li:eq(1)").addClass("active");
				}else{
					i = 2;
					$(".bootstrapWizard li:eq(2)").addClass("active");
				}
				$(".bootstrapWizard li").not($(".bootstrapWizard li:eq("+i+")")).removeClass("active");
			}); 
		}
</script>
<div class="widget-body " style="border-bottom: 1px dashed #ccc;float:left;width: 50%;position: absolute;">
	<div class="row" style="margin-bottom: 24px;">
							<form id="wizard-1" novalidate="novalidate">
								<div id="bootstrap-wizard-1" class="col-sm-12">
									<div class="form-bootstrapWizard">
										<ul class="bootstrapWizard form-wizard">
											<li class="active" data-target="#step1" style="width:30%" onclick="miaodian(this)">
												<a href="#tab1" data-toggle="tab"> <span class="step" style="font-size:15px;">1</span> <span class="title">基本信息</span> </a>
											</li>
											<li data-target="#step2" style="width:30%" onclick="miaodian(this)">
												<a href="#tab2" data-toggle="tab"> <span class="step" style="font-size:15px;">2</span> <span class="title">解析列表</span> </a>
											</li>
											<li data-target="#step3" style="width:30%" onclick="miaodian(this)">
												<a href="#tab3" data-toggle="tab"> <span class="step" style="font-size:15px;">3</span> <span class="title">解析正文</span> </a>
											</li>
										</ul>
										<div class="clearfix"></div>
									</div>
								</div>
							</form>
						</div>
</div>
<div  title="Dialog Simple Title" class="col-sm-6" id="leftEditBox" style="overflow-y: scroll;height: 559px;margin-top: 74px;">
	
	<form class="form-horizontal col col-6" id="mainFrm">
		<fieldset >
			<legend id="tab1">
				基本信息
			</legend>
			<div class="form-group" name="textPageUrl" style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="">
				</div>
			</div>
			
			<div class="form-group" name="id" style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="${rule.id }">
				</div>
			</div>
			<div class="form-group" name="listLetOffHtmlunitFlag" style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="${rule.listLetOffHtmlunitFlag }">
				</div>
			</div>
			<div class="form-group" name="textLetOffHtmlunitFlag" style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="${rule.textLetOffHtmlunitFlag }">
				</div>
			</div>
			<div class="form-group" name="publicListRuleId" style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="${rule.publicListRuleId }">
				</div>
			</div>
			<div class="form-group" name="publicTextRuleId" style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="${rule.publicTextRuleId }">
				</div>
			</div>
			<div class="form-group" name="fetchStrategy" style="display:none;">
				<div class="col-sm-10">
					
					<input  type="text" placeholder="${rule.fetchStrategy }" value="${extraRule.fetchStrategy}">
				</div>
			</div>
			<div class="form-group" name="listDataType"  style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="${rule.listDataType }"/>
				</div>
			</div>
			<div class="form-group" name="textDataType"  style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="${rule.textDataType }"/>
				</div>
			</div>
			<div class="form-group siteId" name="siteId" style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="${siteId }">
				</div>
			</div>
			<div class="form-group " name="site" style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="${site}">
				</div>
			</div>
			<div class="form-group " name="siteUrl" style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="${siteUrl }">
				</div>
			</div>
			<div class="form-group" name="section" >
				<label class="control-label col-md-2">
					版块名称
				</label>
				<div class="col-sm-10">
					<input class="form-control" placeholder="" type="text" value="${rule.section }">
				</div>
			</div>
			<div class="form-group" name="sectionUrl" >
				<label class="control-label col-md-2">
					版块URL
				</label>
				<div class="col-md-10">
					<input class="form-control" placeholder="" type="text" value="${rule.sectionUrl }">
				</div>
			</div>
			<div class="form-group" name="frequency">
				<label class="control-label col-md-2">
					抓取频次
				</label>
				<div class="col-sm-5">
					<input class="form-control" placeholder="" type="text" value="${rule.frequency }">
				</div>
			</div>
			<div class="form-group" name="categoryId">
				<label class="control-label col-md-2">
					类别
				</label>
				<div class="col-sm-5">
					<input class="form-control" placeholder="" type="text" value="${rule.categoryId }">
				</div>
			</div>
			<div class="form-group" name="pageCutImageFlag">
				<label class="control-label col-md-2">
					是否需要网页截图
				</label>
				<div class="col-sm-5">
					<input class="form-control" placeholder="" type="text" value="${rule.pageCutImageFlag }">
				</div>
			</div>
			<legend id="tab2">
				<span style="float:left;">解析列表</span> 
				<span style="float:right;">
					<c:if test="${newsPublicListRuleName == null ||newsPublicListRuleName=='' }">
						<a class="glyphicon glyphicon-flag extends_flag" onclick="cancelExtends(this,0)" style="color:#ccc;text-decoration:none;" title="当前无继承模板" flag_title="当前无继承模板" href="javascript:void(0);" style="text-decoration: none;"></a>&nbsp;&nbsp;
					</c:if>
					<c:if test="${newsPublicListRuleName != null &&newsPublicListRuleName!='' }">
						<a class="glyphicon glyphicon-flag extends_flag"  onclick="cancelExtends(this,0)" data-placement="top" title="继承模板【${newsPublicListRuleName }】,点击取消继承" flag_title="继承模板【${newsPublicListRuleName }】" href="javascript:void(0);" style="text-decoration: none;"></a>&nbsp;&nbsp;
					</c:if>
					<a class="glyphicon glyphicon-cog" onclick="use_list_model()" title="使用模板" href="javascript:;" style="text-decoration: none;"></a>&nbsp;&nbsp;
					<a class="glyphicon glyphicon-arrow-up" onclick="ready_to_create_list_model()" title="生成模板" href="javascript:;" style="text-decoration: none;"></a>&nbsp;&nbsp;
					<label class="toggle" style="display:inline-block;">
						<span style="display:inline-block;height:20px;"></span>
						<input type="checkbox" name="open-list-type-flag" class="open-type-flag" checked="checked" onclick="changeListType(this)">
						<i data-swchon-text="HTML" data-swchoff-text="JSON" style="width: 53px;"></i>
					</label>
				
				</span>
				<div style="clear:both;"></div>
			</legend>
			
			<!-- html-box start -->
			<c:if test="${rule.publicListRuleId ==null}">
			<div class="html-box">
				<div class="form-group">
					<label class="control-label col-md-2">
						页面脚本:
					</label>
					<div class="col-md-5" style="padding-top: 7px;">
						<label class="toggle" style="display:inline-block;">
							<span style="display:inline-block;height:20px;"></span>
							<input type="checkbox" name="open-html-script-flag" class="open-html-script-flag" checked="checked" onclick="changeHtmlScriptOption(this)">
							<i data-swchon-text="开启" data-swchoff-text="关闭" style="width: 53px;"></i>
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2">
						抓取策略:
					</label>
					<div class="col-md-5" style="padding-top: 7px;">
						<c:if test="${rule.fetchStrategy==null ||rule.fetchStrategy==1}">
							<input type="radio" name="radio-fetch-strategy" checked="checked" t_value="1" onchange="changeFetchStrategy(1)">
							<a href="javascript:;" title="循环文章列表的时候，当遇到已经抓取过得文章的时候（判断标准为：URL相同），即跳出抓取循环，默认该条以下的文章都已经抓取过，不纳入返回的结果集。">策略一</a>
							<input type="radio" name="radio-fetch-strategy" t_value="2" onchange="changeFetchStrategy(2)">
							<a href="javascript:;" title="循环文章列表的时候，只要遇到已经抓取过得文章的时候（判断标准为：URL相同），仅该条不纳入结果集，继续循环下面的文章，如再遇到相同文章，重复以上操作，不会因为有相同文章而跳出循环，跳出循环的唯一依据是分页结束">策略二</a>
						</c:if>
						<c:if test="${rule.fetchStrategy!=null&&rule.fetchStrategy==2}">
							<label class="radio" style="display:inline-block">
								<input type="radio" name="radio-fetch-strategy"  t_value="1" onchange="changeFetchStrategy(1)">
							<a href="javascript:;" title="循环文章列表的时候，当遇到已经抓取过得文章的时候（判断标准为：URL相同），即跳出抓取循环，默认该条以下的文章都已经抓取过，不纳入返回的结果集。">策略一</a>
							</label>
							<label class="radio" style="display:inline-block">
								<input type="radio" name="radio-fetch-strategy" checked="checked" t_value="2" onchange="changeFetchStrategy(2)">
							<a href="javascript:;" title="循环文章列表的时候，只要遇到已经抓取过得文章的时候（判断标准为：URL相同），仅该条不纳入结果集，继续循环下面的文章，如再遇到相同文章，重复以上操作，不会因为有相同文章而跳出循环，跳出循环的唯一依据是分页结束">策略二</a>
							</label>
						</c:if>
					</div>
				</div>
				<div class="form-group" name="everyArticleSelector">
					<label class="control-label col-md-2">
						列表循环域
					</label>
					<div class="col-md-5">
						<span style="display:none"><xmp>${rule.everyArticleSelector }</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.everyArticleSelector }">
					</div>
				</div>
				<div class="form-group" name=listCharset>
					<label class="control-label col-md-2">
						列表字符集
					</label>
					<div class="col-md-5">
						<span style="display:none"><xmp>${rule.listCharset }</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.listCharset }">
					</div>
				</div>
				<div class="form-group" name="page">
					<label class="control-label col-md-2">
						抓取页数
					</label>
					<div class="col-md-5">
						<span style="display:none"><xmp>${rule.page }</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.page }">
					</div>
				</div>
				<c:if test="${rule.listUrlParserMap == null}">
				<div class="form-group" name="listUrlParserMap"> 
					<label class="control-label col-md-2">
						URL
					</label>
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text" value="">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
						</div>
				</div>
				</c:if>
				<c:if test="${rule.listUrlParserMap != null}">
					<c:forEach var="urlParserMap" items="${rule.listUrlParserMap }" varStatus="s">
						<div class="form-group" name="listUrlParserMap"> 
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								URL
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="selector" type="text" value="${urlParserMap.key }">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${urlParserMap.value }</xmp></span>
								<input class="form-control" placeholder="locator" type="text" value="${urlParserMap.value }">
							</div>
							<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
							
						</div>
				</c:forEach>
				</c:if>
				<c:if test="${rule.listTitleParserMap == null}">
					<div class="form-group" name="listTitleParserMap">	
						
						<label class="control-label col-md-2">
							标题
						</label>
							<div class="col-md-4">
								<input class="form-control" placeholder="selector" type="text" value="">
							</div>
							<div class="col-md-4">
								<input class="form-control" placeholder="locator" type="text" value="">
							</div>
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
					</div>
				</c:if>
				<c:if test="${rule.listTitleParserMap != null}">
					<c:forEach var="titleParserMap" items="${rule.listTitleParserMap }" varStatus="s">
						<div class="form-group" name="listTitleParserMap">
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								标题
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="selector" type="text"  value="${titleParserMap.key }">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${titleParserMap.value }</xmp></span>
								<input class="form-control" placeholder="locator" type="text" value="${titleParserMap.value }">
							</div>
							
							<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
						</div>
					</c:forEach>
				</c:if>
	
				<c:if test="${rule.listTimeParserMap == null}">
				<div class="form-group" name="listTimeParserMap">
					<label class="control-label col-md-2">
						发布时间
					</label>
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text" value="">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
						</div>
					
					
				</div>
				</c:if>
				<c:if test="${rule.listTimeParserMap != null}">
				<c:forEach var="timeParserMap" items="${rule.listTimeParserMap }"  varStatus="s">
					<div class="form-group" name="listTimeParserMap">
						<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								发布时间
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text"  value="${timeParserMap.key }">
						</div>
						<div class="col-md-4">
							<span style="display:none"><xmp>${timeParserMap.value }</xmp></span>
							<input class="form-control" placeholder="locator" type="text" value="${timeParserMap.value }">
						</div>
						<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
				</c:forEach>
				</c:if>
				<c:if test="${rule.listNextPageParserMap == null}">
				<div class="form-group" name="listNextPageParserMap">
					<label class="control-label col-md-2">
						列表下一页
					</label>
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text" value="">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
						</div>
					
					
				</div>
				</c:if>
				<c:if test="${rule.listNextPageParserMap != null}">	
					<c:forEach var="nextPageParserMap" items="${rule.listNextPageParserMap }" varStatus="s">
						<div class="form-group" name="listNextPageParserMap">
							<c:if test="${s.index==0}"> 
								<label class="control-label col-md-2">
									列表下一页
								</label>
								</c:if>
								<c:if test="${s.index>0}"> 
								<label class="control-label col-md-2">
								</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="selector" type="text"  value="${nextPageParserMap.key }">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${nextPageParserMap.value }</xmp></span>
								<input class="form-control" placeholder="locator" type="text" value="${nextPageParserMap.value }">
							</div>
							<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
							</div>
					</c:forEach>
					
				</c:if>
				<c:if test="${rule.listAdditionalParserMap == null}"><span style="display:none;" id="listAdditionalShowFlag"></span></c:if>
				<div class="form-group other" style="text-align:center;" ><a href="javascript:;" onclick="showOther(this)">添加其他</a></div>
				<c:if test="${rule.listAdditionalParserMap == null}">
				<div class="form-group listAdditionalParserMap" name="listAdditionalParserMap">
						<label class="control-label col-md-2">
							其他
						</label>
						<div class="col-md-2">
							<input class="form-control" placeholder="selector" type="text" value="">
						</div>
						<div class="col-md-3">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-3">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>
						</div>
				</div>
				</c:if>
				<c:forEach var="listAdditionalParserMap" items="${rule.listAdditionalParserMap }" varStatus="s">	
					<div class="form-group listAdditionalParserMap" name="listAdditionalParserMap">	
						<c:if test="${s.index==0}">
						<label class="control-label col-md-2">
							其他
						</label>
						</c:if>
						<c:if test="${s.index>0}">
						<label class="control-label col-md-2">
						</label>
						</c:if>
						<div class="col-md-2">
							<input class="form-control" placeholder="selector" type="text"  value="${listAdditionalParserMap.key }">
						</div>
						<c:forEach var="listAdditionalParserMap2" items="${listAdditionalParserMap.value }">
							<div class="col-md-3">
								<input class="form-control" placeholder="locator" type="text" value="${listAdditionalParserMap2.key }">
							</div>
							<div class="col-md-3">
								<span style="display:none"><xmp>${listAdditionalParserMap2.value }</xmp></span>
								<input class="form-control" placeholder="locator" type="text" value="${listAdditionalParserMap2.value }">
							</div>
						</c:forEach>
						<c:if test="${s.index==0}">
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>
							</div>
						</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</div>
			</c:if>
			<!-- html-box end -->
			
			<!-- 如果有列表模板的话 -->
			<!-- html-box start -->
			<c:if test="${rule.publicListRuleId !=null}">
			<div class="html-box">
				<div class="form-group">
					<label class="control-label col-md-2">
						页面脚本:
					</label>
					<div class="col-md-5" style="padding-top: 7px;">
						<label class="toggle" style="display:inline-block;">
							<span style="display:inline-block;height:20px;"></span>
							<input type="checkbox" name="open-html-script-flag" class="open-html-script-flag" checked="checked" onclick="changeHtmlScriptOption(this)">
							<i data-swchon-text="开启" data-swchoff-text="关闭" style="width: 53px;"></i>
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2">
						抓取策略:
					</label>
					<div class="col-md-5" style="padding-top: 7px;">
						<c:if test="${rule.fetchStrategy==null ||rule.fetchStrategy==1}">
							<input type="radio" name="radio-fetch-strategy" checked="checked" t_value="1" onchange="changeFetchStrategy(1)">
							<a href="javascript:;" title="循环文章列表的时候，当遇到已经抓取过得文章的时候（判断标准为：URL相同），即跳出抓取循环，默认该条以下的文章都已经抓取过，不纳入返回的结果集。"><a href="javascript:;" title="循环文章列表的时候，当遇到已经抓取过得文章的时候（判断标准为：URL相同），即跳出抓取循环，默认该条以下的文章都已经抓取过，不纳入返回的结果集。">策略一</a></a>
							<input type="radio" name="radio-fetch-strategy" t_value="2" onchange="changeFetchStrategy(2)">
							<a href="javascript:;" title="循环文章列表的时候，只要遇到已经抓取过得文章的时候（判断标准为：URL相同），仅该条不纳入结果集，继续循环下面的文章，如再遇到相同文章，重复以上操作，不会因为有相同文章而跳出循环，跳出循环的唯一依据是分页结束"><a href="javascript:;" title="循环文章列表的时候，只要遇到已经抓取过得文章的时候（判断标准为：URL相同），仅该条不纳入结果集，继续循环下面的文章，如再遇到相同文章，重复以上操作，不会因为有相同文章而跳出循环，跳出循环的唯一依据是分页结束">策略二</a></a>
						</c:if>
						<c:if test="${rule.fetchStrategy!=null&&rule.fetchStrategy==2}">
							<label class="radio" style="display:inline-block">
								<input type="radio" name="radio-fetch-strategy"  t_value="1" onchange="changeFetchStrategy(1)">
							<a href="javascript:;" title="循环文章列表的时候，当遇到已经抓取过得文章的时候（判断标准为：URL相同），即跳出抓取循环，默认该条以下的文章都已经抓取过，不纳入返回的结果集。">策略一</a>
							</label>
							<label class="radio" style="display:inline-block">
								<input type="radio" name="radio-fetch-strategy" checked="checked" t_value="2" onchange="changeFetchStrategy(2)">
							<a href="javascript:;" title="循环文章列表的时候，只要遇到已经抓取过得文章的时候（判断标准为：URL相同），仅该条不纳入结果集，继续循环下面的文章，如再遇到相同文章，重复以上操作，不会因为有相同文章而跳出循环，跳出循环的唯一依据是分页结束">策略二</a>
							</label>
							
						</c:if>
					</div>
				</div>
				<div class="form-group" name="everyArticleSelector">
					<label class="control-label col-md-2">
						列表循环域
					</label>
					<div class="col-md-5">
						<span style="display:none"><xmp>${extraRule.everyArticleSelector==null?rule.everyArticleSelector:extraRule.everyArticleSelector }</xmp></span>
						<input class="form-control" placeholder="${rule.everyArticleSelector }" type="text" value="${extraRule.everyArticleSelector }">
					</div>
				</div>
				<div class="form-group" name=listCharset>
					<label class="control-label col-md-2">
						列表字符集
					</label>
					<div class="col-md-5">
						
						<span style="display:none"><xmp>${extraRule.listCharset==null?rule.listCharset:extraRule.listCharset }</xmp></span>
						<input class="form-control" placeholder="${rule.listCharset }" type="text" value="${extraRule.listCharset }">
					</div>
				</div>
				<div class="form-group" name="page">
					<label class="control-label col-md-2">
						抓取页数
					</label>
					<div class="col-md-5">
						<span style="display:none"><xmp>${extraRule.page==null?rule.page:extraRule.page }</xmp></span>
						<input class="form-control" placeholder="${rule.page }" type="text" value="${extraRule.page }">
					</div>
				</div>
				<c:if test="${rule.listUrlParserMap == null&&extraRule.listUrlParserMap == null}">
				<div class="form-group" name="listUrlParserMap"> 
					<label class="control-label col-md-2">
						URL
					</label>
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text" value="">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
						</div>
				</div>
				</c:if>
				<c:if test="${extraRule.listUrlParserMap != null}">
					<c:forEach var="urlParserMap" items="${extraRule.listUrlParserMap }" varStatus="s">
						<div class="form-group" name="listUrlParserMap"> 
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								URL
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="" type="text" value="${urlParserMap.key }">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${urlParserMap.value }</xmp></span>
								<input class="form-control" placeholder="" type="text" value="${urlParserMap.value }">
							</div>
							<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
							
						</div>
				</c:forEach>
				</c:if>
				<c:if test="${rule.listUrlParserMap != null&&extraRule.listUrlParserMap == null}">
					<c:forEach var="urlParserMap" items="${rule.listUrlParserMap }" varStatus="s">
						<div class="form-group" name="listUrlParserMap"> 
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								URL
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="${urlParserMap.key }" type="text" value="">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${urlParserMap.value }</xmp></span>
								<input class="form-control" placeholder="${urlParserMap.value }" type="text" value="">
							</div>
							<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
							
						</div>
				</c:forEach>
				</c:if>
				
				
				
				<c:if test="${rule.listTitleParserMap == null&&extraRule.listTitleParserMap == null}">
					<div class="form-group" name="listTitleParserMap">	
						
						<label class="control-label col-md-2">
							标题
						</label>
							<div class="col-md-4">
								<input class="form-control" placeholder="selector" type="text" value="">
							</div>
							<div class="col-md-4">
								<input class="form-control" placeholder="locator" type="text" value="">
							</div>
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
					</div>
				</c:if>
				
				<c:if test="${extraRule.listTitleParserMap != null}">
					<c:forEach var="titleParserMap" items="${extraRule.listTitleParserMap }" varStatus="s">
						<div class="form-group" name="listTitleParserMap">
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								标题
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="" type="text"  value="${titleParserMap.key }">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${titleParserMap.value }</xmp></span>
								<input class="form-control" placeholder="" type="text" value="${titleParserMap.value }">
							</div>
							
							<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${rule.listTitleParserMap != null&&extraRule.listTitleParserMap == null}">
					<c:forEach var="titleParserMap" items="${rule.listTitleParserMap }" varStatus="s">
						<div class="form-group" name="listTitleParserMap">
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								标题
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="${titleParserMap.key }" type="text"  value="">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${titleParserMap.value }</xmp></span>
								<input class="form-control" placeholder="${titleParserMap.value }" type="text" value="">
							</div>
							
							<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
						</div>
					</c:forEach>
				</c:if>
	
				<c:if test="${rule.listTimeParserMap == null&&extraRule.listTimeParserMap == null}">
				<div class="form-group" name="listTimeParserMap">
					<label class="control-label col-md-2">
						发布时间
					</label>
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text" value="">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
						</div>
					
					
				</div>
				</c:if>
				
				<c:if test="${extraRule.listTimeParserMap != null}">
				<c:forEach var="timeParserMap" items="${extraRule.listTimeParserMap }"  varStatus="s">
					<div class="form-group" name="listTimeParserMap">
						<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								发布时间
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="" type="text"  value="${timeParserMap.key }">
						</div>
						<div class="col-md-4">
							<span style="display:none"><xmp>${timeParserMap.value }</xmp></span>
							<input class="form-control" placeholder="" type="text" value="${timeParserMap.value }">
						</div>
						<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
				</c:forEach>
				</c:if>
				<c:if test="${rule.listTimeParserMap != null&&extraRule.listTimeParserMap == null}">
				<c:forEach var="timeParserMap" items="${rule.listTimeParserMap }"  varStatus="s">
					<div class="form-group" name="listTimeParserMap">
						<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								发布时间
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="${timeParserMap.key }" type="text"  value="">
						</div>
						<div class="col-md-4">
							<span style="display:none"><xmp>${timeParserMap.value }</xmp></span>
							<input class="form-control" placeholder="${timeParserMap.value }" type="text" value="">
						</div>
						<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
				</c:forEach>
				</c:if>
				
				
				<c:if test="${rule.listNextPageParserMap == null&&extraRule.listNextPageParserMap == null}">
				<div class="form-group" name="listNextPageParserMap">
					<label class="control-label col-md-2">
						列表下一页
					</label>
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text" value="">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
						</div>
					
					
				</div>
				</c:if>
				
				<c:if test="${extraRule.listNextPageParserMap != null}">	
					<c:forEach var="nextPageParserMap" items="${extraRule.listNextPageParserMap }" varStatus="s">
						<div class="form-group" name="listNextPageParserMap">
							<c:if test="${s.index==0}"> 
								<label class="control-label col-md-2">
									列表下一页
								</label>
								</c:if>
								<c:if test="${s.index>0}"> 
								<label class="control-label col-md-2">
								</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="" type="text"  value="${nextPageParserMap.key }">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${nextPageParserMap.value }</xmp></span>
								<input class="form-control" placeholder="" type="text" value="${nextPageParserMap.value }">
							</div>
							<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
							</div>
					</c:forEach>
					
				</c:if>
				<c:if test="${rule.listNextPageParserMap != null&&extraRule.listNextPageParserMap == null}">	
					<c:forEach var="nextPageParserMap" items="${rule.listNextPageParserMap }" varStatus="s">
						<div class="form-group" name="listNextPageParserMap">
							<c:if test="${s.index==0}"> 
								<label class="control-label col-md-2">
									列表下一页
								</label>
								</c:if>
								<c:if test="${s.index>0}"> 
								<label class="control-label col-md-2">
								</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="${nextPageParserMap.key }" type="text"  value="">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${nextPageParserMap.value }</xmp></span>
								<input class="form-control" placeholder="${nextPageParserMap.value }" type="text" value="">
							</div>
							<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
							</div>
					</c:forEach>
					
				</c:if>
				<c:if test="${rule.listAdditionalParserMap == null&&extraRule.listAdditionalParserMap == null}"><span style="display:none;" id="listAdditionalShowFlag"></span></c:if>
				<div class="form-group other" style="text-align:center;" ><a href="javascript:;" onclick="showOther(this)">添加其他</a></div>
				<c:if test="${rule.listAdditionalParserMap == null&&extraRule.listAdditionalParserMap == null}">
				<div class="form-group listAdditionalParserMap" name="listAdditionalParserMap">
						<label class="control-label col-md-2">
							其他
						</label>
						<div class="col-md-2">
							<input class="form-control" placeholder="selector" type="text" value="">
						</div>
						<div class="col-md-3">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-3">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>
						</div>
				</div>
				</c:if>
				<c:if test="${extraRule.listAdditionalParserMap != null}">
					<c:forEach var="listAdditionalParserMap" items="${extraRule.listAdditionalParserMap }" varStatus="s">	
						<div class="form-group listAdditionalParserMap" name="listAdditionalParserMap">	
							<c:if test="${s.index==0}">
							<label class="control-label col-md-2">
								其他
							</label>
							</c:if>
							<c:if test="${s.index>0}">
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-2">
								<input class="form-control" placeholder="" type="text"  value="${listAdditionalParserMap.key }">
							</div>
							<c:forEach var="listAdditionalParserMap2" items="${listAdditionalParserMap.value }">
								<div class="col-md-3">
									<input class="form-control" placeholder="" type="text" value="${listAdditionalParserMap2.key }">
								</div>
								<div class="col-md-3">
									<span style="display:none"><xmp>${listAdditionalParserMap2.value }</xmp></span>
									<input class="form-control" placeholder="" type="text" value="${listAdditionalParserMap2.value }">
								</div>
							</c:forEach>
							<c:if test="${s.index==0}">
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${rule.listAdditionalParserMap != null&&extraRule.listAdditionalParserMap == null}">
					<c:forEach var="listAdditionalParserMap" items="${rule.listAdditionalParserMap }" varStatus="s">	
						<div class="form-group listAdditionalParserMap" name="listAdditionalParserMap">	
							<c:if test="${s.index==0}">
							<label class="control-label col-md-2">
								其他
							</label>
							</c:if>
							<c:if test="${s.index>0}">
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-2">
								<input class="form-control" placeholder="${listAdditionalParserMap.key }" type="text"  value="">
							</div>
							<c:forEach var="listAdditionalParserMap2" items="${listAdditionalParserMap.value }">
								<div class="col-md-3">
									<input class="form-control" placeholder="${listAdditionalParserMap2.key }" type="text" value="">
								</div>
								<div class="col-md-3">
									<span style="display:none"><xmp>${listAdditionalParserMap2.value }</xmp></span>
									<input class="form-control" placeholder="${listAdditionalParserMap2.value }" type="text" value="">
								</div>
							</c:forEach>
							<c:if test="${s.index==0}">
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
						</div>
					</c:forEach>
				</c:if>
			</div>
			</c:if>
			<!-- html-box end -->
			
			<!-- json-box start -->
			<c:if test="${rule.publicListRuleId==null}">
			<div class="json-box">
				<div class="form-group">
					<label class="control-label col-md-2">
						页面脚本:
					</label>
					<div class="col-md-5" style="padding-top: 7px;">
						<label class="toggle" style="display:inline-block;">
							<span style="display:inline-block;height:20px;"></span>
							<input type="checkbox" name="open-html-script-flag" class="open-html-script-flag" checked="checked" onclick="changeHtmlScriptOption(this)">
							<i data-swchon-text="开启" data-swchoff-text="关闭" style="width: 53px;"></i>
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2">
						抓取策略:
					</label>
					<div class="col-md-5" style="padding-top: 7px;">
						<c:if test="${rule.fetchStrategy==null ||rule.fetchStrategy==1}">
							<input type="radio" name="radio-fetch-strategy2" checked="checked" t_value="1" onchange="changeFetchStrategy(1)">
							<a href="javascript:;" title="循环文章列表的时候，当遇到已经抓取过得文章的时候（判断标准为：URL相同），即跳出抓取循环，默认该条以下的文章都已经抓取过，不纳入返回的结果集。"><a href="javascript:;" title="循环文章列表的时候，当遇到已经抓取过得文章的时候（判断标准为：URL相同），即跳出抓取循环，默认该条以下的文章都已经抓取过，不纳入返回的结果集。">策略一</a></a>
							<input type="radio" name="radio-fetch-strategy2" t_value="2" onchange="changeFetchStrategy(2)">
							<a href="javascript:;" title="循环文章列表的时候，只要遇到已经抓取过得文章的时候（判断标准为：URL相同），仅该条不纳入结果集，继续循环下面的文章，如再遇到相同文章，重复以上操作，不会因为有相同文章而跳出循环，跳出循环的唯一依据是分页结束"><a href="javascript:;" title="循环文章列表的时候，只要遇到已经抓取过得文章的时候（判断标准为：URL相同），仅该条不纳入结果集，继续循环下面的文章，如再遇到相同文章，重复以上操作，不会因为有相同文章而跳出循环，跳出循环的唯一依据是分页结束">策略二</a></a>
						</c:if>
						<c:if test="${rule.fetchStrategy!=null&&rule.fetchStrategy==2}">
							<label class="radio" style="display:inline-block">
								<input type="radio" name="radio-fetch-strategy2"  t_value="1" onchange="changeFetchStrategy(1)">
							<a href="javascript:;" title="循环文章列表的时候，当遇到已经抓取过得文章的时候（判断标准为：URL相同），即跳出抓取循环，默认该条以下的文章都已经抓取过，不纳入返回的结果集。">策略一</a>
							</label>
							<label class="radio" style="display:inline-block">
								<input type="radio" name="radio-fetch-strategy2" checked="checked" t_value="2" onchange="changeFetchStrategy(2)">
							<a href="javascript:;" title="循环文章列表的时候，只要遇到已经抓取过得文章的时候（判断标准为：URL相同），仅该条不纳入结果集，继续循环下面的文章，如再遇到相同文章，重复以上操作，不会因为有相同文章而跳出循环，跳出循环的唯一依据是分页结束">策略二</a>
							</label>
							
						</c:if>
					</div>
				</div>
				<div class="form-group" name="listFormData" >
					<label class="control-label col-md-2">
						post提交的参数
					</label>
					<div class="col-sm-10">
						<span style="display:none"><xmp>${rule.listFormData}</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.listFormData }">
					</div>
				</div>
				<div class="form-group" name=listCharset>
					<label class="control-label col-md-2">
						列表字符集
					</label>
					<div class="col-md-5">
						<span style="display:none"><xmp>${rule.listCharset}</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.listCharset }">
					</div>
				</div>
				<div class="form-group" name="page">
					<label class="control-label col-md-2">
						抓取页数
					</label>
					<div class="col-md-5">
						<input class="form-control" placeholder="" type="text" value="${rule.page }">
					</div>
				</div>
				<div class="form-group" name="listReplaceStr" >
					<label class="control-label col-md-2">
						需要replace的字符串
					</label>
					<div class="col-sm-10">
						<span style="display:none"><xmp>${rule.listReplaceStr}</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.listReplaceStr }">
					</div>
				</div>
		
				<div class="form-group" name="listPageKey" >
					<label class="control-label col-md-2">
						控制页码的参数
					</label>
					<div class="col-sm-10">
						<span style="display:none"><xmp>${rule.listPageKey}</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.listPageKey }">
					</div>
				</div>
				<div class="form-group" name="listListKey" >
					<label class="control-label col-md-2">
						列表页的key
					</label>
					<div class="col-sm-10">
						<span style="display:none"><xmp>${rule.listListKey}</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.listListKey }">
					</div>
				</div>
				<div class="form-group" name="listCountLimit" >
					<label class="control-label col-md-2">
						列表取前几条
					</label>
					<div class="col-sm-10">
						<span style="display:none"><xmp>${rule.listCountLimit}</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.listCountLimit }">
					</div>
				</div>
				<div class="form-group" name="listTitleKey" >
					<label class="control-label col-md-2">
						列表页标题
					</label>
					<div class="col-sm-10">
						<span style="display:none"><xmp>${rule.listTitleKey}</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.listTitleKey }">
					</div>
				</div>
				<div class="form-group" name="listUrlKey" >
					<label class="control-label col-md-2">
						列表页URL
					</label>
					<div class="col-sm-10">
						<span style="display:none"><xmp>${rule.listUrlKey}</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.listUrlKey }">
					</div>
				</div>
				<div class="form-group" name="listRealUrlKey" >
					<label class="control-label col-md-2">
						真实URL
					</label>
					<div class="col-sm-10">
						<span style="display:none"><xmp>${rule.listRealUrlKey}</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.listRealUrlKey }">
					</div>
				</div>
				
				<div class="form-group" name="listTimeKey" >
					<label class="control-label col-md-2">
						列表页时间
					</label>
					<div class="col-sm-10">
						<span style="display:none"><xmp>${rule.listTimeKey}</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.listTimeKey }">
					</div>
				</div>
				<div class="form-group" name="listStopFlag" >
					<label class="control-label col-md-2">
						列表页分页请求 停止标志
					</label>
					<div class="col-sm-10">
						<span style="display:none"><xmp>${rule.listStopFlag}</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.listStopFlag }">
					</div>
				</div>
				<c:if test="${rule.listAdditionalKey == null}">
				<div class="form-group" name="listAdditionalKey">
					<label class="control-label col-md-2">
						列表页额外添加的字段
					</label>
					
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text" value="">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
						</div>
					
					
				</div>
				</c:if>
				<c:if test="${rule.listAdditionalKey!= null}">
					<c:forEach var="listAdditionalKey" items="${rule.listAdditionalKey }" varStatus="s">
					<div class="form-group" name="listAdditionalKey">
						<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								列表页额外添加的字段
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text"  value="${listAdditionalKey.key }">
						</div>
						<div class="col-md-4">
							<span style="display:none"><xmp>${listAdditionalKey.value}</xmp></span>
							<input class="form-control" placeholder="locator" type="text" value="${listAdditionalKey.value }">
						</div>
						<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
					</c:forEach>
				</c:if>
			</div>
			<!-- json-box end -->
			</c:if>
			
			<!-- 如果有模板的话 -->
			<c:if test="${rule.publicListRuleId!=null}">
			<!-- json-box start -->
			<div class="json-box">
				<div class="form-group">
					<label class="control-label col-md-2">
						页面脚本:
					</label>
					<div class="col-md-5" style="padding-top: 7px;">
						<label class="toggle" style="display:inline-block;">
							<span style="display:inline-block;height:20px;"></span>
							<input type="checkbox" name="open-html-script-flag" class="open-html-script-flag" checked="checked" onclick="changeHtmlScriptOption(this)">
							<i data-swchon-text="开启" data-swchoff-text="关闭" style="width: 53px;"></i>
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2">
						抓取策略:
					</label>
					<div class="col-md-5" style="padding-top: 7px;">
						<c:if test="${rule.fetchStrategy==null ||rule.fetchStrategy==1}">
							<input type="radio" name="radio-fetch-strategy2" checked="checked" t_value="1" onchange="changeFetchStrategy(1)">
							<a href="javascript:;" title="循环文章列表的时候，当遇到已经抓取过得文章的时候（判断标准为：URL相同），即跳出抓取循环，默认该条以下的文章都已经抓取过，不纳入返回的结果集。"><a href="javascript:;" title="循环文章列表的时候，当遇到已经抓取过得文章的时候（判断标准为：URL相同），即跳出抓取循环，默认该条以下的文章都已经抓取过，不纳入返回的结果集。">策略一</a></a>
							<input type="radio" name="radio-fetch-strategy2" t_value="2" onchange="changeFetchStrategy(2)">
							<a href="javascript:;" title="循环文章列表的时候，只要遇到已经抓取过得文章的时候（判断标准为：URL相同），仅该条不纳入结果集，继续循环下面的文章，如再遇到相同文章，重复以上操作，不会因为有相同文章而跳出循环，跳出循环的唯一依据是分页结束"><a href="javascript:;" title="循环文章列表的时候，只要遇到已经抓取过得文章的时候（判断标准为：URL相同），仅该条不纳入结果集，继续循环下面的文章，如再遇到相同文章，重复以上操作，不会因为有相同文章而跳出循环，跳出循环的唯一依据是分页结束">策略二</a></a>
						</c:if>
						<c:if test="${rule.fetchStrategy!=null&&rule.fetchStrategy==2}">
							<label class="radio" style="display:inline-block">
								<input type="radio" name="radio-fetch-strategy2"  t_value="1" onchange="changeFetchStrategy(1)">
							<a href="javascript:;" title="循环文章列表的时候，当遇到已经抓取过得文章的时候（判断标准为：URL相同），即跳出抓取循环，默认该条以下的文章都已经抓取过，不纳入返回的结果集。">策略一</a>
							</label>
							<label class="radio" style="display:inline-block">
								<input type="radio" name="radio-fetch-strategy2" checked="checked" t_value="2" onchange="changeFetchStrategy(2)">
							<a href="javascript:;" title="循环文章列表的时候，只要遇到已经抓取过得文章的时候（判断标准为：URL相同），仅该条不纳入结果集，继续循环下面的文章，如再遇到相同文章，重复以上操作，不会因为有相同文章而跳出循环，跳出循环的唯一依据是分页结束">策略二</a>
							</label>
							
						</c:if>
					</div>
				</div>
				<div class="form-group" name="listFormData" >
					<label class="control-label col-md-2">
						post提交的参数
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.listFormData }" type="text" value="${extraRule.listFormData }">
					</div>
				</div>
				<div class="form-group" name=listCharset>
					<label class="control-label col-md-2">
						列表字符集
					</label>
					<div class="col-md-5">
						<input class="form-control" placeholder="${rule.listCharset }" type="text" value="${extraRule.listCharset }">
					</div>
				</div>
				<div class="form-group" name="page">
					<label class="control-label col-md-2">
						抓取页数
					</label>
					<div class="col-md-5">
						<input class="form-control" placeholder="${rule.page }" type="text" value="${extraRule.page }">
					</div>
				</div>
				<div class="form-group" name="listReplaceStr" >
					<label class="control-label col-md-2">
						需要replace的字符串
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.listReplaceStr }" type="text" value="${extraRule.listReplaceStr }">
					</div>
				</div>
		
				<div class="form-group" name="listPageKey" >
					<label class="control-label col-md-2">
						控制页码的参数
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.listPageKey }" type="text" value="${extraRule.listPageKey }">
					</div>
				</div>
				<div class="form-group" name="listListKey" >
					<label class="control-label col-md-2">
						列表页的key
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.listListKey }" type="text" value="${extraRule.listListKey }">
					</div>
				</div>
				<div class="form-group" name="listRealUrlKey" >
					<label class="control-label col-md-2">
						真实URL
					</label>
					<div class="col-sm-10">
						<span style="display:none"><xmp>${rule.listRealUrlKey}</xmp></span>
						<input class="form-control" placeholder="${rule.listRealUrlKey }" type="text" value="${extraRule.listRealUrlKey }">
					</div>
				</div>
				<div class="form-group" name="listCountLimit" >
					<label class="control-label col-md-2">
						列表取前几条
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.listCountLimit }" type="text" value="${extraRule.listCountLimit }">
					</div>
				</div>
				<div class="form-group" name="listTitleKey" >
					<label class="control-label col-md-2">
						列表页标题
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.listTitleKey }" type="text" value="${extraRule.listTitleKey }">
					</div>
				</div>
				<div class="form-group" name="listUrlKey" >
					<label class="control-label col-md-2">
						列表页URL
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.listUrlKey }" type="text" value="${extraRule.listUrlKey }">
					</div>
				</div>
				<div class="form-group" name="listTimeKey" >
					<label class="control-label col-md-2">
						列表页时间
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.listTimeKey }" type="text" value="${extraRule.listTimeKey }">
					</div>
				</div>
				<div class="form-group" name="listStopFlag" >
					<label class="control-label col-md-2">
						列表页分页请求 停止标志
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.listStopFlag }" type="text" value="${extraRule.listStopFlag }">
					</div>
				</div>
				<c:if test="${rule.listAdditionalKey == null&&extraRule.listAdditionalKey == null}">
				<div class="form-group" name="listAdditionalKey">
					<label class="control-label col-md-2">
						列表页额外添加的字段
					</label>
					
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text" value="">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
						</div>
					
					
				</div>
				</c:if>
				<c:if test="${extraRule.listAdditionalKey != null}">
					<c:forEach var="listAdditionalKey" items="${extraRule.listAdditionalKey }" varStatus="s">
					<div class="form-group" name="listAdditionalKey">
						<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								列表页额外添加的字段
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="" type="text"  value="${listAdditionalKey.key }">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="" type="text" value="${listAdditionalKey.value }">
						</div>
						<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
					</c:forEach>
				</c:if>
				<c:if test="${rule.listAdditionalKey!= null&&extraRule.listAdditionalKey == null}">
					<c:forEach var="listAdditionalKey" items="${rule.listAdditionalKey }" varStatus="s">
					<div class="form-group" name="listAdditionalKey">
						<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								列表页额外添加的字段
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="${listAdditionalKey.key }" type="text"  value="">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="${listAdditionalKey.value }" type="text" value="">
						</div>
						<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
					</c:forEach>
				</c:if>
			</div>
			<!-- json-box end -->
			</c:if>
			<legend id="tab3">
				<span style="float:left;">解析正文</span> 
				<span style="float:right;">
					<c:if test="${newsPublicTextRuleName == null ||newsPublicTextRuleName=='' }">
						<a class="glyphicon glyphicon-flag extends_flag"  onclick="cancelExtends(this,1)" style="color:#ccc;text-decoration:none;" title="当前无继承模板" flag_title="当前无继承模板" rel="tooltip" href="javascript:void(0);" style="text-decoration: none;"></a>&nbsp;&nbsp;
					</c:if>
					<c:if test="${newsPublicTextRuleName != null &&newsPublicTextRuleName!='' }">
						<a class="glyphicon glyphicon-flag extends_flag"   onclick="cancelExtends(this,1)" title="继承模板【${newsPublicTextRuleName }】,点击取消继承" flag_title="继承模板【${newsPublicTextRuleName }】" href="javascript:void(0);" style="text-decoration: none;"></a>&nbsp;&nbsp;
					</c:if>
					<a class="glyphicon glyphicon-cog" onclick="use_text_model()" title="使用模板" href="javascript:;" style="text-decoration: none;"></a>&nbsp;&nbsp;
					<a class="glyphicon glyphicon-arrow-up" onclick="ready_to_create_text_model()" title="生成模板" href="javascript:;" style="text-decoration: none;"></a>
					<label class="toggle" style="display:inline-block;">
						<span style="display:inline-block;height:20px;"></span>
						<input type="checkbox" name="open-list-type-flag" class="open-type-flag" checked="checked" onclick="changeListType(this)">
						<i data-swchon-text="HTML" data-swchoff-text="JSON" style="width: 53px;"></i>
					</label>
				</span> 
				<div style="clear:both;"></div>
			</legend>
			<!-- html-box2 start -->
			
			<c:if test="${rule.publicTextRuleId ==null}">
			
			<div class="html-box">
			<div class="form-group">
				<label class="control-label col-md-2">
					页面脚本:
				</label>
				<div class="col-md-5" style="padding-top: 7px;">
					<label class="toggle" style="display:inline-block;">
						<span style="display:inline-block;height:20px;"></span>
						<input type="checkbox" name="open-html-script-flag" class="open-html-script-flag" checked="checked" onclick="changeHtmlScriptOption(this)">
						<i data-swchon-text="开启" data-swchoff-text="关闭" style="width: 53px;"></i>
					</label>
				</div>
			</div>
			<div class="form-group" name="textCharset">
				<label class="control-label col-md-2">
					正文字符集
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${rule.textCharset }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${rule.textCharset }">
				</div>
			</div>
			
			<c:if test="${rule.textContentParserMap == null}">
			<div class="form-group" name="textContentParserMap">
				<label class="control-label col-md-2">
					内容
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${urlParserMap.key }">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="${urlParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${rule.textContentParserMap!= null}">
				<c:forEach var="contentParserMap" items="${rule.textContentParserMap }" varStatus="s">
				<div class="form-group" name="textContentParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							内容
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text"  value="${contentParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${contentParserMap.value }</xmp></span>
						<input class="form-control" placeholder="locator" type="text" value="${contentParserMap.value }">
					</div>
					<c:if test="${s.index==0}"> 
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
						</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textImgUrlsParserMap == null}">
			<div class="form-group" name="textImgUrlsParserMap">
				<label class="control-label col-md-2">
					图片链接地址
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${urlParserMap.key }">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="${urlParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
				</div>
				
				
			</div>
			</c:if>
			<c:if test="${rule.textImgUrlsParserMap != null}">
			<c:forEach var="imgUrlsParserMap" items="${rule.textImgUrlsParserMap }" varStatus="s">
				<div class="form-group" name="textImgUrlsParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							图片链接地址
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text"  value="${imgUrlsParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${imgUrlsParserMap.value }</xmp></span>
						<input class="form-control" placeholder="locator" type="text" value="${imgUrlsParserMap.value }">
					</div>
					<c:if test="${s.index==0}"> 
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
						</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textAuthorParserMap == null}">
			<div class="form-group" name="textAuthorParserMap">
				<label class="control-label col-md-2">
					作者
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${urlParserMap.key }">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="${urlParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${rule.textAuthorParserMap != null}">
			<c:forEach var="authorParserMap" items="${rule.textAuthorParserMap }" varStatus="s">
				<div class="form-group" name="textAuthorParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							作者
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text"  value="${authorParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${authorParserMap.value }</xmp></span>
						<input class="form-control" placeholder="locator" type="text"  value="${authorParserMap.value }">
					</div>
					<c:if test="${s.index==0}"> 
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
						</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textSourceParserMap == null}">
			<div class="form-group" name="textSourceParserMap">
				<label class="control-label col-md-2">
					来源
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${urlParserMap.key }">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="${urlParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${rule.textSourceParserMap != null}">
				<c:forEach var="sourceParserMap" items="${rule.textSourceParserMap }" varStatus="s">
						<div class="form-group" name="textSourceParserMap">
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								来源
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="selector" type="text"  value="${sourceParserMap.key }">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${sourceParserMap.value }</xmp></span>
								<input class="form-control" placeholder="locator" type="text" value="${sourceParserMap.value }">
							</div>
							<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
						</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textReplyParserMap == null}">
			<div class="form-group" name="textReplyParserMap">
				<label class="control-label col-md-2">
					回复
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${urlParserMap.key }">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="${urlParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
				</div>
				
				
			</div>
			</c:if>
			<c:if test="${rule.textReplyParserMap != null}">
				<c:forEach var="replyParserMap" items="${rule.textReplyParserMap }" varStatus="s">
					<div class="form-group" name="textReplyParserMap">
						<c:if test="${s.index==0}"> 
								<label class="control-label col-md-2">
									回复
								</label>
								</c:if>
								<c:if test="${s.index>0}"> 
								<label class="control-label col-md-2">
								</label>
								</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text"  value="${replyParserMap.key }">
						</div>
						<div class="col-md-4">
							<span style="display:none"><xmp>${replyParserMap.value }</xmp></span>
							<input class="form-control" placeholder="locator" type="text" value="${replyParserMap.value }">
						</div>
						<c:if test="${s.index==0}"> 
									<div class="col-md-2">
											<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
									</div>
								</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textClickParserMap == null}">
			<div class="form-group" name="textClickParserMap">
				<label class="control-label col-md-2">
					点击
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${urlParserMap.key }">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="${urlParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${rule.textClickParserMap != null}">
				<c:forEach var="clickParserMap" items="${rule.textClickParserMap }" varStatus="s">
					<div class="form-group" name="textClickParserMap">
						<c:if test="${s.index==0}"> 
										<label class="control-label col-md-2">
											点击
										</label>
										</c:if>
										<c:if test="${s.index>0}"> 
										<label class="control-label col-md-2">
										</label>
										</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text"  value="${clickParserMap.key }">
						</div>
						<div class="col-md-4">
							<span style="display:none"><xmp>${clickParserMap.value }</xmp></span>
							<input class="form-control" placeholder="locator" type="text" value="${clickParserMap.value }">
						</div>
						<c:if test="${s.index==0}"> 
											<div class="col-md-2">
													<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
											</div>
										</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textTimeParserMap == null}">
			<div class="form-group" name="textTimeParserMap">
				<label class="control-label col-md-2">
					发布时间
				</label>
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${rule.textTimeParserMap != null}">
			<c:forEach var="timeParserMap" items="${rule.textTimeParserMap }"  varStatus="s">
				<div class="form-group" name="textTimeParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							发布时间
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text"  value="${timeParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${timeParserMap.value }</xmp></span>
						<input class="form-control" placeholder="locator" type="text" value="${timeParserMap.value }">
					</div>
					<c:if test="${s.index==0}"> 
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
						</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
			</c:forEach>
			</c:if>
			<c:if test="${rule.textNextPageParserMap == null}">
			<div class="form-group" name="textNextPageParserMap">
				<label class="control-label col-md-2">
					正文下一页
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${urlParserMap.key }">
					</div>
					<div class="col-md-4">
						
						<input class="form-control" placeholder="locator" type="text" value="${urlParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${rule.textNextPageParserMap != null}">
			<c:forEach var="nextPageParserMap" items="${rule.textNextPageParserMap }" varStatus="s">
				<div class="form-group" name="textNextPageParserMap">
					<c:if test="${s.index==0}"> 
											<label class="control-label col-md-2">
												正文下一页
											</label>
											</c:if>
											<c:if test="${s.index>0}"> 
											<label class="control-label col-md-2">
											</label>
											</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text"  value="${nextPageParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${nextPageParserMap.value }</xmp></span>
						<input class="form-control" placeholder="locator" type="text" value="${nextPageParserMap.value }">
					</div>
					<c:if test="${s.index==0}"> 
												<div class="col-md-2">
														<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
												</div>
											</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textAdditionalParserMap == null}"><span style="display:none;" id="textAdditionalShowFlag"></span></c:if>
			<div class="form-group other" style="text-align:center;"><a href="javascript:;" onclick="showOther(this)">添加其他</a></div>
			<c:if test="${rule.textAdditionalParserMap == null}">
			<div class="form-group textAdditionalParserMap" name="textAdditionalParserMap">
					<label class="control-label col-md-2">
						其他
					</label>
					<div class="col-md-2">
						<input class="form-control" placeholder="selector" type="text" value="">
					</div>
					<div class="col-md-3">
						<input class="form-control" placeholder="locator" type="text" value="">
					</div>
					<div class="col-md-3">
						<input class="form-control" placeholder="locator" type="text" value="">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>
					</div>
			</div>
			</c:if>
			<c:forEach var="textAdditionalParserMap" items="${rule.textAdditionalParserMap }" varStatus="s">	
				<div class="form-group textAdditionalParserMap" name="textAdditionalParserMap">	
					<c:if test="${s.index==0}">
					<label class="control-label col-md-2">
						其他
					</label>
					</c:if>
					<c:if test="${s.index>0}">
					<label class="control-label col-md-2">
					</label>
					</c:if>
					<div class="col-md-2">
						<input class="form-control" placeholder="selector" type="text"  value="${textAdditionalParserMap.key }">
					</div>
					<c:forEach var="textAdditionalParserMap2" items="${textAdditionalParserMap.value }">
						<div class="col-md-3">
							<input class="form-control" placeholder="locator" type="text" value="${textAdditionalParserMap2.key }">
						</div>
						<div class="col-md-3">
							<span style="display:none"><xmp>${textAdditionalParserMap2.value }</xmp></span>
							<input class="form-control" placeholder="locator" type="text" value="${textAdditionalParserMap2.value }">
						</div>
					</c:forEach>
					<c:if test="${s.index==0}">
						<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>
						</div>
					</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
			</c:forEach>
			</div>
			</c:if>
			<!-- html-box2 end -->
			<!-- 如果有正文模板的话 -->
			<!-- html-box2 start -->
			
			<c:if test="${rule.publicTextRuleId !=null}">
			<div class="html-box">
			
			<div class="form-group">
				<label class="control-label col-md-2">
					页面脚本:
				</label>
				<div class="col-md-5" style="padding-top: 7px;">
					<label class="toggle" style="display:inline-block;">
						<span style="display:inline-block;height:20px;"></span>
						<input type="checkbox" name="open-html-script-flag" class="open-html-script-flag" checked="checked" onclick="changeHtmlScriptOption(this)">
						<i data-swchon-text="开启" data-swchoff-text="关闭" style="width: 53px;"></i>
					</label>
				</div>
			</div>
			<div class="form-group" name="textCharset">
				<label class="control-label col-md-2">
					正文字符集
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${extraRule.textCharset==null?rule.textCharset:extraRule.textCharset }</xmp></span>
					<input class="form-control" placeholder="${rule.textCharset }" type="text" value="${extraRule.textCharset }">
				</div>
			</div>
			
			<c:if test="${rule.textContentParserMap == null&&extraRule.textContentParserMap==null}">
			<div class="form-group" name="textContentParserMap">
				<label class="control-label col-md-2">
					内容
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="" type="text" value="">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="" type="text" value="">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${extraRule.textContentParserMap!=null}">
				<c:forEach var="contentParserMap" items="${extraRule.textContentParserMap }" varStatus="s">
				<div class="form-group" name="textContentParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							内容
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="" type="text"  value="${contentParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${contentParserMap.value }</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${contentParserMap.value }">
					</div>
					<c:if test="${s.index==0}"> 
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
						</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textContentParserMap!= null&&extraRule.textContentParserMap==null}">
				<c:forEach var="contentParserMap" items="${rule.textContentParserMap }" varStatus="s">
				<div class="form-group" name="textContentParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							内容
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="${contentParserMap.key }" type="text"  value="">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${contentParserMap.value }</xmp></span>
						<input class="form-control" placeholder="${contentParserMap.value }" type="text" value="">
					</div>
					<c:if test="${s.index==0}"> 
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
						</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textImgUrlsParserMap == null&&extraRule.textImgUrlsParserMap==null}">
			<div class="form-group" name="textImgUrlsParserMap">
				<label class="control-label col-md-2">
					图片链接地址
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="${urlParserMap.key }" type="text" value="">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="${urlParserMap.value }" type="text" value="">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
				</div>
				
				
			</div>
			</c:if>
			<c:if test="${extraRule.textImgUrlsParserMap!=null}">
			<c:forEach var="imgUrlsParserMap" items="${extraRule.textImgUrlsParserMap}" varStatus="s">
				<div class="form-group" name="textImgUrlsParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							图片链接地址
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="" type="text"  value="${imgUrlsParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${imgUrlsParserMap.value }</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${imgUrlsParserMap.value }">
					</div>
					<c:if test="${s.index==0}"> 
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
						</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textImgUrlsParserMap != null&&extraRule.textImgUrlsParserMap==null}">
			<c:forEach var="imgUrlsParserMap" items="${rule.textImgUrlsParserMap }" varStatus="s">
				<div class="form-group" name="textImgUrlsParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							图片链接地址
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="${imgUrlsParserMap.key }" type="text"  value="">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${imgUrlsParserMap.value }</xmp></span>
						<input class="form-control" placeholder="${imgUrlsParserMap.value }" type="text" value="">
					</div>
					<c:if test="${s.index==0}"> 
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
						</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
				</c:forEach>
			</c:if>
			
			<c:if test="${rule.textAuthorParserMap == null&&extraRule.textAuthorParserMap == null}">
			<div class="form-group" name="textAuthorParserMap">
				<label class="control-label col-md-2">
					作者
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="${urlParserMap.key }" type="text" value="">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="${urlParserMap.value }" type="text" value="">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${extraRule.textAuthorParserMap != null}">
			<c:forEach var="authorParserMap" items="${extraRule.textAuthorParserMap}" varStatus="s">
				<div class="form-group" name="textAuthorParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							作者
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="" type="text"  value="${authorParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${authorParserMap.value }</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${authorParserMap.value }">
					</div>
					<c:if test="${s.index==0}"> 
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
						</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textAuthorParserMap != null&&extraRule.textAuthorParserMap == null}">
			<c:forEach var="authorParserMap" items="${rule.textAuthorParserMap }" varStatus="s">
				<div class="form-group" name="textAuthorParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							作者
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="${authorParserMap.key }" type="text"  value="">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${authorParserMap.value }</xmp></span>
						<input class="form-control" placeholder="${authorParserMap.value }" type="text" value="">
					</div>
					<c:if test="${s.index==0}"> 
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
						</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
				</c:forEach>
			</c:if>
			
			<c:if test="${rule.textSourceParserMap == null&&extraRule.textSourceParserMap == null}">
			<div class="form-group" name="textSourceParserMap">
				<label class="control-label col-md-2">
					来源
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="${urlParserMap.key }" type="text" value="">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="${urlParserMap.value }" type="text" value="">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${extraRule.textSourceParserMap != null}">
				<c:forEach var="sourceParserMap" items="${extraRule.textSourceParserMap }" varStatus="s">
						<div class="form-group" name="textSourceParserMap">
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								来源
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="" type="text"  value="${sourceParserMap.key }">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${sourceParserMap.value }</xmp></span>
								<input class="form-control" placeholder="" type="text" value="${sourceParserMap.value }">
							</div>
							<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
						</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textSourceParserMap != null&&extraRule.textSourceParserMap == null}">
				<c:forEach var="sourceParserMap" items="${rule.textSourceParserMap }" varStatus="s">
						<div class="form-group" name="textSourceParserMap">
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								来源
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="${sourceParserMap.key }" type="text"  value="">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${sourceParserMap.value }</xmp></span>
								<input class="form-control" placeholder="${sourceParserMap.value }" type="text" value="">
							</div>
							<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
							<c:if test="${s.index>0}"> 
								<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
								</div>
							</c:if>
						</div>
				</c:forEach>
			</c:if>
			
			<c:if test="${rule.textReplyParserMap == null&&extraRule.textReplyParserMap == null}">
			<div class="form-group" name="textReplyParserMap">
				<label class="control-label col-md-2">
					回复
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="${urlParserMap.key }" type="text" value="">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="${urlParserMap.value }" type="text" value="">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
				</div>
				
				
			</div>
			</c:if>
			<c:if test="${extraRule.textReplyParserMap != null}">
				<c:forEach var="replyParserMap" items="${extraRule.textReplyParserMap }" varStatus="s">
					<div class="form-group" name="textReplyParserMap">
						<c:if test="${s.index==0}"> 
								<label class="control-label col-md-2">
									回复
								</label>
								</c:if>
								<c:if test="${s.index>0}"> 
								<label class="control-label col-md-2">
								</label>
								</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="" type="text"  value="${replyParserMap.key }">
						</div>
						<div class="col-md-4">
							<span style="display:none"><xmp>${replyParserMap.value }</xmp></span>
							<input class="form-control" placeholder="" type="text" value="${replyParserMap.value }">
						</div>
						<c:if test="${s.index==0}"> 
									<div class="col-md-2">
											<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
									</div>
								</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textReplyParserMap != null&&extraRule.textReplyParserMap == null}">
				<c:forEach var="replyParserMap" items="${rule.textReplyParserMap }" varStatus="s">
					<div class="form-group" name="textReplyParserMap">
						<c:if test="${s.index==0}"> 
								<label class="control-label col-md-2">
									回复
								</label>
								</c:if>
								<c:if test="${s.index>0}"> 
								<label class="control-label col-md-2">
								</label>
								</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="${replyParserMap.key }" type="text"  value="">
						</div>
						<div class="col-md-4">
							<span style="display:none"><xmp>${replyParserMap.value }</xmp></span>
							<input class="form-control" placeholder="${replyParserMap.value }" type="text" value="">
						</div>
						<c:if test="${s.index==0}"> 
									<div class="col-md-2">
											<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
									</div>
								</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textClickParserMap == null&&extraRule.textClickParserMap == null}">
			<div class="form-group" name="textClickParserMap">
				<label class="control-label col-md-2">
					点击
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="${urlParserMap.key }" type="text" value="">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="${urlParserMap.value }" type="text" value="">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${extraRule.textClickParserMap != null}">
				<c:forEach var="clickParserMap" items="${extraRule.textClickParserMap}" varStatus="s">
					<div class="form-group" name="textClickParserMap">
						<c:if test="${s.index==0}"> 
										<label class="control-label col-md-2">
											点击
										</label>
										</c:if>
										<c:if test="${s.index>0}"> 
										<label class="control-label col-md-2">
										</label>
										</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="" type="text"  value="${clickParserMap.key }">
						</div>
						<div class="col-md-4">
							<span style="display:none"><xmp>${clickParserMap.value }</xmp></span>
							<input class="form-control" placeholder="" type="text" value="${clickParserMap.value }">
						</div>
						<c:if test="${s.index==0}"> 
											<div class="col-md-2">
													<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
											</div>
										</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textClickParserMap != null&&extraRule.textClickParserMap == null}">
				<c:forEach var="clickParserMap" items="${rule.textClickParserMap }" varStatus="s">
					<div class="form-group" name="textClickParserMap">
						<c:if test="${s.index==0}"> 
										<label class="control-label col-md-2">
											点击
										</label>
										</c:if>
										<c:if test="${s.index>0}"> 
										<label class="control-label col-md-2">
										</label>
										</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="${clickParserMap.key }" type="text"  value="">
						</div>
						<div class="col-md-4">
							<span style="display:none"><xmp>${clickParserMap.value }</xmp></span>
							<input class="form-control" placeholder="${clickParserMap.value }" type="text" value="">
						</div>
						<c:if test="${s.index==0}"> 
											<div class="col-md-2">
													<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
											</div>
										</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textTimeParserMap == null&&extraRule.textTimeParserMap == null}">
			<div class="form-group" name="textTimeParserMap">
				<label class="control-label col-md-2">
					发布时间
				</label>
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${extraRule.textTimeParserMap != null}">
			<c:forEach var="timeParserMap" items="${extraRule.textTimeParserMap }"  varStatus="s">
				<div class="form-group" name="textTimeParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							发布时间
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="" type="text"  value="${timeParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${timeParserMap.value }</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${timeParserMap.value }">
					</div>
					<c:if test="${s.index==0}"> 
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
						</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
			</c:forEach>
			</c:if>
			<c:if test="${rule.textTimeParserMap != null&&extraRule.textTimeParserMap == null}">
			<c:forEach var="timeParserMap" items="${rule.textTimeParserMap }"  varStatus="s">
				<div class="form-group" name="textTimeParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							发布时间
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="${timeParserMap.key }" type="text"  value="">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${timeParserMap.value }</xmp></span>
						<input class="form-control" placeholder="${timeParserMap.value }" type="text" value="">
					</div>
					<c:if test="${s.index==0}"> 
							<div class="col-md-2">
									<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
							</div>
						</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
			</c:forEach>
			</c:if>
			<c:if test="${rule.textNextPageParserMap == null&&extraRule.textNextPageParserMap == null}">
			<div class="form-group" name="textNextPageParserMap">
				<label class="control-label col-md-2">
					正文下一页
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="${urlParserMap.key }" type="text" value="">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="${urlParserMap.value }" type="text" value="">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${extraRule.textNextPageParserMap != null}">
			<c:forEach var="nextPageParserMap" items="${extraRule.textNextPageParserMap}" varStatus="s">
				<div class="form-group" name="textNextPageParserMap">
					<c:if test="${s.index==0}"> 
											<label class="control-label col-md-2">
												正文下一页
											</label>
											</c:if>
											<c:if test="${s.index>0}"> 
											<label class="control-label col-md-2">
											</label>
											</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="" type="text"  value="${nextPageParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${nextPageParserMap.value }</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${nextPageParserMap.value }">
					</div>
					<c:if test="${s.index==0}"> 
												<div class="col-md-2">
														<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
												</div>
											</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
				</c:forEach>
			</c:if>
			<c:if test="${rule.textNextPageParserMap != null&&extraRule.textNextPageParserMap == null}">
			<c:forEach var="nextPageParserMap" items="${rule.textNextPageParserMap }" varStatus="s">
				<div class="form-group" name="textNextPageParserMap">
					<c:if test="${s.index==0}"> 
											<label class="control-label col-md-2">
												正文下一页
											</label>
											</c:if>
											<c:if test="${s.index>0}"> 
											<label class="control-label col-md-2">
											</label>
											</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="${nextPageParserMap.key }" type="text"  value="">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${nextPageParserMap.value }</xmp></span>
						<input class="form-control" placeholder="${nextPageParserMap.value }" type="text" value="">
					</div>
					<c:if test="${s.index==0}"> 
												<div class="col-md-2">
														<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
												</div>
											</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
				</c:forEach>
			</c:if>
			
			<c:if test="${rule.textAdditionalParserMap == null&&extraRule.textAdditionalParserMap == null}"><span style="display:none;" id="textAdditionalShowFlag"></span></c:if>
			<div class="form-group other" style="text-align:center;"><a href="javascript:;" onclick="showOther(this)">添加其他</a></div>
			<c:if test="${rule.textAdditionalParserMap == null&&extraRule.textAdditionalParserMap == null}">
			<div class="form-group textAdditionalParserMap" name="textAdditionalParserMap">
					<label class="control-label col-md-2">
						其他
					</label>
					<div class="col-md-2">
						<input class="form-control" placeholder="selector" type="text" value="">
					</div>
					<div class="col-md-3">
						<input class="form-control" placeholder="locator" type="text" value="">
					</div>
					<div class="col-md-3">
						<input class="form-control" placeholder="locator" type="text" value="">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>
					</div>
			</div>
			</c:if>
			<c:if test="${extraRule.textAdditionalParserMap != null}">
			<c:forEach var="textAdditionalParserMap" items="${extraRule.textAdditionalParserMap}" varStatus="s">	
				<div class="form-group textAdditionalParserMap" name="textAdditionalParserMap">	
					<c:if test="${s.index==0}">
					<label class="control-label col-md-2">
						其他
					</label>
					</c:if>
					<c:if test="${s.index>0}">
					<label class="control-label col-md-2">
					</label>
					</c:if>
					<div class="col-md-2">
						<input class="form-control" placeholder="" type="text"  value="${textAdditionalParserMap.key }">
					</div>
					<c:forEach var="textAdditionalParserMap2" items="${textAdditionalParserMap.value }">
						<div class="col-md-3">
							<input class="form-control" placeholder="" type="text" value="${textAdditionalParserMap2.key }">
						</div>
						<div class="col-md-3">
							<span style="display:none"><xmp>${textAdditionalParserMap2.value }</xmp></span>
							<input class="form-control" placeholder="" type="text" value="${textAdditionalParserMap2.value }">
						</div>
					</c:forEach>
					<c:if test="${s.index==0}">
						<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>
						</div>
					</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
			</c:forEach>
			</c:if>
			<c:if test="${rule.textAdditionalParserMap != null&&extraRule.textAdditionalParserMap == null}">
			<c:forEach var="textAdditionalParserMap" items="${rule.textAdditionalParserMap }" varStatus="s">	
				<div class="form-group textAdditionalParserMap" name="textAdditionalParserMap">	
					<c:if test="${s.index==0}">
					<label class="control-label col-md-2">
						其他
					</label>
					</c:if>
					<c:if test="${s.index>0}">
					<label class="control-label col-md-2">
					</label>
					</c:if>
					<div class="col-md-2">
						<input class="form-control" placeholder="${textAdditionalParserMap.key }" type="text"  value="">
					</div>
					<c:forEach var="textAdditionalParserMap2" items="${textAdditionalParserMap.value }">
						<div class="col-md-3">
							<input class="form-control" placeholder="${textAdditionalParserMap2.key }" type="text" value="">
						</div>
						<div class="col-md-3">
							<span style="display:none"><xmp>${textAdditionalParserMap2.value }</xmp></span>
							<input class="form-control" placeholder="${textAdditionalParserMap2.value }" type="text" value="">
						</div>
					</c:forEach>
					<c:if test="${s.index==0}">
						<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>
						</div>
					</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
			</c:forEach>
			</c:if>
			</div>
			</c:if>
			<!-- html-box2 end -->
			
			
			
			<!-- json-box2 start -->
			<c:if test="${rule.publicTextRuleId ==null}">
			<div class="json-box">
				<div class="form-group">
					<label class="control-label col-md-2">
						页面脚本:
					</label>
					<div class="col-md-5" style="padding-top: 7px;">
						<label class="toggle" style="display:inline-block;">
							<span style="display:inline-block;height:20px;"></span>
							<input type="checkbox" name="open-html-script-flag" class="open-html-script-flag" checked="checked" onclick="changeHtmlScriptOption(this)">
							<i data-swchon-text="开启" data-swchoff-text="关闭" style="width: 53px;"></i>
						</label>
					</div>
				</div>
    			<div class="form-group" name="textFormData" >
					<label class="control-label col-md-2">
						post提交的参数
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="" type="text" value="${rule.textFormData }">
					</div>
				</div>
				<div class="form-group" name="textReplaceStr" >
					<label class="control-label col-md-2">
						需要replace的字符串
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="" type="text" value="${rule.textReplaceStr }">
					</div>
				</div>
				
				<div class="form-group" name="textTimeKey" >
					<label class="control-label col-md-2">
						正文页时间
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="" type="text" value="${rule.textTimeKey }">
					</div>
				</div>
				<div class="form-group" name="textContentKey" >
					<label class="control-label col-md-2">
						正文页内容
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="" type="text" value="${rule.textContentKey }">
					</div>
				</div>
				<div class="form-group" name="textImgUrlsKey" >
					<label class="control-label col-md-2">
						正文页图片链接地址
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="" type="text" value="${rule.textImgUrlsKey }">
					</div>
				</div>
				<div class="form-group" name="textAuthorKey" >
					<label class="control-label col-md-2">
						正文页作者
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="" type="text" value="${rule.textAuthorKey }">
					</div>
				</div>
				<div class="form-group" name="textSourceKey" >
					<label class="control-label col-md-2">
						正文页来源
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="" type="text" value="${rule.textSourceKey }">
					</div>
				</div>
				<div class="form-group" name="textReplyKey" >
					<label class="control-label col-md-2">
						正文页回复
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="" type="text" value="${rule.textReplyKey }">
					</div>
				</div>
				<div class="form-group" name="textClickKey" >
					<label class="control-label col-md-2">
						正文页点击
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="" type="text" value="${rule.textClickKey }">
					</div>
				</div>
				
				
				
				<c:if test="${rule.textAdditionalKey == null}">
				<div class="form-group" name="textAdditionalKey">
					<label class="control-label col-md-2">
						正文页额外添加的字段
					</label>
					
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text" value="">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
						</div>
				</div>
				</c:if>
				<c:if test="${rule.textAdditionalKey!= null}">
					<c:forEach var="textAdditionalKey" items="${rule.textAdditionalKey }" varStatus="s">
					<div class="form-group" name="textAdditionalKey">
						<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								正文页额外添加的字段
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text"  value="${textAdditionalKey.key }">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="locator" type="text" value="${textAdditionalKey.value }">
						</div>
						<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
					</c:forEach>
				</c:if>
			</div>
			</c:if>
			<!-- json-box2 end -->
			
			<!-- 有公共正文模板 -->
			<!-- json-box2 start -->
			<c:if test="${rule.publicTextRuleId !=null}">
			<div class="json-box">
				<div class="form-group">
					<label class="control-label col-md-2">
						页面脚本:
					</label>
					<div class="col-md-5" style="padding-top: 7px;">
						<label class="toggle" style="display:inline-block;">
							<span style="display:inline-block;height:20px;"></span>
							<input type="checkbox" name="open-html-script-flag" class="open-html-script-flag" checked="checked" onclick="changeHtmlScriptOption(this)">
							<i data-swchon-text="开启" data-swchoff-text="关闭" style="width: 53px;"></i>
						</label>
					</div>
				</div>
    			<div class="form-group" name="textFormData" >
					<label class="control-label col-md-2">
						post提交的参数
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.textFormData }" type="text" value="${extraRule.textFormData }">
					</div>
				</div>
				<div class="form-group" name="textReplaceStr" >
					<label class="control-label col-md-2">
						需要replace的字符串
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.textReplaceStr }" type="text" value="${extraRule.textReplaceStr }">
					</div>
				</div>
				
				<div class="form-group" name="textTimeKey" >
					<label class="control-label col-md-2">
						正文页时间
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.textTimeKey }" type="text" value="${extraRule.textTimeKey }">
					</div>
				</div>
				<div class="form-group" name="textContentKey" >
					<label class="control-label col-md-2">
						正文页内容
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.textContentKey }" type="text" value="${extraRule.textContentKey }">
					</div>
				</div>
				<div class="form-group" name="textImgUrlsKey" >
					<label class="control-label col-md-2">
						正文页图片链接地址
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.textImgUrlsKey }" type="text" value="${extraRule.textImgUrlsKey }">
					</div>
				</div>
				<div class="form-group" name="textAuthorKey" >
					<label class="control-label col-md-2">
						正文页作者
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.textAuthorKey }" type="text" value="${extraRule.textAuthorKey }">
					</div>
				</div>
				<div class="form-group" name="textSourceKey" >
					<label class="control-label col-md-2">
						正文页来源
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.textSourceKey }" type="text" value="${extraRule.textSourceKey }">
					</div>
				</div>
				<div class="form-group" name="textReplyKey" >
					<label class="control-label col-md-2">
						正文页回复
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.textReplyKey }" type="text" value="${extraRule.textReplyKey }">
					</div>
				</div>
				<div class="form-group" name="textClickKey" >
					<label class="control-label col-md-2">
						正文页点击
					</label>
					<div class="col-sm-10">
						<input class="form-control" placeholder="${rule.textClickKey }" type="text" value="${extraRule.textClickKey }">
					</div>
				</div>
				
				
				
				<c:if test="${rule.textAdditionalKey == null&&extraRule.textAdditionalKey == null}">
				<div class="form-group" name="textAdditionalKey">
					<label class="control-label col-md-2">
						正文页额外添加的字段
					</label>
					
						<div class="col-md-4">
							<input class="form-control" placeholder="selector" type="text" value="">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="locator" type="text" value="">
						</div>
						<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
						</div>
				</div>
				</c:if>
				<c:if test="${extraRule.textAdditionalKey != null}">
					<c:forEach var="textAdditionalKey" items="${extraRule.textAdditionalKey}" varStatus="s">
					<div class="form-group" name="textAdditionalKey">
						<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								正文页额外添加的字段
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="" type="text"  value="${textAdditionalKey.key }">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="" type="text" value="${textAdditionalKey.value }">
						</div>
						<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
					</c:forEach>
				</c:if>
				<c:if test="${rule.textAdditionalKey!= null&&extraRule.textAdditionalKey == null}">
					<c:forEach var="textAdditionalKey" items="${rule.textAdditionalKey }" varStatus="s">
					<div class="form-group" name="textAdditionalKey">
						<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								正文页额外添加的字段
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
						<div class="col-md-4">
							<input class="form-control" placeholder="${textAdditionalKey.key }" type="text"  value="">
						</div>
						<div class="col-md-4">
							<input class="form-control" placeholder="${textAdditionalKey.value }" type="text" value="">
						</div>
						<c:if test="${s.index==0}"> 
								<div class="col-md-2">
										<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
								</div>
							</c:if>
						<c:if test="${s.index>0}"> 
							<div class="col-md-2">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
					</div>
					</c:forEach>
				</c:if>
			</div>
			</c:if>
			<!-- json-box2 end -->
		</fieldset>
	</form>
</div>

<div class="col-sm-6" id="fatch-news-list"  style="border-left:1px dashed rgba(0,0,0,.2);height:635px;overflow-y: scroll;min-width:541px;">
	<fieldset id="rule_list_fieldset" style="display:none;">
			<legend>
				抓取列表
			</legend>
			<div class="form-group" name="section">
			</div>
	</fieldset>
	<div id="rule_list_processing" class="fatch_processing" style="display:none;">
		<a href="javascript:void(0);" class="bg-color-white txt-color-teal">
			<i class="fa fa-gear fa-3x fa-spin"></i>
		</a>&nbsp;&nbsp;&nbsp;正在处理...
	</div>
</div>
<script><!--
	$(function(){
		var listDataType = $("#mainFrm div[name='listDataType'] input").val();
		if(!listDataType){
			$("div[name='listDataType'] input").attr("value","2");
			listDataType = "2";
		}
		if(listDataType=="2"){//html
			console.log("here");
			$("input[name='open-list-type-flag']:eq(0)").attr("checked","checked");
			
			$("#mainFrm div[name$='listCharset']:eq(0)").attr("name","listCharset");
			$("#mainFrm div[name$='listCharset']:eq(1)").attr("name","_invalid_listCharset");
			
			$("#mainFrm div[name$='page']:eq(0)").attr("name","page");
			$("#mainFrm div[name$='page']:eq(1)").attr("name","_invalid_page");
			$("input[name='open-list-type-flag']")[0].checked = true;
			$("div.html-box:eq(0)").show();
			$("div.json-box:eq(0)").hide();
		}else{//json
			$("input[name='open-list-type-flag']:eq(0)").removeAttr("checked");
			$("#mainFrm div[name$='listCharset']:eq(1)").attr("name","listCharset");
			$("#mainFrm div[name$='listCharset']:eq(0)").attr("name","_invalid_listCharset");
			
			$("#mainFrm div[name$='page']:eq(1)").attr("name","page");
			$("#mainFrm div[name$='page']:eq(0)").attr("name","_invalid_page");
			$("div.json-box:eq(0)").show();
			$("div.html-box:eq(0)").hide();
		}
		
		var textDataType = $("#mainFrm div[name='textDataType'] input").val();
		if(!textDataType){
			$("div[name='textDataType'] input").attr("value","2");
			textDataType = "2";
		}
		if(textDataType=="2"){//html
			$("input[name='open-list-type-flag']:eq(1)").attr("checked","checked");
			$("div.html-box:eq(1)").show();
			$("div.json-box:eq(1)").hide();
		}else{//json
			$("input[name='open-list-type-flag']:eq(1)").removeAttr("checked");
			$("div.json-box:eq(1)").show();
			$("div.html-box:eq(1)").hide();
		}
		
		var fetch_strategy = $("div[name='fetchStrategy'] input").val()?$("div[name='fetchStrategy'] input").val():$("div[name='fetchStrategy'] input").attr("placeholder");
		if(!fetch_strategy){
			$("div[name='fetchStrategy'] input").attr("value",1);
			$("div[name='fetchStrategy'] input").val(1);
			fetch_strategy = 1;
		}
		
		$("input[name='radio-fetch-strategy']").each(function(){
			if($(this).attr("t_value")==fetch_strategy){
				$(this).attr("checked","checked");
			}else{
				$(this).removeAttr("checked");
			}
		});
		$("input[name='radio-fetch-strategy2']").each(function(){
			if($(this).attr("t_value")==fetch_strategy){
				$(this).attr("checked","checked");
			}else{
				$(this).removeAttr("checked");
			}
		});
		
		
		var listLetOffHtmlunitFlag = $("#mainFrm div[name='listLetOffHtmlunitFlag'] input").val();
		var textLetOffHtmlunitFlag = $("#mainFrm div[name='textLetOffHtmlunitFlag'] input").val();
		if(listLetOffHtmlunitFlag=='true'){
			$(".open-html-script-flag:lt(2)").each(function(){
				$(this).attr("checked","checked");
			})
		}else{
			$(".open-html-script-flag:lt(2)").each(function(){
				$(this).removeAttr("checked");
			})
		}
		
		if(textLetOffHtmlunitFlag=='true'){
			$(".open-html-script-flag:gt(1)").each(function(){
				$(this).attr("checked","checked");
			})
		}else{
			$(".open-html-script-flag:gt(1)").each(function(){
				$(this).removeAttr("checked");
			})
		}
	});
	function changeFetchStrategy(fetch_strategy){
		var fetchStrategyVal = $("div[name='fetchStrategy'] input").attr("placeholder");
		//如果和继承的列表模板的抓取策略bu一样的话，存储。否则不存储
		if(fetch_strategy!=fetchStrategyVal){
			$("div[name='fetchStrategy'] input").val(fetch_strategy);
			$("div[name='fetchStrategy'] input").attr("value",fetch_strategy);
		}else{
			$("div[name='fetchStrategy'] input").val("");
			$("div[name='fetchStrategy'] input").attr("value","");	
		}
	}
	function changeHtmlScriptOption(ele){
		var idx = $(ele).index(".open-html-script-flag");
		console.log($(ele)[0].checked);
		if(idx<2){
			radioCheck(".open-html-script-flag:lt(2)",$(ele)[0].checked);
			$("[name=listLetOffHtmlunitFlag] input").val($(ele)[0].checked);
		}else{
			$("[name=listLetOffHtmlunitFlag] input").val($(ele)[0].checked);
			radioCheck(".open-html-script-flag:gt(1)",$(ele)[0].checked);
		}
	}
	function radioCheck(radio_,isCheck){
		$(radio_).each(function(){
			/*//这种写法不太管用
			if(isCheck){
				$(this).attr("checked","checked");
			}else{
				$(this).removeAttr("checked");
			}
			*/
			$(this)[0].checked=isCheck;
		})
	}
	
</script>