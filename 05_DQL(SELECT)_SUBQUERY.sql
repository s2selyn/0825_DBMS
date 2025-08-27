/*
 * < SUB QUERY 서브쿼리 >
 * 보조역할
 * 
 * 하나의 메인 SQL(SELECT, INSERT, UPDATE, DELETE, CREATE, ...)안에 포함된
 * 또 하나의 SELECT문
 * 
 * MAIN SQL문의 보조역할을 하는 쿼리문
 * 
 */

-- 간단 서브쿼리 예시
SELECT * FROM EMPLOYEE;
-- 박세혁 사원과 부서가 같은 사원들의 사원명 조회

-- 뭘 알아야 사원명 조회할 수 있음? 일단 박세혁 사원의 부서 코드를 알아야함
-- 한 2300개 있다고 가정하면?
-- 1) 먼저 박세혁 사원의 부서코드 조회
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       '박세혁' = EMP_NAME; -- D5

-- 부서코드가 D5인 사원들의 사원명을 조회할 수 있게됨
-- 2) 부서코드가 D5인 사원들의 사원명 조회
SELECT
       EMP_NAME
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'; -- 6행

-- 박세혁 사원의 부서가 바뀔때마다 쿼리문을 바꿔줘야함

-- 1) + 2)
-- 위 두 단계를 하나의 쿼리문으로 합치기
-- 최종적으로 하고싶은건 사원명 조회
SELECT
       EMP_NAME
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = (SELECT
					       DEPT_CODE
					  FROM
					       EMPLOYEE
					 WHERE
					       '박세혁' = EMP_NAME);
-- D5라는 값을 어떻게 가져옴? 1)의 쿼리문으로 알아낸 것( 1)쿼리문 수행 결과가 D5였던것 )
-- D5를 괄호로 묶고나서 D5를 1)의 쿼리문 통째로 바꿔줌
-- 이러면 박세혁 사원의 부서가 바뀌어도 이 쿼리문은 항상 박세혁 사원의 부서와 같은 사람들을 조회하게 됨
-- 실질적으로 수행하고 싶은 것은? 앞의 것이지, 이걸 동작시키고 싶어서 하나 더 썼음(D5를 얻기 위한 QUERY <- 이걸 서브쿼리라고 함)
-- 생각해야할것은 처음부터 서브쿼리를 이렇게 쓰는 게 아니고, 따로따로 써서 결과 확인하고 그다음에 합침

-- 오라클을 기준으로 놓고 보면, 오라클의 과금 정책이 DB서버에다가 SELECT 100번하면 100만원, 1000번하면 2천만원... 이런식(보통은 접근해서 작업한 횟수가 기준)
-- 서브 쿼리를 쓴 것은 접근을 한번해서 수행하고 돌아옴
-- DB에 최대한 적게 가서 데이터를 뽑아오는것이 능력과 실력의 기준이 되기도 함

--------------------------------------------------
SELECT
       EMP_NAME
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = (SELECT
					       DEPT_CODE
					  FROM
					       EMPLOYEE
					 WHERE
					       EMP_ID = (SELECT
					       					EMP_ID
									   FROM
											EMPLOYEE 
									  WHERE
											EMP_NAME = '박세혁'
										AND
											DEPT_CODE = 'D5'));

-- 이런걸 볼때 제일 안에있는거, 제일먼저 수행되어야 하는걸 먼저 봐야함
-- 작성할때는 최종먼저, 볼때는 제일 안에있는거 먼저

--------------------------------------------------

-- 간단한 서브쿼리 예시 두 번째
-- 전체 사원의 평균 급여보다 더 많은 급여를 받고 있는 사원들의 사번, 사원명을 조회
-- 1) 전체 사원의 평균 급여 구하기
SELECT
       AVG(SALARY)
  FROM
       EMPLOYEE; -- 대략 3131140원

-- 2) 급여가 3131140원 이상인 사원들의 사번, 사원명
SELECT
       EMP_ID
     , EMP_NAME
  FROM
       EMPLOYEE
 WHERE
       SALARY >= 3131140;

-- 위의 두 단계를 하나로 합치기
-- 메인 쿼리는 2)이고, 여기에 넣은 리터럴 값을 얻기 위해서 1)을 작성했으므로 1)을 서브 쿼리로 넣어서 실행
SELECT
       EMP_ID
     , EMP_NAME
  FROM
       EMPLOYEE
 WHERE
       SALARY >= (SELECT
       					 AVG(SALARY)
				    FROM
				         EMPLOYEE);

