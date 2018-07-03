var pagefunction=function(){
	InitList();
}
var tableID = "#table";
var controllerUrlBase='specialFragment';
var listUrl = "/"+controllerUrlBase+"/getPagedList.html";
var dataTable;
var editDialog;
function InitList()
{
	var params = "";
	/*if($("#groupId").val()){
		params+="eq_groupId="+$("#groupId").val();
	}*/
	dataTable=new InfoEdit();
	dataTable.requestUrl=controllerUrlBase;
	dataTable.oTable=$(tableID).dataTable({
		"oLanguage" : common_data_table_config.oLanguage,
		"sDom": "<'dt-toolbar'<'col-xs-6 tools-bar'><'col-xs-6'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
		"oColVis": {
            "buttonText": "表格列显示 / 隐藏"
        },
        "bSort":false,
		"bPaginate" : true,
		"bProcessing" : false,
		"bServerSide" : true,
		"sAjaxSource" : listUrl+"?"+params,
		"fnServerData" : function(sSource, aoData, fnCallback, oSettings) {
				oSettings.jqXHR = $.ajax( {
					"dataType" : 'json',
					"type" : "POST",
					"url" : sSource,
					"beforeSend" : function() {
						//ZENG.msgbox.show(" 正在加载中，请稍后...", 6, 100000);
					},
					"complete" : function() {
						
					},
					"data" : aoData,
					"success" : fnCallback
				});
			},
		
		"aoColumns" : [{
			"sTitle": "类别", "sClass": "center", "data" : function ( row, type, set ){
				var str = '';
				if(row.type=='0001'){
					str = 'webClient地址';
				}else if(row.type=='0002'){
					str = 'CDATA地址';
				}else if(row.type=='0003'){
					str = '代码片段';
				}
				return genHtmlByObject(str);
			}
		}, {
			"sTitle": "片段", "sClass": "center", "data" : function ( row, type, set ){
				var s_fragment = cut_str(row.fragment, 30,"...");
				return genHtmlByObject(s_fragment);
			}
		}, {
			"sWidth":'140px',
            "sTitle": "操作",
            "sClass": "center",
            "data": function ( row, type, set ){
				var editBtn = "<button  onclick=\"openEditDialog(this,'"+row.id+"');\" title=\"编辑\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-pencil\"></i></button>&nbsp;";
            	var deleteBtn = "<button  onclick=\"dataTable.deleteRow('"+row.id+"');\" title=\"删除\" class=\"btn btn-xs btn-default\"><i class=\"fa fa-times\"></i></button>&nbsp;";
            	return editBtn+deleteBtn;
	        } 
        }],
        "fnInitComplete": function(oSettings, json) {
				initTableButton();
		 },
	});
}
function openEditDialog(obj,id)
{
	if(!id){id=""}
	callDialog("/"+controllerUrlBase+"/edit?eq_id="+id,"editModal","详情","550",[],'','afterOpenEditDialog');
}
function afterOpenEditDialog(dialog){
	editDialog = dialog;
	var buttons = [{
						name:"保存",
				    	callback:function(){
							saveRow(dialog);
							return false;
						}
					},{
						name:"取消",
						callback:function(){
					}
	}];
	dialog.button(buttons);
}
function initTableButton(){
	/*左*/
	$(tableID+"_wrapper label").remove();
	$(tableID+"_wrapper .dt-toolbar").addClass("padding_B5");
	var sle_type = '<select type="text" name="eq_type" class="form-control ng-valid ng-dirty margin_R5" placeholder="片段"><option value="">全部</option><option value="0001">webClient地址</option><option value="0002">CDATA地址</option><option value="0003">代码片段</option></select>';
	var ipt_fragment = '<input type="text" name="l_fragment" class="form-control ng-valid ng-dirty margin_R5" placeholder="片段">';
	var s_submit_btn = '<a class="btn btn-default" id="app_search" onclick=tableSearch(\'i@l_fragment|s@eq_type\') >查询 </a>';
	$(tableID+"_wrapper .dt-toolbar div:eq(0)").append($(sle_type)).append($(ipt_fragment)).append($(s_submit_btn));
	/*右*/
	var add_btn = '<a class="btn btn-primary margin_L5" name="toAdd" id="weiboApp" style="float:right;" onclick="openEditDialog()" href="javascript:void(0);">添加片段</a>';
	$(tableID+"_wrapper .dt-toolbar div:eq(1)").append($(add_btn));
}
function tableSearch(fromParam){
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
	dataTable.oTable.fnSettings().sAjaxSource=url;
	dataTable.oTable.fnDraw(); //重新加载数据
}
function saveRow(dialog){
	ajax_('/'+controllerUrlBase+'/saveOrUpdate.html',$("#frm").serialize(),'saveRowCallback');
}
function saveRowCallback(data){
	
	if(data.result==1){
		if(editDialog){
			editDialog.close();
		}
		if(dataTable){
			dataTable.oTable.fnDraw(); //重新加载数据
		}
		MessageBoxShow('保存成功!',true);
	}else if(data.result==-2){
		MessageBoxShow('保存失败，同一类别不允许有相同片段!');
	}else if(data.result==-1){
		MessageBoxShow('保存失败，服务器异常!');
	}
}
//初始化分发策略表单
loadScript(
	"resources/js/plugin/datatables/jquery.dataTables.min.js",
	function() {
		loadScript(
				"resources/js/plugin/datatables/dataTables.colVis.min.js",
				function() {
					loadScript(
							"resources/js/plugin/datatables/dataTables.tableTools.min.js",
							function() {
								loadScript(
										"resources/js/plugin/datatables/dataTables.bootstrap.min.js",
										function() {
											loadScript("resources/js/custom-edit.js",pagefunction);
										});
							});
				});
});