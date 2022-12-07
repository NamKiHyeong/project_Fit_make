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

nav > ul > li > a:link {
	color: #ffffff;
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

<script type="text/javascript">
	window.onload = function(){
		var curPageDoc = $('#curPage');
		var pageButtonId = '#pageButton' + curPageDoc.val();
		
		$(pageButtonId).addClass('active');
		
	}
	
	function goPageFnc(pageNumber){
		var curPageObj = $("#curPage");
		curPageObj.val(pageNumber);
		
		$("#pagingForm").submit();
	}
</script>

<nav id="pagingNav">
		<ul>
		<c:if test="${uPagingMap.userPaging.prevBlock ne 1}">
			<li>
				<a href="#" 
					onclick="goPageFnc(${uPagingMap.userPaging.prevBlock});">
					<span>«</span>
				</a>
			</li>
		</c:if>
		
		<c:forEach var="num" 
			begin="${uPagingMap.userPaging.blockBegin}" 
			end="${uPagingMap.userPaging.blockEnd}">
			<li id='pageButton${num}'>
				<a href="#" onclick="goPageFnc(${num});">
					<c:out value="${num}"/>
				</a>
			</li>
		</c:forEach>
		
		<c:if test="${uPagingMap.userPaging.curBlock 
			< uPagingMap.userPaging.totBlock}">
			<li>
				<a href="#" 
					onclick="goPageFnc(${uPagingMap.userPaging.nextBlock});">
					<span>»</span>
				</a>
			</li>			
		</c:if>			
	
			
		</ul>
	</nav>