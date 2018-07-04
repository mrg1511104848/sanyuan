<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
		$(function(){
			var additionalShowFlagLength = $("#textAdditionalShowFlag_").length;
			if(additionalShowFlagLength>0){
				$(".textAdditionalParserMap").hide();
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
		})
</script>
<div  title="Dialog Simple Title" class="col-sm-12" id="" style="min-width:600px;height:570px;overflow-y: scroll;">
	<form class="form-horizontal col col-6" id="mainFrm">
	<fieldset>
			<legend>
				解析正文
			</legend>
			<div class="form-group" name="id" style="display:none;">
				<label class="control-label col-md-2">
					id
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicTextRule.id }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicTextRule.id }">
				</div>
			</div>
			<div class="form-group" name="name">
				<label class="control-label col-md-2">
					自定义名称
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicTextRule.name }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicTextRule.name }">
				</div>
			</div>
			<div class="form-group" name="textCharset">
				<label class="control-label col-md-2">
					正文字符集
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicTextRule.textCharset }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicTextRule.textCharset }">
				</div>
			</div>
			<c:if test="${publicTextRule.textTimeParserMap == null}">
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
			<c:if test="${publicTextRule.textTimeParserMap != null}">
			<c:forEach var="timeParserMap" items="${publicTextRule.textTimeParserMap }"  varStatus="s">
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
			<c:if test="${publicTextRule.textTitleParserMap == null}">
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
			<c:if test="${publicTextRule.textTitleParserMap!= null}">
				<c:forEach var="textTitleParserMap" items="${publicTextRule.textTitleParserMap }" varStatus="s">
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
			
			
			
			
			<c:if test="${publicTextRule.textContentParserMap == null}">
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
			<c:if test="${publicTextRule.textContentParserMap!= null}">
				<c:forEach var="contentParserMap" items="${publicTextRule.textContentParserMap }" varStatus="s">
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
			<c:if test="${publicTextRule.textImgUrlsParserMap == null}">
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
			<c:if test="${publicTextRule.textImgUrlsParserMap != null}">
			<c:forEach var="imgUrlsParserMap" items="${publicTextRule.textImgUrlsParserMap }" varStatus="s">
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
			<c:if test="${publicTextRule.textAuthorParserMap == null}">
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
			<c:if test="${publicTextRule.textAuthorParserMap != null}">
			<c:forEach var="authorParserMap" items="${publicTextRule.textAuthorParserMap }" varStatus="s">
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
						<input class="form-control" placeholder="locator" type="text" value="${authorParserMap.value }">
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
			<c:if test="${publicTextRule.textSourceParserMap == null}">
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
			<c:if test="${publicTextRule.textSourceParserMap != null}">
				<c:forEach var="sourceParserMap" items="${publicTextRule.textSourceParserMap }" varStatus="s">
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
			<c:if test="${publicTextRule.textNextPageParserMap == null}">
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
			<c:if test="${publicTextRule.textNextPageParserMap != null}">
			<c:forEach var="nextPageParserMap" items="${publicTextRule.textNextPageParserMap }" varStatus="s">
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
			<c:if test="${publicTextRule.textAdditionalParserMap == null}"><span style="display:none;" id="textAdditionalShowFlag_"></span></c:if>
			<div class="form-group" style="text-align:center;"><a href="javascript:;" onclick="showOther(this)">添加其他</a></div>
			<c:if test="${publicTextRule.textAdditionalParserMap == null}">
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
			<c:forEach var="additionalParserMap" items="${publicTextRule.textAdditionalParserMap }" varStatus="s">	
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