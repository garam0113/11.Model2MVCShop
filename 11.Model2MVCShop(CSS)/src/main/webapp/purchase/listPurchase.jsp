<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>

	<title>���� �����ȸ</title>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script type="text/javascript">
	
		function fncGetList(currentPage) {
			//document.getElementById("currentPage").value = currentPage;
			//document.detailForm.submit();
			
			$("#currentPage").val(currentPage);
		
			var currentPage = $("#currentPage").val();
			alert(currentPage);
			alert($("input[name='menu']").val());
			//$("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
			
			$.ajax(
					{
					url : "/purchase/json/listPurchase",
					method : "POST",
					data : JSON.stringify ({
						currentPage : $("#currentPage").val(),
						menu : $("input[name='menu']").val()
					}),
					dataType : "json",
					contentType: "application/json",
					success : function(data, status) {
						
						$.map(data, function(item, index){
							
							alert(index);
							
							/* for(var i = 0 ; i < item.length ; i++) {
								
								$(".ct_list_pop:eq(" + i + ") td:eq(0)").text(item[i].prodNo);
								
								$(".ct_list_pop:eq(" + i + ") td:eq(2)").text("�밡��");
								$(".ct_list_pop:eq(" + i + ") td:eq(4)").text(item[i].prodName);
								$(".ct_list_pop:eq(" + i + ") td:eq(6)").text(item[i].price);
								$(".ct_list_pop:eq(" + i + ") td:eq(8)").text(item[i].prodDetail);
								
								if(item[i].prodQuantity == 0) {
									$(".ct_list_pop:eq(" + i + ") td:eq(10)").text("������_");
								} else {
									$(".ct_list_pop:eq(" + i + ") td:eq(10)").text("�Ǹ���_");
								}
	
							} */
							
						})
						
						$("table:eq(4) b").text("��ü " + data.totalCount + " �Ǽ�, ���� " + $("#currentPage").val() + " ������");
						
						//$("#page").load(location.href + " #page");
						
						} // success close
					
					} // ajax inner close
		
			) // ajax close
		
		//$("jsp:include").load("../common/pageNavigator.jsp");

		//$("#page").load("../common/pageNavigator.jsp", function(){
			
		//});
		}
		
		$(function(){
			
			$("b:contains('����')").bind("click", function(){
				
				//fncGetList(${resultPage.currentPage - 1}, ${search.order});
				
				$("#currentPage").val((parseInt($($("#pageNumber b")[0]).text()) - 1));
				$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
				
			})
			
			$("b:contains('����')").bind("click", function(){

				$("#currentPage").val( (parseInt($($("#pageNumber b")[4]).text()) + 1) );
				$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
			})
			
			$("#pageNumber b").bind("click", function(){
			
				fncGetList($(this).text(), ${search.order});
			
			})
			
			$(".ct_list_pop td:nth-child(1)").bind("click", function(){
				
				alert($(this).parent().find("td:eq(0)").text().trim());
				self.location = "/purchase/getPurchaseByOrder?orderNo=" + $(this).parent().find("td:eq(0)").text().trim();
			});
			
			$(".ct_list_pop td:nth-child(1)").hover(function(){
				
				var orderNo = $(this).parent().find("td:eq(0)").text().trim();
				
				$.ajax({
					
					url : "/purchase/json/getPurchaseByOrder",
					method : "POST",
					data : JSON.stringify ({
						orderNo : $(this).parent().find("td:eq(0)").text().trim()
					}), 
					dataType : "json",
					contentType : "application/json",
					success : function(data, status) {
						
						var displayValue = "<p>�ֹ���ȣ : " + data[0].orderNo + "<br/>"
											+ "�ֹ��� : " + data[0].buyer.userId + "<br/>";
						
						$.each(data, function(index) {
							displayValue += "��ǰ��ȣ : " + data[index].purchaseProd.prodNo + "<br/>"
						})
						
						displayValue += "</p>";
						
						$("#" + orderNo + "").html(displayValue);
					} // success close
					
				}) // ajax close
				
				$("#" + orderNo + "").dialog({
					autoOpen: false,
					show: {
						effect: "Pulsate",
				        duration: 1000
					},
					hide: {
				        effect: "Scale",
				        duration: 1000
					}
				});
				
				$("#" + orderNo + "").dialog("open");
				
			},
			
			function() {
				
				$("p").parent().dialog("close");
				
			})
			
		});
		
	</script>
	
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form>

