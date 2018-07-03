$.datepicker.regional["zh-CN"] = { closeText: "关闭", prevText: "上月", nextText: "下月", currentText: "今天", monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"], monthNamesShort: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"], dayNames: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"], dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"], dayNamesMin: ["日", "一", "二", "三", "四", "五", "六"], weekHeader: "周", dateFormat: "yy-mm-dd", firstDay: 1, isRTL: !1, showMonthAfterYear: !0, yearSuffix: "年" }
$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
// 获取URL参数
$.request = (function() {
	var apiMap = {};
	function request(queryStr) {
		var api = {};
		if (apiMap[queryStr]) {
			return apiMap[queryStr];
		}
		api.queryString = (function() {
			var urlParams = {};
			var e, d = function(s) {
				return decodeURIComponent(s.replace(/\+/g, " "));
			}, q = queryStr.substring(queryStr.indexOf('?') + 1), r = /([^&=]+)=?([^&]*)/g;
			while (e = r.exec(q))
				urlParams[d(e[1])] = d(e[2]);

			return urlParams;
		})();
		api.getUrl = function() {
			var url = queryStr.substring(0, queryStr.indexOf('?') + 1);
			for ( var p in api.queryString) {
				url += p + '=' + api.queryString[p] + "&";
			}
			if (url.lastIndexOf('&') == url.length - 1) {
				return url.substring(0, url.lastIndexOf('&'));
			}
			return url;
		}
		apiMap[queryStr] = api;
		return api;
	}
	$.extend(request, request(window.location.href));
	return request;
})();
//提示
artDialog.tips = function(content, time) {  
	return artDialog({  
			id: 'Tips',  
			title: false,  
			cancel: false,  
			fixed: true,  
			lock: true,  
			opacity: 0.3  
	}).content('<div style="padding: 0 1em;">' + content + '</div>').time(time || 0.5);  
};  
function loadingTip(content, div) {
	$(div).html('<p class="text-center loadding" style="padding: 20px;"><img src="/resources/img/loading.gif" />' + content + '</p>');
}
artDialog.confirm = function (content, yes, no) {
    return artDialog({
        id: 'Confirm',
        icon: 'question',
        fixed: true,
        lock: true,
        opacity: .1,
        content: content,
        ok: function (here) {
            return yes.call(this, here);
        },
        cancel: function (here) {
            return no && no.call(this, here);
        }
    });
};
artDialog.alert = function (content, callback) {
    return artDialog({
        id: 'Alert',
        icon: 'warning',
        fixed: true,
        lock: true,
        content: content,
        ok: true,
        close: callback
    });
};
// 根据长度截取字符串
function cut_str(str, len, hasDot) {
	var newLength = 0;
	var newStr = "";
	var chineseRegex = /[^\x00-\xff]/g;
	var singleChar = "";
	var strLength = str.replace(chineseRegex, "**").length;
	for ( var i = 0; i < strLength; i++) {
		singleChar = str.charAt(i).toString();
		if (singleChar.match(chineseRegex) != null) {
			newLength += 2;
		} else {
			newLength++;
		}
		if (newLength > len) {
			break;
		}
		newStr += singleChar;
	}

	if (hasDot && strLength > len) {
		newStr += "...";
	}
	return newStr;
}
/**
 * 循环往url中添加参数
 * @param url
 * @param params
 * @return
 */
function addQueryParams(url, params) {
    var key,
    joinChar = (url.indexOf('?') === -1) ? '?' : '&',
    arrParams = [],
    strParams = '';
    for (key in params) {
    	arrParams[arrParams.length] = '&' + key + '=' + params[key];
    }
    // 去掉第一个'&', 因为有joinChar存在
    strParams = arrParams.join('').substring(1);
    url = url + joinChar + strParams;
     return url;
}

String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
}
String.prototype.ltrim = function() {
	return this.replace(/(^\s*)/g, "");
}
String.prototype.rtrim = function() {
	return this.replace(/(\s*$)/g, "");
}
//返回字符的长度，一个中文算2个 
/*
String.prototype.ChineseLength=function() {      
    return this.replace(/[^/x00-/xff]/g,"**").length;     
};*/
//批量替换，比如：str.ReplaceAll([/a/g,/b/g,/c/g],["aaa","bbb","ccc"])     
String.prototype.ReplaceAll=function (A,B) {     
    var C=this;     
    for(var i=0;i<A.length;i++) {     
        C=C.replace(A[i],B[i]);     
    };     
    return C;     
}; 

