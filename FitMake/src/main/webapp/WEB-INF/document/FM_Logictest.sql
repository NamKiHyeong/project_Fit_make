-- 회원가입
INSERT INTO FM_USER
VALUE(FM_USER_NO, FM_USER_NICKNAME, FM_USER_EMAIL, FM_USER_PASSWORD, FM_USER_MOBILE
    , FM_USER_ZIP_CODE, FM_USER_ADDRESS, FM_USER_CRE_DATE, FM_USER_POINT)
VALUES(5, 'psu0007', 'psu0007@naver.com', '1234', '010-1111-2222', 21938, '인천시 어딘가', SYSDATE, 50000);

-- 로그인
SELECT FM_USER_NO, FM_USER_NICKNAME, FM_USER_POINT
FROM FM_USER
WHERE FM_USER_EMAIL = 'nkhink@naver.com'
AND FM_USER_PASSWORD = 1234;

-- BMI 연산식 
-- 몸무게 / 키의제곱 = 몸무게 / (키*키) => 소수점이 길다
-- 라운드 함수로 2째자리에서 반올림

SELECT b.fm_user_nickname, round(a.fm_user_weight / (a.fm_user_height * a.fm_user_height) * 10000, 2)
FROM fm_user_bmi a, fm_user b
where a.fm_user_no = b.fm_user_no;

-- BMI 등급
select b.bmi_grade
from fm_user_bmi a, bmi_standard b
where round(a.fm_user_weight / (a.fm_user_height * a.fm_user_height) * 10000, 2) >= b.bmi_min
and round(a.fm_user_weight / (a.fm_user_height * a.fm_user_height) * 10000, 2) < b.bmi_max;

-- 목표 BMI 산출
-- 내 BMI - 1 이 목표 BMI입니다
select round(a.fm_user_bmi - 1, 1) as "목표BMI", 
    case when round(a.fm_user_bmi - 1, 1) <= 2  then 2 else round(a.fm_user_bmi - 1, 1) end as "목표BMI등급"
from fm_user_bmi a, bmi_standard b
where round(a.fm_user_weight / (a.fm_user_height * a.fm_user_height) * 10000, 2) >= b.bmi_min
and round(a.fm_user_weight / (a.fm_user_height * a.fm_user_height) * 10000, 2) < b.bmi_max;

-- 목표 표준체중
-- (키*키*목표BMI)/ 10000 => 소수점이 길어 2째자리에서 반올림
-- /10000을 하는 이유 -> 키 기준이 m인데 입력을 cm로 받기 때문에 자리를 맞춰야한다
select round((a.fm_user_height * a.fm_user_height * 20.9) / 10000, 2)
from fm_user_bmi a;

-- 권장 섭취 칼로리(한끼)
-- 한끼 식사 칼로리에서 밥 한공기 칼로리(300kcal) 제외 후 반찬 2개 기준으로 나눈 값을 표기
-- 일일 권장 칼로리, 한끼 권장 칼로리
select (64.01 * 30),round(((64.01 * 30)) / 3), (round(((64.01 * 30)) / 3)-300)/2
from dual;







