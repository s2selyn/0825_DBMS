SELECT * FROM EMPLOYEE;
-- 단순 사원의 정보, 23명 사원들의 정보를 담아놨음

/*
사번 사원명 주민번호 이메일 전화번호
부서코드 직급코드 급여등급
이런 부서에 대한 정보
직급에 대한 정보
이런것들을 사원의 정보를 담는 테이블에 저장해두지 않고 따로 분리해뒀음
*/

-- 부서에 대한 정보는 DEPARTMENT 라는 테이블에 저장해뒀음
SELECT * FROM DEPARTMENT;

-- 직급에 대한 정보는 JOB 이라는 테이블에 저장해뒀음
SELECT * FROM JOB;

-- 15:15 부서코드를 보고 부서에 대한 정보 테이블에 가서 무슨부서인지 확인?

-- 지금 배우는 오라클은 관계형 DBMS, RDBMS라고 부름(RELATIONSHIP)
-- 데이터를 하나의 테이블에 다 넣는것이 아니고, 각각의 테이블에 데이터를 나눠서 저장하고, 테이블마다 관계를 만들어줘서 저장하는 방식

-- 15:20 나중에 프로젝트 하기 전에 정규화를 배울텐데, 정규화를 통해서 데이터 정확성, 중복 이런 작업들을 하기 위함?

-- 전체사원들의 사원명, 부서코드, 부서명을 한꺼번에 조회하고 싶다.
-- 문제는 사번, 사원명, 부서코드는 EMPLOYEE 테이블에 있음
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
  FROM
       EMPLOYEE;
-- 부서코드, 부서명은 DEPARTMENT 테이블에 있음
SELECT
       DEPT_ID
     , DEPT_TITLE
  FROM
       DEPARTMENT;
-- 부서코드 봐봤자 뭔지 구분이 안되니까 부서명이 뭔지 한번에 보고싶음
-- 어떻게 함? 하면 하지 돈주면 다 해야지, 그림판에서 짜집기^_^ㅎ 이렇게 하면 됨? 허허...
-- EMPLOYEE 테이블과 DEPARTMENT 테이블 컬럼의 값을 비교해서 같은걸 붙여주면 됨
-- 해야지 회사에서 시키면 열심히 해야지 예쁘게 꼼꼼히 하겠지
-- 만약에 내가 이 일을 너무 훌륭하게 잘했어, 예쁘게 잘하면? 또시킴

-- 전체사원들의 사번, 사원명, 직급코드, 직급명을 한 번에 조회
-- 사번, 사원명, 직급코드는 EMPLOYEE 테이블에 있음
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_CODE
  FROM
       EMPLOYEE;

-- 직급코드, 직급명은 JOB 테이블에 있음
SELECT
       JOB_CODE
     , JOB_NAME
  FROM
       JOB;
-- 직급코드를 보고, JOB 테이블에서 보고 같은걸 보고 또 붙여
-- 사원 수가 많아지면 이게 인력으로 해결하기 쉽지 않겠지

-- 조회를 하고싶은데, 조회하고 싶은 컬럼이 다른 테이블에 있는 경우
-- 두 개 이상의 다른 테이블에 존재하는 컬럼을 어떻게 한번에 조회해서 하나의 RESULTSET에 담을 수 있는지 배워보자
-- 굉장히 중요함, 면접 단골질문
-- SQL문에 대해서 물어볼때 보통 이거 물어봄, 배울게 JOIN인데, 면접 질문이 보통 JOIN 얼마나 해보셨어요? 몇개의 테이블까지 JOIN 해보셨어요?
-- 엄청 어마어마하게 잘물어봄, 잘하면 좋아하는 파트, 많이해봤어요, 잘해요 이러면 좋아함, 얘는 실제로 너무 좋아하고 많이 물어보는 파트

--------------------------------------------------

--> JOIN을 통해 연결고리에 해당하는 컬럼만 매칭시킨다면 마치 하나의 조회 결과물처럼 조회 가능
-- 지금 공통점 동일한 값이 들어있는 컬럼이 있음 --> 연결고리, 매칭시킬 수 있음
-- 굉장히 중요함!

-- 테이블 하나 만들어서 테스트 해보자
-- KH
-- 어떤 강의장에 어떤 강사가 수업을 하고 있는가??(이걸 테이블로 저장해놓고싶음, 아직 안배웠는데 맛보기로 해보자)
CREATE TABLE CLASS_ROOM( -- 테이블 만들기
	CLASS_ID CHAR(1), -- 변수이름, 식별자 짓듯이, CHAR형에 1바이트, ABC만 넣을거니까
	LECTURE_NAME VARCHAR2(20) -- 강사이름을 넣자, 이름은 짧을수도 있고 두글자도 있고 네글자도 있고 많으니까 VARCHAR2, 20바이트
);
-- 강의장 정보와 강사 이름을 넣을 테이블을 만들었다, 조회 한 번 해보자
SELECT * FROM CLASS_ROOM;
-- 데이터가 없으니 텅텅 비었고 컬럼 두개만 있으면 끝

-- 15:38 테이블에 데이터를 추가 한 번 해보자, 추가 조회 삭제 수정 전부 한 행 단위 항상!?
INSERT INTO CLASS_ROOM VALUES('A', '이승철'); -- INSERT INTO 테이블식별자 VALUES
-- INSERT, INTO, VALUES 다 키워드, 매개변수 순서 중요!
INSERT INTO CLASS_ROOM VALUES('B', '홍길동');
INSERT INTO CLASS_ROOM VALUES('C', '고길동');
-- 이렇기때문에 테이블을 나눌수밖에 없음
-- 우리의 정보를 저장해야함, 이름이라고 치면 이름을 테이블에 저장해야하는데, 전체의 이름을 저장하려면 컬럼이 몇개가 더 필요함? 학생수만큼의 컬럼이 있어야함
-- 반마다 학생수가 다르겠지? 어떤 강의실은 많고 어떤 강의실은 모자라고
-- 15:42 하나의 강의장에 여럿 학생이 들어오려면 하나의 테이블에 담을 구조를 만들수가 없음, 그래서 데이터를 분리시킴