//判断字符串是否以指定的字符串结束     
String.prototype.EndsWith=function (A,B) {     
    var C=this.length;     
    var D=A.length;     
    if(D>C)return false;     
    if(B) {     
        var E=new RegExp(A+'$','i');     
        return E.test(this);     
    }else return (D==0||this.substr(C-D,D)==A);     
};     
// 判断字符串是否以指定的字符串开始     
String.prototype.StartsWith = function(str)      
{     
    return this.substr(0, str.length) == str;     
};     
// 字符串从哪开始多长字符去掉     
String.prototype.Remove=function (A,B) {     
    var s='';     
    if(A>0)s=this.substring(0,A);     
    if(A+B<this.length)s+=this.substring(A+B,this.length);     
    return s;     
};  
//表单自动填充
$.fn.jsontoform = function(entity, attrName, attrPrefix) {
	if (this.length > 0) {
		for ( var i = 0; i < this.length; i++) {
			var tObj = $(this[i]);
			if (attrName == null) {
				attrName = "name";
			}
			var propertyVal = (attrPrefix == null ? tObj.attr(attrName) : (tObj.attr(attrName).replace(attrPrefix, '')));
			if (entity[propertyVal] != undefined) {
				var enValue = entity[propertyVal];
				if ("radio" == tObj.attr("type") || "checkbox" == tObj.attr("type")) {
					if (enValue == tObj.val()) {
						tObj.attr("checked", "checked");
					}
				}else if("file" == tObj.attr("type"))
				{
					tObj.next("img").attr("src",enValue);
					
				}else if ("SELECT" == tObj.get(0).tagName) {
					tObj.find("option[value='" + enValue + "']").attr("selected", "true");
				} else {
					tObj.val(enValue);
				}
			}
		}
	}
}
//弹出层
function MessageBoxShow(content, flag) {
	if (flag) {
		$.smallBox( {
			title : "系统提示",
			content : "<strong>" + content + "</strong>",
			color : "#659265",
			iconSmall : "fa fa-check fa-2x fadeInRight animated",
			timeout : 2000
		});
	} else {
		$.smallBox( {
			title : "系统提示",
			content : "<strong>" + content + "</strong>",
			color : "#C46A69",
			iconSmall : "fa fa-times fa-2x fadeInRight animated",
			timeout : 2000
		});
	}
}

//根据map创建内容------开始----------------------------
function genHtmlByObject(obj,type){//根据key，value生成页面显示的内容，针对于表格，不然会显示成object
	
	var str = "";
	if(obj){
		if(typeof(obj)=="object"){
			var key = getKey(obj)[0];
			var value = getValue(obj)[0];
			
			if(!key){key = "暂无"};
			if(!value){value = "暂无"};
			if(value!="暂无"){
				if(typeof(value)=="object"){
					var key2 = getKey(value);
				    if(!key2){key = "暂无"};
				    if(!value){value = "暂无"};
				    value = getValue(value);
				    str+=key+"["+key2+":"+value+"]";
				}else{
					str+=key+":"+value;
				}
			}else{
				str+=key+":"+value;
			}
			str+="...";
		}else if(typeof(obj)=="string"||typeof(obj)=="number"){
			str+=obj;
		}
	}else{
	    str+="暂无";
	}
	return str;
}

