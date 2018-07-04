<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style>
	.dataTables_filter{display:none;}
	.ColVis{display:none;}
</style>

<!-- widget grid -->
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" style="margin:0px;" data-widget-editbutton="false" data-widget-colorbutton="false">

				<!-- widget div-->
				<div style="padding-top:10px;">
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body">

						<table id="tbAppTable"
												class="table table-striped table-bordered table-hover smart-form"
												width="100%">
						</table>
						
					</div>
					<input type="hidden" name="groupId" id="groupId" value="${groupId }"/>
					<input type="hidden" name="groupName" id="groupName" value="${groupName }"/>
					<div id="dialog_edit" title="编辑文章" style=""></div>
					<div id="dialog_delete"  title="删除文章" style="text-align:center;"></div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
			<!-- end widget -->


		</article>
		<!-- WIDGET END -->

	</div>

	<!-- end row -->

	<!-- end row -->

</section>
<!-- end widget grid -->
<script type="text/javascript" src="/resources/js/app-common.js"></script>
<script type="text/javascript" src="/resources/js/distribution_strategies.js"></script>
<script type="text/javascript">
	$(function(){	
		$('#distributionStrategies [role="content"]').css("border","none");
		$("#tbAppTable_wrapper .dt-toolbar").css("padding","0px 0px 5px");
	})
</script>