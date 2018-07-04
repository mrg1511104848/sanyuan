<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
</style>
<div style="max-height:500px;overflow-y:scroll;">
	<div class="modal-header">
		<h4 class="modal-title" id="myModalLabel">
			应用编辑
		</h4>
	</div>
	<div class="modal-body">
		<div class="row">
			<div class="col-md-12">
				<form id="frmApp" name="frmApp" class="smart-form">
					<input type="hidden" name="id" id="txt_id"
						value="${app.id }" />
					<input type="hidden" name="userId" id="txt_userId"
						value="${app.userId }" />
					<input type="hidden" id="dbType"
						value="${app.dbType }" />
					<section>
						<label class="label">
							名称
						</label>
						<label class="input">
							<input class="form-control" placeholder="" type="text" name="name"
								id="txt_name" value="${app.name }">
						</label>
					</section>
					<section>
						<label class="label">
							产品
						</label>
						<select name="productCategory" value="${app.productCategory }">
							<c:forEach var="p" items="${products}" >
								<option value="${p.value }">
								${p.key }
								</option>
							</c:forEach>
						</select>
					</section>
					<section class=" db">
						<label class="label">
							数据库类型
						</label>
						<div class="row">
							<div class="col col-2">
								<label class="radio">
									<input type="radio" name="dbType" class="dbType" dbType="MySQL" value="MySQL">
									<i></i>MySQL</label>
							</div>
							<div class="col col-2">
								<label class="radio">
									<input type="radio" name="dbType" class="dbType" dbType="Oracle"  value="Oracle">
									<i></i>Oracle</label>
							</div>
							<div class="col col-2">
							<label class="radio">
									<input type="radio" name="dbType" class="dbType" dbType="DB2" value="DB2">
									<i></i>DB2</label>
							</div>
							<div class="col col-2">
							<label class="radio">
									<input type="radio" name="dbType" class="dbType" dbType="SQLServer" value="SQLServer">
									<i></i>SQLServer</label>
							</div>
						</div>
					</section>
					<section class=" db to_empty">
						<label class="label">
							数据库实例（名称）
						</label>
						<label class="input">
							<input class="form-control" placeholder="" type="text" name="dbInstance"
								id="txt_dbInstance" value="${app.dbInstance }">
						</label>
					</section>
					<section class="apiAddress">
						<label class="label">
							接口地址
						</label>
						<label class="input">
							<input class="form-control" placeholder="" type="text"
								name="apiAddress" id="txt_apiAddress" value="${app.apiAddress }">
						</label>
					</section>
					<section  class=" db to_empty">
						<label class="label">
							服务器IP
						</label>
						<label class="input">
							<input class="form-control" placeholder="" type="text"
								name="serverIp" id="txt_serverIp" value="${app.serverIp }">
						</label>
					</section>
					<section  class="to_empty" >
						<label class="label">
							用户名
						</label>
						<label class="input">
							<input class="form-control" placeholder="" type="text"
								name="username" id="txt_username" value="${app.username }">
						</label>
					</section>
	
					<section class="to_empty">
						<label class="label">
							密码
						</label>
						<label class="input">
							<input class="form-control" placeholder="" type="text"
								name="password" id="txt_password" value="${app.password }">
						</label>
					</section>
	
					<section  class=" db to_empty">
						<label class="label">
							端口
						</label>
						<label class="input">
							<input class="form-control" placeholder="" type="text"
								name="serverPort" id="txt_serverPort" value="${app.serverPort }">
						</label>
					</section>
					<section  class=" db to_empty">
						<label class="label">
							连接参数
						</label>
						<label class="input">
							<input class="form-control" placeholder="" type="text"
								name="dbParams" id="txt_dbParams" value="${app.dbParams }">
						</label>
					</section>
					<section  class=" oracle db to_empty">
						<label class="label">
							连接为
						</label>
						<select name="connectTo" value="${app.connectTo }">
							<option value="normal">normal</option>
							<option value="sysdba">sysdba</option>
							<option value="sysoper">sysoper</option>
						</select>
					</section>
					
					<section class="hide_flag">
						<label class="label hide_flag">
							license
						</label>
						<label class="input hide_flag">
							<input class="form-control" placeholder="" type="text"
								name="license" id="txt_license" value="${app.license }">
						</label>
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