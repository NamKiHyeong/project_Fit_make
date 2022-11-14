function joinSunFnc() {
	var addFormObj = document.getElementById("addctrForm");
	var emailChkVal = document.getElementById("emailChk").value;
	var nickNameChkVal = document.getElementById("nickNameChk").value;
	var pwdChkVal = document.getElementById("pwdChk").value;
	var mobileChkVal = document.getElementById("mobileChk").value;
	var zipChkVal = document.getElementById("zipChk").value;
	var addressChkVal = document.getElementById("addressChk").value;
// 	var genderChkVal = document.getElementById("genderChk").value;
	var weightChkVal = document.getElementById("weightChk").value;
	var heightChkVal = document.getElementById("heightChk").value;
	
	if (emailChkVal == '' || emailChkVal == null) {
		alert("[필수] 이메일을 입력해주세요")
	} else if (nickNameChkVal == '' || nickNameChkVal == null) {
		alert("[필수] 닉네임을 입력해주세요")
	} else if (pwdChkVal == ''|| pwdChkVal == null) {
		alert("[필수] 비밀번호를 입력해주세요")
	} else if (mobileChkVal == '' || mobileChkVal == null) {
		alert("[필수] 전화번호를 입력해주세요")
	} else if (zipChkVal == '' || zipChkVal == null) {
		alert("[필수] 우편번호를 등록하세요")
	} else if (addressChkVal == '' || addressChkVal == null) {
		alert("[필수] 주소를 입력해주세요")
	} else if (weightChkVal == '' || weightChkVal == null) {
		alert("[필수] 몸무게를 기입해주세요")
	} else if (heightChkVal == '' || heightChkVal == null) {
		alert("[필수] 키를 기입해주세요")
	} else {
		addFormObj.submit();
	}
	
};