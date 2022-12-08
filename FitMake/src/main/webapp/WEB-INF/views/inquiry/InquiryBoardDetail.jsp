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
	#inquiryDetailRootDiv {
		display: flex;
		width : 1200px;
		margin: 0px auto;
		justify-content: space-between;
	}
	#inquiryDetail{
		width: 1000px;
	}
	#inquiryDetailReply{
		display: flex;
		flex-direction: column;
	}
	#titleDiv{
		position: relative;
		overflow: hidden;
	}
	#inquiryDetailTitle{
		font-size: 26px;
		font-weight: 600;
	}
	#inquiryDetailform{
		width: 1000px;
	}
	#inquiryDetailDiv{
		padding: 10px;
 		display: flex; 
		flex-direction: column;
		justify-content: space-between;
	}
	#inquiryDetailTable > tr > td{
		margin-top: 10px;
		border-collapse: collapse;
	}
	.inquiryDetailHead{
		text-align: right;
	}
	#inquiryDetailWriter{
		text-align: left;
	}
	#inquiryDetailContent{
		width: 100%;
	    height: 500px;
		border: none;
		padding: 30px;
		vertical-align: top;
	}
	#inquiryDetailbtnArea{
		width: 200px;
		text-align: right;
	}
	.inquiryBtn{
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
	
	<div id="inquiryDetailRootDiv">
	<jsp:include page="../MyPageLeft.jsp" />
		<div id="inquiryDetail">
			<div id="inquiryDetailReply">
				<jsp:include page="../MyPageNav.jsp" />
				<div id="titleDiv">
					<p id="inquiryDetailTitle">문의상세내용</p>
				</div>
	
				<form id="inquiryDetailform">
					<div id="inquiryDetailDiv">
						<table id="inquiryDetailTable">
							<tr>
								<td colspan="4">
									${inquiryMap.FM_INQUIRY_TITLE}
								</td>
								<td>
									<input type="hidden" id="bNo" name="bNo" value="${inquiryMap.FM_INQUIRY_NO}">
								</td>
							</tr>
							<tr class="inquiryDetailHead" style="border-bottom: 1px solid;">
								<td colspan="3" id="inquiryDetailWriter" class="inquiryDetailHead">
								${inquiryMap.FM_USER_NICKNAME}
								</td>
								<td class="inquiryDetailHead">
									작성일 ${inquiryMap.FM_INQUIRY_CRE_DATE}
								</td>
								<td class="inquiryDetailHead">
									댓글수 ${inquiryMap.rCount}
								</td>
							</tr>
							<tr>
								<td colspan="5">
									<hr>
								</td>
							</tr>
							<tr>
								<td colspan="5" id="inquiryDetailContent">
									${inquiryMap.FM_INQUIRY_CONTENT}
								</td>
							</tr>
							<tr>
								<td colspan="4">
									
								</td>
								<td id="inquiryDetailbtnArea">
									<input type="button" class="inquiryBtn" value="수정">
									<input type="button" class="inquiryBtn" value="삭제" onclick="location.href='./delete.do?bNo=${inquiryMap.FM_INQUIRY_NO}'">
									<input type="button" class="inquiryBtn" value="목록" onclick="location.href='./list.do'">
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
			<jsp:include page="/WEB-INF/views/inquiry/InquiryReply.jsp" />
		</div>
	</div>
</body>
</html>