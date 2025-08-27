/*
 * < DML : DATA MANIPULATION LANGUAGE >
 * 데이터 조작 언어
 * 
 * INSERT / UPDATE / DELETE(SELECT는 사흘저옫 했는데, 이거세개는 뭐 세시간이면 할지도..)
 * 논외 ) SELECT : 나는..? DML(신토불이) / DQL(요새)
 * 클래식은 SELECT를 DML에 껴줌, 모던은 SELECT를 DATA QUERY LANGUAGE(DQL)로 빼서 분류해버림
 * SELECT의 비중이 엄청 커짐, 데이터에 변화가 일어나지는 않음, 의미론적으로도 좀 껴주기 그럼..
 * MANIPULATION의 의미는 테이블의 값 자체가 조작되는것
 * ㅋㅋ 분명히 회사가서 기술면접 보면 DML 종류 물어보겠지? 뭐라고해야함?
 * DML에 포함되기도 하는데, 요새는 DQL로 따로 분류하기도 합니다.. 뭐 이런식으로 정갈하게 대답하쇼
 * 물어보는 사람 나이(? ㅋㅋ) 의도에 따라 뭐 답이 달라질수도
 * 아무튼 DML + DQL이라고도 합니다
 * 
 * INSERT / UPDATE / DELETE
 * 
 * 테이블에 새로운 데이터를 삽입(INSERT)하거나,
 * 테이블에 존재하는 데이터를 수정(UPDATE)하거나,
 * 테이블에 존재하는 데이터를 삭제(DELETE)하는 구문
 * 
 * 사용했을 때 중요한 것은, 테이블에 있는 값이 변동되어야함, 테이블 안에 값이 변화가 일어나야함
 * 
 */

/*
 * 1. INSERT : 테이블에 새로운 행을 추가해주는 구문
 * 뭐든지 행단위! 행이 중요
 * 
 * [ 표현법 ]
 * 
 * 1) INSERT INTO 테이블명 VALUES (값, 값, 값, ...);
 * 
 * => 해당 테이블에 모든 컬럼에 추가하고자 하는 값을 직접 입력해서 한 행을 INSERT할 때 사용
 * ※ 주의할 점 : 값의 순서를 꼭 컬럼의 순서와 동일하게 작성해야 함
 * 
 */
SELECT * FROM EMPLOYEE;

-- 행단위, 한 줄이 들어가야함
INSERT INTO EMPLOYEE VALUES ('김태호'); -- 이름만 넣을건데? 이럴 순 없음
-- 컬럼의 개수만큼 데이터를 작성해야함
-- 이렇게 말고 예쁘게 쓰자~
INSERT
  INTO
       EMPLOYEE
VALUES
       ( -- 테이블의 컬럼 순서대로, 개수만큼 작성해야함
       223
     , '김태호'
     , '991231-9999999'
     , 'kth04@kh.or.kr'
     , '01004044040'
     , 'D9'
     , 'J5'
     , 'S4'
     , 5000000
     , NULL
     , NULL
     , SYSDATE
     , NULL
     , 'N'
       );
-- 지금은 우리가 이렇게 맘대로 썼음, 실제로는 이클립스 켜서 입력받겠지?
-- 입력받은것을 이 자리에 들어가게 할것임,, 그래야 입력받은걸 테이블에 넣겠지
-- 실제로는 자바로 만든 프로그램을 실행시켜서 서비스 메세지 출력하고 스캐너로 입력받고 INSERT에 여기 넣어서 테이블에 들어가게 하겠다는게 우리 목표
-- 이게 정석적인 방법임

-- 들어갔는지 확인해보자
SELECT * FROM EMPLOYEE WHERE EMP_ID = 223;

-- 테이블을 어떻게 만드느냐에 따라서 값을 입력 안하고 생략할수도 있음
-- 기본값이 들어가는 컬럼(디폴트 어쩌고)이나, Not Null에 체크가 안된 컬럼(null-able?) 이런것들에 따라서
/*
 * 2) INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명) VALUEW(값, 값, 값);
 * => 테이블 특정 컬럼만 선택해서 컬럼에 값을 추가하면서 행을 추가할 때 사용
 * INSERT는 무조건 한 행 단위로 추가가 되기 때문에 작성하지 않은 컬럼은 NULL값이 들어감
 * 
 * NULL 값이 들어갈수 있냐없냐를 테이블을 만들때 지정함
 * NOT NULL에 체크되어 있으면 무조건 값 넣어줘야함
 * 
 * 주의할 점 ) NOT NULL이 달려있는 컬럼은 반드시 테이블 명 뒤에 컬럼명을 적어야함
 * 예외 사항 ) NOT NULL제약조건이 달려있는데 기본값이 있는경우는 DEFAULT VALUE가 들어감
 * 
 */ 
INSERT
  INTO
       EMPLOYEE
       ( -- NOT NULL 체크된 애들 골라옴
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , JOB_CODE
     , SAL_LEVEL
       )
VALUES
       (
       900
     , '고길동'
     , '770909-0909090'
     , 'J5'
     , 'S1'
       );

SELECT * FROM EMPLOYEE;

