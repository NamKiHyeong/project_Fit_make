<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/fitmake/resources/css/join.css">
<script type="text/javascript" src="/fitmake/resources/js/join.js"></script>
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/fitmake/resources/js/jq_join.js"></script>
<script type="text/javascript">
$(document).ready(function () {
$('input:radio[name="gType"]').on("click", function () {
$('input:radio[name="gType"]').each(function() {
    
    if(this.checked == true){
    	$("#genderInput").val(this.value);
                      
    }
 		});
	});
	
});
</script>
<title>회원가입 페이지</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div id="container">
		<div id="joinDiv">
			<p class="join_Tag">회원가입</p>
			<form action='./addCtr.do' method='post' id="addctrForm">
				<div class="input_p_Css">
					<p class="join_P">
						이메일<em class="join_em_Cl">*</em>
					</p>
					<input type='text' name='email' id="emailChk" class="input_Css"
						placeholder="이메일 입력"> <span id="result_checkEmail"></span>
				</div>
				<div class="input_p_Css">
					<p class="join_P">
						닉네임<em class="join_em_Cl">*</em>
					</p>
					<input type='text' name='nickName' id="nickNameChk"
						class="input_Css" placeholder="닉네임 입력"> <span
						id="result_check_Nickname"></span>
				</div>
				<div class="input_p_Css">
					<p class="join_P">
						비밀번호<em class="join_em_Cl">*</em>
					</p>
					<input type='password' name='password' id="pwdChk"
						class="input_Css" placeholder="비밀번호 입력"
						style="margin-bottom: 12px;"> <span id="result_Check_pwd"></span>
					<input type='password' id="pwd_Re_chk" class="input_Css"
						placeholder="비밀번호 다시 한번 입력"> <span
						id="result_check_Re_pwd"></span>
				</div>
				<div class="input_p_Css">
					<p class="join_P">
						휴대폰<em class="join_em_Cl">*</em>
					</p>
					<input id="phone" type="text" class="mobile_first" name="mobile"
						placeholder="휴대폰번호 입력" maxlength="13" /> <input type="button"
						id="phoneChk" class="doubleChk" value="인증번호 보내기"><br>
					<input id="phone2" type="text" class="mobile_second" name="phone2"
						placeholder="인증번호 입력" disabled /> <input type="button"
						id="phoneChk2" class="doubleChk" value="본인인증"><br> <span
						class="successPhoneChk"></span> <input type="hidden"
						id="phoneDoubleChk" />
				</div>
				<div class="input_p_Css">
					<p class="join_P">
						주소<em class="join_em_Cl">*</em>
					</p>
					<input type="text" id="zipcode_Id" class="zipCode" name="zipCode"
						placeholder="우편번호" readonly="readonly"> <input
						type="button" class="seach_add" onclick="kakaoAddressFnc();"
						value="우편번호 찾기"><br> <input type="text" id="add_1st"
						class="add_1st" name="add_1st" placeholder="주소"
						readonly="readonly"><br> <input type="text"
						id="add_Detail" class="add_Detail" name="add_Detail"
						placeholder="상세주소"> <input type="text" id="add_Extra"
						class="add_Extra" name="add_Extra" placeholder="참고항목"
						readonly="readonly"> <span id="result_check_add"></span>
				</div>
				<div class="input_p_Css">
					<p class="join_P">
						성별<em class="join_em_Cl">*</em>
					</p>
					<label><input type="radio" name="gType" value="M" checked />남성</label>
					<label><input type="radio" name="gType" value="W" />여성</label>
					<input type="hidden" id="genderInput" name="gender" value="">
				</div>
				<div class="input_p_Css">
					<p class="join_P">
						몸무게<em class="join_em_Cl">*</em>
					</p>
					<input type="text" name="weight" id="weightChk" class="input_Css"
						placeholder="숫자만 입력(소수점까지 기입가능)"> <span
						id="result_check_wei"></span>
				</div>
				<div class="input_p_Css">
					<p class="join_P">
						키<em class="join_em_Cl">*</em>
					</p>
					<input type="text" name="height" id="heightChk" class="input_Css"
						placeholder="숫자만 입력(소수점까지 기입가능)"> <span
						id="result_check_hei"></span>
				</div>
				<div>
					<input type="button" value='회원가입' id="joinSubmit"
						onclick="joinSunFnc();">
				</div>
			</form>
		</div>
	</div>
</body>
</html>