<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
#history_Container {
	display: flex;
	width: 1200px;
	margin: 0px auto;
	justify-content: space-between;
}

#historytableDiv table {
	border-collapse: collapse;
	width: 100%;
}

#historytableDiv table, th, tr, td {
	border: 1px solid;
}

#historyDiv {
	width: 1000px;
}
</style>
<title>FitMake</title>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<div id="history_Container">
		<jsp:include page="../MyPageLeft.jsp"/>
		<div id="historyDiv">
			<jsp:include page="../MyPageNav.jsp"/>
			<h1>충전/사용내역</h1>
		<div id="historytableDiv">
		<table>
			<tr>
				<th>번호</th>
				<th>1</th>
				<th>2</th>
				<th>3</th>
			</tr>
			<tr>
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td>4</td>
			</tr>
			<tr>
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td>4</td>
			</tr>
			<tr>
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td>4</td>
			</tr>
			<tr>
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td>4</td>
			</tr>
			<tr>
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td>4</td>
			</tr>
		</table>
		</div>
		</div>
	</div>
</body>
</html>