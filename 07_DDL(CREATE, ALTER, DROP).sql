/*
 * * DDL(DATA DEFINITION LANGUAGE) : 데이터 정의 언어
 * 
 * (데이터의) 구조자체를 정의하는 언어로 주로 DB관리자, 설계자가 사용함(개발자가 쓸일은 별로 없고)
 * 
 * DML은 데이터를 조작, DDL은 데이터를 조작할 수 있는 구조(오라클에서의 객체)
 * 오라클에서 제공하는 객체(OBJECT)를
 * 새롭게 만들고(CREATE), 구조를 변경하고(ALTER), 구조를 삭제하고(DROP)하는 명령어
 * 
 * DDL : CREATE, ALTER, DROP
 * 
 * 오라클의 객체(구조) : 테이블(TABLE), 사용자(USER, 안해볼거임), 뷰(VIEW), 시퀀스(SEQUENCE)
 * 				   , 인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER)
 * 				   , 프로시저(PRECEDURE), 함수(FUNCTION), 동의어(SYNONYM) ...
 * 
 * DQL : SELECT => 질의
 * DML : INSERT / UPDATE / DELETE => 데이터를 조작
 * DDL : CREATE / ALTER / DROP => 구조 조작
 * 
 */

/*
 * < CREATE TABLE >
 * 
 * 테이블이란? : 행(ROW), 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
 * 관계형 데이터베이스는 모든 데이터를 테이블 형태로 저장함('모든'이 핵심)
 * (데이터를 보관하고자 하면 반드시 테이블이 존재해야함!!)
 * 
 * 9:20 DB에 데이터를 저장하지만, 실제 운영체제상에서는 파일로 저장됨, 컴퓨터(물리적 저장장치)에 데이터를 기록한다는 것(메모장 열어서 다른이름으로 저장하는거랑 다를게없음)
 * 저장하는 매체(시스템)이 메모장에서 데이터베이스라는 프로그램으로 바뀐것
 * DBMS는 데이터를 관리(저장) 할 때 테이블의 형태로 저장함, 읽어올때도 테이블의 형태로
 * 
 * [ 표현법 ]
 * CREATE TABLE TB_테이블명 ( -- 테이블 선언(정의) 영역
 *   컬럼명 자료형,
 *   컬럼명 자료형,
 *   컬럼명 자료형,
 *   ...
 * );
 * 
 * 오라클 객체 종류가 많음.. 나중에 쓸 때 테이블인지 뭔지 구분이 안감, 보편적으로 테이블을 만들때 보통 접두사를 붙임 --> TB_
 * 자바에서도 해봤지만 데이터의 형태가 중요함, 테이블 만들 때 붙이는 컬럼명(조회할때 나오는 첫줄)
 * 
 * < 자료형 > (밑도끝도없이 많으니까 우리 필요한것만)
 * 
 * - 문자(CHAR(크기) / VARCHAR2(크기) / NVARCHAR2(크기)) : 크기는 BYTE단위
 * 														(NVARCHAR는 예외)
 * 
 * 									숫자, 영문자, 특수문자 => 1글자당 1BYTE
 * 									한글, 일본어, 중국어  => 1글자당 3BYTE
 * 제일 많이 쓰는 자료형, 크기는 내가 어느정도의 공간을 만들겠다는 뜻
 * 1글자당 BYTE크기를 잘 생각해서 만들어야함, 안그러면 테이블 지웠다가 새로만들고.. 근데 그럴 일 다반사
 * 
 *  - CHAR(바이트크기) : 최대 2000BYTE까지 저장가능
 * 					  고정길이(아무리 작은 값이 들어와도 공백으로 채워서 크기 유지)
 * 					  주로 들어올 값의 글자수가 정해져 있을 경우
 * 					  예) 성별 M/F
 * 
 * 자바랑은 배포부터 다름, 오라클은 DB 저장하려고 있는 애니까
 * 2000 지정해놓고 1 썼으면 나머지 1999 낭비됨
 * 해시코드 돌리거나 암호화했다든지 주민번호, 휴대폰번호는 길이가 고정되어 있으니 이런거
 * 
 *  - VARCHAR2(바이트크기) : VAR는 '가변'을 의미, 2는 '2배'를 의미
 * 						  최대 4000BYTE까지 지정 가능
 * 						  가변길이(적은값이 들어오면 맞춰서 크기가 줄어듬)
 * 						  --> CLOB, BLOB(4000 했는데 부족하면 이런거 쓸수는 있지만 그런 경우가 있을리가..?)
 * 
 * VAR 어디서 봤나요? 변수(VARI ABLE, 변할 수 있는)
 * CHAR는 고정, VAR는 가변
 * 4000 지정해놓고 실제 데이터 1 넣어도 길이가 줄어듬, 가변길이, 낭비가 없음
 * 웬만하면 낭비가 안되니까 이게 좋겠지? 그래도 크기가 줄어드는데 시간이 걸릴테니 사용 용도에 따라서
 * 
 *  - NVARCHAR2(N) : 가변길이, 선언방식(N) --> N : 최대 문자 수
 * 					 다국어 지원 아주 화끈함 완전 지원(세상천지어디나라를쓰든)
 * 					 (단점) VARCHAR2보다 성능이 떨어질 수 있음(나는 성능충이다~ 이럼 VARCHAR2, 나는 글로벌할거야~ 이럼 NVARCHAR2)
 * 
 * CHAR, VARCHAR2 꼬졌어요 너모 오래됨(너무 영어 특화)
 * 이모지, 고대 히브리어 이런거 넣으면 깨질수있음, NVARCHAR는 이런거 다 넣을 수 잇는 초 좋은 자료형
 * 크기가 아니라 4000을 지정했으면 지정한 4000 글자까지
 * 다국어 지원 가능, 오라클이 큰맘먹고 내놓음(?)
 * 
 * - 숫자(NUMBER) : 정수 / 실수 상관없이 NUMBER
 * 
 * - 날짜(DATE)
 * 
 */

