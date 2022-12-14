<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@	taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>

<head>

	<title>회원 목록조회</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script type="text/javascript">
	
		// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
		function fncGetList(currentPage) {
			//document.getElementById("currentPage").value = currentPage;
	   		//document.detailForm.submit();
	   		
	   		$("#currentPage").val(currentPage);
	   		$("form").attr("method", "POST").attr("action", "/user/listUser").submit();
		}
		
		$(function() {
			
			$("td.ct_btn01:contains('검색')").bind("click", function(){
				
				fncGetList(1);
				
			});
			
			//==> userId LINK Event 연결처리
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용
			
			$(".ct_list_pop td:nth-child(3)").hover(
					
				function(){
				
					var userId = $(this).text().trim();
					
					$.ajax(
						{
							url : "/user/json/getUser/" + userId,
							method : "GET",
							dataType : "json",
							header : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							}, // header close
							success : function(JSONData, status) {
								var displayValue = "<p>" + "아이디 : " + JSONData.userId + "<br/>"
														+ "이 름 : " + JSONData.userName + "<br/>"
														+ "이메일 : " + JSONData.email + "<br/>"
														+ "Role : " + JSONData.role + "<br/>"
														+ "등록일 : " + JSONData.regDateString + "<br/>"
														+ "</p>";
								
														
								$("#" + userId + "").html(displayValue);
								
							} // success close						
						}	
					) // ajax close
					
					$("#" + userId + "").dialog({
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
					
					$("#" + userId + "").dialog("open");
				},
				
				function(){
					
					$("p").parent().dialog("close");
				}
				
			)
			
			$(".ct_list_pop td:nth-child(3)").bind("click", function(){
				
				self.location ="/user/getUser?userId=" + $(this).text().trim();
				
			});
			 
			$(".ct_list_pop td:nth-child(3)").css("color" , "blue");
			$("h7").css("color" , "blue");
			
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "grey");
			
			$(document).scroll(function(){
				var maxHeight = $(document).height();
				//alert(maxHeight);
				
				var currentScroll = $(window).scrollTop() + $(window).height();
				//alert(currentScroll);
				
				if(currentScroll == maxHeight) {
					alert(currentScroll);
					
					var count = 1;
					var currentPage = parseInt($("#currentPage").val()) + count;
					
					alert(parseInt($("#currentPage").val()) + 1)
					
					$("#currentPage").val(currentPage);
					
					$.ajax(
						{
							url : "/user/json/listUser",
							method : "POST",
							data : JSON.stringify ({
								currentPage : parseInt($("#currentPage").val())
							}), 
							dataType : "json",
							contentType: "application/json",						
							success : function(JSONData, status) {
								var value = "<b>";
								$.each(JSONData, function(index, item) {
									value += item.userId + " ";
									alert(value);
								});
								
								value += "</b><br>";
								
								alert(value);
								
								if(value != "<b></b><br>"){
									$(value).appendTo($("form"));
								}
								
								count++;
							} // success close;
							
						}
					
					)
					
				}
			})
			
		});
		
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<input type="hidden" id="currentPage" name="currentPage" value="1"/>
<input type="hidden" id="order" name="order" value="0"/>
			
<table width="100%" height="750" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">회원 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>

			</select>
			<input 	type="text" name="searchKeyword"  value="${! empty search.searchKeyword ? search.searchKeyword : ""}" 
							class="ct_input_g" style="width:200px; height:19px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 ${requestScope.resultPage.totalCount} 건수, 현재 ${requestScope.resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">
			회원ID<br>
			<h7>(id click : 상세정보)</h7>
		</td>
		
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">이메일</td>		
	</tr>
	
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
	<c:forEach var="user" items="${list}">
		<c:set var="i" value="${i + 1}" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="left" style="text-decoration:underline">
				${user.userId}
			</td>
			<td></td>
			<td align="left" >${user.userName}</td>
			<td></td>
			<td align="left"><h1>${user.email}</h1>
			</td>		
		</tr>
		<tr>
			<!-- 변경된 부분
				<td colspan="11" bgcolor="D6D7D6" height="1"></td>
			-->
			<td id="${user.userId}" colspan="11" bgcolor="D6D7D6" height="1"></td>
			
		</tr>
	</c:forEach>
</table>


</form>
</div>

</body>

</html>