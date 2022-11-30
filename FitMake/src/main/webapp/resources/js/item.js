$(document).ready(function() {
	
	$("#addCartListBtn").on("click", function(){
		
		var iNo = [];
		
		$('input:checkbox[name="iCkBox"]').each(function() {
			
			if(this.checked == true){
				iNo.push(this.value);
			}
		});
		
		var itemCart = { 
				"iNo" : iNo,
				"iCount" : 1
		};
				
		$.ajax({
			type : "POST",
			url : "../cart/addex.do",
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
					viewCartSummaryFnc();

					alert("장바구니 추가완료");
				} else if (data == 2) {

					alert("이미 추가 된 상품입니다");
				}

			}
		});
		
	});
	
	$("#addCartBtn").on("click", function(){
		
		var iNo = [];
		
		iNo.push($("#iNoInput").val());
		
		var itemCart = { 
				"iNo" : iNo,
				"ctCount" : $("#ctCountInput").val()
		};
		
		$.ajax({
			type : "POST",
			url : "../cart/addex.do",
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
					viewCartSummaryFnc();

					alert("장바구니 추가완료");
				} else if (data == 2) {

					alert("이미 추가 된 상품입니다");
				}

			}
		});
		
	});
	
	$("#addOrderBtn").on("click", function() {
		$("#itemOneForm").attr("action", "../order/add.do");
		$("#itemOneForm").attr("method", "post");
		$("#itemOneForm").submit();
		
	});
	
	viewCartSummaryFnc();
	
});
	function itemOneFnc(no){
		//pagingForm에 curPage
		
		var idStr = 'itemOneForm' + no;
		var itemOneFormObj = document.getElementById(idStr);
		
		itemOneFormObj.submit();
		
	}
	function itemOneAsc(){
		var itemOneFormObj = document.getElementById("pagingForm");
		itemOneFormObj.submit();
	}
	
//----------------------------------------------------------------
	//리스트로 이동
	function pageMoveListFnc(cNo) {
		location.href="../item/list.do?cNo=" + cNo;
	}
	
	
	
	function pageMoveBefore(iNo){
		
		var url ="./one.do?no=" + iNo;
		location.href = url;
//		/views/item/ItemOne.jsp
//		/views/review/ReviewList.jsp
//<h3><a href="/fitmake/WEB-iNF/views/review/list.do?cNo=1">리뷰</a></h3>
	}
//------------------------------------------------------------------


	function pageReviewFnc(iNo){
		location.href="../review/add.do?iNo=" + iNo;
		
	}
//-----------------------------------------------------
	function itemDeleteOneFnc(iNo, cNo){
		var url = "./deleteOne.do?iNo=" + iNo + '&cNo=' + cNo;
		location.href = url;
	}
	function deleteFileFnc(obj){
		
		$(obj).parent().remove();
	}
	
	function fileUpdateFnc(){
		var obj = $('#fileContent');
		var htmlStr = "";
		
		htmlStr += '<div>';
		htmlStr += '<input type="hidden" id="fileIdx" name="fileIdx"';
		htmlStr += ' value="">';
		htmlStr += '<input type="file" id="file0" name="file0">';
		htmlStr += '<a href="#this" id="delete0">삭제</a><br>';
		htmlStr += '</div>';
		
		obj.html=(htmlStr);
		
		$('a[id^="delete"]').on('click', function(e){
			e.preventDefault();
			deleteFileFnc($(this));
		});
	}
	function deleteItemFnc(iNo){
	      var deletecheck = confirm("제품을 삭제하시겠습니까?");
	      
	      if(deletecheck == true){
	         location.href = "./deleteOne.do?iNo=" + iNo + '&cNo=' + cNo;
	      } else {
	         return false;
	      }
	   }
//-------------------------------------------------------------