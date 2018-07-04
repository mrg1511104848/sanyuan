<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row">
	<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
		<h1 class="page-title txt-color-blueDark">
			<i class="fa fa-book "></i> 新闻
			<span>> API</span>
		</h1>
	</div>
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8"
		style="text-align: right;">
	</div>
</div>
<div class="row">
	<div class="col-sm-12">
		<div class="well">
			<h1>
				<span class="semi-bold">数据平台API</span> (新闻渠道数据)
				<sup class="badge bg-color-green bounceIn animated">
					v 1.0
				</sup>
				<br>
				<%--				<small class="text-danger slideInRight fast animated"><strong>Exclusive--%>
				<%--						to SmartAdmin!</strong>--%>
				<%--				</small>--%>
			</h1>
			<a href="javascript:void(0)" onclick="click_scroll('row1');" class="btn btn-info">数据平台读取文章接口（按时间戳和文章数）</a>
			<a href="javascript:void(0)" onclick="click_scroll('row2');" class="btn btn-info">数据平台读取文章接口（按起始时间和结束时间）</a>
		</div>
	</div>
</div>


<div class="row" id="row1">
	<div class="col-sm-12">
		<div class="well">
			<a name="a1"></a>
			<dt class="font-lg">
				/news/getNewsArticlesByTimestamp
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<dd>
				按照时间戳和文章长度来请求文章
			</dd>
			<br />
			<dt class="font-lg">
				URL
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<dd>
				http://data.huilan.com/news/getNewsArticlesByTimestamp
			</dd>
			<br />
			<dt class="font-lg">
				支持格式
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<dd>
				JSON
			</dd>
			<br />
			<dt class="font-lg">
				HTTP请求方式
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<dd>
				GET
			</dd>
			<br />
			<dt class="font-lg">
				是否需要登录
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<dd>
				是
			</dd>
			<br />
			<dt class="font-lg">
				请求参数
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<div class="table-responsive">
				<table class="table table-bordered table-striped hidden-mobile">
					<thead>
						<tr>
							<th>
								参数
							</th>
							<th>
								必选
							</th>
							<th>
								类型及范围
							</th>
							<th>
								说明
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								u
							</td>
							<td>
								true
							</td>
							<td>
								String
							</td>
							<td>
								用户名
							</td>
						</tr>
						<tr>
							<td>
								p
							</td>
							<td>
								true
							</td>
							<td>
								String
							</td>
							<td>
								密码
							</td>
						</tr>
						<tr>
							<td>
								g
							</td>
							<td>
								true
							</td>
							<td>
								String
							</td>
							<td>
								分组ID
							</td>
						</tr>
						<tr>
							<td>
								s
							</td>
							<td>
								true
							</td>
							<td>
								int
							</td>
							<td>
								想要获取的文章数量
							</td>

						</tr>
						<tr>
							<td>
								t
							</td>
							<td>
								true
							</td>
							<td>
								long
							</td>
							<td>
								时间戳
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<br />
			<dt class="font-lg">
				返回结果
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<span class="label bg-color-green">JSON示例</span>
			<div class="bs-example">
				<blockquote>
					<p>
						{
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"additionalAttribute": null,
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"author": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"categoryId": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"click": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"content":
						"海淀区政府、温泉镇政府决定向社会公开征集2015年政府实事项目，诚挚欢迎社会各界踊跃参与，献计献策。",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"htmlContent": "&lt;p
						class='content'&gt;海淀区政府、温泉镇政府决定向社会公开征集2015年政府实事项目，诚挚欢迎社会各界踊跃参与，献计献策。&lt;/p&gt;",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"id":
						"549cc86cf06620e6be56fd95",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"imgUrls": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"insertTime": "2014-12-26
						10:31:08",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"realUrl": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"reply": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"ruleId":
						"5487ef657c1f71e40c240bf0",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"section": "通知公告",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"sectionUrl":
						"http://hdwqz.bjhd.gov.cn/xwzx_new/tzgg/",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"site": "海淀区温泉镇",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"siteUrl":
						"http://hdwqz.bjhd.gov.cn",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"source": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"time": "2014-12-26 00:00:00",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"timeStamp": 1419561068841,
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"title":
						"关于面向社会公开征集2015年政府为民办实事项目意见建议的通知",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"url":
						"http://hdwqz.bjhd.gov.cn/xwzx_new/tzgg/201409/t20140926_635436.htm"
					</p>
					<p>
						}
					</p>
				</blockquote>
			</div>


			<br />
			<dt class="font-lg">
				返回字段说明
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<div class="table-responsive">
				<table class="table table-bordered table-striped hidden-mobile">
					<thead>
						<tr>
							<th>
								返回字段
							</th>
							<th>
								字段类型
							</th>
							<th>
								字段说明
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								additionalAttribute
							</td>
							<td>
								String
							</td>
							<td>
								额外字段
							</td>
						</tr>
						<tr>
							<td>
								author
							</td>
							<td>
								String
							</td>
							<td>
								作者
							</td>
						</tr>
						<tr>
							<td>
								categoryId
							</td>
							<td>
								String
							</td>
							<td>
								分类ID
							</td>
						</tr>
						<tr>
							<td>
								click
							</td>
							<td>
								int
							</td>
							<td>
								点击数
							</td>

						</tr>
						<tr>
							<td>
								content
							</td>
							<td>
								String
							</td>
							<td>
								正文内容
							</td>
						</tr>
						<tr>
							<td>
								htmlContent
							</td>
							<td>
								String
							</td>
							<td>
								带html标签的正文内容
							</td>
						</tr>
						<tr>
							<td>
								id
							</td>
							<td>
								String
							</td>
							<td>
								ID
							</td>
						</tr>
						<tr>
							<td>
								imgUrls
							</td>
							<td>
								String
							</td>
							<td>
								正文中包含的图片地址（多个以英文逗号分隔）
							</td>
						</tr>
						<tr>
							<td>
								insertTime
							</td>
							<td>
								String
							</td>
							<td>
								入库时间
							</td>
						</tr>
						<tr>
							<td>
								realUrl
							</td>
							<td>
								String
							</td>
							<td>
								该篇文章真实的URL（有一些特殊情况，比如iframe、页面多次跳转等等）
							</td>
						</tr>
						<tr>
							<td>
								reply
							</td>
							<td>
								int
							</td>
							<td>
								回复数
							</td>
						</tr>
						<tr>
							<td>
								ruleId
							</td>
							<td>
								String
							</td>
							<td>
								页面对应的规则ID
							</td>
						</tr>
						<tr>
							<td>
								section
							</td>
							<td>
								String
							</td>
							<td>
								页面版块名称
							</td>
						</tr>
						<tr>
							<td>
								sectionUrl
							</td>
							<td>
								String
							</td>
							<td>
								页面版块URL
							</td>
						</tr>
						<tr>
							<td>
								site
							</td>
							<td>
								String
							</td>
							<td>
								页面对应的站点名称
							</td>
						</tr>
						<tr>
							<td>
								siteUrl
							</td>
							<td>
								String
							</td>
							<td>
								页面对应的站点URL
							</td>
						</tr>
						<tr>
							<td>
								source
							</td>
							<td>
								String
							</td>
							<td>
								来源
							</td>
						</tr>
						<tr>
							<td>
								time
							</td>
							<td>
								String
							</td>
							<td>
								发布时间
							</td>
						</tr>
						<tr>
							<td>
								timeStamp
							</td>
							<td>
								long
							</td>
							<td>
								该文章的时间戳（取文章的时候用）
							</td>
						</tr>
						<tr>
							<td>
								title
							</td>
							<td>
								String
							</td>
							<td>
								标题
							</td>
						</tr>
						<tr>
							<td>
								url
							</td>
							<td>
								String
							</td>
							<td>
								正文页URL
							</td>
						</tr>
					</tbody>
				</table>
			</div>

		</div>
	</div>