-- 학생들의 정보를 저장하는 테이블을 만든다고 가정하자
CREATE TABLE STUDENT(
	CLASS_ID CHAR(1),
	STUDENT_NAME VARCHAR2(20)
);

INSERT INTO STUDENT VALUES('A', '이승욱');
INSERT INTO STUDENT VALUES('A', '채정민');
INSERT INTO STUDENT VALUES('B', '김윤기');
INSERT INTO STUDENT VALUES('C', '김태호');
COMMIT;

-- 16:00 ??? 무슨상황?
SELECT
       CLASS_ID
     , LECTURE_NAME
  FROM
       CLASS_ROOM;

SELECT
       CLASS_ID
     , STUDENT_NAME
  FROM
       STUDENT;
-- 따로 보면 이것저것 볼 수 있음

-- 나는 강의실이랑, 강사이름이랑, 학생이름을 한꺼번에 같이 보고싶은데!
-- 따로따로 나눈건 어쩔 수 없는 선택
-- 만약에 학생 테이블에 강사 이름을 넣겠다면 모든 행에 강사 이름이 중복으로들어감, 그래서 테이블을 나눠서 두개의 테이블을 만들었음
-- 학생 테이블에다가 강사이름 강의장을 같이 한번에 조회하고싶다!
-- SELECT 한번하면 A강의실 이승철 이승욱 같이 나오게
-- 저장은 따로 되어있지만 조회할 때 RESULTSET은 하나로 받고싶음
-- 1. 내가 조회하고 싶은 컬럼을 다 적음
SELECT
       LECTURE_NAME -- 이건 CLASS_ROOM
     , CLASS_ROOM.CLASS_ID -- 이건 CLASS_ROOM
     , STUDENT.CLASS_ID -- 이건 STUDENT
     , STUDENT_NAME -- 이건 STUDENT
  FROM
       CLASS_ROOM, STUDENT; -- 테이블 두개를 써줌, 이대로 실행하면 열의 정의가 애매합니다, 열은 컬럼을 의미함, CLASS_ID라는 컬럼이 두개의 테이블에 전부 존재하고 있음
       -- 여기도있고 여기도있는데 누구꺼 조회하는거임? 이러는거지
       -- 컬럼명 앞에 테이블명 쓰고 참조연산자 써줌, 우리 좋아하는거
       -- 1절 끝
-- 조회 결과 이해해야함, 왜 이렇게 나왔는지
-- 두 테이블의 곱해진 결과가 나온것
-- 이걸 다 조회하고싶은게 아니고, 어떤것만 조회하고싶음?
-- CLASS_ROOM의 CLASS_ID 컬럼값과 STUDENT의 CLASS_ID 컬럼값이 같은 것만 조회하고 싶음
-- 곱한 결과에서 컬럼값이 일치하는 것만 조회하고싶음
-- FROM절에 두개의 테이블을 쓰면 각각의 행이 곱해진 결과가 출력됨
-- 16:13 이걸 조회할 때, 하고싶은 일? 실제 조회하고싶은것은?
-- 그럼 조건이 달린 것이니까 WHERE 추가해보자
SELECT
       LECTURE_NAME
     , CLASS_ROOM.CLASS_ID
     , STUDENT.CLASS_ID -- 얘 날려버리면 강의실 정보도 하나만 나옴
     , STUDENT_NAME
  FROM
       CLASS_ROOM, STUDENT
 WHERE
       CLASS_ROOM.CLASS_ID = STUDENT.CLASS_ID;
-- 16:16 이게 조인의 원리, 곱한것이 만들어지는데 같은것만 조회하게 만들어줌

-- 16:16
/*
 * 쓸 게 많음 중요해서
 * 
 * < JOIN >
 * 
 * 두 개 이상의 테이블에서 데이터를 한 번에 조회하기 위해 사용하는 구문
 * (JOIN을 통한) 조회결과는 하나의 ResultSet으로 나옴 -- 두개의 테이블에서 하나의 RESULTSET으로 ???뭘 출력했다고?
 * 
 * 관계형 데이터베이스에서는 최소한의 데이터로 각각의 테이블에 데이터를 보관하고있음(중복방지)
 * ??? 나눠져있는 것을 한꺼번에 조회하려면?
 * -> JOIN구문을 사용해서 여러 개의 테이블 간 "관계"를 맺어서 같이 조회 해야함
 * 전혀 관계없는 테이블은 JOIN할 수 없음, 같은 값이 들어있는 컬럼이 두 테이블에 존재해야 걔를 매칭시켜서 JOIN할 수 있음
 * => 무작정 JOIN을 해서 조인하는 것이 아니고 테이블 간 매칭을 할 수 있는 컬럼이 존재해야함
 * 
 * JOIN은 크게 "오라클 전용구문(오라클에서만쓸수있음)"과 "ANSI(미국국립표준협회)구문(오라클에서도 쓸 수 있고 다른 DBMS에서도 쓸 수 있고)"으로 나뉜다.
 * 보통 ANSI를 선호함, 회사에서 제품을 만들 때 DBMS는 회사마다 다름, 오라클로 이걸 만들어두면 오라클 쓰는 회사에밖에 납품을 못함, ANSI를 쓰면 여기저기 납품할 수 있겠지
 * 근데 큰회사들은 오라클밖에 안씀, 그런데는 오라클 전용 구문만 사용하고 이런 식이라서
 * 그래서 우리는 둘 다 배운다!
 * 
 * 똑같은 JOIN인데 문법도 다르고 부르는 것도 다름
 * ====================================================================================================
 * 				오라클 전용 구문				|				ANSI(오라클 + 타 DBMS) 구문
 * ====================================================================================================
 * 					등가조인					|						내부조인
 * 				(EQUAL JOIN)				|					(INNER JOIN)
 * ----------------------------------------------------------------------------------------------------
 * 					포괄조인					|
 * 				(LEFT OUTER)				|				왼쪽 외부조인(LEFT OUTER JOIN)
 * 				(RIGHT OUTER)				|				오른쪽 외부조인(RIGHT OUTER JOIN)
 * 											|			전체 외부조인(FULL OUTER JOIN) -> 오라클에선X
 * ----------------------------------------------------------------------------------------------------
 * 					카테시안 곱				|						교차조인
 * 				(CARTESIAN PRODUCT)			|					(CROSS JOIN)
 * ----------------------------------------------------------------------------------------------------
 * 자체조인(SELF JOIN)
 * 비등가조인(NON EQUAL JOIN)
 * 자연조인(NATURAL JOIN)
 * 
 * 다 학습할건데 자연조인은 한번 쓰고 넘어갈거임, 가치가 없음
 * 
 */

