<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style type="text/css">
</style>
<div class="modal-body" style="width:500px;">
	<div class="row">
		<div class="col-md-12">
			<form id="frmSite"  class="smart-form">
			<input type="hidden"  name="id" value="${newsSite.id }"
								/>
			<div class="pt-wrapper">
			<div class="pt-page pt-page-1 ">
						<section class="">
							<label class="label">
								名称：
							</label>
							<input type="text" class="form-control" name="name" value="${newsSite.name }"/>
						</section>	
						<section class="">
							<label class="label">
								URL：
							</label>
							<input type="text" class="form-control" name="url" value="${newsSite.url }"/>
						</section>
				</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	pageSetUp();
	$(function(){
			$(".dtp1").datepicker({
					showSecond: true,
		        	numberOfMonths:1,  
				  showButtonPanel:false,  
				  dateFormat: 'yy-mm-dd',  
				  minDate: new Date()  
		    });
		loadingHide();
		dialogCenterScreen(editSiteDialog);
	});
	
	
</script>
 