<input type="hidden" name="menu" value="${menu}">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						${menu eq 'manage' ? '�ֹ�����' : '������ȸ'}
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">�ֹ� ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="200">���� ��ǰ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">���� ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">���� �ݾ�</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">�� �ݾ�</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">������</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">�����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">��������</td>
	</tr>
	<tr>
		<td colspan="23" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var = "i" value = "0"></c:set>
	<c:forEach var = "list" items = "${list}">
		<c:set var = "i" value = "${i + 1}"></c:set>
		<tr class="ct_list_pop">
			<td align="center" style="text-decoration:underline">
				<!-- 
				<a href="/purchase/getPurchase?tranNo=${list.tranNo}">${list.tranNo}</a>
				-->
				${list.orderNo}
			</td>
		
			<td></td>
			
			<td align="center">
			
			<a href="/product/getProduct?prodNo=${list.purchaseProd.prodNo}&menu=search">${list.purchaseProd.prodName}</a>
			</td>
		
			<td></td>
			
			<td align="center">
				${list.buyQuantity}
			</td>
		
			<td></td>
			
			<td align="center">
				<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${list.purchaseProd.price}"></fmt:formatNumber>
			</td>
		
			<td></td>
			
			<td align="center">
				<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${list.buyQuantity * list.purchaseProd.price}"/>
				
			</td>
		
			<td></td>
			
			<td align="center">
				<a href="/user/getUser?userId=${list.buyer.userId}">${list.buyer.userId}</a>
			</td>
			
			<td></td>
			
			<td align="center">${list.receiverName}</td>
			<td></td>
			<td align="center">${list.receiverPhone}</td>
			<td></td>
			<td align="center">${list.divyAddr}</td>
			<td></td>
			
			<td align="center">
				<c:if test="${fn:trim(user.role) eq 'user'}">
					<c:if test="${fn:trim(list.tranCode) eq '1'}">
						��� ���
					</c:if>
					
					<c:if test="${fn:trim(list.tranCode) eq '2'}">
						�����
					</c:if>
					
					<c:if test="${! (fn:trim(list.tranCode) eq '1') && ! (fn:trim(list.tranCode) eq '2')}">
						���� �Ϸ�
					</c:if>
				</c:if>
				
				<c:if test="${fn:trim(user.role) ne 'user'}">
					
					<c:if test ="${fn:trim(list.tranCode) == '1'}" >
						��� ���
					<%--						
						<a href="/updateTranCodeByProd.do?prodNo=${list.purchaseProd.prodNo}&tranCode=1">��� �ϱ�</a>
						
						--%>
					</c:if>
					
					<c:if test ="${fn:trim(list.tranCode) == '2'}" >
						�����
					</c:if>
					
					<c:if test ="${fn:trim(list.tranCode) == '3'}" >
						�Ǹ� �Ϸ�
					</c:if>
				</c:if>
				
			</td>
			
			<td></td>
			
			<td align="center">
			
				<a href="/purchase/updateTranCode?tranNo=${list.tranNo}&tranCode=${fn:trim(list.tranCode)}&menu=${menu}&currentPage=${search.currentPage}">  

					<c:if test="${(fn:trim(list.tranCode) eq '1')&& user.role eq 'admin'}">
						��� �ϱ�
					</c:if>
					
					<c:if test="${(fn:trim(list.tranCode) eq '2') && user.role eq 'user'}">
						��� �Ϸ�
					</c:if>
				</a>
			</td>
		</tr>
	
	<tr>
		<!-- 
			<td colspan="23" bgcolor="D6D7D6" height="1"></td>
		-->
		
		<td id="${list.orderNo}" colspan="23" bgcolor="D6D7D6" height="1"></td>
	</tr>
	
	</c:forEach>
			
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="currentPage" name="currentPage" value="1"/>
			
		<jsp:include page="../common/pageNavigator.jsp"/>
		
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>