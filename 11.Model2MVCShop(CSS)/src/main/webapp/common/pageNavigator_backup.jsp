<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${resultPage.currentPage > resultPage.pageUnit}">
	<a href="javascript:fncGetList('${resultPage.currentPage - 1}', '${search.order}')"><b>����</b></a>
</c:if>

<c:forEach var = "i" begin = "${resultPage.beginUnitPage}" end = "${resultPage.endUnitPage}">
	<a href="javascript:fncGetList('${i}', '${search.order}');">${i}</a>
</c:forEach>

<c:if test="${resultPage.endUnitPage < resultPage.maxPage}">
	<a href="javascript:fncGetList('${resultPage.endUnitPage + 1}', '${search.order}')"><b>����</b></a>
</c:if>
			
			
			
			
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${resultPage.currentPage > resultPage.pageUnit}">
	<b>����</b>
</c:if>

<c:forEach var = "i" begin = "${resultPage.beginUnitPage}" end = "${resultPage.endUnitPage}">
	<b id="pageNumber">${i}</b>
</c:forEach>

<c:if test="${resultPage.endUnitPage < resultPage.maxPage}">
	<b>����</b>
</c:if>
			