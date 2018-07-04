<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style>
	.dataTables_filter{display:none;}
	.ColVis{display:none;}
	#site_list .tooltip{opacity:1;min-width:400px;background:none;}
	#site_list  td:nth-child(8) .tooltip-inner{min-width:388px;}
	#site_list .tooltip-inner{max-width:none;};
	img.online{border:none;}
</style>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 
				新闻 
			<span>> 
				文章列表
			</span>
		</h1>
	</div>
</div>
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>站点列表  </h2>
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

						<table id="site_list" class="table table-striped table-bordered table-hover" width="100%">
							<thead>
								<tr>
     								<th><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i> 标题</th>
									<th><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i> 主站</th>
									<th><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i> 版块</th>
									<th><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i> 发布时间</th>
									<th><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i> 作者</th>
									<th><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i> 来源</th>
									<th><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i> 图片</th>
									<th><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i> 额外字段</th>
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
	var data_table ;
	$(function(){
			$(".dtp").datepicker({
				  showSecond: true,
		          numberOfMonths:1,  
				  showButtonPanel:false,  
				  dateFormat: 'yy-mm-dd' 
		    });
		    
		    
	})
	
	// PAGE RELATED SCRIPTS

	/* remove previous elems */
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	// Needed if you are rendering multiple tables in ajax version
	//var tableDestroyer = [];
	function openDialog(obj,id)
	{
		$("#dialog_edit").load("/epaper/edit?id="+id,function(){
			var dialog = window.top.art.dialog({
					title: "详情",
					content: $("#dialog_edit").html(),
					width:"850px",
					padding: '0px 0px',
					lock:true
			});
			$(".aui_content").css("width","100%");
		});
	}
	function deleteRow(id){
		$("#dialog_delete").load("/epaper/toDelete?id="+id);
		$('#dialog_delete').dialog("open");
		return false;
	}
	// pagefunction	
	var pagefunction = function() {
		//console.log("cleared");
		$('.dtp').datepicker({  
		  numberOfMonths:1,  
		  showButtonPanel:false,  
		  dateFormat: 'yy-mm-dd',  
		  minDate: new Date()  
		 }); 
		 
		$('#dialog_delete').dialog({
			autoOpen: false,
			resizable : false,
			modal : true,
			width : 600,
			buttons : [{
				html : "确定",
				"class" : "btn btn-danger",
				click : function() {
					var url = "/epaper/deleteArticle";
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
					var url = "/epaper/updateArticle";
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
		/* BASIC ;*/
		data_table = $("#site_list").dataTable({
			"bProcessing" : true,//加载数据时候是否显示进度条
			"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/epaper/getArticlePagedList",//如果从服务器端加载数据,这个属性用于指定加载的路径 
			"columns": [//数据列
	            {"data": function ( row, type, set ){
	            	var title = cut_str(row.title, 30,"...");
	            	return "<a href='"+row.url+"' target= '_blank' title='"+row.title+"'>"+title+"</a>";
	            },"bSortable": false},
	            {"data": function ( row, type, set ){
	            	if(!row.site){return "无";}
	            	return "<a href='"+row.siteUrl+"' target= '_blank'>"+row.site+"</a>";
	            },"bSortable": false},
	            {"data": function ( row, type, set ){
	            	if(!row.section){return "无";}
	            	return "<a href='"+row.sectionUrl+"' target= '_blank'>"+row.section+"</a>";
	            }},
	            {"data": function ( row, type, set ){
	            	if(!row.time){return "无";}
	            	return row.time;
	            },"bSortable": false},
	            {"data":  function ( row, type, set ){
	            	if(!row.author){return "无";}
	            	return row.author;
	            },"bSortable": false},
	            {"data":   function ( row, type, set ){
	            	if(!row.source){return "无";}
	            	return row.source;
	            },"bSortable": false},
	            {"data": function( row, type, set ){
	            	var urls = row.imgUrls;
	            	var r =  "";
	            	if(urls!=""){
	            		var urlArr = urls.split("---------rotarapes---------");
	            		var imgstr = "";
	            		var b_imgstr = "";
	            		var ttt= '';
	            		for(var i = 0 ; i< urlArr.length;i++){
	            			b_imgstr="<img src='"+urlArr[i]+"' alt='me' width='580'/>";
	            			imgstr="<img src='"+urlArr[i]+"' alt='me' width='80' style='margin:3px;'/>";
	            			
	            			r+='<a href="javascript:void(0)" rel="tooltip" data-placement="top" data-original-title="'+b_imgstr+'" data-html="true">'+imgstr+'</a>';
	            		}
	            		//r = '<a href="javascript:void(0);" class="" rel="tooltip" data-placement="top" data-original-title="'+imgstr+'" data-html="true">tutututu</a>';
	            		//r='<a href="javascript:void(0);" class="" rel="tooltip" data-placement="top" data-original-title="'+imgstr+'" data-html="true"><i class="fa fa-file-picture-o"></i></a>';
	            		//r = '<a href="javascript:void(0)" rel="tooltip" data-placement="top" data-original-title="'+b_imgstr+'" data-html="true">'+imgstr+'</a>';
	            	}else{
	            		return "无";
	            	}
	            	return r;
	            }},
	            {"data": function ( row, type, set ){
	            	var str = "";
	            	if(row.additionalAttribute){
	            		var keys = getKey(row.additionalAttribute);
	            		var values = getValue(row.additionalAttribute);
	            		for(var i = 0 ; i <keys.length; i++){
	            			str+="<p style='width:300px;text-align:left;'>"+keys[i]+":"+values[i]+"</p>";
	            		}
	            		
	            	}else{
	            		str+="无";
	            	}
	            	if(str.length>80){
		            	var short_str = str.substring(0,80);
		            	//var s = '<div class="tooltip fade top in" style="top: -203px; left: 869px; display: block;"><div class="tooltip-arrow"></div><div class="tooltip-inner"><p style="width:300px;">收费标准:无</p><p style="width:300px;">办理时限:法定期限：0个工作日 承诺期限：30个工作日</p><p style="width:300px;">窗口办理流程:顺德区经济和科技促进局初审，广东省知识产权局终审</p><p style="width:300px;">办理对象:企事业单位</p><p style="width:300px;">常见问题解答: 无</p><p style="width:300px;">办事窗口:广东省知识产权局产业促进处 工作时间： 法定工作日：上午8：30-12：00，下午2：00-5：30 地址： 顺德区行政服务中心东座二楼 联系电话： 02087684899 交通指引： 可搭乘301、308、312、316、902、904路公交前往，在区行政服务中心站下车。</p><p style="width:300px;">办理条件:根据广东省知识产权优势示范企业认定办法</p><p style="width:300px;">所需材料:1 、 广东省知识产权优势示范企业申请书（原件一式三份） 2 、 申报要求的附件（原件一式三份）</p><p style="width:300px;">受理机构:广东省知识产权局产业促进处</p><p style="width:300px;">附件:http://www.sdewt.com/OuterNetWeb/appMain?service=attach&amp;func=openItemAttachmentFile&amp;seq=814</p><p style="width:300px;">办理依据:《广东省知识产权优势示范企业认定办法》（粤知产〔2012〕23号，2011年3月21日起实施）</p><p style="width:300px;">备注:当电子材料初审通过后才递交《广东省知识产权优势示范企业申请书》（在网站中打印），未通过初审的不用交。</p><p style="width:300px;">网上办理流程:访问区网上办事大厅→登录（如果还没有登录帐号，先实名注册）→在首页事项查找栏里查找办理事项→点击在线申请→填写表单→上传相关电子材料（根据页面提示清单要求）→提交确认→凭业务受理号查询办件办理进度</p><p style="width:300px;">主管部门:区经济和科技促进局</p></div></div>';
		            	return '<span rel="tooltip" data-placement="top" data-original-title="'+str+'" data-html="true">'+short_str+'</span>';
		            }
	            	return str;
	            },"bSortable": false},
	             {
	            	"sWidth" : "10%",
		            "sTitle": "操作",
		            "sClass": "center",
		             "bSortable": false,
		            "data": function ( row, type, set ){
				        return "<button  onclick=\"openDialog(this,'"+row.id+"');\" title=\"编辑\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></button>&nbsp;"
				        +"<button  onclick=\"deleteRow('"+row.id+"');\" title=\"删除\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-times\"></i></button>";
			        } 
	        	}
			],
			"oLanguage" : { //主要用于设置各种提示文本
				"sProcessing" : "正在处理...", //设置进度条显示文本
<%--				"sLengthMenu" : "每页_MENU_行",//显示每页多少条记录--%>
				"sEmptyTable" : "没有找到记录",//没有记录时显示的文本
				"sZeroRecords" : "没有找到记录",//没有记录时显示的文本
				
				"sInfoEmpty" : "",//没记录时,关于记录数的显示文本
<%--				"sSearch" : "搜索:",//搜索框前的文本设置--%>
				"oPaginate" : {//不设置时，默认为英文
					"sFirst" : "首页",
					"sLast" : "未页",
					"sNext" : "下页",
					"sPrevious" : "上页"
				},
				"sLengthMenu": "每页 _MENU_ 条 "
			},
			"aaSorting": [[ 2, "desc" ]] ,//更改默认排序，从0开始，
			"fnInfoCallback": function( oSettings, iStart, iEnd, iMax, iTotal, sPre ) {
   	 			return  "总共<span class='text-primary'>"+iTotal+"</span>条 ,"+
   	 				"当前"+(iTotal==0?"无记录":"(<span class='txt-color-darken'>"+iStart+" </span>到 <span class='txt-color-darken'>"+iEnd+"</span>)&nbsp;&nbsp;");
  			},
  			"fnDrawCallback": function( oSettings ) {
		      $("[rel=tooltip]").tooltip();
		    },
			"sDom": "<'dt-toolbar'<'col-xs-6'f><'col-xs-6'C>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
			"fnInitComplete": function(oSettings, json) {
				initEpaperToolItems();
		     }
	    });
	    
	};
	function initEpaperToolItems(){
		$("#site_list_wrapper .dt-toolbar").empty();
		var ipt_title = '<div class="btn-group margin_R5 "><input type="text" class="form-control " name="title" placeholder="标题"></div>';
		var ipt_site = '<div class="btn-group margin_R5  "><input type="text" class="form-control " name="site" placeholder="主站"></div>';
		var ipt_section = '<div class="btn-group margin_R5  "><input type="text" class="form-control " name="section" placeholder="版块"></div>';
		var ipt_s_time = '<div class="btn-group margin_R5  "><input type="text" class="form-control dtp" name="s_time"  placeholder="开始时间"></div>';
		var ipt_e_time = '<div class="btn-group margin_R5  "><input type="text" class="form-control dtp " name="e_time" placeholder="结束时间"></div>';
		//var search_btn = '<button type="button" class="btn btn-primary" style="">查询</button>';
		var search_btn = '<a class="btn btn-default margin_R5  "  id="sub_button" href="javascript:void(0);">查询</a><a></a>';
		var del_all_btn = '<a class="btn btn-danger margin_R5  "  id="del_all_button" href="javascript:void(0);">删除全部</a><a></a>';
		$("#site_list_wrapper .dt-toolbar").addClass("padding_B5")
		.append(ipt_title).append(ipt_site).append(ipt_section).append(ipt_s_time).append(ipt_e_time)
		.append(search_btn).append(del_all_btn);
		$(".dtp").datepicker();
		
		$("#sub_button").click(function(){
	    	var url = "/epaper/getArticlePagedList";
	    	var title = $("input[name='title']").val();
	    	var site = $("input[name='site']").val();
	    	var section = $("input[name='section']").val();
	    	//var author = $("input[name='author']").val();
	    	//var source = $("input[name='source']").val();
	    	var s_time = $("input[name='s_time']").val();
	    	var e_time = $("input[name='e_time']").val();
	    	var params = {"l_title":title,"l_site":site,"l_section":section,
	    				  "s_time":s_time,"e_time":e_time};
	    	url = addQueryParams(url,params);
	   	 	data_table.fnSettings().sAjaxSource=url;
	   	 	data_table.fnDraw(); //重新加载数据
	    });
		
		/*
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
		*/
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
	loadScript("/resources/js/plugin/jquery-form/jquery-form.min.js",function(){
		loadScript("/resources/js/plugin/datatables/jquery.dataTables.min.js", function(){
			loadScript("/resources/js/plugin/datatables/dataTables.colVis.min.js", function(){
				loadScript("/resources/js/plugin/datatables/dataTables.tableTools.min.js", function(){
					loadScript("/resources/js/plugin/datatables/dataTables.bootstrap.min.js", pagefunction);
				});
			});
		});
	});


--></script>
