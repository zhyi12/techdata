<%@ include file="/WEB-INF/pages/common/include.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<youi:page caption="首页" dataSrc="/mobileServices/services/mdataQueryManager/lineOrBarWithXPeriodAttrOptions.json?indicatorId=A001&areaId=45010001">

	<form action="/zuul/fileserver/upload.json"  enctype="multipart/form-data" method="post" target="_blank">
		<input type="file" name="uploadName"/>
		<input type="submit" name="submit"/>
	</form>

</youi:page>