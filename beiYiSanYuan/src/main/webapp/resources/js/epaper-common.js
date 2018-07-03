/**
** 继承列表模板
*/
	function extendsPublicListRuleModel(ele){
		var id = $("div[name='id'] input").attr("value");
		//if(!id) {MessageBoxShow('请保存后再继承，或直接使用复制!');return false;}
		var list_model_id = $(ele).attr("list_model_id");
		var list_model_name = $(ele).attr("list_model_name");
		$("#mainFrm div[name='publicListRuleId'] input").val(list_model_id);
		//var r = updateToRule();
		//if(r){
			$("#mainFrm a.extends_flag:eq(0)").attr("title","继承模板【"+list_model_name+"】,点击取消继承");
			$("#mainFrm a.extends_flag:eq(0)").attr("flag_title","继承模板【"+list_model_name+"】");
			$("#mainFrm a.extends_flag:eq(0)").css("color","#3276b1").css("text-decoration","none");
			MessageBoxShow('继承成功!请记得保存哦');
		//}
		var url = "/epaper/editEpaperPublicListRule.html";
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
		/*
		if(listAdditionalParserMapKeys.length>1){
			$(".listAdditionalParserMap").remove();
		}else{
			$(".listAdditionalParserMap:gt(0)").remove();
			$(".listAdditionalParserMap:eq(0) input").val("");
			$(".listAdditionalParserMap:eq(0)").hide();
		}*/
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
				 	$("div.other:eq(1)").after($(str));
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

function loadPublicHtmlTextRuleModelOnlySelect(){	
	commonLoadPublicHtmlTextRuleModelTable(true);
}

var public_html_text_rule_model_table;
function commonLoadPublicHtmlTextRuleModelTable(isCopyOrExtends,isAll){//isSelect:是否是将要 复制或者继承
	if(public_html_text_rule_model_table!=null){
        	//$("#rule_list tbody tr").remove();
        public_html_text_rule_model_table.fnDestroy();
	}
	//公共正文模板
    public_html_text_rule_model_table = $("#public_html_text_rule_model").dataTable({
		"bProcessing" : true,//加载数据时候是否显示进度条
		//"bServerSide" : true,//是否从服务加载数据 
		"sAjaxSource" : "/epaper/epaperPublicRankTextRules",//如果从服务器端加载数据,这个属性用于指定加载的路径 
		"bSort":false,
		"fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {
	        var aoData = buildFormData2('#leftEditBox');     
	        if(isAll) aoData['isAll'] = isAll; 
	        oSettings.jqXHR = $.ajax( {
	            "dataType": 'json',
	            "type": "POST",
	            "url": sSource,
	            "data": aoData,
	            "success": function(data){
	            	//uuu
	            	if(data.iTotalRecords==0){
		            	$("#public_html_text_rule_model_processing").hide();
		            }else{
		            	fnCallback(data);
		            }
	           	},
	            "error":function(data){
	           		$("#public_html_text_rule_model_processing").hide();
		        }
	        } );
	    }, 
		"sPaginationType" : "full_numbers",
		"columns": [
            {"data": function ( row, type, set ){
            	return genHtmlByObject(row.name);
			}},
            {"sWidth" : "20%","data": function ( row, type, set ){
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
			if(!isCopyOrExtends){
				var button_html = '	<a class="btn btn-primary" id="add_public_html_text_rule_model" onclick=\'toAddPublicTextRuleModel("html")\' style="float:right;" href="javascript:void(0);">添加公共正文模板</a>&nbsp;&nbsp;';
				$("#public_html_text_rule_model_wrapper .dt-toolbar>div:eq(1)").append($(button_html)).css("padding-right","0px");
			}
		},
		"sDom":common_data_table_config.sDom
    });
}



