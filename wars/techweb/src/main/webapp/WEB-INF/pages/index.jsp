<%@ taglib prefix="youi" uri="http://www.cjyoui.xyz/youi" %>
<%@ page language="java" pageEncoding="UTF-8"%>

<youi:html title="科技大数据平台">

    <%@ include file="/WEB-INF/pages/common/commonScriptAndCss.jsp"%>
    <youi:body decorator="defaults">

        <youi:func name="init">
            if(!window.location.hash){
                window.location.hash = '#p:welcome.html';
            }
        </youi:func>
    </youi:body>
</youi:html>