<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${resultPage.currentPage > resultPage.pageUnit}">
	<b>����</b>
</c:if>

<span id="pageNumber">
	<c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}">
		<b>${i}</b>
	</c:forEach>
</span>

<c:if test="${resultPage.endUnitPage < resultPage.maxPage}">
	<b>����</b>
</c:if>
			