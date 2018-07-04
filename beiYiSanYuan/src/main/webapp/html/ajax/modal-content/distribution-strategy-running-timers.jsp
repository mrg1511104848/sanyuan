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
					<div class="widget-body no-padding">

						<table id="running_timer_list" class="table table-striped table-bordered table-hover" width="100%">
							<thead>
								<tr>
     								<th><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i> 作业名称</th>
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
<script type="text/javascript" src="/resources/js/app-common.js"></script>
<script type="text/javascript">

	pageSetUp();
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	var running_timers_data_table ;
	// pagefunction	
	var pagefunction = function() {
		loadDataTable();
	};
	function loadDataTable(){
		/* BASIC ;*/
		if(running_timers_data_table!=null){
	        	//$("#rule_list tbody tr").remove();
	        running_timers_data_table.fnDestroy();
		}
		running_timers_data_table = $("#running_timer_list").dataTable({
			"bProcessing" : true,//加载数据时候是否显示进度条
			"bServerSide" : true,//是否从服务加载数据 
			"bSort":false,
			"iDisplayLength" : 10,// 每页显示行数
			"sAjaxSource" : "/distribution-strategies/getRuningTimerAll",//如果从服务器端加载数据,这个属性用于指定加载的路径 
			"columns": [//数据列
	            {"data": function ( row, type, set ){
		            return row;
	            },"bSortable": false},
	             {
	             	"sWidth":'30px',
		            "sTitle": "操作",
		            "sClass": "center",
		             "bSortable": false,
		            "data": function ( row, type, set ){
		            	var delBtn ="<button  onclick=\"confirm('操作确认','<div style=padding:10px><font color=red>确定要删除吗(一旦删除，数据将无法恢复!)</font></div>',killTimer,'','"+row+"');\" title=\"删除\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-times\"></i></button>"; 
				        return delBtn; 
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
		    "sDom": "<'dt-toolbar'<'col-xs-12 tools-bar'><'col-xs-4'C>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
			"fnInitComplete": function(oSettings, json) {
				$("#running_timer_list_wrapper .dt-toolbar").remove();
		     }
	    });
	}
	function killTimer(d,all){
		
		var url = "/distribution-strategies/removeRuningTimer?id="+d;
		if(all=="delAll"){	
			url+="&all=1";
		}
		$.ajax({
				url:url,
				type:"POST",
				dataType:'json',
				success:function(data){
					if(data.result==1){
						MessageBoxShow('操作成功!',true);
						running_timers_data_table.fnDraw(); //重新加载数据
						
					}else{
						MessageBoxShow('操作失败!服务器异常!',true);
					}
					return false;
				}
		});
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
