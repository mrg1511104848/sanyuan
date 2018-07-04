<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style type="text/css">
</style>
<div class="modal-body" style="height:570px;overflow-y: scroll;" id="edit-box">
	<div class="row">
		<div class="col-md-12">
			<form id="frmArticle"  class="smart-form">
			<input type="hidden"  name="id" value="${epaperArticle.id }"
								/>
			<div class="pt-wrapper">
			<div class="pt-page pt-page-1 ">
						<section class="">
							<label class="label">
								标题：
							</label>
							<input type="text" class="form-control" name="title" value="${epaperArticle.title }"
								/>
						</section>	
						<section id="stClient">
							<label class="label">
								内容：
							</label>
							<label class="textarea">
							<textarea name="content" class="form-control" rows="3">${epaperArticle.content }</textarea>
							</label>
						</section>
						<section class="">
							<label class="label">
								URL：
							</label>
							<input type="text" class="form-control" name="url" value="${epaperArticle.url }"
								/>
						</section>
						<section class="">
							<label class="label">
								发布时间：
							</label>
							<label class="input">
							<i class="icon-append fa fa-calendar"></i>
							<input type="text" class="form-control dtp1" name="time" value="${epaperArticle.time }" placeholder="Request activation on" 
								/>
							</label>
						</section>
						<section class="">
						<label class="label">
							主站：
						</label>
						<input type="text" class="form-control" name="site" value="${epaperArticle.site }"
							/>
						<input type="hidden" value="" id="txtId" name="id" />
						</section>
						<section class="">
						<label class="label">
							主站URL：
						</label>
						<input type="text" class="form-control" name="siteUrl" value="${epaperArticle.siteUrl }"
							id="siteUrl" />
						</section>
						<section id="stClient" class="">
						<label class="label">
							版块：
						</label>
						<input type="text" class="form-control" name="section" value="${epaperArticle.section }"
							id="siteUrl" />
						</section>
						
						<section id="stClient" class="">
						<label class="label">
							版块URL：
						</label>
						<input type="text" class="form-control" name="sectionUrl" value="${epaperArticle.sectionUrl }"
							id="siteUrl" />
						</section>
					<section>
					<label class="label">
						图片链接地址：
					</label>
					<input type="text" class="form-control" name="imgUrls" value="${epaperArticle.imgUrls }"
						/>
					</section>
    				<section>
						<label class="label">
							作者：
						</label>
						<input type="text" class="form-control" name="author" value="${epaperArticle.author }"
						/>
					</section>
					<section>
						<label class="label">
							来源：
						</label>
						<input type="text" class="form-control" name="source" value="${epaperArticle.source }"
						/>
					</section>
					
					<section>
						<label class="label">
							入库时间：
						</label>
						<label class="input"> <i class="icon-append fa fa-calendar"></i>
						<input type="text" class="dtp1 form-control " name="insertTime" value="${epaperArticle.insertTime }" 
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
		    $("#edit-box :input").attr("disabled",true);
	})
	
</script>
 
