<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="EUC-KR">

<title>Model2 MVC Shop</title>
	
	<link href="/css/left.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

	<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script type="text/javascript">
	
	function history(){
		popWin = window.open("/history.jsp","popWin","left=300, top=200", 
							"width=300, height=200, marginwidth=0, marginheight=0",
							"scrollbars=no, scrolling=no, menubar=no, resizable=no");
	}
	
	$(function(){
		
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	
		// 일반사용자용 메뉴
		
		$('#menubar div:contains("메 뉴")').bind("click", function(){
			alert("0st");
			$(top.location).attr("href","/index.jsp");
		})
		
		$('#menubar div:contains("Home")').bind("click", function(){
			alert("1st");
			$(top.location).attr("href","/index.jsp");
		})
		
		$('#menubar div:contains("개인정보조회")').bind("click", function(){
			alert("2nd");
			$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId=${user.userId}");
		})
		
		$('#menubar div:contains("상 품 검 색")').bind("click", function(){
			alert("3rd");
			$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=search");
		})
		
		$('#menubar div:contains("구매이력조회")').bind("click", function(){
			alert("4th");
			$(window.parent.frames["rightFrame"].document.location).attr("href","/purchase/listPurchase");
		})
		
		$('#menubar div:contains("장 바 구 니")').bind("click", function(){
			alert("5th");
			$(window.parent.frames["rightFrame"].document.location).attr("href","/basket/listBasket");
		})
		
		$('#menubar div:contains("고 객 센 터")').bind("click", function(){
			alert("6th");
			$(window.parent.frames["rightFrame"].document.location).attr("href","/board/listBoard");
		})
		
		$('#menubar div:contains("최근 본 상품")').bind("click", function(){
			//history();
			$(top.location).attr("href","/history.jsp");
		})
		
		// 관리자용 메뉴
		
		$('#menubarAdmin div:contains("관리자")').bind("click", function(){
			alert("0st");
			$(top.location).attr("href","/index.jsp");
		})
		
		$('#menubarAdmin div:contains("회원정보조회")').bind("click", function(){
			$(window.parent.frames["rightFrame"].document.location).attr("href","/user/listUser");
		})
		
		$('#menubarAdmin div:contains("판매상품등록")').bind("click", function(){
			$(window.parent.frames["rightFrame"].document.location).attr("href","../product/addProductView.jsp");
		})
		
		$('#menubarAdmin div:contains("판매상품관리")').bind("click", function(){
			$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=manage");
		})
		
		$('#menubarAdmin div:contains("주 문 관 리")').bind("click", function(){
			$(window.parent.frames["rightFrame"].document.location).attr("href","/purchase/listPurchase?menu=manage");
		})
		
		$('#menubarAdmin div:contains("고 객 센 터")').bind("click", function(){
			$(window.parent.frames["rightFrame"].document.location).attr("href","/board/listBoard");
		})
		
	    $( "#menubar" ).menu({
	      items: "> :not(.ui-widget-header)"
	    });
		
		$( "#menubarAdmin" ).menu({
			items: "> :not(.ui-widget-header)"
		});
		
		$('td:contains("login")').bind("click", function(){
			$(window.parent.frames["rightFrame"].document.location).attr("href","/user/login");
		});
		
		$('td:contains("logout")').bind("click", function(){
			$(window.parent.document.location).attr("href","/user/logout");
		});
	});
	
	
	</script>

<style>
.ui-menu {
	width: 150px;
}
</style>

</head>

<body background="/images/left/imgLeftBg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

	<table width="159" border="0" cellspacing="0" cellpadding="0">

		<tr>
			<td valign="top">
				<table border="0" cellspacing="0" cellpadding="0" width="159">


					<tr>
						<td class="Depth03" style="text-decoration: underline">

							<ul id="menubar">
								<li><div>메 뉴</div>
									<ul>
										<li><div>Home</div></li>

										<c:if test="${!empty user}">
											<li><div>개인정보조회</div></li>
										</c:if>

										<li><div>상 품 검 색</div></li>

										<c:if test="${fn:trim(user.role) eq 'user'}">
											<li><div>구매이력조회</div></li>
										</c:if>

										<c:if test="${fn:trim(user.role) eq 'user'}">
											<li><div>장 바 구 니</div></li>
										</c:if>
										
										<li><div>고 객 센 터</div></li>
										
										<c:if test="${fn:trim(user.role) eq 'user'}">
											<li><div>최근 본 상품</div></li>
										</c:if>
										
									</ul>
								</li>
							</ul>
						</td>
					</tr>
					
					<c:if test="${!empty user && fn:trim(user.role) == 'admin'}">
						<tr>
							<td class="Depth03" style="text-decoration: underline">
	
								<ul id="menubarAdmin">
									<li><div>관리자</div>
										<ul>
	
											<li><div>회원정보조회</div></li>
											<li><div>판매상품등록</div></li>
											<li><div>판매상품관리</div></li>
											<li><div>주 문 관 리</div></li>
											<li><div>고 객 센 터</div></li>
											
										</ul>
									</li>
								</ul>
							</td>
						</tr>
					</c:if>
					
				</table>
			</td>
			
		</tr>

	</table>

	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	
	<!-- 
	
	<table width="200" border="0" cellspacing="0" cellpadding="0">
			<tr> 
				<td width="75">
         
					<c:if test="${empty user}">
						<button id='loginButton'>login</button>
					</c:if>	
					
					<c:if test="${!empty user}">
						<button id='logoutButton'>logout</button>
					</c:if>	
				</td>
			</tr>
	</table>
	
	-->
	
</body>

</html>