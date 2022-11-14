<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/fitmake/resources/css/join.css">
<script type="text/javascript" src="/fitmake/resources/js/join.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
unction sample6_execDaumPostcode() {
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
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}
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
					<p>
						이메일<em class="join_em_Cl">*</em>
					</p>
					<input type='text' name='email' id="emailChk" class="input_Css"
						placeholder="이메일 입력">
				</div>
				<div class="input_p_Css">
					<p>
						닉네임<em class="join_em_Cl">*</em>
					</p>
					<input type='text' name='nickName' id="nickNameChk"
						class="input_Css" placeholder="닉네임 입력">
				</div>
				<div class="input_p_Css">
					<p>
						비밀번호<em class="join_em_Cl">*</em>
					</p>
					<input type='password' name='password' id="pwdChk"
						class="input_Css" placeholder="비밀번호 입력">
				</div>
				<div class="input_p_Css">
					<input type='password' id="pwd_Re_chk" class="input_Css"
						placeholder="비밀번호 다시 한번 입력">
				</div>
				<div class="input_p_Css">
					<p>
						휴대폰<em class="join_em_Cl">*</em>
					</p>
					<input type='tel' name='mobile' id="mobileChk" class="input_Css"
						placeholder="휴대폰 번호 입력">
				</div>
				<div class="input_p_Css">
					<p>
						우편번호<em class="join_em_Cl">*</em>
					</p>
					<input type='text' name='zipCode' id="zipChk" class="input_Css">
				</div>
				<div class="input_p_Css">
					<p>
						주소<em class="join_em_Cl">*</em>
					</p>
					<input type='text' name='address' id="addressChk" class="input_Css">
				</div>
				<div class="input_p_Css">
					<p>신체정보</p>
				</div>
				<div class="input_p_Css">
					<p>
						성별<em class="join_em_Cl">*</em>
					</p>
					<input type="text" name="gender" id="genderChk" class="input_Css"
						placeholder="M/W">
				</div>
				<div class="input_p_Css">
					<p>
						몸무게<em class="join_em_Cl">*</em>
					</p>
					<input type="text" name="weight" id="weightChk" class="input_Css"
						placeholder="숫자만 입력(소수점까지 기입가능)">
				</div>
				<div class="input_p_Css">
					<p>
						키<em class="join_em_Cl">*</em>
					</p>
					<input type="text" name="height" id="heightChk" class="input_Css"
						placeholder="숫자만 입력(소수점까지 기입가능)">
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