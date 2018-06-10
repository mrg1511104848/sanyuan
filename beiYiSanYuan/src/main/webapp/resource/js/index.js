$(function() {
	for (var i = 1; i < 10; i++) {
		if (i == 1) {
			$(".tabBar").append(
					'<span role="tab" class="current">适应症' + i + '</span>');
		} else {
			$(".tabBar").append('<span role="tab">适应症' + i + '</span>');
		}
		$("#tab_demo").append($(".shi-ying-zheng-common").html());
	}
	getDrugIfEdit();
	initTab();
})
function getDrugIfEdit() {
	var _id = $("#id").val();
	if (_id) {
		$
				.ajax({
					url : "getDrugOne.htm?id=" + _id,
					dataType : 'json',
					type : 'post',
					success : function(data) {
						if (data.msg = 'success') {
							var drug = data.data;
							for ( var fieldName in drug) {
								$("[name=" + fieldName + "]").val(
										drug[fieldName]);
							}
							if (!drug.bigAdaptationDiseases) {
								return;
							}
							var bigAdaptationDiseases = drug.bigAdaptationDiseases;
							for (var i = 0; i < bigAdaptationDiseases.length; i++) {
								var eachBigAdaptationDisease = bigAdaptationDiseases[i];
								var adaptationDiseases = eachBigAdaptationDisease.adaptationDiseases;
								for (var j = 0; j < adaptationDiseases.length; j++) {
									var eachAdaptationDisease = adaptationDiseases[j];
									var type = eachAdaptationDisease.type;
									var fieldName = eachAdaptationDisease.fieldName;
									var fieldValue = eachAdaptationDisease.fieldValue;
									$(
											'[name="bigAdaptationDiseases[' + i
													+ '].adaptationDiseases['
													+ j + '].type"]').val(type);
									$(
											'[name="bigAdaptationDiseases[' + i
													+ '].adaptationDiseases['
													+ j + '].fieldName"]').val(
											fieldName);
									$(
											'[name="bigAdaptationDiseases[' + i
													+ '].adaptationDiseases['
													+ j + '].fieldValue"]')
											.val(fieldValue);
									console.log(fieldName + "\t" + fieldValue);
								}
							}
						} else {
							alert('获取药品失败');
						}
					}
				});
	}
}
function initTab() {
	$(".tabCon").each(
			function(idx) {
				$(this).find(".row input").each(
						function(inputIdx) {
							var namePrefix = 'bigAdaptationDiseases[' + idx
									+ '].adaptationDiseases[' + inputIdx + ']';
							var labelText = $(this).parents('.row').first()
									.find('label').text();
							labelText = labelText.replace('：', '');
							var type = -1;
							if (labelText.indexOf('成人') > -1) {
								type = 1;
							} else if (labelText.indexOf('儿童') > -1) {
								type = 2;
							}
							$(this).before(
									'<input type="hidden" name="' + namePrefix
											+ '.type" value="' + type + '"/>');
							$(this).before(
									'<input type="hidden" name="' + namePrefix
											+ '.fieldName" value="' + labelText
											+ '"/>');
							$(this).attr('name',
									'' + namePrefix + '.fieldValue');
						})
			})
	$("#tab_demo").Huitab();
}
function checkForm() {
}
function subForm() {
	checkForm();
	var formData = $("#demoform-2").serialize();
	$.ajax({
		url : "save.htm",
		dataType : 'json',
		type : 'post',
		data : formData,
		success : function(data) {
			if (data.msg = 'success') {
				alert('保存成功');
			} else {
				alert('保存失败');
			}
		}
	});
}