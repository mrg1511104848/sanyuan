<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
pageSetUp();

		$(function(){
			var publicListRuleId = $("div[name='publicListRuleId'] input").val();
			if(publicListRuleId){
				$(".html-box:eq(0) .form-group").each(function(){
					var pre = $(this).find("input:last").prev();
					if(pre){
						var v = pre.text().trim();
						console.log("15:53-------------------------"+v);
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


			var publicSectionRuleId = $("div[name='publicSectionRuleId'] input").val();
			if(publicSectionRuleId){
				$(".epaper-public-section-rule-box .form-group").each(function(){
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
				$(".epaper-public-section-rule-box .form-group").each(function(){
					var pre = $(this).find("input:last").prev();
					if(pre){
						var v = pre.text().trim();
						$(this).find("input:last").val(v);
						$(this).find("input:last").attr("value",v);
					}
				});
			}

			
			var listAdditionalShowFlagLength = $("#listAdditionalShowFlag").length;
			if(listAdditionalShowFlagLength>0){
				$(".listAdditionalParserMap").hide();
			}
			var textAdditionalShowFlagLength = $("#textAdditionalShowFlag").length;
			if(textAdditionalShowFlagLength>0){
				$(".textAdditionalParserMap").hide();
			}
			var sectionAdditionalShowFlagLength = $("#sectionAdditionalShowFlag").length;
			if(sectionAdditionalShowFlagLength>0){
				$(".sectionAdditionalParserMap").hide();
			}
			
		})
		function use_list_model(){
			loadPublicHtmlListRuleModelOnlySelect();
			var dialog = window.top.art.dialog({
					title: "公共列表模板列表",
					content:  $("#public-html-list-rule-model-boxs div:eq(0)")[0],
					width:"900px",
					padding: '0px 0px',
					lock:true
			});
			$(".aui_content").css("width","100%");
		}
		function ready_to_create_list_model(){
			var paper = $("#leftEditBox div[name=paper] input").val();
			
			var dialog = window.top.art.dialog({
					title: "创建列表模板",
					content:  "自定义名称: <input name='zdy_list_name' value='"+paper+"'/>",
					width:"500px",
					padding: '0px 0px',
					lock:true,
					button:[{
				    	name:"确认",
				    	callback:function(){
				    		
				    		var h = $("div.html-box:eq(0) input");
				    		h.each(function(){
				    			var hv = $(this).val();
				    			if(hv!=""){
				    				$(this).attr("placeholder",hv);
				    			}
				    		});
				    		h.val("");
				    		
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
			var url = "/epaper/saveEpaperPublicListRule.html?type=new&zdy_list_name="+zdy_list_name;
			$.ajax({
				url:url,
				data:buildFormData(),
				type:'POST',
				success:function(data){
					data = 	eval('('+data+')');
					if(data.result){
						$(".aui_content #mainFrm div[name='publicListRuleId'] input").val(data.id);
						//var r = updateToRule();
						//if(r){
							art.dialog.tips('生成模板成功!');
							var name = data.name;
							$(".aui_content #mainFrm a.extends_flag:eq(1)").attr("title","继承模板【"+name+"】,点击取消继承");
							$(".aui_content #mainFrm a.extends_flag:eq(1)").attr("flag_title","继承模板【"+name+"】");
							$(".aui_content #mainFrm a.extends_flag:eq(1)").css("color","#3276b1").css("text-decoration","none");
						//}
					}
				}
			});
		}
		function ready_to_create_text_model(){
			var paper = $("#leftEditBox div[name=paper] input").val();
			var dialog = window.top.art.dialog({
					title: "创建正文模板",
					content:  "自定义名称: <input name='zdy_text_name' value='"+paper+"'/>",
					width:"500px",
					padding: '0px 0px',
					lock:true,
					button:[{
				    	name:"确认",
				    	callback:function(){
				    		var h = $("div.html-box:eq(1) input");
				    		h.each(function(){
				    			var hv = $(this).val();
				    			if(hv!=""){
				    				$(this).attr("placeholder",hv);
				    			}
				    		});
				    		h.val("");
				    		
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
			var url = "/epaper/saveEpaperPublicTextRule.html?type=new&zdy_text_name="+zdy_text_name;
			$.ajax({
				url:url,
				data:buildFormData(),
				type:'POST',
				success:function(data){
					data = 	eval('('+data+')');
					if(data.result){
						$(".aui_content #mainFrm div[name='publicTextRuleId'] input").val(data.id);
						//var r = updateToRule();
						var name = data.name;
						//if(r){
							art.dialog.tips('生成模板成功!');
							$(".aui_content #mainFrm a.extends_flag:eq(2)").attr("title","继承模板【"+name+"】,点击取消继承");
							$(".aui_content #mainFrm a.extends_flag:eq(2)").attr("flag_title","继承模板【"+name+"】");
							$(".aui_content #mainFrm a.extends_flag:eq(2)").css("color","#3276b1").css("text-decoration","none");
						//}
					}
				}
			});
		}
		
		function use_text_model(){
				loadPublicHtmlTextRuleModelOnlySelect();
				var dialog = window.top.art.dialog({
					title: "公共列表模板列表",
					content:  $("#public-html-text-rule-model-boxs div:eq(0)")[0],
					width:"900px",
					padding: '0px 0px',
					lock:true
				});
			$(".aui_content").css("width","100%");
		}
		function use_epaper_section_model(){
			loadEpaperPublicSectionRuleModelOnlySelect();
			var dialog = window.top.art.dialog({
				title: "公共列表模板列表",
				content:  $("#epaper-public-section-rule-model-boxs div:eq(0)")[0],
				width:"900px",
				padding: '0px 0px',
				lock:true
			});
			$(".aui_content").css("width","100%");
		}
		function ready_to_create_epaper_section_model(){
			var paper = $("div[name=paper] input").val();
			var dialog = window.top.art.dialog({
				title: "创建列表模板",
				content:  "自定义名称: <input name='zdy_epaper_section_name' value='"+paper+"'/>",
				width:"500px",
				padding: '0px 0px',
				lock:true,
				button:[{
			    	name:"确认",
			    	callback:function(){
			    		
			    		var h = $("div.epaper-public-section-rule-box input");
			    		h.each(function(){
			    			var hv = $(this).val();
			    			if(hv!=""){
			    				$(this).attr("placeholder",hv);
			    			}
			    		});
			    		h.val("");
			    		
			    		create_epaper_section_model();
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
		};
		function create_epaper_section_model(){
			var zdy_epaper_section_name = $(".aui_content input[name='zdy_epaper_section_name']").val();
			var url = "/epaper/saveEpaperPublicSectionRule.html?type=new&zdy_epaper_section_name="+zdy_epaper_section_name;
			$.ajax({
				url:url,
				data:buildFormData(),
				type:'POST',
				success:function(data){
					data = 	eval('('+data+')');
					if(data.result){
						$(".aui_content #mainFrm div[name='publicSectionRuleId'] input").val(data.id);
						//var r = updateToRule();
						var name = data.name;
						//if(r){
							art.dialog.tips('生成模板成功!');
							$(".aui_content #mainFrm a.extends_flag:eq(0)").attr("title","继承模板【"+name+"】,点击取消继承");
							$(".aui_content #mainFrm a.extends_flag:eq(0)").attr("flag_title","继承模板【"+name+"】");
							$(".aui_content #mainFrm a.extends_flag:eq(0)").css("color","#3276b1").css("text-decoration","none");
						//}
					}
				}
			});
		};
		function cancelExtends(ele,type){
			var public_id;
			//var param = {};
			
			var id = $("#mainFrm div[name='id'] input").val();
			//console.log("\\\\\\\\\\\\\\\\\\\\\\\\\\"+id);
			if(type==0){
				public_id = $("#mainFrm div[name='publicSectionRuleId'] input").val();
				
				if(!public_id){
					return;
				}else{
					$("#mainFrm div[name='publicSectionRuleId'] input").val("");
					$("#mainFrm div[name='publicSectionRuleId'] input").attr("value","");
					//param = {"id":id,"publicListRuleId":""};
				}
			}else if(type==1){
				public_id = $("#mainFrm div[name='publicListRuleId'] input").val();
				
				if(!public_id){
					return;
				}else{
					$("#mainFrm div[name='publicListRuleId'] input").val("");
					$("#mainFrm div[name='publicListRuleId'] input").attr("value","");
					//param = {"id":id,"publicListRuleId":""};
				}
			}else{
				public_id = $("#mainFrm div[name='publicTextRuleId'] input").val();
				if(!public_id){
					return;
				}else{
					$("#mainFrm div[name='publicTextRuleId'] input").val("");
					$("#mainFrm div[name='publicListRuleId'] input").attr("value","");
					//param = {"id":id,"publicTextRuleId":""};
				}
			}
			startToCancelExtends(ele,type);
			
		}
		function startToCancelExtends(ele,type){

			art.dialog.tips('取消继承成功!请记得保存哦');
			$("#mainFrm a.extends_flag:eq("+type+")").css("color","#ccc").css("text-decoration","none");
			$("#mainFrm a.extends_flag:eq("+type+")").attr("title","当前无继承模板");
			$("#mainFrm a.extends_flag:eq("+type+")").attr("flag_title","当前无继承模板");
			/*
			var url = "/epaper/saveRule.html";
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
			});*/
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
			console.log(tabTop1+"_"+tabTop2+"__"+tabTop3);
			$('#leftEditBox').bind('scroll', function() { 
				
				var top = $('#leftEditBox').scrollTop();
				var i = -1;
				if(top>=0&&top<247){
					i = 0;
					$(".bootstrapWizard li:eq(0)").addClass("active");
				}else if(top>=247&&top<400){
					i = 1;
					$(".bootstrapWizard li:eq(1)").addClass("active");
				}else if(top>=400&&top<600){
					i = 2;
					$(".bootstrapWizard li:eq(2)").addClass("active");
				}else{
					i = 3;
					$(".bootstrapWizard li:eq(3)").addClass("active");
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
											<li class="active" data-target="#step1" onclick="miaodian(this)">
												<a href="#tab1" data-toggle="tab"> <span class="step">1</span> <span class="title">基本信息</span> </a>
											</li>
											<li data-target="#step2" onclick="miaodian(this)">
												<a href="#tab2" data-toggle="tab"> <span class="step">2</span> <span class="title">版块信息</span> </a>
											</li>
											<li data-target="#step3"  onclick="miaodian(this)">
												<a href="#tab3" data-toggle="tab"> <span class="step">3</span> <span class="title">解析列表</span> </a>
											</li>
											<li data-target="#step4" onclick="miaodian(this)">
												<a href="#tab4" data-toggle="tab"> <span class="step">4</span> <span class="title">解析正文</span> </a>
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
		<fieldset>
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
			<div class="form-group" name="publicSectionRuleId" style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="${rule.publicSectionRuleId }">
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
			<div class="form-group" name="paper" >
				<label class="control-label col-md-2">
					报刊名称
				</label>
				<div class="col-sm-10">
					<input class="form-control" placeholder="" type="text" value="${rule.paper }">
				</div>
			</div>
			<div class="form-group" name="paperUrl" >
				<label class="control-label col-md-2">
					报刊URL
				</label>
				<div class="col-md-10">
					<input class="form-control" placeholder="" type="text" value="${rule.paperUrl }">
				</div>
			</div>
			<div class="form-group" name="wildcardPaperUrl" >
				<label class="control-label col-md-2">
					历史报刊URL
				</label>
				<div class="col-md-10">
					<input class="form-control" placeholder="" type="text" value="${rule.wildcardPaperUrl }">
				</div>
			</div>
			<div class="form-group tmp" > 
				<label class="control-label col-md-2">
					历史报刊时间
				</label>
				<div class="col-md-5">
					<input class="form-control my_datepicker" id="start_date" data-dateformat="yy-mm-dd"/>
				</div>
				<div class="col-md-5">
					<input class="form-control my_datepicker"  id="end_date" data-dateformat="yy-mm-dd">
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
			
			<legend  id="tab2">
				<span style="float:left;">版块信息</span> 
				<span style="float:right;">
					<c:if test="${epaperPublicSectionRuleName == null ||epaperPublicSectionRuleName=='' }">
						<a class="glyphicon glyphicon-flag extends_flag" onclick="cancelExtends(this,0)" style="color:#ccc;text-decoration:none;" title="当前无继承模板" flag_title="当前无继承模板" href="javascript:void(0);" style="text-decoration: none;"></a>&nbsp;&nbsp;
					</c:if>
					<c:if test="${epaperPublicSectionRuleName != null &&epaperPublicSectionRuleName!='' }">
						<a class="glyphicon glyphicon-flag extends_flag"  onclick="cancelExtends(this,0)" data-placement="top" title="继承模板【${epaperPublicSectionRuleName }】,点击取消继承" flag_title="继承模板【${epaperPublicSectionRuleName }】" href="javascript:void(0);" style="text-decoration: none;"></a>&nbsp;&nbsp;
					</c:if>
					<a class="glyphicon glyphicon-cog" onclick="use_epaper_section_model()" title="使用模板" href="javascript:;" style="text-decoration: none;"></a>&nbsp;&nbsp;
					<a class="glyphicon glyphicon-arrow-up" onclick="ready_to_create_epaper_section_model()" title="生成模板" href="javascript:;" style="text-decoration: none;"></a>&nbsp;&nbsp;
				</span>
				<div style="clear:both;"></div>
			</legend>
			<c:if test="${rule.publicSectionRuleId ==null}">
				<div class="epaper-public-section-rule-box">
					<div class="form-group" name="everySectionSelector">
						<label class="control-label col-md-2">
							版块列表循环域
						</label>
						<div class="col-md-5">
							<span style="display:none"><xmp>${rule.everySectionSelector }</xmp></span>
							<input class="form-control" placeholder="" type="text" value="${rule.everySectionSelector }">
						</div>
					</div>
					
					<c:if test="${rule.sectionUrlParserMap == null}">
						<div class="form-group" name="sectionUrlParserMap"> 
							<label class="control-label col-md-2">
								版块URL
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
					<c:if test="${rule.sectionUrlParserMap != null}">
							<c:forEach var="sectionUrlParserMap" items="${rule.sectionUrlParserMap }" varStatus="s">
								<div class="form-group" name="sectionUrlParserMap"> 
									<c:if test="${s.index==0}"> 
									<label class="control-label col-md-2">
										版块URL
									</label>
									</c:if>
									<c:if test="${s.index>0}"> 
									<label class="control-label col-md-2">
									</label>
									</c:if>
									<div class="col-md-4">
										<input class="form-control" placeholder="selector" type="text" value="${sectionUrlParserMap.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${sectionUrlParserMap.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${sectionUrlParserMap.value }">
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
					
					<c:if test="${rule.sectionNameParserMap == null}">
						<div class="form-group" name="sectionNameParserMap"> 
							<label class="control-label col-md-2">
								版块名称
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
					<c:if test="${rule.sectionNameParserMap != null}">
							<c:forEach var="sectionNameParserMap" items="${rule.sectionNameParserMap }" varStatus="s">
								<div class="form-group" name="sectionNameParserMap"> 
									<c:if test="${s.index==0}"> 
									<label class="control-label col-md-2">
										版块名称
									</label>
									</c:if>
									<c:if test="${s.index>0}"> 
									<label class="control-label col-md-2">
									</label>
									</c:if>
									<div class="col-md-4">
										<input class="form-control" placeholder="selector" type="text" value="${sectionNameParserMap.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${sectionNameParserMap.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${sectionNameParserMap.value }">
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
				
					<c:if test="${rule.sectionAdditionalParserMap == null}"><span style="display:none;" id="sectionAdditionalShowFlag"></span></c:if>
					<div class="form-group other" style="text-align:center;" ><a href="javascript:;" onclick="showOther(this)">添加其他</a></div>
					<c:if test="${rule.sectionAdditionalParserMap == null}">
					<div class="form-group sectionAdditionalParserMap" name="sectionAdditionalParserMap">
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
					<c:forEach var="sectionAdditionalParserMap" items="${rule.sectionAdditionalParserMap }" varStatus="s">	
						<div class="form-group sectionAdditionalParserMap" name="sectionAdditionalParserMap">	
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
								<input class="form-control" placeholder="selector" type="text"  value="${sectionAdditionalParserMap.key }">
							</div>
							<c:forEach var="sectionAdditionalParserMap2" items="${sectionAdditionalParserMap.value }">
								<div class="col-md-3">
									<input class="form-control" placeholder="locator" type="text" value="${sectionAdditionalParserMap2.key }">
								</div>
								<div class="col-md-3">
									<span style="display:none"><xmp>${sectionAdditionalParserMap2.value }</xmp></span>
									<input class="form-control" placeholder="locator" type="text" value="${sectionAdditionalParserMap2.value }">
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
			<!-- 如果有模块模板的话 -->
			<c:if test="${rule.publicSectionRuleId !=null}">
				<div class="epaper-public-section-rule-box">
					<div class="form-group" name="everySectionSelector">
						<label class="control-label col-md-2">
							版块列表循环域
						</label>
						<div class="col-md-5">
							<span style="display:none"><xmp>${extraRule.everySectionSelector==null?rule.everySectionSelector:extraRule.everySectionSelector }</xmp></span>
							<input class="form-control" placeholder="${rule.everySectionSelector }" type="text" value="${extraRule.everySectionSelector }">
						</div>
					</div>
					<!-- ffffffffffffff -->
					<c:if test="${rule.sectionUrlParserMap == null&&extraRule.sectionUrlParserMap == null}">
					<div class="form-group" name="listUrlParserMap"> 
						<label class="control-label col-md-2">
							版块URL
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
					<c:if test="${extraRule.sectionUrlParserMap != null}">
						<c:forEach var="sectionUrlParserMap" items="${extraRule.sectionUrlParserMap }" varStatus="s">
							<div class="form-group" name="sectionUrlParserMap"> 
								<c:if test="${s.index==0}"> 
								<label class="control-label col-md-2">
									版块URL
								</label>
								</c:if>
								<c:if test="${s.index>0}"> 
								<label class="control-label col-md-2">
								</label>
								</c:if>
								<div class="col-md-4">
									<input class="form-control" placeholder="" type="text" value="${sectionUrlParserMap.key }">
								</div>
								<div class="col-md-4">
									<span style="display:none"><xmp>${sectionUrlParserMap.value }</xmp></span>
									<input class="form-control" placeholder="" type="text" value="${sectionUrlParserMap.value }">
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
					<c:if test="${rule.sectionUrlParserMap != null&&extraRule.sectionUrlParserMap == null}">
						<c:forEach var="sectionUrlParserMap" items="${rule.sectionUrlParserMap }" varStatus="s">
							<div class="form-group" name="sectionUrlParserMap"> 
								<c:if test="${s.index==0}"> 
								<label class="control-label col-md-2">
									版块URL
								</label>
								</c:if>
								<c:if test="${s.index>0}"> 
								<label class="control-label col-md-2">
								</label>
								</c:if>
								<div class="col-md-4">
									<input class="form-control" placeholder="${sectionUrlParserMap.key }" type="text" value="">
								</div>
								<div class="col-md-4">
									<span style="display:none"><xmp>${sectionUrlParserMap.value }</xmp></span>
									<input class="form-control" placeholder="${sectionUrlParserMap.value }" type="text" value="">
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
					<!-- ffffffffffffff -->
					
					<!-- ffffffffffffff222222222 -->
					<c:if test="${rule.sectionNameParserMap == null&&extraRule.sectionNameParserMap == null}">
					<div class="form-group" name="listUrlParserMap"> 
						<label class="control-label col-md-2">
							版块名称
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
					<c:if test="${extraRule.sectionNameParserMap != null}">
						<c:forEach var="sectionNameParserMap" items="${extraRule.sectionNameParserMap }" varStatus="s">
							<div class="form-group" name="sectionNameParserMap"> 
								<c:if test="${s.index==0}"> 
								<label class="control-label col-md-2">
									版块名称
								</label>
								</c:if>
								<c:if test="${s.index>0}"> 
								<label class="control-label col-md-2">
								</label>
								</c:if>
								<div class="col-md-4">
									<input class="form-control" placeholder="" type="text" value="${sectionNameParserMap.key }">
								</div>
								<div class="col-md-4">
									<span style="display:none"><xmp>${sectionNameParserMap.value }</xmp></span>
									<input class="form-control" placeholder="" type="text" value="${sectionNameParserMap.value }">
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
					<c:if test="${rule.sectionNameParserMap != null&&extraRule.sectionNameParserMap == null}">
						<c:forEach var="sectionNameParserMap" items="${rule.sectionNameParserMap }" varStatus="s">
							<div class="form-group" name="sectionNameParserMap"> 
								<c:if test="${s.index==0}"> 
								<label class="control-label col-md-2">
									版块名称
								</label>
								</c:if>
								<c:if test="${s.index>0}"> 
								<label class="control-label col-md-2">
								</label>
								</c:if>
								<div class="col-md-4">
									<input class="form-control" placeholder="${sectionNameParserMap.key }" type="text" value="">
								</div>
								<div class="col-md-4">
									<span style="display:none"><xmp>${sectionNameParserMap.value }</xmp></span>
									<input class="form-control" placeholder="${sectionNameParserMap.value }" type="text" value="">
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
					<!-- ffffffffffffff222222222 -->
					<c:if test="${rule.sectionAdditionalParserMap == null&&extraRule.sectionAdditionalParserMap == null}"><span style="display:none;" id="sectionAdditionalShowFlag"></span></c:if>
						<div class="form-group other" style="text-align:center;" ><a href="javascript:;" onclick="showOther(this)">添加其他</a></div>
						<c:if test="${rule.sectionAdditionalParserMap == null&&extraRule.sectionAdditionalParserMap == null}">
						<div class="form-group sectionAdditionalParserMap" name="sectionAdditionalParserMap">
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
						<c:if test="${extraRule.sectionAdditionalParserMap != null}">
							<c:forEach var="sectionAdditionalParserMap" items="${extraRule.sectionAdditionalParserMap }" varStatus="s">	
								<div class="form-group sectionAdditionalParserMap" name="sectionAdditionalParserMap">	
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
										<input class="form-control" placeholder="" type="text"  value="${sectionAdditionalParserMap.key }">
									</div>
									<c:forEach var="sectionAdditionalParserMap2" items="${sectionAdditionalParserMap.value }">
										<div class="col-md-3">
											<input class="form-control" placeholder="" type="text" value="${sectionAdditionalParserMap2.key }">
										</div>
										<div class="col-md-3">
											<span style="display:none"><xmp>${sectionAdditionalParserMap2.value }</xmp></span>
											<input class="form-control" placeholder="" type="text" value="${sectionAdditionalParserMap2.value }">
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
						<c:if test="${rule.sectionAdditionalParserMap != null&&extraRule.sectionAdditionalParserMap == null}">
							<c:forEach var="sectionAdditionalParserMap" items="${rule.sectionAdditionalParserMap }" varStatus="s">	
								<div class="form-group sectionAdditionalParserMap" name="sectionAdditionalParserMap">	
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
										<input class="form-control" placeholder="${sectionAdditionalParserMap.key }" type="text"  value="">
									</div>
									<c:forEach var="sectionAdditionalParserMap2" items="${sectionAdditionalParserMap.value }">
										<div class="col-md-3">
											<input class="form-control" placeholder="${sectionAdditionalParserMap2.key }" type="text" value="">
										</div>
										<div class="col-md-3">
											<span style="display:none"><xmp>${sectionAdditionalParserMap2.value }</xmp></span>
											<input class="form-control" placeholder="${sectionAdditionalParserMap2.value }" type="text" value="">
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
			<legend  id="tab3">
				<span style="float:left;">解析列表</span> 
				<span style="float:right;">
					<c:if test="${epaperPublicListRuleName == null ||epaperPublicListRuleName=='' }">
						<a class="glyphicon glyphicon-flag extends_flag" onclick="cancelExtends(this,1)" style="color:#ccc;text-decoration:none;" title="当前无继承模板" flag_title="当前无继承模板" href="javascript:void(0);" style="text-decoration: none;"></a>&nbsp;&nbsp;
					</c:if>
					<c:if test="${epaperPublicListRuleName != null &&epaperPublicListRuleName!='' }">
						<a class="glyphicon glyphicon-flag extends_flag"  onclick="cancelExtends(this,1)" data-placement="top" title="继承模板【${epaperPublicListRuleName }】,点击取消继承" flag_title="继承模板【${epaperPublicListRuleName }】" href="javascript:void(0);" style="text-decoration: none;"></a>&nbsp;&nbsp;
					</c:if>
					<a class="glyphicon glyphicon-cog" onclick="use_list_model()" title="使用模板" href="javascript:;" style="text-decoration: none;"></a>&nbsp;&nbsp;
					<a class="glyphicon glyphicon-arrow-up" onclick="ready_to_create_list_model()" title="生成模板" href="javascript:;" style="text-decoration: none;"></a>&nbsp;&nbsp;
				
				</span>
				<div style="clear:both;"></div>
			</legend>
			
			<!-- html-box start -->
			<c:if test="${rule.publicListRuleId ==null}">
			<div class="html-box">
				
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
				<c:if test="${rule.sectionThumbnailUrlParserMap == null}">
				<div class="form-group" name="sectionThumbnailUrlParserMap"> 
					<label class="control-label col-md-2">
						缩略图
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
				<c:if test="${rule.sectionThumbnailUrlParserMap != null}">
					<c:forEach var="sectionThumbnailUrlParserMap" items="${rule.sectionThumbnailUrlParserMap }" varStatus="s">
						<div class="form-group" name="sectionThumbnailUrlParserMap"> 
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								缩略图
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="selector" type="text" value="${sectionThumbnailUrlParserMap.key }">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${sectionThumbnailUrlParserMap.value }</xmp></span>
								<input class="form-control" placeholder="locator" type="text" value="${sectionThumbnailUrlParserMap.value }">
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
				<c:if test="${rule.sectionThumbnailUrlParserMap == null&&extraRule.sectionThumbnailUrlParserMap == null}">
				<div class="form-group" name="sectionThumbnailUrlParserMap"> 
					<label class="control-label col-md-2">
						缩略图
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
				<c:if test="${extraRule.sectionThumbnailUrlParserMap != null}">
					<c:forEach var="sectionThumbnailUrlParserMap" items="${extraRule.sectionThumbnailUrlParserMap }" varStatus="s">
						<div class="form-group" name="sectionThumbnailUrlParserMap"> 
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								缩略图
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="" type="text" value="${sectionThumbnailUrlParserMap.key }">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${sectionThumbnailUrlParserMap.value }</xmp></span>
								<input class="form-control" placeholder="" type="text" value="${sectionThumbnailUrlParserMap.value }">
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
				<c:if test="${rule.sectionThumbnailUrlParserMap != null&&extraRule.sectionThumbnailUrlParserMap == null}">
					<c:forEach var="sectionThumbnailUrlParserMap" items="${rule.sectionThumbnailUrlParserMap }" varStatus="s">
						<div class="form-group" name="sectionThumbnailUrlParserMap"> 
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								缩略图
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="${sectionThumbnailUrlParserMap.key }" type="text" value="">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${sectionThumbnailUrlParserMap.value }</xmp></span>
								<input class="form-control" placeholder="${sectionThumbnailUrlParserMap.value }" type="text" value="">
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
			
			
			
			
			<legend   id="tab4">
				<span style="float:left;">解析正文</span> 
				<span style="float:right;">
					<c:if test="${epaperPublicTextRuleName == null ||epaperPublicTextRuleName=='' }">
						<a class="glyphicon glyphicon-flag extends_flag"  onclick="cancelExtends(this,2)" style="color:#ccc;text-decoration:none;" title="当前无继承模板" flag_title="当前无继承模板" rel="tooltip" href="javascript:void(0);" style="text-decoration: none;"></a>&nbsp;&nbsp;
					</c:if>
					<c:if test="${epaperPublicTextRuleName != null &&epaperPublicTextRuleName!='' }">
						<a class="glyphicon glyphicon-flag extends_flag"   onclick="cancelExtends(this,2)" title="继承模板【${epaperPublicTextRuleName }】,点击取消继承" flag_title="继承模板【${epaperPublicTextRuleName }】" href="javascript:void(0);" style="text-decoration: none;"></a>&nbsp;&nbsp;
					</c:if>
					<a class="glyphicon glyphicon-cog" onclick="use_text_model()" title="使用模板" href="javascript:;" style="text-decoration: none;"></a>&nbsp;&nbsp;
					<a class="glyphicon glyphicon-arrow-up" onclick="ready_to_create_text_model()" title="生成模板" href="javascript:;" style="text-decoration: none;"></a>
				</span> 
				<div style="clear:both;"></div>
			</legend>
			<!-- html-box2 start -->
			<c:if test="${rule.publicTextRuleId ==null}">
			<div class="html-box">
			<div class="form-group" name="textCharset">
				<label class="control-label col-md-2">
					正文字符集
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${rule.textCharset }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${rule.textCharset }">
				</div>
			</div>
			<c:if test="${rule.textTitleParserMap == null}">
			<div class="form-group" name="textTitleParserMap">
				<label class="control-label col-md-2">
					标题
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${textTitleParserMap.key }">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="${textTitleParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${rule.textTitleParserMap!= null}">
				<c:forEach var="textTitleParserMap" items="${rule.textTitleParserMap }" varStatus="s">
				<div class="form-group" name="textTitleParserMap">
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
						<input class="form-control" placeholder="selector" type="text"  value="${textTitleParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${textTitleParserMap.value }</xmp></span>
						<input class="form-control" placeholder="locator" type="text" value="${textTitleParserMap.value }">
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
			<div class="form-group" name="textCharset">
				<label class="control-label col-md-2">
					正文字符集
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${extraRule.textCharset==null?rule.textCharset:extraRule.textCharset }</xmp></span>
					<input class="form-control" placeholder="${rule.textCharset }" type="text" value="${extraRule.textCharset }">
				</div>
			</div>
			<c:if test="${rule.textTitleParserMap == null&&extraRule.textTitleParserMap==null}">
			<div class="form-group" name="textTitleParserMap">
				<label class="control-label col-md-2">
					标题
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
			<c:if test="${extraRule.textTitleParserMap!=null}">
				<c:forEach var="textTitleParserMap" items="${extraRule.textTitleParserMap }" varStatus="s">
				<div class="form-group" name="textTitleParserMap">
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
						<input class="form-control" placeholder="" type="text"  value="${textTitleParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${textTitleParserMap.value }</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${textTitleParserMap.value }">
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
			<c:if test="${rule.textTitleParserMap!= null&&extraRule.textTitleParserMap==null}">
				<c:forEach var="textTitleParserMap" items="${rule.textTitleParserMap }" varStatus="s">
				<div class="form-group" name="textTitleParserMap">
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
						<input class="form-control" placeholder="${textTitleParserMap.key }" type="text"  value="">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${textTitleParserMap.value }</xmp></span>
						<input class="form-control" placeholder="${textTitleParserMap.value }" type="text" value="">
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
<script>
	$(function(){
		/*
		var listDataType = $("#mainFrm div[name='listDataType'] input").val();
		//console.log("17:00-------------------->"+listDataType);
		if(!listDataType){
			$("div[name='listDataType'] input").attr("value","2");
			//alert("---------->"+$("div[name='listDataType'] input").length);
			listDataType = "2";
		}
		console.log("listDataType"+listDataType);
		
		var textDataType = $("#mainFrm div[name='textDataType'] input").val();
		//console.log("17:00-------------------->"+listDataType);
		if(!textDataType){
			$("div[name='textDataType'] input").attr("value","2");
			//alert("---------->"+$("div[name='listDataType'] input").length);
			textDataType = "2";
		}
		var public_list_rule_id = $("div[name='publicListRuleId'] input").val();
		
		var fetch_strategy = $("div[name='fetchStrategy'] input").val()?$("div[name='fetchStrategy'] input").val():$("div[name='fetchStrategy'] input").attr("placeholder");
		if(!fetch_strategy){
			//if(!public_list_rule_id||(public_list_rule_id)){
				$("div[name='fetchStrategy'] input").attr("value",1);
				$("div[name='fetchStrategy'] input").val(1);
				fetch_strategy = 1;
			//}
		}*/
	});
	
</script>