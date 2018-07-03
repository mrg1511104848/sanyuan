var public_html_text_rule_model_table;
var news_group_rule_requirement_list_table ;
function loadPublicHtmlTextRuleModelOnlySelect(){	
	commonLoadPublicHtmlTextRuleModelTable(true);
}

function commonLoadPublicHtmlTextRuleModelTable(isCopyOrExtends){//isSelect:是否是将要 复制或者继承
	if(public_html_text_rule_model_table!=null){
        	//$("#rule_list tbody tr").remove();
        public_html_text_rule_model_table.fnDestroy();
	}
	//-------------------------------
	var everyArticleSelectorPlaceHodler = $("#leftEditBox div[name='everyArticleSelector'] input").attr("placeholder");
	var everyArticleSelector;
	if(!(everyArticleSelectorPlaceHodler=='selector'||everyArticleSelectorPlaceHodler=='locator'||everyArticleSelectorPlaceHodler=='')){
		everyArticleSelector = everyArticleSelectorPlaceHodler;
	}else{
		everyArticleSelector = $("#leftEditBox div[name='everyArticleSelector'] input").val();
	}
	//-------------------------------
	var sectionUrlPlaceHodler = $("#leftEditBox div[name='sectionUrl'] input").attr("placeholder");
	var sectionUrl;
	if(!(sectionUrlPlaceHodler=='selector'||sectionUrlPlaceHodler=='locator'||sectionUrlPlaceHodler=='')){
		sectionUrl = sectionUrlPlaceHodler;
	}else{
		sectionUrl = $("#leftEditBox div[name='sectionUrl'] input").val();
	}
	//-------------------------------
	var listUrlParserMapKeyPlaceHodler = $("#leftEditBox div[name='listUrlParserMap'] input:eq(0)").attr("placeholder");
	var listUrlParserMapKey = $("#leftEditBox div[name='listUrlParserMap'] input:eq(0)").val();
	if(!(listUrlParserMapKeyPlaceHodler=='selector'||listUrlParserMapKeyPlaceHodler=='locator'||listUrlParserMapKeyPlaceHodler=='')){
		listUrlParserMapKey = listUrlParserMapKeyPlaceHodler;
	}else{
		listUrlParserMapKey = $("#leftEditBox div[name='listUrlParserMap'] input:eq(0)").val();
	}
	//-------------------------------
	var listUrlParserMapValuePlaceHodler = $("#leftEditBox div[name='listUrlParserMap'] input:eq(1)").attr("placeholder");
	var listUrlParserMapValue = $("#leftEditBox div[name='listUrlParserMap'] input:eq(1)").val();
	if(!(listUrlParserMapValuePlaceHodler=='selector'||listUrlParserMapValuePlaceHodler=='locator'||listUrlParserMapValuePlaceHodler=='')){
		listUrlParserMapValue = listUrlParserMapValuePlaceHodler;
	}else{
		listUrlParserMapValue = $("#leftEditBox div[name='listUrlParserMap'] input:eq(1)").val();
	}
	//-------------------------------
	var tmpListUrlParserMapKey = "listUrlParserMap["+listUrlParserMapKey+"]";
	
	//公共正文模板
    public_html_text_rule_model_table = $("#public_html_text_rule_model").dataTable({
		"bProcessing" : true,//加载数据时候是否显示进度条
		//"bServerSide" : true,//是否从服务加载数据 
		"sAjaxSource" : "/news/newsPublicRankTextRules?textDataType=2&"+tmpListUrlParserMapKey+"="+listUrlParserMapValue,//如果从服务器端加载数据,这个属性用于指定加载的路径 
		"fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {
	        var aoData = { "everyArticleSelector":everyArticleSelector,"sectionUrl":sectionUrl};  
	        oSettings.jqXHR = $.ajax( {
	            "dataType": 'json',
	            "type": "POST",
	            "url": sSource,
	            "data": aoData,
	            "success": fnCallback
	        } );
	    }, 
		"sPaginationType" : "full_numbers",
		"columns": [
            {"data": function ( row, type, set ){
            	return genHtmlByObject(row.name);
			}},
            {"sWidth" : "60px","data": function ( row, type, set ){
            	if(isCopyOrExtends){
            		return "<button class='btn btn-xs btn-default' text_model_id='"+row.id+"' title='点击复制'   onclick='copyPublicTextRuleModel(this)'><i class='glyphicon glyphicon-book'></i></button>&nbsp&nbsp"+
	            				"<button class='btn btn-xs btn-default' text_model_id='"+row.id+"' text_model_name='"+row.name+"' title='点击继承'  onclick='extendsPublicTextRuleModel(this)'><i class='glyphicon glyphicon-flag'></i></button>&nbsp&nbsp";
            	}else{
            		return "<button class='btn btn-xs btn-default' text_model_id='"+row.id+"' title='编辑'  onclick=\"editPublicTextRuleModel(this,'html')\"><i class='fa fa-pencil'></i></button>&nbsp&nbsp"+
			        	   "<button class='btn btn-xs btn-default'  title='删除' text_model_id='"+row.id+"' onclick=\"delPublicTextRuleModel(this,'html')\"><i class='fa fa-times'></i></button>";
            	}
		    }}
		],
		"oLanguage" : common_data_table_config.oLanguage,

		"fnInitComplete": function(oSettings, json) {
	    	loadingHide();
	    	dialogCenterScreen(public_html_text_rule_model_dialog);
			if(!isCopyOrExtends){
				var button_html = '	<a class="btn btn-primary" id="add_public_html_text_rule_model" onclick=\'toAddPublicTextRuleModel("html")\' style="float:right;" href="javascript:void(0);">添加公共正文模板</a>&nbsp;&nbsp;';
				$("#public_html_text_rule_model_wrapper .dt-toolbar>div:eq(1)").append($(button_html)).css("padding-right",0);
	    		$("#public_html_text_rule_model_wrapper .dt-toolbar").addClass("padding_B5");
			}
		},
		"sDom":common_data_table_config.searchSDom
    });
}
/**
复制正文模板
*/
function copyPublicTextRuleModel(ele){
	var publicTextRuleId = $(".aui_content #mainFrm div[name='publicTextRuleId'] input").val();
	console.log("8:51----------------------log----------------"+publicTextRuleId);
	if(publicTextRuleId){
		var extends_html = $(".aui_content #mainFrm a.extends_flag:eq(1)").attr("flag_title");
		var dialog = art.dialog({
			title: '取消继承确认',
			width: 'auto',    // 内容宽度
				height: 'auto',    // 内容高度
			content: "<div>您当前"+extends_html+"，您确认要取消继承吗?</div>",
			padding: '0px 0px',
			lock:true,
			button:[{
				  name:"<i class='fa  fa-play'></i>&nbsp; 保存",
				  callback:function(){
				  	$(".aui_content #mainFrm div[name='publicTextRuleId'] input").val("");
				  	$(".aui_content #mainFrm a.extends_flag:eq(1)").attr("title","当前无继承模板");
				  	$(".aui_content #mainFrm a.extends_flag:eq(1)").attr("flag_title","当前无继承模板");
					$(".aui_content #mainFrm a.extends_flag:eq(1)").css("color","#ccc").css("text-decoration","none");
				  	startToCopyPublicTextRuleModel(ele);
				  	//var r = updateToRule();
				  	//if(r){
				  		MessageBoxShow('复制成功!',true);
				  //	}
					//return false;
				  }
			  },{
			    name:'取消',
			    callback:function(){
			  	}
			  }],
			    init: function () {
			    	changeArtdialogButtonCss();
			    }
		});
	}else{
		startToCopyPublicTextRuleModel(ele);
		//MessageBoxShow('复制成功!',true);
	}
}

