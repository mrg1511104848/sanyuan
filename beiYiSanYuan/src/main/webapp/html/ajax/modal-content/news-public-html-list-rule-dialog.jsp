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
		});
		function changeFetchStrategy(fetch_strategy){
			$("div[name='fetchStrategy'] input").val(fetch_strategy);
			$("div[name='fetchStrategy'] input").attr("value",fetch_strategy);
		};
</script>
<div  title="Dialog Simple Title" class="col-sm-12" id="" style="">
	<form class="form-horizontal col col-6" id="mainFrm">
	<fieldset>
			<legend>
				<span style="float:left;">基本信息</span> 
				<span style="float:right;">
					<!-- 
					<span>抓取策略:</span>
					<label class="radio" style="display:inline-block;padding-top:0;">
						<input type="radio" name="radio-fetch-strategy" value="2" onchange="changeFetchStrategy(2)">
					<i></i>按置顶
					</label>
					<label class="radio" style="display:inline-block;padding-top:0;">
						<input type="radio" name="radio-fetch-strategy" value="1" onchange="changeFetchStrategy(1)">
					<i></i>按时间倒序
					</label>
					 -->
				</span>
				<div style="clear:both;"></div>
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
			<div class="form-group" name="listDataType" style="display:none;">
				<label class="control-label col-md-2">
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>2</xmp></span>
					<input class="form-control" placeholder="" type="text" value="2">
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
			<div class="form-group">
				<label class="control-label col-md-2">
					抓取策略
				</label>
				<div class="col-md-5">
					<c:if test="${publicListRule.fetchStrategy==1||publicListRule.fetchStrategy==null}">
						<label class="radio" style="display:inline-block;padding-top:0;">
							<input type="radio" name="radio-fetch-strategy" checked="checked" t_value="1" onchange="changeFetchStrategy(1)">
						<a href="javascript:;" title="循环文章列表的时候，当遇到已经抓取过得文章的时候（判断标准为：URL相同），即跳出抓取循环，默认该条以下的文章都已经抓取过，不纳入返回的结果集。">策略一</a>
						</label>
						<label class="radio" style="display:inline-block;padding-top:0;">
							<input type="radio" name="radio-fetch-strategy" t_value="2" onchange="changeFetchStrategy(2)">
						<a href="javascript:;" title="循环文章列表的时候，只要遇到已经抓取过得文章的时候（判断标准为：URL相同），仅该条不纳入结果集，继续循环下面的文章，如再遇到相同文章，重复以上操作，不会因为有相同文章而跳出循环，跳出循环的唯一依据是分页结束">策略二</a>
						</label>
					</c:if>
					<c:if test="${publicListRule.fetchStrategy==2 }">
						<label class="radio" style="display:inline-block;padding-top:0;">
							<input type="radio" name="radio-fetch-strategy" t_value="1" onchange="changeFetchStrategy(1)">
						<a href="javascript:;" title="循环文章列表的时候，当遇到已经抓取过得文章的时候（判断标准为：URL相同），即跳出抓取循环，默认该条以下的文章都已经抓取过，不纳入返回的结果集。">策略一</a>
						</label>
						<label class="radio" style="display:inline-block;padding-top:0;">
							<input type="radio" name="radio-fetch-strategy" checked="checked" t_value="2" onchange="changeFetchStrategy(2)">
						<a href="javascript:;" title="循环文章列表的时候，只要遇到已经抓取过得文章的时候（判断标准为：URL相同），仅该条不纳入结果集，继续循环下面的文章，如再遇到相同文章，重复以上操作，不会因为有相同文章而跳出循环，跳出循环的唯一依据是分页结束">策略二</a>
						</label>
					</c:if>
				</div>
			</div>
			<div class="form-group" name="fetchStrategy" style="display:none;">
				<div class="col-sm-10">
					<span style="display:none"><xmp>${publicListRule.fetchStrategy }</xmp></span>
					<input  type="text" value="${publicListRule.fetchStrategy }">
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
			<div class="form-group" name="page">
				<label class="control-label col-md-2">
					抓取页数
				</label>
				<div class="col-md-5">
					<span style="display:none"><xmp>${publicListRule.page }</xmp></span>
					<input class="form-control" placeholder="" type="text" value="${publicListRule.page }">
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
			<c:if test="${publicListRule.listTimeParserMap == null}">
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
			<c:if test="${publicListRule.listTimeParserMap != null}">
			<c:forEach var="timeParserMap" items="${publicListRule.listTimeParserMap }"  varStatus="s">
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
			<c:if test="${publicListRule.listNextPageParserMap == null}">
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
			<c:if test="${publicListRule.listNextPageParserMap != null}">	
				<c:forEach var="nextPageParserMap" items="${publicListRule.listNextPageParserMap }" varStatus="s">
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

