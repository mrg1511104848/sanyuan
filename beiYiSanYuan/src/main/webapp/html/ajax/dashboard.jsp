<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<a class="btn btn-primary" _id="/news/getListPageInfo" href="javascript:void(0);">/news/getListPageInfo</a>
<a class="btn btn-primary" _id="/news/getTextPageInfo" param="textPageUrl=http://news.sina.com.cn/c/2014-11-04/161731093350.shtml" href="javascript:void(0);">/news/getTextPageInfo</a>
<script language="javascript">
	location.href="index#/news/rules?"+new Date().getTime();
</script> 
<div id="json_dialog">
	<p id="result">
		<a href="javascript:void(0);" class="bg-color-white txt-color-teal"><i class="fa fa-gear fa-3x fa-spin"></i></a>
	</p>
</div>
<script type="text/javascript">

	/* DO NOT REMOVE : GLOBAL FUNCTIONS!
	 *
	 * pageSetUp(); WILL CALL THE FOLLOWING FUNCTIONS
	 *
	 * // activate tooltips
	 * $("[rel=tooltip]").tooltip();
	 *
	 * // activate popovers
	 * $("[rel=popover]").popover();
	 *
	 * // activate popovers with hover states
	 * $("[rel=popover-hover]").popover({ trigger: "hover" });
	 *
	 * // activate inline charts
	 * runAllCharts();
	 *
	 * // setup widgets
	 * setup_widgets_desktop();
	 *
	 * // run form elements
	 * runAllForms();
	 *
	 ********************************
	 *
	 * pageSetUp() is needed whenever you load a page.
	 * It initializes and checks for all basic elements of the page
	 * and makes rendering easier.
	 *
	 */

	pageSetUp();
	
	/*
	 * ALL PAGE RELATED SCRIPTS CAN GO BELOW HERE
	 * eg alert("my home function");
	 * 
	 * var pagefunction = function() {
	 *   ...
	 * }
	 * loadScript("js/plugin/_PLUGIN_NAME_.js", pagefunction);
	 * 
	 */


	function formatParamToJson(param){
		var jsonResult = {};
		var paramArr = param.split("&");
		$.each(paramArr,function(n,element) {   
	    	var key = element.substring(0,element.indexOf("=")); 
	    	var val = element.substring(element.indexOf("=")+1,element.length); 
	    	jsonResult[key] = val;
		});
		return jsonResult;
	}
	// PAGE RELATED SCRIPTS

	/* remove previous elems */
	if($('.DTTT_dropdown.dropdown-menu').length){
		$('.DTTT_dropdown.dropdown-menu').remove();
	}
	
	// Needed if you are rendering multiple tables in ajax version
	//var tableDestroyer = [];

	// pagefunction	
	var pagefunction = function() {
		//console.log("cleared");
		
		/* // DOM Position key index //
		
			l - Length changing (dropdown)
			f - Filtering input (search)
			t - The Table! (datatable)
			i - Information (records)
			p - Pagination (paging)
			r - pRocessing 
			< and > - div elements
			<"#id" and > - div with an id
			<"class" and > - div with a class
			<"#id.class" and > - div with an id and class
			
			Also see: http://legacy.datatables.net/usage/features
		*/	

		/* BASIC ;*/
		/*
		 * CONVERT DIALOG TITLE TO HTML
		 * REF: http://stackoverflow.com/questions/14488774/using-html-in-a-dialogs-title-in-jquery-ui-1-10
		 */
		$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
			_title : function(title) {
				if (!this.options.title) {
					title.html("&#160;");
				} else {
					title.html(this.options.title);
				}
			}
		}));

		$('a[_id]').on( 'click', function () {
			$('#json_dialog').data("url", $(this).attr("_id")).data("param", $(this).attr("param")).dialog('open');
			return false;
		});
		
		$('#json_dialog').dialog({
			open  : function(){
				$("#result").html("<a href=\"javascript:void(0);\" class=\"bg-color-white txt-color-teal\"><i class=\"fa fa-gear fa-3x fa-spin\"></i></a>");
				$.ajax({
					type: 'POST',
					url: $(this).data("url"),
					data: formatParamToJson($(this).data("param")),
					success: function(result){
						$("#result").text(result);
			    	}
				});
			},
			maxHeight : 900,
			autoOpen : false,
			width : 900,
			resizable : false,
			modal : true,
			title : "<div class='widget-header'><h4><i class='fa fa-warning'></i> JSON结果</h4></div>",
			buttons : [
			{
				html : "<i class='fa fa-times'></i>&nbsp; 关闭",
				"class" : "btn btn-warning",
				click : function() {
					$(this).dialog("close");
				}
			}]
		});
	};
	
	// load related plugins
	
<%--	loadScript("/resources/js/plugin/datatables/jquery.dataTables.min.js", --%>
<%--		function(){loadScript("/resources/js/plugin/datatables/dataTables.colVis.min.js", --%>
<%--			function(){loadScript("/resources/js/plugin/datatables/dataTables.tableTools.min.js", --%>
<%--				function(){loadScript("/resources/js/plugin/datatables/dataTables.bootstrap.min.js", --%>
					pagefunction();
<%--				);--%>
<%--			});--%>
<%--		});--%>
<%--	});--%>


</script>