/**
开始复制正文模板
*/
function startToCopyPublicTextRuleModel(ele){
	var text_model_id = $(ele).attr("text_model_id");
	var url = "/news/editNewsPublicTextRule.html";
	$.ajax({
		url:url,
		type:'POST',
		data:{"id":text_model_id},
		beforeSend:function(){
			//这里是开始执行方法，显示效果
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
		},
		success:function(data){
			commonCopyPublicTextRuleModel(data);
	}
	});
	MessageBoxShow('复制成功!',true);
	return false;
}

function commonCopyPublicTextRuleModel(data,type){
	data = 	eval('('+data+')');
			commonCopyPublicRuleModel(data,type);
			var textAdditionalParserMapKeys = getKey(data.textAdditionalParserMap);
			var textAdditionalParserMapValues = getValue(data.textAdditionalParserMap);
			console.log(textAdditionalParserMapKeys);
			$(".textAdditionalParserMap").remove();
			for(var i = 0 ; i < textAdditionalParserMapKeys.length; i++){
				console.log("当前----->"+textAdditionalParserMapKeys[i]);
					var str = ' <div class="form-group textAdditionalParserMap" name="textAdditionalParserMap">	'+
					 ' <label class="control-label col-md-2">	';
					 var addStr = '<a href="javascript:;" class="btn btn-primary btn-circle" onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>';
					 var minusStr = '<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>';
					 var minusOrAddStr = '';
					 if(i<1){
					 	str+="其他";
					 	minusOrAddStr=addStr;
					 }else{
					 	minusOrAddStr=minusStr;
					 }
					 if(type=="extends"){
						 str+=' </label>	'+
						 ' <div class="col-md-2">	'+
						 ' 	<input class="form-control" placeholder="" type="text" value="">	'+
						 ' </div>	'+
						 ' 	<div class="col-md-3">	'+
						 ' 		<input class="form-control" placeholder="" type="text" value="">	'+
						 ' 	</div>	'+
						 ' 	<div class="col-md-3">	'+
						 ' 		<input class="form-control" placeholder="" type="text" value="">	'+
						 ' 	</div>	'+
						 ' 	<div class="col-md-2">	'+
						 minusOrAddStr+
						 ' 	</div>	'+
						 ' </div>	';
					 }else{
					 	str+=' </label>	'+
						 ' <div class="col-md-2">	'+
						 ' 	<input class="form-control" placeholder="selector" type="text" value="">	'+
						 ' </div>	'+
						 ' 	<div class="col-md-3">	'+
						 ' 		<input class="form-control" placeholder="locator" type="text" value="">	'+
						 ' 	</div>	'+
						 ' 	<div class="col-md-3">	'+
						 ' 		<input class="form-control" placeholder="locator" type="text" value="">	'+
						 ' 	</div>	'+
						 
						 ' 	<div class="col-md-2">	'+
						 minusOrAddStr+
						 ' 	</div>	'+
						 ' </div>	';
					 }
					 if(i<1){
					 	$("div.other:eq(1)").after($(str));
					 }else{
					 	$(".textAdditionalParserMap:last").after($(str));
					 }
					 if(type=="extends"){
						 $(".textAdditionalParserMap:last").find("input:eq(0)").attr("placeholder",textAdditionalParserMapKeys[i]+"");
						 $(".textAdditionalParserMap:last").find("input:eq(1)").attr("placeholder",getKey(textAdditionalParserMapValues[i]));
						 $(".textAdditionalParserMap:last").find("input:eq(2)").attr("placeholder",getValue(textAdditionalParserMapValues[i]));
					 }else{
						 $(".textAdditionalParserMap:last").find("input:eq(0)").val(textAdditionalParserMapKeys[i]+"");
						 $(".textAdditionalParserMap:last").find("input:eq(1)").val(getKey(textAdditionalParserMapValues[i]));
						 $(".textAdditionalParserMap:last").find("input:eq(2)").val(getValue(textAdditionalParserMapValues[i]));
					 }
			}
}


function commonCopyPublicRuleModel(data,type){
	
	var mainFrm = $("#mainFrm");
			for(var key in data){
				console.log("---------------------"+key);
					if(typeof(data[key])=="object"){
						
						if(key!="textAdditionalParserMap"&&key!="listAdditionalParserMap"){
							//console.log("--------start-----"+key+"-----------");
							$(".tem_copy_flag").removeClass("tem_copy_flag");
							//console.log(data[key]);
							var tem_dataKey = data[key];
							var keys = getKey(data[key]);
							//console.log("hehehe"+tem_dataKey);
								var values = getValue(tem_dataKey);
								for(var i = 0 ; i < keys.length; i++){
									console.log("this----->  key="+keys[i]+"   value="+values[i]);
									var old = mainFrm.find("div[name='"+key+"']:first");
									var copyd = old.clone();
									copyd.find("input:eq(0)").attr("placeholder","");
									copyd.find("input:eq(1)").attr("placeholder","");
									if(type=="extends"){
										copyd.find("input:eq(0)").attr("placeholder",keys[i]);
										copyd.find("input:eq(1)").attr("placeholder",values[i]);
										copyd.find("input:eq(0)").val("");
										copyd.find("input:eq(1)").val("");
									}else{
										copyd.find("input:eq(0)").val(keys[i]);
										copyd.find("input:eq(1)").val(values[i]);
									}
									
									if(i==0){
										old.after(copyd);
									}else{
										mainFrm.find("div[name='"+key+"']:last").after(copyd);
										copyd.find("label:first").empty();
									}
									copyd.addClass("tem_copy_flag");
								}
								
								if(keys.length>0){
									$("div[name='"+key+"']").not(".tem_copy_flag").remove();
								}else{
									$("div[name='"+key+"']:gt(0)").remove();
									$("div[name='"+key+"'] input").val("");
								}
							//console.log("--------end----------------");
						}
					}else if(((typeof(data[key])=="string"||typeof(data[key])=="number"))&&mainFrm.find("div[name='"+key+"']").css("display")!="none"){
						//console.log("-----str---start----------------");
						if(key!="id"){
							mainFrm.find("div[name='"+key+"'] input:eq(0)").attr("placeholder","");
							if(type=="extends"){
								mainFrm.find("div[name='"+key+"'] input:eq(0)").attr("placeholder",data[key]);
								mainFrm.find("div[name='"+key+"'] input:eq(0)").val("");
							}else{
								mainFrm.find("div[name='"+key+"'] input:eq(0)").val(data[key]);
							}
							
						}
						//console.log("-----str---end----------------");
					}
	}
}


