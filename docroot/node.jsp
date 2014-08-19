<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<li>
	<ul class="folders sub">
		<c:forEach items="${subfolders}" var="subFolder">
			<li class="folder sub"><c:out value="${ subFolder.name }" /></li>
			
			<c:if test="${not empty subFolder.files}">
			<ul class="folders sub">
				<c:forEach items="${subFolder.files}" var="subFile">
					<li class="file sub">
						<a href="<c:out value="${ subFile.url }" />">
							<c:out value="${ subFile.name }" />
						</a>
					</li>
				</c:forEach>
			</ul>
			</c:if>
			
			<c:set var="subfolders" value="${subFolder.subFolders}" scope="request"/>
			<jsp:include page="node.jsp"/>
			
		</c:forEach>
	</ul>
</li>