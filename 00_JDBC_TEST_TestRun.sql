-- JDBC_WORKSPACE에서 실습용 테이블 만들기 위해서 넘어왔음

CREATE TABLE TB_STUDENT(
    STUDENT_ID NUMBER PRIMARY KEY, -- PK 컬럼하나(사람식별을위한번호), 넘버
    STUDENT_NAME NVARCHAR2(5) NOT NULL, -- 이름 하나, 문자
    ENROLL_DATE DATE NOT NULL -- 날짜 하나, DATE, DEFAULT는 넣지 말자, 직접 기술하고싶으니까 NOT NULL
    -- 과감하게 시퀀스는 넘기고 자기가 입력하는걸로 하자
);

-- 더미데이터 하나씩만 넣어놓자
INSERT
  INTO
       TB_STUDENT
VALUES
       ( -- 컬럼의 순서와 자료형에 맞게
       1
     , '홍길동'
     , SYSDATE
       );

COMMIT;

SELECT * FROM TB_STUDENT;

SELECT
       STUDENT_ID
     , STUDENT_NAME
     , ENROLL_DATE
 FROM
      TB_STUDENT
      -- 그냥 이상태로 하면 정렬이 안된 상태로 돌아옴, 별로 안좋음, 내가 고객이면 아 왜이렇게 해놨어 정렬좀 해주지 하겠지
      -- 항상 ORDER BY 써서 정렬해야함
ORDER
   BY
      ENROLL_DATE DESC;
      -- 이런 경우에 보통 날짜로 함, 왜 날짜로 하냐면 지금은 PK를 시퀀스로 만드는데 나중에는 난수를 써서 만들어낼거임
      -- 나중에 들어간 친구가 이 난수가 더 크다고 보장할 수 없음, 임의의 수니까
      -- 실무에서 사용할때는 숫자가 더 길고, 몇개 만들어질지 모름, 날짜로 쓰면 들어온 순서대로 들어가서 명확하니까 이걸 사용함
      -- 조회할 때 보통 최신이 먼저 나오게 해주니까 기본 오름차순 말고 내림차순으로
-- 이거 자바에서 쓰려면 자료형 String