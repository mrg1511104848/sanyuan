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
</style>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 
				微博 
			<span>> 
				用户列表
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
					<h2>用户列表  </h2>
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
										<button class="btn btn-info" id="weiboUserAdd"
										onclick="addUser(-1)">微博添加</button>
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
<div id="weibo_user_add_dialog_div" style="display:none;"></div>
<div id="weibo_topics_dialog_div" style="display:none;margin-bottom:-6px;"></div>

<script type="text/javascript" src="/resources/js/plugin/jquery-tmpl/jquery.tmpl.min.js"></script> 
<script type="text/javascript" src="/resources/js/bootstrap/bootstrap-paginator.min.js"></script>

<script id="myTemplate" type="text/x-jquery-tmpl"> 

<div class="userBox col-lg-3 col-sm-12 bg-color-lighten "
							>
							<div class="col-xs-3 col-sm-3 col-lg-3">
								<a target="_blank" href="http://weibo.com/{{html weibo4jUserId}}" >
									<img  src="{{html profileImageURL}}"> 
								</a>
							</div>
							<div class="col-xs-8 col-sm-8 col-lg-8">
								
								<ul class="list-unstyled">
									<li>
										<p >
											<b>姓名：</b>&nbsp;&nbsp;
											<span><a href='javascript:;' onclick='showArticles("{{html name}}")'>{{html name}}</a></span>
											<i class="W_icon {{user.verified=='1'?'w_v':'w_n'}}"></i>
										</p>
									</li>
									<li>
										<p style="margin-bottom: 0px;">
											<b>粉丝数：</b>&nbsp;&nbsp; {{html followersCount}}&nbsp;
										</p>
									</li>
									<li>
										<p>
											<b>所在地：</b>&nbsp;&nbsp; {{html location}}
										</p>
									</li>
								</ul>
							</div>
							<div class="col-xs-1 col-sm-1">
								<i class="botClose fa fa-times" style="top: 0px; right: 0px;"
									title="点击删除该用户" onclick="weibo_user_del(this,'{{html id}}')"></i>
								<!--<i class="botClose fa fa-edit" style="top: 20px; right: 0px;"
									title="点击编辑该用户" onclick="addUser('{{html id}}')"></i>-->
							</div>
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
		var query = "/weibo/getWeiboUserPagedList?timeStamp="+new Date().getTime()+
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
		$('#weibo_user_add_dialog_div').load("/weibo/weibo-user-add"+params,function(){
			var dialog = art.dialog({
					title: '微博用户添加',
					width: '900px',    // 内容宽度
		 			height: 'auto',    // 内容高度
					content: $("#weibo_user_add_dialog_div").html(),
					padding: '0px 0px',
					lock:true,
					button:[{
						  name:"保存",
						  callback:function(){
						  	if(!$("#userName").val()){
								MessageBoxShow("请输入用户微博名称!");
								return false;
							}else if(!$("#u-info").is(":visible")){
								MessageBoxShow("用户信息填写有误!");
								return false;
							}
						  	weibo_user_add();
						  }
					  },{
					    name:'取消',
					    callback:function(){
					  	}
					}],
					init: function () {
					   changeArtdialogButtonCss();
					   checkoutForm = $('#frmWBUserAdd').validate( {
							rules : {
								userName : {
									required : true
								}
							},
							messages : {
								userName : {
									required : '请输入用户微博名称'
								}
							},
							errorPlacement : function(error, element) {
								error.insertAfter(element.parent());
							}
						});
					}
			});
		});
	}
	function weibo_user_add(){
		$.ajax({
			url:'/weibo/saveWeiboUser',
			type:'POST',
			data:$("#frmWBUserAdd").serialize(),
			dataType:'json',
			success:function(d){
				if(d.result>0){
					MessageBoxShow(d.msg,1);
					getRuleList(pageIndex);
					firstSaveWeiboInfo(d.name,d.id);
				}else MessageBoxShow(d.msg);
			}
		})
	}
	function firstSaveWeiboInfo(nm,id){
		$.ajax({
			url:'/weibo/firstSaveWeiboInfo',
			type:'POST',
			data:{"name":nm,"weiboUserId":id},
			dataType:'json',
			success:function(d){
			}
		})
	}
	function weibo_user_del(ele,id){
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
								url:'/weibo/delWeiboUser?id='+id,
								type:'POST',
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
	function searchUser(){
		getRuleList(pageIndex,"&l_name="+$("#txtKeyword").val());
	}
	/**
	* 点击查询 查看用户信息
	*/
	function getWeiboUserInfos(){
		if(!$("#userName").val().trim()){
			MessageBoxShow("请输入用户微博名称!");
			return;
		}
		$.ajax({
			dataType: "json",
			beforeSend:function(){
				$("#no-info").hide();
				$("#u-info").hide();
				loadingTip("正在加载中,请耐心等待...","#resultUserInfoLoading");
			},
			type: "post",
			data:{name:$("#userName").val().trim()},
			url: '/weibo/getWeiboUserInfos',
			success: function(d){
				$("#resultUserInfoLoading").html("");
				var weiboUser;
				if(d.result>0){
					weiboUser = d.weiboUser;
					$("#resultUserInfo #profileImageURL").attr("src",weiboUser.profileImageURL);
					$("#resultUserInfo #name").html(weiboUser.name);
					$("#resultUserInfo #followersCount").html(weiboUser.followersCount);
					$("#resultUserInfo #location").attr("src",weiboUser.location);
					$("#frmWBUserAdd input[name='profileImageURL']").val(weiboUser.profileImageURL);
					$("#frmWBUserAdd input[name='name']").val(weiboUser.name);
					$("#frmWBUserAdd input[name='followersCount']").val(weiboUser.followersCount);
					$("#frmWBUserAdd input[name='location']").val(weiboUser.location);
					$("#frmWBUserAdd input[name='sysUserId']").val(weiboUser.sysUserId);
					$("#frmWBUserAdd input[name='sysUserName']").val(weiboUser.sysUserName);
					$("#frmWBUserAdd input[name='weibo4jUserId']").val(weiboUser.weibo4jUserId);
					
					$("#u-info").show();
					MessageBoxShow(d.msg,1);
				}else{
					$("#no-info").show();
					MessageBoxShow(d.msg);
				}	
			}
		});
		
	}
	var weibo_topics_dialog;
	function showArticles(name){
		loadingShow();
		$('#weibo_topics_dialog_div').load("/weibo/weibo-topics-dialog?weiboUserName="+name,function(){
			weibo_topics_dialog = window.top.art.dialog({
					title: "微博文章",
					content: $("#weibo_topics_dialog_div")[0],
					width:"850px",
					padding: '0px 0px',
					lock:true
				});
			$(".aui_content").css("width","100%");
			weibo_topics_dialog.hide();
		});
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
