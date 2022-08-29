<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>

<head>

	<meta charset="EUC-KR">
	<title>글보기</title>
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		
		$(function() {
			
			$($("input:button")[0]).bind("click", function() {
				$("form").attr("method", "GET").attr("action", "/board/modifyBoard?boardNo=${board.boardNo}").submit();
			})
			
			$($("input:button")[1]).bind("click", function() {
				$("form").attr("method", "GET").attr("action", "/board/deleteBoard?boardNo=${board.boardNo}").submit();
			})
			
			$($("input:button")[2]).bind("click", function() {
				$("form").attr("method", "POST").attr("action", "/reply/addReply").submit();
			})
			
		})
	
	</script>
	
</head>

<body>

<form>
	<div align="center">
		
		제목 : ${board.title}
		
	</div>
		<hr/><br/><br/>
		
	<div align="center">
		
		내용 : ${board.content} 
		<br/><br/>
		check : ${user.userId } // ${fn:trim(board.userId)}
		
	</div>
		<br/><br/><hr/>
		
		<c:if test="${(user.userId eq fn:trim(board.userId)) or user.role eq 'admin'}">
			<input type="button" value="수정"/>
			<input type="button" value="삭제"/>
		</c:if>
		
		<hr/>
		
		<c:if test="${user.role eq 'admin'}">
			답변 달기 : <textarea name="reply" cols="40" rows="8"></textarea>
			<input type="button" value="답변">
		</c:if>
</form>

</body>

</html>