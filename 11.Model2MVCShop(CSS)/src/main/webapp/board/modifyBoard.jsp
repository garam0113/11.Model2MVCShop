<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>�ۼ���</title>
	
	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
		$(function(){
			$("form").submit(function(){
				$("form").attr("method", "POST").attr("action", "/board/modifyBoard?boardNo=${board.boardNo}");
			});
		});
		
	</script>
	
</head>

<body>

<form>
	���� : <input type="text" name="title" value="${board.title}">
	
	<br/><br/>
	
	���� : <textarea name="content" cols="40" rows="8">${board.content}</textarea>
	
	<input type="submit" value="�ۼ�"/>
</form>

</body>

</html>