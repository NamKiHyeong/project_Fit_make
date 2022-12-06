<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<style type="text/css">
nav > ul{
	list-style-type: none;
	padding: 0px;
	overflow: hidden;
	background: #d7266d;
	border: 0px solid #ffffff;
	display: table;
	margin-left: auto;
	margin-right: auto;
}

nav > ul > li{
	float: left;
}

nav > ul > li > a{
	display: block;
	color: white;
	text-align: center;
	padding: 16px;
	text-decoration: none;
}

nav > ul > li > a:hover {
	color: #ffffff;
	background-color: #a41d53;
	font-weight: bold;
}

.active {
	color: #ffffff;
    background-color: #a41d53;
    font-weight: bold;
}


</style>

<script type="text/javascript" 
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript">
	function goPageFnc(pageNumber){
// 		var curPageObj = document.getElementById('curPage');
		
// 		curPageObj.value = pageNumber;
		
// 		var pagingFormObj = document.getElementById('pagingForm');
// 		pagingFormObj.submit();

		var curPageObj = $("#curPage");
		curPageObj.val(pageNumber);
		
// 		alert(curPageObj.val());
		
		$("#pagingForm").submit();
	}
	
	window.onload = function(){
// 		var curPageObj = document.getElementById('curPage');
		
// 		var pageButtonIdStr = 'pageButton' + curPageObj.value;
		
// 		alert(pageButtonIdStr);
		
// 		var pageButtonObj = document.getElementById(pageButtonIdStr);
		
// 		pageButtonObj.setAttribute('class', 'active');
		
		var curPageDoc = $('#curPage');
		var pageButtonId = '#pageButton' + curPageDoc.val();
		
		$(pageButtonId).addClass('active');
		
		
	}
</script>

<nav>
		<ul>
		<c:if test="${pagingMap.itemPaging.prevBlock ne 1}">
			<li>
				<a href="#" 
					onclick="goPageFnc(${pagingMap.itemPaging.prevBlock});">
					<span>«</span>
				</a>
			</li>
		</c:if>
		
		<c:forEach var="num" 
			begin="${pagingMap.itemPaging.blockBegin}" 
			end="${pagingMap.itemPaging.blockEnd}">
			<li id='pageButton${num}'>
				<a href="#" onclick="goPageFnc(${num});">
					<c:out value="${num}"/>
				</a>
			</li>
		</c:forEach>
		
		<c:if test="${pagingMap.itemPaging.curBlock 
			< pagingMap.itemPaging.totBlock}">
			<li>
				<a href="#" 
					onclick="goPageFnc(${pagingMap.itemPaging.nextBlock});">
					<span>»</span>
				</a>
			</li>			
		</c:if>			
	
			
		</ul>
	</nav>