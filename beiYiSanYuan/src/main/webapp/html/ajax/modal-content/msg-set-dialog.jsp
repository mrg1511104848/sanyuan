<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

                    <!-- widget content -->
                    <div class="widget-body">
                        <form  class="smart-form" id="frmSetting">
                        	<input type="hidden" name="id" />
                        	<fieldset id="state">
								<div class="row">
									<section class="col col-5">
										<label class="toggle state-error"><input type="checkbox" name="checkbox-toggle" class="state"><i data-swchon-text="开启" data-swchoff-text="关闭"></i>状态</label>
									</section>
								</div>
							</fieldset>
                            <fieldset id="sendType">
								<section>
									<label class="label">发送时间</label>
									<div class="row">
											<div class="col col-2">
											
												<label class="radio">
													<input type="radio" name="radio" checked="checked" class="sendType">
													<i></i>每日早晚</label>
												
											</div>
											<div class="col col-2">
												<label class="radio">
														<input type="radio" name="radio"  class="sendType">
														<i></i>每日多次</label>
											</div>
									</div>
								</section>
							</fieldset>
							<fieldset id="sendWay">
								<section>
									<label class="label">发送方式</label>
									<div class="row">
										<div class="col col-2">
											<label class="checkbox">
												<input type="checkbox" name="checkbox"  sendWay="1"  class="sendWay">
												<i></i>短信</label>
											
										</div>
										<div class="col col-2">
											<label class="checkbox">
												<input type="checkbox" name="checkbox"   class="sendWay"  sendWay="2">
												<i></i>邮件</label>
										</div>
										<div class="col col-2">
										<label class="checkbox">
												<input type="checkbox" name="checkbox"   class="sendWay"  sendWay="3">
												<i></i>微信</label>
										</div>
									</div>
								</section>

							</fieldset>
                        </form>

                    </div>
                    <!-- end widget content -->


<script type="text/javascript">

	pageSetUp();
	var pagefunction=function(){
        getMainView();
    }
    function getMainView(){
         $.ajax({
             type:"get",
             url: "/msg/getMessageSet.html",
             dataType:"json",
             cache: false,
             success: function(msg){
             	 var messageSet = msg.messageSet;
             	 var sendType = messageSet.sendType;
             	 var sendWay = messageSet.sendWay;
             	 var state = messageSet.state;
                 $(".sendType:eq("+(sendType-1)+")").attr("checked","checked");
                 for(var i = 0 ; i < sendWay.length ;i++ ){
                 		var sWayEach = sendWay[i];
                 		$(".sendWay:eq("+(sWayEach-1)+")").attr("checked","checked");
                 }
                 $("#frmSetting [name=id]").val(messageSet.id);
                 if(state==1){
                 	$("#state .state")[0].checked = true;
                 }
             }
         });
     }
    pagefunction();
</script>
