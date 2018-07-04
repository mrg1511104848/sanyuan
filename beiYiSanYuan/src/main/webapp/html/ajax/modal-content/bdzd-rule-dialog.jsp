<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
pageSetUp();

		$(function(){
			$(".html-box:eq(0) .form-group").each(function(){
				var pre = $(this).find("input:last").prev();
				if(pre){
					var v = pre.text().trim();
					$(this).find("input:last").val(v);
					$(this).find("input:last").attr("value",v);
				}
			});
			$(".html-box:eq(1) .form-group").each(function(){
					var pre = $(this).find("input:last").prev();
					if(pre){
						var v = pre.text().trim();
						$(this).find("input:last").val(v);
						$(this).find("input:last").attr("value",v);
					}
				});

			
				$(".epaper-public-section-rule-box .form-group").each(function(){
					var pre = $(this).find("input:last").prev();
					if(pre){
						var v = pre.text().trim();
						$(this).find("input:last").val(v);
						$(this).find("input:last").attr("value",v);
					}
				});
			

			/*
			var listAdditionalShowFlagLength = $("#listAdditionalShowFlag").length;
			if(listAdditionalShowFlagLength>0){
				$(".listAdditionalParserMap").hide();
			}*/
			var textAdditionalShowFlagLength = $("#textAdditionalShowFlag").length;
			if(textAdditionalShowFlagLength>0){
				$(".textAdditionalParserMap").hide();
			}
		})
</script>

