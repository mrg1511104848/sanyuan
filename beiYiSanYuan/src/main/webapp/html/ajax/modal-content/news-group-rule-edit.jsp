<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
	.cRed{
		color:red;
	}
	.cGreen{
		color:green;
	}
</style>
<div role="content">
<c:if test="${groupRule.id!=null &&groupRule.state!=0}">
<div style="text-align:center;padding-left:30px;">
<div style="float:left;width:107px;">
<c:if test="${groupRule.state==2 }">
<i class="fa fa-frown-o fa-4x txt-color-red"></i>
</c:if>
<c:if test="${groupRule.state==1 }">
<i class="fa fa-smile-o fa-4x txt-color-green"></i>
</c:if>
</div>
<div style="float:left;text-align:left;font-size:16px;">
	<c:if test="${groupRule.state==2 }">
	<p>很抱歉，该页面未通过审核。</p>
	<p>审核意见：<span class="txt-color-red">${groupRule.auditOpinion}</span></p>
	<p>${groupRule.dealTime }</p>
	</c:if>
	<c:if test="${groupRule.state==1 }">
	<p>页面已通过审核，并添加到<span class="txt-color-green">${groupRule.groupName }</span>任务中。</p>
	<p>提示：<span class="txt-color-green">${groupRule.auditOpinion}</span></p>
	<p>${groupRule.dealTime }</p>	
	</c:if>
