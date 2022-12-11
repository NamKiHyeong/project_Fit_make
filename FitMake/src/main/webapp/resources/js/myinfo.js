$(document).ready(function() {

	$("#nickNameChk").keyup(function() {
		//닉네임 정규식
		var nicknameRull = RegExp(/^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/);
		let nickNameChk = $("#nickNameChk").val();
		if (nickNameChk == null || nickNameChk == '') {
			$("#result_check_Nickname").html("· 변경할 닉네임을 입력해주세요");
			$("#result_check_Nickname").css("color", "black");
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
					result = "· 동일 닉네임이거나 이미 사용중인 닉네임입니다";
					$("#result_check_Nickname").html(result).css("color", "red");
				}
			},
			error: function() {
				console.log("통신실패");
			}
		});
	});

	$("#new_user_pwd, #new_user_pwd_check").keyup(function() {
		var pwdChk = $("#new_user_pwd").val();
		var new_user_pwd_check = $("#new_user_pwd_check").val();
		// 비밀번호 정규식
		var pwdRull = RegExp(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,25}$/);
		if (pwdChk == null || pwdChk == '') {
			$("#result_check_Re_pwd").html("");
			return false;
		}

		// test() ㅡ 찾는 문자열이, 들어있는지 아닌지를 알려준다.
		if (!pwdRull.test(pwdChk)) {
			$("#result_check_Re_pwd").html("· 영문자+숫자+특수문자 조합으로 8~25자리 사용해야합니다").css("color", "red");
			$("#new_user_pwd").focus();
			return false;
		}
		if (pwdChk != new_user_pwd_check) {
			$("#result_check_Re_pwd").html("· 비밀번호가 일치하지 않습니다").css("color", "red");
			$("#new_user_pwd_check").focus();
			return false;
		} else {
			$("#result_check_Re_pwd").html("· 비밀번호가 일치합니다").css("color", "green");
			return false;
		}


	});

	// 금액 콤마
	var point = $('#myPonit').val();
	var pointcomma = point.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	$('#myPonit').val(pointcomma);

	
	// DB에 저장된 M,W을 남성,여성으로 변환
	var infoGender = $("#infoGender").val();

	if (infoGender == "M") {
		$("#infoGender").val("남성");
	} else if (infoGender == "W") {
		$("#infoGender").val("여성");
	}

});

// 회원정보수정에서 비밀번호 변경 버튼 클릭 -> 신규 비밀번호 작성란 생성 
function viewPwdChange() {
	if ($("#trpwd1").is(':visible') == false) {
		$("#trpwd1").show();
		$("#trpwd2").show();
	} else {
		$("#trpwd1").hide();
		$("#trpwd2").hide();
		$("#new_user_pwd").val("");
		$("#new_user_pwd_check").val("");
	}
}

// 충전 버튼 클릭 -> 팝업창 실행
function showPopup() {
	window.open("/fitmake/user/point.do", "point",
		"width=500px, height=400px, left=100px, top=50px");
}