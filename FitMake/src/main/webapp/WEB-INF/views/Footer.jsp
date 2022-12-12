<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#inquiryBtn").click(function() {
			location.href = "../inquiry/add.do";
		});
	});
</script>
<!-- headerCSS에 footerCSS 통합 -->
</head>

<body>
	<footer>
		<div id="footerArea">
			<div id="containerFdiv">
				<span><img alt="메인 로고"
					src="/fitmake/resources/image/mainlogo.jpg"></span>
				<ul id="firstUl">
					<li><span><strong>회사소개</strong></span></li>
					<li class="footerContent"><span>(주) 회사 이름 - FitMake</span></li>
					<li class="footerContent"><span>대표 - 김태훈</span></li>
					<li class="footerContent"><span>전화 - 김태훈</span></li>
					<li class="footerContent"><span>주소 - 인천광역시 남동구 인주대로 593
							엔타스빌딩 12층</span></li>
					<li><span>&copy; 2022, FITMAKE</span></li>
				</ul>
				<ul id="secondUl">
					<li><span><strong>고객센터 C/S Center</strong></span></li>
					<li class="footerContent"><span>전화 : 010-1234-1234</span></li>
					<li class="footerContent"><span>이메일 : fitmake@naver.com</span></li>
					<li class="footerContent"><span>카카오톡 ID : FitMake</span></li>
					<li class="footerContent"><span>오전 9시부터 오후 6시까지
							상담가능합니다.
							<c:if test="${_userDto_.uNo != 1}"><button id="inquiryBtn">문의하기</button></c:if>
					</span></li>
				</ul>
			</div>
		</div>
	</footer>
</body>


</html>