function extendsPublicListRuleModel(ele){
	var id = $("div[name='id'] input").attr("value");
	//if(!id) {art.dialog.tips('请保存后再继承，或直接使用复制!');return false;}
	var list_model_id = $(ele).attr("list_model_id");
	var list_model_name = $(ele).attr("list_model_name");
	$("#mainFrm div[name='publicListRuleId'] input").val(list_model_id);
	//var r = updateToRule();
	//if(r){
		$("#mainFrm a.extends_flag:eq(0)").attr("title","继承模板【"+list_model_name+"】,点击取消继承");
		$("#mainFrm a.extends_flag:eq(0)").attr("flag_title","继承模板【"+list_model_name+"】");
		$("#mainFrm a.extends_flag:eq(0)").css("color","#3276b1").css("text-decoration","none");
	//	art.dialog.tips('继承成功!请记得保存哦');
		MessageBoxShow('继承成功!请记得保存哦');
	//}
	var url = "/news/editNewsPublicListRule.html";
	$.ajax({
		url:url,
		type:'POST',
		data:{"id":list_model_id},
		beforeSend:function(){
			//这里是开始执行方法，显示效果
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
		},
		success:function(data){
			
			commonCopyPublicListRuleModel(data,"extends");
		}
	});
	
	return false;
}

function commonCopyPublicListRuleModel(data,type){
	data=eval("("+data+")");//转换为json对象
	var fetch_strategy = data.fetchStrategy?data.fetchStrategy:1;
	if(type!="extends"){
		$("div[name='fetchStrategy'] input").attr("value",fetch_strategy);
		$("div[name='fetchStrategy'] input").val(fetch_strategy);
	}else{
		$("div[name='fetchStrategy'] input").attr("value","");
		$("div[name='fetchStrategy'] input").val("");
		$("div[name='fetchStrategy'] input").attr("placeholder",fetch_strategy);
	}
	$("input[name='radio-fetch-strategy']").each(function(){
		console.log($(this).attr("t_value")+"===="+fetch_strategy);
		if($(this).attr("t_value")==fetch_strategy){
			$(this).prop("checked",true);
			//$(this)[0].checked = true;
		}else{
			$(this).prop("disabled",false);
		}
	});
	$("input[name='radio-fetch-strategy2']").each(function(){
		console.log($(this).attr("t_value")+"===="+fetch_strategy);
		if($(this).attr("t_value")==fetch_strategy){
			$(this).prop("checked",true);
		}else{
			$(this).prop("disabled",false);
		}
	});
	
	commonCopyPublicRuleModel(data,type);
	var listAdditionalParserMapKeys = getKey(data.listAdditionalParserMap);
	var listAdditionalParserMapValues = getValue(data.listAdditionalParserMap);
	console.log(listAdditionalParserMapKeys.length);
	$(".listAdditionalParserMap").remove();
	for(var i = 0 ; i < listAdditionalParserMapKeys.length; i++){
			var str = ' <div class="form-group listAdditionalParserMap" name="listAdditionalParserMap">	'+
			 ' <label class="control-label col-md-2">	';
			 if(i<1){
			 	str+="其他";
			 }
			 if(type=="extends"){
			 	str+=' </label>	'+
				 ' <div class="col-md-2">	'+
				 ' 	<input class="form-control" placeholder="" type="text" value="">	'+
				 ' </div>	'+
				 ' 	<div class="col-md-3">	'+
				 ' 		<input class="form-control" placeholder="" type="text" value="">	'+
				 ' 	</div>	'+
				 ' 	<div class="col-md-3">	'+
				 ' 		<input class="form-control" placeholder="" type="text" value="">	'+
				 ' 	</div>	'+
				 ' 	<div class="col-md-2">	'+
				 ' 		<a href="javascript:;" class="btn btn-primary btn-circle" onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>	'+
				 ' 	</div>	'+
				 ' </div>	';
			 }else{
			 	str+=' </label>	'+
				 ' <div class="col-md-2">	'+
				 ' 	<input class="form-control" placeholder="selector" type="text" value="">	'+
				 ' </div>	'+
				 ' 	<div class="col-md-3">	'+
				 ' 		<input class="form-control" placeholder="locator" type="text" value="">	'+
				 ' 	</div>	'+
				 ' 	<div class="col-md-3">	'+
				 ' 		<input class="form-control" placeholder="locator" type="text" value="">	'+
				 ' 	</div>	'+
				 ' 	<div class="col-md-2">	'+
				 ' 		<a href="javascript:;" class="btn btn-primary btn-circle" onclick="addNewRow(this,2)"><i class="fa fa-plus"></i></a>	'+
				 ' 	</div>	'+
				 ' </div>	';
			 }
			 if(i<1){
			 	$("div.other:eq(0)").after($(str));
			 }else{
			 	$(".listAdditionalParserMap:last").after($(str));
			 }
			 if(type=="extends"){
				 $(".listAdditionalParserMap:last").find("input:eq(0)").attr("placeholder",listAdditionalParserMapKeys[i]+"");
				 $(".listAdditionalParserMap:last").find("input:eq(1)").attr("placeholder",getKey(listAdditionalParserMapValues[i]));
				 $(".listAdditionalParserMap:last").find("input:eq(2)").attr("placeholder",getValue(listAdditionalParserMapValues[i]));
			 }else{
				 $(".listAdditionalParserMap:last").find("input:eq(0)").val(listAdditionalParserMapKeys[i]);
				 $(".listAdditionalParserMap:last").find("input:eq(1)").val(getKey(listAdditionalParserMapValues[i]));
				 $(".listAdditionalParserMap:last").find("input:eq(2)").val(getValue(listAdditionalParserMapValues[i]));
			 }
	}
}

