<%@ include file="/WEB-INF/pages/common/include.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<youi:page caption="角色管理">
	
	<youi:subpage height="150" src="page/admin.role/roleEdit.html?roleId={roleId}" subpageId="role_edit" caption="修改角色" type="dialog"></youi:subpage>
	<youi:subpage height="150" src="page/admin.role/roleEdit.html" subpageId="role_add" caption="添加角色" type="dialog"></youi:subpage>
	
	<youi:subpage src="page/admin.role/roleAuth.html?roleId={roleId}" subpageId="role_auth" caption="角色授权"
		type="page"></youi:subpage>
	
	<youi:grid id="grid_role" src="/operatorServices/services/roleManager/getPagerRoles.json"
		removeSrc="/operatorServices/services/roleManager/removeRole.json" idKeys="roleId" styleClass="grid-query-inline"
		showNum="true" showCheckbox="true">
		
		<youi:fieldLayout>
			<youi:fieldText property="roleId" caption="角色名"/>
			<youi:fieldText property="roleCaption" caption="角色描述"/>
		</youi:fieldLayout>

		<youi:gridCol orderBy="desc" width="30%" caption="角色名" property="roleId"/>
		<youi:gridCol orderBy="desc" width="50%" caption="角色描述" property="roleCaption"/>
		
		<youi:gridCol align="center" width="20%" type="button" property="button" caption="操作">
			<youi:button name="edit" caption="编辑"/>
			<youi:button name="auth" icon="hand-right" caption="授权"/>
			<youi:button name="split" caption=""/>
			<youi:button name="removeRecord" icon="remove" caption="删除"/>
			
		</youi:gridCol>
		
		<youi:button name="add" caption="添加" icon="plus"/>
	</youi:grid>
	<!-- Grid编辑按钮动作：打开修改角色弹出页 -->
	<youi:func name="grid_role_edit" params="dom,options,record">
		$elem('subpage_role_edit',pageId).subpage('open',{},'['+record.roleCaption+']',record,pageId);
	</youi:func>
	<!-- Grid新增按钮动作：打开新增角色弹出页 -->
	<youi:func name="grid_role_add" params="dom,options">
		$elem('subpage_role_add',pageId).subpage('open',{},'',{},pageId);
	</youi:func>
	
	<!-- 打开授权页面 -->
	<youi:func name="grid_role_auth" params="dom,options,record">
		$elem('subpage_role_auth',pageId).subpage('open',{},'',record,pageId);
	</youi:func>
	
	<!-- 编辑角色的subpage内容变化回调函数 -->
	<youi:func name="subpage_role_edit_change" params="record">
		$elem('grid_role',pageId).grid('refresh');
	</youi:func>
	<!-- 新增角色的subpage内容变化回调函数 -->
	<youi:func name="subpage_role_add_change" params="record">
		$elem('grid_role',pageId).grid('refresh');
	</youi:func>
	
</youi:page>