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
     								<th> 标题</th>
									<th> 内容</th>
									<th> 图片</th>
									<th> 时间</th>
									<th> 操作</th>
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
<div id="weixin_edit_dialog_div"  style="display:none;"></div>
<div id="edit_dialog_div" style="display:none;"></div>
<script src="/resources/js/news-common.js"></script>
<script type="text/javascript">
 	//初始化加载一些参数
	pageSetUp();
	
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	var data_table ;
	var weixin_edit_dialog;
	// pagefunction	
	var pagefunction = function() {
		data_table = $("#news_articles_list").dataTable({
			"bSort":false,
			"bProcessing" : true,//加载数据时候是否显示进度条
			"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/weixin/getWeixinPagedListDialog?eq_author=${weixinAccountName}&orderBy=time-desc&timeStamp="+new Date().getTime(),//如果从服务器端加载数据,这个属性用于指定加载的路径 
			"columns": [//数据列
	            {"sWidth" : "30%","data": function ( row, type, set ){
	            	var url = row.url;
		            var title = row.title;
		            var stitle = cut_str(title, 30,"...");
		            if(!title){return "无";}
	            	return "<a href='"+url+"' title='"+title+"'>"+stitle+"</a>";
	            },"bSortable": false},
	            {"sWidth" : "5%","data": function ( row, type, set ){
	            	var content =  row.content;
	            	var scontent = cut_str(content, 30,"...");
	            	if(!row.content){
	            	return "无";
	            	}else return "有";
	            },"bSortable": false},
	            {"sWidth" : "5%","data": function ( row, type, set ){
	            	var imgUrls = row.imgUrls;
	            	if(imgUrls!=""){
	            		return "有";
	            	}else{	
	            		return "无";
	            	}
	            },"bSortable": false},
	            {"sWidth" : "5%","data": function ( row, type, set ){
	            	var time = row.time;
	            	if(!time){return "无";}
	            	return time;
	            },"bSortable": false},
	            {"sWidth" : "20px","data": function ( row, type, set ){
	            	var htm = '';
	            	htm+='<button onclick="lookWeixinArticleDetail(this);" title="详细" id="'+row.id+'" class="btn btn-xs btn-default ">';
	            	htm+='<i class="fa fa-search"></i>';
	            	htm+='</button>';
	            	return htm;
	            	//return "<a href='javascript:;' title='详细' onclick='lookWeixinArticleDetail(this)' id='"+row.id+"'>xx</a>";
	            }}
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
				
			
			
				var ipt_title = '<div class="btn-group margin_R5"><input type="text" class="form-control " name="title" placeholder="标题"></div>';
				var ipt_author = '<div class="btn-group margin_R5"><input type="text" class="form-control " name="author" placeholder="作者"></div>';
				
				var search_btn = '<a class="btn btn-default"  id="sub_button" href="javascript:void(0);">查询</a><i></i>';
				$("#news_articles_list_wrapper .dt-toolbar")
				.addClass("padding_B5")
				.append(ipt_title)
				.append(ipt_author)
				.append(search_btn);
				
				$("#sub_button").click(function(){
			    	var url = "/weixin/getWeixinPagedListDialog?eq_author=${weixinAccountName}&orderBy=time-desc";
			    	var author = $("input[name='author']").val();
			    	var title = $("input[name='title']").val();
			    	var params = {"l_author":author,"l_title":title};
			    	url = addQueryParams(url,params);
			   	 	data_table.fnSettings().sAjaxSource=url;
			   	 	data_table.fnDraw(); //重新加载数据
			    });
			    
			    loadingHide();
			    weixin_articles_dialog.show();
				//dialogCenterScreen(weixin_articles_dialog);
		     }
		});
	}
	
	function lookWeixinArticleDetail(ele){
		var id = $(ele).attr("id");
		loadingShow();
		
		$('#weixin_edit_dialog_div').load("/weixin/edit?eq_id="+id,function(){
			weixin_edit_dialog = window.top.art.dialog({
					title: "详细",
					content: $("#weixin_edit_dialog_div")[0],
					width:"850px",
					padding: '0px 0px',
					lock:true
				});
			$(".aui_content").css("width","100%");
			loadingHide();
			//weixin_edit_dialog.hide();
		});
		return false;
		/*
		$('#weixin_edit_dialog_div').load("news/news-logs-detail-dialog");
		loadNewsLogsDetailDialog();
		$('#weixin_edit_dialog_div').html("");
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