<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>定时器帮助文档</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		*{
			padding:0;
			margin:0;
		}
		#header {
		    background-color: #f3f3f3;
		    background-image: linear-gradient(to bottom, #f3f3f3, #e2e2e2);
		    background-repeat: repeat-x;
		    display: block;
		    height: 49px;
		    margin: 0;
		    padding: 0 13px 0 0;
		    position: relative;
		    z-index: 905;
		}
		#logo-group{
			padding-left:20px;
		}
		
		#content {
		    padding: 17px 200px;
		}
		
		body h1 {
		    font-family: "Microsoft Yahei";
		    font-size: 30px;
		}
	</style>
  </head>
  
  <body>
    	<header id="header">
			<div id="logo-group">
				<h3 style="color: #000!important;font-weight: bold;padding: 8px 0;font-size: 16px;"><img width="30" src="/resources/img/logo01.jpg" alt="" style="vertical-align: middle;"> <span>中科汇联数据采集平台</span></h3>
			</div>
		</header>
		<div id="content">
			<h1 style="margin-bottom:10px;">
				定时器表达式	
			</h1>
			<div>
				<p>字段 允许值 允许的特殊字符</p>
				   

				<p>秒 0-59 , - * /   </p>
				
				<p>分 0-59 , - * /   </p>
				
				<p>小时 0-23 , - * /   </p>
				
				<p>日期 1-31 , - * ? / L W C   </p>
				
				<p>月份 1-12 或者 JAN-DEC , - * /   </p>
				
				<p>星期 1-7 或者 SUN-SAT , - * ? / L C #   </p>
				
				<p>年（可选） 留空, 1970-2099 , - * /   </p>
				
				<p>表达式意义   </p>
				
				<p>"0 0 12 * * ?" 每天中午12点触发   </p>
				
				<p>"0 15 10 ? * *" 每天上午10:15触发   </p>
				
				<p>"0 15 10 * * ?" 每天上午10:15触发   </p>
				
				<p>"0 15 10 * * ? *" 每天上午10:15触发   </p>
				
				<p>"0 15 10 * * ? 2005" 2005年的每天上午10:15触发   </p>
				
				<p>"0 * 14 * * ?" 在每天下午2点到下午2:59期间的每1分钟触发   </p>
				
				<p>"0 0/5 14 * * ?" 在每天下午2点到下午2:55期间的每5分钟触发   </p>
				
				<p>"0 0/5 14,18 * * ?" 在每天下午2点到2:55期间和下午6点到6:55期间的每5分钟触发   </p>
				
				<p>"0 0-5 14 * * ?" 在每天下午2点到下午2:05期间的每1分钟触发   </p>
				
				<p>"0 10,44 14 ? 3 WED" 每年三月的星期三的下午2:10和2:44触发   </p>
				
				<p>"0 15 10 ? * MON-FRI" 周一至周五的上午10:15触发   </p>
				
				<p>"0 15 10 15 * ?" 每月15日上午10:15触发   </p>
				
				<p>"0 15 10 L * ?" 每月最后一日的上午10:15触发   </p>
				
				<p>"0 15 10 ? * 6L" 每月的最后一个星期五上午10:15触发   </p>
				
				<p>"0 15 10 ? * 6L 2002-2005" 2002年至2005年的每月的最后一个星期五上午10:15触发  </p>
				
				
				
				
				<p>"0 15 10 ? * 6#3" 每月的第三个星期五上午10:15触发   </p>

				<p>每天早上6点   </p>
				
				<p>0 6 * * *   </p>
				
				<p>每两个小时   </p>
				
				<p>0 */2 * * *   </p>
				
				<p>晚上11点到早上8点之间每两个小时，早上八点   </p>
				
				<p>0 23-7/2，8 * * *   </p>
				
				<p>每个月的4号和每个礼拜的礼拜一到礼拜三的早上11点   </p>
				
				<p>0 11 4 * 1-3   </p>
				
				<p>1月1日早上4点   </p>
				
				<p>0 4 1 1 *   </p>
				
				<p>有些子表达式能包含一些范围或列表  </p>
				
				<p>例如：子表达式（天（星期））可以为 “MON-FRI”，“MON，WED，FRI”，“MON-WED,SAT”  </p>
				
				<p>“*”：字符代表所有可能的值  </p>
				
				<p>因此，“*”在子表达式（月）里表示每个月的含义，“*”在子表达式（天（星期））表示星期的每一天  </p>
				
				<p>“/”：字符用来指定数值的增量  </p>
				
				<p>例如：在子表达式（分钟）里的“0/15”表示从第0分钟开始，每15分钟 ; </p>
				
				<p>在子表达式（分钟）里的“3/20”表示从第3分钟开始，每20分钟（它和“3，23，43”）的含义一样  </p>
				
				<p>“？”：字符仅被用于天（月）和天（星期）两个子表达式，表示不指定值  </p>
				
				<p>当2个子表达式其中之一被指定了值以后，为了避免冲突，需要将另一个子表达式的值设为“？”  </p>
				
				<p>“L”： 字符仅被用于天（月）和天（星期）两个子表达式，它是单词“last”的缩写  </p>
				
				<p>但是它在两个子表达式里的含义是不同的。  </p>
				
				<p>在天（月）子表达式中，“L”表示一个月的最后一天 , </p>
				
				<p>在天（星期）自表达式中，“L”表示一个星期的最后一天，也就是SAT  </p>
				
				<p>如果在“L”前有具体的内容，它就具有其他的含义了  </p>
				
				<p>例如：“6L”表示这个月的倒数第６天，“ＦＲＩＬ”表示这个月的最后一个星期五  </p>
				
				<p>注意：在使用“L”参数时，不要指定列表或范围，因为这会导致问题 </p>
			</div>
		</div>
  </body>
</html>
