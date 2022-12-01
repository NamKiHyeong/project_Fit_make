// 회원가입 유효성 검사 (임시 제이쿼리로 다 바꿀예정)
function joinSunFnc() {
	var addFormObj = $("#addctrForm");
	var pwdChk = $("#pwdChk").val();
	var pwd_Re_chk = $("#pwd_Re_chk").val();
	var mobileChk = $("#phone").val();
	var zipcode_Id = $("#zipcode_Id").val();
	var add_Detail = $("#add_Detail").val();
	var weightChk = $("#weightChk").val();
	var heightChk = $("#heightChk").val();



	if (pwdChk == '' || pwdChk == null) {
		$("#result_check_Re_pwd").html("· 비밀번호를 입력해주세요").css("color", "red");
		$("#pwdChk").focus();
		return false;
	}

	// 비밀번호 정규식
	var pwdRull = RegExp(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,25}$/);

	// test() ㅡ 찾는 문자열이, 들어있는지 아닌지를 알려준다.
	if (!pwdRull.test(pwdChk)) {
		$("#result_check_Re_pwd").html("· 비밀번호는 영문자+숫자+특수문자 조합으로 8~25자리 사용해야합니다").css("color", "red");
		$("#pwdChk").focus();
		return false;
	}
	if (pwdChk != pwd_Re_chk) {
		$("#result_check_Re_pwd").html("· 비밀번호가 일치하지 않습니다").css("color", "red");
		$("#pwd_Re_chk").focus();
		return false;
	}

	if (mobileChk == '' || mobileChk == null) {
		$("#successPhoneChk").html("· 휴대폰 번호를 입력해주세요").css("color", "red");
		$("#phone").focus();
		return false;
	}

	if (zipcode_Id == '' || zipcode_Id == null) {
		$("#result_check_add").html("· 우편번호를 등록하세요").css("color", "red");
		$("#zipcode_Id").focus();
		return false;
	}

	if (add_Detail == '' || add_Detail == null) {
		$("#result_check_add").html("· 상세주소를 입력해주세요").css("color", "red");
		$("#add_Detail").focus();
		return false;
	}

	if (weightChk == '' || weightChk == null) {
		$("#result_check_wei").html("· 몸무게를 기입해주세요").css("color", "red");
		$("#weightChk").focus();
		return false;
	}

	if (heightChk == '' || heightChk == null) {
		$("#result_check_hei").html("· 키를 기입해주세요").css("color", "red");
		$("#heightChk").focus();
		return false;
	}
	
	if ($("#phoneDoubleChk").val == true){
		addFormObj.submit();
	} else {
		alert("· 휴대폰인증을 완료해주세요");
		return false;
	}


};

// 우편주소 api 로직 
function kakaoAddressFnc() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if (data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', '
						+ data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraAddr !== '') {
					extraAddr = ' (' + extraAddr + ')';
				}
				// 조합된 참고항목을 해당 필드에 넣는다.
				document.getElementById("add_Extra").value = extraAddr;

			} else {
				document.getElementById("add_Extra").value = '';
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('zipcode_Id').value = data.zonecode;
			document.getElementById("add_1st").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("add_Detail").focus();
		}
	}).open();
}