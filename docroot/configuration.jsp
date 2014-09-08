<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib prefix="liferay-portlet" uri="http://liferay.com/tld/portlet" %>

<%@ page import="com.liferay.portal.kernel.util.Constants" %>
<%-- <%@ page import="com.inercy.liferay.portlets.documents.logic.CustomDocumentsViewerBean" %> --%>

<portlet:defineObjects />

<%-- <jsp:useBean 
	id="customDocumentsViewerBean" 
	class="com.inercy.liferay.portlets.documents.logic.CustomDocumentsViewerBean" 
	scope="request" /> --%>
	


<form 
	action="<liferay-portlet:actionURL portletConfiguration="true" />" 
	method="post" name="<portlet:namespace />fm">
	
	<input name="<portlet:namespace /><%=Constants.CMD%>" type="hidden" value="<%=Constants.UPDATE%>" /> 
	
	Folder a mostrar:
	
	<select name="<portlet:namespace />folderId">
		<c:forEach items="${folders}" var="folder" >
			<option value="<c:out value="${folder.folderId }"/>" ><c:out value="${folder.name}" /></option>
		</c:forEach>
	</select>
	<br /> 
	<input type="button" value="Save" 
		onClick="submitForm(document.<portlet:namespace />fm);" />
</form>