--> 회원의 정보(아이디, 비밀번호, 이름, 회원가입일)를 담기위한 테이블 만들기
-- 테이블은 데이터를 담기 위한 구조
-- 키워드는 식별자로 사용할 수 없음, 너무 USER라고 만들고싶다면 앞에 키워드 TB_달아주기, 근데 이것도 권장하는 방법은 아님
CREATE TABLE TB_USER( -- USER라는 친구는 오라클에서 키워드로 사용됨, 자바에서도 메소드명 PUBLIC 이런걸로 만들수 없던거랑 똑같음, 키워드로 되있는거는 테이블명이나 컬럼명으로 사용할 수 없음
	-- 컬럼명 자료형 쓸건데, 오라클도 네이밍 컨벤션이 있음, 자바에선 userId라고 했겠지? 여기에선 상수필드처럼 다 대문자로, 근데 단어가 합쳐진거 구분하려면 가운데를 언더바로
	USER_ID VARCHAR2(20), -- 이 컬럼에 내가 저장할 값이 어떤 모양새와 길이를 가질지 생각해야함, 아이디는 보통 user01, admin 이렇게 생겼겠지? 사람마다 아이디 길이가 다를테니 길이를 특정할 수 없음, CHAR는 탈락
	-- VARCHAR2, NVARCHAR2 둘중에 고르겠지? 근데 보통 아이디는 한글 이런거 못넣게 할테니까 VARCHAR2
	-- 최대 몇 BYTE 받을것이냐? 아이디는 만드는 사람 마음이겠지? 영어숫자특수문자로 만들텐데 일단 최대 20
	-- 비밀번호 저장할 컬럼 만들자, 이름 짓기 어려우면 구글에 변수명 짓기 사이트 검색 ㄱㄱ 단어 네개 넘어가면 잘못지었어 해석하기 어려움
	-- USER_PASSWORD 의미도 명확하고 좋은데 ID 줄였으니 이거도 줄이자 안그럼 ID 섭섭함
	USER_PWD VARCHAR2(20), -- 비밀번호 몇글자? 영어로 저장할거고 사람마다 다를거니까
	-- 이름을 저장할 컬럼도 만들자
	USER_NAME NVARCHAR2(30), -- 자료형은 이름을 영어로만 받을건지 한글로 받을건지 아랍어로 받을건지, 보통 뭘로 적든 풀어주는 느낌이니까 NVARCHAR2, 어차피 가변 길이니까 넉넉하게
	ENROLL_DATE DATE -- 가입일 초까지, 회원가입 밀리초까지 받을 필요는 없겠지, 이게 필요하면 TIMESTAMP 쓰면되고
);

SELECT * FROM TB_USER; -- 잘 만들어졌는지 확인
-- 이 세션에서 만들어서 없다고 빨간줄인데 방금 만들어서 같은 세션이라 인식 못하는것

/*
 * 컬럼에 주석 달기 == 설명 다는 법
 * 
 * COMMENT ON COLUMN 테이블명.컬럼명 IS '설명'
 * 
 */

COMMENT ON COLUMN TB_USER.USER_ID IS '회원아이디';

SELECT * FROM USER_TABLES;
-- 현재 이 계정이 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있음
-- 오라클은 모든 데이터를 테이블 형태로 저장함
-- 이건 현재 접속한 내 계정이 가진 테이블의 구조, 테이블의 구조도 테이블로 저장됨

SELECT * FROM USER_TAB_COLUMNS;
-- 현재 이 계정이 가지고 있는 테이블들의 모든 컬럼의 정보를 조회할 수 있음
-- 10:13 현재...엉?
-- 이것도 테이블로 저장
-- 그시절에는 이게 효율적이라고 생각했나보죠. 지금은 효율적이 아니라고 판명난 상태??

-- 데이터 딕셔너리 : 객체들의 정보를 저장하고 있는 시스템 테이블
-- 사실 자바랑 관계형 DB가 잘 안맞음
-- 자바는 데이터를 객체로 저장하는게 목적이고 관계형 데이터베이스는 데이터를 테이블로 저장하는게 목적임
-- 객체랑 테이블이기때문에 두개가 호환이 잘 안됨, 안맞다고 이미 결론이 났음 땅땅땅 몇십년전에
-- 이걸 가지고 처음 개발하던 시점에는 선택지가 없었음, 이렇게 몇십년을 하고나니까 기존의 구조를 바꿀 수 없어서 어쩔 수 없이 이걸 쓰고있음
-- 다들 안좋은거 알고 별로라는걸 알지만 쓰고있음 기존의 것을 싹 갈아엎을수가 없음... 이걸 LEGACY하다고 함. 이걸로 쭉 가는거지뭐

-- 어쨌든 테이블을 만들었으니까 이 테이블에 데이터를 추가해보자
-- 테이블에 데이터를 추가
-- 어제 배운 DML 중에서 뭘 써야함? INSERT
-- INSERT
INSERT
  INTO
       TB_USER
VALUES
       ( -- 컬럼의 순서대로
       'user01'
     , '1234'
     , '관리자'
     , '2025-08-27' -- 오라클에서 날짜 쓸 때 날짜 형식만 맞춰서 문자열로 쓰면 됨
       ); -- Updated Rows 1

INSERT INTO TB_USER VALUES('user01', 'pass01', '이승철', '25/08/27'); -- 날짜 이런식으로 쓸수도있음
INSERT INTO TB_USER VALUES('user02', 'pass02', '홍길동', SYSDATE); -- 이렇게도 가능

SELECT * FROM TB_USER;

-- 오토 끄자, 윈도우 > 환경설정 > 연결 > 연결유형 > AUTO-COMMIT BY DEFAULT 체크해제

--------------------------------------------------

-- 우리가 만든 테이블에 문제가 있음
INSERT INTO TB_USER VALUES(NULL, NULL, NULL, SYSDATE);
-- 10:22 회원이 한명 가입했다는 얘기인데 NULL?
-- 최소한 아이디와 비밀번호 컬럼에는 NULL값이 들어가선 안됨!

