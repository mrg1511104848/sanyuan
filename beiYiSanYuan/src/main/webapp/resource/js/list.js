$(function() {
	$.ajax({
		url : "list.htm",
		dataType : 'json',
		type : 'post',
		success : function(data) {
			if (data.msg = 'success') {
				if(data.data){
					data = data.data;
					for(var i = 0 ; i < data.length ; i++){
						var dataEach = data[i];
						var id=dataEach.id;
						var tongYongName=dataEach.tongYongName;
						var shangPinName=dataEach.shangPinName;
						var companyName=dataEach.companyName;
						$("table tbody ").append(
								'<tr>'+
								'<td>'+tongYongName+'</td>'+
								'<td>'+shangPinName+'</td>'+
								'<td>'+companyName+'</td>'+
								'<td><a href="toInput.htm?id='+id+'"><i class="Hui-iconfont">&#xe60c;</i></a></td>'+
								'</tr>');
					}
				}
			} else {
				alert('获取列表失败');
			}
		}
	});
})