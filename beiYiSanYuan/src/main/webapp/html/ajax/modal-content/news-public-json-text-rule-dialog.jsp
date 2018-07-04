<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
		$(function(){
			var additionalShowFlagLength = $("#textAdditionalShowFlag_").length;
			if(additionalShowFlagLength>0){
				$(".textAdditionalKey").hide();
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
				基本信息
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
			<div class="form-group" name="textDataType" style="display:none;">
				<label class="control-label col-md-2">
					正文页数据类型
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>1</xmp></span>
					<input class="form-control" placeholder="" type="text" value="1">
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
			

			<div class="form-group" name=textCharset>
				<label class="control-label col-md-2">
					正文字符集
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicTextRule.textCharset }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicTextRule.textCharset }">
				</div>
			</div>
    
			<div class="form-group" name="textFormData">
				<label class="control-label col-md-2">
					post提交的参数
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicTextRule.textFormData }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicTextRule.textFormData }">
				</div>
			</div>
   
			<div class="form-group" name="textReplaceStr">
				<label class="control-label col-md-2">
					需要replace的字符串
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicTextRule.textReplaceStr }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicTextRule.textReplaceStr }">
				</div>
			</div>
    
			<div class="form-group" name="textTimeKey">
				<label class="control-label col-md-2">
					正文页时间
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicTextRule.textTimeKey }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicTextRule.textTimeKey }">
				</div>
			</div>
    
			<div class="form-group" name="textContentKey">
				<label class="control-label col-md-2">
					正文页内容
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicTextRule.textContentKey }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicTextRule.textContentKey }">
				</div>
			</div>
   
			<div class="form-group" name="textImgUrlsKey">
				<label class="control-label col-md-2">
					正文页图片链接地址
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicTextRule.textImgUrlsKey }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicTextRule.textImgUrlsKey }">
				</div>
			</div>
			<div class="form-group" name="textAuthorKey">
				<label class="control-label col-md-2">
					正文页作者
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicTextRule.textAuthorKey }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicTextRule.textAuthorKey }">
				</div>
			</div>
   
			<div class="form-group" name="textSourceKey">
				<label class="control-label col-md-2">
					正文页来源
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicTextRule.textSourceKey }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicTextRule.textSourceKey }">
				</div>
			</div>
   
			<div class="form-group" name="textReplyKey">
				<label class="control-label col-md-2">
					正文页回复
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicTextRule.textReplyKey }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicTextRule.textReplyKey }">
				</div>
			</div>
			<div class="form-group" name="textClickKey">
				<label class="control-label col-md-2">
					正文页点击
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicTextRule.textClickKey }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicTextRule.textClickKey }">
				</div>
			</div>
			<c:if test="${publicTextRule.textAdditionalKey == null}"><span style="display:none;" id="textAdditionalShowFlag_"></span></c:if>
			<div class="form-group" style="text-align:center;"><a href="javascript:;" onclick="showOther(this)">添加其他</a></div>
			<c:if test="${publicTextRule.textAdditionalKey == null}">
			<div class="form-group textAdditionalKey" name="textAdditionalKey">
					<label class="control-label col-md-2">
						其他
					</label>
					<div class="col-md-3">
						<input class="form-control" placeholder="selector" type="text" value="">
					</div>
					<div class="col-md-4">
						<input class="form-control" placeholder="locator" type="text" value="">
					</div>
					<div class="col-md-3">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>
					</div>
			</div>
			</c:if>
			<c:forEach var="textAdditionalKey" items="${publicTextRule.textAdditionalKey }" varStatus="s">	
				<div class="form-group textAdditionalKey" name="textAdditionalKey">	
					<c:if test="${s.index==0}">
					<label class="control-label col-md-2">
						其他
					</label>
					</c:if>
					<c:if test="${s.index>0}">
					<label class="control-label col-md-2">
					</label>
					</c:if>
					<div class="col-md-3">
						<input class="form-control" placeholder="selector" type="text"  value="${textAdditionalKey.key }">
					</div>
					<div class="col-md-4">
						<span style="display:none"><xmp>${textAdditionalKey.value }</xmp></span>
							<input class="form-control" placeholder="locator" type="text" value="${textAdditionalKey.value }">
						</div>
					<c:if test="${s.index==0}">
						<div class="col-md-3">
							<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>
						</div>
					</c:if>
					<c:if test="${s.index>0}"> 
							<div class="col-md-3">
								<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>
							</div>
						</c:if>
				</div>
			</c:forEach>
		</fieldset>
	</form>
</div>

