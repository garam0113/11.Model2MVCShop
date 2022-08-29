<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@	taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<title></title>
	</head>
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
	function fncAddBasket(){
		
		$("#Quantity").val($("#QuantityShow").html());
		$("form").attr("method", "POST").attr("action", "/basket/addBasket").submit();
	}
	
	function count(type)  {
		  // 결과를 표시할 element
		  // const QuantityShow = document.getElementById('QuantityShow');
		  const QuantityShow = $("#QuantityShow");
		  
		  // 현재 화면에 표시된 값
		  let number = QuantityShow.html();
		  
		  // 더하기/빼기
		  if(type === 'plus') {
		    number = parseInt(number) + 1;
		  }else if(type === 'minus')  {
		    number = parseInt(number) - 1;
		  }
		  
		  // 결과 출력
		  QuantityShow.html(number);
	}
	
	function fncPurchase() {
		
		$("#Quantity").val($("#QuantityShow").html());
		$("form").attr("method", "GET").attr("action", "/purchase/addPurchase").submit();
	}
	
	$(function(){
			
		$("td.ct_btn01:contains('장바구니 추가')").bind("click", function(){
			
			fncAddBasket();
			
		})
		
		$("td.ct_btn01:contains('구매')").bind("click", function(){
			
			fncPurchase();
			
		});
		
		$("td.ct_btn01:contains('취소')").bind("click", function(){
			
			history.go(-1);
			
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

<body bgcolor="#ffffff" text="#000000">

<form>
	
	<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
		<tr>
			<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"	width="15" height="37"></td>
			<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="93%" class="ct_ttl01">상품상세조회</td>
						<td width="20%" align="right">&nbsp;</td>
					</tr>
				</table>
			</td>
			<td width="12" height="37">
				<img src="/images/ct_ttl_img03.gif"  width="12" height="37"/>
			</td>
		</tr>
	</table>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">
				상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="105">
							<input type="hidden" name="prodNo" value="${product.prodNo}">
								${product.prodNo}
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">
				상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${product.prodName}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		
		<c:set var="text" value="${fn:split(product.fileName, '*')}" ></c:set>
		
		<tr>
			<td width="104" class="ct_write">
				상품이미지 <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			
			<td class="ct_write01">
				<c:forEach var="i" items="${text}">
					<img src="/images/uploadFiles/${i}" width="100" height="100" align="absmiddle"/>
				</c:forEach>
			</td>
		</tr>
		
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		
		<tr>
			<td width="104" class="ct_write">
				상품상세정보 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${product.prodDetail}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">제조일자</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${product.manuDate}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">가격</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
			
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${product.price}" />
	
			</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">등록일자</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${product.regDate}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
	</table>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
		<tr>
			<td width="53%"></td>
			<td align="right">
	
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
				
					<c:if test="${user eq null || user.role == 'user'}" >
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								
								<td class="ct_write01" >
									
									<input type="hidden" id="Quantity" name="Quantity" value="1"/>
									
									<input type='button' value='-' />									
									
									<span id='QuantityShow'>1</span>
									
									<input type='button' value='+'/>&nbsp;&nbsp;&nbsp;&nbsp;
									
								</td>
								
							</tr>
							
						</table>
						
						<td width="5" height="25">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						
						<td background="/images/ct_btnbg02.gif" width="108" class="ct_btn01" style="padding-top: 3px;">
							장바구니 추가
						</td>
						
						<td width="5" height="25">
							<img src="/images/ct_btnbg03.gif" width="14" height="23">
						</td>
						
						<td width="30"></td>
						
						<c:if test="${product.prodQuantity ne '0' }">
							<td width="17" height="25">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
						
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
								구매
							</td>
						
							<td width="14" height="25">
								<img src="/images/ct_btnbg03.gif" width="14" height="23">
							</td>
						</c:if>
						
						<td width="30"></td>
					</c:if>
			
					<td width="17" height="25">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					
					<td background="/images/ct_btnbg02.gif" width="108" class="ct_btn01" style="padding-top: 3px;">
						이전
					</td>
					
					<td width="14" height="25">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
					
				</tr>
			</table>
	
			</td>
		</tr>
	</table>
</form>

</body>

</html>