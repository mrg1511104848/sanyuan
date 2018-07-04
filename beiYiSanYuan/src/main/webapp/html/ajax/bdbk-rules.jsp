<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>
 .color_296191{
 	color:#296191;
 }
 .margin_b_5{
 	margin-bottom:5px;
 }
</style>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-2">
		<h1 class="page-title txt-color-blueDark">
			<i class="fa fa-table fa-fw "></i> 百度百科
			<span>> 抓取规则 </span>
		</h1>
	</div>
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-10" style="text-align:right;">
	</div>
</div>

<a href="javascript:;" onclick="ruleDetail()">添加</a>

<a href="javascript:;" onclick="ruleDetail('54d88381e0fdb33b6ae7af45')">获取</a>

<div id="rule_dialog_div" class="row" style="display:none;"></div>
<script type="text/javascript">
	$(function(){
		
	})
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
	function buildFormData2(){
		$("#rule_dialog_div").html("");
		var listDataType = $("div[name='listDataType']").length;
		//console.log("listDataTypeLength"+listDataType);
		var formData = {};
		var len = $(".aui_content").length;
		$("div.form-group").each(function(){
			var key = $(this).attr("name");
			var elements = $(this).find("div>input");
			if(elements.length==1){
				var value= elements.val().trim();
				//console.log(key+"_____"+value);
				if(value!=""||key=="id"){
					formData[key]=value;
				}
			}else if(elements.length>1&&elements.length<3){
				var innerFormData = {};
				elements.each(function(i){
					if(i%2==0){
						if($(this).val().trim()!=""&&$(elements[i+1]).val().trim()!=""){
							//当方括号：[] 出现在json的key中时，aaa[d[h=t]g]=vvv 这种写法的时候 会有一些小问题 右闭合部分会丢失 所以这里转义下 展示的时候 在java后端再反转义下
							innerFormData[$(this).val().trim().replace(/\[/g,"@iamapresb@").replace(/\]/g,"@iamarearsb@")]=$(elements[i+1]).val().trim();
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
						if($(ele).val().trim()!=""&&$(elements[1]).val().trim()!=""){
							//当方括号：[] 出现在json的key中时，aaa[d[h=t]g]=vvv 这种写法的时候 会有一些小问题 右闭合部分会丢失 所以这里转义下 展示的时候 在java后端再反转义下
							var obj = {};
							obj[$(elements[1]).val().trim().replace("[","@iamapresb@").replace("]","@iamarearsb@")]=$(elements[2]).val().trim().replace("[","@iamapresb@").replace("]","@iamarearsb@");
							//console.log(obj);
							innerFormData[$(ele).val().trim().replace("[","@iamapresb@").replace("]","@iamarearsb@")]=obj;
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
		return formData;
	};
	function ruleDetail(id){
		$(".fetch-content").html("");
		$('#rule_dialog_div').load("bdbk/toRuleDialog?rule_id="+id,function(){
			loadEditRuleDialog();
			$('#rule_dialog_div').html("");
			//getListPageInfo();
		});
		return false;
	}
	function loadEditRuleDialog(){
		var left = 541/2+"px";
		var top = 570/2+"px";
		var screen_width = $(document).width();
		$(".fatch_processing").css({"position":"absolute","top":top,"left":left});
		var dialog = art.dialog({
			id:"rule_dialog",
		    title: '欢迎',
		    width: screen_width,    // 内容宽度
				height: 'auto',    // 内容高度
		    content: $("#rule_dialog_div").html(),
		    follow: document.getElementById('btn2'),
		    padding: '0px 0px',
		    lock:true,
		    button:[{
		    	name:"<i class='fa  fa-play'></i>&nbsp; 实时入库",
		    	callback:function(){
		    		saveFatchListToDBRightNow();
		    		//art.dialog.tips('入库成功!');
		    		return false;
		    	}
		    },{
		    	name:'保存为新模块',
		    	callback:function(){
					var rId = saveNewRule();
					$(".aui_buttons button:eq(2)").show();
					if(rId){
						art.dialog.tips('保存成功!');
					}
					return false;
		    	}
		    },{
		    	name:'更新',
		    	callback:function(){
		    		updateToRule();
					return false;
		    	}
		    },{
		    	name:'测试',
		    	callback:function(){
					getTextPageInfo();
					return false;
				}
		    }],
		    init: function () {
		    	changeArtdialogButtonCss();
		    }
		});
		$(".aui_content").css("width","100%");
	}
	function saveNewRule(){
		var ipt_id = $("div[name='id'] input");
		ipt_id.val(""); //新增id置为""
		$.ajax({
			type: "post",
			url: "/bdbk/saveRule",
			data: buildFormData2(),
			async: false,
			success: function(data){
				data = eval('('+data+')');
				var id  = data.id;
				$("div[name='id'] input").attr("value",id);
				$("div[name='id'] input").val(id);
				rule_table.fnDraw();
			}
		});
		return ipt_id;
	}
	function updateToRule(){
		var r = false;
		$.ajax({
			type: "post",
			url: "/bdbk/saveRule",
			async:true,
			data: buildFormData2(),
			success: function(data){
				r = true;
				data = eval('('+data+')');
				$("div[name='id'] input").attr("value",data.id);
				$("div[name='id'] input").val(data.id);
				
				art.dialog.tips('更新成功!');
			}
		});
		return r;
	}
	function getTextPageInfo(ele){
		var textPageUrl = $("div[name='textPageUrl'] input").val();
		var url = "bdbk/getTextPageInfo";
		var post_data = buildFormData2();
		$.ajax({
			url:url,
			type:'POST',
			data:post_data,
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
				doAfterGetTextPageInfoSuccess(data);
			}
		})
	}
	function doAfterGetTextPageInfoSuccess(data){
		data=eval("("+data+")");//转换为json对象
		var title = data.title;
		var useful = data.useful;
		var shared = data.shared;
		var cardSummary = data.cardSummary;
		var img_strs = data.imgs;
		var imgs = convertStrToImgs(img_strs);
		
		var link_url_strs = data.linkUrls;
		var link_text_strs = data.linkTexts;
		var links = convertStrToLinks(link_url_strs,link_text_strs);
		
		var baseinfoList = data.baseinfoList;
		var baseinfoListHtml = convertListToHtml(baseinfoList);
		var content = data.content;
		
		var strs = "<div class='margin_b_5'><b class='color_296191'>标题</b>:"+title+"</div>"+
					"<div class='margin_b_5'><b class='color_296191'>概述</b>:"+cardSummary+"</div>"+
					"<div class='margin_b_5'><b class='color_296191'>页面中所有的链接</b>:"+links+"</div>"+
					"<div class='margin_b_5'><b class='color_296191'>基本信息</b>:"+baseinfoListHtml+"</div>"+
					"<div class='margin_b_5'><b class='color_296191'>图片</b>:"+imgs+"</div>"+
					"<div class='margin_b_5'><b class='color_296191'>内容</b>:"+content+"</div>";
		$("#rule_list_fieldset div:eq(0)").html(strs);
	}
	function convertStrToLinks(link_url_strs,link_text_strs){
		var linkUrlArry = link_url_strs.split("---------rotarapes---------");
		var linkTextArry = link_text_strs.split("---------rotarapes---------");
		
		var linkEles = "";
		if(link_url_strs){
			for(var i = 0 ; i < linkUrlArry.length;i++){
				if(linkUrlArry[i]){
					linkEles+="<a href='"+linkUrlArry[i]+"' target=_blank>"+linkTextArry[i]+"</a>,";
				}
			}
		}
		linkEles+="";
		return linkEles;
	}
	function convertStrToImgs(img_strs){
		var srcArry = img_strs.split("---------rotarapes---------");
		var imgUrlEles = "";
		if(img_strs){
			for(var i = 0 ; i < srcArry.length;i++){
				if(srcArry[i]){
					imgUrlEles+="<div style='text-align:center;'><img src='"+srcArry[i]+"' width='400' style='margin:10px 0'/></div>";
				}
			}
		}
		return imgUrlEles;
	}
	function convertListToHtml(list){
		var html = "";
		for(var i = 0 ; i < list.length; i++){
			var list_i = list[i];
			var baseinfo_arr = list_i.split(":");
			var baseinfo_title = baseinfo_arr[0];
			var baseinfo_content = baseinfo_arr[1];
			html+="<b>"+baseinfo_title+":</b>"+baseinfo_content+",";
		}
		return html;
	}
	function deleteRow(ele){
		$(ele).parent().parent().remove();
	}
	function showOther(ele){
		$(ele).parent().next().show();
	}


	//正文事件--end
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


	/**
	** 实时入库
	*/
	function saveFatchListToDBRightNow(){
		$("#rule_dialog_div").html("");
		
		var id = $("div[name='id'] input").val();
		var textPageUrl = $("div[name='textPageUrl'] input").val();
		console.log(textPageUrl);
		saveFatchListToDB(".aui_buttons button:eq(0)",id,textPageUrl);	
	}
	/**
	* 实时入库
	*/
	function saveFatchListToDB(ele,id,textPageUrl){
		
		var url = "bdbk/saveFatchList?id="+id+"&textPageUrl="+textPageUrl;
		$.ajax({
			url:url,
			type:'POST',
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
				art.dialog.tips('入库成功!');
			}
		})
	}
</script>








