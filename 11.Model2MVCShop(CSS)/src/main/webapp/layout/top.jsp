<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>

	<title>Model2 MVC Shop</title>
	<link href="/css/left.css" rel="stylesheet" type="text/css">
	
	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">

	$(function(){
		
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		
		$("td:contains('T.T')").hover(function(){
			const number = Math.floor(Math.random() * 10);
			
			if(number == 1) {
				$("h1").html("^_^");
			} else if(number == 2) {
				$("h1").html("T.T");
			} else if(number == 3) {
				$("h1").html(">_<");
			} else if(number == 4) {
				$("h1").html("T_T");
			} else if(number == 5) {
				$("h1").html("-_T");
			} else if(number == 6) {
				$("h1").html("T_-");
			} else if(number == 7) {
				$("h1").html("T_^");
			} else if(number == 8) {
				$("h1").html("^_T");
			} else if(number == 9) {
				$("h1").html("@_@");
			}
			
		});
		
		$("#loginButton").bind("click", function(){
			//$(window.parent.frames["rightFrame"].document.location).attr("href","/user/login");
			//$("form").attr("method", "POST").attr("action", "/user/login").submit();
		
			$.ajax(
					{
						url : "/user/json/login",
						method : "POST",
						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						
						data : JSON.stringify({
							userId : $($(".iText")[0]).val(),
							password : $($(".iText")[1]).val()
						}),
						
						success : function(JSONData, status) {	
							
							if(JSONData != null) {
								$(window.parent.frames["topFrame"].document.location).attr("href", "/layout/top.jsp");
								$(window.parent.frames["leftFrame"].document.location).attr("href", "/layout/left.jsp");
								$(window.parent.frames["rightFrame"].document.location).attr("href", "/user/getUser?userId=" + JSONData.userId);
							} else {
								alert("���̵�, �н����带 �ٽ� Ȯ���ϼ���");
							}
						}
					}
			);
			
		});
		
		$("#logoutButton").bind("click", function(){
			$(window.parent.document.location).attr("href","/user/logout");
			//$("form").attr("method", "GET").attr("action", "/user/logout").submit();
		});
		
		$("a").bind("click", function(){
			
			$(window.parent.frames["rightFrame"].document.location).attr("href","/user/addUser");
		})
	});

	</script>
	
</head>

<body topmargin="0" leftmargin="0">

	<form> 
		<table width="100%" height="50" border="0" cellpadding="0" cellspacing="0">
			
			<tr>
				<td align="center"><h1>T.T</h1></td>
				<td height="30" >&nbsp;</td>
			</tr>
		
		</table>
	
		<c:if test="${empty user}">		
			<div align="right">
				<a>ȸ�� ����</a>
				<input class="iText" type="text" name="userId" value="" placeholder="���̵�" />
				<input class="iText" type="password" name="password" value="" placeholder="��ȣ" />
				<button id='loginButton'>login</button>
			</div>
		</c:if>
		
		<c:if test="${!empty user}">
			<div align="right">
				<button id='logoutButton'>logout</button>
			</div>
		</c:if>
		
	</form>
</body>

</html>