/*
 * 1. 등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)
 * 아무도 내부조인이라고 안하고 이너조인이라고 함, 등가조인은 그렇게 하는 사람이 있음? 선생님이 못본걸수도있고
 * 
 * JOIN 시 연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회(아까 했던 것, 일치하는 것만 조회)
 * ( == 일치하지 않는 값들을 조회에서 제외 )
 * 
 */

--> 오라클 전용 구문
--> SELECT 절에는 조회하고 싶은 컬럼명을 각각 기술
-->   FROM 절에는 조회하고자 하는 테이블을 , 를 이용해서 전부 다 나열(처음 시작은 두개로 시작하겠지만 JOIN은 내가 JOIN하고싶은 개수만큼 할 수 있음, 보통 면접가서 물어볼 때 JOIN을 많이했다면 많이했다고 할 수록 좋아함)
-->  WHERE 절에는 매칭을 시키고자 하는 컬럼명에 대한 조건을 제시함( = )(우리는 동등비교 연산자를 가지고 조인함)

-- 다시 처음으로 돌아가서
-- 전체 사원들의 사원명, 부서코드, 부서명을 한꺼번에 조회하고 싶다.
-- 이럴때는 항상 테이블 구조를 파악해야함
SELECT * FROM EMPLOYEE; -- EMP_NAME, DEPT_CODE
-- EMP_NAME에 사원명, DEPT_CODE에 부서코드가 저장되어 있음
SELECT * FROM DEPARTMENT; -- DEPT_ID, DEPT_TITLE
-- DEPT_ID에 부서코드, DEPT_TITLE에 부서명이 들어가있음
-- 이 두개의 테이블을 봤을 때 매칭시켜줄 수 있는 같은 값을 가진 컬럼이 존재하느냐? ㅇㅇ
-- EMPLOYEE 테이블의 DEPT_CODE, DEPARTMENT 테이블의 DEPT_ID가 그 역할을 함
-- 16:35 이걸 어떻게 한다고요?

-- case 1. 연결할 두 컬럼의 컬럼명이 다른경우(DEPT_CODE - DEPT_ID)
-- 1. 오라클 구문 먼저
-- SELECT 절에 조회하고 싶은 컬럼명을 싹다 써요, 1절 끝
-- 2절, FROM 절에서는 내가 조회하고 싶은 컬럼이 있는 테이블을 싹다 써요, 쉼표이용해서 시원하게
-- 이렇게 하면 곱한 결과가 나옴, 207개, 이걸 보고싶은게 아니고 이 결과 중에서 DEPT_CODE와 DEPT_ID컬럼 값이 동일한 행만 들고가고싶음
-- 조건달기
SELECT
       EMP_NAME
     , DEPT_CODE
     , DEPT_ID
     , DEPT_TITLE
  FROM
       EMPLOYEE
     , DEPARTMENT
 WHERE
       DEPT_CODE = DEPT_ID;
-- 여기서 중요한 거, 하나 짚고 넘어가야 할 것
-- 아직 부서가 없는 사원이 있음, 이상태에서 조회함
-- 16:39 EMPLOYEE에서, DEPARTMENT에서? 어??? 뭐한다고?
-- 여기서 중요한거, 조회결과가 21행임, 이게 중요함
-- 처음에 EMPLOYEE는 23행, DEPARTMENT는 9행이므로 21행은 없던 숫자
-- 207개중에 21개 행만 일치하더라 라는 이야기
-- 207개 행중에서 21개행만 일치하더라

-- 일치하지 않는 것들을 이 조회 결과에서 날려버리고 일치하는 것만 가져오겠다, 조회하겠다
-- 23명의 사원중에서 아까 부서가 들어있지 않은(DEPT_CODE가 NULL) 사원들이 있었음, 이 두명은 매칭해보니 맞는게 없음, 그래서 조회결과에 포함되지 못한것
-- 일치하지 않는 값은 조회에서 제외
-- DEPT_CODE가 NULL인 사원 2명은 데이터가 조회되지 않는다.

-- 2절이 있음, 1절이 끝이 아님
-- EMPLOYEE입장에서도 NULL인 친구들이 있었는데, DEPARTMENT도 9행이 있었음, EMPLOYEE 테이블이 9행을 전부 쓰고있지 않음, 3,4,7부서는 사용하고있지않음
-- 이렇게 되니까 3,4,7은 조인 결과에서 찾을 수 없음
-- 16:43 EMPLOYEE에서도 조회 안되는게 있고 DEPARTMENT에서도 조회 안되는게 있음
-- DEPT_ID가 D3, D4, D7인 부서데이터가 조회되지 않는다.

-- 전체 사원들의 사원명, 직급코드, 직급명을 같이 한꺼번에 조회하고 싶다.
-- 항상 JOIN을 할 때는 테이블의 구조 및 데이터를 파악(확인)해야 한다.
SELECT * FROM JOB; -- 컬럼 두개, JOB_CODE가 직급코드 데이터, 직급코드를 조회할거니까 JOB 테이블에서는 JOB_CODE와 JOB_NAME을 조회할 것
-- 사원명이 JOB에 없음, 사원명은 EMPLOYEE에 있음
SELECT * FROM EMPLOYEE; -- EMP_NAME, JOB_CODE 두개를 조회할 것
-- 16:49 여기 보면 JOB_CODE가 있음, 짝궁 만들어줄 수 있겠다

