<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>jQuery Lightbox（balupton版）图片展示插件demo</title>
<style type="text/css">
body{font-size:84%; color:#333333; line-height:1.4;}
p{padding:0 40px;}
h1{font-size:1.8em; text-align:center; margin:30px 10px;}
h3{margin:30px 10px 10px;}
img{border:none; vertical-align:middle;}
li{padding:3px 40px 3px 0;}
.code{padding:10px; margin:5px 40px; font-size:12px; background:#eeeeee; border:1px dashed #cccccc; clear:both; zoom:1;}
.code pre{margin:0; color:#00F; white-space:pre-wrap; word-wrap:break-word;}
#footer{padding:30px 0 ; text-align:center;}
#footer a{color:#34538b;}
#footer a:hover{text-decoration:none; color:#333333;}
</style>
<!-- 引入 Lightbox (可编辑文件) -->
<!--<script type="text/javascript" src="../js/jquery.lightbox.js"></script>-->
<!-- 引入 Lightbox (压缩文件,没有linkback) -->
<!--<script type="text/javascript" src="../js/jquery.lightbox.min.js?show_linkback=false"></script>-->
<!-- 引入 Lightbox (压缩文件, 人工添加baseurl) -->
<!--<script type="text/javascript" src="../js/jquery.lightbox.min.js?baseurl=http://www.your.com/baseurl/jquery_lightbox/"></script>-->
<!-- 引入 Lightbox (压缩文件, 滚动禁用) -->
<!--<script type="text/javascript" src="../js/jquery.lightbox.min.js?scroll=disabled"></script>-->
<!-- 引入 Lightbox (压缩文件, 支持colorBlend) -->
<!--<script type="text/javascript" src="../js/jquery.lightbox.min.js?colorBlend=true"></script>-->
<!-- 引入 Lightbox (压缩文件, 没有linkback + 滚动禁用) -->
<!--<script type="text/javascript" src="../js/jquery.lightbox.min.js?show_linkback=false&amp;scroll=disabled"></script>-->
</head>

<body>
<h1>jQuery Lightbox（balupton版）图片展示插件demo</h1>
<h3>一、Lightbox Tour</h3>
<div class="code"><pre>&lt;a href="http://image.zhangxinxu.com/image/study/s/s512/mm1.jpg" rel="lightbox-tour" title="张含韵小美女"&gt;</pre></div>
<p>
	<a href="http://image.zhangxinxu.com/image/study/s/s512/mm1.jpg" rel="lightbox-tour" title="张含韵小美女">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm1.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm3.jpg" rel="lightbox-tour" title="某不知名美女1">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm3.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm4.jpg" rel="lightbox-tour" title="某不知名美女2">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm4.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm5.jpg" rel="lightbox-tour" title="某不知名美女3: 谢谢，这是最后一张图片">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm5.jpg" />
    </a>
</p>
<p><strong>简要说明</strong></p>
<ul>
	<li>这里a标签的rel值是lightbox-tour，JavaScript文件通过a标签的rel属性自动判断是否要执行lightbox效果</li>
    <li>显示的图片信息来自a标签的title属性，title内部的文字通过英文的":"冒号属性区分描述的标题和内容，标题样式为粗体，默认含图片链接，内容文字粗细正常，原项目CSS中此处字体大小为10px，但是对于中文而言，10px偏小，所以我已经改为12像素。</li>
    <li>大图的链接地址直接写在a标签的href上，有时HTML DOM tree尚未完全加载是点击a标签会直接打开图片，可以用name代替href解决这一问题，需修改原JavaScript文件。</li>
</ul>
<h3>二、自动创建lightbox组</h3>
<div class="code"><pre>&lt;a href="http://image.zhangxinxu.com/image/study/s/s512/mm1.jpg" rel="lightbox-myGroup" title="张含韵小美女"&gt;</pre></div>
<p>
	<a href="http://image.zhangxinxu.com/image/study/s/s512/mm1.jpg" rel="lightbox-myGroup" title="张含韵小美女">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm1.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm3.jpg" rel="lightbox-myGroup" title="某不知名美女1">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm3.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm4.jpg" rel="lightbox-myGroup" title="某不知名美女2">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm4.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm5.jpg" rel="lightbox-myGroup" title="某不知名美女3: 谢谢，这是最后一张图片">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm5.jpg" />
    </a>
</p>
<p><strong>简要说明</strong></p>
<ul>
	<li>这里a标签的rel值是lightbox-myGroup，所谓分组，就是JavaScript会将rel属性一致的a标签划分为一组。只要a标签的rel属性以"lightbox- * "为结构。都可以触发lightbox效果。所以这里的效果与上面Lightbox Tour是一样的，这里的rel改为"lightbox-my"也是一样的效果。</li>
</ul>
<h3>三、独立的lightbox效果</h3>
<div class="code"><pre>&lt;a href="http://image.zhangxinxu.com/image/study/s/s512/mm1.jpg" rel="lightbox" title="张含韵小美女"&gt;</pre></div>
<p>
	<a href="http://image.zhangxinxu.com/image/study/s/s512/mm1.jpg" rel="lightbox" title="张含韵小美女">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm1.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm3.jpg" rel="lightbox" title="某不知名美女1">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm3.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm4.jpg" rel="lightbox" title="某不知名美女2">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm4.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm5.jpg" rel="lightbox" title="某不知名美女3: 谢谢，这是最后一张图片">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm5.jpg" />
    </a>
</p>
<p><strong>简要说明</strong></p>
<ul>
	<li>与上面分组示例唯一的差别就是这里a标签的rel值是lightbox，没有任何后缀。这里的lightbox就是关键，当rel为lightbox时，JavaScript会将此a标签下的img图片当作一个独立的个体来处理，即没有“上一张”，“下一张”的图片切换。</li>
</ul>
<h3>四、手动创建分组</h3>
<div class="code"><pre>&lt;a href="http://image.zhangxinxu.com/image/study/s/s512/mm1.jpg" title="张含韵小美女"&gt;

$(function(){
	$("#manualGroup a").lightbox();		   
});
</pre></div>
<p id="manualGroup">
	<a href="http://image.zhangxinxu.com/image/study/s/s512/mm1.jpg" title="张含韵小美女">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm1.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm3.jpg" title="某不知名美女1">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm3.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm4.jpg" title="某不知名美女2">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm4.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm5.jpg" title="某不知名美女3: 谢谢，这是最后一张图片">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm5.jpg" />
    </a>
</p>
<script type="text/javascript">
$(function(){
	$("#manualGroup a").lightbox();		   
});
</script>
<p><strong>简要说明</strong></p>
<ul>
	<li>这里与上面不同，上面的实例都是通过a标签的rel值判断是否是要应用lightbox效果。而这里没有rel属性，是手动创建分组，方法就是$("选择器").lightbox();</li>
    <li>本实例可以说是最简单的手动创建lightbox效果的例子了，lightbox效果还有其他的些方法，下面会有简要介绍。</li>
</ul>
<h3>五、一些参数使用举例</h3>
<div class="code"><pre>&lt;a href="http://image.zhangxinxu.com/image/study/s/s512/mm1.jpg" title="张含韵小美女"&gt;

$(function(){
    $("#paramsTest a").lightbox();	
    <span style="color:#999999;">//------------------</span>
    $.Lightbox.construct({
        show_linkback: false,
        opacity: 0.6,
        text: {
            image: '照片'
        }
    });		   
});
</pre></div>
<p id="paramsTest">
	<a href="http://image.zhangxinxu.com/image/study/s/s512/mm1.jpg" title="张含韵小美女">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm1.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm2.jpg" title="某不知名美女1">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm2.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm3.jpg" title="某不知名美女2">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm3.jpg" />
    </a>
    <a href="http://image.zhangxinxu.com/image/study/s/s512/mm4.jpg" title="某不知名美女3: 谢谢，这是最后一张图片">
    	<img src="http://image.zhangxinxu.com/image/study/s/s128/mm4.jpg" />
    </a>
</p>
<p><strong>简要说明</strong></p>
<ul>
	<li>这里示例的几个参数有三个，依次表示：是否显示右上角的反向链接（false不显示），黑色覆盖层透明度（0.6，默认是0.9），其中的一个文字替换为“照片”（原来是“图片”，原项目js中为"image"）</li>
    <li>为了显示效果是由于这里的点击失效的，所以js代码中添加了一个简单的判读。</li>
    <li>此插件参数总共将近20个，关于这些参数的些详细信息您可以点击<a href="../">这里</a>。</li>
</ul>
<script type="text/javascript">
$(function(){
	$("#paramsTest a").lightbox();
	//-------------------------------
	$("body > p > a").mousedown(function(){
		if($(this).parent().attr("id") === "paramsTest"){
			$.Lightbox.construct({
				show_linkback: false,
				opacity: 0.6,
				text: {
					image: '照片'
				}
			});	
		}else{
			$.Lightbox.construct({
				show_linkback: true,
				opacity: 0.9,
				text: {
					image: '图片'
				}
			});	
		}
		return false;
	});		   
});
</script>
<div id="footer">Copyright &copy; by <a href="http://www.zhangxinxu.com/">张鑫旭-鑫空间-鑫生活</a> | <a href="http://www.zhangxinxu.com/wordpress/?p=575">相关文章</a></div>
</body>
</html>
