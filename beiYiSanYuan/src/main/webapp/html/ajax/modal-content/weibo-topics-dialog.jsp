<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!-- widget grid -->
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" data-widget-editbutton="false" data-widget-colorbutton="false" style="margin:0;">

				<!-- widget div-->
				<div>
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body no-padding">

						<table id="news_articles_list"
						class="table table-striped table-bordered table-hover smart-form has-tickbox" 
						width="100%">
						<thead>
							<tr>
     								<th> 话题</th>
									<th> 内容</th>
									<th> 评论数</th>
									<th> 转发数</th>
									<th> 图片</th>
									<th> 来源</th>
							</tr>
						</thead>
						</tbody>
</table>

					</div>
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
<div id="news_logs_detail_dialog_div"  style="display:none;"></div>
<div id="edit_dialog_div" style="display:none;"></div>
<script src="/resources/js/news-common.js"></script>
<script type="text/javascript"><!--
 	//初始化加载一些参数
	pageSetUp();
	
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	var data_table ;
	
	// pagefunction	
	var pagefunction = function() {
		data_table = $("#news_articles_list").dataTable({
			"bSort":false,
			"bProcessing" : true,//加载数据时候是否显示进度条
			"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/weibo/getWeiboPagedListDialog?eq_weiboUserName=${weiboUserName}&orderBy=jobStartTime-desc",//如果从服务器端加载数据,这个属性用于指定加载的路径 
			"columns": [//数据列
	            {"sWidth" : "20%","data": function ( row, type, set ){
		            var topic = row.topic;
		            if(!topic){return "无";}
		           // var title = cut_str(row.title, 30,"...");
	            	return topic;
	            },"bSortable": false},
	            {"sWidth" : "40%","data": function ( row, type, set ){
	            	var url = row.url;
	            	if(!url){return "无";}
	            	var surl = cut_str(url, 30,"...");
	            	
	            	var content =  row.content;
	            	if(!row.content){return "无";}
	            	var scontent = cut_str(content, 30,"...");
	            	
	            	return "<a href='"+url+"' target= '_blank'><span  title='"+content+"'>"+scontent+"</span></a>";
	            },"bSortable": false},
	            
	            {"data": function( row, type, set ){
	            	var commentCount = row.commentCount;
	            	return commentCount;
	            },"bSortable": false},
	            {"data": function ( row, type, set ){
	            	var forwardCount = row.forwardCount;
	            	return forwardCount;
	            },"bSortable": false},
	            {"data": function ( row, type, set ){
	            	var imgUrls = row.imgUrls;
	            	if(imgUrls!=null){
	            		return "<a href='"+imgUrls+"' title='"+imgUrls+"' target='blank_'>有</a>";
	            	}
	            	return imgUrls;
	            },"bSortable": false},
	            {"sWidth" : "15%","data": function ( row, type, set ){
	            	return row.source;
	            },"bSortable": false}
			],
			"oLanguage" : common_data_table_config.oLanguage,
			"fnInfoCallback": function( oSettings, iStart, iEnd, iMax, iTotal, sPre ) {
   	 			return  "总共<span class='text-primary'>"+iTotal+"</span>条 ,"+
   	 				"当前"+(iTotal==0?"无记录":"(<span class='txt-color-darken'>"+iStart+" </span>到 <span class='txt-color-darken'>"+iEnd+"</span>)&nbsp;&nbsp;");
  			},
  			"fnDrawCallback": function( oSettings ) {
		      $("[rel=tooltip]").tooltip();
		    },
			"sDom": "<'dt-toolbar'<'col-xs-6'f><'col-xs-6'C>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
			"fnInitComplete": function(oSettings, json) {
				loadingHide();
				dialogCenterScreen(weibo_topics_dialog);
				
						var ipt_topic = '<div class="btn-group margin_R5"><input type="text" class="form-control " name="topic" placeholder="话题"></div>';
						var search_btn = '<a class="btn btn-default"  id="sub_button" href="javascript:void(0);">查询</a><i></i>';
						$("#news_articles_list_wrapper .dt-toolbar")
						.addClass("padding_B5")
						.append(ipt_topic)
						.append(search_btn);
						
						$("#sub_button").click(function(){
					    	var url = "/weibo/getWeiboPagedListDialog?eq_weiboUserName=${weiboUserName}&orderBy=time-desc";
					    	var topic = $("input[name='topic']").val();
					    	var params = {"l_topic":topic};
					    	url = addQueryParams(url,params);
					   	 	data_table.fnSettings().sAjaxSource=url;
					   	 	data_table.fnDraw(); //重新加载数据
					    });
			 }
			/**/
		});
	}
	function lookNewsLogsDetail(ele){
		var logs_summary_id = $(ele).attr("logs_summary_id");
		var rule_id = $(ele).attr("rule_id");
		loadingShow();
		
		$('#news_logs_detail_dialog_div').load("/news/news-logs-detail-dialog?id="+logs_summary_id+"&ruleId="+rule_id,function(){
			news_logs_detail_dialog = window.top.art.dialog({
					title: "异常日志详细细节",
					content: $("#news_logs_detail_dialog_div")[0],
					width:"850px",
					padding: '0px 0px',
					lock:true
				});
			$(".aui_content").css("width","100%");
			news_logs_detail_dialog.hide();
		});
		return false;
		/*
		$('#news_logs_detail_dialog_div').load("news/news-logs-detail-dialog");
		loadNewsLogsDetailDialog();
		$('#news_logs_detail_dialog_div').html("");
		*/
	}
	function lookNewsLogsSummaryDetail(ele){
		var id = $(ele).attr("logs_summary_id");
		$("#edit_dialog_div").load("/news/editNewsLogsSummary?id="+id,function(){
			var dialog = window.top.art.dialog({
					title: "异常日志摘要 - 详情",
					content: $("#edit_dialog_div").html(),
					width:"850px",
					padding: '0px 0px',
					lock:true
			});
			$(".aui_content").css("width","100%");
		});
	}
	function loadNewsLogsDetailDialog(){
		
	}
	function initButtons(){
		var l_site = '<div class="btn-group margin_R5"><input type="text" class="form-control" name="l_site"  placeholder="主站"></div>';
		var l_section = '<div class="btn-group margin_R5"><input type="text" class="form-control" name="l_section" placeholder="版块"></div>';
		var search_btn = '<a class="btn btn-default"  id="sub_button" href="javascript:void(0);">查询</a><a></a>';
		$("#news_logs_summary_table_wrapper .dt-toolbar")
				.addClass("padding_B5")
				.append(l_site)
				.append(l_section)
				.append(search_btn);
		
		$("#sub_button").click(function(){
			    	var url = "/news/getNewsLogsSummarysPagedList?eq_newsLogsOutlineUniquelyNo=${id}&t="+new Date().getTime();
			    	var l_site = $("input[name='l_site']").val();
			    	var l_section = $("input[name='l_section']").val();
			    	var params = {"l_site":l_site,"l_section":l_section
			    				 };
			    	url = addQueryParams(url,params);
			   	 	news_logs_summary_table.fnSettings().sAjaxSource=url;
			   	 	news_logs_summary_table.fnDraw(); //重新加载数据
		});
	}
	loadScript("/resources/js/plugin/datatables/jquery.dataTables.min.js", function(){
		loadScript("/resources/js/plugin/datatables/dataTables.colVis.min.js", function(){
			loadScript("/resources/js/plugin/datatables/dataTables.tableTools.min.js", function(){
				loadScript("/resources/js/plugin/datatables/dataTables.bootstrap.min.js", pagefunction);
			});
		});
	});
</script>