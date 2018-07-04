<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<style>
</style>
<div style="max-height:500px;overflow-y:scroll;">
	<div class="modal-header">
		<h4 class="modal-title" id="myModalLabel">
			新增药师
		</h4>
	</div>
	<div class="modal-body">
		<div class="row">
			<div class="col-md-12">
				<form id="frmDepartment" name="frmDepartment" class="smart-form">
					<input type="hidden" name="id" id="txt_id" value="${authorityDepartment.id }" />
					<section>
						<label class="label">
							用户名
						</label>
						<label class="input">
							<input class="form-control" placeholder="" type="text"
								   name="pharmacistName" value="${authorityDepartment.pharmacistName }">
						</label>
					</section>
					<section>
						<label class="label">
							密码
						</label>
						<label class="input">
							<input class="form-control" placeholder="" type="text"
								   name="pharmPwd" value="${authorityDepartment.pharmPwd }">
						</label>
					</section>
					<section>
						<label class="label">
							类型
						</label>
						<select class="form-control" name="deptType" value="${authorityDepartment.deptType }">
							<option value="急诊">急诊</option>
							<option value="门诊">门诊</option>
							<option value="住院">住院</option>
						</select>
					</section>
					<section>
						<label class="label">科室</label>
						<select  multiple class="select2 form-control" name="sectionName">
							<option value="呼吸科" <c:if test="${fn:contains(authorityDepartment.sectionName, '呼吸科')}">selected</c:if>>呼吸科</option>
							<option value="消化科" <c:if test="${fn:contains(authorityDepartment.sectionName, '消化科')}">selected</c:if>>消化科</option>
							<option value="心内科" <c:if test="${fn:contains(authorityDepartment.sectionName, '心内科')}">selected</c:if>>心内科</option>
							<option value="脾胃科" <c:if test="${fn:contains(authorityDepartment.sectionName, '脾胃科')}">selected</c:if>>脾胃科</option>
							<option value="妇科" <c:if test="${fn:contains(authorityDepartment.sectionName, '妇科')}">selected</c:if>>妇科</option>
							<option value="产科" <c:if test="${fn:contains(authorityDepartment.sectionName, '产科')}">selected</c:if>>产科</option>
						</select>
					</section>
					<section>
						<label class="label">是否系统审核</label>
						<div class="row">
							<div class="col col-2">
								<label class="radio">
									<input type="radio" name="reviewFlag" <c:if test="${empty authorityDepartment}">checked</c:if> <c:if test="${authorityDepartment.reviewFlag == 1}">checked="checked"</c:if> class="sendType" value="1" />
									<i></i>是</label>
							</div>
							<div class="col col-2">
								<label class="radio">
									<input type="radio" name="reviewFlag" <c:if test="${authorityDepartment.reviewFlag == 0}">checked="checked"</c:if>  class="sendType" value="0" />
									<i></i>否</label>
							</div>
						</div>
					</section>

			</div>
			</form>
		</div>
	</div>
</div>
<script>
	pageSetUp();
	$(function() {	
		if($("select[name='productCategory']").attr("value")==""){
			$("select[name='productCategory']").attr("value","es")
		}
		initSelect('productCategory');
		initSelect('connectTo');
		initRadio('dbType');
		dealFrm();
		dealDB();
		$("select[name='productCategory']").change(function(){
			dealFrm();
		})
		$("[name=dbType]").change(function(){
			dealDB();
			$(".to_empty input").val("");
			$(".to_empty select").each(function(){
				$(this).val($(this).find("option:first").attr("value"))
			});
		})
	});
	
	function dealDB(){
		if($("[name='dbType']:checked").attr("dbType")!='Oracle'){
			$(".oracle").hide();
		}else{
			$(".oracle").show();
		}
	}
	function dealFrm(){
		if($("select[name='productCategory']").val()=='es'){
			$(".hide_flag").show();
		}
		if($("select[name='productCategory']").val()=='es'||$("select[name='productCategory']").val()=='hy'){
			$(".db").hide();
			$(".apiAddress").show();
		}else{
			$(".db").show();
			$(".apiAddress").hide();
		}
		if($("select[name='productCategory']").val()!='es'){
			$(".hide_flag").hide();
		}
	}
</script>