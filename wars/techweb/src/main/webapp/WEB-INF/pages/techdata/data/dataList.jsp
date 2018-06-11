
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

<youi:page caption="数据维护">

    <youi:ajaxUrl name="getPagerMtopicsUrl" src="/mobileServices/services/mtopicManager/getPagerMtopics.json"/>

    <youi:ajaxUrl name="getIndicatorTreesUrl" src="/mobileServices/services/mtopicManager/getIndicatorTrees.json"/>

    <youi:ajaxUrl name="queryByIndicatorAndAreaUrl" src="/mobileServices/services/mdataQueryManager/queryByIndicatorAndArea.json"/>

    <youi:ajaxUrl name="saveMdatasUrl" src="/mobileServices/services/mdataManager/saveMdatas.json"/>

    <youi:customWidget name="page_spliter" widgetName="pageSpliter" styleClass="col-sm-4 page-inner-height">
        <youi:toolbar refWidgetId="tree_indicator" styleClass="fixed-hiehgt">
            <youi:toolbarItem caption="南宁高新" tooltips="选择行政区划" name="save" icon="map-marker" value="45010001"/>
        </youi:toolbar>
        <youi:tree id="tree_indicator" styleClass="col-sm-12 no-padding auto-height">

        </youi:tree>

    </youi:customWidget>

    <youi:customWidget widgetName="cubeditor" name="cubeditor"
                       urls="queryByIndicatorAndAreaUrl,saveMdatasUrl"
                       styleClass="col-sm-8 page-inner-height page-spliter-right no-padding">
        <youi:toolbar refWidgetId="cubeditor" styleClass="fixed-hiehgt">
            <youi:toolbarItem caption="添加数据期" tooltips="添加数据期" name="save" icon="save" groups="indicator"/>
        </youi:toolbar>

    </youi:customWidget>

    <youi:func name="init" urls="getPagerMtopicsUrl,getIndicatorTreesUrl">

        $.youi.ajaxUtils.ajax({
            url:funcUrls.getPagerMtopicsUrl,
            success:function(result){

                var treeHtmls = [];

                if(result.records){
                    $(result.records).each(function(){
                        var indicatorSrc = funcUrls.getIndicatorTreesUrl+'?topicId='+this.topicId;
                        treeHtmls.push($.youi.treeUtils.treeNodeHtml(this.topicId,this.topicCaption,{src:indicatorSrc}));
                    });
                }

                $elem('tree_indicator',pageId).find('>ul').empty().html(treeHtmls.join(''));
            }
        });

    </youi:func>

    <youi:func name="tree_indicator_select" params="treeNode">
        var code = treeNode.data('code'),
            activeGroups = [];
        if(code){
            activeGroups = ['indicator'];
            $elem('cubeditor',pageId).cubeditor('loadCube',code,'45010001');
        }

        $elem('cubeditor',pageId).trigger('activeTools',{groups:activeGroups});
    </youi:func>
</youi:page>