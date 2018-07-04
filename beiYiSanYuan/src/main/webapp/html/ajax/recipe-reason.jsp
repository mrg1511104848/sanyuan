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
            审核不通过原因
        </h4>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="col-md-12">
                <form id="frmApp" name="frmApp" class="smart-form">
                    <input type="hidden" name="eq_recipeId" id="recipeId"
                           value="${pendingRecipe.recipeId}" />
                    <input type="hidden" name="amountState" id="amountState"
                           value="${pendingRecipe.amountState}" />
                    <input type="hidden" name="channelState" id="channelState"
                           value="${pendingRecipe.channelState}" />
                    <input type="hidden" name="frequencyState" id="frequencyState"
                           value="${pendingRecipe.frequencyState}" />
                    <input type="hidden" name="singleDoseState" id="singleDoseState"
                           value="${pendingRecipe.singleDoseState}" />
                    <input type="hidden" name="drugNameState" id="drugNameState"
                           value="${pendingRecipe.drugNameState}" />
                    <section>
                        <label class="label">
                            原因：
                        </label>
                        <label class="input">
                            <textarea class="form-control" placeholder=""  name="reason" rows="5" cols="30"
                                      id="reason" value="${pendingRecipe.reason}">
                                ${pendingRecipe.reason}
                            </textarea>
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
