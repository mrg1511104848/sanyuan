<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style type="text/css">
</style>
<div class="modal-body">
	<div class="row">
		<div class="col-md-12">
			<form id="frmArticle"  class="smart-form">
			<input type="hidden"  name="id" value="${question.id }"
								/>
			<div class="pt-wrapper">
			<div class="pt-page pt-page-1 ">
						<section class="">
							<label class="label">
								标题：
							</label>
							<input type="text" class="form-control" name="title" value="${question.title }"
								/>
						</section>	
						<section class="">
							<label class="label">
								URL：
							</label>
							<input type="text" class="form-control" name="url" value="${question.url }"
								/>
						</section>
						<section class="">
							<label class="label">
								提问时间：
							</label>
							<label class="input">
							<i class="icon-append fa fa-calendar"></i>
							<input type="text" class="form-control dtp1" name="askTime" value="${question.askTime }" placeholder="Request activation on" 
								/>
							</label>
						</section>
						<section class="">
						<label class="label">
							主站：
						</label>
						<input type="text" class="form-control" name=siteName value="${question.siteName }"
							/>
						</section>
						<section class="">
						<label class="label">
							主站URL：
						</label>
						<input type="text" class="form-control" name="siteUrl" value="${question.siteUrl }"
							id="siteUrl" />
						</section>
    				<section>
						<label class="label">
							提问人：
						</label>
						<input type="text" class="form-control" name="askPeople" value="${question.askPeople }"
						/>
					</section>
					
					<section>
						<label class="label">
							入库时间：
						</label>
						<label class="input"> <i class="icon-append fa fa-calendar"></i>
						<input type="text" class="dtp1" name="insertTime" value="${question.insertTime }" 
						/>
						</label>
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
 
