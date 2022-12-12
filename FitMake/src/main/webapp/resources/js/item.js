$(document).ready(function() {
		
	$("#addCartBtn").on("click", function(){
		
		var iNo = [];
		var ctCount = $("#ctCountInput").val();
		
		if($('input:checkbox[name="iCkBox"]').length > 0){
			$('input:checkbox[name="iCkBox"]').each(function() {
				if(this.checked == true){
					iNo.push(this.value);
				}
			});
		} else{
			iNo.push($("#iNoInput").val());			
		}
		
		var itemCart = { 
				"iNo" : iNo,
				"ctCount" : ctCount
		};
		
		$.ajax({
			type : "POST",
			url : "../cart/add.do",
			dataType : "json",
			data : itemCart,
			error : function(request, status, error) {
				alert("code:"
						+ request.status
						+ "\n"
						+ "message:"
						+ request.responseText
						+ "\n"
						+ "error:"
						+ error);
			},
			success : function(data) {

				if (data == 1) {
					alert("장바구니에 추가되었습니다");
					
					viewCartSummaryFnc();
					var confirmCart = confirm("장바구니로 이동하시겠습니까?");
					
					if(confirmCart == true){
						location.href ='../cart/list.do';
					} else{
						return false;
					}
				} else if (data == 2) {

					alert("이미 추가 된 상품입니다");
				}

			}
		});
		
	});
	
	$("#addOrderBtn").on("click", function() {
		
		var itemBuyCheck = confirm("해당 상품을 구매하시겠습니까?");
		
		if(itemBuyCheck == true){
			$("#itemOneForm").attr("action", "../order/add.do");
			$("#itemOneForm").attr("method", "post");
			$("#itemOneForm").submit();
		} else{
			return false;
		}
		
	});
	
	viewCartSummaryFnc();
	
//	------------------------------------
	$("a[id^='delete']").on('click', function(e){ // 삭제 버튼
		e.preventDefault();
		deleteFileFnc($(this));
	});
	
	
});

function itemOneFnc(iNo){
	//pagingForm에 curPage
	var idStr = 'itemOneForm' + iNo;
	var itemOneFormObj = document.getElementById(idStr);
	
	
	itemOneFormObj.submit();
	
}
function itemOneAsc(){
	var itemOneFormObj = document.getElementById("pagingForm");
	itemOneFormObj.submit();
}
	
//----------------------------------------------------------------
//리스트로 이동
function pageMoveListFnc(cNo, curPage) {
	
	location.href='./list.do?cNo='+ cNo + '&curPage=' + curPage;
	
}
	
	
	
	
//------------------------------------------------------------------



function pageReviewListFnc(iNo){
	location.href="../review/list.do?iNo=" + iNo;
}
//-----------------------------------------------------

	
//-------------------------------------------------------------