</div>
<div style="clear:both;"></div>
</c:if>
</div>
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body">

						<form class="form-horizontal" id="requirmentForm">
							
							<fieldset>
								<div class="form-group" name="id" style="display:none;">
									<label class="col-md-2 control-label"></label>
									<div class="col-md-10">
										<input class="form-control" placeholder="" type="text"  value="${groupRule.id }">
									</div>
								</div>
								<div class="form-group" name="state" style="display:none;">
									<label class="col-md-2 control-label"></label>
									<div class="col-md-10">
										<input class="form-control" placeholder="" type="text"  value="${groupRule.state }">
									</div>
								</div>
								<div class="form-group" name="userId" style="display:none;">
									<label class="col-md-2 control-label"></label>
									<div class="col-md-10">
										<input class="form-control" placeholder="" type="text"  value="${groupRule.userId }">
									</div>
								</div>
								<div class="form-group" name="userName" style="display:none;">
									<label class="col-md-2 control-label"></label>
									<div class="col-md-10">
										<input class="form-control" placeholder="" type="text"  value="${groupRule.userName }">
									</div>
								</div>
								<div class="form-group" name="weixinId" style="display:none;">
									<label class="col-md-2 control-label"></label>
									<div class="col-md-10">
										<input class="form-control" placeholder="" type="text"  value="${groupRule.weixinId }">
									</div>
								</div>
								<div class="form-group" name="ruleId" style="display:none;">
									<label class="col-md-2 control-label"></label>
									<div class="col-md-10">
										<input class="form-control" placeholder="" type="text"  value="${groupRule.ruleId }">
									</div>
								</div>
								<div class="form-group" name="insertTime" style="display:none;">
									<label class="col-md-2 control-label"></label>
									<div class="col-md-10">
										<input class="form-control" placeholder="" type="text"  value="${groupRule.insertTime}">
									</div>
								</div>
								
								<div class="form-group" name="groupId">
									<label class="col-md-2 control-label">所属采集任务</label>
									<div class="col-md-10">
										<select id="txt_groupId" class="form-control" name="txt_groupId">
											<option value=""> 请选择</option>
											<c:forEach items="${newsGroups}" var="ng">
											<option value="${ng.id }"> ${ng.name } </option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="form-group" name="section">
									<label class="col-md-2 control-label">页面名称</label>
									<div class="col-md-10">
										<input class="form-control" name="txt_section" id="txt_section" placeholder="" type="text"  value="${groupRule.section }">
									</div>
								</div>
								<div class="form-group" name="sectionUrl">
									<label class="col-md-2 control-label">页面URL</label>
									<div class="col-md-10">
										<input class="form-control" name="txt_sectionUrl" id="txt_sectionUrl" placeholder="" type="text"  value="${groupRule.sectionUrl }">
									</div>
								</div>
								<div class="form-group" name="collectionContent">
									<label class="col-md-2 control-label">采集内容</label>
									<div class="col-md-10">
										<textarea class="form-control" placeholder="Textarea" rows="4"> ${groupRule.collectionContent }</textarea>
									</div>
								</div>
								<c:if test="${currentUser.isAdmin!=null&&currentUser.isAdmin==1}">
								<div class="form-group" name="auditOpinion">
									<label class="col-md-2 control-label">审核意见</label>
									<div class="col-md-10">
										<textarea class="form-control" placeholder="Textarea" rows="4"> ${groupRule.auditOpinion }</textarea>
									</div>
								</div>
								</c:if>
								<!-- 
								<div class="form-group" name="hopeTime">
									<label class="col-md-2 control-label">期望采集周期</label>
									<div class="col-md-10">
										<input class="form-control" placeholder="5天/10天..." type="text" list="list" value="${groupRule.hopeTime  }">
										<datalist id="list">
											<option value="一天">一天</option>
											<option value="一周">一周</option>
											<option value="三周">三周</option>
										</datalist>
										<p class="note"></p>
									</div>
									
								</div>
								 -->
								<!-- 
								<div class="form-group" name="dataSource">
									 
									<label class="col-md-2 control-label">数据来源</label>
									<div class="col-md-10">
										<input class="form-control" placeholder="新闻..." type="text" list="dataSourcelist" value="${groupRule.dataSource }">
										<datalist id="dataSourcelist">
											<option value="博客">博客</option>
											<option value="论坛">论坛</option>
											<option value="平煤">平煤</option>
										</datalist>
										<p class="note"></p>
									</div>
								</div>
								
								<div class="form-group" name="dataIndustry">
									 
									<label class="col-md-2 control-label">数据行业</label>
									<div class="col-md-10">
										<input class="form-control" placeholder="政府政务..." type="text" list="dataIndustrylist" value="${groupRule.dataIndustry  }">
										<datalist id="dataIndustrylist">
											<option value="政府政务">政府政务</option>
											<option value="媒体媒介">媒体媒介</option>
											<option value="电子商务">电子商务</option>
										</datalist>
										<p class="note"></p>
									</div>
								</div>
								-->
							
							</fieldset>
							
							<c:if test="${groupRule.id==null||isEdit!=null}">
								<footer style="text-align:right;">
									<c:if test="${groupRule.id!=null&&currentUser.isAdmin!=null&&currentUser.isAdmin==1}">
										<c:if test="${ groupRule.state==0}">
										<button type="button" class="btn btn-primary" onclick="startAudit();">
											开始审核
										</button>
										<button type="button" class="btn btn-primary" onclick="auditBack(2);">
											审核驳回
										</button> 
										</c:if>
									</c:if>
									
									<c:if test="${(currentUser.isAdmin==null||currentUser.isAdmin==0)&&(groupRule.state==0||groupRule.state==2||groupRule.state==null)}">
									
									<button type="submit" class="btn btn-primary" >
										提交
									</button>
									</c:if>
									<button type="button" class="btn btn-default" onclick="closeRequirementDialog()">
										取消
									</button>
								</footer>
							</c:if>
						</form>

					</div>
					<!-- end widget content -->

