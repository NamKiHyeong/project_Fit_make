$("document").ready(function() {
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
					result = "· 이미 사용중인 아이디입니다";
					$("#result_checkEmail").html(result).css("color", "red");
				}
			},
			error: function() {
				console.log("통신실패");
			}
		});
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
		alert("· 인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주세요.");

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
			$(".successPhoneChk").html("· 휴대폰 번호 입력 후 인증번호 보내기를 눌러주세요").css("color", "black");
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