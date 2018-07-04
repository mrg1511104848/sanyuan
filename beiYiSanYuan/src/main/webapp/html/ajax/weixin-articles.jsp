<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style>
	.dataTables_filter{display:none;}
	.ColVis{display:none;}
	#news_articles_list .tooltip{opacity:1;min-width:400px;background:none;}
	#news_articles_list  td:nth-child(8) .tooltip-inner{min-width:388px;}
	#news_articles_list .tooltip-inner{max-width:none;};
	img.online{border:none;}
</style>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 
				微信
			<span>> 
				文章列表
			</span>
		</h1>
	</div>
</div>
<!-- widget grid -->
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-custombutton="false" data-widget-sortable="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>文章列表  </h2>
				</header>

				<!-- widget div-->
				<div>
					
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body no-padding">

						<table id="news_articles_list" class="table table-striped table-bordered table-hover smart-form has-tickbox dataTable no-footer" width="100%">
							<thead>
								<tr>
									<th>
										<label class="checkbox">
											<input type="checkbox"  id="all_articles">
											<i></i>
										</label>
									</th>
									<th> 标题</th>
									<th> 内容</th>
									<th> 作者</th>
									<th> 图片</th>
									<th> 时间</th>
									<th><i class="fa fa-fw fa-list-alt text-muted hidden-md hidden-sm hidden-xs"></i> 操作</th>
								</tr>
							</thead>
						</table>

					</div>
					<div id="dialog_edit" title="编辑文章" style="display:none;"></div>
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