function changeArtdialogButtonCss(aui_btns_class){
	$(".pRed").parents("button").removeClass("btn-primary").addClass("btn-danger");
	$(".aui_dialog .aui_buttons .aui_state_highlight ").removeClass("btn-primary").addClass("btn-danger");
	
	if(!aui_btns_class){
		$(".aui_dialog .aui_buttons button").each(function(){
			if($(this).html().indexOf("取消")>-1||$(this).html().indexOf("关闭")>-1){
				$(this).addClass("btn btn-default margin_L5");
			}else{
				$(this).addClass("btn btn-primary margin_L5");
			}
		});
	}else{
		$(".aui_dialog .aui_buttons button").addClass(aui_btns_class);
	}
	
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
function obj2str(o){
	   var r = [];
	   if(typeof o == "string" || o == null) {
	     return o;
	   }
	   if(typeof o == "object"){
	     if(!o.sort){
	       r[0]="{"
	       for(var i in o){
	         r[r.length]="<b>"+i+"</b>";
	         r[r.length]=":";
	         r[r.length]=obj2str(o[i]);
	         r[r.length]=",";
	       }
	       r[r.length-1]="}"
	     }else{
	       r[0]="["
	       for(var i =0;i<o.length;i++){
	         r[r.length]=obj2str(o[i]);
	         r[r.length]=",";
	       }
	       r[r.length-1]="]"
	     }
	     return r.join("");
	   }
	   return o.toString();
	}
function loadingShow(){
	$(".loading_ele").remove();
	// 获取浏览器窗口 
	var windowScreen = document.documentElement; 
	var main_left = (windowScreen.clientWidth)/2; 
	var main_top = (windowScreen.clientHeight)/2;
	var loadingHtml = '<i class="loading_ele fa fa-gear fa-3x fa-spin txt-color-white" style="position: absolute;top: '+main_top+'px;left: '+main_left+'px;z-index: 100000;"></i>';
	var zhezhao = "<div  class='loading_ele' style='position:absolute;z-index: 100000;top:0;opacity:0.3;width:"+windowScreen.clientWidth+"px;height:"+windowScreen.clientHeight+"px;background:black;'></div>";
	$("body").append(zhezhao+loadingHtml);
}
function loadingHide(){
	$(".loading_ele").hide();
}
function dialogCenterScreen(dialog,dialogId){
	var width = $(".aui_main ").width();
	var height = $(".aui_main ").height();
	if(dialogId){
		width = $("#"+dialogId).width();
		height = $("#"+dialogId).height();
		console.log(width+"@@@@"+height);
	}
	// 获取浏览器窗口 
	var windowScreen = document.documentElement; 
	dialog.show();
	var main_left = (windowScreen.clientWidth - width)/2 ; 
//	var main_top = (windowScreen.clientHeight - height)/2; 
	var main_top = 100;
	console.log(main_left+"_"+main_top);
	dialog.position(main_left,main_top);
}
function callDialog(ajaxUrl,dialogId,dialogTitle,dialogWidth,dialogButtons,callBack,initCallBack,d2){
	loadingShow();
	if($("#"+dialogId).length==0){
		$("body").append("<div id='"+dialogId+"' style='display:none;' ></div>");
	}
	
	$("#"+dialogId).load(ajaxUrl,function(response,status,xhr){
		
		var dialog = window.top.art.dialog({
			top: '10%',
			title: dialogTitle,
			content: $("#"+dialogId)[0],
			width:dialogWidth+"px",
			padding: '0px 0px',
			lock:true,
			button:dialogButtons,
			init: function () {
				if(initCallBack){
					callFunction(initCallBack,this);
				}
		    	changeArtdialogButtonCss();
		    }
		})
		$(".aui_content").css("width","100%");
		loadingHide();
		if(callBack){
			callFunction(callBack,dialog);
		}
	});
}
var common_data_table_config = {
		//查看子版块
		"oLanguage" : { //主要用于设置各种提示文本
			"sProcessing" : "<a href=\"javascript:void(0);\" class=\"bg-color-white txt-color-teal\"><i class=\"fa fa-gear fa-2x fa-spin\"></i></a>&nbsp;&nbsp;&nbsp;正在处理...", //设置进度条显示文本
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
		"sDom": "<'dt-toolbar'<'col-xs-8 tools-bar'><'col-xs-4'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>",
		"searchSDom": "<'dt-toolbar'<'col-xs-8 tools-bar'f><'col-xs-4'>r>"+"t"+"<'dt-toolbar-footer'<'col-xs-6'il><'col-xs-6'p>>"
	}

function callFunction(functionName,d,d2,d3,d4){
    //根据函数名得到函数类型
    var  func=eval(functionName);
     //创建函数对象，并调用
    console.log(functionName);
    new func(d,d2,d3,d4);
}
/**
 * 公共ajax请求
 * @param url
 * @param data
 * @param success_callback
 * @param otherParam0
 * @param otherParam1
 * @param otherParam2
 * @return
 */
function ajax_(url,data,success_callback,otherParam0,otherParam1,otherParam2){
	$.ajax({
		url:url,
		data:data,
		dataType:'json',
		type:'post',
		dataType:"json",
		success:function(d){
			if(success_callback){
				callFunction(success_callback,d,otherParam0,otherParam1,otherParam2);
			}
		}
	})
}

function initSelect(selectName){
	$("select[name='"+selectName+"']").val($("select[name='"+selectName+"']").attr("value"));
}
function initCheckBox(ckBoxName){
	if($("[name='"+ckBoxName+"']").attr("value")==0){
		$("[name='"+ckBoxName+"']").removeAttr("checked");
	}else{
		$("[name='"+ckBoxName+"']").attr("checked",'true');
	}
}
function initRadio(radioName){
	$("[name='"+radioName+"']").each(function(){
		var text = $(this).parent().text();
		if(text.indexOf($('#'+radioName).val())>-1){
			$(this).attr("checked",'true');
			return;
		}
	})
	//$("[name='"+radioName+"']").val($("[name='"+radioName+"']").attr("value"));
}
