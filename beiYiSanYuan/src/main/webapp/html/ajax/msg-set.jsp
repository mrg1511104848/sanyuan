<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-home"></i> 消息设置</h1>
	</div>
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8">
	</div>
</div>
<!-- widget grid -->
<section id="widget-grid" class="">
	<!-- row -->
	<div class="row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

            <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-colorbutton="false" 
			 data-widget-editbutton="false"
			 data-widget-togglebutton="false"
			 data-widget-deletebutton="false"
			 data-widget-fullscreenbutton="false"
			>
                <header>
                    <span class="widget-icon"> <i class="fa fa-table"></i> </span>
                    <h2>消息设置</h2>

                </header>

                <!-- widget div-->
                <div>

                    <!-- widget edit box -->
                    <div class="jarviswidget-editbox">
                        <!-- This area used as dropdown edit box -->

                    </div>
                    <!-- end widget edit box -->

                    <!-- widget content -->
                    <div class="widget-body no-padding">
                        <form  class="smart-form" id="frmSetting">
                            <fieldset>
								<section>
									<label class="label">发送时间</label>
									<div class="row">
										<div class="col col-2">
											<label class="radio">
												<input type="radio" name="radio" checked="checked">
												<i></i>每日早晚</label>
										</div>
										<div class="col col-2">
											<label class="radio">
												<input type="radio" name="radio">
												<i></i>每日多次</label>
										</div>
									</div>
								</section>
							</fieldset>
							<fieldset>
								<section>
									<label class="label">发送方式</label>
									<div class="row">
										<div class="col col-2">
											<label class="checkbox">
												<input type="checkbox" name="checkbox" checked="checked">
												<i></i>短信</label>
											
										</div>
										<div class="col col-2">
										<label class="checkbox">
												<input type="checkbox" name="checkbox">
												<i></i>微信</label>
										</div>
										<div class="col col-2">
											<label class="checkbox">
												<input type="checkbox" name="checkbox">
												<i></i>邮件</label>
										</div>
									</div>
								</section>

							</fieldset>
                            <footer>
                                <div class="pull-left">
                                <button type="button" class="btn btn-primary" onclick="editSetting(this)">
                                    编辑
                                </button>
                              </div>
                            </footer>
                        </form>

                    </div>
                    <!-- end widget content -->

                </div>
                <!-- end widget div -->

            </div>
            <!-- end widget -->

        </article>
	</div>

	<!-- end row -->


</section>
<!-- end widget grid -->

<script type="text/javascript">

	pageSetUp();
	var pagefunction=function(){
        //getMainView();
    }
    function getMainView(){
         $.ajax({
             type:"get",
             url: "/system/getMonitorStrategy.html",
             dataType:"json",
             cache: false,
             success: function(msg){
                 $("#txtId").val(msg.aaData.id);
                 $("#homePageAlertWay").val(msg.aaData.homePageAlertWay);
                 $("#homePageFrequency").val(msg.aaData.homePageFrequency);
                 if(msg.aaData.homePageAvailable!=0){
                    $("#homePageAvailable").attr("checked","checked");
                 }
                 $("#linkAlertWay").val(msg.aaData.linkAlertWay);
                 $("#linkFrequency").val(msg.aaData.linkFrequency);
                 if(msg.aaData.linkAvailable!=0){
                     $("#linkAvailable").attr("checked","checked");
                 }
                 $("#infoAlertWay").val(msg.aaData.infoAlertWay);
                 $("#infoFrequency").val(msg.aaData.infoFrequency);
                 if(msg.aaData.infoAvailable!=0){
                     $("#infoAvailable").attr("checked","checked");
                 }
                 $("#sensitiveAlertWay").val(msg.aaData.sensitiveAlertWay);
                 $("#sensitiveFrequency").val(msg.aaData.sensitiveFrequency);
                 if(msg.aaData.sensitiveAvailable!=0){
                     $("#sensitiveAvailable").attr("checked","checked");
                 }
             }
         });
     }
    function editSetting(obj){

        if($.trim($(obj).text())=="编辑")
        {
            $(obj).text("保存");
            $(".table tr td").each(function(i,n){
                $(n).find(".state-disabled").removeClass("state-disabled");
                $(n).find("input").removeAttr("disabled");
                $(n).find("select").removeAttr("disabled");
            });
        }else{
            $(obj).text("编辑");

            $.ajax({
                type: "post",
                url: "/system/saveMonitorStrategy.html",
                data: {
                    id: $("#txtId").val(),
                    homePageAvailable:($("#homePageAvailable").is(':checked')==true?1:0),
                    homePageFrequency:$("#homePageFrequency").val(),
                    homePageAlertWay:$("#homePageAlertWay").val(),
                    linkFrequency:$("#linkFrequency").val(),
                    linkAlertWay:$("#linkAlertWay").val(),
                    linkAvailable:($("#linkAvailable").is(':checked')==true?1:0),
                    infoFrequency:$("#infoFrequency").val(),
                    infoAlertWay:$("#infoAlertWay").val(),
                    infoAvailable:($("#infoAvailable").is(':checked')==true?1:0),
                    sensitiveAvailable:($("#sensitiveAvailable").is(':checked')==true?1:0),
                    sensitiveFrequency:$("#sensitiveFrequency").val(),
                    sensitiveAlertWay:$("#sensitiveAlertWay").val()
                },
                success: function(data){
                    art.dialog.tips('操作成功!');
                }
            });

            $(".table tr td").each(function(i,n){
                $(n).find("label").addClass("state-disabled");
                $(n).find("input").attr("disabled","disabled");
                $(n).find("select").attr("disabled","disabled");
            });
        }

    }
    pagefunction();
</script>
