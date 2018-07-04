<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title  txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 应用管理
			<span>> 分发策略</span>
		</h1>
	</div>
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8" style="text-align:right;">
	</div>
</div>
<section id="widget-grid">
<div class="row">
	<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	<div class="jarviswidget jarviswidget-color-darken" id="wid-id-1"
		data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
		<header>
		<span class="widget-icon"> <i class="fa fa-table"></i> </span>
		<h2>
			分发策略列表
		</h2>
		</header>
		<!-- widget div-->
		<div>
			<div class="jarviswidget-editbox">
			</div>
			<div class="widget-body no-padding">
				<table id="tbAppTable"
					class="table table-striped table-bordered table-hover" width="100%">
				</table>
			</div>
		</div>
	</div>
	</article>
</div>
</section>
<div id="remoteModal" style="display: none;"></div>
<div id="divDialog"></div>
<script type="text/javascript" src="/resources/js/app-common.js"></script>
<script type="text/javascript" src="/resources/js/distribution_strategies.js"></script>