-- case 2. 연결할 두 컬럼의 이름이 같은 경우(JOB_CODE)
SELECT
       JOB_CODE
     , JOB_NAME
     , EMP_NAME
     , JOB_CODE -- SELECT에 조회하고 싶은 컬럼 시원하게 다 적기
  FROM
       EMPLOYEE, JOB -- FROM에 테이블 시원하게 다 적기
 WHERE
       JOB_CODE = JOB_CODE; -- 내가 연결고리를 지어줄 컬럼을 동등비교해서 TRUE가 나오는 애들만 조회되게끔
-- SQL Error 원래 영어로 나와야하는데, 그래야 우리한테 질문하는데, 선생님 시나리오랑 어긋남
-- 원래 column ambiguously defined, 애매하다, 모호하다
-- JOB_CODE가 있는데 EMPLOYEE의 것인지 JOB의 것인지 애매함
-- 두가지 방법이 있음
-- 방법 1. 테이블명을 사용하는 방법
SELECT
       EMP_NAME
     , EMPLOYEE.JOB_CODE
     , JOB.JOB_CODE
     , JOB_NAME
  FROM
       EMPLOYEE, JOB
 WHERE
       EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- 이러면 더이상 애매하지 않죠, 누구껀지 알 수 있음, 두개가 같은것만 조회됨

-- 방법 2. 별칭 사용(각 테이블마다 별칭 부여 가능)(컬럼 조회할 때 별칭 부여했던것처럼)
SELECT
       EMP_NAME
     , E.JOB_CODE
     , J.JOB_CODE
     , JOB_NAME
  FROM
       EMPLOYEE E
     , JOB J
 WHERE
       E.JOB_CODE = J.JOB_CODE; -- 애매한 상황, JOB_CODE가 누구의 JOB_CODE인지 알 수 없다
-- 수업용이라 이렇게 했는데 테이블도 이름짓기 규칙이 있음, 접두사도 붙고 특수문자도 쓰고 대문자만 써야하니까 실수할 확률이 있음
-- 쓰기 힘드니까 테이블에 별칭을 달아
-- EMPLOYEE는 E, JOB은 J
-- 별칭을 어디서 달았음? FROM, 얘는 실행순서가 1등, 그럼 이 이후에는 다 이걸 활용할 수 있음
-- 별칭을 달면 테이블 명 쓰다가 실수하는 걸 줄일 수도 있고 쓰기도 편해지고
-- 양날의 검이긴 함. 지금은 테이블 두개라 끝남
-- 보통 앞글자만 따는데, 테이블 조인하다보면 10개 12개 이러면 분명히 앞글자가 겹치는게있을것임
-- E를 EE로 만들면 컬럼 앞에 쓰다가 또 헷갈리는 경우가 생김
-- 실제로 회사에서 사용하는 SELECT문은 어려운거 신입한테 안시킴
-- 보통 SELECT문이 하나에 300~400줄, 이런거 보면 별칭 달아두면 오히려 헷갈릴 수 있음. 차라리 테이블명이었으면 명확했겠지
-- 서브쿼리 안에 서브쿼리 안에 서브쿼리 안에.. 이런식으로 들어가면 헷갈릴 수 있음, 쓸 때는 좋지만 길어지면 오히려 안좋아질수도, 고민해볼부분, 편한데 편한만큼 불편한것도 생김
-- 17:12 오라클 구문 JOIN법, 문법 어려운거 없음, 하는방법 어쩌구저쩌구...

--> ANSI구문
-- FROM절에 기준테이블을 하나 기술한 뒤
-- 그 뒤에 JOIN절에 같이 조회하고자하는 테이블을 기술(매칭시킬 컬럼에 대한 조건도 기술)
-- 조건을 기술할 때 쓸 수 있는 기법이 두 개, 두개중에 하나 골라서 씀
-- USING / ON 구문
-- ANSI가 더 명확하고 보기좋고 편해, 써보고 판단

-- EMP_NAME, DEPT_CODE, DEPT_TITLE
-- 사원명, 부서코드, 부서명
-- 연결컬럼이 컬럼명이 다름(EMPLOYEE - DEPT_CODE / DEPARTMENT - DEPT_ID) --> 이런 경우에 ANSI구문에서는 USING을 못씀 무조건 ON 써야함
-- 무조건 ON구문만 사용가능!!!(USING은 못씀 안됨 불가능함!!!!!!!!!!!!!!!!!!!)
SELECT
       EMP_NAME -- 컬럼은 시원하게 다 쓰는거
     , DEPT_CODE
     , DEPT_TITLE
  FROM
       EMPLOYEE -- 테이블은 다 쓰지 말고 하나만, 얘가 기준
-- INNER 보통 INNER 안 씀, INNER JOIN은 INNER 안 쓰면 됨
  JOIN -- 이 뒤에 내가 JOIN하고싶은 테이블을 씀, 쉼표쓰고 테이블 썼던걸 JOIN하고 테이블 썼음
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);
       -- 얘는 WHERE을 안 쓰고 이 뒤에 ON을 씀
-- 이게 더 명확함, 나 JOIN한다!
-- WHERE보다 먼저 수행됨
-- ????

-- EMPLOYEE 테이블에서 EMP_NAME, JOB 테이블에서 JOB_CODE, JOB_NAME
-- 사원명, 직급코드, 직급명
-- 연결할 두 컬럼명이 같을경우(JOB_CODE)
-- 17:21 어차피 똑같은거 조회될거니까???
-- ON 구문이용 ) 애매하다(AMBIGUOUSLY)발생할 수 있음 어떤 테이블의 컬럼인지 명시
SELECT
       EMP_NAME
     , E.JOB_CODE -- 사실 얘 없어도 됨, 있는게 공부할땐 좋아
     , JOB_NAME
  FROM
       EMPLOYEE E
  JOIN
       JOB J ON (E.JOB_CODE = J.JOB_CODE);
-- 이건 컬럼명이 같으니까 ANSI구문에서는 USING구문을 쓸 수 있음
-- USING 구문이용 ) 컬럼명이 동일할 경우 사용이 가능하며 동등비교연산자를 기술하지 않음
SELECT
       EMP_NAME
     , JOB_CODE
     , JOB_NAME
  FROM
       EMPLOYEE -- USING 구문 쓸때는 별칭 안지음, 시원하게 조인하고 조인하고 싶은 테이블 적은 다음에 ON 대신 USING 적음, 그다음에 컬럼명을 한번만 적음
  JOIN
       JOB USING (JOB_CODE); -- 결과는 똑같음
