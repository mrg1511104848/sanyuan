<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style type="text/css">
</style>
<div class="modal-body" style="height:570px;overflow-y: scroll;" id="news-edit-box">
	<div class="row">
		<div class="col-md-12">
			<form id="frmArticle"  class="smart-form">
			<input type="hidden"  name="id" value="${newsArticle.id }"
								/>
			<div class="pt-wrapper">
			<div class="pt-page pt-page-1 ">
						<section class="">
							<label class="label">
								标题：
							</label>
							<input type="text" class="form-control" name="title" value="${newsArticle.title }"
								/>
						</section>	
						<section id="stClient">
							<label class="label">
								内容：
							</label>
							<label class="textarea">
							<textarea name="content" class="form-control" rows="3">${newsArticle.content }</textarea>
							</label>
						</section>
						<section class="">
							<label class="label">
								URL：
							</label>
							<input type="text" class="form-control" name="url" value="${newsArticle.url }"
								/>
						</section>
						<section class="">
							<label class="label">
								发布时间：
							</label>
							<label class="input">
							<i class="icon-append fa fa-calendar"></i>
							<input type="text" class="form-control dtp1" name="time" value="${newsArticle.time }" placeholder="Request activation on" 
								/>
							</label>
						</section>
						<section class="">
						<label class="label">
							主站：
						</label>
						<input type="text" class="form-control" name="site" value="${newsArticle.site }"
							/>
						<input type="hidden" value="" id="txtId" name="id" />
						</section>
						<section class="">
						<label class="label">
							主站URL：
						</label>
						<input type="text" class="form-control" name="siteUrl" value="${newsArticle.siteUrl }"
							id="siteUrl" />
						</section>
						<section id="stClient" class="">
						<label class="label">
							版块：
						</label>
						<input type="text" class="form-control" name="section" value="${newsArticle.section }"
							id="siteUrl" />
						</section>
						
						<section id="stClient" class="">
						<label class="label">
							版块URL：
						</label>
						<input type="text" class="form-control" name="sectionUrl" value="${newsArticle.sectionUrl }"
							id="siteUrl" />
						</section>
					<section>
					<label class="label">
						图片链接地址：
					</label>
					<input type="text" class="form-control" name="imgUrls" value="${newsArticle.imgUrls }"
						/>
					</section>
    				<section>
						<label class="label">
							作者：
						</label>
						<input type="text" class="form-control" name="author" value="${newsArticle.author }"
						/>
					</section>
					<section>
						<label class="label">
							来源：
						</label>
						<input type="text" class="form-control" name="source" value="${newsArticle.source }"
						/>
					</section>
					<section>
						<label class="label">
							回复：
						</label>
						<input type="text" class="form-control" name="reply" value="${newsArticle.reply }"
						/>
					</section>
					
					<section>
						<label class="label">
							点击：
						</label>
						<input type="text" class="form-control" name="click" value="${newsArticle.click }"
						/>
					</section>
					<section id="stClient">
							<label class="label">
								额外字段（普通）：
							</label>
							<label class="textarea">
							<textarea name="additionalAttribute" class="form-control" rows="3">${newsArticle.additionalAttribute }</textarea>
							</label>
					</section>
					<section id="stClient">
							<label class="label">
								额外字段（复杂）：
							</label>
							<label class="textarea">
							<textarea name="additionalAttribute" class="form-control" rows="3">${newsArticle.extraAttribute }</textarea>
							</label>
					</section>
					<section id="stClient">
							<label class="label">
								所属分类：
							</label>
							<label class="textarea">
							<textarea name="markingTagList" class="form-control" rows="3">${newsArticle.markingTagList }</textarea>
							</label>
					</section>
					<section>
						<label class="label">
							入库时间：
						</label>
						<label class="input"> <i class="icon-append fa fa-calendar"></i>
						<input type="text" class="dtp1 form-control" name="insertTime" value="${newsArticle.insertTime }" 
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
		    $("#news-edit-box :input").attr("disabled",true);
	})
	
</script>
 
