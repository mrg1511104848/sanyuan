/*! SmartAdmin - v1.4.0 - 2014-06-04 */
!
function(a) {
    a.fn.SuperBox = function() {
    	/*
        var b = a('<div class="superbox-show"></div>'),
        
        c = a('<img src="" style="width:50%" class="superbox-current-img"><div id="imgInfoBox" class="superbox-imageinfo inline-block"> <h1>Image Title</h1><span><p><em>http://imagelink.com/thisimage.jpg</em></p><p class="superbox-img-description">Image description</p><p class="hide"><a href="javascript:void(0);" class="btn btn-primary btn-sm">添 加</a> <a href="javascript:void(0);" id="cancel" class="btn btn-danger btn-sm">取 消</a></p></span> </div>'),
        d = a('<div class="superbox-close txt-color-white"><i class="fa fa-times fa-lg"></i></div>');
        
        b.append(c).append(d);
        a(".superbox-imageinfo");
        return this.each(function() {
            a(".superbox-list ").click(function() {
                $this = a(this);
                var d = $this.find(".superbox-img"),
                e = d.data("img"),
                f = d.attr("alt") || "",
                g = e,
                url=d.attr("url")|| "",
                h = d.attr("title") || "暂无标题";
                c.attr("src", e),
                a(".superbox-list").removeClass("active"),
                $this.addClass("active"),
                c.find("em").text(url),
                c.find(">:first-child").text(h),
                c.find(".superbox-img-description").text("采集周期："+f),
                0 == a(".superbox-current-img").css("opacity") && a(".superbox-current-img").animate({
                    opacity: 1
                }),
                a(this).next().hasClass("superbox-show") ? (a(".superbox-list").removeClass("active"), b.toggle()) : (b.insertAfter(this).css("display", "block"), $this.addClass("active")),
                a("html, body").animate({
                    scrollTop: b.position().top - d.width()
                },
                "medium")
            }),
            a(".superbox").on("click", ".superbox-close",
            function() {
                a(".superbox-list").removeClass("active"),
                a(".superbox-current-img").animate({
                    opacity: 0
                },
                200,
                function() {
                    a(".superbox-show").slideUp()
                })
            }),
            a(".superbox").on("click", "#cancel",
            function() {
                a(".superbox-list").removeClass("active"),
                a(".superbox-current-img").animate({
                    opacity: 0
                },
                200,
                function() {
                    a(".superbox-show").slideUp()
                })
            })
        })
        */
    	var last_id ;
    	var b = a('<div class="superbox-show" style="padding:3px;background-color: #999;"></div>');
    	var c = a('<div class="superbox-close txt-color-blank"><i class="fa fa-times fa-lg"></i></div>');
    	var d = a('<div style="background:white;"></div>');
    	b.append(d).append(c);
        return this.each(function() {
            a(".superbox-list img").click(function() {
            		$this = a(this).parent();
            		var id = $this.find("input[name=id]").val();
            		//防止重复点击、收起时重复发送请求。
            		if(!last_id||last_id!=id){
	                    var type = $this.find("input[name=type]").val();
	                    var rules = ajaxForRules(id+'',type);
	                    d.empty();
	                    d.append(rules);
	                    getRuleList(1,id,type);
            		}
            		last_id = id;
                    a(".superbox-list").removeClass("active"),
                    $this.addClass("active"),
                    0 == a(".superbox-current-img").css("opacity") && a(".superbox-current-img").animate({
                        opacity: 1
                    }),
                    
                    $this.next().hasClass("superbox-show") ? (a(".superbox-list").removeClass("active"), b.toggle()) : (b.insertAfter($this).css("display", "block"), $this.addClass("active")),
                    		
                    a("html, body").animate({
                        scrollTop: b.position().top - d.width()
                    },
                    "medium")
            }),
            a(".superbox").on("click", ".superbox-close",
            function() {
                a(".superbox-list").removeClass("active"),
                a(".superbox-show").slideUp()
            });
        })
    }
    function ajaxForRules(id,type){
    	$.ajax({
    	    url: '/'+type+'/loadSuperboxRulesBySite',
    	    async:false,
    	    complete:function(){
    	    	
    	    },
    	    success: function (data) {
    	       rules = data;
    	    },
    	    cache: false
    	});
    	return rules;
    }
    var pageIndex = 1, pageSize = 10, pageCount = 0;
    var container;
    function showData(data,id,type)
    {
    	pageCount = Math.ceil( data.iTotalRecords/pageSize ),lists = data.aaData;
    	container=$('#rulepage');
    	if(pageCount>0)
    	{
       	  	options = {
       	  		bootstrapMajorVersion:3,
               	currentPage:pageIndex, 
               	numberOfPages: 10, 
               	totalPages:pageCount,
               	itemTexts:function(type, page, current){
               		  switch (type) {
    		            case "first":
    		                return "首页";
    		            case "prev":
    		                return "上一页";
    		            case "next":
    		                return "下一页";
    		            case "last":
    		                return "尾页";
    		            case "page":
    		                return page;
    		           }
               	}, 
               	tooltipTitles: function (type, page, current) {
    	            switch (type) {
    	            case "first":
    	                return "首页";
    	            case "prev":
    	                return "上一页";
    	            case "next":
    	                return "下一页";
    	            case "last":
    	                return "尾页";
    	            case "page":
    	                return (page === current) ? "当前页 " + page : "当前页 " + page;
    	            }
        		},
        		size:"small",
               	onPageClicked:null, 
               	onPageChanged:function(e, oldPage, newPage){
               		getRuleList(newPage,id,type);
               	}
            };
            container.bootstrapPaginator(options);
    	}
    	$("#ruledivContent").empty();
    	if(lists.length==0) 
    	{
    		$("#pageInfo #rulepage").after("<div class='nodata' style='padding-top: 10px; padding-bottom: 10px;'>暂无数据</div>");
    	}else{
    		$(".nodata").remove();
    	}
    	$('#myRuleTemplate').tmpl(lists).appendTo('#ruledivContent');
    }
    var options = null;
    function getRuleList(index,id,type)
    {
    	
    	var query = "/"+type+"/getRulePagedList?timeStamp="+new Date().getTime()+
    		"&iDisplayLength=" +pageSize+
    		"&iDisplayStart=" + (index-1) * pageSize+
    		"&eq_siteId="+id+
    		"&eq_groupId="+$("#_groupId").val();
    		
    	pageIndex = index;
    	$.ajax({
    		dataType: "json",
    		beforeSend:function(){
    			loadingTip("正在加载中,请耐心等待...","#ruledivContent");
    			//$("#ruledivContent").html('正在加载中,请耐心等待...');
    		},
    		type: "GET",
    		url: query,
    		success: function(d){
    			showData(d,id,type);
    		}
    	});
    }
} (jQuery);