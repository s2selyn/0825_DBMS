-- Quiz --

-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 직급명, 근무국가명을 조회해주세요!

SELECT NATIONAL_NAME FROM NATIONAL;

-- EMPLOYEE		DEPT_CODE	JOB_CODE
-- DEPARTMENT	DEPT_ID					LOCATION_ID
-- JOB						JOB_CODE
-- LOCATION								LOCATION_ID		NATIONAL_CODE
-- NATIONAL												NATIONAL_CODE
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;
SELECT * FROM LOCATION;
SELECT * FROM NATIONAL;

SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_TITLE
     , JOB_NAME
     , NATIONAL_NAME
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN
       JOB USING(JOB_CODE)
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN
       NATIONAL USING(NATIONAL_CODE)
 WHERE
       NATIONAL_NAME = '한국'; -- 부서가 없으면 국가가 없어서 INNER JOIN만으로 가능함
-- 문제를 풀이하는 과정에 중점을 두자
-- 차근차근

--------------------------------------------------

-- 필터에 따라 조회결과가 바뀌어야함
-- 일본을 조회하고싶으면 똑같은 SELECT문에 한국만 일본으로 바뀜
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_TITLE
     , JOB_NAME
     , NATIONAL_NAME
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN
       JOB USING(JOB_CODE)
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN
       NATIONAL USING(NATIONAL_CODE)
 WHERE
       NATIONAL_NAME = '일본';

-- 미국을 조회하고싶으면 또 이걸 바꿔야하겠지(우리는 변수쓸거긴함)
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_TITLE
     , JOB_NAME
     , NATIONAL_NAME
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN
       JOB USING(JOB_CODE)
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN
       NATIONAL USING(NATIONAL_CODE)
 WHERE
       NATIONAL_NAME = '미국';
-- 똑같은거 반복해서 쓰는 상황이 생김(중복되는 SQL문이 생기는)

/*
 * < VIEW 뷰 > --> 논리적인 가상테이블(이론적인 내용)
 * 
 * SELECT문 저장하는 객체(선생님이 설명하는 내용)
 * 
 */

/*
 * VIEW도 오라클에서 객체
 * 1. VIEW 생성
 * 
 * [ 표현법 ]
 * CREATE VIEW 뷰이름
 *     AS 서브쿼리;
 * 
 */

CREATE VIEW VW_EMPLOYEE -- VIEW도 그냥 쓰면 테이블인지 뷰인지 모르니까 접두사 붙임 VW_
    AS SELECT -- 아까 WHERE절 빼고 나머지, 조인한거
       EMP_ID
     , EMP_NAME
     , DEPT_TITLE
     , JOB_NAME
     , NATIONAL_NAME
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN
       JOB USING(JOB_CODE)
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN
       NATIONAL USING(NATIONAL_CODE);

SELECT * FROM VW_EMPLOYEE;
-- 원래 받고싶은 RESULTSET을 SELECT 주루룩 안쓰고 뷰 이름만 써서도 받을 수 있음

-- 한국에서 근무하는 사원
SELECT
       *
  FROM
       VW_EMPLOYEE
 WHERE
       NATIONAL_NAME = '한국';

-- 일본에서 근무하는 사원
SELECT
       *
  FROM
       VW_EMPLOYEE
 WHERE
       NATIONAL_NAME = '일본';

-- 뷰의 장점 : 쿼리문이 엄청 긴게 필요할 때 그때그때 작성하면 힘들다...
--			 딱 한번 뷰로 만들어주면 그때부터는 뷰를 사용해서 간단하게 조회할 수 있음(생산성 향상)

-- 해당 계정이 가지고있는 VIEW에 대한 정보를 조회할 수 있는 데이터 딕셔너리
SELECT * FROM USER_VIEWS; -- 이걸 보면 뷰의 정체를 알 수 있음
-- 뷰가 하나밖에 없어서 하나만 나오는데 뭐가 저장되어 있음? TEXT 컬럼에 아까 뷰 만들때 썼던 서브쿼리문이 들어있음
-- 뷰를 호출하면 자기가 가진 TEXT(SELECT문)를 돌려줌
-- 실제 데이터를 저장하고 있는 것이 아님
-- 뷰는 논리적인 가상테이블 => 실질적으로 데이터를 저장하고 있지 않음
--						(쿼리문을 TEXT 형태로 저장해놓음)

