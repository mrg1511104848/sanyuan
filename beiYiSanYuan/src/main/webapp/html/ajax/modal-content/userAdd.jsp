<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal-header">
	<h4 class="modal-title" id="myModalLabel">
		用户编辑
	</h4>
</div>
<div class="modal-body">
	<div class="row">
		<div class="col-md-12">
			<form id="frmUser" name="frmUser" class="smart-form">
				<input type="hidden" name="newsPageCount" value="${user.newsPageCount }"/>
				<input type="hidden" name="epaperPageCount" value="${user.epaperPageCount }"/>
				<input type="hidden" class="form-control" value="${user.collectPageCount }" name="collectPageCount" />
				<section>
					<label class="label">
						用户名：
					</label>
					<label class="input">
						<input type="text" class="form-control" value="${user.userName }" name="userName" id="txt_userName" />
					</label>
				</section>
				
				<section>
					<label class="label">
						微信号：
					</label>
					<label class="input">
						<input type="text" class="form-control" value="${user.weixinId }" name="weixinId"  />
					</label>
					<input type="hidden" value="${user.id }" name="id" id="txt_id" />
				</section>
				
				<section>
					<label class="label">
						用户密码：
					</label>
					<input type="password" class="form-control" value="${user.passWord }" name="passWord"
						id="txt_passWord" />
				</section>
				
				<section>
					<label class="label">
						是否是管理员：
					</label>
					<select class="form-control" name="isAdmin" value="${user.isAdmin }">
						<option value="0">否</option>
						<option value="1">是</option>
					</select>
				</section>
				<section>
					<label class="label">
						是否启用：
					</label>
					<select class="form-control" name="enabled" value="${user.enabled }">
						<option value="0">否</option>
						<option value="1">是</option>
					</select>
				</section>
				<section>
					<label class="label">
						采集页面上限：
					</label>
					<input type="text" class="form-control" value="${user.collectPageLimit }" name="collectPageLimit"
						 />
				</section>
				<section>
					<label class="label">
						手机号：
					</label>
					<label class="input">
						<input type="text" class="form-control" value="${user.phoneNum }" name="phoneNum"  />
					</label>
				</section>
				<section>
					<label class="label">
						邮箱：
					</label>
					<label class="input">
						<input type="text" class="form-control" value="${user.email }" name="email"  />
					</label>
				</section>
				<!-- 
				<section>
					<label class="label">
						采集数量上限：
					</label>
					<input type="text" class="form-control" value="${user.collectCountLimit }" name="collectCountLimit"
						 />
				</section>
				
				<section>
					<label class="label">
						已经添加了的数量：
					</label>
					<input type="text" class="form-control" value="${user.collectPageCount }" name="collectPageCount"
						 />
				</section>
				 -->
				
			</form>
		</div>
	</div>
</div>
<script src="resources/js/plugin/jquery-validate/jquery.validate.min.js"></script>
<script type="text/javascript">
	$(function(){
		if($("select[name='isAdmin']").attr("value")=="")
			$("select[name='isAdmin']").attr("value","0")
		$("select[name='isAdmin']").val($("select[name='isAdmin']").attr("value"));

		if($("select[name='enabled']").attr("value")=="")
			$("select[name='enabled']").attr("value","0")
		$("select[name='enabled']").val($("select[name='enabled']").attr("value"));
	})
</script>
