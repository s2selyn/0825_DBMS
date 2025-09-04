-- < JOIN ORACLE 구문 사용 >

-- 1. 회원 전체 조회(사번, 사원명, 급여, 부서명, 직급명)
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , DEPT_TITLE
     , JOB_NAME
  FROM
       EMPLOYEE E
     , JOB J
     , DEPARTMENT D
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND
       E.DEPT_CODE = D.DEPT_ID(+);

-- 2. 부서명을 입력받아 부서가 동일한 사원 조회(총무부 입력시 총무부인 사원들만 조회되도록)
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , DEPT_TITLE
     , JOB_NAME
  FROM
       EMPLOYEE E
     , JOB J
     , DEPARTMENT D
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND
       E.DEPT_CODE = D.DEPT_ID(+)
   AND
       D.DEPT_TITLE = '사용자가 입력한 부서명' -- pstmt binding
 ORDER
    BY
       HIRE_DATE DESC;

-- 3. 직급명을 입력받아 직급이 동일한 사원 조회(과장 입력시 과장인 사원들만 조회되도록)
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , DEPT_TITLE
     , JOB_NAME
  FROM
       EMPLOYEE E
     , JOB J
     , DEPARTMENT D
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND
       E.DEPT_CODE = D.DEPT_ID(+)
   AND
       J.JOB_NAME = '사용자가 입력한 직급명' -- pstmt binding
 ORDER
    BY
       HIRE_DATE DESC;

-- 4. 사원 상세 조회(사번을 입력받아서 모든 컬럼 값 조회)
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , DEPT_TITLE
     , JOB_NAME
  FROM
       EMPLOYEE E
     , JOB J
     , DEPARTMENT D
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND
       E.DEPT_CODE = D.DEPT_ID(+)
   AND
       E.EMP_ID = '사용자가 입력한 사번' -- pstmt binding
 ORDER
    BY
       HIRE_DATE DESC;

-- 5, 6은 서브쿼리 인라인뷰(클래식)
-- 5. 급여가 높은 상위 다섯명 조회
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , DEPT_TITLE
     , JOB_NAME
  FROM
       (SELECT
		       EMP_ID
		     , EMP_NAME
		     , SALARY
		     , DEPT_TITLE
		     , JOB_NAME
	      FROM
		       EMPLOYEE E
		     , JOB J
		     , DEPARTMENT D
		 WHERE
		       E.JOB_CODE = J.JOB_CODE
		   AND
		       E.DEPT_CODE = D.DEPT_ID(+)
		 ORDER
		    BY
		       SALARY DESC
       )
 WHERE
       ROWNUM <= 5;

-- 6. 급여가 낮은 하위 다섯명 조회
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , DEPT_TITLE
     , JOB_NAME
  FROM
       (SELECT
		       EMP_ID
		     , EMP_NAME
		     , SALARY
		     , DEPT_TITLE
		     , JOB_NAME
	      FROM
		       EMPLOYEE E
		     , JOB J
		     , DEPARTMENT D
		 WHERE
		       E.JOB_CODE = J.JOB_CODE
		   AND
		       E.DEPT_CODE = D.DEPT_ID(+)
		 ORDER
		    BY
		       SALARY ASC
       )
 WHERE
       ROWNUM <= 5;

-- 7. 사원 추가
INSERT
  INTO
       EMPLOYEE
VALUES
       (
       -- 사번 입력받음?
     , -- 사원명
     , -- 주민번호
     , -- 이메일
     , -- 전화번호
     , -- 부서코드
     , -- 직급코드
     , -- 급여등급
     , -- 급여
     , -- 보너스율
     , -- 사수 사번
     , -- 입사일
     , -- 퇴사일
     , -- 퇴사여부
       );

-- 8. 사원 정보 수정(사번을 입력받아 급여, 직급, 부서 수정)
UPDATE
       EMPLOYEE
   SET
       SALARY = 0 -- 바꿀 값
     , JOB_CODE = 'J1' -- 바꿀 직급코드
     , DEPT_CODE = 'D1' -- 바꿀 부서코드
 WHERE
       EMP_ID = '사용자가 입력한 사번'; -- pstmt binding

-- 9. 사원 퇴사 기능(사번을 입력받아 퇴사 여부, 퇴사일 수정)
UPDATE
       EMPLOYEE
   SET
       ENT_YN = 'Y'
     , ENT_DATE = SYSDATE
 WHERE
       EMP_ID = '사용자가 입력한 사번'; -- pstmt binding