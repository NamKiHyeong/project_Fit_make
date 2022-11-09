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
SELECT b.fm_user_nickname, round(a.fm_user_bmi_weight / (a.fm_user_bmi_height * a.fm_user_bmi_height) * 10000, 2)
FROM fm_user_bmi a, fm_user b
where a.fm_user_no = b.fm_user_no;

-- BMI 등급
select c.fm_user_nickname, b.fm_bmi_grade
from fm_user_bmi a, fm_user c, fm_bmi_standard b 
where c.fm_user_no = a.fm_user_no
and round(a.fm_user_bmi_weight / (a.fm_user_bmi_height * a.fm_user_bmi_height) * 10000, 2) >= b.fm_bmi_min
and round(a.fm_user_bmi_weight / (a.fm_user_bmi_height * a.fm_user_bmi_height) * 10000, 2) < b.fm_bmi_max;

-- 목표 BMI 산출

select round(a.fm_user_bmi - 1, 1) as "목표BMI", 
    case when round(a.fm_user_bmi - 1, 1) <= 2  then 2 else round(a.fm_user_bmi - 1, 1) end as "목표BMI등급"
from fm_user_bmi a, bmi_standard b
where round(a.fm_user_weight / (a.fm_user_height * a.fm_user_height) * 10000, 2) >= b.bmi_min
and round(a.fm_user_weight / (a.fm_user_height * a.fm_user_height) * 10000, 2) < b.bmi_max;

-- 목표 표준체중

select round((a.fm_user_height * a.fm_user_height * 20.9) / 10000, 2)
from fm_user_bmi a;

-- 권장 섭취 칼로리(한끼)
-- 한끼 식사 칼로리에서 밥 한공기 칼로리 제외 후 반찬 2개 기준으로 나눈 값을 표기
-- 일일 권장 칼로리, 한끼 권장 칼로리
select (64.01 * 30),round(((64.01 * 30)) / 3), (round(((64.01 * 30)) / 3)-300)/2
from dual;

-- 메인 추천리스트 등록
Insert into fm_recommand
value(FM_ITEM_NO, FM_USER_BMI_NO)
values((
    select fm_item_no 
    from fm_item i
    where i.fm_calory_grade*100 > (select bmi.fm_user_goal_calory
                                    from fm_user_bmi bmi
                                    where bmi.fm_user_no = 3)
    and (i.fm_calory_grade-1)*100 < (select bmi.fm_user_goal_calory
                                    from fm_user_bmi bmi
                                    where bmi.fm_user_no = 3)
    ), 3);

Insert into fm_recommand
value(FM_ITEM_NO, FM_USER_BMI_NO)
values((
    select fm_item_no 
    from fm_item i
    where i.fm_calory_grade*100 >= (select bmi.fm_user_goal_calory
                                    from fm_user_bmi bmi
                                    where bmi.fm_user_no = 1)
    and (i.fm_calory_grade-1)*100 < (select bmi.fm_user_goal_calory
                                    from fm_user_bmi bmi
                                    where bmi.fm_user_no = 1)
    ), 1);

Insert into fm_recommand
value(FM_ITEM_NO, FM_USER_BMI_NO)
values((
    select fm_item_no 
    from fm_item i
    where i.fm_calory_grade*100 >= (select bmi.fm_user_goal_calory
                                    from fm_user_bmi bmi
                                    where bmi.fm_user_no = 2)
    and (i.fm_calory_grade-1)*100 < (select bmi.fm_user_goal_calory
                                    from fm_user_bmi bmi
                                    where bmi.fm_user_no = 2)
    ), 2);

--확인
select *
from fm_recommand;

--추천제품을 조회하는 방법
select b.fm_item_no, b.fm_item_name
from fm_recommand a inner join fm_item b
        on b.fm_item_no = a.fm_item_no
    inner join fm_user_bmi c
        on c.fm_user_bmi_no = a.fm_user_bmi_no
where c.fm_user_no = 2;

-- 장바구니
INSERT INTO FM_CART
VALUE(FM_CART_NO, FM_CART_COUNT, FM_CART_ITEM, FM_CART_PRICE, FM_USER_NO, FM_ITEM_NO)
VALUES(1, 2, (select fm_item_name from fm_item where fm_item.fm_item_no = 3)
    , (select fm_item_sellprice from fm_item where fm_item.fm_item_no = 3) * 2, 1, 3);

--확인
select *
from fm_cart;

-- 주문
insert into fm_order_detail
value(FM_ORDER_DETAIL_NO, FM_ORDER_NO, FM_ITEM_NO, FM_CART_NO)
values(1, )