-- 별칭짓고 컬럼명 누구거다 안적어도 지가 알아서 매칭시켜줌
-- 지금 JOB_CODE가 붙은 다른 테이블이 붙을수도 있음, JOIN은 하고싶은만큼 하는거니까 JOIN해서 계속 붙일 수 있음
-- 똑같은 이름의 JOB_CODE가 있다면 또 애매해짐, 이러면 USING을 못쓰게됨, ON으로 바꿔줘야함
-- 좋긴 한데... 좋은걸로만 따지면? 얘가 제일 좋음, NATURAL JOIN
-- [참고사항] NATURAL JOIN(자연조인)
-- 편한걸로만 따지면 얘가 1등, 말이안됨... 뭘로 조인할지 안써도 해줌
SELECT
       EMP_NAME
     , JOB_CODE
     , JOB_NAME
  FROM
       EMPLOYEE
NATURAL
  JOIN
       JOB;
-- 17:28 운이 좋았음
-- 특정 조건이 너무 많이 붙는 애라서 잘 쓰지 않음
-- 뭐가 하나 끼어들기만 해도 와장창
-- 두 개의 테이블을 조인하는데 운 좋게도 두 개의 테이블에 일치하는 컬럼이 딱 하나있었다.
-- 과정 끝날때까지 쓸 일 없음. 이렇게 운이 좋을 수가 없음

/*
 * < Quiz >
 * 
 */
-- 사원명과 직급명을 같이 조회해주세요. 단 직급명이 대리인 사원들만 조회해주세요.
-- 내가 조회할 컬럼명이 뭐지?
-- EMP_NAME, JOB_NAME
-- EMPLOYEE, JOB
-- 두개의 테이블을 조인해야함
-- 기본적으로 문법이기 때문에 문법에 맞춰서 써야함
-- 언어공부가 다 그렇지, SQL 문법을 배우는것임(구조적 질의 언어)
-- 우리가 지금 하고 있는게 데이터베이스에 쿼리를 날리는 것, 구조적으로 잘 만들어서 날려야 결과를 잘 받을 수 있다
-- 구조적인 문법은 보면서 쓰면서 익히는수밖에없다
-- 영어 한글 문법이 다르듯이
-- 사람은 순서를 바꿔도 알아들을 수 있겠지만 컴퓨터는 못알아봄
-- SQL은 공식처럼 외워도됨

--> ORACLE문법
SELECT -- 내가 조회하고 싶은 컬럼을 싹다 씀
       EMP_NAME
     , JOB_NAME
  FROM -- 이 컬럼들이 위치한 테이블을 싹다 씀, 그대신 쉼표로 구분함
       EMPLOYEE E
     , JOB J
 WHERE -- 내가 동등비교할 컬럼을 싹다 씀, 그대신 안헷갈리게 별칭 붙여줌
       E.JOB_CODE = J.JOB_CODE -- 여기에 추가 조건이 붙었음, JOB_NAME이 ??? 얘도 만족시키고싶고
   AND
       JOB_NAME = '대리';

--> ANSI문법
SELECT -- 여기까지는 똑같음, 시원하게 내가 조회하고 싶은 컬럼 다 쓰기
       EMP_NAME
     , JOB_NAME
  FROM -- 여기에는 하나만 씀
       EMPLOYEE E
  JOIN -- JOIN 하고싶으니까, 근데 ON / USING 두개중에 하나를 골라야함, ON을 쓸거면 헷갈릴 수 있으니까 별칭을 지어줘
       JOB J ON (E.JOB_CODE = J.JOB_CODE)
 WHERE
       JOB_NAME = '대리';

-- 이걸 오라클에선 EQUAL JOIN, ANSI에서는 INNER JOIN
-- 둘다하면 좋지만 부담되면 ANSI먼저, 범용성이 높은 친구에 집중
-- 오라클만 쓰는 회사도 있는데, 다들 오라클만 쓴다 그러면 오라클 써야지.. 로마가면 로마법 따르기

-- EQUAL JOIN / INNER JOIN : 일치하지 않는 행은 애초에 ResultSet에 포함시키지 않음
-- 얘를 제일 많이 씀, 프로젝트 할때도 이거랑 포괄조인정도?
-- 팀원 6명이면 한명정도 자체조인 쓸수도있고
-- 나머지는 알고만 있으면 되는 정도

--------------------------------------------------

-- 여러 컬럼을 하나의 ResultSet으로 받을 때 JOIN을 쓰면 좋다

/*
 * 2. 포괄조인 / 외부조인(OUTER JOIN)
 * 
 * 테이블간의 JOIN 시 일치하지 않는 행도 포함시켜서 ResultSet 반환
 * 단, 반드시 LEFT / RIGHT를 지정해줘야 함!(기준 테이블을 선택해야함)
 * 
 * 어제는 INNER 안써도 INNER JOIN을 해줬음
 * OUTER JOIN은 왼쪽을 쓰든 오른쪽을 쓰든 뭐든 하나는 써야함
 * 
 */
-- EMPLOYEE테이블에 존재하는 "모든" 사원의 사원명, 부서명 조회
-- 사원명은 EMPLOYEE, 부서명은 DEPARTMENT 테이블에 있음, 두개의 테이블이 다르니까 같이 조회하려면 JOIN해야함
-- INNER JOIN
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE -- 여기까진 확정, 오라클 쓸지 ANSI 쓸지 결정
-- INNER 안써도 인식함
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- 이게 어제까지 했던거
-- 조건이 "모든" 사원이었음, EMPLOYEE 테이블은 23행인데 21행까지밖에 안나옴, 23명걸 봐야함
-- 이거 왜그럼? EMPLOYEE 테이블에서 DEPT_CODE에 부서가 없는 사람은 NULL값이 들어있으므로 일치하는 게 없어서 JOIN할 때 잘려서 못나옴
-- EMPLOYEE 테이블에서 DEPT_CODE가 NULL인 두 명의 사원은 조회 X
-- DEPARTMENT 테이블 입장에서도 마찬가지, DEPARTMENT 테이블에서 부서에 배정된 사원이 없는 부서(D3, D4, D7) 조회 X
-- 이 문제는 OUTER JOIN에서 해결할수있다
-- 오늘은 OUTER JOIN
-- 어제는 오라클 먼저 했으니 오늘은 ANSI 먼저

