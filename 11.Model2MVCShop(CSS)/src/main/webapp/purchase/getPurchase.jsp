<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<head>
	
	<title>구매상세조회</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		
		$(function(){
			
			$("td.ct_btn01:contains('확인')").bind("click", function(){
				history.go(-1);
			});
			
		});
	
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<c:set var="i" value="0"></c:set>
<c:forEach var="list" items="${list}">

	<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="15" height="37">
				<img src="/images/ct_ttl_img01.gif"	width="15" height="37"/>
			</td>
			<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="93%" class="ct_ttl01">구매상세조회</td>
						<td width="20%" align="right">&nbsp;</td>
					</tr>
				</table>
			</td>
			<td width="12" height="37">
				<img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>
			</td>
		</tr>
	</table>


	<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">
				물품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="105">${list.purchaseProd.prodNo}</td>
						<td></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		
		<tr>
			<td width="104" class="ct_write">
				구매자아이디 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${list.buyer.userId}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
	
		<tr>
			<td width="104" class="ct_write">구매방법</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
			
				<c:if test="${fn:trim(list.paymentOption) eq '1'}">
					현금결제
				</c:if>
				
				<c:if test="${fn:trim(list.paymentOption) eq '2'}">
					카드결제
				</c:if>
				
			</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">구매자이름</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${list.receiverName}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">구매자연락처</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${list.receiverPhone}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">구매자주소</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${list.divyAddr}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">구매요청사항</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${list.divyRequest}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">배송희망일</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${list.divyDate}</td>
		</tr>
	
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
	
		<tr>
			<td width="104" class="ct_write">주문일</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${list.orderDate}</td>
		</tr>
	
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		
	</table>
	
</c:forEach>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>					
					<td width="30"></td>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					
					<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
						확인						
					</td>
					
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif"width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>
</html>