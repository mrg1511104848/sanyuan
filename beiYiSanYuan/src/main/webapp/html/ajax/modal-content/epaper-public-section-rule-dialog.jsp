<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
		$(function(){
			var sectionAdditionalShowFlagLength = $("#sectionAdditionalShowFlag").length;
			if(sectionAdditionalShowFlagLength>0){
				$(".sectionAdditionalParserMap").hide();
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
					<span style="display:none"><xmp>${epaperPublicSectionRule.id }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${epaperPublicSectionRule.id }">
				</div>
			</div>
			<div class="form-group" name="name">
				<label class="control-label col-md-2">
					自定义名称
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${epaperPublicSectionRule.name }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${epaperPublicSectionRule.name }">
				</div>
			</div>
			<div class="form-group" name="everySectionSelector">
					<label class="control-label col-md-2">
						版块列表循环域
					</label>
					<div class="col-md-5">
						<span style="display:none"><xmp>${epaperPublicSectionRule.everySectionSelector }</xmp></span>
						<input class="form-control" placeholder="" type="text" value="${epaperPublicSectionRule.everySectionSelector }">
					</div>
			</div>
			
			
			<c:if test="${epaperPublicSectionRule.sectionUrlParserMap == null}">
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
				<c:if test="${epaperPublicSectionRule.sectionUrlParserMap != null}">
						<c:forEach var="sectionUrlParserMap" items="${epaperPublicSectionRule.sectionUrlParserMap }" varStatus="s">
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
				<c:if test="${epaperPublicSectionRule.sectionNameParserMap == null}">
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
				<c:if test="${epaperPublicSectionRule.sectionNameParserMap != null}">
						<c:forEach var="sectionNameParserMap" items="${epaperPublicSectionRule.sectionNameParserMap }" varStatus="s">
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
			
				<c:if test="${epaperPublicSectionRule.sectionAdditionalParserMap == null}"><span style="display:none;" id="sectionAdditionalShowFlag"></span></c:if>
				<div class="form-group other" style="text-align:center;" ><a href="javascript:;" onclick="showOther(this)">添加其他</a></div>
				<c:if test="${epaperPublicSectionRule.sectionAdditionalParserMap == null}">
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
				<c:forEach var="sectionAdditionalParserMap" items="${epaperPublicSectionRule.sectionAdditionalParserMap }" varStatus="s">	
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
		</fieldset>
	</form>
</div>

