<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
    
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>

	<title>�ֹ� �Ϸ�</title>

</head>

<body>

	<form>
		���� �Ϸ�
	<c:set var="i" value="0"></c:set>
	
	<c:forEach var="list" items="${list}">
	
		<table border=1>
			<tr>
				<td>��ǰ��ȣ</td>
				<td>${list.purchaseProd.prodNo}</td>
				<td></td>
			</tr>
			<tr>
				<td>�����ھ��̵�</td>
				<td>${list.buyer.userId}</td>
				<td></td>
			</tr>
			<tr>
				<td>���Ź��</td>
				<td>
					${list.paymentOption == 1 ? '���ݱ���' : '�ſ뱸��' }			
				</td>
				<td></td>
			</tr>
			<tr>
				<td>�������̸�</td>
				<td>${list.receiverName}</td>
				<td></td>
			</tr>
			<tr>
				<td>�����ڿ���ó</td>
				<td>${list.receiverPhone}</td>
				<td></td>
			</tr>
			<tr>
				<td>�������ּ�</td>
				<td>${list.divyAddr}</td>
				<td></td>
			</tr>
				<tr>
				<td>���ſ�û����</td>
				<td>${list.divyRequest}</td>
				<td></td>
			</tr>
			<tr>
				<td>����������</td>
				<td>${list.divyDate}</td>
				<td></td>
			</tr>
		</table>
		
		</c:forEach>
		
	</form>

</body>

</html>