--------------------------------------------------

/*
 * 3) INSERT INTO 테이블명 (서브쿼리);
 * => VALUES 대신에 서브쿼리를 작성해서 INSERT 할 수 있음
 * 
 */
-- 이런거 배워서 안좋을건없지~
-- 새 테이블 하나 만들기
CREATE TABLE  EMP_01(
  EMP_NAME VARCHAR2(20),
  DEPT_TITLE VARCHAR2(20)
); -- 이렇게 만들면 데이터 중복이라 안좋지만 배울 용도로 이런게 있다 하고 만들어봄~

SELECT * FROM EMP_01;
-- 기존에는 JOIN 해야하기도 하고, 서브쿼리로 INSERT 해보고 싶어서 만들어봄^^!
-- EMPLOYEE테이블에 존재하는 모든 사원 사원명과, 부서명을 새로만든 EMP_01에 INSERT
INSERT
  INTO
       EMP_01
       (
       SELECT
              EMP_NAME
            , DEPT_TITLE
         FROM
              EMPLOYEE
            , DEPARTMENT
        WHERE
              DEPT_CODE = DEPT_ID(+)
       );
SELECT * FROM EMP_01; -- 데이터 중복이니까 좋은 방식은 아니지만 이렇게도 할 수 있다

--------------------------------------------------

-- INSERT에서 이렇게 쓸만한게 3개정도 있긴하고, DB책에는 나와있는데 실제로는?
-- 그냥 실전압축ㄱㄱ
/*
 * 4) INSERT ALL ☆★☆ 굉장히 활용도가 높은 친구
 * 하나의 테이블에 여러 행을 한꺼번에 INSERT 할 때 사용
 *  INSERT ALL
 *    INTO 테이블명 VALUES(값, 값, 값 ...)
 *    INTO 테이블명 VALUES(값, 값, 값 ...) -- 넣고싶은만큼 INTO절 추가
 *  SELECT *
 *    FROM DUAL;
 * 
 */
-- 원래 여러 행을 넣으려면?
INSERT INTO EMP_01 VALUES('사원1', '부서1');
INSERT INTO EMP_01 VALUES('사원2', '부서2');
-- ...
-- 이렇게 쓰고 각각 실행해야함
SELECT * FROM EMP_01;
INSERT INTO EMP_01 VALUES('사원3', '부서3'); -- UPDATED ROWS 1, EXECUTE TIME 0.002S, 이게 DB서버의 응답이 온 것
-- EXECUTE TIME은 INSERT하는데 걸린 시간, 사실 별로 중요한게 아니고
-- 중요한건 UPDATED ROWS, 처리결과가 왔는데, UPDATED ROWS 해서 얼마나 많은 행에 작업이 수행되었는지가 돌아왔음
-- INSERT를 한 줄 한거지, VALUE가 1이 돌아옴, 정수값 1, 1행을 INSERT했더니 정수값 1이 돌아왔다

INSERT
   ALL
       INTO EMP_01 VALUES('사원4', '부서4')
       INTO EMP_01 VALUES('사원5', '부서5')
       INTO EMP_01 VALUES('사원6', '부서6')
SELECT
       *
  FROM
       DUAL; -- INSERT ALL 은 항상 SELECT * FROM DUAL이 붙어야함
-- UPDATED ROWS 3이 중요함, 3개의 행을 INSERT했더니 정수값 3을 돌려줌
-- 1행 INSERT는 1, 3행 INSERT는 3이 돌아옴, 성공적으로 작업이 처리되었다는 가정 하에 INSERT 한 만큼 이 값이 돌아옴

--------------------------------------------------

/*
 * 2. UPDATE
 * 테이블에 기록된 기존의 데이터를 수정하는 구문
 * 
 * [ 표현법 ]
 * UPDATE
 *        테이블명 -- 내가 업데이트하고싶은데이터가존재하는테이블명
 *    SET -- 자바에서는 뭐 썼더라? SET
 *        컬럼명 = 바꿀값 -- 바꾸고 싶은 컬럼이 여러개면 쉼표로 구분해서 여러개 작성
 *      , 컬럼명 = 바꿀값
 *      , ... => 여러 개의 컬럼값을 바꿀 수 있음(,써야함! AND아님!! AND아님!!!!!)
 *  WHERE
 *        조건식; => 생략 가능(조건식은 쓸수도있고 안쓸수도있음)
 * 
 */

-- 테이블 복사하기, 서브쿼리 써서 복사하면됨
CREATE TABLE DEPT_COPY
    AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- 복사한 테이블에서 데이터를 수정해보자
-- DEPT_COPY 테이블에서 총무부의 부서명을 미래사업부로 변경
-- 데이터를 바꾸고싶은거니까 UPDATE문을 사용
UPDATE
       DEPT_COPY
   SET
       DEPT_TITLE = '미래사업부'; -- 그냥 실행했는데 UPDATED ROWS 9가 돌아옴, 업데이트가 9개 행이 되었어

SELECT * FROM DEPT_COPY; -- 모든 행이 미래사업부로 바뀌어버렸음
-- 전체 행의 모든 DEPT_TITLE 컬럼 값이 전부 미래사업부로 UPDATE
-- 그래서 UPDATE ROWS가 9로 돌아온것