<script type="text/javascript">

	pageSetUp();
	/* remove previous elems */
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
			"sAjaxSource" : "/weixin/getWeixinPagedList?orderBy=time-desc",//如果从服务器端加载数据,这个属性用于指定加载的路径 
			"columns": [//数据列
				{"data": function ( row, type, set ){
						var html_ = '<label class="checkbox">'+
										'<input type="checkbox" name="articles" value="'+row.id+'">'+
										'<i></i>'+
									'</label>';
						return html_;
			    }},
	            {"data": function ( row, type, set ){
	            	var url = row.url;
		            var title = row.title;
		            if(!title){return "无";}
	            	return "<a href='"+url+"' target='_blank'>"+title+"</a>";
	            },"bSortable": false},
	            {"data": function ( row, type, set ){
	            	var content =  row.content;
	            	if(!row.content){
	            	return "无";
	            	}else return "有";
	            },"bSortable": false},
	            
	            {"data": function( row, type, set ){
	            	var author = row.author;
	            	return author;
	            },"bSortable": false},
	            {"data": function ( row, type, set ){
	            	var imgUrls = row.imgUrls;
	            	if(imgUrls!=""){
	            		return "有";
	            	}else{	
	            		return "无";
	            	}
	            },"bSortable": false},
	            {"data": function ( row, type, set ){
	            	var time = row.time;
	            	if(!time){return "无";}
	            	return time;
	            },"bSortable": false},
	             {
	            	"sWidth" : "60px",
		            "sTitle": "操作",
		            "sClass": "center",
		             "bSortable": false,
		            "data": function ( row, type, set ){
		            	var isAdmin = '${currentUser.isAdmin}';
		            	var btns = "<button  onclick=\"openDialog(this,'"+row.id+"');\" title=\"查看\" class=\"btn btn-xs btn-default \"><i class=\"fa fa-search\"></i></button>&nbsp;";
				        if(isAdmin==1){
				        	btns+="<button  onclick=\"deleteRow('"+row.id+"');\" title=\"删除\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-times\"></i></button>";
				        }
				        return btns;
			        } 
	        	}
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
				var del_all_btn = '<a class="btn btn-danger margin_L5 "  id="del_all_button" href="javascript:void(0);" onclick="delAllArticle()">删除全部</a><a></a>';
				$("#news_articles_list_wrapper .dt-toolbar")
				.addClass("padding_B5")
				.append(ipt_title)
				.append(ipt_author)
				.append(search_btn);
				
				var isAdmin = '${currentUser.isAdmin}';
				if(isAdmin==1){
					$("#news_articles_list_wrapper .dt-toolbar").append(del_all_btn);
				}
				
				$("#sub_button").click(function(){
			    	var url = "/weixin/getWeixinPagedList?orderBy=time-desc";
			    	var author = $("input[name='author']").val();
			    	var title = $("input[name='title']").val();
			    	var params = {"l_author":author,"l_title":title};
			    	url = addQueryParams(url,params);
			   	 	data_table.fnSettings().sAjaxSource=url;
			   	 	data_table.fnDraw(); //重新加载数据
			    });
		     }
			});		
			$("#all_articles").click(function(){
				if($(this).is(':checked')){
					$("input[name='articles']").each(function(){
						$(this)[0].checked = true;
					})
				}else{
					$("input[name='articles']").each(function(){
						$(this)[0].checked = false;
					})
				}
			});
	
}


	function delAllArticle(){
		var del_article_ids = "";
		$("input[name='articles']").each(function(){
		   if($(this).is(":checked")){
		    	del_article_ids+=$(this).val()+",";
		   }
		});
		if(!del_article_ids){
			MessageBoxShow('至少选择一项进行删除!');
			return;
		}
		if(del_article_ids.indexOf(",")>-1) del_article_ids = del_article_ids.substring(0,del_article_ids.length-1);
		$.ajax({
			url:'/weixin/delete.html?ids='+del_article_ids,
			success:function(d){
				if(d){
					MessageBoxShow('删除成功!',true);
					data_table.fnDraw(); //重新加载数据
				}else{
					MessageBoxShow('删除失败!');
				}
			}
		})	
	}
	function openDialog(obj,id)
	{
		loadingShow();
		$("#dialog_edit").load("/weixin/edit?eq_id="+id,function(){
			var dialog = window.top.art.dialog({
					title: "详情",
					content: $("#dialog_edit").html(),
					width:"850px",
					padding: '0px 0px',
					lock:true
			});
			loadingHide();
			$(".aui_content").css("width","100%");
		});
		
		//$('#dialog_edit').dialog("open");
		//return false;
	}
	function deleteRow(id){
		//$("#dialog_delete").load("/news/toDelete?id="+id);
		//$('#dialog_delete').dialog("open");
		var dialog = art.dialog({
					id:"rule_dialog",
				    title: '删除确认框',
				    width: 'auto',    // 内容宽度
	 				height: 'auto',    // 内容高度
				    content: "确认要删除吗?",
				    padding: '0px 0px',
				    lock:true,
				    button:[{
				    	name:"确认",
				    	callback:function(){
					    	$.ajax({
								type: "post",
							    url: "/weixin/delete?id="+id,
							    dataType:"json",
							    success: function(d){
							    	if(d.result>0){
										MessageBoxShow(d.msg,1);
									}else MessageBoxShow(d.msg);
							    	data_table.fnDraw(); //重新加载数据
					        	}
							});
				    	}
				    },{
				    	name:"取消",
				    	callback:function(){
				    	}
				    }],
				    init: function () {
				    	changeArtdialogButtonCss();
				    }
		});
		$(".aui_content").css("text-align","center");
		return false;
	}

	// load related plugins
	loadScript("/resources/js/plugin/jquery-form/jquery-form.min.js",function(){
		loadScript("/resources/js/plugin/datatables/jquery.dataTables.min.js", function(){
			loadScript("/resources/js/plugin/datatables/dataTables.colVis.min.js", function(){
				loadScript("/resources/js/plugin/datatables/dataTables.tableTools.min.js", function(){
					loadScript("/resources/js/plugin/datatables/dataTables.bootstrap.min.js", pagefunction);
				});
			});
		});
	});
</script>
