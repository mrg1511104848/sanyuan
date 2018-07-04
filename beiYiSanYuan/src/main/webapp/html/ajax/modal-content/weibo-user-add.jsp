<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">

</style>
<div class="modal-body">
	<div class="row">
		<div class="col-md-12">
			<form id="frmWBUserAdd" name="frmWBUserAdd" class="smart-form">
				<div class="pt-wrapper">
					<div class="pt-page pt-page-1 ">
						<div class="col-md-4">
							<section>
							<label class="label">
								用户微博名称(或者昵称)：
							</label>
							<label class="input-group col-xs-12 col-md-6 pull-left">
								<input type="text" class="form-control" style="width: 200px;padding-left:12px;"
									name="name" id="userName" value="${wbuser.name }"/>
								<input type="hidden" value="${wbuser.id  }" name="id" />
								<input type="hidden" class="form-control" style="width: 200px;padding-left:12px;"
									name="url" value="${wbuser.url }"/>
								<input type="hidden" class="form-control" style="width: 200px;padding-left:12px;"
									name="location" value="${wbuser.location }"/>
								<input type="hidden" class="form-control" style="width: 200px;padding-left:12px;"
									name="followersCount" value="${wbuser.followersCount }"/>
								<input type="hidden" class="form-control" style="width: 200px;padding-left:12px;"
									name="profileImageURL" value="${wbuser.profileImageURL }"/>
								<input type="hidden" class="form-control" style="width: 200px;padding-left:12px;"
									name="sysUserId" value="${wbuser.sysUserId }"/>
								<input type="hidden" class="form-control" style="width: 200px;padding-left:12px;"
									name="sysUserName" value="${wbuser.sysUserName }"/>
								<input type="hidden" class="form-control" style="width: 200px;padding-left:12px;"
									name="weibo4jUserId" value="${wbuser.weibo4jUserId }"/>
									
								<div class="input-group-btn">
										<button type="button" class="btn btn-default" onClick="getWeiboUserInfos()" style="padding: 6px 12px;margin-left: 5px">
											<i class="fa fa-fw fa-search fa-lg"></i>
										</button>
								</div>
							</label>
							</section>
							<div style="clear:both;"></div>
							<section>
							<div id="resultMsg" style="margin-top: 10px;"></div>
							</section>
							<section id="resultUserInfo">
								<div class="" style="
								    margin-top: 0px;
								    left: -19px;
								    top: 32px;
								    position: relative;
								" >
									<ul style="list-style-type: none;">
										<li style="padding-left: 20px;">
											<div id="resultUserInfoLoading"></div>
											<div id="u-info" style="display:none;">
											<span style="float: left;"> <a href="http://weibo.com/5000609535" target="_blank"> <img id="profileImageURL" ng-src="http://tp4.sinaimg.cn/5000609535/50/40042030871/1" class="online" src="http://tp4.sinaimg.cn/5000609535/50/40042030871/1"> </a> </span>
											<span class="message-text" style="margin: 0px 0px 5px 10px; float: left;">
												<p class="txt-color-purple">
													姓名：&nbsp;&nbsp;
													<span><a target="_blank" name="name" href="" id="name" ng-bind="UserObj.nick"  class="ng-binding"></a> </span>
													<i class="W_icon w_v"></i>
												</p>
												<p class="ng-binding">
													粉丝数：&nbsp;&nbsp; <span id="followersCount">10926726</span>&nbsp;
												</p>
												<p class="ng-binding">
													所在地：&nbsp;&nbsp; <span id="location">北京</span>&nbsp;
												</p> </span>
											</div>
											
										</li>
									</ul>
								</div>
							</section>
							<div id="no-info" style="display:none;margin-left: 80px;margin-top: 75px;">
								没有找到记录
							</div>
						</div>
						<div class="col-md-8">
							<blockquote style="padding: 9px 18px;">
								<span><h1>
										添加微博说明
									</h1> </span>
								<p class="font-sm padding-5">
									1、登录新浪微博粘贴复制用户的昵称或者名字
								</p>
								<p>
									<span class="font-sm">(新浪微博)图列说明：</span>
									<img src="/resources/img/weibo.png" />
								</p>
								<p class="font-sm padding-5">
									2、输入完毕后系统会自动验证微博是否存在，若不存在，
									系统会提示微博用户不存在，需要重新输入正确的信息
								</p>
							</blockquote>
						</div>
					</div>
				</div>
			</form>
		</div>

	</div>
</div>
<script type="text/javascript">
	pageSetUp();
	
</script>

