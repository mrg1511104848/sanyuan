<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
		$(function(){
			var additionalShowFlagLength = $("#listAdditionalShowFlag_").length;
			if(additionalShowFlagLength>0){
				$(".listAdditionalParserMap").hide();
			}
			$("#mainFrm .form-group").each(function(){
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
		});
</script>
<div  title="Dialog Simple Title" class="col-sm-12" id="" style="">
	<form class="form-horizontal col col-6" id="mainFrm">
	<fieldset>
			<legend>
				<span >基本信息</span> 
			</legend>
			<div class="form-group" name="id" style="display:none;">
				<label class="control-label col-md-2">
					id
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicListRule.id }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicListRule.id }">
				</div>
			</div>
			<div class="form-group" name="name">
				<label class="control-label col-md-2">
					自定义名称
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicListRule.name }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicListRule.name }">
				</div>
			</div>
			<div class="form-group" name="everyArticleSelector">
				<label class="control-label col-md-2">
					列表循环域
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicListRule.everyArticleSelector }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicListRule.everyArticleSelector }">
				</div>
			</div>
			<div class="form-group" name=listCharset>
				<label class="control-label col-md-2">
					列表字符集
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicListRule.listCharset }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicListRule.listCharset }">
				</div>
			</div>
			<c:if test="${publicListRule.listUrlParserMap == null}">
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
			<c:if test="${publicListRule.listUrlParserMap != null}">
				<c:forEach var="urlParserMap" items="${publicListRule.listUrlParserMap }" varStatus="s">
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
			<c:if test="${publicListRule.listTitleParserMap == null}">
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
			<c:if test="${publicListRule.listTitleParserMap != null}">
				<c:forEach var="titleParserMap" items="${publicListRule.listTitleParserMap }" varStatus="s">
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
			
			<c:if test="${publicListRule.sectionThumbnailUrlParserMap == null}">
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
			<c:if test="${publicListRule.sectionThumbnailUrlParserMap != null}">
				<c:forEach var="sectionThumbnailUrlParserMap" items="${publicListRule.sectionThumbnailUrlParserMap }" varStatus="s">
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
							<input class="form-control" placeholder="selector" type="text"  value="${sectionThumbnailUrlParserMap.key }">
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
			
			
			<c:if test="${publicListRule.listAdditionalParserMap == null}"><span style="display:none;" id="listAdditionalShowFlag_"></span></c:if>
			<div class="form-group" style="text-align:center;"><a href="javascript:;" onclick="showOther(this)">添加其他</a></div>
			<c:if test="${publicListRule.listAdditionalParserMap == null}">
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
			<c:forEach var="additionalParserMap" items="${publicListRule.listAdditionalParserMap }" varStatus="s">	
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
						<input class="form-control" placeholder="selector" type="text"  value="${additionalParserMap.key }">
					</div>
					<c:forEach var="additionalParserMap2" items="${additionalParserMap.value }">
						<div class="col-md-3">
							<input class="form-control" placeholder="locator" type="text" value="${additionalParserMap2.key }">
						</div>
						<div class="col-md-3">
							<span style="display:none"><xmp>${additionalParserMap2.value }</xmp></span>
							<input class="form-control" placeholder="locator" type="text" value="${additionalParserMap2.value }">
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
		</fieldset>
	</form>
</div>

