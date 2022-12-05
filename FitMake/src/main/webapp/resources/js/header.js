$(document).ready(function() {
	myNickNameChk();
	myPointChkFnc();
	viewCartSummaryFnc();

});

function myNickNameChk() {
	$.ajax({
		url: "../user/nickNameChk.do",
		type: "get",
		dataType: "text",
		success: function(data) {
			$("#nicknameChk").html(data);
		}
	});
}

function myPointChkFnc() {
	$.ajax({
		url: "../user/pointChk.do",
		type: "get",
		dataType: "json",
		success: function(data) {
			var data = data.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$("#pointChk").html(data + "원");
		}

	});
}

function viewCartSummaryFnc() {
	$
		.ajax({
			url: "../cart/summary.do",
			type: "get",
			dataType: "html",
			success: function(data) {

				if (data.length == 0) {
					return false;
				}

				var cartMapList = $.parseJSON(data);
				var str = '';
				var cartTotal = 0;


				if (cartMapList < 1) {
					str += '<div style="text-align:center">장바구니가 비었습니다</div>';
				}


				$.each(cartMapList, function(key, value) {
					var iPriceRaw = parseInt(value.FM_ITEM_SELLPRICE);
					var ctCount = parseInt(value.FM_CART_COUNT);
					var iPrice = new Intl.NumberFormat(
						'ko-KR', {
						style: 'currency',
						currency: 'KRW'
					}).format(iPriceRaw * ctCount);

					var ctNo = parseInt(value.FM_CART_NO);

					str += '<tr><td rowspan="3", style="width:40px">';
					str += '<a href="/item/list.do?iNo='
						+ value.FM_ITEM_NO
						+ '">';
					str += '<img alt="image not found" src="../image/' + value.FM_ITEM_STORED_IMG_NAME + '"></a></td>';
					str += '<td style="width:40px;vertical-align : bottom; font-size:13px;">';
					str += '<a href="/item/list.do?iNo='
						+ value.FM_ITEM_NO
						+ '">'
						+ value.FM_ITEM_NAME;
					str += '<td style="width: 40px;text-align:right;"><a onclick="deleteCartFnc('
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
					style: 'currency',
					currency: 'KRW'
				}).format(cartTotal);

				$("#cartPrice").html(cartTotal);
				$("#cartView").html(str);

			},
			error: function(request, status, error) {
				alert("code:"
					+ request.status
					+ "\n"
					+ "message:"
					+ request.responseText
					+ "\n"
					+ "error:"
					+ error);
			}
		});
}

function deleteCartFnc(cartNo) {
	var deletecheck = confirm("장바구니에서 삭제하시겠습니까?");

	if (deletecheck == true) {

		$.ajax({
			url: "../cart/delete.do",
			type: "post",
			dataType: "json",
			data: {
				"ctNo": cartNo
			},
			success: function(data) {
				alert("삭제완료");
				viewCartSummaryFnc();
				location.reload();
			}
		})

	} else {
		return false;
	}
}