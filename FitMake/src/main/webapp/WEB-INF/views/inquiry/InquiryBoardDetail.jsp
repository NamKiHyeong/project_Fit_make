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
	#boardRootDiv {
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
	
	<div id="boardRootDiv">
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
				<td colspan="4">
					<input type="text" name="bTitle" value="${boardMap.FM_INQUIRY_TITLE}">
				</td>
				<td>
					<input type="hidden" id="bNo" name="bNo" value="${boardMap.FM_INQUIRY_NO}">
				</td>
			</tr>
				<tr>
					<td colspan="2">
						
					</td>
					<td>
						${boardMap.FM_USER_NICKNAME}
					</td>
					<td>
						${boardMap.FM_INQUIRY_CRE_DATE}
					</td>
					<td>
						${boardMap.igrCount}
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<div>
							${boardMap.FM_INQUIRY_CONTENT}
						</div>
					</td>
				</tr>
				<tr>
					<td>
						
					</td>
					<td>
						<input type="button" value="수정">
						<input type="button" value="삭제" onclick="location.href='./delete.do?bNo=${boardMap.FM_INQUIRY_NO}'">
						<input type="button" value="목록">
					</td>
				</tr>
		</table>
	</form>
	
	<jsp:include page="/WEB-INF/views/inquiry/InquiryReply.jsp" />
</body>
</html>