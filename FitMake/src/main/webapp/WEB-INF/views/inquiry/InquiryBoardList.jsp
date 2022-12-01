<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	
</script>
<style type="text/css">
	#orderRootDiv {
		width : 1200px;
		margin: 0px auto;
		align-content: left;
 		align-items: left; 
	}
	#headTitle {
		font-size: 40px;
	}
	#headTable {
		width: 80%;
		margin-top: 5%;
		margin-left: 3%;
		padding-left: 6.5%;
		text-align: left;
	}
	#headHr {
		width: 75%;
		margin-left: 10%;
		margin-top: 2.4%
	}
	
	#fncDiv{
		text-align: right;
		margin-top: 2%; 
	}
	#searchSection {
		float: left;
		width: 40%;
		text-align: left;
		margin-left: 5%;
	}
	#btnSection{
		float: right;
		width: 30%;
		text-align: right;
	}
</style>
<title>주문관리</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/Header.jsp" />
	
	<div id="orderRootDiv">
	<jsp:include page="../MyPageLeft.jsp" />
		<div id="titleDiv">
			<table id="headTable">
				<tr>
					<th id="headTitle">문의게시판</th>
				</tr>
			</table>
			<hr id="headHr">
		</div>
	</div>
	
	<form id="form">
		<table>
			<tr>
				<td>
					
				</td>
				<td>
					문의제목
				</td>
				<td>
					댓글수
				</td>
				<td>
					작성일
				</td>
			</tr>
			<c:forEach var="boardMap" items="${BoardMapList}">
				<tr>
					<td>
						${boardMap.FM_INQUIRY_NO}
					</td>
					<td>
						${boardMap.FM_INQUIRY_TITLE}
					</td>
					<td>
					</td>
					<td>
						${boardMap.igrCount}
					</td>
					<td>
						${boardMap.FM_INQUIRY_CRE_DATE}
					</td>
				</tr>
			</c:forEach>
		</table>
	</form>
	
	
	<jsp:include page="/WEB-INF/views/inquiry/InquiryPaging.jsp" />
	
	<div id="pagingSection">
		<form id="pagingForm" action="./list.do" method="get">
			<input type="hidden" id="curPage" name="curPage" value="${iqPagingMap.iqPaging.curPage}">
		</form>
	</div>
	
</body>
</html>