-- 접근을 한번으로 줄이고, 3131140 값은 사원이 들고나거나 SALARY 값이 바뀌면 값이 변하게 될텐데 이걸 수동으로 바꾸지 않아도 됨
-- 서브쿼리가 중요하고 좋긴 하지만 JOIN이 좀 더 중요함, 둘다 좋고 중요하지만 JOIN이 더 우선순위가 높음

----------------------------------------

/*
 * 서브쿼리의 분류
 * 
 * 서브쿼리를 수행한 결과가 몇 행 몇 열이냐에 따라서 분류됨
 * 
 * - 단일행 [단일열] 서브쿼리 : 서브쿼리 수행 결과가 딱 1개일 경우 --> 결과값이 하나인것, 그룹함수 떠올리면 됨, 셀 하나에 값 하나 나오는거
 * - 다중행 [단일열] 서브쿼리 : 서브쿼리 수행 결과가 여러 행일 때 --> 행은 여러개인데 컬럼은 하나만 나옴
 * - [단일행] 다중열 서브쿼리 : 서브쿼리 수행 결과가 여러 열일 때 --> 행이 하나고 컬럼만 많음
 * - 다중행 다중열 서브쿼리   : 서브쿼리 수행 결과가 여러 행, 여러 열 일때
 * 
 * => 수행 결과가 몇 행 몇 열이냐에 따라서 사용할 수 있는 연산자가 다름(구분하는 이유)
 * 
 * 테이블이 2차원 배열 형태이므로 2 X 2 해서 모든 결과가 나온것
 * 
 */

/*
 * 1. 단일 행 서브쿼리(SINGLE ROW SUBQUERY)
 * 
 * 서브쿼리의 조회 결과값이 오로지 1개 일 때
 * 
 * 일반 연산자 사용(=, !=, >, < ...)
 * 
 */
-- 전 직원의 평균 급여보다 적게 받는 사원들의 사원명, 전화번호 조회

-- 1. 평균 급여 구하기
-- 보조하는 역할로 작성했음, 결과가 셀 하나로 나옴, 딱 하나
SELECT
       AVG(SALARY)
  FROM
       EMPLOYEE; --> 결과값 : 오로지 1개의 값
-- 이런 친구들을 단일 행 서브쿼리라고 함

-- 2. 메인쿼리에 조건으로 서브쿼리 넣기
SELECT
       EMP_NAME
     , PHONE
  FROM
       EMPLOYEE
 WHERE
       SALARY < (SELECT
				        AVG(SALARY)
				   FROM
				        EMPLOYEE);

-- 최저급여를 받는 사원의 사번, 사원명, 직급코드, 급여, 입사일 조회

-- 1. 최저급여 구하기
-- 단일행함수보다 그룹함수를 더많이쓰고있음, 그룹함수 5개밖에없었지
SELECT
       MIN(SALARY)
  FROM
       EMPLOYEE;
-- 그룹함수니까 결과가 하나나옴, 똑같은거 여러개여도 결과값은 똑같이 하나만 나옴

-- 실제 원했던 메인 쿼리문
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , SALARY
     , HIRE_DATE
  FROM
       EMPLOYEE
 WHERE
       SALARY = (SELECT
				        MIN(SALARY)
				   FROM
				        EMPLOYEE);

-- 안준영 사원의 급여보다 더 많은 급여를 받는 사원들의 사원명, 급여 조회

-- 일단 안준영 사원이 얼마를 받는지 알아야함
SELECT
       SALARY
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '안준영';

SELECT
       EMP_NAME
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > (SELECT
				        SALARY
				   FROM
				        EMPLOYEE
				  WHERE
				        EMP_NAME = '안준영');

-- 단일행 서브쿼리는 서브쿼리랑 메인쿼리 비교할때 연산자 쓰던거 마음대로 쓸 수 있음

-- JOIN도 써먹어야죵
-- 박수현 사원과 같은 부서인 사원들의 사원명, 전화번호, 직급명을 조회하는데 박수현 사원은 제외
-- SQL(Structured Query Language) 구조적 질의 언어
-- 데이터베이스에 질의를 보내는데, 구조적으로 잘 만들어서 보내야 올바른 답변을 받을 수 있음