</div>

<div class="row" id="row2">
	<div class="col-sm-12">
		<div class="well">
			<a name="2"></a>
			<dt class="font-lg">
				/news/getNewsArticlesByPeriods
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<dd>
				按照起始时间和结束时间来请求文章
			</dd>
			<br />
			<dt class="font-lg">
				URL
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<dd>
				http://data.huilan.com/news/getNewsArticlesByPeriods
			</dd>
			<br />
			<dt class="font-lg">
				支持格式
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<dd>
				JSON
			</dd>
			<br />
			<dt class="font-lg">
				HTTP请求方式
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<dd>
				GET
			</dd>
			<br />
			<dt class="font-lg">
				是否需要登录
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<dd>
				是
			</dd>
			<br />
			<dt class="font-lg">
				请求参数
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<div class="table-responsive">
				<table class="table table-bordered table-striped hidden-mobile">
					<thead>
						<tr>
							<th>
								参数
							</th>
							<th>
								必选
							</th>
							<th>
								类型及范围
							</th>
							<th>
								说明
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								u
							</td>
							<td>
								true
							</td>
							<td>
								String
							</td>
							<td>
								用户名
							</td>
						</tr>
						<tr>
							<td>
								p
							</td>
							<td>
								true
							</td>
							<td>
								String
							</td>
							<td>
								密码
							</td>
						</tr>
						<tr>
							<td>
								g
							</td>
							<td>
								true
							</td>
							<td>
								String
							</td>
							<td>
								分组ID
							</td>
						</tr>
						<tr>
							<td>
								s
							</td>
							<td>
								true
							</td>
							<td>
								int
							</td>
							<td>
								想要获取的文章数量
							</td>

						</tr>
						<tr>
							<td>
								t
							</td>
							<td>
								true
							</td>
							<td>
								long
							</td>
							<td>
								时间戳
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<br />
			<dt class="font-lg">
				返回结果
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<span class="label bg-color-green">JSON示例</span>
			<div class="bs-example">
				<blockquote>
					<p>
						{
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"additionalAttribute": null,
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"author": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"categoryId": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"click": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"content":
						"海淀区政府、温泉镇政府决定向社会公开征集2015年政府实事项目，诚挚欢迎社会各界踊跃参与，献计献策。",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"htmlContent": "&lt;p
						class='content'&gt;海淀区政府、温泉镇政府决定向社会公开征集2015年政府实事项目，诚挚欢迎社会各界踊跃参与，献计献策。&lt;/p&gt;",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"id":
						"549cc86cf06620e6be56fd95",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"imgUrls": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"insertTime": "2014-12-26
						10:31:08",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"realUrl": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"reply": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"ruleId":
						"5487ef657c1f71e40c240bf0",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"section": "通知公告",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"sectionUrl":
						"http://hdwqz.bjhd.gov.cn/xwzx_new/tzgg/",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"site": "海淀区温泉镇",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"siteUrl":
						"http://hdwqz.bjhd.gov.cn",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"source": "",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"time": "2014-12-26 00:00:00",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"timeStamp": 1419561068841,
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"title":
						"关于面向社会公开征集2015年政府为民办实事项目意见建议的通知",
					</p>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"url":
						"http://hdwqz.bjhd.gov.cn/xwzx_new/tzgg/201409/t20140926_635436.htm"
					</p>
					<p>
						}
					</p>
				</blockquote>
			</div>


			<br />
			<dt class="font-lg">
				返回字段说明
			</dt>
			<hr style="margin-top: 5px; margin-bottom: 5px;"></hr>
			<div class="table-responsive">
				<table class="table table-bordered table-striped hidden-mobile">
					<thead>
						<tr>
							<th>
								返回字段
							</th>
							<th>
								字段类型
							</th>
							<th>
								字段说明
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								additionalAttribute
							</td>
							<td>
								String
							</td>
							<td>
								额外字段
							</td>
						</tr>
						<tr>
							<td>
								author
							</td>
							<td>
								String
							</td>
							<td>
								作者
							</td>
						</tr>
						<tr>
							<td>
								categoryId
							</td>
							<td>
								String
							</td>
							<td>
								分类ID
							</td>
						</tr>
						<tr>
							<td>
								click
							</td>
							<td>
								int
							</td>
							<td>
								点击数
							</td>

						</tr>
						<tr>
							<td>
								content
							</td>
							<td>
								String
							</td>
							<td>
								正文内容
							</td>
						</tr>
						<tr>
							<td>
								htmlContent
							</td>
							<td>
								String
							</td>
							<td>
								带html标签的正文内容
							</td>
						</tr>
						<tr>
							<td>
								id
							</td>
							<td>
								String
							</td>
							<td>
								ID
							</td>
						</tr>
						<tr>
							<td>
								imgUrls
							</td>
							<td>
								String
							</td>
							<td>
								正文中包含的图片地址（多个以英文逗号分隔）
							</td>
						</tr>
						<tr>
							<td>
								insertTime
							</td>
							<td>
								String
							</td>
							<td>
								入库时间
							</td>
						</tr>
						<tr>
							<td>
								realUrl
							</td>
							<td>
								String
							</td>
							<td>
								该篇文章真实的URL（有一些特殊情况，比如iframe、页面多次跳转等等）
							</td>
						</tr>
						<tr>
							<td>
								reply
							</td>
							<td>
								int
							</td>
							<td>
								回复数
							</td>
						</tr>
						<tr>
							<td>
								ruleId
							</td>
							<td>
								String
							</td>
							<td>
								页面对应的规则ID
							</td>
						</tr>
						<tr>
							<td>
								section
							</td>
							<td>
								String
							</td>
							<td>
								页面版块名称
							</td>
						</tr>
						<tr>
							<td>
								sectionUrl
							</td>
							<td>
								String
							</td>
							<td>
								页面版块URL
							</td>
						</tr>
						<tr>
							<td>
								site
							</td>
							<td>
								String
							</td>
							<td>
								页面对应的站点名称
							</td>
						</tr>
						<tr>
							<td>
								siteUrl
							</td>
							<td>
								String
							</td>
							<td>
								页面对应的站点URL
							</td>
						</tr>
						<tr>
							<td>
								source
							</td>
							<td>
								String
							</td>
							<td>
								来源
							</td>
						</tr>
						<tr>
							<td>
								time
							</td>
							<td>
								String
							</td>
							<td>
								发布时间
							</td>
						</tr>
						<tr>
							<td>
								timeStamp
							</td>
							<td>
								long
							</td>
							<td>
								该文章的时间戳（取文章的时候用）
							</td>
						</tr>
						<tr>
							<td>
								title
							</td>
							<td>
								String
							</td>
							<td>
								标题
							</td>
						</tr>
						<tr>
							<td>
								url
							</td>
							<td>
								String
							</td>
							<td>
								正文页URL
							</td>
						</tr>
					</tbody>
				</table>
			</div>

		</div>
	</div>
</div>
<script type="text/javascript">
	function click_scroll(row) {
		var scroll_offset = $("#"+row).offset();
		$("body,html").animate( {
			scrollTop : scroll_offset.top
		}, 100);
	}
</script>