</div>
<!-- JQUERY VALIDATE -->
<script src="/resources/js/plugin/jquery-validate/jquery.validate.min.js"></script>
 <script>
	 var lookOnly = '${lookOnly}';
	 if(lookOnly=="true"){
		 $("input,textarea,select").not(".tools-bar input,.tools-bar textarea,.tools-bar select,#user_name").attr("readOnly",true);
	 }
	 $(function(){
		var groupId = '${groupRule.groupId }' ;
		var id = $("div[name=id] input").val();
		if(!id){
			groupId = $("#ul_group li.active a").attr("site_id");
		}
		$("#groupId").val(groupId);
		
		
		
		$("#requirmentForm").validate( {
			onsubmit:true,// 是否在提交是验证 
			// Rules for form validation
			rules : {
				txt_groupId:{
					required : true
				},
				txt_section : {
					required : true
				},
				txt_sectionUrl: {
					required : true
				}
			},
			submitHandler : function(form) {
				submitRequirement();
			},
			messages : {
				txt_groupId : {
					required : '请选择采集任务'
				},
				txt_section : {
					required : '请输入页面名称'
				},
				txt_sectionUrl: {
					required : '请输入页面URL'
				}
			},
			errorPlacement : function(error, element) {
				error.insertAfter(element);
			}
		});
	});
	
function auditBack(state){
	//aaaaaaa
	art.dialog.confirm('你确定要驳回这个任务吗？', function () {
		var formData = buildFormData('');
		formData['state'] = state;
		formData['groupId'] = $("#txt_groupId").val();
		formData['groupName'] = $("#groupId option:selected").text();
		formData['collectionContent'] = $("div[name='collectionContent'] textarea").val();
		formData['auditOpinion'] = $("div[name='auditOpinion'] textarea").val();
		 $.ajax({
				url:'/newsGroupRule/auditBack',
				type:'POST',
				data:formData,
				dataType:'json',
				success:function(d){
					if(d.result){
						var html = '驳回成功！<br/>'+
						  			'详细审核状态和结果可在采集任务的审核情况中查看。';
						MessageBoxShow(html,true);
						newsGroupRuledialog.close();
						console.log(news_group_rule_requirement_list_table);
						news_group_rule_requirement_list_table.fnDraw();
						var user_id = $("#click_user_id").attr("user_id");
						$(".userBox").each(function(){
							var a = $(this).find("div:first").attr("user_id");
							console.log(a+"::"+user_id);
							if($(this).find("div:first").attr("user_id")==user_id){
								var requirementSurplus = $(this).find(".requirementSurplus").text();
								var rebutCount = $(this).find(".rebutCount").text();
								if(parseInt(requirementSurplus)-1>=0) $(this).find(".requirementSurplus").text(parseInt(requirementSurplus)-1);
								$(this).find(".rebutCount").text(parseInt(rebutCount)+1);
							}
						})
					}else{
						MessageBoxShow("提交失败！");
					}
				}
		});
		}, function () {
	});
	changeArtdialogButtonCss();
 }
 
 function submitRequirement(){
 	$("#requirmentForm [type=submit]").attr("disabled",true);
	var formData = buildFormData('#group-rule-boxs');
	formData['state'] = 0;
	formData['groupId'] = $("#txt_groupId").val();
	formData['groupName'] = $("#txt_groupId option:selected").text();
	formData['collectionContent'] = $("div[name='collectionContent'] textarea").val();
	formData['auditOpinion'] = $("div[name='auditOpinion'] textarea").val();
	$.ajax({
		url:'/newsGroupRule/addNewsGroupRuleRequirement',
		type:'POST',
		data:formData,
		dataType:'json',
		success:function(d){
			if(d.resultCode==1){
				news_group_rule_requirement_list_table.fnDraw();
				var html = '您的采集页面已成功提交，管理员审核后会将结果及时反馈给您！<br/>'+
	  			'详细审核状态和结果可在采集任务的审核情况中查看。';
				MessageBoxShow(html,true);
				groupRuleRequirementDialog.close();
			}else if(d.resultCode==-1){
				MessageBoxShow("提交失败！服务器异常");
			}else if(d.resultCode==2){
				MessageBoxShow("提交失败！页面数量超出限制!");
			}
		}
	});
 }
 </script>