-- 1절 : 박수현 사원의 부서
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '박수현'; -- D5

-- EMPLOYEE 테이블에서 DEPT_CODE가 D5면 같은 부서
SELECT * FROM EMPLOYEE;

-- 2절 : D5로 먼저 해보기
SELECT
       EMP_NAME
     , PHONE
     , JOB_NAME
  FROM
       EMPLOYEE
     , JOB
 WHERE
       EMPLOYEE.JOB_CODE = JOB.JOB_CODE
   AND
       DEPT_CODE = 'D5';

-- D5를 구하려고 했던 일을 리터럴값과 교체
SELECT
       EMP_NAME
     , PHONE
     , JOB_NAME
  FROM
       EMPLOYEE
     , JOB
 WHERE
       EMPLOYEE.JOB_CODE = JOB.JOB_CODE
   AND
       DEPT_CODE = (SELECT
					       DEPT_CODE
					  FROM
					       EMPLOYEE
					 WHERE
					       EMP_NAME = '박수현');

-- 박수현 사원은 제외 --> 조건 뒤에 추가
SELECT
       EMP_NAME
     , PHONE
     , JOB_NAME
  FROM
       EMPLOYEE
     , JOB
 WHERE
       EMPLOYEE.JOB_CODE = JOB.JOB_CODE
   AND
       DEPT_CODE = (SELECT
					       DEPT_CODE
					  FROM
					       EMPLOYEE
					 WHERE
					       EMP_NAME = '박수현')
   AND
       EMP_NAME != '박수현';

-- 오라클 해봤으니 ANSI로 바꿔봐야지
SELECT
       EMP_NAME
     , PHONE
     , JOB_NAME
  FROM
       EMPLOYEE
  JOIN
       JOB USING(JOB_CODE)
 WHERE
       DEPT_CODE = (SELECT
       					   DEPT_CODE
       				  FROM
       				       EMPLOYEE
       				 WHERE
       				       EMP_NAME = '박수현')
   AND
       EMP_NAME != '박수현';

--------------------------------------------------

-- 부서별 급여 합계가 가장 큰 부서의 부서명, 부서코드, 급여합계 조회
-- 메인쿼리는 부서명, 부서코드, 급여합계
-- 이걸 하려면 뭘 알아야함? 급여합계, 이것중에 제일 많이 받는 급여합계
-- 이걸 알려면 또 모든 부서의 급여합계를 알아야함

-- 1_1. 각 부서별 급여 합계
SELECT
       SUM(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE;

-- 1_2. 부서별 급여합계 중 가장 큰 급여합
SELECT
       MAX(SUM(SALARY))
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE;

-- 부서명은 DEPARTMENT, 급여합계는 EMPLOYEE 테이블을 봐야하므로 JOIN해야함
SELECT
       SUM(SALARY)
     , DEPT_CODE
     , DEPT_TITLE -- GROUP BY에서 안나눴으니까 조회가 안됨, 근데 JOIN했으니까 DEPT_CODE랑 DEPT_TITLE이랑 매칭됨
-- ???? GROUP BY 할때 코드가 같으면 타이틀이 같을것이므로, 하나의 코드에는 하나의 타이틀만 붙을 것이므로 GROUP BY에 DEPT_TITLE도 작성가능
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_ID = DEPT_CODE)
--  WHERE
--        SUM(SALARY) = 18000000
 GROUP
    BY
       DEPT_CODE,
       DEPT_TITLE -- GROUP BY를 쓰는데 SELECT절에서 조회할 수 있는 컬럼은? GROUP BY로 나눈 것만 조회할 수 있음!
-- 그룹함수를 조건으로 쓰고싶으면? WHERE절이 아니라 HAVING에 가야함
 HAVING
        SUM(SALARY) = 18000000;

-- 내가 원하는 결과를 얻었으니 합치기
-- 합치기
SELECT
       SUM(SALARY)
     , DEPT_CODE
     , DEPT_TITLE
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_ID = DEPT_CODE)
 GROUP
    BY
       DEPT_CODE,
       DEPT_TITLE
 HAVING
        SUM(SALARY) = (SELECT
					          MAX(SUM(SALARY))
					     FROM
					          EMPLOYEE
					    GROUP
					       BY
					          DEPT_CODE);

