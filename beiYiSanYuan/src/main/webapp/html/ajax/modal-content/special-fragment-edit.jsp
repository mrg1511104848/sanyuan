<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/js/plugin/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<style>
	.forms{display:none;}
	.primaryKeyForms{display:none;}
	.over500hidden{
		max-height:500px;overflow-y:scroll;
	}
	.over600hidden{
		max-height:600px;overflow-y:scroll;
	}
	.page2,.page3{
		display:none;
	}
	.input{
		margin-bottom:10px;
	}
	.ztree{
		font-style:normal;
	}
	.ztree li span.button{
		padding:0;
	}
	.menuContent {
		border: 1px solid #ccc;
		background: #f0f6e4;
		box-shadow: -5px 5px 20px 5px rgba(0,0,0,.2);
		height: 360px;
		overflow-y: scroll;
		overflow-x: auto;
		scrollbar-face-color: green; 
		scrollbar-hightLight-color: red; 
		scrollbar-3dLight-color: orange; 
		scrollbar-darkshadow-color:blue; 
		scrollbar-shadow-color:yellow; 
		scrollbar-arrow-color:purple; 
		scrollbar-track-color:black; 
		scrollbar-base-color:pink; 
	}
	.senior-write{
		cursor:pointer;
	}
</style>

<div class="page1 over600hidden">
	<div class="modal-header">
		<h4 class="modal-title" id="myModalLabel">
			特殊片段编辑
		</h4>
	</div>
	<div class="modal-body">
		<div class="row">
			<div class="col-md-12">
				<form id="frm" name="frm" class="smart-form">
					<input type="hidden" name="id" id="txt_id"
						value="${specialFragment.id }" />
					<input type="hidden" id="hide_fragment"
						value="${specialFragment.fragment }" />
					<label class="label">
						类别
					</label>
					<label class="input">
						<select name="type" class="form-control" value="${specialFragment.type }">
							<c:forEach items="${types }" var="type">
								<option value="${type.key }">${type.value }</option>
							</c:forEach>
						</select>
					</label>
					<label class="label">
						片段
					</label>
					<label class="input fragment">
						<input type="text" name="fragment" class="form-control" id="txt_fragment"
						value="${specialFragment.fragment}" />
					</label>	
			</div>
			</form>
		</div>
	</div>
</div>
<div id="remoteModal" style="display: none;"></div>
<script src="/resources/js/special-fragment-edit.js"></script>