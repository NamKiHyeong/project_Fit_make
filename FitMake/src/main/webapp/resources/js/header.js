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
			$("#pointChk").html(data + " 원");
		}

	});
}

function getContextPath() {
	
	return sessionStorage.getItem("contextpath");
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
				var ctx = getContextPath();

				if (cartMapList < 1) {
					str += '<div style="text-align:center">장바구니가 비었습니다</div>';
				}
				
				$.each(cartMapList, function(key, value) {
					var iPriceRaw = new Intl.NumberFormat().format(parseInt(value.FM_ITEM_SELLPRICE));
					var ctCount = parseInt(value.FM_CART_COUNT);
					var iPrice = new Intl.NumberFormat().format(parseInt(value.FM_ITEM_SELLPRICE) * ctCount);

					var ctNo = parseInt(value.FM_CART_NO);

					str += '<tr><td class="cartSummaryImg" rowspan="3">';
					str += '<a href="' + ctx + '/item/one.do?iNo='+ value.FM_ITEM_NO + '">';
					str += '<img alt="image not found" src="../image/' + value.FM_ITEM_STORED_IMG_NAME + '"></a></td>';
					str += '<td class="cartSummaryItemName">';
					str += '<a class="cartSummaryItemName" href="' + ctx + '/item/one.do?iNo='
						+ value.FM_ITEM_NO
						+ '">'
						+ value.FM_ITEM_NAME;
					str += '<td class="cartSummaryDeleteBtnArea"><a onclick="deleteCartFnc('
						+ ctNo
						+ ');" href="#">';
					str += '<u>삭제하기</u></a></td></tr>';
					str += '<tr><td class="cartSummaryPriceEach">'
						+ iPriceRaw + '원</td>'
					str += '<td class="cartSummaryCount">';
					str += value.FM_CART_COUNT
						+ '개</td></tr>';
					str += '<tr><td colspan="2" class="cartSummaryPriceMultiplyWithCount">';
					str += (iPrice) + '원</td></tr>';
					
					cartTotal = cartTotal
						+ (parseInt(value.FM_ITEM_SELLPRICE) * ctCount);
				});
		
				var cartTotal = new Intl.NumberFormat().format(cartTotal)+'원';

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