INSERT INTO TB_USER VALUES('user02', 'pass03', '고길동', SYSDATE);
-- 이것도 너무 잘됨!
-- 일반적으로 생각했을 때 중복된 아이디값은 존재해선 안됨!

-- NULL값이나 중복된 아이디값은 유효하지 않은 값들
-- 유효한 데이터값을 유지하기 위해서는 (테이블에) 제약조건을 걸어줘야함

SELECT * FROM TB_USER;
-- 우리의 테이블은 지금 매우 널널함...

--------------------------------------------------

/*
 * < 제약 조건 CONSTRAINT >
 * 
 * - 테이블에 유효한 데이터값만 유지하기 위해서 특정 컬럼마다 제약 == 데이터 무결성 보장을 목적으로 함(고급지게 얘기하기)
 * - 제약조건을 부여하면 데이터를 INSERT / UPDATE할 때마다 제약조건에 위배되지 않는지 검사
 * 
 * 오라클에 제약조건 5가지 있음
 * - 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
 * 
 * - 제약조건을 부여하는 방법 : 컬럼 레벨 / 테이블 레벨
 * 
 */

/*
 * 1. NOT NULL 제약조건(이름만 봐도..)
 * 해당 컬럼에 반드시 값이 존재해야 할 경우 사용(NULL값을 막는다)
 * INSERT / UPDATE 시 NULL값을 허용하지 않도록 제한
 * 
 * NOT NULL제약조건은 컬럼레벨 방식으로만 부여할 수 있음
 * 
 */

-- 앞에서 테이블 만들어 봤으니까 규모 키워서 만들어보자
-- 새로운 테이블을 만들면서 NOT NULL제약조건 달아보기
-- 컬럼레벨 방식 : 컬럼명 자료형 제약조건
-- 컬럼명, 자료형 쓰고 그 뒤에 내가 달고싶은 제약조건 쓰면 됨
CREATE TABLE TB_USER_NOT_NULL( -- 똑같은 이름 못씀
	-- 회원번호, 아이디, 비밀번호, 이름, 성별
	USER_NO NUMBER NOT NULL, -- ???
	USER_ID VARCHAR2(20) NOT NULL, -- 아이디도 일반적으로 회원가입을 했다면 비어있을 수 없음
	USER_PWD VARCHAR2(20) NOT NULL, -- 비밀번호도 회원가입을 마쳤다면 비어있을 수 없음
	USER_NAME NVARCHAR2(30), -- ??
	GENDER CHAR(3) -- 성별은 남 또는 여 로 한글자?
);

-- 잘 만들어졌는지 확인
SELECT * FROM TB_USER_NOT_NULL;

INSERT INTO TB_USER_NOT_NULL VALUES(1, 'admin', '1234', '관리자', '남');
INSERT INTO TB_USER_NOT_NULL VALUES(NULL, NULL, NULL, NULL, NULL);
-- NULL을 ("CJ18"."TB_USER_NOT_NULL"."USER_NO") 안에 삽입할 수 없습니다
-- Error position: line: 214 pos: 36
-- 위치와 원인을 알려줌, 친절함 그 자체

INSERT
  INTO
       TB_USER_NOT_NULL
VALUES
       (
       2
     , 'user01'
     , 'pass01'
     , NULL
     , NULL
       ); -- NOT NULL제약조건이 달린 컬럼에는 반드시 NULL이 아닌 값이 존재해야함!!(안그러면 INSERT가 수행될 수 없음, UPDATE도 마찬가지)
-- 사실 이렇게 씀, 이렇게 써야 정확히 어떤 친구가 문제인지 알 수 있음(컬럼을 LINE BY LINE으로 적어야)
-- 한줄로 적어버리면 누가 문제인지 명확히 알 수가 없음
-- NULL을 ("CJ18"."TB_USER_NOT_NULL"."USER_ID") 안에 삽입할 수 없습니다
-- Error position: line: 225 pos: 76
-- NULL을 ("CJ18"."TB_USER_NOT_NULL"."USER_PWD") 안에 삽입할 수 없습니다
-- Error position: line: 226 pos: 93

SELECT * FROM TB_USER_NOT_NULL;

-- 제약조건을 걸어서 해냄!

-- 하지만 여기서 끝이 아님
INSERT
  INTO
       TB_USER_NOT_NULL
VALUES
       (
       3
     , 'user01'
     , 'pass02'
     , NULL
     , NULL
       );
-- 여전히 아이디가 NULL값은 못들어가는데 똑같은 값은 들어갈 수 있음
-- 이걸 해결하는 방법을 학습해보자

--------------------------------------------------

/*
 * 2. UNIQUE 제약조건
 * UNIQUE 무슨 뜻? 고유한것, 컬럼의 값을 UNIQUE하게 만들어줄 수 있는 제약조건
 * 컬럼에 중복값을 제한하는 제약도건
 * INSERT / UPDATE 시 기존 컬럼값 중 중복값이 있을 경우 추가 또는 수정을 할 수 없도록 제약
 * 
 * 이름따라감~ 다들 이름따라가지뭐
 * 컬럼레벨 / 테이블레벨 방식 둘 다 가능
 * 
 */

CREATE TABLE TB_USER_UNIQUE(
	USER_NO NUMBER NOT NULL,
	USER_ID VARCHAR2(20) NOT NULL UNIQUE, -- 아이디 중복된값 INSERT 못하게 하고싶다
	USER_PWD VARCHAR2(20) NOT NULL,
	USER_NAME NVARCHAR2(20), -- 쉼표 빼먹거나 자료형 잘못썼거나
	GENDER CHAR(3)
);

