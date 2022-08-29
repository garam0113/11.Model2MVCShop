<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>글작성</title>
	
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
		아이디 : <input type="text" name="userId">
		비밀번호 : <input type="password" name="password">
		
		<br/><br/>
		
	</c:if>
		제목 : <input type="text" name="title">
		
		<br/><br/>
		
		내용 : <textarea name="content" cols="40" rows="8"></textarea>
		
		<input type="submit" value="작성"/>
</form>
	
</body>

</html>