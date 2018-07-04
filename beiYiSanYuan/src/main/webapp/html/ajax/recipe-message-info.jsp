<%--
  Created by IntelliJ IDEA.
  User: leosmile
  Date: 2018/6/27
  Time: 上午9:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
</style>
<div style="max-height:500px;overflow-y:scroll;">
    <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">
            消息查看
        </h4>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="col-md-12">
                <form id="frmApp" name="frmApp" class="smart-form">
                    <input type="hidden" name="id" id="patientId"
                           value="" />
                    <section>
                        <label class="label">
                            消息详情
                        </label>
                        <label class="input">
                            <div class="form-control" placeholder="" type="text" name="messgae" rows="6" onscroll="true"
                                   id="message" value="" readonly="readonly">
                                <c:forEach items="${message}" var="l">
                                    ${l.from } : ${l.msg } 
                                    <hr/>
                                </c:forEach>
                            </div>

                </form>
            </div>
        </div>
    </div>
</div>
<script>
    pageSetUp();
    $(function() {
        if($("select[name='productCategory']").attr("value")==""){
            $("select[name='productCategory']").attr("value","es")
        }
        initSelect('productCategory');
        initSelect('connectTo');
        initRadio('dbType');
        dealFrm();
        dealDB();
        $("select[name='productCategory']").change(function(){
            dealFrm();
        })
        $("[name=dbType]").change(function(){
            dealDB();
            $(".to_empty input").val("");
            $(".to_empty select").each(function(){
                $(this).val($(this).find("option:first").attr("value"))
            });
        })
    });

    function dealDB(){
        if($("[name='dbType']:checked").attr("dbType")!='Oracle'){
            $(".oracle").hide();
        }else{
            $(".oracle").show();
        }
    }
    function dealFrm(){
        if($("select[name='productCategory']").val()=='es'){
            $(".hide_flag").show();
        }
        if($("select[name='productCategory']").val()=='es'||$("select[name='productCategory']").val()=='hy'){
            $(".db").hide();
            $(".apiAddress").show();
        }else{
            $(".db").show();
            $(".apiAddress").hide();
        }
        if($("select[name='productCategory']").val()!='es'){
            $(".hide_flag").hide();
        }
    }
</script>