SELECT * FROM TB_USER_UNIQUE; -- UNIQUE 제약조건을 달아서 컬럼에 중복된 값이 못들어가도록 막음
-- 실제로 잘 막혔는지 테스트 해봐야지
-- ID 컬럼에 달았으니까
INSERT INTO TB_USER_UNIQUE VALUES(1, 'admin', '2134', NULL, NULL);
INSERT INTO TB_USER_UNIQUE VALUES(2, 'admin', '1231', NULL, NULL);
-- 무결성 제약 조건(CJ18.SYS_C0042416)에 위배됩니다
-- 뭐때문에 문제가 생겼는지 알아보기 힘듦 CJ18.SYS_C0042416 찾아들어가서 봐야함
-- 알아보기 쉽게 제약조건명을 달아줄 수 있음, 이거 어떻게 하는지 알아보자
-- 하는 김에 같이 하자
-- 일단 테이블 날려보자
DROP TABLE TB_USER_UNIQUE;

-- 제약조건을 컬럼레벨방식 말고 테이블 레벨 방식으로 달아보자
CREATE TABLE TB_USER_UNIQUE(
	USER_NO NUMBER CONSTRAINT NUM_NOT_NULL NOT NULL,
	USER_ID VARCHAR2(20) NOT NULL,
	USER_PWD VARCHAR2(20) NOT NULL,
	USER_NAME NVARCHAR2(20),
	GENDER CHAR(3),
	CONSTRAINT ID_UNIQUE UNIQUE(USER_ID) -- 테이블레벨 방식, 제약조건명까지 같이 달아보자
	-- 제약조건을 달 때 제약조건 앞에 CONSTRAINT를 쓰고, 내가 달고 싶은 제약조건의 별칭을 써줌
	-- 테이블 레벨 방식에도 할 수 있음
); -- 제약조건 이름과 제약조건을 같이 달 수 있음

-- 이렇게 하고 INSERT할때 제약조건을 위배하게 되면?
INSERT INTO TB_USER_UNIQUE VALUES(1, 'admin', '2134', NULL, NULL);
INSERT INTO TB_USER_UNIQUE VALUES(2, 'admin', '1231', NULL, NULL);
INSERT INTO TB_USER_UNIQUE VALUES(1, 'admin', '1234', NULL, NULL);
-- 제약조건명을 달아두면 문제가 생긴 원인은 조금 더 쉽게 유추할 수 있음

-- 이렇게 해서 어...뭘 했긴한데 문제가 또 있음

INSERT INTO TB_USER_UNIQUE VALUES(3, 'user01', '1234', '홍길동', '밥'); -- GENDER 컬럼에 남 또는 여 두개중에 하나만 들어가게 하고싶은데 밥?
SELECT * FROM TB_USER_UNIQUE;
-- GENDER컬럼은 '남' 또는 '여'라는 값만 들어갈 수 있게 하고 싶음
-- 컬럼에 특정 조건을 달아서 원하는 값만 들어갈 수 있도록 돌려보자

--------------------------------------------------

/*
 * 3. CHECK 제약조건
 * 컬럼에 기록될 수 있는 값에 대한 조건을 설정할 수 있음!
 * 
 * CHECK(조건식)
 * 
 */

CREATE TABLE TB_USER_CHECK(
	USER_NO NUMBER NOT NULL,
	USER_ID VARCHAR2(20) NOT NULL UNIQUE,
	USER_PWD VARCHAR2(20) NOT NULL,
	GENDER CHAR(3) CHECK(GENDER IN ('남', '여')) -- 다른 컬럼에 대한 조건을 달 수 없고 이 컬럼에 대한것만 달 수 있음, TRUE일때만 INSERT가능
);

INSERT INTO TB_USER_CHECK VALUES(1, 'admin', '1234', '여');
INSERT INTO TB_USER_CHECK VALUES(2, 'user01', 'pass01', '밥');
INSERT INTO TB_USER_CHECK VALUES(3, 'user03', 'pass02', NULL);
-- CHECK를 부여하더라도 NULL값은 INSERT할 수 있음 -> NOT NULL로 막아야함

--------------------------------------------------

/*
 * 테이블 만들기 실습
 * 테이블명 : TB_USER_DEFAULT
 * 컬럼 :
 * 		1. 회원 번호를 저장할 컬럼 : NULL값 금지
 * 		2. 회원 아이디를 저장할 컬럼 : NULL값 금지, 중복값 금지
 * 		3. 회원 비밀번호를 저장할 컬럼 : NULL값 금지
 * 		4. 회원 이름을 저장할 컬럼
 * 		5. 회원 닉네임을 저장할 컬럼 : 중복값 금지
 * 		6. 회원 성별을 저장할 컬럼 : 'M' 또는 'F'만 INSERT될 수 있음
 * 		7. 전화 번호를 저장할 컬럼
 * 		8. 이메일을 저장할 컬럼
 * 		9. 주소를 저장할 컬럼
 * 	   10. 가입일을 저장할 컬럼 : NULL값 금지
 * 
 */

CREATE TABLE TB_USER_DEFAULT(
	USER_NO NUMBER NOT NULL,
	USER_ID VARCHAR2(20) NOT NULL UNIQUE,
	USER_PWD VARCHAR2(20) NOT NULL,
	USER_NAME NVARCHAR2(30),
	NICKNAME NVARCHAR2(20) UNIQUE,
	GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')) NOT NULL,
	PHONE VARCHAR2(13),
	EMAIL VARCHAR2(25),
	ADDRESS VARCHAR2(120),
	ENROLL_DATE DATE NOT NULL
); -- 이건 맞춰놓으면 하나 고쳤을 때 나머지도 다 고쳐서 맞춰야해서 유지보수 시간이 늘어나게됨, 이건 억지로 안맞춤, 괜히 맞추려다 시간 더 오래걸림
-- 보기좋고 고치기 좋으려는건데, 했더니 시간이 더들어? 그럼 할 이유가 없죠

-- 가입일은 INSERT되는 시점의 날짜랑 시간이 들어갔으면 좋겠고
-- 나머지는 다 입력받아서 넣을거고, USER_NUM은 하나씩 증가시킬거고

