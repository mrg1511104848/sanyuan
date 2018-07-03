function InfoEdit() {
    this.rowObj = null;
    this.oTable = null;
    this.oDialog = null;
    this.frmName = "";
    this.requestUrl = "";
    this.frmValite=null;
}
InfoEdit.prototype.Save = function() {

    if (this.frmValite.form()) {
        var obj=this;
        $("#" + this.frmName).ajaxSubmit( {
            beforeSubmit :this.showRequest,
            success :  function(responseText, statusText){
                if (responseText.success)
                {
                    obj.closeWin();
                    MessageBoxShow("保存成功", true);
                    obj.oTable.fnClearTable();
                } else {
                    MessageBoxShow("保存失败", false);
                }
            },
            url : "/" + this.requestUrl + "/saveOrUpdate",
            type : "post",
            dataType : 'json',
            resetForm : false
        });
    }
}
InfoEdit.prototype.getRowData = function() {
    if (this.oTable!=null && this.rowObj != null) {
        var obj = this.oTable.fnGetData(this.rowObj);

        $("#" + this.frmName + " [name]").jsontoform(obj,"id","txt_");
    } else {
        $(':input', '#' + this.frmName).not(':button, :submit, :reset, :radio').val('').removeAttr('checked').removeAttr('selected');
    }
}
InfoEdit.prototype.showRequest = function(formData, jqForm, options) {
    var queryString = $.param(formData);
    return true;
}
InfoEdit.prototype.showResponse = function(responseText, statusText) {
    if (responseText.success)
    {
        MessageBoxShow("保存成功", true);
        this.oTable.fnClearTable();
    } else {
        MessageBoxShow("保存失败", false);
    }
}
InfoEdit.prototype.closeWin = function() {
    this.rowObj=null;
    this.oDialog.modal('hide');
}
InfoEdit.prototype.deleteRow = function(id,p2) {
    var title = '操作确认';
    var htm = "<div style='padding:10px;color:red;'>确认要删除吗?<br/> <div style='display:none;'><input name='del_id' id='site_allrule_del_id'/></div></div>";
    var editObj=this;
    var dialog = art.dialog({
        id:"rule_dialog",
        title: title,
        width: 'auto',    // 内容宽度
        height: 'auto',    // 内容高度
        content: htm,
        padding: '0px 0px',
        lock:true,
        button:[{
            name:"确认",
            callback:function(){
                var data = "id=" + id;
                if(p2){
                    data+="&"+p2;
                }
                $.ajax( {
                    type : "GET",
                    url : "/"+editObj.requestUrl+"/delete",
                    data : data,
                    dataType : 'json',
                    success : function(msg) {
                        if (msg.success) {
                            MessageBoxShow("删除成功", true);
                            editObj.oTable.fnClearTable();
                        } else {
                            MessageBoxShow("删除失败", false);
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

}
InfoEdit.prototype.changeAttrState=function (exp,key) {

}
InfoEdit.prototype.changeRecipeState=function (t,recipeId,state) {
    var editObj=this;
    console.log(this);
    //审核药方
    if(state==0){
        //通过
        $.ajax( {
            type : "POST",
            url : "/"+editObj.requestUrl+"/changeRecipeState",
            data : {"eq_recipeId":recipeId,"state":"0"},
            dataType : 'json',
            success : function(msg) {
                console.log(msg);
                if (msg) {
                    app_edit.oTable.fnDraw(); //重新加载数据
                    MessageBoxShow('成功!',true);
                }
            }
        });

    }else{
       // 不通过
        var s=t.parent().parent().children();
        var l ="{";
        var d ="\"eq_recipeId\":"+recipeId+",";
        for(var i=4;i<s.length-1;i++){
            console.log($(s)[i].firstChild);
            var e=$(s)[i].firstChild;
           d=d+"\""+$(e).attr("name")+"\""+":"+$(e).attr("value")+",";
        };
        l=l+d.substr(0,d.length-1)+"}";
        console.log(l);
        openRecipeDialog(l);
    }


}
InfoEdit.prototype.getPatientInfo=function (id) {
    openDialog(id);
}
InfoEdit.prototype.getMessageInfo=function (recipeId) {
    openMessageDialog(recipeId);
}