--------------------------------------------------

-- 뷰를 만들었는데 고치고싶은 경우가 있음
-- SALARY 컬럼을 같이 조회하고싶은데? 뷰에 SALARY 안넣고 만들어서 조회안댐
-- 만드는 구문 수정하면 됨? 안됨..
-- 시원하게 DROP으로 날리고 다시 만들어? 그럼 얼마나 귀찮아
-- 뷰는 좋은게 있음 CREATE VIEW 사이에 OR REPLACE를 넣을 수 있음
-- 이러면 뷰 객체가 없으면 새로 만들어주고, 이미 중복 이름이 있으면 갱신시켜버림

/*
 * CREATE OR REPLACE VIEW 뷰이름
 *     AS 서브쿼리;
 * 
 * 뷰 생성 시 기존에 중복된 이름의 뷰가 존재한다면 갱신(변경)해주고
 * 없다면 새로운 뷰를 생성해줌
 * 
 */

-- 선생님 개인적인 생각에 이게 편하고 좋다.. 좀더 효율적으로 사용하는 방법이 뭐가 있을까? 이런 생각할수있음
-- 고민하다보면 결론이 어디에 도달함?
-- 사원의 사원명, 연봉, 근무년수를 조회할 수 있는 SELECT문 정의
SELECT
       EMP_NAME
     , SALARY * 12 -- 연봉을 조회하려면 컬럼에 연산을 해야함
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) -- 근무년수를 뽑으려면? 입사일 뽑아서 현재연도 추출해서 두개 뺀 결과를.. 함수 호출도 해야하고 빼기 연산도 해야함
  FROM
       EMPLOYEE;
-- 아 맨날 이거 써야함? 실수로 순서 잘못쓸수도 있고.. 이거 뷰로 만들어놔야겠다
-- 알차게 뷰 만드는법 배워써!
CREATE OR REPLACE VIEW VW_EMP
    AS (SELECT
		       EMP_NAME
		     , SALARY * 12
		     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
		  FROM
		       EMPLOYEE);
-- 헤헹 안되지롱 ㅠㅠ
-- 조회할 때 얘네가 컬럼명이 되는데, 키워드라서 조회할 때 컬럼명으로 들어갈 수 없음
-- 이런 상황에서 뷰를 만들고싶다면 반드시 별칭을 지어줘야함, 컬럼명으로 뷰를 만들 수 없으므로
/*
 * 뷰 생성 시 SELECT절에 함수 또는 산술연산식이 기술되어있는 경우 뷰 생성이 불가능하기때문에
 * 반드시 별칭을 지정해주어야 함
 * 
 */
CREATE OR REPLACE VIEW VW_EMP
    AS (SELECT
		       EMP_NAME
		     , SALARY * 12 AS "연봉"
		     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "근무년수"
		  FROM
		       EMPLOYEE);
-- 시원하게 잘 만들어짐^^ 아 시원하다
SELECT * FROM VW_EMP;

-- 컬럼에 별칭을 지어줄때 이 방법 말고 다른 방법을 쓸 수 있음
-- 별칭 부여 방법 두 번째!(모든 컬럼에다가 별칭을 지어주어야함, 안그러면 안돌아감)
-- VIEW 식별자 뒤에 소괄호를 추가해서 작성
CREATE OR REPLACE VIEW VW_EMP(사원명, 연봉, 근무년수)
    AS (SELECT
		       EMP_NAME
		     , SALARY * 12
		     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
		  FROM
		       EMPLOYEE);
SELECT * FROM VW_EMP;

-- 뷰 삭제하기
DROP VIEW 뷰이름;

--------------------------------------------------