/**
** 继承正文模板
*/
function extendsPublicTextRuleModel(ele){
	var id = $("div[name='id'] input").attr("value");
	//if(!id) {art.dialog.tips('请保存后再继承，或直接使用复制!');return false;}
	var text_model_id = $(ele).attr("text_model_id");
	var text_model_name = $(ele).attr("text_model_name");
	$("#mainFrm div[name='publicTextRuleId'] input").val(text_model_id);
	//var r = updateToRule();
	//if(r){
		$("#mainFrm a.extends_flag:eq(1)").attr("title","继承模板【"+text_model_name+"】,点击取消继承");
		$("#mainFrm a.extends_flag:eq(1)").attr("flag_title","继承模板【"+text_model_name+"】");
		$("#mainFrm a.extends_flag:eq(1)").css("color","#3276b1").css("text-decoration","none");
		//art.dialog.tips('继承成功!请记得保存哦');
		MessageBoxShow('继承成功!请记得保存哦');
	//}
	var url = "/news/editNewsPublicTextRule.html";
	$.ajax({
		url:url,
		type:'POST',
		data:{"id":text_model_id},
		beforeSend:function(){
			//这里是开始执行方法，显示效果
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
		},
		success:function(data){
			console.log("over");
			console.log("11:54"+data);
			commonCopyPublicTextRuleModel(data,"extends");
		}
	});
}
var newsGroupRuledialog;
function addOrEditNewsGroupRuleRequirement(id,lookOnlyFlag){
	loadingShow();
	$('#group-rule-boxs').load("/newsGroupRule/editNewsGroupRuleRequirement?eq_id="+id+"&lookOnly="+lookOnlyFlag,function(){
	    newsGroupRuledialog = window.top.art.dialog({
			title: "详情",
			content: $("#group-rule-boxs")[0],
			width:"850px",
			lock:true
		});
		$(".aui_content").css("width","100%");
		loadingHide();
		dialogCenterScreen(newsGroupRuledialog);
	});
	$("#group-rule-boxs").html("");
}
function closeDialog(){
	newsGroupRuledialog.close();
}

var newsGroupRuleRequirementdialog;
function addOrEditNewsGroupRule(ele,id,lookOnlyFlag){
	$("#click_user_id").attr("user_id",$(ele).attr("user_id"));
	loadingShow();
	$('#group-rule-boxs').load("/newsGroupRule/editNewsGroupRuleRequirement?eq_id="+id+"&lookOnly="+lookOnlyFlag,function(){
	    newsGroupRuleRequirementdialog = window.top.art.dialog({
			title: "详情",
			content: $("#group-rule-boxs")[0],
			width:"850px",
			lock:true
		});
		$(".aui_content").css("width","100%");
		loadingHide();
		dialogCenterScreen(newsGroupRuleRequirementdialog);
	});
	
	$("#group-rule-boxs").html("");
}
function closeRequirementDialog(){
	if(newsGroupRuleRequirementdialog) newsGroupRuleRequirementdialog.close();
	if(newsGroupRuledialog) newsGroupRuledialog.close();
}

function initNewsGroupRuleRequirementListTableButton(){
	$("#news_group_rule_requirement_list__wrapper .dt-toolbar").css("border","none").css("padding","0px");
	var eq_state = '<select  name="eq_state" class="form-control margin_R5">'+
						'<option value="">所有</option>'+
						'<option value="0">未审核</option>'+
						'<option value="1">已通过</option>'+
						'<option value="2">被驳回</option>'+
						'</select>';
	var l_userName = '<input type="text" name="l_userName" class="form-control ng-valid ng-dirty margin_R5" placeholder="用户名">';					
	var l_section = '<input type="text" name="l_section" class="form-control ng-valid ng-dirty margin_R5" placeholder="页面名称">';
	var search_btn = '<button type="button" class="btn btn-default marginR5" onclick="searchRequirement()">查 询</button>';
	$("#news_group_rule_requirement_list__wrapper .dt-toolbar div:eq(0)").append(eq_state).append(l_userName).append(l_section).append(search_btn);
}
function searchRequirement(){
	var url = "/newsGroupRule/getNewsGroupRuleRequirementList";
	var eq_state = $("select[name='eq_state']").val();
	var l_section = $("input[name='l_section']").val();
	var l_userName = $("input[name='l_userName']").val();
	
	var params = {"eq_state":eq_state,"l_section":l_section,"l_userName":l_userName};
	url = addQueryParams(url,params);
	news_group_rule_requirement_list_table.fnSettings().sAjaxSource=url;
	news_group_rule_requirement_list_table.fnDraw(); //重新加载数据
}
function toRequirement(state,userId,userName){
	var url = "/newsGroupRule/getNewsGroupRuleRequirementList";
	var params = {"eq_state":state,"eq_userId":userId};
	url = addQueryParams(url,params);
	console.log(url);
	news_group_rule_requirement_list_table.fnSettings().sAjaxSource=url;
	news_group_rule_requirement_list_table.fnDraw(); //重新加载数据
	$('a[data-toggle="tab"]').trigger("click");
	$("select[name=eq_state]").val(state);
	$("input[name=l_userName]").val(userName);
}