-- 특정 컬럼에 기본값을 설정하는 방법 ===> 제약조건은 아님
DROP TABLE TB_USER_DEFAULT;

-- 자료형과 제약조건 사이에 DEFAULT를 적고 그 뒤에 내가 기본값으로 넣고싶은것을 적음
CREATE TABLE TB_USER_DEFAULT(
	USER_NO NUMBER NOT NULL,
	USER_ID VARCHAR2(20) NOT NULL UNIQUE,
	USER_PWD VARCHAR2(20) NOT NULL,
	USER_NAME NVARCHAR2(30),
	NICKNAME NVARCHAR2(20) UNIQUE,
	GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')) NOT NULL,
	PHONE VARCHAR2(13),
	EMAIL VARCHAR2(25),
	ADDRESS VARCHAR2(120),
	ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL
);

INSERT
  INTO
       TB_USER_DEFAULT
       (
       USER_NO
     , USER_ID
     , USER_PWD
     , GENDER
       )
VALUES
       (
       1
     , 'admin'
     , '1234'
     , 'M'
       );

SELECT * FROM TB_USER_DEFAULT;
-- NOT NULL을 달아놨어도 내가 INSERT할때 안넣어도 DEFAULT값이 들어감

--------------------------------------------------

/*
 * 4. PRIMARY KEY(기본키, PK) 제약조건 ☆★☆★☆★☆★☆★☆★중요
 * 다른애들은 이름이 직관적임, 갑자기 뜬금없이 얘는..? 기본키, DBMS에서 중요한 역할
 * 테이블에서 각 행들의 정보를 유일하게 식별할 용도로 컬럼에 부여하는 제약조건
 * -> 행들을 구분하는 식별자의 역할
 *  예 ) 학생번호, 게시글번호, 사번, 주문번호, 예약번호
 * => 중복이 발생해선 안되고 값이 꼭 있어야만 하는 식별용 컬럼에 PRIMARY KEY를 부여
 * 
 * 오라클은 함수를 이용해서 난수를 만들어 넣는 경우가 있고, 자바에서는 해시코드 만들거나 랜덤으로 만들거나
 * 
 * 기본적으로 컴퓨터로 돌아가는 모든건 DB에 한행단위로 저장하겠지(관계형 DBMS라면)
 * 아침에 커피 사오면 영수증에 뭐나옴? 주문번호가 달려있음 각 주문들을 구분해야하니까. 똑같이 아아 시키면 구분 어케함?
 * 
 * 한 테이블 당 한 번만 사용 가능
 * 
 */

CREATE TABLE TB_USER_PK(
	USER_NO NUMBER CONSTRAINT PK_USER PRIMARY KEY, -- 컬럼레벨 방식
	USER_ID VARCHAR2(15) NOT NULL UNIQUE,
	USER_PWD VARCHAR2(20) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER CHAR(3) CHECK(GENDER IN ('남', '여'))
	-- PRIMARY KEY(USER_NO) -- 테이블레벨방식
);

INSERT INTO TB_USER_PK
VALUES (1, 'admin', '1234', NULL, NULL); -- 이건 아무런 문제없이 잘 INSERT됨

INSERT INTO TB_USER_PK
VALUES (1, 'user01', '132312', NULL, NULL); -- 기본적으로 제약조건 컷!
-- 기본키 컬럼은 중복값을 INSERT할 수 없음(UNIQUE의 특성도 같이 가지고 있음)

INSERT INTO TB_USER_PK
VALUES (NULL, 'user02', '3535', NULL, NULL);
-- 기본키 컬럼은 NULL값을 INSERT할 수 없음(NOT NULL의 특징도 가짐)

-- UDEMY

-- PRIMARY KEY : 중복값, NULL값 INSERT 할 수 없음, 식별을 위한 친구
-- 주의사항
CREATE TABLE TB_PRIMARYKEY(
	NO NUMBER PRIMARY KEY, -- NOT NULL도 되고 UNIQUE니까 편하다, 두개가 달리니까
	ID CHAR(2) PRIMARY KEY
); -- 이건 안돼, 테이블에는 하나의 기본 키만 가질 수 있습니다. PRIMARY KEY 두 개 이상 못가진다
-- 하나의 테이블은 하나의 PRIMARY KEY만 가질 수 있음
-- 근데 이건 됨
-- 두 개의 컬럼을 묶어서 하나의 PRIMARY KEY로 만들 수 있음 --> 복합키☆

CREATE TABLE VIDEO(
  NAME VARCHAR2(15),
  PRODUCT VARCHAR2(20)
);

INSERT INTO VIDEO VALUES('이승철', '자바');

SELECT * FROM VIDEO;

INSERT INTO VIDEO VALUES('이승철', '자바');
-- 지금 이게 됨, 근데 같은 사람은 같은 영상 못찍게 하고싶음, 이게 UNIQUE 배웠으니까 이걸로 되는가? UNIQUE를 각각 달면 됨?
-- UNIQUE는 컬럼에 다는거니까, 이걸 둘다 달아버리면 같은 사람이 다른 영상 찍은거 못넣게됨

DROP TABLE VIDEO;

CREATE TABLE VIDEO(
  NAME VARCHAR2(15),
  PRODUCT VARCHAR2(20),
  PRIMARY KEY(NAME, PRODUCT) -- 컬럼 두개를 묶어서 PRIMARY KEY하나로 설정
);

INSERT INTO VIDEO VALUES('이승철', '자바');
INSERT INTO VIDEO VALUES('이승철', 'DB');
INSERT INTO VIDEO VALUES('홍길동', '자바');

SELECT * FROM VIDEO;

--------------------------------------------------

-- 회원 등급에 대한 데이터(코드, 등급명) 보관하는 테이블
CREATE TABLE USER_GRADE( -- 부모테이블, 얘를 참조할거니까
	GRADE_CODE CHAR(2) PRIMARY KEY,
	GRADE_NAME NVARCHAR2(20) NOT NULL
);

