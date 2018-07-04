<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<style>
::selection {
	background: #eb7350;
	color: #fff;
}
</style>


<style>
  .tmp_div { margin:3px; width:40px; height:40px;
        position:absolute; left:0px; top:30px; 
        background:green; display:none; }
  .tmp_div.newcolor { background:blue; }
  .tmp_span { color:red; }
  
  
  
  .tmp_div2 { margin:3px; width:40px; height:40px;
        position:absolute; left:0px; top:30px; 
        background:green; display:none; }
  .tmp_div2.newcolor { background:blue; }

  
  
</style>

<style>
.tmp_div3 { margin:3px; width:40px; height:40px;
        position:absolute; left:0px; top:30px; 
        background:green; display:none; }
.tmp_div3.newcolor { background:blue; }
</style>
  
<script>
pageSetUp();

var pagefunction = function() {


	


}; 

// end pagefunction

// run pagefunction


	$(function(){
		
		/*
		var callbacks = $.Callbacks();
		callbacks.add( a );
		callbacks.add( b );
		callbacks.add( c );
		callbacks.fire();  

		var j = {'test': 1};
		alert( j.test );*/
		$(".datepicker").datepicker();



		$(".tem_p").append( $("input").map(function(){
			  return $(this).val();
		}).get().join(", ") );
	});
	function a(){
		console.log(1);
	}
	function b(){
		console.log(2);
	}
	function c(){
		console.log(3);
	}
	function d(){
		console.log(4);
	}


	var obj = {
		name: "John",
		test: function() {
			console.log(this);
			alert( this.name );
			$("#test").unbind("click", obj.test);
	    }
	};
	//两个执行的不一样(obj作用域不同)
	$("#test").click( jQuery.proxy( obj, "test" ) );//1
	//$("#test").click( obj.test );//2
	
	function deleteRepeatDOM(){
		console.log("run");
		$.unique($(".aaa")[0]);
	}


	pagefunction();



	$("#show").click(function () {
	      var n = $(".tmp_div").queue("fx");
	      $("span").text("Queue length is: " + n.length);
	});
	function runIt() {
	      $(".tmp_div").show("slow");
	      $(".tmp_div").animate({left:'+=200'},2000);
	      $(".tmp_div").slideToggle(1000);
	      $(".tmp_div").slideToggle("fast");
	      $(".tmp_div").animate({left:'-=200'},1500);
	      $(".tmp_div").hide("slow");
	      $(".tmp_div").show(1200);
	      $(".tmp_div").slideUp("normal", runIt);
	}
	//runIt();

	$("#start").click(function () {
	      $(".tmp_div2").show("slow");
	      $(".tmp_div2").animate({left:'+=200'},5000);
	      $(".tmp_div2").queue(function () {
	          $(this).addClass("newcolor");
	          $(this).dequeue();
	      });
	      $(".tmp_div2").animate({left:'-=200'},1500);
	      $(".tmp_div2").queue(function () {
	          $(this).removeClass("newcolor");
	          $(this).dequeue();
	      });
	      $(".tmp_div2").slideUp();
	  });
	$("#stop").click(function () {

	      $(".tmp_div2").queue("fx", []);  //与 $(".tmp_div2").clearQueue(); 差不多
	      $(".tmp_div2").stop();

	});

	/*
	$(document.body).click(function () {
	      $(".tmp_div3").show("slow");
	      $(".tmp_div3").animate({left:'+=200'},2000);
	      $(".tmp_div3").queue(function () {
	          $(this).addClass("newcolor");
	          $(this).dequeue();
	      });
	      $(".tmp_div3").animate({left:'-=200'},500);
	      $(".tmp_div3").queue(function () {
	          $(this).removeClass("newcolor");
	          $(this).dequeue();
	      });
	      $(".tmp_div3").slideUp();
	});*/

	var count = 0;
	$(".tem_p").click(function(){
		var t = count++ % 3;
	  $(this).toggleClass("highlight", t == 0);
	});
</script>

<button onclick="a()">ffff</button>
<div id="test">Click Here!</div>
<button onclick="deleteRepeatDOM()">删除重复的DOM</button>
<div class="aaa">aaaa</div>
<div class="aaa">bbbb</div>
<div class="aaa">cccc</div>
<div class="aaa">dddd</div>



<button id="show">Show Length of Queue</button>
<span class="tmp_span"></span>
<div class="tmp_div"></div>


<button id="start">Start</button>
<button id="stop">Stop</button>
<div class="tmp_div2"></div>


Click here...
<div class="tmp_div3"></div>

<input class="datepicker"/>


<p class="tem_p">pppppppppppppppppppppppppppppppppp</p>



<form>
  <input type="text" name="name" value="John"/>
  <input type="text" name="password" value="password"/>
  <input type="text" name="url" value="http://ejohn.org/"/>
</form>



<div class="yyyy">
	<div class="yyyy_c"></div>
	<div class="yyyy_c">
		<div class="yyyy_c2"></div>
	</div>
</div>