//根据规则创建参数------结束----------------------------
function loadNewsGroupRuleRequirementTable(){
	news_group_rule_requirement_list_table = $("#news_group_rule_requirement_list_").dataTable({
		"bProcessing" : true,//加载数据时候是否显示进度条
		"bServerSide" : true,//是否从服务加载数据 
		"sAjaxSource" : "/newsGroupRule/getNewsGroupRuleRequirementList",//如果从服务器端加载数据,这个属性用于指定加载的路径 
		"sPaginationType" : "full_numbers",
		"bSort":false,
		"columns": [
			{"data": function ( row, type, set ){
			    return row.userName;
			}},
            {"data": function ( row, type, set ){
			        return row.groupName;
		    }},
		    {"data": function ( row, type, set ){
		    	 return '<a target="blank_" href="'+row.sectionUrl+'" title="'+row.section+'">'+cut_str(row.section, 15,"...")+'</a>';
	    	}},
	        {"data": function ( row, type, set ){
	    		return '<a target="blank_" href="'+row.sectionUrl+'" title="'+row.sectionUrl+'">'+cut_str(row.sectionUrl, 30,"...")+'</a>';
	        }},
	        {"data": function ( row, type, set ){
		        if(row.state==0){
			        return"未审核&nbsp;<i class='glyphicon glyphicon-minus txt-color-blueLight'></i>";
			    }else if(row.state==1){
			    	return"已通过&nbsp;<i class='glyphicon glyphicon-ok txt-color-green'></i>";
				}else if(row.state==2){
					return"被驳回&nbsp;<i class='glyphicon glyphicon-remove txt-color-red'></i>";
				}
	    		return row.state;
	        }},
	        {"data": function ( row, type, set ){
	            return row.insertTime;
	        }},
	        {"data": function ( row, type, set ){
	        	var id = row.id;
	        	var readOnly = true;
	        	if(row.state==0||row.state==2){
	        		readOnly = false;
		        }
		        //"<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRuleRequirement(\""+id+"\",true)'><i class='fa fa-eye'></i></button>&nbsp&nbsp"
	        	var adminBtns = "<button onclick='addOrEditNewsGroupRuleRequirement(\""+id+"\","+readOnly+")'  class='lookDataForThis btn btn-xs btn-default' news_group_rule_id='"+id+"' rule_id='"+row.ruleId+"' group_id='"+row.groupId+"' title='查看数据'><i class='fa fa-search'></i></button>"
				
				var notAdminBtns_pass = "<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRuleRequirement(\""+id+"\","+readOnly+")'><i class='fa fa-search'></i></button>";
				var notAdminBtns_notPass = "<button class='addOrEditNewsGroupRule btn btn-xs btn-default' id='"+id+"' title='查看' onclick='addOrEditNewsGroupRuleRequirement(\""+id+"\","+readOnly+")'><i class='fa fa-search'></i></button>"
				+ "<button class='delAll btn btn-xs btn-default'  title='删除' site_id='"+ id
				+ "' onclick='deleteRequirementPageRule(\""+id+"\")'><i class='fa fa-times'></i></button>";
				if(row.state==2){
					return adminBtns
					+ "&nbsp;<button class='delAll btn btn-xs btn-default'  title='删除' site_id='"+ id
					+ "' onclick='deleteRequirementPageRule(\""+id+"\")'><i class='fa fa-times'></i></button>";
				}
	        	if(row.tempAdminFlag){
		        	return adminBtns;
		        }else{
			        if(row.state==1){
						return notAdminBtns_pass;
			        }else {
				        return notAdminBtns_notPass;
			        }
		        }
	        }}
		],
		"oLanguage" : { //主要用于设置各种提示文本
			"sProcessing" : "<a href=\"javascript:void(0);\" class=\"bg-color-white txt-color-teal\"><i class=\"fa fa-gear fa-3x fa-spin\"></i></a>&nbsp;&nbsp;&nbsp;正在处理...", //设置进度条显示文本
			"sEmptyTable" : "没有找到记录",//没有记录时显示的文本
			"sZeroRecords" : "没有找到记录",//没有记录时显示的文本
			"sInfo" : "总数<span class='text-primary'>_TOTAL_</span>显示<span class='txt-color-darken'>_START_</span>至<span class='txt-color-darken'>_END_</span>",
			"sInfoEmpty" : "",//没记录时,关于记录数的显示文本
			"oPaginate" : {
				"sFirst" : "首页",
				"sLast" : "未页",
				"sNext" : "下页",
				"sPrevious" : "上页"
			}
		},
		"fnInitComplete": function(oSettings, json) {
			$("#news_group_rule_requirement_list__wrapper .dt-toolbar").append("<span style='display:none' id='click_user_id'></span>");
			$("#news_group_rule_requirement_list__wrapper .dt-toolbar").css("margin-bottom","5px");
			initNewsGroupRuleRequirementListTableButton();
	     },
	     "sDom": "<'dt-toolbar'<'col-xs-8 tools-bar'><'col-xs-4'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>"
    });
}

function startAudit(){
	$('#audit-boxs').load("/newsGroupRule/startAudit",function(){
		loadRuleDialog();
	});
}
var shenHeDialog;
function loadRuleDialog(){
	//console.log($("#rule_dialog_div").html());
		var section = $("#group-rule-boxs div[name='section'] input").val();
		var sectionUrl = $("#group-rule-boxs div[name='sectionUrl'] input").val();
		$("#leftEditBox div[name='section'] input").val(section);
		$("#leftEditBox div[name='sectionUrl'] input").val(sectionUrl);
		
		var left = 541/2+"px";
		var top = 570/2+"px";
		var screen_width = $(document).width();
		$(".fatch_processing").css({"position":"absolute","top":top,"left":left});
		shenHeDialog = art.dialog({
					id:"rule_dialog",
				    title: '需求审核',
				    width: screen_width,    // 内容宽度
	 				height: 'auto',    // 内容高度
				    content: $("#audit-boxs")[0],
				    padding: '0px 0px',
				    lock:true,
				    button:[{
				    	name:'测试',
				    	callback:function(){
							getListPageInfo();
							return false;
						}
				    },{
				    	name:"通过",
				    	callback:function(){
				    		auditPass();
				    		return false;
				    	}
				    }
				    ],
				    init: function () {
				    	changeArtdialogButtonCss();
				    }
			});
		$(".aui_content").css("width","100%");
}




function loadPublicHtmlListRuleModel(){
	commonLoadPublicHtmlListRuleModelTable();
}

