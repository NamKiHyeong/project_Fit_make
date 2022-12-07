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
	#inquiryListRootDiv {
		display: flex;
		width : 1200px;
		margin: 0px auto;
		justify-content: space-between;
	}
	#pagingDiv{
		display: flex;
		flex-direction: column;
	}
	#inquiryList{
		width: 1000px;
	}
	#titleDiv{
		position: relative;
		overflow: hidden;
	}
	#inquiryHeadTitle{
		font-size: 26px;
		font-weight: 600;
	}
	.inquiryListDiv{
 		display: flex; 
		flex-direction: column;
	}
	.inquiryListTableTitle{
		text-align: center;
	}
	#inquiryListTable{
		border-spacing : 0px;
	}
	.inquiryListTr{
		border-bottom: 1px solid black;
		border-collapse: collapse; 
	}
	.inquiryListTitleTr > td{
		border-spacing : 0px;
		border-bottom: 1px solid #afa9a9;
		border-collapse: collapse; 
		height: 30px;
	}
	.inquiryListContent{
		text-align: center;
		height: 30px;
	}
	#emptyTable{
		font-size: 20px;
		font-weight: 600;
		text-align: center;
	}
	#AddInquiryBtnArea{
		text-align: right;
	}
	#pagingNav {
		display: flex;
	}
	#AddInquiryBtn{
		margin-left: 10px;
		width: 100px;
		background: #d7266d;
		border: 2px solid #d7266d;
		color: #fff;
		text-align: center;
		cursor: pointer;
	}
</style>
<title>FitMake</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div style="height: 50px;"></div>
	<div id="inquiryListRootDiv">
		<jsp:include page="../MyPageLeft.jsp" />
		<div id="pagingDiv">
			<div id="inquiryList">
				<jsp:include page="../MyPageNav.jsp" />
				<div id="titleDiv">
					<p id="inquiryHeadTitle">문의게시판</p>
				</div>
			
	
				<form id="inquiryForm">
					<div class="inquiryListDiv">
						<table id="inquiryListTable">
							<c:if test="${inquiryMapList.size() > 0}">
								<tr class="inquiryListTitleTr">
									<td>
										
									</td>
									<td class="inquiryListTableTitle">
										문의제목
									</td>
									<td class="inquiryListTableTitle">
										댓글수
									</td>
									<td class="inquiryListTableTitle">
										작성일
									</td>
								</tr>
							</c:if>
							<c:forEach var="inquiryMap" items="${inquiryMapList}">
								<tr class="inquiryListTr">
									<td class="inquiryListContent">
										<input type="hidden" name="bNo" value="${inquiryMap.FM_INQUIRY_NO}">
									</td>
									<td class="inquiryListContent">
										<a href="./detail.do?bNo=${inquiryMap.FM_INQUIRY_NO}">${inquiryMap.FM_INQUIRY_TITLE} </a>
									</td>
									<td class="inquiryListContent">
										${inquiryMap.igrCount}
									</td>
									<td class="inquiryListContent">
										${inquiryMap.FM_INQUIRY_CRE_DATE}
									</td>
								</tr>
							</c:forEach>
						
							<c:if test="${inquiryMapList.size() == 0}">
								<tr>
									<td id="emptyTable" colspan="4">
										문의 내역이 없습니다
									</td>
								</tr>
							</c:if>
							<tr>
								<td colspan="4" id="AddInquiryBtnArea">
									<input type="button" id="AddInquiryBtn" value="문의하기" onclick="location.href='./add.do'">
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		<jsp:include page="/WEB-INF/views/inquiry/InquiryPaging.jsp" />
		</div>
	</div>
	
	<div id="pagingSection">
		<form id="pagingForm" action="./list.do" method="get">
			<input type="hidden" id="curPage" name="curPage" value="${iqPagingMap.iqPaging.curPage}">
		</form>
	</div>
	
</body>
</html>