INSERT INTO USER_GRADE VALUES('G1', '일반회원');
INSERT INTO USER_GRADE VALUES('G2', '회장님');
INSERT INTO USER_GRADE VALUES('G3', '대통령');

SELECT
       GRADE_CODE
     , GRADE_NAME
  FROM
       USER_GRADE;
-- JOIN 배웠으니까 써먹어보려고 테이블 분리해봄

/*
 * 5. FOREIGN KEY(외래키) 제약조건
 * 
 * 다른 테이블에 존재하는 값만 컬럼에 INSERT하고 싶을 때 부여하는 제약조건
 * USER를 만들건데, USER_GRADE에 있는것만 들어가게 하고싶음
 * 만들 테이블이 이 테이블을 참조하게됨
 * => 다른 테이블(부모테이블)을 참조한다고 표현
 * 참조하는 테이블에 존재하는 값만 INSERT 할 수 있음
 * => FOREIGN KEY제약조건을 이용해서 다른 테이블간의 관계를 형성할 수 있음
 * 
 * [ 표현법 ]
 * - 컬럼 레벨 방식
 * 컬럼명 자료형 REFERENCES 참조할테이블명(참조할컬럼명) -- 외래키는 달때 조금 귀찮음, FOREIGN KEY가 아니고 REFERENCES
 * 참조할 테이블에 PRIMARY KEY가 있으면 이렇게 쓰고, 없으면 (참조할컬럼명) 추가, 근데 보통 넣으니까 얜 생략가능
 * 
 * - 테이블 레벨 방식
 * FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명(참조할컬럼명)
 * 참조할 테이블명에 PRIMARY KEY가 없으면 참조할 컬럼명 써야함
 * 
 * 컬럼명 생략 시 PRIMARY KEY컬럼이 참조할 컬럼이 됨
 * 
 */

-- 자식테이블을 만들어보자
CREATE TABLE TB_USER_CHILD ( -- 자식테이블
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(15) NOT NULL UNIQUE,
	USER_PWD VARCHAR(20) NOT NULL,
	GRADE_ID CHAR(2) REFERENCES USER_GRADE -- 컬럼레벨 방식 회원 등급을 넣을 컬럼을 만들고싶다, 참조할 컬럼과 자료형+크기를 맞춰서
	-- FOREIGN KEY(GRADE_ID) REFERENCES USER_GRADE 테이블 레벨 방식, 조금 번거로움, 컬럼레벨 방식이 쓸게 좀 적다
);

INSERT INTO TB_USER_CHILD VALUES(1, 'user01', 'pass01', 'G1'); -- USER_GRADE의 PRIMARY KEY 컬럼을 참조하게 됨
INSERT INTO TB_USER_CHILD VALUES(2, 'user02', 'pass01', 'G2');
INSERT INTO TB_USER_CHILD VALUES(3, 'user03', 'pass03', 'G1');
INSERT INTO TB_USER_CHILD VALUES(4, 'user04', 'pass04', NULL); -- NOT NULL 안썼기때문에 이것도 가능함, NULL값 막고싶으면 무조건 NOT NULL 달아야해

SELECT * FROM TB_USER_CHILD;

-- 부모테이블에 존재하지 않는 값을 넣겠다고 하면 바로 문제생김
INSERT INTO TB_USER_CHILD VALUES(5, 'user05', 'pass05', 'G4'); -- 부모 키가 없습니다, USER_GRADE 테이블에 G4는 존재하지 않음

-- < Quiz > TB_USER_CHILD에 존재하는 모든 회원에 대해서
--			회원번호, 회원아이디, 등급명(예: 회장님)을 조회해주세요!
SELECT
       USER_NO
     , USER_ID
     , GRADE_NAME
  FROM
       TB_USER_CHILD
  LEFT
  JOIN
       USER_GRADE ON (GRADE_CODE = GRADE_ID);
-- FOREIGN KEY를 달면...
-- 무조건 FOREIGN을 달아야 조인할수있는건아님!
-- 우리 안달고 썼었음, 컬럼의 값만 매칭할 수 있으면 외래키 제약조건 없어도 조인 사용할 수 있음, 외래키가 필수사항은 아님
-- 테이블이 많으면 조인을 많이 해야함, 잘게 쪼개놔서, 이런 경우에는 억지로 달려있는 외래키 제약조건을 제거하는 경우도 있음
-- 항상 연산을 하게되므로 많아지면 성능에 영향을 끼칠수밖에없음, 정말 테이블을 많이 쓰는 회사는 속도향상을 위해서 없애버리는것
-- 아무튼 조인의 필수요소는 아니고 성능을 위해서는 희생시킬수도있다는걸 알아둡시다
-- 조인을 하기 위해서 꼭 외래키 제약조건을 달아야하는 것은 아님!

--------------------------------------------------

-- 배운 DELETE를 써보자
-- 부모테이블(USER_GRADE)에서 데이터를 삭제
-- 테이블을 삭제하는거는? DROP / 테이블 안에 있는 데이터를 삭제하는거는? DELETE
-- DML은 테이블 안에 있는 데이터를 만지는거지
-- GRADE_CODE 가 G1인 행 삭제(DELETE도 행이 기준임!)
DELETE
  FROM
       USER_GRADE
 WHERE
       GRADE_CODE = 'G1'; -- 안됨, 자식 레코드가 발견되었습니다
-- 우리가 외래키 제약조건을 가져와서 CHILD에 달아줬음, 자식테이블에서 부모테이블의 G1, G2를 사용중임
-- 이런 경우 꽤 많고 반드시 일어남
-- 나중에 웹개발 하는데 게시글 쓰고 댓글을 씀, 댓글은 게시글 번호를 가지고있겠지, 게시글을 삭제하려고 하면? 댓글테이블에서 사용중이라고 삭제가 안되는 상황이 생기겠지
-- 파일 첨부를 했을때도 그렇고, 예약했을때도 그렇고.. 호텔정보를 지우려니 예약테이블에서 쓰고있고..

SELECT * FROM USER_GRADE;