function loadPublicHtmlListRuleModelOnlySelect(){
	commonLoadPublicHtmlListRuleModelTable(true);
}
var public_html_list_rule_model_table = null;
function commonLoadPublicHtmlListRuleModelTable(isCopyOrExtends){//isSelect:是否是将要 复制或者继承
	if(public_html_list_rule_model_table!=null){
        	//$("#rule_list tbody tr").remove();
        	public_html_list_rule_model_table.fnDestroy();
	}
	var sectionUrl = $("div[name='sectionUrl'] input").val();
	public_html_list_rule_model_table = $("#public_html_list_rule_model").dataTable({
			"bProcessing" : true,//加载数据时候是否显示进度条
			//"bServerSide" : true,//是否从服务加载数据 
			"sAjaxSource" : "/news/newsPublicRankListRules?listDataType=2",//如果从服务器端加载数据,这个属性用于指定加载的路径
			"fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {

		        aoData.push( { "name": "sectionUrl", "value": sectionUrl } );      

		        oSettings.jqXHR = $.ajax( {
		            "dataType": 'json',
		            "type": "POST",
		            "url": sSource,
		            "data": aoData,
		            "success": fnCallback
		        } );
		    }, 
			"sPaginationType" : "full_numbers",
			"columns": [
	            {"data": function ( row, type, set ){
	            	return genHtmlByObject(row.name);
			    }},
	            {"data": function ( row, type, set ){
	            	if(isCopyOrExtends){//yes
	            		return "<button class='btn btn-xs btn-default' list_model_id='"+row.id+"' title='点击复制'   onclick='copyPublicListRuleModel(this)'><i class='glyphicon glyphicon-book'></i></button>&nbsp&nbsp"+
	            				"<button class='btn btn-xs btn-default' list_model_id='"+row.id+"' list_model_name='"+row.name+"' title='点击继承'  onclick='extendsPublicListRuleModel(this)'><i class='glyphicon glyphicon-flag'></i></button>&nbsp&nbsp";
	            	}else{
	            		return "<button class='btn btn-xs btn-default' list_model_id='"+row.id+"' title='编辑'  onclick=\"editPublicListRuleModel(this,'html')\"><i class='fa fa-pencil'></i></button>&nbsp&nbsp"+
				        	   "<button class='btn btn-xs btn-default'  title='删除' list_model_id='"+row.id+"' onclick=\"delPublicListRuleModel(this,'html')\"><i class='fa fa-times'></i></button>";
	            	}
	            		
			    }}
			],
			"oLanguage" : common_data_table_config.oLanguage,
			"fnInitComplete": function(oSettings, json) {
		    	loadingHide();
		    	dialogCenterScreen(public_html_list_rule_model_dialog);
				if(!isCopyOrExtends){
					var left_button_html = '<input type="text" name="l_name" class="form-control ng-valid ng-dirty margin_R5" placeholder="自定义名称"/>'+
										   '<a class="btn btn-default">查询 </a>';
					
					//$("#public_html_list_rule_model_wrapper .dt-toolbar>div:eq(0)").append($(left_button_html));
					
					var button_html = '	<a class="btn btn-primary" id="add_public_html_list_rule_model" onclick=\'toAddPublicListRuleModel("html")\' style="float:right;" href="javascript:void(0);">添加公共列表模板</a>&nbsp;&nbsp;';
		    		$("#public_html_list_rule_model_wrapper .dt-toolbar>div:eq(1)").append($(button_html)).css("padding-right",0);
		    		$("#public_html_list_rule_model_wrapper .dt-toolbar").addClass("padding_B5");
				}
		     },
		     "sDom":common_data_table_config.searchSDom
	    });
}
function tableSearch(listUrl,fromParam){
	var params = {};
	if(fromParam){
		var eles = fromParam.split('|');
		for(var i = 0 ; i < eles.length; i++){
			var eleParts = eles[i].split('@');
			var eleType = eleParts[0];
			var eleName = eleParts[1];
			var eleVal =  $('[name='+eleName+']').val();
			params[eleName]=eleVal;
		}
	}
	var url = addQueryParams(listUrl,params);
	public_html_list_rule_model_table.fnSettings().sAjaxSource=url;
	public_html_list_rule_model_table.fnDraw(); //重新加载数据
}


/**
** 获取根据规则进行过滤的列表
*/
function getListPageInfo(isAll){
	var assignPage = "";
	if(isAll==1){
		assignPage = "?assignPage=1";
	}
	var url = "/news/getListPageInfo"+assignPage;
	$.ajax({
		url:url,
		type:'POST',
		data:buildFormData("#leftEditBox"),
		beforeSend:function(){
			//这里是开始执行方法，显示效果
			$("#rule_list_fieldset").hide();
			$(".fatch_processing").show();
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
			$(".fatch_processing").hide();
			$("#rule_list_fieldset").show();
		},
		success:function(data){
			data=eval("("+data+")");//转换为json对象
			var nodata = "无";
			var strs = "";
		    for(var i = 0 ; i < data.length;i++){
		    	var id = data[i].id;
		    	var title = data[i].title?data[i].title:nodata;
		    	var url = data[i].url;
		    	var realUrl = data[i].realUrl;
		    	var short_url = "";
		    	var time = data[i].time?data[i].time:nodata;
		    	var originTime = data[i].originTime;
		    	var additionalAttribute = data[i].additionalAttribute?data[i].additionalAttribute:nodata;
		    	var additionalAttributeStr = "";
		    	if(url){
			    	if(url.length>80){
			    		short_url = url.substring(0,80)+"...";
				    }else{
				    	short_url = url;
					}
			    }
		    	if(additionalAttribute){
		    		additionalAttributeStr = obj2str(additionalAttribute); 
		    	}
		    	if(id){
		    		var page = id.split(":")[1];
		    		strs+='<div style="font-size: 31px;text-align: center;">第'+page+'页</div>'+
		    			  ' <legend></legend>';
		    	}else{
			    	var titleStr = '  <div><b>标题</b>:<a target="blank_" href='+url+'>'+title+'</a></div>';
			    	if(realUrl){
			    		titleStr = '  <div><b>标题</b>:<a target="blank_" href='+realUrl+'>'+title+'</a></div>';
				    }
		    		strs+=titleStr+
					    ' <div style="width:100%;"><b>URL</b>:<span title="'+url+'">'+short_url+'</span></div>'+
					    ' <div><b>原始时间</b>:'+originTime+'</div>'+
					    ' <div><b>时间</b>:'+time+'</div>'+
					    ' <div><b>列表页额外字段</b>:'+additionalAttributeStr+'</div>'+
					    ' <div>'+
					    ' 	<a class="btn btn-primary btn-xs" to-url="'+url+'" href="javascript:void(0);" onclick="testContent(this)" style="display: block;width: 80px;margin:10px 0;"><i class="fa  fa-play"></i>测试内容</a>'+
					    ' 	<span class="test-content-progress" style="display:none;">'+
						'     	<a href="javascript:void(0);" class="bg-color-white txt-color-teal test_content" ><i class="fa fa-gear fa-2x fa-spin"></i>'+
						'		</a>&nbsp;&nbsp;&nbsp;正在处理...'+
						'	</span>'+
						'	<div class="fetch-content" style="display:none;">'+
						'	</div>'+
					    ' </div>'+
					    ' <legend></legend>';
		    	}
		    	
		    }
		    //console.log(strs);
		    $("#rule_list_fieldset div:eq(0)").html(strs);
		}
	})
}




