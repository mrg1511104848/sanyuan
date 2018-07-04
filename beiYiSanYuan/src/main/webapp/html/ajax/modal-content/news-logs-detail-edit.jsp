<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style type="text/css">
</style>
<div class="modal-body" style="height:570px;overflow-y: scroll;" id="news-edit-box">
	<div class="row">
		<div class="col-md-12">
			<form id="frmArticle"  class="smart-form">
			<input type="hidden"  name="id" value="${newsLogsDetail.id }"
								/>
								
				<div class="pt-wrapper">
					<div class="pt-page pt-page-1 ">
							<section class="">
								<label class="label">
									主站：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsDetail.site }"
									/>
							</section>
							<section class="">
								<label class="label">
									主站URL：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsDetail.siteUrl }"
									/>
							</section>
							<section class="">
								<label class="label">
									版块：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsDetail.section }"
									/>
							</section>
							<section class="">
								<label class="label">
									版块URL：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsDetail.sectionUrl }"
									/>
							</section>
							<section class="">
								<label class="label">
									策略：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsDetail.strategy }"
									/>
							</section>
							<section class="">
								<label class="label">
									抓取时间：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsDetail.time }"
									/>
							</section>
							<section class="">
								<label class="label">
									当前请求的页码：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsDetail.pageNo }"
									/>
							</section>	
							<section class="">
								<label class="label">
									当前所在的列表页URL：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsDetail.listPageUrl }"
									/>
							</section>
	
							<section class="">
								<label class="label">
									页面类型：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsDetail.pageType }"
									/>
							</section>
							<section class="">
								<label class="label">
									当前请求的正文页URL：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsDetail.pageUrl }"
									/>
							</section>
							<section class="">
								<label class="label">
									问题描述编号：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsDetail.abnormityDescriptionNo }"
									/>
							</section>
								<section class="">
								<label class="label">
									问题描述：
								</label>
								<input type="text" class="form-control" name="title" value="${newsLogsDetail.abnormityDescription }"
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
		    $("#news-edit-box :input").attr("disabled",true);
	})
	
</script>
 
