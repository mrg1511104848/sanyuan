$(function() {	
	init();
});
function init(){
	initFormValues();
	switchFragment();
}
function switchFragment(){
	switchFragmentCommon();//为fragment赋值
	$("[name=type]").change(function(){
		switchFragmentCommon('change');
	});
}
/**
 * 初始化fragment
 * @param type
 * @return
 */
function switchFragmentCommon(type){
	var fragment = '';
	if(!type){
		if($("#hide_fragment").val()){
			fragment = $("#hide_fragment").val();
		}
	}
	var $htm = '';
	console.log("$$"+$("select[name=type]").val());
	if($("[name=type]").val()=='0003'){
		$htm = '<textarea class="form-control" type="text" name="fragment" id="txt_fragment"  >'+fragment+'</textarea>';
	}else{
		$htm = '<input class="form-control" type="text" name="fragment" id="txt_fragment"  value="'+fragment+'"/>';
	}
	$(".fragment").html($htm);
}
function initFormValues(){
	initSelect('type');
}
function common(url,dataName,selectName,optionVal,optionTxt,functionName,otherParam0,otherParam1,otherParam2){
	
		$.ajax({
			url:url,
			type:'post',
			dataType:"json",
			success:function(d){
				try{
					var options = '<option value=" ">请选择</option>';
					for(var i = 0; i<d[dataName].length; i++){
						var each = d[dataName][i];
						options+='<option value="'+each[optionVal]+'">'+each[optionTxt]+'</option>';
					}
					$("select[name='"+selectName+"']").html(options);
					if(functionName){
						callFunction(functionName,d,otherParam0,otherParam1,otherParam2);
					}
				}catch(e){}
			}
		})
	
}
