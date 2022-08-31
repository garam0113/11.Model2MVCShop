<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@	taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
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
			
		$("#no3:contains('장바구니')").bind("click", function(){
			
			fncAddBasket();
			
		})
		
		$("#no2:contains('구매')").bind("click", function(){
			
			fncPurchase();
			
		});
		
		$("#no:contains('이전')").bind("click", function(){
			
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
						
						<td>
						<button type="button" class="btn btn-warning" id="no3">장바구니</button>
						
						</td>
						
						
						<td width="30"></td>
						
						<c:if test="${product.prodQuantity ne '0' }">
						
						<td>
						<button type="button" class="btn btn-warning" id="no2">구매</button>
							
							</td>
						
							
						</c:if>
						
				  </c:if>
			
					<td>
						<button type="button" class="btn btn-warning" id="no">이전</button>
					</td>
				
					
				</tr>
			</table>
	
			</td>
		</tr>
	</table>
</form>

</body>

</html>