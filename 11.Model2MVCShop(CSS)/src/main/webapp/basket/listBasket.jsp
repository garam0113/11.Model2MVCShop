<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
	<title>장바구니</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
	function fncGetList(currentPage){
		//document.getElementById("currentPage").value = currentPage;
		//document.detailForm.submit();
		
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").submit();
	}

	function count(type, i)  {
		// 결과를 표시할 element
		var Qid = 'Quantity_' + i;
		var Pid = 'price_' + i; 
	  
		// const Quantity = document.getElementById(Qid);
		// const price = document.getElementById(Pid);
	  
		const Quantity = $("#" + Qid);
		const price = $("#" + Pid);
		
		// 현재 화면에 표시된 값
		// let number = Quantity.innerText;
		// let numberPrice = price.innerText / number;
		
		let number = Quantity.html();
		let numberPrice = price.html() / number;
		
		// 더하기/빼기
		if(type == 'plus') {
			number = parseInt(number) + 1;
		} else if(type == 'minus')  {
			number = parseInt(number) - 1;
		}
		
		// 결과 출력
		// Quantity.innerText = number;
		// price.innerText = parseInt(numberPrice) * number;
		
		Quantity.html(number);
		price.html(parseInt(numberPrice) * number);
		
	}
	
	function fncPurchase(cnt) {
		for(var i = 0 ; i < cnt ; i++) {
			
			var Qid = 'Quantity_' + (i + 1);
			// const Quantity = document.getElementById(Qid);
			const Quantity = $("#" + Qid);
			
			// alert($($("input[name=prodNo]")[i]).is(":checked"));
			
			// if(document.getElementsByName("prodNo")[i].checked == true)
			if($($("input[name=prodNo]")[i]).is(":checked")) {
				var hiddenField = document.createElement("input");
				hiddenField.setAttribute('type', 'hidden');
				hiddenField.setAttribute('name', 'Quantity');
				hiddenField.setAttribute('value', Quantity.html());
				
				// document.detailForm.appendChild(hiddenField);
				$("form").append(hiddenField);
			}
			
		}
		// document.detailForm.action="/purchase/addPurchase";
		// document.detailForm.method="GET";
		// document.detailForm.submit();
		
		$("form").attr("action", "/purchase/addPurchase").attr("method", "GET").submit();
	
	}
	
	$(function(){
		
		$("#deleteBasket").bind("click", function(){
			$("form").attr("action", "/basket/removeBasket").attr("method", "POST").submit();
		});
		
		$("#button").bind("click", function(){
		
			fncPurchase($("#button").val());
		});
		
		$.each($("td.ct_write01 input:button"), function(index, item){

			if(index % 2 == 0) {
				$($("td.ct_write01 input:button")[index]).bind("click", function(){
					
					count("minus", (index/2) + 1);
				});
			} else {
				$($("td.ct_write01 input:button")[index]).bind("click", function(){
					
					count("plus", Math.ceil(index/2));
				});
			}
		
		});
		
	});
	
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
							장바구니
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
			<td colspan="11" >전체 ${ resultPage.totalCount } 건수, 현재 ${ resultPage.currentPage } 페이지</td>
		</tr>
	
		<tr>
			<td class="ct_list_b" width="100">상품번호</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="150">상품명</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="50">수량</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="150">가격</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="300">정보</td>	
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="100">현재상태</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="100">장바구니 삭제</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="30">선택</td>
		</tr>
		
		<tr>
			<td colspan="17" bgcolor="808285" height="1"></td>
		</tr>
		
		<c:set var = "i" value = "0" />
		<c:forEach var = "list" items = "${list}" varStatus="status">
			<c:set var = "i" value = "${i + 1}" />
			<tr class="ct_list_pop">
			
			<td align="center">
			<!-- <input type="hidden" id="prod_no_${i}" name="prod_no" value="${list.prodNo}"/> -->		
				${list.prodNo}
			</td>
			<td></td>
			<td align="center">
			
			<c:if test="${empty user || fn:trim(user.role) == 'user' }">
					<c:if test ="${fn:trim(list.prodQuantity) == '0'}" >
						<a href="/product/getProduct?prodNo=${list.prodNo}&menu=search">${list.prodName}</a>
					</c:if>
		
					<c:if test ="${fn:trim(list.prodQuantity) != '0'}" >
						<a href="/product/getProduct?prodNo=${list.prodNo}&menu=search">${list.prodName}</a>
					</c:if>
				</c:if>
				
			</td>
			<td></td>
			
			<td class="ct_write01">
				<!--	jQuery Event 처리로 변경
				<input type='button' onclick='count("minus", ${i})' value='-'/>
				-->
				
				<input type='button' value='-'/>
				<%-- <div id='Quantity_${i}'>${addQuantity[status.index]}</div> --%>		
				<%-- <div id='Quantity_${i}'>${list.basketCount}</div> 			--%>	
				<span id='Quantity_${i}'>${list.basketCount}</span>
				<!--	jQuery Event 처리로 변경
				<input type='button' onclick='count("plus", ${i})' value='+'/>
				-->
				
				<input type='button' value='+'/>
			</td>
			<td></td>
			<td align="center">
				<div id='price_${i}'>${list.price * list.basketCount}</div>
			</td>
			<td></td>
			<td align="center">${list.prodDetail}</td>
			<td></td>
			
			<td align="center">				
				<c:if test="${empty user || fn:trim(user.role) == 'user' }">
					<c:if test ="${fn:trim(list.prodQuantity) eq '0'}" >
						재고없음
					</c:if>
					<c:if test ="${fn:trim(list.prodQuantity) ne '0'}" >
						판매중
					</c:if>
				</c:if>
			
			<td></td>	
			<td align="center">
				<a href="/basket/removeBasket?prodNo=${list.prodNo}">삭제</a>
			</td>	
			
			<td></td>
			<td align="center">
			<!-- <input type="hidden" id="prodQuantity" name="prodQuantity" value="${addBasket[status.index]}"/>	-->
			<!-- <input type="hidden" id="Quantity" name="Quantity"/>												-->
				<input type="checkbox" name="prodNo" value="${list.prodNo}"><br>
				
			</td>
			
		</tr>
		
		<tr>
			<td colspan="17" bgcolor="D6D7D6" height="1"></td>
		</tr>
		
		</c:forEach>
	</table>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			<td align="right">
				<input type='submit' id="deleteBasket" value='장바구니 삭제'>
				<button id="button" value="${i}">다사버리기</button>
	    	</td>
		</tr>
	</table>
	
	<br/>
	
	<!--
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			<td align="right">
				<button id="button" >다사버리기</button>
				 <a href="javascript:fncPurchase(${i});">다사버리기</a>	
	    	</td>
		</tr>
	</table>
	
	-->	
	
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