//根据规则创建参数------开始----------------------------
function buildFormData(eleClass){
	if(!eleClass){
		eleClass='';
	}
	var formData = {};
	$(eleClass+" div.form-group").each(function(){
		var key = $(this).attr("name");
		var elements = $(this).find("div>input");
		if(elements.length==1){
			var value0 = elements.attr("placeholder");
			if(value0=="selector"||value0=="locator"){
				value0 = "";
			}
			var value= elements.val().trim()==""?value0:elements.val().trim();
			
			if(value!=""||key=="id"){
				formData[key]=value;
			}
		}else if(elements.length>1&&elements.length<3){
			var innerFormData = {};
			elements.each(function(i){
				if(i%2==0){
					var value0 = $(this).attr("placeholder");
					if(value0=="selector"||value0=="locator"){
						value0 = "";
					}
					var thisVal = $(this).val().trim()==""?value0:$(this).val().trim();
					
					var value1 = $(elements[i+1]).attr("placeholder");
					if(value1=="selector"||value1=="locator"){
						value1 = "";
					}
					var elei1Val = $(elements[i+1]).val().trim()==""?value1:$(elements[i+1]).val().trim();
					//elei1Val = elei1Val.replace(/\s/g,'nbsp;')
					//elei1Val = elei1Val.replace(" ", "&nbsp;");
					if(thisVal!=""&&elei1Val!=""){
						//当方括号：[] 出现在json的key中时，aaa[d[h=t]g]=vvv 这种写法的时候 会有一些小问题 右闭合部分会丢失 所以这里转义下 展示的时候 在java后端再反转义下
						innerFormData[thisVal.replace("[","@iamapresb@").replace("]","@iamarearsb@")]=elei1Val;
					}
				}
			});
			if(formData.hasOwnProperty(key)){
				var obj = formData[key];
				var props = "";
				for(var p in obj){   
				    // 方法  
				    if(typeof(obj[p])=="function"){   
				        //obj[p]();  
				    }else{   
				        // p 为属性名称，obj[p]为对应属性的值  
				        innerFormData[p+""] = obj[p];
				        //props += p + "=" + obj[p] + ";  ";  
				    }   
				}
			}
			formData[key]=innerFormData;
		}else if(elements.length>2&&elements.length<4){
			var innerFormData = {};
			
			var ele = elements[0];
			var value0 = $(ele).attr("placeholder");
			if(value0=="selector"||value0=="locator"){
				value0 = "";
			}
			var eleVal = $(ele).val().trim()==""?value0:$(ele).val().trim();
			
			var ele1 = elements[1];
			var value1 = $(ele1).attr("placeholder");
			if(value1=="selector"||value1=="locator"){
				value1 = "";
			}
			var ele1Val = $(ele1).val().trim()==""?value1:$(ele1).val().trim();
			
			var ele2 = elements[2];
			var value2 = $(ele2).attr("placeholder");
			if(value2=="selector"||value2=="locator"){
				value2 = "";
			}
			var ele2Val = $(ele2).val().trim()==""?value2:$(ele2).val().trim();
			
					if(eleVal!="" && ele1Val!=""){
						//当方括号：[] 出现在json的key中时，aaa[d[h=t]g]=vvv 这种写法的时候 会有一些小问题 右闭合部分会丢失 所以这里转义下 展示的时候 在java后端再反转义下
						var obj = {};
						obj[ele1Val.replace("[","@iamapresb@").replace("]","@iamarearsb@")]=ele2Val.replace("[","@iamapresb@").replace("]","@iamarearsb@");
						//console.log(obj);
						innerFormData[eleVal.replace("[","@iamapresb@").replace("]","@iamarearsb@")]=obj;
						//innerFormData[$(this).val().trim().replace(/\[/g,"@iamapresb@").replace(/\]/g,"@iamarearsb@")]=$(elements[i+1]).val().trim();
					}
			if(formData.hasOwnProperty(key)){
				var obj = formData[key];
				var props = "";
				for(var p in obj){   
				    // 方法  
				    if(typeof(obj[p])=="function"){   
				        //obj[p]();  
				    }else{   
				        // p 为属性名称，obj[p]为对应属性的值  
				        innerFormData[p+""] = obj[p];
				        //props += p + "=" + obj[p] + ";  ";  
				    }   
				}
			}
			formData[key]=innerFormData;
		}
	});
	console.log(formData);
	return formData;
};
//根据规则创建参数------结束----------------------------



