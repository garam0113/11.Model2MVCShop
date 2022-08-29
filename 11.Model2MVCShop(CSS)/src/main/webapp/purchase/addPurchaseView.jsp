<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

	<title>구매진행</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript" src="../javascript/calendar.js"></script>
	<script type="text/javascript">
	
	function fncGetList(currentPage){
		//document.getElementById("currentPage").value = currentPage;
		//document.detailForm.submit();
		
		$("#currentPage").val(currentPage);
		$("form").attr("action", "/purchase/addPurchase").attr("method", "POST").submit();
	}
	
	function count(type, i)  {
		  // 결과를 표시할 element
		var Qid = 'Quantity_' + i;
		var Pid = 'price_' + i; 
		  
		//const Quantity = document.getElementById(Qid);
		//const price = document.getElementById(Pid);
		
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
		Quantity.html(number);
		price.html(parseInt(numberPrice) * number);
		
	}
	
	function fncAddPurchase(cnt) {
		
		for(var i = 0 ; i < cnt ; i++) {
			
			var Qid = 'Quantity_' + (i + 1);
			var Pid = 'QuantityDivery_' + (i + 1); 
			
			//const Quantity = document.getElementById(Qid);
			const Quantity = $("#" + Qid);
			
			//document.getElementById(Pid).value = Quantity.innerText;
			$("#" + Pid).val(Quantity.html());
			
		}
		//document.detailForm.submit();
		$("form").attr("method", "POST").attr("action", "/purchase/addPurchase").submit();
	}
	
	$(function() {
		
		$("td.ct_btn01:contains('구매')").bind("click", function(){
			fncAddPurchase(${i});
		})
		
		$("td.ct_btn01:contains('취소')").bind("click", function(){
			history.go(-1);
		})		
		
		$("img[src='../images/ct_icon_date.gif']").bind("click", function(){
			
			var receiverDate = $("input[name='receiverDate']");
			
			show_calendar('receiverDate', receiverDate.val());
			
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
									구매진행								
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
					<td colspan="11" >전체 ${ resultPage.totalCount } 건수</td>
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
				</tr>
				
				<tr>
					<td colspan="17" bgcolor="808285" height="1"></td>
				</tr>
				
				<c:set var = "i" value = "0" />
				<c:forEach var = "list" items = "${list}" varStatus="status">
					<c:set var = "i" value = "${i + 1}" />
					<tr class="ct_list_pop">
					
					<td align="center">
		 				<input type="hidden" id="prod_no_${i}" name="prodNo" value="${list.prodNo}"/>
							${list.prodNo}
					</td>
					<td></td>
					<td align="center">
					
					<c:if test="${empty user || fn:trim(user.role) == 'user' }">
							<c:if test ="${fn:trim(list.proTranCode) == '0'}" >
								<a href="/product/getProduct?prodNo=${list.prodNo}&menu=search">${list.prodName}</a>
							</c:if>
				
							<c:if test ="${fn:trim(list.proTranCode) != '0'}" >
								<a href="/product/getProduct?prodNo=${list.prodNo}&menu=search">${list.prodName}</a>
							</c:if>
						</c:if>
						
					</td>
					<td></td>
					
					<td class="ct_write01">
						<input type='button' onclick='count("minus", ${i})' value='-'/>
						<input type="hidden" id="QuantityDivery_${i}" name="Quantity" value="${quantity[i-1]}"/>
						<span id='Quantity_${i}'>${quantity[i-1]}</span>
						<input type='button' onclick='count("plus", ${i})' value='+'/>
					</td>
					<td></td>
					<td align="center">
						<div id='price_${i}'>${list.price * quantity[i-1]}</div>
					</td>
					<td></td>
					<td align="center">${list.prodDetail}</td>
					<td></td>
									
					<tr>
						<td colspan="17" bgcolor="D6D7D6" height="1"></td>
					</tr>
				</c:forEach>
			</table>
					
			<br/>
		
			<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
				<tr>
					<td width="15" height="37">
						<img src="/images/ct_ttl_img01.gif" width="15" height="37">
					</td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">
									구매자정보
								</td>
								
								<td width="20%" align="right">&nbsp;</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37">
						<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
					</td>
				</tr>
			</table>
						
			<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						<input type="hidden" name="buyerId" value="${user.userId}" />
						구매자아이디 <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${user.userId}</td>
					
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">구매방법</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<select 	name="paymentOption"		class="ct_input_g" 
										style="width: 100px; height: 19px" maxLength="20">
							<option value="1" selected="selected">현금구매</option>
							<option value="2">신용구매</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">구매자이름</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="receiverName" 	class="ct_input_g" 
									style="width: 100px; height: 19px" maxLength="20" value="${user.userName}" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">구매자연락처</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input 	type="text" name="receiverPhone" class="ct_input_g" 
										style="width: 100px; height: 19px" maxLength="20" value="${user.phone}" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">구매자주소</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input 	type="text" name="divyAddr" class="ct_input_g" 
										style="width: 100px; height: 19px" maxLength="20" value="${user.addr}" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">구매요청사항</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input		type="text" name="divyRequest" 	class="ct_input_g" 
										style="width: 100px; height: 19px" maxLength="20" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">배송희망일자</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td width="200" class="ct_write01">
						<input 	type="text" readonly="readonly" id="divyDate" name="receiverDate" class="ct_input_g" 
										style="width: 100px; height: 19px" maxLength="20"/>
										
						<!--	jQuery Event 처리로 변경
						
						<img 	src="../images/ct_icon_date.gif" width="15" height="15"	
									onclick="show_calendar('document.detailForm.receiverDate', document.detailForm.receiverDate.value)"/>
								
						-->
						
						&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15"/>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
			</table>
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
				<tr>
					<td width="53%"></td>
					<td align="center">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23">
									<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
								</td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
									<!--	jQuery Event 처리로 변경
									
									<a href="javascript:fncAddPurchase(${i});">구매</a>
									
									-->
									구매
								</td>
								<td width="14" height="23">
									<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
								</td>
								<td width="30"></td>
								<td width="17" height="23">
									<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
								</td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
									<!--	jQuery Event 처리로 변경
									
									<a href="javascript:history.go(-1)">취소</a>
									
									-->
									취소
								</td>
								<td width="14" height="23">
									<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		
	</div>

</body>

</html>