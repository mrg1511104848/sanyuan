<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style type="text/css">
</style>
<div class="modal-body" style="width:500px;">
	<div class="row">
		<div class="col-md-12">
			<form id="frmSite"  class="smart-form">
			<input type="hidden"  name="id" value="${bDZhiDaoSite.id }"
								/>
			<div class="pt-wrapper">
			<div class="pt-page pt-page-1 ">
						<section class="">
							<label class="label">
								标题：
							</label>
							<input type="text" class="form-control" name="siteName" value="${bDZhiDaoSite.siteName }"
								/>
						</section>	
						<section class="">
							<label class="label">
								URL：
							</label>
							<input type="text" class="form-control" name="siteUrl" value="${bDZhiDaoSite.siteUrl }"
								/>
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
		    
	})
	
</script>