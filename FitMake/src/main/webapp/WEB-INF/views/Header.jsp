<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/fitmake/resources/css/header.css">
<title>헤더</title>
<script type="text/javascript">
$(document).ready(function() {
	viewCartSummaryFnc();
});

function viewCartSummaryFnc(){
	$.ajax({
		url : "../cart/summary.do",
		type : "get",
		dataType : "json",
		success : function(cartList){
		var str ='';
		var cartTotal = 0;
		
		if(cartList < 1){
			str += '<div style="text-align:center">장바구니가 비었습니다</div>' ;
		}
		
		$.each(cartList, function(key,value){
			var iPriceRaw = parseInt(value.FM_ITEM_SELLPRICE);
			var iPrice = new Intl.NumberFormat('ko-KR', {
				style : 'currency',
				currency : 'KRW'
			}).format(iPriceRaw);
			
			var ctCount = parseInt(value.FM_CART_COUNT)
			var ctNo = parseInt(value.FM_CART_NO);
			
			str += '<tr><td style="width:18%">';
			str += '<a href="/item/list.do?iNo=' + value.FM_ITEM_NO + '">';
//				str += '<img src="/img/'+value.itemVO.item_imgmain+'"></a></td>';
			str += '<td style="vertical-align : bottom; font-size:13px;">';
			str += '<a href="/item/list.do?iNo=' + value.FM_ITEM_NO + '">'; 
			str += value.FM_ITEM_NAME + '<p>'+value.FM_CART_COUNT + '개</p></a>';
			str += '<a onclick="deleteCartFnc('+ ctNo +');" style="font-size:6px" href="#"><u>삭제하기</u></a></td>';
			str += '<td style="width:20%;vertical-align : middle; font-size:13px;">'+ iPrice +'</td> </tr>';
			
			cartTotal = cartTotal + (parseInt(iPriceRaw) * ctCount);
		});
		
		var cartTotal = new Intl.NumberFormat('ko-KR', {
			style : 'currency',
			currency : 'KRW'
		}).format(cartTotal);
		
		
		$("#cartPrice").html(cartTotal);
		$("#cartView").html(str);
		
		}
	});
}
</script>
</head>
<body>
	<div id="rootDiv">
		<div id="logoInfo_Wrap">
			<div id="headerDiv">
				<ul>
					<c:if test="${_userDto_.email ne null}">
						<li><strong>${_userDto_.nickName}</strong>님&nbsp;&nbsp;</li>
						<li><strong>${_userDto_.point}원</strong>&nbsp;&nbsp;</li>
						<li><a
							href="${pageContext.request.contextPath}/auth/logout.do">로그아웃</a></li>
					</c:if>
				</ul>
			</div>
			<div id="logo_infoDiv">
				<div id="logo">
					<form action="./mainpage/main.do" method="get">

						<a href="${pageContext.request.contextPath}/main/main.do"><img
							alt="메인로고" src="/fitmake/resources/image/mainlogo.jpg"></a>
					</form>
				</div>
				<div id="infoDiv">
					<c:if test="${_userDto_.email ne null}">
						<ul>
							<li><a href="#"><img alt="포인트관리"
									src="/fitmake/resources/image/point.png"></a></li>
							<li><a href="${pageContext.request.contextPath}/user/Info.do"><img alt="내정보"
									src="/fitmake/resources/image/myinfo.png"></a></li>
							<li><a href="${pageContext.request.contextPath}/order/list.do"><img alt="주문관리"
									src="/fitmake/resources/image/membermanagement.png"></a></li>
							<li><a href="${pageContext.request.contextPath}/cart/list.do"><img alt="장바구니"
									src="/fitmake/resources/image/cart.png"></a>
								<a  class="dropdown-toggle" href="../cart/list.do"  data-toggle="dropdown">
									<span class="icon-basket" aria-hidden="true"></span>
								</a>
					        	<ul class="dropdown-menu">
					            	<li class="dropdown" id="cartHeaderIcon"> 
					               		<div style="width:550px;" class="bg-light">
					               			<table class="table table-hover bg-light" style="">
						                    	<tbody id="cartView">
						
						                    	</tbody>
					                  		</table>
						                  	<hr/>
											<div style="text-align:right" class="font-serif">
												<span style="font-size:22px;"> total : <span id="cartPrice"></span></span>
							              	</div>
										</div>
									</li>
									<li class="dropdown" style="font-size:15px;text-align:right;">
										<a href="../cart/list.do" style="color:white">장바구니 보기</a>
									</li>
								</ul>
							</li>
						</ul>
					</c:if>
				</div>
			</div>
		</div>
		<div id="menu">
			<div id="navDiv">
				<c:if test="${_userDto_.email ne null}">
					<ul>
						<li><img alt="목록"
							src="/fitmake/resources/image/Kategorie.png"> 전체 카테고리</li>
						<li><a href="${pageContext.request.contextPath}/item/list.do">다이어트</a></li>
						<li><a href="#">식단</a></li>
						<li><a href="#">특가</a></li>
						<li><a href="#">베스트</a></li>
					</ul>
				</c:if>
			</div>
		</div>
	</div>
	<div id="padding_Div"></div>
</body>
</html>