function testContent(ele){
	var textPageUrl = $(ele).attr("to-url");
	$("#mainFrm div[name='textPageUrl'] input").val(textPageUrl);
	var url = "news/getTextPageInfo";
	$.ajax({
		url:url,
		type:'POST',
		data:buildFormData("#leftEditBox"),
		beforeSend:function(){
			//这里是开始执行方法，显示效果
			$(ele).attr("disabled","disabled");
			$(ele).find("i").attr("class","fa fa-gear fa-1x fa-spin")
		},
		complete:function(){
			//方法执行完毕，效果自己可以关闭，或者隐藏效果
			$(ele).removeAttr("disabled");
			$(ele).find("i").attr("class","fa fa-play")
		},
		success:function(data){
			doAfterTestContentSuccess(data,ele);
		}
	})
}
function doAfterTestContentSuccess(data,ele){
	data=eval("("+data+")");//转换为json对象
	var nodata = "无";
	var content = data.content;
	var imgUrls = data.imgUrlSet;
	var author = data.author;
	var source = data.source;
	var originTime = data.originTime;
	var time = data.time;
	var reply = data.reply;
	var click = data.click;
	
	var additionalAttribute = data.additionalAttribute;
		    	var additionalAttributeStr = "";
		    	if(additionalAttribute){
		    		additionalAttributeStr = obj2str(additionalAttribute); 
		    	}
	
	var srcArry = imgUrls;
	var imgUrlEles = "";
	var totalContent = '';
	if(imgUrls){
		for(var i = 0 ; i < srcArry.length;i++){
			if(srcArry[i]){
				imgUrlEles+="<div style='text-align:center;'><img src='"+srcArry[i]+"' width='400' style='margin:10px 0'/></div>";
			}
			
		}
	}
	var content0 = '';
	if(author){
		content0+='<div><b>作者</b>:'+author+'</div>';
	}
	if(source){
		content0+='<div><b>来源</b>:'+source+'</div>';
	}
	if(originTime){
		content0+='<div><b>原始发布时间</b>:'+originTime+'</div>';
	}
	if(time){
		content0+='<div><b>发布时间</b>:'+time+'</div>';
	}
	if(reply){
		content0+='<div><b>回复</b>:'+reply+'</div>';
	}
	if(click){
		content0+='<div><b>点击</b>:'+click+'</div>';
	}
	if(additionalAttributeStr){
		content0+='<div><b>其他字段</b>:'+additionalAttributeStr+'</div>'
	}
	if(content){
		content0+='<div><b>内容</b>:</div>';
	}
	if(content&&content.trim()){
		var content1 = content.substring(0,200);
		var content2 = "<span class='more-contents' style='display:none;'>"+content.substring(200)+"</span>";
		totalContent = content0+content1+content2+"<a href='javascript:;' class='more-ele' onclick='openOrCloseContent(this)'>展开</a>";
	}else{
		totalContent+=content0;
	}
	$(ele).parent().find(".fetch-content").html(imgUrlEles+totalContent);
	$(ele).parent().find(".fetch-content").show();
	
	if(source&&source.length>100){
		MessageBoxShow("来源填写错误!");
	}
}
// load related plugins
function openOrCloseContent(more_ele){
	var $more_ele = $(more_ele);
	var $content_ele = $more_ele.parent();
	var $more_contents = $content_ele.find(".more-contents");
	
	if($more_ele.html()=="展开"){
		$more_contents.show();
		$more_ele.html("收起");	
	}else{
		$more_contents.hide();
		$more_ele.html("展开");	
	}
}
//通过
function auditPass(){
	var formData = buildFormData("#leftEditBox");
	var userName = $("#group-rule-boxs div[name='userName'] input").val();
	var groupName = $("#groupId option:selected").text();
	formData['newsGroupRuleRequirementId'] = $("#group-rule-boxs div[name='id'] input").val();
	formData['auditOpinion'] = $("#group-rule-boxs div[name='auditOpinion'] textarea").val();
	formData['groupId'] = $("#groupId").val();
	formData['groupName'] = groupName;
	
	$.ajax({
		url:'/newsGroupRule/auditPass',
		dataType:'json',
		data:formData,
		success:function(d){
			if(d.result==1){
				var html = '页面审核完成！<br/>'+
				  			'该规则已添加到用户'+userName+' 的 '+groupName+' 任务中。';
				MessageBoxShow(html,true);
				news_group_rule_requirement_list_table.fnDraw();
				if(newsGroupRuleRequirementdialog) newsGroupRuleRequirementdialog.close();
				if(shenHeDialog) shenHeDialog.close();
				if(newsGroupRuledialog) newsGroupRuledialog.close();
				var user_id = $("#click_user_id").attr("user_id");
				$(".userBox").each(function(){
					var a = $(this).find("div:first").attr("user_id");
					//alert(a+"::"+user_id);
					if($(this).find("div:first").attr("user_id")==user_id){
						var num = $(this).find("div:first").text();
						var requirementSurplus = parseInt($(this).find(".requirementSurplus").text());
						var passAuditCount = parseInt($(this).find(".passAuditCount").text());
						if(requirementSurplus-1>=0){
							$(this).find(".requirementSurplus").text(requirementSurplus-1);
						}
						$(this).find(".passAuditCount").text(passAuditCount+1);
					}
				})
			}else if(d.result==-1){
				MessageBoxShow("审核失败！服务器异常");
			}else if(d.result==2){
				MessageBoxShow("审核失败！页面数量超出限制!");
			}
		},error:function(){
			MessageBoxShow("审核失败！服务器异常");
		}
	})
}
function startToCopyPublicListRuleModel(ele){
	var list_model_id = $(ele).attr("list_model_id");
		var url = "/news/editNewsPublicListRule.html";
		$.ajax({
			url:url,
			type:'POST',
			data:{"id":list_model_id},
			beforeSend:function(){
				//这里是开始执行方法，显示效果
			},
			complete:function(){
				//方法执行完毕，效果自己可以关闭，或者隐藏效果
			},
			success:function(data){
				commonCopyPublicListRuleModel(data);
			}
		});
}
/**
复制列表模板
*/
function copyPublicListRuleModel(ele){
	var publicListRuleId = $(".aui_content #mainFrm div[name='publicListRuleId'] input").val();
	
	if(publicListRuleId){
		var extends_html = $(".aui_content #mainFrm a.extends_flag:eq(0)").attr("flag_title");
		var dialog = art.dialog({
			title: '取消继承确认',
			width: 'auto',    // 内容宽度
				height: 'auto',    // 内容高度
			content: "<div>您当前"+extends_html+"，您确认要取消继承吗?</div>",
			padding: '0px 0px',
			lock:true,
			button:[{
				  name:"<i class='fa  fa-play'></i>&nbsp; 保存",
				  callback:function(){
				  	$(".aui_content #mainFrm div[name='publicListRuleId'] input").val("");
				  	$(".aui_content #mainFrm a.extends_flag:eq(0)").attr("title","当前无继承模板");
				  	$(".aui_content #mainFrm a.extends_flag:eq(0)").attr("flag_title","当前无继承模板");
					$(".aui_content #mainFrm a.extends_flag:eq(0)").css("color","#ccc").css("text-decoration","none");
				  	startToCopyPublicListRuleModel(ele);
				  	//var r = updateToRule();
				  	//if(r){
				  	MessageBoxShow('复制成功!',true);
				  	//	art.dialog.tips('复制成功!');
				  		
				  	//}
				  }
			  },{
			    name:'取消',
			    callback:function(){
			  	}
			  }],
			    init: function () {
			    	changeArtdialogButtonCss();
			    }
		});
	}else{
		startToCopyPublicListRuleModel(ele);
		//art.dialog.tips('复制成功!');
		MessageBoxShow('复制成功!',true);
	}

}
function addNewRow(ele,type){
	var parent = $(ele).parents(".form-group");
	var name = $(ele).parents(".form-group").attr("name");
	var deleteHtml = '	<a href="javascript:;" class="btn btn-primary btn-circle"  onclick="deleteRow(this)"><i class="glyphicon glyphicon-minus"></i></a>';
	var cloneParent = parent.clone();
	$(cloneParent).find("label").html("");
	$(cloneParent).find("div:eq(0) input").val("");
	$(cloneParent).find("div:eq(1) input").val("");
	if(!(type&&type==2)){
		$(cloneParent).find("div:eq(2)").html(deleteHtml);
	}else{
		$(cloneParent).find("div:eq(2) input").val("");
		$(cloneParent).find("div:eq(3)").html(deleteHtml);
	}
	$(".aui_content div[name='"+name+"']:last").after(cloneParent);
}
function deleteRow(ele){
	$(ele).parent().parent().remove();
}
function showOther(ele){
	$(ele).parent().next().show();
}
/**
* 实时入库
*/
function saveFatchListToDB(ele,ruleId,isUpdate){
	var url = "news/saveFatchList?id="+ruleId;
	var msg = '后台入库任务已开启!';
	if(isUpdate){
		msg = '后台更新任务已开启!';
		url = "news/updateFatchList?id="+ruleId;
	}
	MessageBoxShow(msg,true);
	$.ajax({
		url:url,
		type:'POST',
		success:function(data){
			//art.dialog.tips('入库成功!');
			//MessageBoxShow('入库成功!',true);
		}
	})
}