-- 우리가 하고싶었던건 이게아님,, 돌려돌려 해야함

ROLLBACK; -- 아...오토커밋...아... 안돌아가네요 ㅎ

-- 시원하게 DEPT_COPY2를 만듭시다
CREATE TABLE DEPT_COPY2
    AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY2;
-- 정말로 총무부만 미래사업부로 바꿔보자
-- UPDATE는 아까랑 똑같음
UPDATE
       DEPT_COPY2
   SET
       DEPT_TITLE = '미래사업부'
 WHERE -- 생략도 가능하지만 기본적으로 조건이 붙음, 특정 행만 바꾸고싶은거니까
       DEPT_TITLE = '총무부'; -- 이렇게 하면 UPDATED ROWS 1이 돌아옴

SELECT * FROM DEPT_COPY2;

-- 원래 뭐 해야됨? 커밋으로 뭐??

-- 어떤 상황에 WHERE가 필요없을까?
-- 메일주소 전체 뒷부분 바꾸기, 전체 사원들 급여를 기존급여에서 5%인상해
UPDATE
       EMPLOYEE
   SET
       SALARY = 100
 WHERE
       -- EMP_NAME = '김하늘' 이거 올바른 방법은 아님, 김하늘이라는 이름의 사원이 분명히 동명이인이 있을 수 있음, 겹치지 않는(중복되지 않는) 값으로 해줘야함
       EMP_ID = 204;

-- 전체 사원들 급여를 기존급여에서 5%인상해
UPDATE
       EMPLOYEE
   SET
       SALARY = SALARY * 1.05;

SELECT * FROM EMPLOYEE;

--------------------------------------------------

/*
 * UPDATE 사용시 서브쿼리 사용해보기
 * 
 * UPDATE
 *        테이블명
 *    SET
 *        컬럼명 = (서브쿼리)
 *  WHERE -- 생략가능
 *        조건;
 * 
 */
-- 안예성 사원의 급여를 김하늘 사원의 급여만큼으로 갱신
UPDATE
       EMPLOYEE
   SET
       SALARY = (SELECT -- 보면 보이지만 데이터가 바뀔수도 있고 데이터가 많아서 찾기 힘들수도 있으니 이 자리에 서브쿼리를 작성해보자
                        SALARY
                   FROM
                        EMPLOYEE
                  WHERE
                        EMP_NAME = '김하늘')
 WHERE
       EMP_ID = (SELECT -- 동명이인이 있을 수 있음
                        EMP_ID
                   FROM
                        EMPLOYEE
                  WHERE
                        EMP_NAME = '안예성');
-- SET, WHERE 둘 다 = 를 쓰고있음
-- SET에서는 대입의 용도로 사용되었고
-- WHERE에서는 비교(동등비교)의 용도로 사용되었음
-- 둘다 서브쿼리절에 의미가 있음, 동명이인이 생길 수 있음
-- 쿼리 연산자를 동등비교로 써놨는데, 이거 쓸 수 있는건 단일행 서브쿼리여야 비교가능함
-- EMP_ID로 조회했는데 이름이 똑같아서 다중행으로 조회되면 UPDATE문이 수행안될것임
-- ??? 고유성 보장 가능

-- 잘 바뀌었는지 확인
SELECT * FROM EMPLOYEE;

--------------------------------------------------

/*
 * 3. DELETE
 * 테이블에 기록된 행을 삭제하는 구문
 * 
 * [ 표현법 ]
 *  DELETE
 *    FROM
 *         테이블명
 *   WHERE
 *         조건; => 생략가능
 * 
 * WHERE 조건절을 작성하지 않으면 모든 행 삭제 -- 업데이트랑 똑같음, 조건절 안적으면 모든행 삭제됨
 * 
 */
SELECT * FROM DEPT_COPY2;

-- 미래사업부 없애버리자
DELETE
  FROM
       DEPT_COPY2
 WHERE
       DEPT_TITLE = '미래사업부'; -- UPDATED ROWS 1이 돌아옴, 하나만 날아간건가? 확인해봐야함

SELECT * FROM DEPT_COPY2;

--------------------------------------------------

-- 싹날리기 방법 2개있음
/*
 * * TRUNCATE : 테이블의 전체 행을 삭제하는 사용하는 구문(절삭)
 * 				DELETE보다 빠름(이론적으로)
 * 				별도의 조건을 부여할 수 없음 ROLLBACK불가능!
 * 
 */

-- 진짜 빠른지 두개 비교
DELETE FROM DEPT_COPY; -- 0.004S
TRUNCATE TABLE DEPT_COPY2; -- 0.027S
-- ??? ㅎㅎ... 이론적으로...
-- 우리는 DB서버와의 물리적 위치가 너무 가깝고 지우려고 하는 데이터가 적었음(10개도안됨)
-- 지울게 수만개다? 수십만개다? 이러면 유의미적 차이가 날 수 도 ? 그럴일은 우리없음 그래서 이론적으로 ㅎ 살리기도 안되고 옵션도 안돼서