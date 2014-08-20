<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<ul class="folder subfolders">
	<c:forEach items="${subfolders}" var="subFolder">
		<li class="folder subfolder"><c:out value="${ subFolder.name }" />
		
		<c:if test="${not empty subFolder.files}">
		<ul class="folder subfiles">
			<c:forEach items="${subFolder.files}" var="subFile">
				<li class="file subfile">
					<a href="<c:out value="${ subFile.url }" />">
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