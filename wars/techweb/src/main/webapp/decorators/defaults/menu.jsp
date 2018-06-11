<%@ taglib prefix="youi" uri="http://www.cjyoui.xyz/youi" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div id="sys_toggle_menu" class="page-menu-toggle">
    <span class="youi-icon icon-indent-left" title="关闭菜单"></span>
    <span class="youi-icon icon-indent-right" title="展开菜单"></span>
</div>

<div id="system_v_menu" class="youi-menu v-menu">
    <youi:pageMenu menuProviderName="menuProvider"/>
</div>