-- 1) LEFT [ OUTER ] JOIN : 두 테이블 중 왼편에 기술한 테이블을 기준으로 JOIN
-- 9:20 조건을 적든 컬럼명을 적음
-- 조건과는 상관없이 왼편에 기술한 테이블의 데이터는 전부 조회(일치하는 값을 못찾더라도 조회)

--> ANSI
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM
       -- EMPLOYEE 기준 테이블
       EMPLOYEE LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 한줄로 작성했다면 이렇게 생김
-- 9:25 JOIN을 기준으로 왼쪽에 있는 테이블은 다 조회함
       /*
  LEFT
-- OUTER 이걸 쓰는데 이 앞에 LEFT/RIGHT 붙어야함, 보편적으로 LEFT가(아마 RIGHT도) 붙으면 알아서 자연스럽게 OUTER, OUTER도 생략 가능
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- INNER JOIN과 똑같이 생긴 상태로 시작
*/
-- 어제 INNER JOIN과 비교하면 LEFT만 붙음, OUTER는 안쓰니까

--> ORACLE
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE, DEPARTMENT
       -- ??? 한줄로 작성했을 때 이렇게 생김, EMPLOYEE에 있는 테이블을 싹다 나오게 하고싶음
       -- 컬럼들이 DEPT_CODE는 EMPLOYEE에 있고, DEPT_TITLE은 DEPARTMENT에 있음
       -- 오라클은 헷갈림, 내가 기준으로 삼고싶지 않은 아이의 컬럼명에 (+)을 붙임
 WHERE -- JOIN절이 없으니까 WHERE절에 조건을 단다
       DEPT_CODE = DEPT_ID(+); -- 일단 INNER JOIN 작성하고나서 수정
-- 기준으로 삼지 않을 테이블의 컬럼에 (+)를 붙여준당

-- 2) RIGHT [ OUTER ] JOIN : (기준 테이블의 위치만 바뀜) 두 테이블 중 오른편에 기술한 테이블을 기준으로 JOIN
-- 일치하는 컬럼이 존재하지 않더라도 오른쪽 테이블의 데이터는 무우우조건 다 조회

--> ANSI
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
 RIGHT
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 어제 INNER JOIN에 하나 더 붙은것

-- ORACLE
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
     , DEPARTMENT
 WHERE
       DEPT_CODE(+) = DEPT_ID;
-- 보통 관계형 DBMS를 쓴다면 ORACLE 또는 MY-SQL에서 고를텐데, 다 비슷하고 번호 붙일 때(채번할때) IDENTIFIED 해서 만드는게 다름
-- 테이블 만들 때 자료형이 조금 다름, 나머지 다 똑같아서 ORACLE 하면
-- MARIADB는 MYSQL이랑 똑같아서 오라클 배우면 세개 다 똑같아서 할 수 있음
-- 오라클 구문은???????????????
-- 컬럼명 적는 순서는 바뀌어도 상관없고 이름만 잘 적으면 됨

-- 3) FULL [ OUTER ] JOIN : 두 테이블 가진 모든 행을 조회할 수 있는 조인
-- 이름만 봐도 왼쪽 오른쪽을 다 해야겠다!
--> ANSI
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
  FULL
 OUTER
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--> ORACLE : 오라클 구문에서는 사용이 불가능!!
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
     , DEPARTMENT
 WHERE
       DEPT_CODE(+) = DEPT_ID(+); -- outer-join된 테이블은 1개만 지정할 수 있습니다
-- 어제 써놨음 오라클에선X, 오라클 구문으로는 사용이 안되는 못쓰는 문법

--------------------------------------------------

/*
 * 3. 카테시안 곱(CARTESIAN PRODUCT) / 교차조인(CROSS JOIN)
 * 모든 테이블의 각 행들을 서로서로 매핑해서 조회된(곱집합), 행들을 쌍쌍바로 곱한것 ** 사용금지 문법
 * 이론 공부할때는 이렇게 해봤지만.. 이렇게 하면 안됨
 * 
 * 두 테이블의 행들이 곱해진 조합 뽑아냄 => 곱하는거기때문에 데이터가 많으면 많을수록 방대한 행이 생ㅇ겨남
 * => SELECT 한번 했는데 하루 걸리는거지... 과부하의 위험
 * 회사에서 이렇게 써버리면 아침 9시에 했는데 데이터가 2천만개씩 곱해버리면 이거하나 때려놓고 시원하게 커피마시러 가야함 아무것도 못함
 * 까딱 잘못했다가 DB서버 망가지면 누가그랬어 로그 찾아보고 난리남
 * 사용하면 안되지만 이론적으로는 알고있어야함
 * 
 */

--> ORACLE
SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT; -- 207행의 결과가 나옴, 23행 곱하기 9행 해서 각 행들의 곱해진 조합을 출력
-- 어제 ㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓ
-- 컬럼이 같은것만 조회할 수 있도록.. 이 과정 자체를 카테시안 곱이라고 부름

--> ANSI
SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE CROSS JOIN DEPARTMENT;
-- 결과는 똑같이 나옴, CROSS JOIN이라고 부름

--------------------------------------------------

/* 
 * 4. 비등가 조인(NON EQUAL JOIN)
 * 같지 않은걸 찾는건가? 싶지만 EQUAL SIGN을 안 쓰는 조인이라는 뜻..ㅎ
 * '='를 사용하지 않는 조인
 * 일치하지 않는걸 찾는게 아니고 일치하는걸 찾는건데 EQUAL SIGN을 안써서
 * 
 * 컬럼값을 비교하는 경우가 아니라 "범위"에 포함되는 내용을 매칭
 * 
 */

