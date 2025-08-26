-- EMPLOYEE 테이블에 존재하는 전체 사원의 총 급여의 합 조회

SELECT
       SUM(SALARY) -- 그룹 함수 SUM 이용
  FROM
       EMPLOYEE; --> EMPLOYEE 테이블에 존재하는 모든 사원들을 하나의 그룹으로묶어서
                 --  합계를 구한 결과

-- 모든 사원을 조회하고 싶은게 아니라면?
-- EMPLOYEE 테이블에서 각 부서별로 급여의 합계를 조회
SELECT * FROM EMPLOYEE;
-- 사원의 정보들이 들어가있음, 사원의 부서가 나뉘어져있음, 총무부 행정부 인사부 등 부서별로 합계를 알고싶음
-- 이 테이블에서 부서 정보를 알고싶다면 뭘 보면 알수있나요? DEPT_CODE 항목을 보면 알 수 있음, 이 코드가 같으면 같은 부서에 있는 사람
-- D9, D8, D7, D6, D5 부서별로 따로
-- 부서번호가 D9인 친구만 묶고싶다면?
SELECT
       SUM(SALARY)
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D9';

-- 부서 마다 알고싶은건데?
SELECT
       SUM(SALARY)
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D8';
-- 부서코드가 같은애들끼리 묶어서 그룹으로 확인..이러면 귀찮다, 하면 하는데?
-- 그룹으로 묶을 수 있는 문법이 있음
/*
 * < GROUP BY 절 >
 * 
 * 그룹을 묶어줄 기준을 제시할 수 있는 구문
 * 
 * 여러 개의 컬럼값을 특정 그룹으로 묶어서 처리할 목적으로 사용
 * 
 */
SELECT
       SUM(SALARY)
     , DEPT_CODE
-- 14:16 이거 왜 같이 조회함?
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE; -- 묶고싶은 기준, 같은 것들끼리 묶임
-- 14:15 그룹함수는 그룹별로 결과를 리턴함, GROUP BY에 의해서 묶인 그룹별로?

-- 전체 사원 수 알아내려면 어떻게 함?
SELECT
       COUNT(*)
  FROM
       EMPLOYEE;
-- 이렇게 하면 EMPLOYEE 테이블에 있는 모든 행을 싹다

-- 기준을 하나 집어서 기준별 사원수를 세보자
-- 부서별(DEPT_CODE 컬럼값) 사원 수
SELECT
       COUNT(*)
     , DEPT_CODE
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE;
-- 각 부서마다 몇명씩 있는지 셀 수 있음

-- 각 사원의 성(이름)별 사원의 수
-- 이름 앞글자가 똑같은 사람이 몇명씩 있는지
SELECT
       COUNT(*)
     , SUBSTR(EMP_NAME, 1, 1)
  FROM
       EMPLOYEE
 GROUP
    BY
       SUBSTR(EMP_NAME, 1, 1); -- 이름 앞글자만 빼오려면? 일단 EMP_NAME을 가져와야함, 여기서 한글자만 빼오고싶으니까 SUBSTR, 첫번째것을 한개만

-- 기준점을 정해서 그것들끼리 묶어주는 문법

-- 각 부서별 급여 합계를 오름차순(부서코드)으로 정렬해서 조회
SELECT
       SUM(SALARY) -- 1행
     , DEPT_CODE -- 어떤 부서인지 알아야하니까, 23행, 얘네 둘만으로는 실행할 수 없음
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE -- 이렇게 묶어주고
 ORDER
    BY
       DEPT_CODE; -- 정렬

-- 14:28 실행순서가 중요함! 합리적으로
-- 1. FROM, 상식적으로 테이블에 먼저 가야함, 그래야 컬럼이 있나없나 알지
-- ORDER BY는 2번이 될 수 없음
-- SELECT 얘부터 한다고 치면? 23행을 더하고 어떻게 쪼갬? 그룹으로 나누고 나눈걸로 합계를 구함
-- 합계가 구해져야 구해진걸 가지고 정렬을 할 수 있음
-- 3 1 2 4
-- 테이블 항상 1등, 정렬은 마지막, 이거 두개는 절대 안변함
-- 중간에 뭐가 왔다갔다,, 합계를 구할건데 그룹을 나눠야 그룹별 합계를 구할 수 있음
-- FROM - GROUP BY - SELECT - ORDER BY

-- 실행순서정도만 기억

--------------------------------------------------

SELECT
       EMP_NAME
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE;
-- 이렇게 그룹을 나눈걸로는 EMP_NAME을 알 수 없음, 이 컬럼은 존재하지 않게 됨
-- GROUP BY가 먼저 이루어진다는것을 생각하면 이건 당연함
-- 나눈 기준을 부서 코드로 나눴기 때문에 쓸 수 없음
-- 주의할 점 : GROUP BY절 사용 시 GROUP으로 나누지 않은 컬럼은 SELECT 할 수 없음
-- GROUP BY는 이거만 조심하면됨

