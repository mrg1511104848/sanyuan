<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style>
	.dataTables_filter{display:none;}
	.ColVis{display:none;}
	#news_articles_list .tooltip{opacity:1;min-width:400px;background:none;}
	#news_articles_list  td:nth-child(8) .tooltip-inner{min-width:388px;}
	#news_articles_list .tooltip-inner{max-width:none;};
	img.online{border:none;}
	
	.userBox {
border-left: 5px solid rgba(0, 0, 0, 0.15);
box-sizing: content-box;
overflow: hidden;
padding: 10px 10px 5px;
box-sizing: content-box;
margin-bottom: 10px;
margin-right: 10px;
margin-top: 10px;
}
	.returnInfo{
		border:1px solid white;
	}
	.c_green{
		border:1px solid #7DC27D;
	}
	.returnInfo:hover{
		cursor:pointer;
		border:1px solid #5D98CC;
	}
</style>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 
				微信
			<span>> 
				账户列表
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
					<h2>账户列表  </h2>
				</header>

				<!-- widget div-->
				<div>
			<div class="jarviswidget-editbox">
			</div>
			<div class="widget-body">
					<div class="col-sm-12 col-lg-12">
						<div class="well well-sm well-light">
							<table>
								<tr>
									<td class="col-md-6 col-lg-6 col-xs-6">
										<div class="icon-addon addon-md ">
											<input type="text" class="form-control" placeholder="例如：中科汇联"
												name="txtKeyword" id="txtKeyword"
												ng-model="keyWord">
											<label title="" rel="tooltip"
												class="glyphicon glyphicon-search"></label>
										</div>
									</td>
									<td class="col-md-6 col-xs-6 col-lg-6">
										<button type="button" class="btn btn-default"
											onclick="searchUser()">
											查 询
										</button>
										<button class="btn btn-info" id="weixinAccountAdd"
										onclick="addUser(-1)">微信添加</button>
									</td>
									
								</tr>
							</table>
						</div>
					</div>
					<div class="superbox col-sm-12 col-lg-12">
						<div id="divContent"></div>
						<div id="no-records" style="text-align:center;display:none;">
						<p class="text-center" style="padding: 20px;font-size: 14px;">没有找到记录</p>
						</div>
						<div class="text-right	 col-lg-12" id="pageInfo">
							<ul id="pager" class="pagination pagination-sm"></ul>
						</div>
					</div>
				</div>
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
<div id="weixin_account_add_dialog_div" style="display:none;"></div>
<div id="weixin_articles_dialog_div" style="display:none;"></div>

<script type="text/javascript" src="/resources/js/plugin/jquery-tmpl/jquery.tmpl.min.js"></script> 
<script type="text/javascript" src="/resources/js/bootstrap/bootstrap-paginator.min.js"></script>

<script id="myTemplate" type="text/x-jquery-tmpl"> 
<div class="userBox col-lg-3 col-sm-12 bg-color-lighten "
							>
							<div class="col-xs-3 col-sm-3 col-lg-3">
								<a target="_blank" href="javascript:;">
									<img  style="width: 50px;" src="{{html profileImageURL}}"> 
								</a>
							</div>
							<div class="col-xs-8 col-sm-8 col-lg-8">
								
								<ul class="list-unstyled">
									<li>
										<p >
											姓名：&nbsp;&nbsp;
											<a href="javascript:;" onclick="showArticles('{{html name}}')"><span>{{html name}}</span></a>
											<i class="W_icon {{user.verified=='1'?'w_v':'w_n'}}"></i>
										</p>
									</li>
									<li>
										<p title='{{= function_}}'>
											功能介绍：&nbsp;&nbsp;
{{if function_.length > 50}}
{{= function_.substr(0,50) }}...
{{/if}}
{{if function_.length < 50}}
{{= function_ }}										
{{/if}}											
										</p>
									</li>
								</ul>
							</div>
							<div class="col-xs-1 col-sm-1">
								<i class="botClose fa fa-times" style="top: 0px; right: 0px;"
									title="点击删除该用户" onclick="weixin_account_del(this,'{{html id}}')"></i>
							</div>
</div>
</script>

