<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<!-- <ul class="folder subfolders"> -->
	<c:forEach items="${subfolders}" var="subFolder">
		
		<li class="folder subfolder">
			<i class="fa fa-folder-open-o"></i>
			<c:out value="${ subFolder.name }" />
		</li>
		
		<c:if test="${not empty subFolder.files}">
		<ul class="folder subfiles">
			<c:forEach items="${subFolder.files}" var="subFile">
				<li class="file subfile">
					
					<a href="<c:out value="${ subFile.url }" />" target="_blank" class="link">
						<i class="fa fa-file"></i>
						<c:out value="${ subFile.name }" />
					</a>
				</li>
			</c:forEach>
		</ul>
		</c:if>
		
		<c:set var="subfolders" value="${subFolder.subFolders}" scope="request"/>
		<jsp:include page="node.jsp"/>
		
	</c:forEach>
<!-- </ul> -->