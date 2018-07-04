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
            患者详情
        </h4>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="col-md-12">
                <form id="frmApp" name="frmApp" class="smart-form">
                    <input type="hidden" name="id" id="patientId"
                           value="${patient.patientId }" />
                    <section>
                        <label class="label">
                            姓名
                        </label>
                        <label class="input">
                            <input class="form-control" placeholder="" type="text" name="name"
                                   id="patient_name" value="${patient.name }" readonly="readonly">
                        </label>
                    </section>
                    <section>
                        <label class="label">
                            性别
                        </label>
                        <label class="input">
                            <input class="form-control" placeholder="" type="text" name="sex"
                                   id="patient_sex" value="${patient.sex }" readonly="readonly">
                        </label>
                    </section>
                    <section >
                        <label class="label">
                            年龄
                        </label>
                        <label class="input">
                            <input class="form-control" placeholder="" type="text" name="age"
                                   id="patient_age" value="${patient.age }" readonly="readonly">
                        </label>
                    </section>
                    <section class="apiAddress">
                        <label class="label">
                            体重
                        </label>
                        <label class="input">
                            <input class="form-control" placeholder="" type="text"
                                   name="weight" id="patient_weight" value="${patient.weight }" readonly="readonly">
                        </label>
                    </section>
                    <section  class=" db to_empty">
                        <label class="label">
                            诊断信息
                        </label>
                        <label class="input">
                            <input class="form-control" placeholder="" type="text"
                                   name="mainDiagnosis" id="patient_mainDiagnosis" value="${patient.mainDiagnosis }" readonly="readonly">
                        </label>
                    </section>
                    <section  class="to_empty" >
                        <label class="label">
                            其他信息
                        </label>
                        <label class="input">
                            <input class="form-control" placeholder="" type="text"
                                   name="info" id="patient_info" value="${patient.info }" readonly="readonly">
                        </label>
                    </section>
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