<div  title="Dialog Simple Title" class="col-sm-6" id="leftEditBox" style="overflow-y: scroll;height: 570px;">
	<form class="form-horizontal col col-6" id="mainFrm">
		<fieldset>
			<legend>
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
			<div class="form-group siteId" name="siteId" style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="${siteId }">
				</div>
			</div>
			<div class="form-group" name="siteName" >
				<label class="control-label col-md-2">
					版块名称
				</label>
				<div class="col-sm-10">
					<input class="form-control" placeholder="" type="text" value="${site}">
				</div>
			</div>
			<div class="form-group" name="siteUrl" >
				<label class="control-label col-md-2">
					版块URL
				</label>
				<div class="col-md-10">
					<input class="form-control" placeholder="" type="text" value="${siteUrl }">
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
			<!-- 类型信息start -->
			<legend>
				<span style="float:left;">类型信息</span> 
				<span style="float:right;">
					<c:if test="${epaperPublicSectionRuleName == null ||epaperPublicSectionRuleName=='' }">
						<a class="glyphicon glyphicon-flag extends_flag" onclick="cancelExtends(this,0)" style="color:#ccc;text-decoration:none;" title="当前无继承模板" flag_title="当前无继承模板" href="javascript:void(0);" style="text-decoration: none;"></a>&nbsp;&nbsp;
					</c:if>
					<a class="glyphicon glyphicon-cog" onclick="use_epaper_section_model()" title="使用模板" href="javascript:;" style="text-decoration: none;"></a>&nbsp;&nbsp;
					<a class="glyphicon glyphicon-arrow-up" onclick="ready_to_create_epaper_section_model()" title="生成模板" href="javascript:;" style="text-decoration: none;"></a>&nbsp;&nbsp;
				</span>
				<div style="clear:both;"></div>
			</legend>
			<div class="epaper-public-section-rule-box">
					<div class="form-group" name="everyTypeSelector">
						<label class="control-label col-md-2">
							类型列表循环域
						</label>
						<div class="col-md-5">
							<span style="display:none"><xmp>${rule.everyTypeSelector }</xmp></span>
							<input class="form-control" placeholder="" type="text" value="${rule.everyTypeSelector }">
						</div>
					</div>
					
					<c:if test="${rule.listTypeUrlParserMap == null}">
						<div class="form-group" name="listTypeUrlParserMap"> 
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
					<c:if test="${rule.listTypeUrlParserMap != null}">
							<c:forEach var="listTypeUrlParserMap" items="${rule.listTypeUrlParserMap }" varStatus="s">
								<div class="form-group" name="listTypeUrlParserMap"> 
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
										<input class="form-control" placeholder="selector" type="text" value="${listTypeUrlParserMap.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${listTypeUrlParserMap.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${listTypeUrlParserMap.value }">
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
					
					<c:if test="${rule.listTypeUrlTitleParserMap == null}">
						<div class="form-group" name="listTypeUrlTitleParserMap"> 
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
					<c:if test="${rule.listTypeUrlTitleParserMap != null}">
							<c:forEach var="listTypeUrlTitleParserMap" items="${rule.listTypeUrlTitleParserMap }" varStatus="s">
								<div class="form-group" name="listTypeUrlTitleParserMap"> 
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
										<input class="form-control" placeholder="selector" type="text" value="${listTypeUrlTitleParserMap.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${listTypeUrlTitleParserMap.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${listTypeUrlTitleParserMap.value }">
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
					<c:if test="${rule.listTypeParserMap == null}">
						<div class="form-group" name="listTypeParserMap"> 
							<label class="control-label col-md-2">
								所属分类
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
					<c:if test="${rule.listTypeParserMap != null}">
							<c:forEach var="listTypeParserMap" items="${rule.listTypeParserMap }" varStatus="s">
								<div class="form-group" name="listTypeParserMap"> 
									<c:if test="${s.index==0}"> 
									<label class="control-label col-md-2">
										所属分类
									</label>
									</c:if>
									<c:if test="${s.index>0}"> 
									<label class="control-label col-md-2">
									</label>
									</c:if>
									<div class="col-md-4">
										<input class="form-control" placeholder="selector" type="text" value="${listTypeParserMap.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${listTypeParserMap.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${listTypeParserMap.value }">
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
			<!-- 类型信息end -->
			<legend>
				<span style="float:left;">解析列表</span> 
				<div style="clear:both;"></div>
			</legend>
			
			<!-- html-box start -->
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
					<c:forEach var="listNextPageParserMap" items="${rule.listNextPageParserMap }" varStatus="s">
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
								<input class="form-control" placeholder="selector" type="text" value="${listNextPageParserMap.key }">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${listNextPageParserMap.value }</xmp></span>
								<input class="form-control" placeholder="locator" type="text" value="${listNextPageParserMap.value }">
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
				<div class="form-group" name="page">
					<label class="control-label col-md-2">
						抓取页码
					</label>
					<div class="col-md-5">
						<span style="display:none"><xmp>${rule.page }</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${rule.page }">
					</div>
				</div>
			</div>
			<!-- html-box end -->
			<legend>
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
			<div class="html-box">
			<div class="form-group" name="textCharset">
				<label class="control-label col-md-2">
					答案字符集
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${rule.textCharset }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${rule.textCharset }">
				</div>
			</div>
			<div class="form-group" name="everyAnswerSelector">
				<label class="control-label col-md-2">
					答案循环域
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${rule.everyAnswerSelector }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${rule.everyAnswerSelector }">
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
			<c:if test="${rule.textAskPeopleParserMap == null}">
			<div class="form-group" name="textAskPeopleParserMap">
				<label class="control-label col-md-2">
					提问人
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${textAskPeopleParserMap.key }">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="${textAskPeopleParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${rule.textAskPeopleParserMap != null}">
			<c:forEach var="textAskPeopleParserMap" items="${rule.textAskPeopleParserMap }" varStatus="s">
				<div class="form-group" name="textAskPeopleParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							提问人
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text"  value="${textAskPeopleParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${textAskPeopleParserMap.value }</xmp></span>
						<input class="form-control" placeholder="locator" type="text"  value="${textAskPeopleParserMap.value }">
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
			
			<c:if test="${rule.textAskTimeParserMap == null}">
			<div class="form-group" name="textAskTimeParserMap">
				<label class="control-label col-md-2">
					提问时间
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${textAskTimeParserMap.key }">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="${textAskTimeParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${rule.textAskTimeParserMap != null}">
			<c:forEach var="textAskTimeParserMap" items="${rule.textAskTimeParserMap }" varStatus="s">
				<div class="form-group" name="textAskTimeParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							提问时间
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text"  value="${textAskTimeParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${textAskTimeParserMap.value }</xmp></span>
						<input class="form-control" placeholder="locator" type="text"  value="${textAskTimeParserMap.value }">
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
			
			
			<c:if test="${rule.textAnswerPeopleParserMap == null}">
			<div class="form-group" name="textAnswerPeopleParserMap">
				<label class="control-label col-md-2">
					回答人
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${textAnswerPeopleParserMap.key }">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="${textAnswerPeopleParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
			</div>
			</c:if>
			<c:if test="${rule.textAnswerPeopleParserMap != null}">
			<c:forEach var="textAnswerPeopleParserMap" items="${rule.textAnswerPeopleParserMap }" varStatus="s">
				<div class="form-group" name="textAnswerPeopleParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							回答人
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text"  value="${textAnswerPeopleParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${textAnswerPeopleParserMap.value }</xmp></span>
						<input class="form-control" placeholder="locator" type="text"  value="${textAnswerPeopleParserMap.value }">
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
			
			<c:if test="${rule.textAnswerTimeParserMap == null}">
			<div class="form-group" name="textAnswerTimeParserMap">
				<label class="control-label col-md-2">
					回答时间
				</label>
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${textAnswerTimeParserMap.key }">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="${textAnswerTimeParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
			</div>
			</c:if>
			<c:if test="${rule.textAnswerTimeParserMap != null}">
			<c:forEach var="textAnswerTimeParserMap" items="${rule.textAnswerTimeParserMap }" varStatus="s">
				<div class="form-group" name="textAnswerTimeParserMap">
					<c:if test="${s.index==0}"> 
						<label class="control-label col-md-2">
							回答时间
						</label>
						</c:if>
						<c:if test="${s.index>0}"> 
						<label class="control-label col-md-2">
						</label>
						</c:if>
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text"  value="${textAnswerTimeParserMap.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${textAnswerTimeParserMap.value }</xmp></span>
						<input class="form-control" placeholder="locator" type="text"  value="${textAnswerTimeParserMap.value }">
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
			
			
			
			<c:if test="${rule.businessFlagParserMap == null}">
			<div class="form-group" name="businessFlagParserMap">
				<label class="control-label col-md-2">
					企业标志
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${businessFlagParserMap.key }">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="${businessFlagParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${rule.businessFlagParserMap != null}">
				<c:forEach var="businessFlagParserMap" items="${rule.businessFlagParserMap }" varStatus="s">
						<div class="form-group" name="businessFlagParserMap">
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								企业标志
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="selector" type="text"  value="${businessFlagParserMap.key }">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${businessFlagParserMap.value }</xmp></span>
								<input class="form-control" placeholder="locator" type="text" value="${businessFlagParserMap.value }">
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
			
			<c:if test="${rule.bestFlagParserMap == null}">
			<div class="form-group" name="bestFlagParserMap">
				<label class="control-label col-md-2">
					采纳标志
				</label>
				
					<div class="col-md-4">
						<input class="form-control" placeholder="selector" type="text" value="${bestFlagParserMap.key }">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="${bestFlagParserMap.value }">
					</div>
					<div class="col-md-2">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this)"><i class="fa fa-plus"></i></a>
					</div>
				
				
			</div>
			</c:if>
			<c:if test="${rule.bestFlagParserMap != null}">
				<c:forEach var="bestFlagParserMap" items="${rule.bestFlagParserMap }" varStatus="s">
						<div class="form-group" name="bestFlagParserMap">
							<c:if test="${s.index==0}"> 
							<label class="control-label col-md-2">
								采纳标志
							</label>
							</c:if>
							<c:if test="${s.index>0}"> 
							<label class="control-label col-md-2">
							</label>
							</c:if>
							<div class="col-md-4">
								<input class="form-control" placeholder="selector" type="text"  value="${bestFlagParserMap.key }">
							</div>
							<div class="col-md-4">
								<span style="display:none"><xmp>${bestFlagParserMap.value }</xmp></span>
								<input class="form-control" placeholder="locator" type="text" value="${bestFlagParserMap.value }">
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
			<!-- html-box2 end -->
		</fieldset>
	</form>
</div>
<div class="col-sm-6" id="fatch-news-list"  style="border-left:1px dashed rgba(0,0,0,.2);height:570px;overflow-y: scroll;min-width:541px;">
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
	});
	
</script>