--------------------------------------------------

-- 자! 우리가 지금 하고 있는 작업이 어떤걸 하고 있는 건가요?
-- SELECT문을 하고 있는데, 이걸 왜하고있음? 목적이 뭔가요?
-- DB에다가 주고받고? 이게 무슨 의미임?
-- 넓은 의미로 봐야함, 컴퓨터로 뭘 하고 있는거지
-- DB에다가 주고받고 --> 콤퓨타 작업
-- 이걸 하고 있는데 왜이걸지금데이터베이스를 자바다음에하고있느냐
-- 자바를가지고 어디까지왔음? 사용자한테 무언가를 출력해준 상태에서, 사용자에게 값을 입력받아서 처리하고, 처리결과를 다시 출력해주는것까지
-- 이걸 하다보니 생긴 문제, 입력받는것까지 좋음, 입력받은걸 객체 필드에 담았음, 여기까지 좋아, 출력까지 잘 됨, 근데 문제가 뭐야?
-- 잘했습니다 하고 꺼버림, 다시 켜면? 열심히 올려둔 필드에 담아둔게 다 날아가버림
-- 왜날아가는건데! 램이 원래 날아가는데임~ 프로세스가 꺼지면 다 날아가지롱
-- 그럼 어떡해? 램에 올리면 안되겠네? 램에 올려둔건 주소값 가리키고 있지 않으면 객체 없어지는것처럼 얘도 사라짐
-- 데이터를 프로그램 밖에 출력해두고 끝나면 다시 입력받으면 되는데? 파일로 출력하긴 귀찮음 읽어올때도 힘들어
-- 그럼 개발자들은 어디에 저장(출력)해두나요? DB에.
-- DB에서 다시 입력받고
-- 그럼 DB에 저장하고 입력하는 방법을 배워야겠당, 자바로만 해결이 안되니까 다른걸 써야 해결된다니까 배워야지 하고 여기로 넘어옴
-- 지금 만드는것들은 자바에서 쓸것을 여기에서어떻게할지??
-- DB에서 가져와서 내 프로그램으로 입력받아야함
-- DB서버 구축하고 우리가 이용하기위해서 서버에 접속해서 서버에 있는 서비스를 이용하고 있음
-- SELECT 한번 할때마다 DB서버에 요청을 보내고 있는것임
-- 우리가 작업하는 컴퓨터는 클라이언트, 이 프로그램은 클라이언트 프로그램
-- 접속하려면 IP주소와 포트번호가 필요함, 이거 한번 적어놓고 계속 이거 이용해서 요청 보내는 작업 하고있음
-- 자바 프로젝트 14번에서 했던거 떠올리기
-- 우리하고있는거 요청보내서 응답받기

-- 저장하는 법은 아직 안배웠고, 저장해놨다 치고 이걸 어떻게 읽어오는지 배우고있음
-- INSERT UPDATE VIEW SEQUENCE 등등
-- 그러고 나서 자바에서 DB서버 접속해서 데이터 넣고빼기, 자바랑 DB 같이쓰는법

--------------------------------------------------

/*
 * 2. 다중 행 서브쿼리
 * 서브쿼리의 조회 결과값이 여러 행일때
 * 
 * - IN(10, 20, 30) : 여러 개의 결과값 중 한 개라도 일치하는 값이 있다면
 * 
 */
