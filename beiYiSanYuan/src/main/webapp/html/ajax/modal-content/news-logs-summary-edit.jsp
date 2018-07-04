<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style type="text/css">
</style>
<div class="modal-body" style="height:570px;overflow-y: scroll;" id="news-logs-summary-edit-box">
	<div class="row">
		<div class="col-md-12">
			<form id="frmArticle"  class="smart-form">
			<input type="hidden"  name="id" value="${newsLogsSummary.id }"
								/>
				<div class="pt-wrapper">
					<div class="pt-page pt-page-1 ">
							<section class="">
								<label class="label">
									主站：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.site }"
									/>
							</section>
							<section class="">
								<label class="label">
									主站URL：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.siteUrl }"
									/>
							</section>
							<section class="">
								<label class="label">
									版块：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.section }"
									/>
							</section>
							<section class="">
								<label class="label">
									版块URL：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.sectionUrl }"
									/>
							</section>
							<section class="">
								<label class="label">
									策略：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.strategy }"
									/>
							</section>
							<section class="">
								<label class="label">
									开始时间：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.startTime }"
									/>
							</section>
							<section class="">
								<label class="label">
									结束时间：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.endTime }"
									/>
							</section>	
							<section class="">
								<label class="label">
									持续时间：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.duration }"
									/>
							</section>
	
							<section class="">
								<label class="label">
									扫描总页数：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.totalPages }"
									/>
							</section>
							<section class="">
								<label class="label">
									扫描总文章数：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.totalArticles }"
									/>
							</section>
							<section class="">
								<label class="label">
									保存总文章数：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.totalSavedArticles }"
									/>
							</section>
								<section class="">
								<label class="label">
									本次保存的所有的文章的分布：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.savedArticlesDistribution }"
									/>
							</section>
							<section class="">
								<label class="label">
									导致跳出循环的URL：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.breakUrl }"
									/>
							</section>
							<section class="">
								<label class="label">
									该规则抓取结束的原因编号：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.endingReasonNo }"
									/>
							</section>
							<section class="">
								<label class="label">
									该规则抓取结束的原因：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsSummary.endingReason }"
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
		    $("#news-logs-summary-edit-box :input").attr("disabled",true);
	})
	
</script>
 
