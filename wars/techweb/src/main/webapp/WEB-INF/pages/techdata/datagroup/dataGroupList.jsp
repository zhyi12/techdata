
<%@ include file="/WEB-INF/pages/common/include.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- ***********************************************************************************************
*   @页面说明:
*
*   @author         zhouyi
*   @since          3.0.0
*   @createTime     2018-05-21
*   @modify
*************************************************************************************************--%>

<youi:page caption="发布管理">

    <youi:ajaxUrl name="getIndicatorTreesUrl" src="/mobileServices/services/mtopicManager/getIndicatorTrees.json"/>

    <youi:customWidget name="page_spliter" widgetName="pageSpliter" styleClass="col-sm-4 page-inner-height">
        <youi:grid id="grid_topic" reset="NOT" query="NOT" showFooter="false" pageSize="2000" src="/mobileServices/services/mtopicManager/getPagerMtopics.json">
            <youi:fieldLayout columns="1">
                <youi:fieldText caption="主题分类" property="topicTypes"/>
            </youi:fieldLayout>
            <youi:gridCol property="topicCaption" type="link" caption="发布主题名称" />
            <youi:gridCol property="icon" caption="主题图标"/>
        </youi:grid>
    </youi:customWidget>

    <youi:form id="form_topicTree" panel="false"
               styleClass="col-sm-8 page-inner-height page-spliter-right no-padding" submit="NOT" reset="NOT">

        <youi:toolbar refWidgetId="form_topicTree">
            <youi:toolbarItem caption="提交" tooltips="保存" name="save" icon="save" groups="indicator"/>
        </youi:toolbar>

        <youi:fieldLayout columns="1" labelWidths="0">
            <youi:fieldHidden property="topicId" defaultValue="T001"/>
            <youi:tree id="tree_indicators" rootText="主题指标" styleClass="col-sm-6">

            </youi:tree>
        </youi:fieldLayout>
    </youi:form>

    <youi:func name="grid_topic_cellLink" params="dom,commandOptions,record" urls="getIndicatorTreesUrl">

        //record
        $.youi.ajaxUtils.ajax({
            url:funcUrls.getIndicatorTreesUrl,
            data:'topicId='+record.topicId,
            success:function(results){

                var treeHtmls = [];
                $(results.records).each(function(){
                    treeHtmls.push($.youi.treeUtils.treeNodeHtml(this.id,this.text,{code:this.code},this.data));
                });

                $elem('tree_indicators',pageId).find('>ul').empty().append(treeHtmls.join(''));

                $elem('form_topicTree',pageId).trigger('activeTools',{groups:['indicator']});
            }
        });


    </youi:func>

</youi:page>