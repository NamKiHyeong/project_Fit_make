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
})

function viewCartSummaryFnc(){
	$.ajax({
		url : "/cart/summary.do",
		type : "get",
		dataType : "json",
		success : function(cartList){
		var str ='';
		var cartTotal = 0;
		
		if(cartList < 1){
			str += '<div style="text-align:center">쇼핑백이 비었습니다</div>' ;
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
</script>
</head>
<body>
	<div>
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
						<a href="../cart/list.do" style="color:white">쇼핑백 보기</a>
					</li>
				</ul>
	</div>
</body>
</html>