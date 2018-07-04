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
			<div class="jarviswidget jarviswidget-color-darken" data-widget-editbutton="false" data-widget-colorbutton="false">

				<!-- widget div-->
				<div>
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body no-padding">

						<table id="epaper_group_rule_list" class="table table-striped table-bordered table-hover" width="100%">
							<thead>
								<tr>
     								<th><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i> 标题</th>
									<th><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i> 发布时间</th>
									<th><i class="fa fa-fw fa-list-alt text-muted hidden-md hidden-sm hidden-xs"></i> 操作</th>
								</tr>
							</thead>
						</table>

					</div>
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

<script type="text/javascript">

	pageSetUp();
	var epaper_article_data_table ;
	$(function(){
		
			$(".dtp").datepicker({
				  showSecond: true,
		          numberOfMonths:1,  
				  showButtonPanel:false,  
				  dateFormat: 'yy-mm-dd'
		    });
		    
	})

	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	/*
	function openDialog(obj,id)
	{
		$("#dialog_edit").load("/epaper/edit?id="+id);
		$('#dialog_edit').dialog("open");
		return false;
	}
	*/
	function openDialog(obj,id)
	{
		 $("#dialog_edit").load("/epaper/edit?id="+id,function(){
			var dialog = window.top.art.dialog({
				title: "详情",
				content: $("#dialog_edit")[0],
				width:"850px",
				padding: '0px 0px',
				lock:true
			});
			$(".aui_content").css("width","100%");
		});
		//$('#dialog_edit').dialog("open");
		$("#dialog_edit").html("");

		
		return false;
	}
	function deleteRow(ele,id){
		art.dialog.confirm('你确定要删除这个任务吗？', function () {
			$.ajax({
				type: "post",
			    url: "/epaper/toDelete?id="+id,
			    dataType:"json",
			    data:{"url":$(ele).attr("url")},
			    success: function(data){
			    	if(data.result)
	    			{
			    		art.dialog.tips('删除成功!');
	    			}else{
			    		art.dialog.tips('删除失败!');
	    			}	
			    	epaper_article_data_table.fnDraw();
			    	//getAllGroupList();
			    	//oTable.fnDraw(); //重新加载数据
	        	}
			});
		}, function () {
		    
		});
		changeArtdialogButtonCss();
		return false;
	}
	// pagefunction	
	var pagefunction = function() {
		
		$('#dialog_delete').dialog({
			autoOpen: false,
			resizable : false,
			modal : true,
			width : 600,
			buttons : [{
				html : "确定",
				"class" : "btn btn-danger",
				click : function() {
					var url = "news/deleteArticle";
					var id = $('#dialog_delete').find("input[name='del_id']").val();
					var data= {"id":id};
					$.ajax({
						url:url,
						data:data,
						type:"POST",
						success:function(data){
							if(data){
								$("#dialog_simple").dialog('close')  ;
								//data_table.fnClearTable(); //清空数据
            					data_table.fnDraw(); //重新加载数据
							}
						}
					})
				}
			}, {
				html : "<i class='fa fa-times'></i>&nbsp; 取消",
				"class" : "btn btn-default",
				click : function() {
					$(this).dialog("close");
				}
			}]
		})
		 $('#dialog_edit').dialog({
			autoOpen: false,
			resizable : false,
			modal : true,
			width : 600,
			height:500,
			buttons : [{
				html : "<i class='fa fa-pencil-square-o'></i>&nbsp; 确定",
				"class" : "btn btn-default",
				click : function() {
					var url = "news/updateArticle";
					var data= $("#frmArticle").serialize();
					$.ajax({
						url:url,
						data:data,
						type:"POST",
						success:function(data){
							if(data){
								$("#dialog_edit").dialog('close')  ;
								//data_table.fnClearTable(); //清空数据
            					data_table.fnDraw(); //重新加载数据
							}
						}
					})
					
				}
			}, {
				html : "<i class='fa fa-times'></i>&nbsp; 取消",
				"class" : "btn btn-default",
				click : function() {
					$(this).dialog("close");
				}
			}]
		});
		//"sInfo" : "总记录数<span class='text-primary'>_TOTAL_</span>当前显示<span class='txt-color-darken'>_START_</span>至<span class='txt-color-darken'>_END_</span>",
		
		loadDataTable();
	};
	function loadDataTable(){
		/* BASIC ;*/
		if(epaper_article_data_table!=null){
	        	//$("#rule_list tbody tr").remove();
	        epaper_article_data_table.fnDestroy();
		}
		epaper_article_data_table = $("#epaper_group_rule_list").dataTable({
			"bProcessing" : true,//加载数据时候是否显示进度条
			"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/epaper/getArticlePagedList?eq_ruleId="+'${eq_ruleId}',//如果从服务器端加载数据,这个属性用于指定加载的路径 
			"columns": [//数据列
	            {"data": function ( row, type, set ){
		            var url = row.url;
		            if(row.realUrl){
			            url = row.realUrl;
			        }
	            	return "<a href='"+url+"' target= '_blank'>"+row.title+"</a>";
	            },"bSortable": false},
	            {"data": function ( row, type, set ){
	            	if(!row.time){return "无";}
	            	return row.time;
	            },"bSortable": false},
	             {
		            "sTitle": "操作",
		            "sClass": "center",
		             "bSortable": false,
		            "data": function ( row, type, set ){
				        return "<button  onclick=\"openDialog(this,'"+row.id+"');\" title=\"编辑\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></button>&nbsp;"
				        +"<button  onclick=\"deleteRow('"+row.id+"');\" title=\"删除\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-times\"></i></button>";
			        } 
	        	}
			],
			"oLanguage" : common_data_table_config.oLanguage,
			"aaSorting": [[ 2, "desc" ]] ,//更改默认排序，从0开始，
			"fnInfoCallback": function( oSettings, iStart, iEnd, iMax, iTotal, sPre ) {
   	 			return  "总共<span class='text-primary'>"+iTotal+"</span>条 ,"+
   	 				"当前"+(iTotal==0?"无记录":"(<span class='txt-color-darken'>"+iStart+" </span>到 <span class='txt-color-darken'>"+iEnd+"</span>)&nbsp;&nbsp;");
  			},
  			"fnDrawCallback": function( oSettings ) {
		      $("[rel=tooltip]").tooltip();
		    },
		    "sDom": "<'dt-toolbar'<'col-xs-12 tools-bar'><'col-xs-4'C>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
			"fnInitComplete": function(oSettings, json) {
				/*
		    	var tools_html='<div class="btn-group">'+
								'  <div class="icon-addon  pull-left">'+
								'  	<input type="text" class="input-sm dtp hasDatepicker" name="title" placeholder="标题">'+
									'</div>'+
								'</div>'+
								'<div class="btn-group">'+
								'  <div class="icon-addon  pull-left">'+
								'  	<input type="text" class="input-sm dtp hasDatepicker" name="s_time" placeholder="开始时间">'+
									'</div>'+
								'</div>'+
								'<div class="btn-group">'+
								'  <div class="icon-addon  pull-left">'+
								'  	<input type="text" class="input-sm dtp hasDatepicker" name="e_time" placeholder="结束时间">'+
								  '</div>'+
								'</div>'+
				'<div class="btn-group">'+
				'<button class="btn btn-default" id="sub_button">查 询 </button></div>';
				*/

				var tools_html=	'<input type="text" class="form-control ng-valid ng-dirty margin_R5" name="title" placeholder="标题" >'+
				'<input type="text" class="dtp hasDatepicker form-control margin_R5" name="s_time" placeholder="开始时间">'+
				'<input type="text" class="dtp hasDatepicker form-control margin_R5" name="e_time" placeholder="结束时间">'+
				'<a class="btn btn-default" id="sub_button">查 询 </a>';

				$("#epaper_group_rule_list_wrapper .tools-bar").append(tools_html);	
				$("#epaper_group_rule_list_wrapper .dt-toolbar").addClass("padding_B5");
				
				$(".dtp").datepicker({
					  showSecond: true,
			          numberOfMonths:1,  
					  showButtonPanel:false,  
					  dateFormat: 'yy-mm-dd'
			    });
				$("#sub_button").click(function(){
			    	var url = "/epaper/getArticlePagedList";
			    	var title = $("input[name='title']").val();
			    	var s_time = $("input[name='s_time']").val();
			    	var e_time = $("input[name='e_time']").val();
			    	var params = {"l_title":title,"s_time":s_time,"e_time":e_time};
			    	url = addQueryParams(url,params);
			    	epaper_article_data_table.fnSettings().sAjaxSource=url;
			    	epaper_article_data_table.fnDraw(); //重新加载数据
			    });
		     }
	    });
	}
	function getKey(map){
		var arr_k =  new Array();
		if(map){
			for(var key in map){  
				arr_k.push(key);
	        }  
        }else{}
        return arr_k;
	}
	function getValue(map){
		var arr_v =  new Array();
		if(map){
			for(var key in map){
				arr_v.push(map[key]);
	        }  
        }else{}
        return arr_v;
	}
	// load related plugins
	loadScript(
		"/resources/js/plugin/datatables/jquery.dataTables.min.js",
		function() {
			loadScript(
					"/resources/js/plugin/datatables/dataTables.colVis.min.js",
					function() {
						loadScript(
								"/resources/js/plugin/datatables/dataTables.tableTools.min.js",
								function() {
									loadScript(
											"/resources/js/plugin/datatables/dataTables.bootstrap.min.js",
											function(){loadScript("/resources/js/plugin/superbox/superbox.js",pagefunction);}
											);
								});
					});
});


</script>
