$(document).ready(function() {
	// 기본 유효성 검사
	$("#joinSubmit").click(function() {
		var addFormObj = $("#addctrForm");
		var emailChk = $("#emailChk").val();
		var nickNameChk = $("#nickNameChk").val();
		var pwdChk = $("#pwdChk").val();
		var pwd_Re_chk = $("#pwd_Re_chk").val();
		var mobileChk = $("#phone").val();
		var zipcode_Id = $("#zipcode_Id").val();
		var add_Detail = $("#add_Detail").val();
		var weightChk = $("#weightChk").val();
		var heightChk = $("#heightChk").val();

		if (emailChk == '' || emailChk == null) {
			$("#result_checkEmail").html("· 이메일을 입력해주세요");
			$("#emailChk").focus();
			return false;
		}

		if (nickNameChk == '' || nickNameChk == null) {
			$("#result_check_Nickname").html("· 닉네임을 입력해주세요");
			$("#nickNameChk").focus();
			return false;
		}


		if (pwdChk == '' || pwdChk == null) {
			$("#result_check_Re_pwd").html("· 비밀번호를 입력해주세요").css("color", "red");
			$("#pwdChk").focus();
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
		if ($("#phone2").val() != code) {
			alert("· 휴대폰 인증을 완료해주세요");
			return false;
		} else {
			addFormObj.submit();
		}
	});

	// 이메일 중복체크
	$("#emailChk").keyup(function() {
		//이메일 정규식
		let emailRull = RegExp(/^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/);
		let emailChk = $("#emailChk").val();
		if (emailChk == null || emailChk == '') {
			$("#result_checkEmail").html("");
			return false;
		}

		if (!emailRull.test(emailChk)) {
			$("#result_checkEmail").html("· 올바른 형식의 이메일 주소를 입력해주세요").css("color", "red");
			$("#emailChk").focus();
			return false;
		}

		$.ajax({
			type: "post",
			url: "emailCheck.do",
			data: { emailChk: emailChk },
			success: function(data) {
				if (data == "N") {
					result = "· 사용가능한 이메일입니다";
					$("#result_checkEmail").html(result).css("color", "green");
				} else {
					result = "· 이미 사용중인 이메일입니다";
					$("#result_checkEmail").html(result).css("color", "red");
				}
			},
			error: function() {
				console.log("통신실패");
			}
		});
	});
	//닉네임 중복체크
	$("#nickNameChk").keyup(function() {
		//닉네임 정규식
		var nicknameRull = RegExp(/^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/);
		let nickNameChk = $("#nickNameChk").val();
		if (nickNameChk == null || nickNameChk == '') {
			$("#result_check_Nickname").html("");
			return false;
		}

		if (!nicknameRull.test(nickNameChk)) {
			$("#result_check_Nickname").html("· 닉네임은 특수문자를 제외한 조합으로 2~16자리 사용해야합니다").css("color", "red");
			$("#nickNameChk").focus();
			return false;
		}

		$.ajax({
			type: "post",
			url: "nickNameChk.do",
			data: { nickNameChk: nickNameChk },
			success: function(data) {
				if (data == "N") {
					result = "· 사용가능한 닉네임입니다";
					$("#result_check_Nickname").html(result).css("color", "green");
				} else {
					result = "· 이미 사용중인 닉네임입니다";
					$("#result_check_Nickname").html(result).css("color", "red");
				}
			},
			error: function() {
				console.log("통신실패");
			}
		});
	});
	// 가입 비밀번호 일치 여부
	$("#pwdChk, #pwd_Re_chk").keyup(function() {
		var pwdChk = $("#pwdChk").val();
		var user_pwd_check = $("#pwd_Re_chk").val();
		// 비밀번호 정규식
		var pwdRull = RegExp(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,25}$/);
		if (pwdChk == null || pwdChk == '') {
			$("#result_check_Re_pwd").html("");
			return false;
		}

		// test() ㅡ 찾는 문자열이, 들어있는지 아닌지를 알려준다.
		if (!pwdRull.test(pwdChk)) {
			$("#result_check_Re_pwd").html("· 영문자+숫자+특수문자 조합으로 8~25자리 사용해야합니다").css("color", "red");
			$("#pwdChk").focus();
			return false;
		}
		if (user_pwd_check == null || user_pwd_check == '') {
			$("#result_check_Re_pwd").html("· 비밀번호 한번더 입력해주세요").css("color", "black");
			return false;
		}
		if (pwdChk != user_pwd_check) {
			$("#result_check_Re_pwd").html("· 비밀번호가 일치하지 않습니다").css("color", "red");
			return false;
		} else {
			$("#result_check_Re_pwd").html("· 비밀번호가 일치합니다").css("color", "green");
			return false;
		}


	});
	//휴대폰 번호 자동 하이픈
	function autoHypenPhone(str) {
		str = str.replace(/[^0-9]/g, '');
		var tmp = '';
		if (str.length < 4) {
			return str;
		} else if (str.length < 7) {
			tmp += str.substr(0, 3);
			tmp += '-';
			tmp += str.substr(3);
			return tmp;
		} else if (str.length < 11) {
			tmp += str.substr(0, 3);
			tmp += '-';
			tmp += str.substr(3, 3);
			tmp += '-';
			tmp += str.substr(6);
			return tmp;
		} else {
			tmp += str.substr(0, 3);
			tmp += '-';
			tmp += str.substr(3, 4);
			tmp += '-';
			tmp += str.substr(7);
			return tmp;
		}
		return str;
	}

	var cellPhone = document.getElementById('phone');
	cellPhone.onkeyup = function(event) {
		event = event || window.event;
		var _val = this.value.trim();
		this.value = autoHypenPhone(_val);
	}

	//휴대폰 번호 인증
	var code = "";
	$("#phoneChk").click(function() {
		var phoneRull = RegExp(/^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/);
		if (!phoneRull.test($("#phone").val())) {
			$(".successPhoneChk").text("· 휴대폰 번호가 올바르지 않습니다");
			$(".successPhoneChk").css("color", "red");
			$("#phone").attr("autofocus", true);
			return false;
		}
		alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주세요.");

		$.ajax({
			type: "GET",
			url: "phoneCheck.do?",
			data: { phone: $("#phone").val() },
			success: function(data) {
				$("#phone2").attr("disabled", false);
				$("#phoneChk2").css("display", "inline-block");
				$(".successPhoneChk").text("· 인증번호를 입력한 뒤 본인인증을 눌러주세요.");
				$(".successPhoneChk").css("color", "green");
				$("#phone").attr("readonly", true);
				code = $.trim(data);

			}
		});
	});
	//휴대폰 인증번호 대조
	$("#phoneChk2").click(function() {
		if ($("#phone2").val() == null || $("#phone2").val() == '') {
			$(".successPhoneChk").html("· 인증번호 보내기 후 본인인증을 눌러주세요").css("color", "black");
			return false;
		}

		if ($("#phone2").val() == code) {
			$(".successPhoneChk").text("· 인증번호 일치 O");
			$(".successPhoneChk").css("color", "green");
			$("#phoneDoubleChk").val("true");
			$("#phone2").attr("disabled", true);
		} else {
			$(".successPhoneChk").text("· 인증번호가 일치 X");
			$(".successPhoneChk").css("color", "red");
			$("#phoneDoubleChk").val("false");
			$(this).attr("autofocus", true);
		}
	});
});

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