-- 부서코드, 각 부서별 평균 급여
-- 14:33 부서 코드가 같은 애들끼리 묶었기 때문에 SELECT절에서 조회 가능
-- 부서들 중에서 평균급여가 300만 이상인 부서만 조회
-- 조건을 달아야함, 조건을 달아야하는데 원래 위치가? FROM 다음인데, GROUP BY랑 FROM 사이에 들어감
SELECT
       DEPT_CODE
     , AVG(SALARY)
  FROM
       EMPLOYEE
 WHERE
       -- AVG(SALARY) >= 3000000 우리가 배운대로 생각하면 이렇게 가야할 것 같지만 이렇게 하면 안됨 될수가없음
       -- GROUP BY를 쓴다고 WHERE절을 못쓰는건 아님
       DEPT_CODE IS NOT NULL -- 부서코드가 NULL이 아닌 친구들, 이렇게 쓰면 잘 됨
       -- 이게 잘되는걸 확인했을 때 합리적으로 생각해보면? 어떤 순서로 돌아야 합리적인가? 자원소모를 덜할까? 연산을 덜할까? 효율적으로 동작할까?
-- 14:37 처음부터 널인애들은 다 빼고 그룹을 하는거랑 어느게 더 괜찮음?
       -- FROM 다음에는 WHERE, 그다음에는 GROUP BY
       -- WHERE에서 GROUP함수를 써버리면 GROUP BY보다 WHERE가 먼저 동작하기 때문에 얘가 23행에 대한 연산처리가 됨
       -- 23행을 하나로 합친 다음에는 그룹함수를 쓸 수 없음
       -- GROUP BY가 실과 바늘 세트가 있음 --> HAVING 절 하러 ㄱㄱ
 GROUP
    BY
       DEPT_CODE;

/*
 * < HAVING 절 >
 * 
 * 그룹에 대한 조건을 제시할 때 사용하는 구문
 * (그룹함수를 아주 쏠쏠히 사용할 수 있음) <- 아까 다섯개 외우자고 했던거
 * 
 */
SELECT
       DEPT_CODE
     , AVG(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE
HAVING
       AVG(SALARY) >= 3000000;
-- HAVING이 동작하기 위해서는? 당연히 GROUP BY 다음에 동작해야함
-- SELECT 문은 실행순서를 기억할것! 문법은 쓰다보면 알아서 손에 익는거고
-- 안그러면 SQL문 이상하게 돌아감
/*
 * < 실행 순서 >
 * 5 : SELECT 조회하고자하는 컬럼명 / 함수식 / 산술연산식 / 리터럴값 / * AS "별칭"
 * 1 :   FROM 조회하고자하는 테이블명
 * 2 :  WHERE 조건식(산술연산, 컬럼비교연산, 함수식 등)
 * 3 :  GROUP BY 그룹 기준에 해당하는 컬럼명 / 함수식
 * 4 : HAVING 그룹함수로 만들어줄 조건식
 * 6 :  ORDER BY 정렬기준으로 사용할 컬럼명 / 함수식 / 별칭 / 컬럼 순번
 * 
 * 누가 제일 먼저 돌아야 합리적인가?
 * 일단 테이블에 가야함, 그래야 이안에 컬럼도 보고 뭐시기도 하겠지
 * 항상 1등은 FROM, 영원히 변치않는 1등
 * 다음, 테이블 가면 항상 행 기준, 행 안에 컬럼으로 구분
 * 내가 조회해서 가져가는것도 행 기준, 모든행을 다 조회해서 가면 시간이 많이 걸릴것 --> SELECT는 추후로 미루기
 * WHERE 아니면 GROUP BY인데, 그룹으로 묶은 다음에 쳐내느냐, 쳐낸 다음에 묶느냐
 * 그룹으로 묶고나면 조건을 쓸 수 없는 경우가 생길 수 있음
 * 조건식으로 먼저 행을 거름, 아닌 행을 먼저 걸러냄
 * 거르고 남은 친구들을 그룹으로 묶음
 * 그 다음에는 그룹 함수로 조건식을 사용할 수 있음, 그건 HAVING 절에서
 * HAVING에서 또 걸러짐! 거르고 걸러서 진짜 조회할 친구들만 남음
 * 그럼 SELECT로 조회를함
 * 쭉 나왔으니까 마지막에 정렬할 수 있음
 * 
 */
-- 이거 생각 안하면 내가 의도한 결과를 반환받지 못하거나 아예 동작하지 않을 수 있음
-- 순서를 항상 기억해야함

-- EMPLOYEE테이블로부터 각 직급별(JOB_CODE)별 총 급여합이 1000만원 이상인 직급의
-- 직급코드, 급여합을 조회 / 단, 직급코드가 J6인 그룹은 제외
-- 15:10 작성과정, 조건 생각
SELECT
       SUM(SALARY)
     , JOB_CODE
  FROM
       EMPLOYEE
 WHERE -- 컬럼 값에 대한 조건이므로
       JOB_CODE != 'J6'
 GROUP
    BY
       JOB_CODE
HAVING
       SUM(SALARY) >= 10000000;

SELECT DEPT_CODE, BONUS FROM EMPLOYEE;
-- 부서 코드랑 보너스 컬럼을 조회할건데, 보너스를 받지 않는 사원이 많음
-- 보너스를 받는 사원이 없는 부서코드만 조회
-- 15:14 여기도 생각과정
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE
HAVING
       COUNT(BONUS) = 0;
