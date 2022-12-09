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

nav > ul > li > .pagingBtn{
	display: block;
	color: white;
	text-align: center;
	padding: 16px;
	text-decoration: none;
}
nav > ul > li > .pagingBtn:link{
	color: white;
}
nav > ul > li > .pagingBtn:hover {
	color: white;
	background-color: #a41d53;
	font-weight: bold;
}

.active {
	color: white;
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
	<c:if test="${oPagingMap ne null}">
		<ul>
			<c:if test="${oPagingMap.orderPaging.prevBlock ne 1}">
				<li>
					<a href="#" 
						onclick="goPageFnc(${oPagingMap.orderPaging.prevBlock});">
						<span>«</span>
					</a>
				</li>
			</c:if>
			
			<c:forEach var="num" 
				begin="${oPagingMap.orderPaging.blockBegin}" 
				end="${oPagingMap.orderPaging.blockEnd}">
				<li id='pageButton${num}'>
					<a href="#" class="pagingBtn" onclick="goPageFnc(${num});">
						<c:out value="${num}"/>
					</a>
				</li>
			</c:forEach>
			
			<c:if test="${oPagingMap.orderPaging.curBlock 
				< oPagingMap.orderPaging.totBlock}">
				<li>
					<a href="#" 
						onclick="goPageFnc(${oPagingMap.orderPaging.nextBlock});">
						<span>»</span>
					</a>
				</li>			
			</c:if>			
		</ul>
	</c:if>
</nav>