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

	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script type="text/javascript">
	
	function history(){
		popWin = window.open("/history.jsp","popWin","left=300, top=200", 
							"width=300, height=200, marginwidth=0, marginheight=0",
							"scrollbars=no, scrolling=no, menubar=no, resizable=no");
	}
	
	$(function(){
		
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	
		// �Ϲݻ���ڿ� �޴�
		
		$('#menubar div:contains("�� ��")').bind("click", function(){
			alert("0st");
			$(top.location).attr("href","/index.jsp");
		})
		
		$('#menubar div:contains("Home")').bind("click", function(){
			alert("1st");
			$(top.location).attr("href","/index.jsp");
		})
		
		$('#menubar div:contains("����������ȸ")').bind("click", function(){
			alert("2nd");
			$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId=${user.userId}");
		})
		
		$('#menubar div:contains("�� ǰ �� ��")').bind("click", function(){
			alert("3rd");
			$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=search");
		})
		
		$('#menubar div:contains("�����̷���ȸ")').bind("click", function(){
			alert("4th");
			$(window.parent.frames["rightFrame"].document.location).attr("href","/purchase/listPurchase");
		})
		
		$('#menubar div:contains("�� �� �� ��")').bind("click", function(){
			alert("5th");
			$(window.parent.frames["rightFrame"].document.location).attr("href","/basket/listBasket");
		})
		
		$('#menubar div:contains("�� �� �� ��")').bind("click", function(){
			alert("6th");
			$(window.parent.frames["rightFrame"].document.location).attr("href","/board/listBoard");
		})
		
		$('#menubar div:contains("�ֱ� �� ��ǰ")').bind("click", function(){
			//history();
			$(top.location).attr("href","/history.jsp");
		})
		
		// �����ڿ� �޴�
		
		$('#menubarAdmin div:contains("������")').bind("click", function(){
			alert("0st");
			$(top.location).attr("href","/index.jsp");
		})
		
		$('#menubarAdmin div:contains("ȸ��������ȸ")').bind("click", function(){
			$(window.parent.frames["rightFrame"].document.location).attr("href","/user/listUser");
		})
		
		$('#menubarAdmin div:contains("�ǸŻ�ǰ���")').bind("click", function(){
			$(window.parent.frames["rightFrame"].document.location).attr("href","../product/addProductView.jsp");
		})
		
		$('#menubarAdmin div:contains("�ǸŻ�ǰ����")').bind("click", function(){
			$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=manage");
		})
		
		$('#menubarAdmin div:contains("�� �� �� ��")').bind("click", function(){
			$(window.parent.frames["rightFrame"].document.location).attr("href","/purchase/listPurchase?menu=manage");
		})
		
		$('#menubarAdmin div:contains("�� �� �� ��")').bind("click", function(){
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
								<li><div>�� ��</div>
									<ul>
										<li><div>Home</div></li>

										<c:if test="${!empty user}">
											<li><div>����������ȸ</div></li>
										</c:if>

										<li><div>�� ǰ �� ��</div></li>

										<c:if test="${fn:trim(user.role) eq 'user'}">
											<li><div>�����̷���ȸ</div></li>
										</c:if>

										<c:if test="${fn:trim(user.role) eq 'user'}">
											<li><div>�� �� �� ��</div></li>
										</c:if>
										
										<li><div>�� �� �� ��</div></li>
										
										<c:if test="${fn:trim(user.role) eq 'user'}">
											<li><div>�ֱ� �� ��ǰ</div></li>
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
									<li><div>������</div>
										<ul>
	
											<li><div>ȸ��������ȸ</div></li>
											<li><div>�ǸŻ�ǰ���</div></li>
											<li><div>�ǸŻ�ǰ����</div></li>
											<li><div>�� �� �� ��</div></li>
											<li><div>�� �� �� ��</div></li>
											
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