<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>���ۼ�</title>
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
	$(function(){
		$("form").submit(function(){
			$("form").attr("method", "POST").attr("action", "/board/addBoard");
		});
	});
	
	</script>
	
</head>

<body>

<form>
	<c:if test="${empty user}">
		���̵� : <input type="text" name="userId">
		��й�ȣ : <input type="password" name="password">
		
		<br/><br/>
		
	</c:if>
		���� : <input type="text" name="title">
		
		<br/><br/>
		
		���� : <textarea name="content" cols="40" rows="8"></textarea>
		
		<input type="submit" value="�ۼ�"/>
</form>
	
</body>

</html>