<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
	<style>
	 #sgr {
        color: yellow;
        background-color: black;
      }
	
	</style>
<div class="navbar navbar-fixed-top" id="sgr">
	

	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp" id="sgr">����Shop</a>
		
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header" >
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target" >
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew" >
	         
	         	<!-- Tool Bar �� �پ��ϰ� ����ϸ�.... -->
	             <ul class="nav navbar-nav">
	             
	              <!--  ȸ������ DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" id="sgr">
	                         <span >ȸ������</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#" id="sgr">����������ȸ</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'admin'}">
	                         	<li><a href="#" id="sgr">ȸ��������ȸ</a></li>
	                         </c:if>
	                         
	                        
	                         <li><a href="#" id="sgr">etc...</a></li>
	                     </ul>
	                 </li>
	                 
	              <!-- �ǸŻ�ǰ���� DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" id="sgr">
		                         <span >��ǰ����</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu" >
		                         <li><a href="#" id="sgr">�ǸŻ�ǰ���</a></li>
		                         <li><a href="#" id="sgr">�ǸŻ�ǰ����</a></li>
		                        
		                         <li><a href="#" id="sgr">etc..</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- ���Ű��� DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" id="sgr">
	                         <span >��ǰ����</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#" id="sgr">�� ǰ �� ��</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'user'}">
	                           <li><a href="#" id="sgr">�����̷���ȸ</a></li>
	                         </c:if>
	                         
	                         <li><a href="#" id="sgr">�ֱٺ���ǰ</a></li>
	                      
	                         <li><a href="#" id="sgr">etc..</a></li>
	                     </ul>
	                 </li>
	                 
	                 <li><a href="#" id="sgr">etc...</a></li>
	             </ul>
	             
	             <ul class="nav navbar-nav navbar-right">
	                <li><a href="#" id="sgr">�α׾ƿ�</a></li>
	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
   	<script type="text/javascript">
	
		//============= logout Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('�α׾ƿ�')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
				//self.location = "/user/logout"
			}); 
		 });
		
		//============= ȸ��������ȸ Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('ȸ��������ȸ')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		
		//=============  ����������ȸȸ Event  ó�� =============	
	 	$( "a:contains('����������ȸ')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		});
		 $(function() {
				//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 	$("a:contains('�ǸŻ�ǰ���')").on("click" , function() {
					//$(self.location).attr("href","/user/logout");
					self.location = "/product/addProduct"
				}); 
			 });
			
			//=============  ����������ȸȸ Event  ó�� =============	
		 	$( "a:contains('�ǸŻ�ǰ����')" ).on("click" , function() {
		 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				self.location = "/product/listProduct?menu=manage"
			});
			 $(function() {
					//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				 	$("a:contains('�� ǰ �� ��')").on("click" , function() {
						//$(self.location).attr("href","/user/logout");
						self.location = "/product/listProduct?menu=search"
					}); 
				 });
				
				//=============  ����������ȸȸ Event  ó�� =============	
			 	$( "a:contains('�ֱٺ���ǰ')" ).on("click" , function() {
			 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
					self.location = "history_backup.jsp"
				});
				 $(function() {
						//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
					 	$("a:contains('�����̷���ȸ')").on("click" , function() {
							//$(self.location).attr("href","/user/logout");
							self.location = "/purchase/listPurchase"
						}); 
					 });
		
		
	</script>  