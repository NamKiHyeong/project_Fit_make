<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<script type="text/javascript">
	$(document).ready(function() {
		viewCartSummaryFnc();
	});

	function viewCartSummaryFnc() {
		$
				.ajax({
					url : "../cart/summary.do",
					type : "get",
					dataType : "json",
					success : function(cartList) {
						var str = '';
						var cartTotal = 0;

						if (cartList < 1) {
							str += '<div style="text-align:center">장바구니가 비었습니다</div>';
						}

						$
								.each(
										cartList,
										function(key, value) {
											var iPriceRaw = parseInt(value.FM_ITEM_SELLPRICE);
											var ctCount = parseInt(value.FM_CART_COUNT);
											var iPrice = new Intl.NumberFormat(
													'ko-KR', {
														style : 'currency',
														currency : 'KRW'
													}).format(iPriceRaw * ctCount);

											var ctNo = parseInt(value.FM_CART_NO);

											str += '<tr><td rowspan="3", style="width:20px">';
											str += '<a href="/item/list.do?iNo='
													+ value.FM_ITEM_NO
													+ '"></a></td>';
											//				str += '<img src="/img/'+value.itemVO.item_imgmain+'">';
											str += '<td style="vertical-align : bottom; font-size:13px;">';
											str += '<a href="/item/list.do?iNo='
													+ value.FM_ITEM_NO
													+ '">'
													+ value.FM_ITEM_NAME;
											str += '<td style="text-align:right;"><a onclick="deleteCartFnc('
													+ ctNo
													+ ');" style="font-size:6px" href="#">';
											str += '<u>삭제하기</u></a></td></tr>';
											str += '<tr><td style="width: 20px ;vertical-align : bottom; font-size:13px;"><p>'
													+ iPriceRaw + '원</p></td>'
											str += '<td style="width: 15% ;vertical-align : bottom; font-size:13px; text-align:right;">';
											str += '<p>' + value.FM_CART_COUNT
													+ '개</p></td></tr>';
											str += '<tr><td colspan="2" style="width:10px;vertical-align:middle;font-size:13px;text-align:right;">';
											str += '<p>' + (iPrice) + '원</p></td></tr>';

											cartTotal = cartTotal
													+ (parseInt(iPriceRaw) * ctCount);
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

	function deleteCartFnc(cartNo) {
		var deletecheck = confirm("장바구니에서 삭제하시겠습니까?");

		if (deletecheck == true) {

			$.ajax({
				url : "../cart/deleteex.do",
				type : "post",
				dataType : "json",
				data : {
					"ctNo" : cartNo
				},
				success : function(data) {
					alert("삭제완료");
					viewCartSummaryFnc();
				}
			})

		} else {
			return false;
		}
	}
</script>
<style type="text/css">
#rightNav {
	float: right;
	width: 300px;
	height: 100%;
	border: 1px solid black;
	padding: 10px;
}

#rootRightNav {
	text-align: center;
	margin-right: 30px;
}
</style>
</head>
<body>
	<div id="rootRightNav">
		<div id="rightNav" aria-hidden="true">
			<a class="rightNavArea" href="../cart/list.do" data-toggle="dropdown">
			</a>

			<div style="" class="">
				<table style="" aria-hidden="true">
					<tbody id="cartView" aria-hidden="true">

					</tbody>
				</table>
				<hr />
				<div style="text-align: right">
					<span style="font-size: 22px;"> total : <span id="cartPrice"></span></span>
				</div>
			</div>
			<ul>
				<li style="font-size: 15px; text-align: right;" aria-hidden="true">
					<a href="../cart/list.do" style="color: black">장바구니 보기</a>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>