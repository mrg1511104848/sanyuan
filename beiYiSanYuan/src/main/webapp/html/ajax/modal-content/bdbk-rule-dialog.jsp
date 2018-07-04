<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
pageSetUp();
		$(function(){
			/*
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
			
			*/
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
			
			<div class="form-group" name="id" style="display:none;">
				<div class="col-sm-10">
					<input  type="text" value="${rule.id }">
				</div>
			</div>
			
			<div class="form-group" name="textPageUrl" >
				<label class="control-label col-md-2">
					URL
				</label>
				<div class="col-md-10">
					<input class="form-control" placeholder="" type="text" value="${siteUrl }">
				</div>
			</div>
			<c:if test="${rule.title == null}">
					<div class="form-group" name="title"> 
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
			<c:if test="${rule.title != null}">
				<c:forEach var="title" items="${rule.title }" varStatus="s">
								<div class="form-group" name="title"> 
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
										<input class="form-control" placeholder="selector" type="text" value="${title.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${title.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${title.value }">
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
			<c:if test="${rule.useful == null}">
					<div class="form-group" name="useful"> 
							<label class="control-label col-md-2">
								有用的
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
			<c:if test="${rule.useful!= null}">
				<c:forEach var="useful" items="${rule.useful }" varStatus="s">
								<div class="form-group" name="useful"> 
									<c:if test="${s.index==0}"> 
									<label class="control-label col-md-2">
										有用的
									</label>
									</c:if>
									<c:if test="${s.index>0}"> 
									<label class="control-label col-md-2">
									</label>
									</c:if>
									<div class="col-md-4">
										<input class="form-control" placeholder="selector" type="text" value="${useful.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${useful.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${useful.value }">
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
			
			<c:if test="${rule.shared == null}">
					<div class="form-group" name="shared"> 
							<label class="control-label col-md-2">
								分享的
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
			<c:if test="${rule.shared!= null}">
				<c:forEach var="shared" items="${rule.shared }" varStatus="s">
								<div class="form-group" name="shared"> 
									<c:if test="${s.index==0}"> 
									<label class="control-label col-md-2">
										分享的
									</label>
									</c:if>
									<c:if test="${s.index>0}"> 
									<label class="control-label col-md-2">
									</label>
									</c:if>
									<div class="col-md-4">
										<input class="form-control" placeholder="selector" type="text" value="${shared.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${shared.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${shared.value }">
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
			
			<c:if test="${rule.cardSummary == null}">
					<div class="form-group" name="cardSummary"> 
							<label class="control-label col-md-2">
								概述
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
			<c:if test="${rule.cardSummary != null}">
				<c:forEach var="cardSummary" items="${rule.cardSummary }" varStatus="s">
								<div class="form-group" name="cardSummary"> 
									<c:if test="${s.index==0}"> 
									<label class="control-label col-md-2">
										概述
									</label>
									</c:if>
									<c:if test="${s.index>0}"> 
									<label class="control-label col-md-2">
									</label>
									</c:if>
									<div class="col-md-4">
										<input class="form-control" placeholder="selector" type="text" value="${cardSummary.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${cardSummary.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${cardSummary.value }">
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
			
			<c:if test="${rule.imgs == null}">
					<div class="form-group" name="imgs"> 
							<label class="control-label col-md-2">
								图片
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
			<c:if test="${rule.imgs != null}">
				<c:forEach var="imgs" items="${rule.imgs }" varStatus="s">
								<div class="form-group" name="imgs"> 
									<c:if test="${s.index==0}"> 
									<label class="control-label col-md-2">
										图片
									</label>
									</c:if>
									<c:if test="${s.index>0}"> 
									<label class="control-label col-md-2">
									</label>
									</c:if>
									<div class="col-md-4">
										<input class="form-control" placeholder="selector" type="text" value="${imgs.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${imgs.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${imgs.value }">
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
			
			<c:if test="${rule.linkUrls == null}">
					<div class="form-group" name="linkUrls"> 
							<label class="control-label col-md-2">
								所要深度挖掘的链接
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
			<c:if test="${rule.linkUrls != null}">
				<c:forEach var="linkUrls" items="${rule.linkUrls }" varStatus="s">
								<div class="form-group" name="linkUrls"> 
									<c:if test="${s.index==0}"> 
									<label class="control-label col-md-2">
										所要深度挖掘的链接
									</label>
									</c:if>
									<c:if test="${s.index>0}"> 
									<label class="control-label col-md-2">
									</label>
									</c:if>
									<div class="col-md-4">
										<input class="form-control" placeholder="selector" type="text" value="${linkUrls.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${linkUrls.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${linkUrls.value }">
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
			
			<c:if test="${rule.linkTexts == null}">
					<div class="form-group" name="linkTexts"> 
							<label class="control-label col-md-2">
								所要深度挖掘的链接文本
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
			<c:if test="${rule.linkTexts != null}">
				<c:forEach var="linkTexts" items="${rule.linkTexts }" varStatus="s">
								<div class="form-group" name="linkTexts"> 
									<c:if test="${s.index==0}"> 
									<label class="control-label col-md-2">
										所要深度挖掘的链接
									</label>
									</c:if>
									<c:if test="${s.index>0}"> 
									<label class="control-label col-md-2">
									</label>
									</c:if>
									<div class="col-md-4">
										<input class="form-control" placeholder="selector" type="text" value="${linkTexts.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${linkTexts.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${linkTexts.value }">
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
			
			<div class="form-group" name="baseinfo" >
				<label class="control-label col-md-2">
					基本信息循环域
				</label>
				<div class="col-md-10">
					<input class="form-control" placeholder="" type="text" value="${rule.baseinfo }">
				</div>
			</div>
			
			<c:if test="${rule.biTitle == null}">
					<div class="form-group" name="biTitle"> 
							<label class="control-label col-md-2">
								基本信息标题
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
			<c:if test="${rule.biTitle!= null}">
				<c:forEach var="biTitle" items="${rule.biTitle }" varStatus="s">
								<div class="form-group" name="biTitle"> 
									<c:if test="${s.index==0}"> 
									<label class="control-label col-md-2">
										基本信息标题
									</label>
									</c:if>
									<c:if test="${s.index>0}"> 
									<label class="control-label col-md-2">
									</label>
									</c:if>
									<div class="col-md-4">
										<input class="form-control" placeholder="selector" type="text" value="${biTitle.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${biTitle.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${biTitle.value }">
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
			
			
			<c:if test="${rule.biContent == null}">
					<div class="form-group" name="biContent"> 
							<label class="control-label col-md-2">
								基本信息内容
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
			<c:if test="${rule.biContent!= null}">
				<c:forEach var="biContent" items="${rule.biContent }" varStatus="s">
								<div class="form-group" name="biContent"> 
									<c:if test="${s.index==0}"> 
									<label class="control-label col-md-2">
										基本信息内容
									</label>
									</c:if>
									<c:if test="${s.index>0}"> 
									<label class="control-label col-md-2">
									</label>
									</c:if>
									<div class="col-md-4">
										<input class="form-control" placeholder="selector" type="text" value="${biContent.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${biContent.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${biContent.value }">
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
			
			
			
			
			<c:if test="${rule.lemmaContent == null}">
					<div class="form-group" name="lemmaContent"> 
							<label class="control-label col-md-2">
								内容
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
			<c:if test="${rule.lemmaContent!= null}">
				<c:forEach var="lemmaContent" items="${rule.lemmaContent }" varStatus="s">
								<div class="form-group" name="lemmaContent"> 
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
										<input class="form-control" placeholder="selector" type="text" value="${lemmaContent.key }">
									</div>
									<div class="col-md-4">
										<span style="display:none"><xmp>${lemmaContent.value }</xmp></span>
										<input class="form-control" placeholder="locator" type="text" value="${lemmaContent.value }">
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