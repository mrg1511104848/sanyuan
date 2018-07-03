function openDialog(obj,id,sureFunctionName,notSureFunctionName,d,d2,d3,d4)
{
	if(!id){id=""}
	loadingShow();
	$("#remoteModal").load("/app/edit?eq_id="+id,function(){
		var dialog = window.top.art.dialog({
			title: "详情",
			content: $("#remoteModal")[0],
			width:"500px",
			padding: '0px 0px',
			lock:true,
			button:[{
				name:"保存",
		    	callback:function(){
					var url = "app/saveOrUpdate";
					var data= $("#frmApp").serialize();
					$.ajax({
							url:url,
							data:data,
							type:"POST",
							success:function(data){
								if(data){
									dialog.close();
									try{
										if(app_edit){
											app_edit.oTable.fnDraw(); //重新加载数据
										}
									}catch(e){}
									MessageBoxShow('保存成功!',true);
									if(sureFunctionName){
										callFunction(sureFunctionName,d,d2,d3,d4);
									}
								}
							}
					});
				}
			},{
				name:"取消",
				callback:function(){
					console.log(notSureFunctionName);
					if(notSureFunctionName){
						callFunction(notSureFunctionName,d);
					}
					dialog.close();
				}
			}],
			init: function () {
		    	changeArtdialogButtonCss();
		    }
		});
		
		$(".aui_content").css("width","100%");
		loadingHide();
		dialogCenterScreen(dialog);
	});
}
function confirm(title,content,sureFunctionName,notSureFunctionName,d,d2){
	var dialog = art.dialog({
			    title: title,
			    width: 'auto',    // 内容宽度
 				height: 'auto',    // 内容高度
			    content: content,
			    padding: '0px 0px',
			    lock:true,
			    button:[{
			    	name:"确认",
			    	callback:function(){
				    	if(sureFunctionName){
							callFunction(sureFunctionName,d,d2);
						}
			    	}
			    },{
			    	name:"取消",
			    	callback:function(){
				    	if(notSureFunctionName){
							callFunction(notSureFunctionName);
						}
			    	}
			    }],
			    init: function () {
			    	changeArtdialogButtonCss();
			    }
	});
}