-- 각 부서별 최고급여를 받는 사원의 이름, 급여 조회
-- 각 부서별로 최고급여가 얼만지 알아야함
SELECT
       MAX(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE; -- 830, 390, 366, 255, 289, 376, 750

SELECT * FROM EMPLOYEE;

-- 부서별 최고급여를 조건으로 써야겠다
SELECT
       EMP_NAME
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       -- SALARY = 8300000 OR SALARY = 3900000 OR
       SALARY IN (SELECT
				         MAX(SALARY)
				    FROM
				         EMPLOYEE
				   GROUP
				      BY
				         DEPT_CODE); -- = 써서는 안됩니다
-- 내가 비교할건 하나인데 7행 나온거랑 비교할 수 없음
-- 서브쿼리를 실행했더니 결과가 여러개의 행으로 나왔음, 컬럼은 하나만 있음
-- 그래서 비교연산자로는 1대 7의 비교라서 말도안됨
-- 말도안되는거 해야함 OR로 연결연결연결... 이건 하기 싫음
-- 연산자를 = 대신 IN을 쓰면 됨!

-- 이승철 사원 또는 선승제 사원과 같은 부서인 사원들의 사원명, 핸드폰번호 조회
-- 두 사원의 부서가 뭔지 알아야함, DEPT_CODE에 들어있음
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '이승철'
    OR
       EMP_NAME = '선승제'; -- 이래도 되지만

-- 이게 맞지?
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME IN ('이승철', '선승제');
-- 컬럼은 하나인데 조회 결과가 두개의 행으로 왔음

-- 궁극적으로 조회하고싶은것은?
SELECT
       EMP_NAME
     , PHONE
  FROM
       EMPLOYEE; -- 차근차근 확인하기~

-- 근데 부서코드가 D9, D8인 친구들 보고싶었던건데?
SELECT
       EMP_NAME
     , PHONE
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE IN ('D9', 'D8');

-- 이제 서브쿼리로 바꿔넣기
SELECT
       EMP_NAME
     , PHONE
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE IN (SELECT
					        DEPT_CODE
					   FROM
					        EMPLOYEE
					  WHERE
					        EMP_NAME IN ('이승철', '선승제'));

-- IN 말고 쓸 수 있는데 활용도는 낮은 친구 알아만두기
SELECT * FROM JOB; -- 여기 직급이 있음

-- 인턴(수습사원) < 사원 < 주임 < 대리 < 과장 < 차장 < 부장
SELECT * FROM EMPLOYEE;
-- 이 악덕회사
-- 대리직급임에도 불구하고 과장보다 급여를 많이 받는 대리가 존재한다!!
-- 내가 과장이면 참을 수 없음 범인을 찾아내야함^^! 테이블에서 찾기 좀 힘드네요,, 찾는 여정으로 떠나보자

-- 1) 과장들은 얼마를 받고 있는가

-- '과장'
SELECT
       SALARY
  FROM
       EMPLOYEE E -- 과장 키워드 보려면 JOB_NAME 필요하니까 조인해야함
     , JOB J
 WHERE
       J.JOB_CODE = E.JOB_CODE -- 여기까지 쓰고 잘되는지 확인한다음에
   AND
       JOB_NAME = '과장'; -- 220, 250, 232, 376, 750

-- 2) 위의 급여보다 높은 급여를 받고 있는 대리의 사원명, 직급명, 급여
SELECT
       EMP_NAME
     , JOB_NAME
     , SALARY
  FROM
       EMPLOYEE E
     , JOB J
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND
       -- SALARY로 조건을 달아야하는데, 과장들 얼마받는지 쿼리 결과가 다중행으로 나왔음, 같은지 비교하고싶은게 아니라서 IN을 못씀, 대소비교하고싶음
       -- 단일값 비교가 아니라 하나랑 다섯개랑 비교할거임... 하나하나 해야함?
       -- SALARY > 2200000 OR SALARY > 2500000 OR... 이거 하기 싫어요
       SALARY > ANY (2200000, 2500000, 2320000, 3760000, 7500000) -- ANY 연산자를 씁니다, 한꺼번에 비교 가능, 조건만 대리 추가로 달기
       -- ANY 안에 들어갈 내용을 서브쿼리로 바꿔주면됨
   AND
       JOB_NAME = '대리'; -- 원래 해야 할 방식??

-- 서브쿼리로 바꿔넣기
SELECT
       EMP_NAME
     , JOB_NAME
     , SALARY
  FROM
       EMPLOYEE E
     , JOB J
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND
       SALARY > ANY (SELECT
					        SALARY
					   FROM
					        EMPLOYEE E
					      , JOB J
					  WHERE
					        J.JOB_CODE = E.JOB_CODE
					    AND
					        JOB_NAME = '과장')
   AND
       JOB_NAME = '대리';

/*
 * X(컬럼) > ANY(값, 값, 값)
 * X의 값이 ANY괄호안의 값 중 하나라도 크면 참
 * 
 * > ANY(값, 값, 값) : 여러 개의 결과값중 하나라도 "클"경우 참을 반환
 * 
 * < ANY(값, 값, 값) : 여러 개의 결과값중 하나라도 "작을"경우 참을 반환
 */

