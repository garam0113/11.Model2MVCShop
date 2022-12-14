<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
	<title>상품 관리</title>
	
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
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
	<script type="text/javascript">
	
	function fncGetList(currentPage, order){
		//document.getElementById("currentPage").value = currentPage;
		//document.getElementById("order").value = order;
		//document.detailForm.submit();
		
		$("#currentPage").val(currentPage);
		
		var currentPage = $("#currentPage").val();
		alert(currentPage);
		//$("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
		
		alert(" :: ");
		
		$.ajax(
				{
					url : "/product/json/listProduct",
					method : "POST",
					data : JSON.stringify ({
						currentPage : $("#currentPage").val()
					}),
					dataType : "json",
					contentType: "application/json",
					success : function(data, status) {
						
						$.map(data, function(item, index){
							
							for(var i = 0 ; i < item.length ; i++) {
								
								$(".ct_list_pop:eq(" + i + ") td:eq(0)").text(item[i].prodNo);
								
								$(".ct_list_pop:eq(" + i + ") td:eq(2)").text("노가다");
								$(".ct_list_pop:eq(" + i + ") td:eq(4)").text(item[i].prodName);
								$(".ct_list_pop:eq(" + i + ") td:eq(6)").text(item[i].price);
								$(".ct_list_pop:eq(" + i + ") td:eq(8)").text(item[i].prodDetail);
								
								if(item[i].prodQuantity == 0) {
									$(".ct_list_pop:eq(" + i + ") td:eq(10)").text("재고없음_");
								} else {
									$(".ct_list_pop:eq(" + i + ") td:eq(10)").text("판매중_");
								}
								
							}
							
						})
						
						$("table:eq(4) b").text("전체 " + data.totalCount + " 건수, 현재 " + $("#currentPage").val() + " 페이지");
						
						//$("#page").load(location.href + " #page");
						
					} // success close
					
				} // ajax inner close
		
		) // ajax close
		
		//$("jsp:include").load("../common/pageNavigator.jsp");

		//$("#page").load("../common/pageNavigator.jsp", function(){
			
		//});
	}
	
	function fncGetListPrice() {
		//document.detailForm.submit();
		
		$("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
	}
	
	$(function(){
		
		$("b:contains('이전')").bind("click", function(){
			
			//fncGetList(${resultPage.currentPage - 1}, ${search.order});
			
			$("#currentPage").val((parseInt($($("#pageNumber b")[0]).text()) - 1));
			$("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
			
		})
		
		$("b:contains('이후')").bind("click", function(){

			$("#currentPage").val( (parseInt($($("#pageNumber b")[4]).text()) + 1) );
			$("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
		})
		
		///////////
		
		$("#pageNumber b").bind("click", function(){
			
			fncGetList($(this).text(), ${search.order});
			
		})
		
		///////////
		
		$("#mainSearch").bind("click", function(){
			fncGetList(1);
		});
		
		$($("input:button")[3]).bind("click", function(){
			fncGetListPrice();
		});
		
		$(".ct_list_pop td:nth-child(5)").css("color", "yellow");
		
		///////////
		
		$(".ct_list_pop td:nth-child(5)").on("click", function(){
			
			var prodNo = $(this).parent().find("td:eq(0)").text().trim();
			
			$.ajax(
					{
						url : "/product/json/getProduct/" + prodNo,
						method : "GET",
						dataType : "json",
						header : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						}, // header close
						success : function(data, status) {
							
							if((data.fileName).indexOf('*') != -1){
								var position = (data.fileName).indexOf('*');
								
								data.fileName = (data.fileName).substring(0, position);
							}
							
							var value = "<p>상품번호 : " + data.prodNo + "<br/>"
										+ "상품명 : " + data.prodName + "<br/>"
										+ "이미지<br/><img src='/images/uploadFiles/" + data.fileName
										+ "' width='200' height='200'/></p>";
										
							$("#" + prodNo + "").html(value);
							
						} // success close
						
						
					} // ajax inner close
			
			) // ajax close
			
			$("#" + prodNo + "").dialog({
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
			
			$("#" + prodNo + "").dialog("open");
			
			},
		
			function(){
				
				$("p").parent().dialog("open");
			}
		
		)
		
		///////////
		
	$(".ct_list_pop td:nth-child(5)").bind("click", function(){
				
				self.location ="/product/getProduct?prodNo=" + $(this).text().trim();
				
			});
		
		$("#low_price").bind("click", function(){
			
			$("#low_price").text(2);
			$("#order").val(2);
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
		});
		
		$("#high_price").bind("click", function(){
			
			$("#high_price").text(1);
			$("#order").val(1);
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
		});
		
		$("#searchKeyword").autocomplete({

			source: function(request, response){
				
				$.ajax(
								
						{
							url : "/product/json/productAutoComplete",
							method : "POST",
							dataType : "json",
							contentType: "application/json",
							data : JSON.stringify({
								searchCondition : $(".ct_input_g option:selected").val(),
								searchKeyword : $("#searchKeyword").val()
							}),
							success : function(data) {
								response(
										$.map(data, function(item){
											return{
												
												label : item.prodName,
												searchKeyword : item.prodName
												
											}
											
										})
										
								) // response close
								
							} ,
							
							error : function() {
								
							}
							
						}
				) // $.ajax close
			} // source : function close
			
			, minLength: 0
			, autoFocus : true
			, delay : 100
			, select : function(event, ui){
				
			} // select : function close
			
		}); // autocomplete close
		
	});
	
	</script>
		<style>
	
        body {
            padding-top : 70px;
            background-color : black;
            color : yellow;
        }
        #low_price {
        background-color : black;
         }
        #high_price {
        background-color : black;
        }
   
     
   	</style>
</head>

<body bgcolor="#ffffff" text="#000000">
	<jsp:include page="/layout/toolbar.jsp" />
<div style="width:98%; margin-left:10px;">

<form>

	<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
		<tr>
			<td width="15" height="37">
			
			</td>
			<td  width="100%" style="padding-left:10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="93%" class="ct_ttl01">
							${menu.equals("manage") ? "상품관리" : "상품 목록 조회"}
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
			
			<td align="right">
				<select name="searchCondition" class="ct_input_g" style="width:80px">
					<c:if test="${fn:trim(user.role) eq 'admin'}">
						<option value="0"  ${ (searchCondition == '0' ? "selected" : "") }>상품번호</option>
						<option value="1"  ${ (searchCondition == '1' ? "selected" : "") }>상품명</option>
						
					</c:if>
				
					<c:if test="${(fn:trim(user.role) eq 'user') || empty user}">
						<option value="1"  ${ (searchCondition == '1' ? "selected" : "") }>상품명</option>
					</c:if>				
				</select>
				
				<input type="text" id="searchKeyword" name="searchKeyword" value="${!empty search.searchKeyword ? search.searchKeyword : ""}" 
												class="ct_input_g" style="width:200px; height:19px" />
			</td>
		
			<td align="right" width="70">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="17" height="23" class="ct_btn01">
							<input type="button" id="mainSearch" value="검색" >
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			<td colspan="11">
				
				
				<!-- <span><input type="text" name="minPrice" class="param-pricerange" maxlength="10" value="${search.minPrice != -1 ? search.minPrice : ""}"
						class="ct_input_g" style="width:100px; height:19px" > ~</span>
			    <span><input type="text" name="maxPrice" class="param-pricerange" maxlength="10" value="${search.maxPrice != -1? search.maxPrice : ""}"
			    				class="ct_input_g" style="width:100px; height:19px" > 원</span>
			
			    <input type="button" value="검색">-->
	    
			</td>
		</tr>
		<tr>

			
			
		</tr>
		<tr>
			
		</tr>
		
		<c:set var = "i" value = "0" />
		<c:forEach var = "list" items = "${list}">
			<c:set var = "i" value = "${i + 1}" />
			<tr class="ct_list_pop">
				
				<td></td>
				
				<div class="col-sm-6 col-md-4">
                <a href="/product/getProduct?prodNo=${ list.prodNo }&menu=${ menu }" class="thumbnail">
      
 
						<img src="/images/uploadFiles/${ list.fileName }" width="100" height="100" align="absmiddle"/>
					  </a>
                    </div>

				
				<td></td>
				
				<td></td>
				
				
				
				<td></td>
				
				<td></td>
				
				
					
				<td></td>
			
			
						
			</tr>
			
			<tr>
			
			</tr>
		</c:forEach>
	</table>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value="1"/>
			<input type="hidden" id="order" name="order" value="0"/>
			
			<div id="page">
				<jsp:include page="../common/pageNavigator.jsp"/>
			</div>
			
	    	</td>
		</tr>
	</table>

</form>


</body>
</html>