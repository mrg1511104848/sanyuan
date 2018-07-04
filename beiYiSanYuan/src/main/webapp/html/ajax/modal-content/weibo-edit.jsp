<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style type="text/css">
</style>
<div class="modal-body" style="height:570px;overflow-y: scroll;" id="news-edit-box">
	<div class="row">
		<div class="col-md-12">
			<form id="frmArticle"  class="smart-form">
			<input type="hidden"  name="id" value="${wbArticle.id }"
								/>
			<div class="pt-wrapper">
			<div class="pt-page pt-page-1 ">
			
						<section class="">
							<label class="label">
								话题：
							</label>
							<input type="text" class="form-control" name="title" value="${wbArticle.topic }"
								/>
						</section>	
						<section id="stClient">
							<label class="label">
								内容：
							</label>
							<label class="textarea">
							<textarea name="content" class="form-control" rows="3">${wbArticle.content }</textarea>
							</label>
						</section>
						<section class="">
							<label class="label">
								URL：
							</label>
							<input type="text" class="form-control" name="url" value="${wbArticle.url }"
								/>
						</section>
						<section class="">
							<label class="label">
								发布时间：
							</label>
							<label class="input">
							<i class="icon-append fa fa-calendar"></i>
							<input type="text" class="form-control dtp1" name="time" value="${wbArticle.time }" placeholder="Request activation on" 
								/>
							</label>
						</section>
						
					<section>

					<label class="label">
						图片链接地址：
					</label>
					<input type="text" class="form-control" name="imgUrls" value="${wbArticle.imgUrls }"
						/>
					</section>
    				<section>
						<label class="label">
							作者：
						</label>
						<input type="text" class="form-control" name="author" value="${wbArticle.weiboUserName }"
						/>
					</section>
					<section>
						<label class="label">
							来源：
						</label>
						<input type="text" class="form-control" name="source" value="${wbArticle.source }"
						/>
					</section>
					<section>
						<label class="label">
							入库时间：
						</label>
						<label class="input"> <i class="icon-append fa fa-calendar"></i>
						<input type="text" class="dtp1 form-control" name="insertTime" value="${wbArticle.timeStamp }" 
						/>
						</label>
					</section>
					<section>
						<label class="label">
							评论数：
						</label>
						<label class="input"> 
						<input type="text" class="dtp1 form-control" name="insertTime" value="${wbArticle.commentCount }" 
						/>
						</label>
					</section>
					<section>
						<label class="label">
							粉丝数：
						</label>
						<label class="input"> 
						<input type="text" class="form-control" name="insertTime" value="${wbArticle.forwardCount }" 
						/>
						</label>
					</section>
					<section>
						<label class="label">
							图片：
						</label>
						<label class="input"> 
						<input type="text" class="form-control" name="insertTime" value="${wbArticle.imgUrls }" 
						/>
						</label>
					</section>
					<section>
						<label class="label">
							入库时间：
						</label>
						<label class="input"> <i class="icon-append fa fa-calendar"></i>
						<input type="text" class="dtp1 form-control" name="insertTime" value="${wbArticle.timeStamp }" 
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
 