-- EMPLOYEE테이블로부터 사원명, 급여
SELECT
       EMP_NAME
     , SALARY
  FROM
       EMPLOYEE;

-- 테이블 중에 급여 등급을 저장하는게 있음
SELECT * FROM SAL_GRADE; -- 범위에 포함되면 등급이 나오도록 되어있음
-- 이걸 조인해서 사원들의 급여가 몇등급인지 조회해보자
-- EMPLOYEE 테이블에도 ?/ 컬럼이 있어서 별칭짓기 해야함
--> ORACLE
SELECT
       EMP_NAME
     , SALARY
     , SAL_GRADE.SAL_LEVEL
     --, MIN_SAL, MAX_SAL 으로 카테시안 곱 해서 ????????????????
  FROM
       EMPLOYEE
     , SAL_GRADE
 WHERE
       SALARY BETWEEN MIN_SAL AND MAX_SAL;

--> ANSI
SELECT
       EMP_NAME
     , SALARY
     , SAL_GRADE.SAL_LEVEL
  FROM
       EMPLOYEE
  JOIN
       SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL); -- 똑같은 이름의 컬럼을 비교하는 게 아니니까 ON구문을 써서
-- 범위에 포함된 것을 찾으면 NON EQUAL JOIN

--------------------------------------------------

-- 주로 쓰는것들, 쓰면 안되는것, 알고만 있으면 되는 것

/* 
 * 5. 자체조인(SELF JOIN)
 * 프로젝트 하면 팀에서 한명정도 한번정도.. 누군가 한명은 사용하게 되는 경우가 있음
 * 활용도가 높지는 않지만 특정 상황에서 필요한 경우가 생김
 * 
 * 같은 테이블을 다시 한 번 조인하는 경우
 * 나랑 나랑 조인하기
 * 자기자신의 테이블과 조인을 맺음
 * 
 */
SELECT
       EMP_ID "사원 번호"
     , EMP_NAME "사원 이름"
     , PHONE "전화번호"
     , MANAGER_ID "사수 사번" -- 사수가 없으면 NULL값, 사수가 있으면 사수의 정보도 같이 조회하고싶음(하나의 ResultSet에서 같이 보고있음)
     -- 사수의 정보도 EMPLOYEE 테이블에 있음, 같은 테이블
  FROM
       EMPLOYEE;

SELECT EMP_ID, EMP_NAME, PHONE, MANAGER_ID FROM EMPLOYEE; -- 사원의 정보
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE; -- 사수의 정보
-- 두 결과를 하나의 RESULTSET에서 받고싶다

--> ORACLE
-- 사원사번, 사원명, 사원 폰번호, 사수번호
-- 사수사번, 사수명, 사수 폰번호
SELECT
       E.EMP_ID, E.EMP_NAME, E.PHONE, E.MANAGER_ID -- 사원 정보
     , M.EMP_ID, M.EMP_NAME, M.PHONE -- 사수 정보
  FROM
       EMPLOYEE E,
       EMPLOYEE M -- 해석하는 입장에서 누구걸 가져오는지 구분이 안감, 테이블 명을 붙이는게 의미가 없음, 그래서 누군데? 이렇게됨 --> 별칭 --> 이렇게 하면 카테시안 곱(529개)
       -- 이거 보고싶은게 아니라 E.의 MANAGER_ID랑 M.의 EMP_ID가 같은행만 뽑아내고싶음
       -- 오라클 구문이니까 WHERE가 붙음
 WHERE
       E.MANAGER_ID = M.EMP_ID(+); -- EMPLOYEE 23명인데 15명 나옴, MANAGER_ID 없는 사원이 있음, 사수가 없어도 사원의 정보는 다 나와야함 --> OUTER JOIN --> 기준이 E니까 M에 (+)

-- ANSI
-- 똑같고 문법만 다르지, 별칭 미리 지었다고 가정하고 SELECT 구문 작성
SELECT
       E.EMP_ID, E.EMP_NAME, E.PHONE, E.MANAGER_ID,
       M.EMP_ID, M.EMP_NAME, M.PHONE
  FROM
       EMPLOYEE E
  LEFT
  JOIN
       EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

--------------------------------------------------

/*
 *  < 다중 JOIN >
 * 
 */
-- 사원명 + 부서명 + 직급명 + 지역명(LOCAL_NAME)
-- 네개의 데이터를 한번에 조회하고싶음
-- 네개가 전부 다 다른 테이블에 있음
SELECT * FROM EMPLOYEE; 	-- 사원명, EMP_NAME		DEPT_CODE	JOB_CODE
SELECT * FROM DEPARTMENT; 	-- 부서명, DEPT_TITLE		DEPT_ID					LOCATION_ID
SELECT * FROM JOB;			-- 직급명, JOB_NAME					JOB_CODE
SELECT * FROM LOCATION;		-- 지역명, LOCAL_NAME								LOCAL_CODE
-- 네개의 테이블을 조인하려면 각 테이블마다 어떤 컬럼으로 매칭시켜야 하는가를 먼저 파악해야함
-- EMPLOYEE + DEPARTMENT JOIN 시킬 연결고리 : DEPT_CODE + DEPT_ID
-- DEPARTMENT + JOB을 연결시킬것이 없음
-- EMPLOYEE + JOB을 연결시킬 것 : JOB_CODE
-- LOCATION + DEPARTMENT를 연결시킬 것 : LOCAL_CODE + LOCATION_ID
-- 누구랑 누구를 조인할지 정리해놓고 시작

-- 개발할때도 항상 먼저 정리를 먼저 하고 그다음에 시작하는것
-- 프로젝트 할 때도(나중에 하게될일) 항상 개발을 시작하기 전에 설계를 다 끝내놓고 시작해야함
-- 어떤 기능, 어떻게, 구조, SQL, 응답데이터는 어떻게 받을거고 등등 다 짜놓고 시작, 어떤 클래스 이용해서 예외처리 할지, 입력값, ㅇㄴㅇㄹㅇㄴㅇㄹ
-- 작은 프로젝트는 기획을 얼마나 세심하고 꼼꼼하게 어디까지 했느냐가 결과물 퀄리티를 좌우하미ㅣ다ㅣㅏㅓ기ㅏㅓ이ㅏㅓㅎ
-- 절대 계획대로는 안되지만 짜놓고 시작하느냐 아니냐는 차이가 큼
-- 주먹구구로 하면 안된다

-- EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
--> ANSI 구문
SELECT
       EMP_NAME
     , DEPT_TITLE
     , JOB_NAME
     , LOCAL_NAME
  FROM
       EMPLOYEE
       /*
  JOIN -- 순서를 잘 지켜야함, 앞에 있는 JOIN부터 차근차근 수행됨
       LOCATION ON (LOCATION_ID = LOCAL_CODE);*/
  LEFT
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN
       JOB USING(JOB_CODE)
  LEFT
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE); -- 이러면 나오긴 나오는데 뭔가 이상함 --> 21개 행 --> DEPARTMENT가 없는 사원이 걸러짐
-- ??? 한번더 걸러지는 곳이 있음, OUTER JOIN 한번더 해줘야함 --> LOCATION을 OUTER JOIN

-- 처음에 어떤 컬럼을 매칭시킬 지 생각하고 시작하면 쉬움, 하면서 하려면 조금 어려움

--> ORACLE
SELECT
       EMP_NAME
     , DEPT_TITLE
     , JOB_NAME
     , LOCAL_NAME
  FROM
       EMPLOYEE E
     , DEPARTMENT
     , JOB J
     , LOCATION
 WHERE
       DEPT_CODE = DEPT_ID(+)
   AND
       LOCATION_ID = LOCAL_CODE(+)
   AND
       E.JOB_CODE = J.JOB_CODE;

-- 오라클보다는 ANSI가 보기좋네..

--------------------------------------------------

/*
 * < 집합 연산자 SET OPERATOR >
 * 
 * JOIN이랑 결이 좀 다르긴 함, 수학익힘책의 벤다이어그램을 떠올려보자(합집합, 교집합, 차집합)
 * 이거 구현할 때 씀
 * 
 * 여러 개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
 * 
 * - UNION : 합집합(두 쿼리문의 수행 결과값을 더한 후 중복되는 부분을 제거)
 * - INTERSECT : 교집합(두 쿼리문의 수행 결과값 중 중복된 부분)
 * - MINUS : 차집합(선행 쿼리문 결과값 빼기 후행 쿼리문의 결과값을 한 결과)
 * 
 * 앞에 세 개 쓰잘데기 없고 이것만 기억
 * - UNION ALL : 합집합의 결과에 교집합을 더한 개념
 * (두 쿼리문을 수행한 결과값을 무조건 더함. 합집합에서 중복 제거를 하지 않는 것)
 * => 중복행이 여러 번 조회 될 수 있음
 * 
 * 원래 합집합 하면 교집합 부분은 한번만
 * A가 1,2,3 / B가 3,4,5 => 합집합 하면 1,2,3,4,5
 * 이걸 UNION ALL 하면 1,2,3,3,4,5
 * 개발자로 인생을 살다가 한번정도 이게 필요할때 쓸 수 있음
 * 
 */

-- 1. UNION
-- 부서코드가 D5인 사원들 조회
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'; -- 박세혁, 박수현, 박채형, 박현준, 배주영, 유성현(6행)

-- 급여가 300만원 초과인 사원들
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000; -- 이승철, 강병준, 강현성, 박성민, 박현준, 유성현, 채정민, 신국희(8행)

-- 두개의 쿼리 결과를 합치고싶다!
-- UNION 사용!
-- 6행짜리를 복사해서 붙여넣기를 하고 8행짜리를 복사해서 붙여넣기를 하고, 두개(쿼리와 쿼리)의 사이에 UNION을 적음
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 UNION
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000;
-- D5이거나 300 초과인것을 찾고싶은것, 중복된것은 날아가고 나머지를 합쳐서 조회됨
-- 박현준, 유성현 사원 중복이니까 합친거 14행에서 2행 뺀 12행 출력
-- 사실 쓰잘데기없음 그냥 OR 쓰면 되잖앙....
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
    OR
       SALARY > 3000000;
-- UNION쓰려면 SELECT절에 기술하는 컬럼이 같아야함

-- 부서코드가 D1, D2, D5인 부서의 급여합계를 조회하고 싶다
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D1'
 UNION
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D2'
 UNION
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5';

SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE IN ('D1', 'D2', 'D5')
 GROUP BY DEPT_CODE;
-- UNION은 OR나 IN으로 대체할 수 있다.. 별로임
-- 아 테이블 설계가 잘못된 거 아닌가? 또는 OR/IN으로 바꿀 수 있는데 왜이렇게 썼지?
-- 별로인거 왜함? 이런거 볼수도 있고.. UNION ALL 의 선행지식이라서

--------------------------------------------------

-- 2. UNION ALL : 여러 개의 쿼리 결과를 무조건 합치는 연산자(중복 가능)
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 UNION
   ALL
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000;
-- 얘는 대체불가
-- 중복 지원/당첨 이런거 잡아낼때 사용할수밖에없음

--------------------------------------------------

-- 3. INTERSECT (교집합 - 여러 쿼리 결과의 중복된 결과만을 조회)
-- 앞뒤쿼리 겹치는것만 조회.. 사실 별로임 겹치는거 보고싶으면 AND 쓰면됨
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
INTERSECT
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000;

-- AND
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
   AND
       SALARY > 3000000;

--------------------------------------------------

-- 4. MINUS (차집합 - 선행쿼리 결과에서 후행 쿼리결과를 뺀 나머지)
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 MINUS
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000; -- 6개에서 중복된 2개 빼서 4개 나옴
-- 이건 다른 친구가 이 역할을 하기 어려움
-- 근데 별로임ㅋ 얘만 빼고싶으면 SALARY 조건 꺼꾸로 쓰면 되징(와 관점의 전환 생각의 전환 이거 뭐임???)
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
   AND
       SALARY <= 3000000;

-- 아무튼 UNION ALL만 기억

--------------------------------------------------