DELETE FROM USER_GRADE WHERE GRADE_CODE = 'G3';

SELECT * FROM USER_GRADE;
-- G3은 쓰고있지 않아서 삭제가 됨
DROP TABLE TB_USER_CHILD;

ROLLBACK; -- 아까 오토커밋 꺼서 이거 됨 히히 살아나따

--------------------------------------------------

-- 자식테이블 G1 다 지워야 부모테이블에서 삭제 가능함
/*
 * * 자식테이블 생성 시 외래키 제약조건을 부여하면
 *   부모테이블의 데이터를 삭제할 때 자식테이블에서는 처리를 어떻게 할 것인지 옵션 지정 가능
 * 
 * 기본 설정은 ON DELETE RESTRICTED(삭제제한)이 설정됨(아까 부모테이블 삭제 안됐던 이유)
 * 
 */

-- 1) ON DELETE SET NULL == 부모 데이터 삭제 시 자식레코드도 NULL값으로 변경
CREATE TABLE TB_USER_ODSN(
	USER_NO NUMBER PRIMARY KEY,
	GRADE_ID CHAR(2),
	FOREIGN KEY (GRADE_ID) REFERENCES USER_GRADE ON DELETE SET NULL
);

INSERT INTO TB_USER_ODSN VALUES(1, 'G1');
INSERT INTO TB_USER_ODSN VALUES(2, 'G2');
INSERT INTO TB_USER_ODSN VALUES(3, 'G1');

SELECT * FROM TB_USER_ODSN;

-- 부모테이블의 GRADE_CODE 가 G1인 행 삭제
DELETE
  FROM
       USER_GRADE
 WHERE
       GRADE_CODE = 'G1';
-- 자식테이블에서 사용중인데 삭제옵션 주고 삭제하니 가능해짐

SELECT * FROM TB_USER_ODSN;

ROLLBACK;

SELECT * FROM USER_GRADE;

-- 2) ON DELETE CASCADE : 부모데이터 삭제 시 (위에서 밑으로 쫄쫄쫄 흘러) 데이터를 사용하는 자식 데이터도 같이 삭제
CREATE TABLE TB_USER_ODC(
	USER_NO NUMBER PRIMARY KEY,
	GRADE_ID CHAR(2),
	FOREIGN KEY(GRADE_ID) REFERENCES USER_GRADE ON DELETE CASCADE
);

INSERT INTO TB_USER_ODC VALUES(1, 'G1');

SELECT * FROM TB_USER_ODC;

DELETE FROM USER_GRADE WHERE GRADE_CODE = 'G1'; -- 잘 지워지고

SELECT * FROM TB_USER_ODC; -- 다시 확인해보면 행단위로 싹날아감

--------------------------------------------------

/*
 * 2. ALTER
 * 
 * 객체 구조를 수정하는 구문
 * UPDATE로 테이블의 구조를 바꿀 수 없음, 구조가 마음에 안들어서 바꾸려면 지우고 새로만들어야함
 * 근데 만약에 데이터가 들어있으면 DROP했을때 데이터를 다 놓아주어야하는데 그런 마음을 먹기 쉽지않지
 * 
 * < 테이블 수정 >
 * 
 * ALTER TABLE 테이블명 수정할 내용;
 * - 수정할 내용
 * 1) 컬럼 추가 / 컬럼 수정 / 컬럼 삭제
 * 2) 제약조건 추가 / 삭제 => 제약조건 수정은 X(수정하고싶으면 지웠다가 다시 추가해야함)
 * 3) 테이블명 / 컬럼명 / 제약조건명
 * 
 */

CREATE TABLE JOB_COPY
    AS SELECT * FROM JOB; -- 서브쿼리로 테이블 복사하기
-- 컬럼들 조회결과의 데이터값들
-- 제약조건은 NOT NULL만 복사가됨

SELECT * FROM JOB_COPY;

-- 1) 컬럼 추가 / 수정 / 삭제
-- 1_1) 추가(ADD) : ADD 추가할 컬럼명 자료형 DEFAULT 기본값(DEFAULT 생략 가능)

-- LOCATION 컬럼 추가해보자
-- JOB_COPY 테이블의 구조를 바꾸고 싶은것임, 데이터를 추가하는게 아니고 테이블이 생긴 모양을 바꾸는것
ALTER TABLE JOB_COPY ADD LOCATION VARCHAR2(10);

SELECT * FROM JOB_COPY;

-- 컬럼에 값이 텅텅 비어있음
ALTER TABLE JOB_COPY ADD LOCATION_NAME VARCHAR2(20) DEFAULT '한국';
-- NULL값이 아닌 DEFAULT값으로 채워짐

SELECT * FROM JOB_COPY;

-- 1_2) 컬럼수정(MODIFY)
-- 자료형 수정 : (크기를 늘리고 싶다든지) ALTER TABLE 테이블명 MODIFY 컬럼명 바꿀데이터타입;
-- DEFAULT 값 수정 : ALTER TABLE 테이블명 MODIFY 컬럼명 DEFAULT 기본값;
-- 자료형인지 DEFAULT인지는 지가 알아서 판단해줌~ 신경안써도됨

-- JOB_CODE 컬럼 데이터 타입을 CHAR(3)로 변경(직급이 더 생길 수 있음, J9 다음에는 어케해)
-- ALTER USER 계정명 IDENTIFIED BY 바꾸고싶은비밀번호; 내 계정 비밀번호 바꿔보자, 오라클에서 내 계정은 USER 개체임
-- ㅋㅋ 안됨, 우리 지금 권한이 없음
-- 아무나 비밀번호 바꾸거나 테이블 바꿀 수 없음, 이런 권한이 있어야 바꿀 수 있음
ALTER TABLE JOB_COPY MODIFY JOB_CODE CHAR(3);