<script  id="myTemplate2" type="text/x-jquery-tmpl">
			<div class="returnInfo">
				<a class='url' href='{{html url}}'></a>
				<div class="col-sm-2 profile-pic">
					<img style="top: 0px;" class='profileImageURL' src="/image/wx/get?imageName={{html profileImageURL}}">
				</div>
				<div class="col-sm-10">
					<h1>
						<span class="semi-bold ng-binding name" >{{html name}}</span>
						<br>
						<small ng-show="true" class="ng-binding">
							</small>
					</h1>

					<ul class="list-unstyled">
						<li>
							<p class="text-muted ng-binding wxNo">
								{{html wxNo}}<i class="W_icon w_n"></i>
							</p>
						</li>
					</ul>
					<br/>
					<p title="" class="ng-binding">
						功能介绍：<span class="function_">{{html function_}}</span>
					</p>

				</div>
				<div style="clear:both;"></div>
			</div>
</script>

<script type="text/javascript">

	pageSetUp();
	/* remove previous elems */
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	var pageIndex = 1, pageSize = 10, pageCount = 0
	var container=$('#pager'); 
	var options = null;
	function getRuleList(index,params)
	{
		var query = "/weixin/getWeixinAccountPagedList?timeStamp="+new Date().getTime()+
			"&iDisplayLength=" +pageSize+
			"&iDisplayStart=" + (index-1) * pageSize;
		if(params){
			query = query+params;
		}
		pageIndex = index;
		$.ajax({
			dataType: "json",
			beforeSend:function(){
				$("#no-records").hide();
				loadingTip("正在加载中,请耐心等待...","#divContent");
			},
			type: "GET",
			url: query,
			success: showData
		});
	}
	var pagefunction = function() {
		getRuleList(pageIndex);
	}
	function cut_s(str){
		return str.substring(0,30);
	}
	function showData(data)
	{
		pageCount = Math.ceil( data.iTotalRecords/pageSize ),lists = data.aaData;
		if(pageCount>0)
		{
	   	  	options = {
	   	  		bootstrapMajorVersion:3,
	           	currentPage:pageIndex, 
	           	numberOfPages: 10, 
	           	totalPages:pageCount,
	           	itemTexts:function(type, page, current){
	           		  switch (type) {
			            case "first":
			                return "首页";
			            case "prev":
			                return "上一页";
			            case "next":
			                return "下一页";
			            case "last":
			                return "尾页";
			            case "page":
			                return page;
			           }
	           	}, 
	           	tooltipTitles: function (type, page, current) {
		            switch (type) {
		            case "first":
		                return "首页";
		            case "prev":
		                return "上一页";
		            case "next":
		                return "下一页";
		            case "last":
		                return "尾页";
		            case "page":
		                return (page === current) ? "当前页 " + page : "当前页 " + page;
		            }
	    		},
	    		size:"small",
	           	onPageClicked:null, 
	           	onPageChanged:function(e, oldPage, newPage){
	           		getRuleList(newPage);
	           	}
	        };
	        container.bootstrapPaginator(options);
		}
		$(".userBox").remove();
		
		$("#divContent").html("");
		if(lists.length==0){
			$("#no-records").show();
		}
		
		$('#pageInfo').before($('#myTemplate').tmpl(lists));
	
		loadingHide();
	}
	var checkoutForm ;
	function addUser(flag){
		var params = "";
		if(flag){
			params+="?edit=true&id="+flag;
		}
		loadingShow();
		$('#weixin_account_add_dialog_div').load("/weixin/weixin-account-add"+params,function(){
			var dialog = art.dialog({
					title: '微信账户添加',
					width: '900px',    // 内容宽度
					content: $("#weixin_account_add_dialog_div").html(),
					padding: '0px 0px',
					lock:true,
					button:[{
						  name:"<i id='i_save'></i>搜索",
						  callback:function(){
						  	loadingShow();
						  	submitBtnShow();
						  	if(checkoutForm.form()){
						  		$.ajax({
						  			url:'/weixin/getWeixinInfoFromWeb',
						  			type:'POST',
						  			data:{name:$("#frmWXAccountAdd #name").val()},
						  			dataType:'json',
						  			success:function(d){
						  				loadingHide();
						  				if(d&&d.weixinAccounts){
						  				$(".template2").html($('#myTemplate2').tmpl(d.weixinAccounts));
						  				$(".returnInfo:eq(0)").addClass("c_green");
						  				$(".returnInfo").click(function(i,ele){
											$(this).addClass("c_green").siblings().removeClass("c_green");;
										})
						  				}else{
						  					$(".template2").html("<span style='margin-left:10px;'>暂无数据</span>");
						  				}
						  			}
						  		});
						  	}
							return false;
						  }
					  },{
						name:"<i id='i_reset'></i>重新填写",
						    callback:function(){
						    	return false;
						  	}
					  },{
						    name:"<i id='i_sub'></i>提交",
						    callback:function(){
						    	if(checkoutForm.form()){
						    		var url = $(".c_green .url").attr("href").trim();
						    		var profileImageURL = $(".c_green .profileImageURL").attr("src").trim();
						    		var name = $(".c_green .name").text().trim();
						    		var wxNo = $(".c_green .wxNo").text().split("：")[1].trim();
						    		var function_ = $(".c_green .function_").text().trim();
						    		var dt = {url:url,profileImageURL:profileImageURL,name:name,wxNo:wxNo,function_:function_};
						    		try{ 
						    			$.ajax({
								  			url:'/weixin/fetchWeixinInfoFromVccoo',
								  			type:'POST',
								  			data:{name:name},
								  			dataType:'json',
								  			success:function(d){
								  				//loadingHide();
								  				//$(".template2").html($('#myTemplate2').tmpl(d));
								  			}
								  		})
							    		$.ajax({
								  			url:'/weixin/saveWeixinAccount',
								  			type:'POST',
								  			data:dt,
								  			dataType:'json',
								  			success:function(d){
								  				if(d.result>0){
													MessageBoxShow(d.msg,1);
													getRuleList(pageIndex);
												}else MessageBoxShow(d.msg);
								  			}
								  		});
							  		}catch (e){ 
										console.log(e.message); 
									} 
						  		}
						    	return false;
						  	}
					  },{
					    name:"取消",
					    callback:function(){
					  	}
					}],
					init: function () {
					   loadingHide();
					   changeArtdialogButtonCss();
					   checkoutForm = $('#frmWXAccountAdd').validate( {
							rules : {
								name : {
									required : true
								}
							},
							messages : {
								name : {
									required : '请输入微信账户名称'
								}
							},
							errorPlacement : function(error, element) {
								error.insertAfter(element.parent());
							}
						});
						
					$("#i_reset").parent().click(function(){
						resetInput();
					});
					$("#i_sub").parent().click(function(){
						submitWxAccount();
					});
				}
			});
			$(".aui_content").css("width","100%").css("height","100%");
		});
	}
	function submitBtnShow(ele){
		var i_save_prt = $("#i_save").parent();
		//var html = $('<button type="button" onclick="resetInput()" class="btn btn-default margin_L5">重新填写</button><button type="button" onclick="submitWxAccount()" class="btn btn-default margin_L5">提交</button>');
		//i_save_prt.before(html);
	}
	function resetInput(){
		$("#frmWXAccountAdd input[name='name']").val("");
		$(".template2").empty();
	}
	function submitWxAccount(){
		if(checkoutForm.form()){
			$("#frmWXAccountAdd").submit();
		}
	}
	function weixin_account_add(){
		$.ajax({
			url:'/weixin/saveWeixinAccount',
			type:'POST',
			data:$("#frmWBUserAdd").serialize(),
			dataType:'json',
			success:function(d){
				if(d.result>0){
					MessageBoxShow(d.msg,1);
					getRuleList(pageIndex);
				}else MessageBoxShow(d.msg);
			}
		})
	}
	function weixin_account_del(ele,id){
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
								url:'/weixin/delWeixinAccount?id='+id,
								type:'POST',
								data:$("#frmWBUserAdd").serialize(),
								dataType:'json',
								success:function(d){
									if(d.result>0){
										MessageBoxShow(d.msg,1);
										$(ele).parents(".userBox:eq(0)").remove();
									}else{ 
									MessageBoxShow(d.msg);
									}
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
	}
	var weixin_articles_dialog;
	function showArticles(name){
		loadingShow();
		$('#weixin_articles_dialog_div').load("/weixin/weixin-articles-dialog?weixinAccountName="+name,function(){
			weixin_articles_dialog = window.top.art.dialog({
					title: "微信文章",
					content: $("#weixin_articles_dialog_div")[0],
					width:"850px",
					padding: '0px 0px',
					top: '20%',
					lock:true
				});
			$(".aui_content").css("width","100%");
			weixin_articles_dialog.hide();
		});
	}
	function searchUser(){
		getRuleList(pageIndex,"&l_name="+$("#txtKeyword").val());
	}
	
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
