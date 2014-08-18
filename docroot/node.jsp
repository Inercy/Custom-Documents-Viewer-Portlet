

<%-- <c:forEach items="${node.children}" var="folder" >
    <!-- TODO: print the node here -->
    <c:set var="node" value="${node}" scope="request"/>
    <jsp:include page="node.jsp"/>
</c:forEach> --%>


<c:if test="${not empty subFolders}">
	<ul>
		<c:forEach items="${subFolders}" var="subFolder">
			<li><c:out value="${ subFolder.name }" /></li>
			
			<c:if test="${not empty subFolder.files}">
			<ul>
				<c:forEach items="${subFolder.files}" var="subFile">
					<li>
						<a href="<c:out value="${ subFile.url }" />">
							<c:out value="${ subFile.name }" />
						</a>
					</li>
				</c:forEach>
			</ul>
			</c:if>
			
		</c:forEach>
	</ul>
</c:if>