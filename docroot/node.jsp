<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<ul class="folders">
	<c:forEach items="${subfolders}" var="subFolder">
		
		<li class="folder">
			<i class="fa fa-folder-open-o"></i>
			<c:out value="${ subFolder.name }" />
		
			<c:if test="${not empty subFolder.files}">
				<ul class="files">
					<c:forEach items="${subFolder.files}" var="subFile">
						<li class="file">
							
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
		
		</li>
		
	</c:forEach>
</ul>