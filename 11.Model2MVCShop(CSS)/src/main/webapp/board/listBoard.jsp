<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>

	<title>고 객 센 터</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
	function fncGetList(currentPage){
		//document.getElementById("currentPage").value = currentPage;
		//document.detailForm.submit();
		
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").submit();
	}
	
	$(function(){
		
		$("#writing").dblclick(function(){
			
			self.location = "/board/writingBoard.jsp";
		});
		
	})
	
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form>
	
	<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
		<tr>
			<td width="15" height="37">
				<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
			</td>
			<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="93%" class="ct_ttl01">
						고 객 센 터
						
						</td>
					</tr>
				</table>
			</td>
			<td width="12" height="37">	
				<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
			</td>
		</tr>
	</table>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			<td colspan="11" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
		</tr>
	
		<tr>
			<td class="ct_list_b" width="10">글번호</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="150">제목</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="10">작성자</td>
			<td class="ct_line02"></td>		
			<td class="ct_list_b" width="10">비고</td>
				
		</tr>
		
		<tr>
			<td colspan="17" bgcolor="808285" height="1"></td>
		</tr>		
		
		<c:set var = "i" value = "0" />
		<c:forEach var = "list" items = "${list}" varStatus="status">
			<c:set var = "i" value = "${i + 1}" />
			<tr class="ct_list_pop">
			
				<td align="center">${list.boardNo}</td>
				
				<td></td>
				
				<td align="center">
					<a href="/board/getBoard?boardNo=${list.boardNo}">${list.title}</a> 
				</td>
				
				<td></td>
				
				<td align="center">${list.userId}</td>
				<td></td>
			
			</tr>
			
			<tr>
				<td colspan="17" bgcolor="D6D7D6" height="1"></td>
			</tr>
		</c:forEach>		
		
	</table>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			<td align="right" >
				<input type="button" id="writing" value="글쓰기"/>
		</tr>
	</table>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value="1"/>
			<input type="hidden" id="order" name="order" value="1"/>
			
			<jsp:include page="../common/pageNavigator.jsp"/>
			
			
	    	</td>
		</tr>
	</table>
	<!--  페이지 Navigator 끝 -->
	</form>
</div>

</body>
</html>