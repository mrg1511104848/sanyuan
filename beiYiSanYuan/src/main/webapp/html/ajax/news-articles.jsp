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
				新闻 
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
									<th> 主站</th>
									<th> 版块</th>
									<!-- <th> 作者</th>
									<th> 来源</th> -->
									<th> 图片</th>
									<th> 额外字段</th>
									<th> 发布时间</th>
									<th> 时间戳</th>
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
	
	
	// PAGE RELATED SCRIPTS

	/* remove previous elems */
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	// Needed if you are rendering multiple tables in ajax version
	//var tableDestroyer = [];
	function openDialog(obj,id)
	{
		$("#dialog_edit").load("/news/edit?id="+id,function(){
			var dialog = window.top.art.dialog({
					title: "详情",
					content: $("#dialog_edit").html(),
					width:"850px",
					padding: '0px 0px',
					lock:true
			});
			$(".aui_content").css("width","100%");
		});
		//$('#dialog_edit').dialog("open");
		//return false;
	}
	function deleteRow(id){
		//$("#dialog_delete").load("/news/toDelete?id="+id);
		//$('#dialog_delete').dialog("open");
		
		art.dialog.confirm('你确定要删除这篇文章吗？', function () {
			$.ajax({
				type: "post",
			    url: "/news/deleteArticle?id="+id,
			    cache:false,
			    dataType:"json",
			    success: function(data){
			    	if(data)
	    			{
			    		art.dialog.tips('删除成功!');
            			data_table.fnDraw(); //重新加载数据
	    			}else{
			    		art.dialog.tips('删除失败!');
	    			}	
	        	}
			});
		}, function () {
		    
		});
		changeArtdialogButtonCss();
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
		/* BASIC ;*/
		loadNewsArticles();
	    
	};
	var data_table ;
	function loadNewsArticles(){
		if(data_table!=null){
	        data_table.fnDestroy();
		}
		data_table = $("#news_articles_list").dataTable({
			"bSort":false,
			"bProcessing" : true,//加载数据时候是否显示进度条
			"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/news/getArticlePagedList?orderBy=timeStamp-asc&t="+Math.random(),//如果从服务器端加载数据,这个属性用于指定加载的路径 
			"sPaginationType" : "full_numbers",
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
		            if(row.realUrl){
			            url = row.realUrl;
			        }
		            var title = cut_str(row.title, 30,"...");
	            	return "<a href='"+url+"' target= '_blank' title='"+row.title+"'>"+title+"</a>";
	            },"bSortable": false},
	            {"data": function ( row, type, set ){
	            	if(!row.site){return "无";}
	            	return "<a href='"+row.siteUrl+"' target= '_blank'>"+row.site+"</a>";
	            },"bSortable": false},
	            {"data": function ( row, type, set ){
	            	if(!row.section){return "无";}
	            	return "<a href='"+row.sectionUrl+"' target= '_blank'>"+row.section+"</a>";
	            },"bSortable": false},
	            
	            {"data": function( row, type, set ){
		            /*
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
	            	
	            	return r;*/
	            	var urls = row.imgUrlSet;
	            	if(urls!=""){
		            	return "有";
		            }
	            	return "无";
	            	
	            },"bSortable": false},
	            {"data": function ( row, type, set ){
		            /*
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
	            	*/
	            	if(row.additionalAttribute){
	            		return "有";
		            }else{
		            	return "无";
			        }
	            },"bSortable": false},
	            {"data": function ( row, type, set ){
	            	return genHtmlByObject(row.time);
	            },"bSortable": false},
	            {"data": function ( row, type, set ){
	            	return genHtmlByObject(row.timeStamp);
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
			"sDom":common_data_table_config.sDom,
			"fnInitComplete": function(oSettings, json) {
				$("#news_articles_list_wrapper .dt-toolbar .col-xs-8 ").remove();
				$("#news_articles_list_wrapper .dt-toolbar .col-xs-4 ").remove();
				var ipt_title = '<div class="btn-group margin_R5 margin_B5"><input type="text" class="form-control " name="title" placeholder="标题"></div>';
				var ipt_site = '<div class="btn-group margin_R5  margin_B5"><input type="text" class="form-control " name="site" placeholder="主站"></div>';
				var ipt_section = '<div class="btn-group margin_R5  margin_B5"><input type="text" class="form-control " name="section" placeholder="版块"></div>';
				var ipt_url = '<div class="btn-group margin_R5  margin_B5"><input type="text" class="form-control " name="url" placeholder="url"></div>';
				var t_timestamp = '<div class="btn-group margin_R5  margin_B5"><input type="text" class="form-control " name="timeStamp" placeholder="时间戳"></div>';
				var ipt_s_time = '<div class="btn-group margin_R5  margin_B5"><input type="text" class="form-control dtp" name="s_time"  placeholder="开始时间"></div>';
				var ipt_e_time = '<div class="btn-group margin_R5  margin_B5"><input type="text" class="form-control dtp " name="e_time" placeholder="结束时间"></div>';
				//var search_btn = '<button type="button" class="btn btn-primary" style="">查询</button>';
				var search_btn = '<a class="btn btn-default margin_R5  margin_B5"  id="sub_button" href="javascript:void(0);" onclick="searchNewsArticle()">查询</a><a></a>';
				var del_all_btn = '<a class="btn btn-danger margin_R5 margin_B5 "  id="del_all_button" href="javascript:void(0);" onclick="delAllArticle()">删除全部</a><a></a>';
				$("#news_articles_list_wrapper .dt-toolbar #news_articles_list_processing").addClass("padding_B5")
				.before(ipt_title).before(ipt_site).before(ipt_section).before(ipt_url).before(t_timestamp).before(ipt_s_time).before(ipt_e_time)
				.before(search_btn)
				
				var isAdmin = '${currentUser.isAdmin}';
				if(isAdmin==1){
					$("#news_articles_list_wrapper .dt-toolbar #news_articles_list_processing").before(del_all_btn);
				}
				$(".dtp").datepicker();
				
				
				$("input[name='articles']").on('click',function(){
					var ck_rules_ele_len = $("input[name='articles']").length;
					var ckd_len = $("input[name='articles']:checked").length;
					if(ckd_len == ck_rules_ele_len){
						$("#all_articles")[0].checked = true;
					}else{
						$("#all_articles")[0].checked = false;
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
						url:'/news/deleteArticle.html?ids='+del_article_ids,
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
	function searchNewsArticle(){
			    	var url = "/news/getArticlePagedList";
			    	var title = $("input[name='title']").val();
			    	var site = $("input[name='site']").val();
			    	var section = $("input[name='section']").val();
			    	var l_url = $("input[name='url']").val();
			    	var l_timeStamp = $("input[name='timeStamp']").val();
			    	var s_time = $("input[name='s_time']").val();
			    	var e_time = $("input[name='e_time']").val();
			    	var params = {"l_title":title,"l_site":site,"l_section":section,"eq_timeStamp":l_timeStamp
			    				  ,"s_time":s_time,"e_time":e_time,"l_url":l_url,"orderBy":"timeStamp-asc"};
			    	url = addQueryParams(url,params);
			   	 	data_table.fnSettings().sAjaxSource=url;
			   	 	data_table.fnDraw(); //重新加载数据
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


</script>