-- 안되는걸 알아야지
-- ALTER TABLE JOB_COPY MODIFY JOB_CODE NUMBER; 이건 안됨, 데이터 유형을 변경할 열은 비어 있어야 합니다
-- ALTER TABLE JOB_COPY MODIFY JOB_CODE CHAR(1); 이것도 안됨, 일부 값이 너무 커서 열 길이를 줄일 수 없음
-- 무조건 다 바꿀 수 있는 것은 아님
-- 현재 변경하려고 하는 컬럼의 값과 완전히 다른 타입이거나 작은 크기로는 변경이 불가능함!
-- 문자 -> 숫자(X) / 사이즈축소(X) / 확대(O)
-- 억지로 하려면 기존의 행 다 지워야함.. 그럴바에 드랍하지?
SELECT * FROM JOB_COPY;

-- JOB_NAME 컬럼 데이터 타입을 NVARCHAR2(40)
-- LOCATION 컬럼 데이터 타입을 NVARCHAR2(40)
-- LOCATION_NAME컬럼 기본값을 '미국'
-- ALTER TABLE JOB_COPY MODIFY JOB_NAME NVARCHAR2(40);
-- ALTER TABLE JOB_COPY MODIFY LOCATION NVARCHAR2(40);
-- ALTER TABLE JOB_COPY MODIFY LOCATION_NAME DEFAULT '미국';
-- 이러기 귀찮그등요? 공통점은 같은 테이블에서 작업하고 있음
 ALTER TABLE JOB_COPY
MODIFY JOB_NAME NVARCHAR2(40)
MODIFY LOCATION NVARCHAR2(40)
MODIFY LOCATION_NAME DEFAULT '미국';

-- 1_3) 컬럼 삭제(DROP COLUMN) : DROP COLUMN 컬럼명
-- 아까워서 테이블 하나 더 만들어서 해볼거임
CREATE TABLE JOB_COPY2
    AS SELECT * FROM JOB;

ALTER TABLE JOB_COPY2 DROP COLUMN JOB_CODE;
SELECT * FROM JOB_COPY2;

ALTER TABLE JOB_COPY2 DROP COLUMN JOB_NAME; -- 남은것도 지워버릴랬더니 이건안됨, 다날릴수는 없음, 하나는 남아있어야돼
CREATE TABLE ABC(

); -- 이것도 안됩니다
-- 테이블의 구성 요소 : 최소한 한개의 컬럼은 있어야 만들 수 있음, 지울때나 만들때나 마찬가지
-- 테이블은 최소 한 개의 컬럼은 가지고 있어야함!

--------------------------------------------------

-- 2) 제약조건 추가 / 삭제
-- 테이블 단위에서 제일 중요한건 아마 제약조건인것같다
/*
 * 테이블을 생성한 후 제약조건을 추가 (ADD)
 * 
 * - PRIMARY KEY : ADD PRIMARY KEY(컬럼명);
 * - FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 부모테이블명;
 * - CHECK : ADD CHECK(컬럼명);
 * - UNIQUE : ADD UNIQUE(컬럼명);
 * 
 * - NOT NULL : MODIFY 컬럼명 NOT NULL;(얘는 달고 빼는게 아니라 예외임, 혼자 튄다)
 * 
 * 제약조건 달려있는걸 삭제(DROP)
 * PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT 제약조건명
 * 제약조건명 모르면 지울 수 없음, 제약조건명 알아야함
 * 
 * - NOT NULL : MODIFY 컬럼명 NULL;
 * 이렇게 써야 NULL 가능해짐
 * 
 */

-- UNIQUE 하나 추가하고 지워보자
ALTER TABLE JOB_COPY
  ADD CONSTRAINT JOB_UQ UNIQUE(JOB_NAME); -- 그냥 제약조건만 쓰면 나중에 지우고 싶을 때 제약조건명 찾아서 지워야하니까 달아줌

ALTER TABLE JOB_COPY
 DROP CONSTRAINT JOB_UQ; -- 제약조건 이름(제약조건 식별자) 써줌, 미리 달아놔야 이때 편함

--------------------------------------------------

-- 테이블 만들다가 오타냈을때
-- 3) 컬럼명 / 제약조건명 / 테이블명 변경(RENAME)
-- 제약조건은 놔두고 나머지만 바꿔보자

-- 3_1) 컬럼명 바꾸기 : ALTER TABLE 테이블명 RENAME COLUMN 원래컬럼명 TO 바꿀컬럼명
ALTER TABLE JOB_COPY RENAME COLUMN LOCATION TO LNAME;

-- 3_2) 테이블명 변경 : ALTER TABLE 테이블병 RENAME 기존테이블명 TO 바꿀테이블명
ALTER TABLE JOB_COPY2 RENAME TO JOB_COPY3;
-- 보통 ALTER TABLE 하고 기존 테이블명 적으니까 RENAME 다음에 기존테이블명은 생략하고 바로 TO 한 다음에 바꿀 테이블명을 작성함

--------------------------------------------------

/*
 * 3. DROP
 * 객체 삭제하기
 * 
 */

CREATE TABLE PARENT_TABLE(
	NO NUMBER PRIMARY KEY
);

CREATE TABLE CHILD_TABLE(
	NO NUMBER REFERENCES PARENT_TABLE
);

INSERT INTO PARENT_TABLE VALUES(1);
INSERT INTO CHILD_TABLE VALUES(1);

SELECT * FROM PARENT_TABLE;
SELECT * FROM CHILD_TABLE;

DROP TABLE PARENT_TABLE; -- 자식테이블에서 부모테이블을 외래키로 쓰고있어서 삭제불가능

-- 지울 수 있는 방법 2가지
-- 1. 자식데이블을 DROP한 후 부모테이블을 DROP

-- 필살기...?
-- 2. CASCADE CONSTRAINT(너무 강력한 방법이라서 7번쯤 생각해보고 그다음에 사용해라, 진짜 지워도 되나? 이래도 괜찮은 것인가?)
DROP TABLE PARENT_TABLE CASCADE CONSTRAINT; -- 제약조건이 붙어있을때는 이것까지
-- 제약조건하고 부모테이블만 지워지고 애기는 남아있음