-- 과장직급인데 모든 차장직급의 급여보다 더 많이 받는 직원
-- 차장이 더 높은데? 차장보다 더 많이 받는 과장이 있다?
-- ANY로 해결이 안됨, ANY는 제일 작은 값보다 크면 참이 됨??????????
SELECT
       SALARY
  FROM
       EMPLOYEE
  JOIN
       JOB USING(JOB_CODE)
 WHERE
       JOB_NAME = '차장';

-- 차장 확인하고, 모든 차장님보다 많이받는 과장님 찾자
SELECT
       EMP_NAME
  FROM
       EMPLOYEE
  JOIN
       JOB USING(JOB_CODE)
 WHERE
       SALARY > ALL(SELECT
					       SALARY
					  FROM
					       EMPLOYEE
					  JOIN
					       JOB USING(JOB_CODE)
					 WHERE
					       JOB_NAME = '차장')
   AND
       JOB_NAME = '과장';

--------------------------------------------------

/*
 * 3. 다중 열 서브쿼리
 * 
 * 조회결과는 한 행이지만 나열된 컬럼의 수가 다수개일 때
 * 
 */
SELECT * FROM EMPLOYEE;
-- 박채형 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원들의 사원명, 부서코드, 직급코드조회
-- 부서코드랑 직급코드 둘 다 똑같은 사람들 찾고싶은것이므로 두개를 먼저 알아야함
SELECT
       DEPT_CODE
     , JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '박채형'; -- D5 / J5

-- 사원명, 부서코드, 직급코드를 조회할건데, 부서코드 == D5 + 직급코드 == J5
SELECT
       EMP_NAME
     , DEPT_CODE
     , JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
   AND
       JOB_CODE = 'J5'; -- 이렇게 쓰고싶은게 아니라 값이 아니라 서브쿼리로 쓰고싶음

-- 두개를 합쳐야하는데,, 1절이 두개가 나오는뎅? 하나만 나와야하는뎅?
-- 지워야함? 기껏 이쁘게 서브쿼리 써놓은 의미가 없음
-- 단일행 서브쿼리로 쓰는건 가능한데 읭
SELECT
       EMP_NAME
     , DEPT_CODE
     , JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = (SELECT
					       DEPT_CODE
					  FROM
					       EMPLOYEE
					 WHERE
					       EMP_NAME = '박채형')
   AND
       JOB_CODE = (SELECT
					      JOB_CODE
					 FROM
					      EMPLOYEE
					WHERE
					      EMP_NAME = '박채형');

-- 이걸 다시
-- 일반연산자를 쓰는데 묶어서 세트로 써줌
SELECT
       EMP_NAME
     , DEPT_CODE
     , JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       (DEPT_CODE, JOB_CODE) = (SELECT
								       DEPT_CODE
								     , JOB_CODE
								  FROM
								       EMPLOYEE
								 WHERE
								       EMP_NAME = '박채형');

--------------------------------------------------

/*
 * 4. 다중 행 다중 열 서브쿼리
 * 서브쿼리 수행 결과가 행도 많고 열도 많음
 * 
 */
