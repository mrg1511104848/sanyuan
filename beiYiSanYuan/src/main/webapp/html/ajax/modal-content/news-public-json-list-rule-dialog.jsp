<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
		$(function(){
			var additionalShowFlagLength = $("#listAdditionalShowFlag_").length;
			if(additionalShowFlagLength>0){
				$(".listAdditionalKey").hide();
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
		});
		function changeFetchStrategy(fetch_strategy){
			$("div[name='fetchStrategy'] input").val(fetch_strategy);
			$("div[name='fetchStrategy'] input").attr("value",fetch_strategy);
		};
</script>
<div  title="Dialog Simple Title" class="col-sm-12" id="" style="min-width:600px;height:570px;overflow-y: scroll;">
	<form class="form-horizontal col col-6" id="mainFrm">
	<fieldset>
			<legend>
				<span style="float:left;">基本信息</span> 
				<!-- 
				<span style="float:right;">
					<span>抓取策略:</span>
					<label class="radio" style="display:inline-block;padding-top:0;">
						<input type="radio" name="radio-fetch-strategy" value="2" onchange="changeFetchStrategy(2)">
					<i></i>按置顶
					</label>
					<label class="radio" style="display:inline-block;padding-top:0;">
						<input type="radio" name="radio-fetch-strategy" value="1" onchange="changeFetchStrategy(1)">
					<i></i>按时间倒序
					</label>
					
				</span>
				 -->
				<div style="clear:both;"></div>
			</legend>
			<div class="form-group" name="id" style="display:none;">
				<label class="control-label col-md-2">
					id
				</label>
				<div class="col-md-5">
					<input class="form-control" placeholder="" type="text" value="${publicListRule.id }">
				</div>
			</div>
			<div class="form-group" name="listDataType" style="display:none;">
				<label class="control-label col-md-2">
				</label>
				<div class="col-md-5">
					<input class="form-control" placeholder="" type="text" value="1">
				</div>
			</div>
			<div class="form-group" name="name">
				<label class="control-label col-md-2">
					自定义名称
				</label>
				<div class="col-md-5">
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
			<div class="form-group" name=listCharset>
				<label class="control-label col-md-2">
					列表字符集
				</label>
				<div class="col-md-5">
					<input class="form-control" placeholder="" type="text" value="${publicListRule.listCharset }">
				</div>
			</div>
			<div class="form-group" name="page">
				<label class="control-label col-md-2">
					抓取页数
				</label>
				<div class="col-md-5">
					<input class="form-control" placeholder="" type="text" value="${publicListRule.page }">
				</div>
			</div>
			<div class="form-group" name="listFormData">
				<label class="control-label col-md-2">
					post提交的参数
				</label>
				<div class="col-md-5">
					<input class="form-control" placeholder="" type="text" value="${publicListRule.listFormData }">
				</div>
			</div>
			<div class="form-group" name="listReplaceStr">
				<label class="control-label col-md-2">
					需要replace的字符串
				</label>
				<div class="col-md-5">
					<input class="form-control" placeholder="" type="text" value="${publicListRule.listReplaceStr }">
				</div>
			</div>
			<div class="form-group" name="listPageKey">
				<label class="control-label col-md-2">
					控制页码的参数
				</label>
				<div class="col-md-5">
					<input class="form-control" placeholder="" type="text" value="${publicListRule.listPageKey }">
				</div>
			</div>
			<div class="form-group" name="listListKey">
				<label class="control-label col-md-2">
					列表页的key
				</label>
				<div class="col-md-5">
					<input class="form-control" placeholder="" type="text" value="${publicListRule.listListKey }">
				</div>
			</div>
			<div class="form-group" name="listCountLimit">
				<label class="control-label col-md-2">
					列表取前几条
				</label>
				<div class="col-md-5">
					<input class="form-control" placeholder="" type="text" value="${publicListRule.listCountLimit }">
				</div>
			</div>
			<div class="form-group" name="listTitleKey">
				<label class="control-label col-md-2">
					列表页标题
				</label>
				<div class="col-md-5">
					<input class="form-control" placeholder="" type="text" value="${publicListRule.listTitleKey }">
				</div>
			</div>
			<div class="form-group" name="listUrlKey">
				<label class="control-label col-md-2">
					列表页URL
				</label>
				<div class="col-md-5">
					<input class="form-control" placeholder="" type="text" value="${publicListRule.listUrlKey }">
				</div>
			</div>
			<div class="form-group" name="listTimeKey">
				<label class="control-label col-md-2">
					列表页时间
				</label>
				<div class="col-md-5">
					<input class="form-control" placeholder="" type="text" value="${publicListRule.listTimeKey }">
				</div>
			</div>
			<div class="form-group" name="listStopFlag">
				<label class="control-label col-md-2">
					列表页分页请求 停止标志
				</label>
				<div class="col-md-5">
					<input class="form-control" placeholder="" type="text" value="${publicListRule.listStopFlag }">
				</div>
			</div>
			<c:if test="${publicListRule.listAdditionalKey == null}"><span style="display:none;" id="listAdditionalShowFlag_"></span></c:if>
			<div class="form-group" style="text-align:center;"><a href="javascript:;" onclick="showOther(this)">添加其他</a></div>
			<c:if test="${publicListRule.listAdditionalKey == null}">
			<div class="form-group listAdditionalKey" name="listAdditionalKey">
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
			<c:forEach var="listAdditionalKey" items="${publicListRule.listAdditionalKey }" varStatus="s">	
				<div class="form-group listAdditionalKey" name="listAdditionalKey">	
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
						<input class="form-control" placeholder="selector" type="text"  value="${listAdditionalKey.key }">
					</div>
					<div class="col-md-4">
							<input class="form-control" placeholder="locator" type="text" value="${listAdditionalKey.value }">
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