-- 각 직급별로 최고 급여를 받는 사원들 조회(이름, 직급코드, 급여)
-- 최종 목적은 EMPLOYEE 에서 이름, 직급코드, 급여
-- 각 직급별로 최고 급여 <-- 이거 먼저 구해야함
SELECT
       JOB_CODE
     , MAX(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY
       JOB_CODE;
-- JOIN 굳이 안하고 작성
-- 얘를 서브쿼리로 쓰고싶음, 쿼리 결과(ResultSet)가 행도 여러개 열도 여러개
-- 여태 쓴 방법 다 스까
SELECT
       EMP_NAME
     , JOB_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       (JOB_CODE, SALARY) IN (SELECT
							         JOB_CODE
							       , MAX(SALARY)
							    FROM
							         EMPLOYEE
							   GROUP
							      BY
							         JOB_CODE);

--------------------------------------------------

-- 일반적으로 많이 쓰는건 1번(단일행서브쿼리)
-- 여기 적은 것 말고 진짜로 많이 쓰는 서브쿼리가 있음, 서브쿼리는 이 용도로 많이 씀(5번하러감)

--------------------------------------------------

/*
 * 5. 인라인 뷰(INLINE-VIEW) <- 이건 진짜 많이 씀, 실질적으로 우리에게 중요한 것
 * 
 * FROM 절에 서브쿼리를 작성
 * 
 * SELECT문의 수행결과(Result Set)을 테이블 대신 사용
 * 
 * 6. 스칼라 서브쿼리(Scalar Subquery) <- 쓰는걸 추천하진 않는데...
 * 
 * 주로 SELECT 절에 사용하는 쿼리를 의미(우리가 사용하는 단일행 서브쿼리가 이 범주에 포함됨), (WHERE나 FROM이나 다 쓸 순 있음)
 * 메인쿼리 실행 마다 서브쿼리가 실행될 수 있으므로 성능이슈가 생길 수 있음
 * 그렇기 때문에 JOIN으로 대체하는 것이 일반적으로는 성능상 유리함
 * 단, 캐싱이 되기 때문에 동일한 결과에 대해선 성능상 JOIN보다 뛰어날 수도 있음(누가 더 유리한지 계산해서 써야하는데 우리가 하기 좀 힘들지도?)
 * 스칼라 쿼리는 반드시 단 한개의 값만을 반환해야함
 * (스칼라의 특징은 스칼라 쿼리의 결과에 대해서 캐싱을 해놓는다고 함, 똑같은 결과는 저장해두므로 조인했을때보다 성능이 좋을 수 있지만 일반적으로 이런 상황은 존재하지 않고, 많은 것을 고려해야하기때문에 JOIN 아니면 GROUP BY 생각하는게 맞음)
 * 알아만 두고 웬만하면 피하자... 면접에서 물어봤을 때 장단점 전부 다 대답하세요
 * 
 */

-- 잘 안쓰는 스칼라부터,, 금방끝남
-- 스칼라 예시
-- 사원의 사원명과 부서명을 조회
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 이걸 JOIN 안쓰고
-- SELECT절에 SELECT 또해버리기(서브쿼리 만들어서)
-- 가장 일반적인 스칼라쿼리 사용방식, 결과는 똑같이 나오긴 하는데, 모든 행에 대해서 SELECT를 계속 수행함 --> 성능저하이슈
SELECT
       EMP_NAME
     , (SELECT DEPT_TITLE FROM DEPARTMENT WHERE E.DEPT_CODE = DEPT_ID)
  FROM
       EMPLOYEE E;

-- 간단하고 시원하게 인라인 뷰 한 번 그냥 써보기만 하기(인라인뷰 특징 안살리고)
-- 사원들의 이름, 보너스 포함 연봉 조회하고 싶음
-- 단 보너스포함 연봉이 4000만원 이상인 사원만 조회
/*
SELECT
       EMP_NAME AS "사원이름"
     , (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "보너스 포함 연봉"
  FROM
       EMPLOYEE
 WHERE
       "보너스 포함 연봉" > 40000000; -- 실행순서때문에 이러면 못써요~
*/

-- 이 상황에서 서브쿼리로 사용할건데, FROM에서!
SELECT
       "사원이름"
     , "보너스 포함 연봉"
  FROM
       (SELECT
		       EMP_NAME AS "사원이름"
		     , (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "보너스 포함 연봉"
		  FROM
               EMPLOYEE) -- 마치 얘가 테이블처럼 인식됨, 여기서 안한건 SELECT에서 조회안됨(BONUS같은거)
 WHERE
       "보너스 포함 연봉" > 40000000;

-- 인라인뷰를 어디서 활용하느냐?
-- 요새 스타일 아닌데, 기존에 만들어진 코드 보는 일도 많으니까 옛날에 어떻게 썼는지 보고, 이걸 요즘엔 어떻게 변경해서 사용하는지 알아보자

--> 인라인 뷰를 주로 사용하는 예(클래식)
-- 쇼핑몰에서 이달의 베스트셀러를 보여주는데 어디 있는걸 보여주는거임? 화면에 보이는 데이터는 데이터베이스의 테이블에 들어있겠지
-- 전체 18개 상품이 있다면 판매량이 높은 5개만 노출됨, 이걸 SQL문으로 연산해서 보여줘야해
-- 옛날에는 어떻게? 주로 인라인뷰를 사용했다
--> TOP-N 분석(TOP에서부터 N개) : DB상에 있는 값들 중 최상위 N개의 데이터를 보기위해서 사용
SELECT * FROM EMPLOYEE; -- 판매량이 있고 이런건 아니니까 줄세우기 할게 SALARY.. 이걸로해보자
-- 전 직원들 중 급여가 가장 높은 상위 5명 줄 세우기해서 조회
-- 23명 다 조회하고싶은게 아니라 상위 5명만 급여가 높은순으로 조회

-- 아주 클래식한 친구라서 이거 알아야함
-- * ROWNUM : 오라클에서 자체적으로 제공해주는 컬럼, 조회된 순서대로 순번을 붙여줌(아무 테이블에서 다 쓸 수 있음)
-- 1부터 시작해서 오름차순으로 붙여줌
SELECT
       EMP_NAME
     , SALARY
     , ROWNUM
  FROM
       EMPLOYEE;

SELECT				-- 3
       ROWNUM
     , EMP_NAME
     , SALARY
  FROM				-- 1
       EMPLOYEE
 WHERE				-- 2, 이 시점에서 줄을 세우게됨, 이거 하고싶은게 아니라 23명 줄세우고 나서 자르고싶음
       ROWNUM <= 5
 ORDER				-- 4, 줄세우기가 제일 마지막에 돌아감...
    BY
       SALARY DESC;

-- 줄을 먼저 세워버리자
-- ORDER BY절을 이용해서 줄세우기 먼저 수행
SELECT -- 3. 마지막으로 자르고 나서 조회
       EMP_NAME
     , SALARY
  FROM -- 이 안에서 줄세우기 돌려버림, FROM 절이 1등이므로 1번에서 줄세우기가 끝나게됨
       (SELECT
               EMP_NAME
             , SALARY
          FROM
               EMPLOYEE
         ORDER
            BY
               SALARY DESC)
 WHERE
       ROWNUM <= 5; -- 2. 줄세우기 끝나고 나서 상위 5개 자르기

-- 자주묻는질문 게시글도 어딘가에 테이블로 존재하고있겠지, 한번에 다 보여주지 않고 몇개씩 자르고 페이지를 나눠서 보여줌
-- 이것도 최신글이 앞으로 나오게(또는 제일 자주묻는거?) 정렬한다음에 잘라서 보여주겠지
-- 이러려면 일단 자르기 전에 정렬이 끝난 결과가 필요함, 자르는건 ROWNUM으로 자를건데, 그 전에 정렬이 끝난 상태가 필요하니까
-- FROM절에서 숫자 기준으로 정렬하든 해서 정렬하고 WHERE에서 자르고자시고어쩌고저쩌고
-- 아무튼 클래식하게 인라인절 줄세우기를 먼저 끝내놓을 용도로 사용

----------------------------------------

-- 클래식 했으니까 모던 해야지
-- 아 모던한 방법 쓰고 싶다.
SELECT
       EMP_NAME
     , SALARY
  FROM
       EMPLOYEE
 ORDER
    BY
       SALARY DESC
       -- 인라인뷰의 희생양으로 쓰기싫은데용
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY; -- 오라클엔 없고 MYSQL에 있었는데, 사람들이 이런거 해야할때 맨날 클래식 하고앉아있으니... 오라클에 중간에 편입됨ㅎ
-- 한평생 오라클만 쓴 사람은 이거 모를수도 있음ㅎㅎ
-- 최신 모던 문법은 OFFSET이 기준, 모든 SQL 표준, 딴데가도 다 있음
-- OFFSET은 몇개씩 건너뛸지를 정하는것. 지금 작성한 것은 0개를 건너뛰고, 0개 이후에 5개를 조회하겠다는 의미로 작성됨
-- 6번째부터 5개 받고싶으면 OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;
-- 앞쪽에 전체 조회 결과중 몇개를 건너뛸건지, 뒤쪽에 건너뛴다음 몇개를 반환받을건지 작성함
-- 0개를 건너 뛰고 그 다음 5행을 반환받겠다.
-- 솔직히 문법을 이렇게 쓰면 오라클이 내부에서 클래식으로 바꿔서 돌림, 동작방식은 똑같고 바꾸는 연산만 추가되겠죠?, 극한의 성능충이면 클래식이 맞겠지..
-- 실질적으로 비교해봤자 성능차가 유의미하게 난다고 하긴 애매함ㅎ 12버전에 처음 나왔는데 그땐 차이가 났을수도? 지금은 뭐...