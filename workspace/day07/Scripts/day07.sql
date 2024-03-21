-- 관계를 맺은 테이블의 DML

-- [테이블 세팅]===============================================================
SELECT * FROM TBL_PHONE;
SELECT * FROM TBL_CASE;

INSERT INTO TBL_PHONE
(PHONE_SERIAL_NUMBER, PHONE_COLOR, PHONE_SIZE, PHONE_PRICE, PHONE_PRODUCTION_DATE, PHONE_SALE)
VALUES('S23-001', 'GREEN', 7, 200, '2023-02-11', 0);
-- DATE 타입의 컬럼에 문자타입의 값을 'YYYY-MM-DD' 의 형태로 넣으면
-- 자동으로 DATE 타입으로 변환되어 들어간다. (일정한 데이터타입의 형태에 맞춰서 작성하면)

INSERT INTO TBL_PHONE
(PHONE_SERIAL_NUMBER, PHONE_COLOR, PHONE_SIZE, PHONE_PRICE, PHONE_PRODUCTION_DATE, PHONE_SALE)
VALUES('S23-002', 'WHITE', 7, 200, SYSDATE, 0); -- 프로젝트할 때 가장 많이 사용하는 형태

INSERT INTO TBL_PHONE
(PHONE_SERIAL_NUMBER, PHONE_COLOR, PHONE_SIZE, PHONE_PRICE, PHONE_PRODUCTION_DATE, PHONE_SALE)
VALUES('S23-003', 'BLACK', 7, 200, '2023/02/15', 0);


-- 자식 테이블에도 값 INSERT!
INSERT INTO TBL_CASE
VALUES('ABC', 'WHITE', 10000, 'S23-004'); -- 오류! 부모에 없는 값을 참조함.

INSERT INTO TBL_CASE
VALUES('ABC', 'WHITE', 10000, 'S23-001');

INSERT INTO TBL_CASE
VALUES('DEF', 'BLACK', 12000, 'S23-002');
-- [//테이블 세팅]===============================================================



-- UPDATE
-- [오류]=================================================
UPDATE TBL_PHONE 
SET PHONE_SERIAL_NUMBER = 'S23-444'
WHERE PHONE_SERIAL_NUMBER = 'S23-001';
-- ======================================================
-- 자식에서 참조하고 있는 PK 값의 수정은 기본적으로 막혀있다.
-- 일반적으로 부모 테이블의 PK를 수정하는 것은 권장하지 않는다.
-- 그 이유는 일관성을 손상시키고, 무결성에 위배될 수 있기 떄문이다.
-- 하지만, 필요에 따라서 수정해야할 때도 있기 때문에
-- 아래의 두 가지 방법 중 하나를 선택하여 PK 값을 수정해야할 때 사용하도록 한다.
-- ======================================================


-- 1번째 방법
-- 자식 테이블에서 부모 테이블을 참조중인 값을 NULL 로 변경 후 수정
UPDATE TBL_CASE 
SET PHONE_SERIAL_NUMBER = NULL
WHERE PHONE_SERIAL_NUMBER = 'S23-001';
-- (1)부모를 참조중인 자식 테이블의 FK 중, 수정하려는 부모 테이블의 값인 친구들을 NULL 로 임시로 바꿔준다.

UPDATE TBL_PHONE 
SET PHONE_SERIAL_NUMBER = 'S23-444'
WHERE PHONE_SERIAL_NUMBER = 'S23-001';
-- (2)다시 PHONE_SERIAL_NUMBER 의 값을 수정해준다 (맨 처음 실행할 땐 참조중이라서 실행오류가 떴었다)

UPDATE TBL_CASE 
SET PHONE_SERIAL_NUMBER = 'S23-444'
WHERE PHONE_SERIAL_NUMBER IS NULL;
-- (3)임시로 NULL 을 매워넣은 자식 테이블의 값을 다시 수정한 부모 테이블의 값(S23-444)으로 바꿔넣어준다.


-- 2번째 방법
-- 부모에 임의의 값을 INSERT 하고
-- 자식 FK 를 수정한 후에 진행한다.
INSERT INTO TBL_PHONE
(PHONE_SERIAL_NUMBER, PHONE_COLOR, PHONE_SIZE, PHONE_PRICE, PHONE_PRODUCTION_DATE, PHONE_SALE)
VALUES('111', '', 0, 0, '', 0);
-- (1)임시값을 INSERT 한다

UPDATE TBL_CASE
SET PHONE_SERIAL_NUMBER = '111'
WHERE PHONE_SERIAL_NUMBER = 'S23-002';
-- (2)임시값을 참조하도록 FK의 값을 수정한다


UPDATE TBL_PHONE
SET PHONE_SERIAL_NUMBER = 'S23-222'
WHERE PHONE_SERIAL_NUMBER = 'S23-002';
-- (3)참조하고 있는 FK가 없어졌으니 바꾸려고 했던 PHONE_SERIAL_NUMBER 키를 변경한다

UPDATE TBL_CASE
SET PHONE_SERIAL_NUMBER = 'S23-222'
WHERE PHONE_SERIAL_NUMBER = '111';
-- (4)자식 FK의 값을 임시로 만들어놓은 값에서 -> 수정한 부모의 값으로 다시 제대로 참조시켜준다

DELETE FROM TBL_PHONE
WHERE PHONE_SERIAL_NUMBER = '111';
-- (5) 임시로 넣은 값('111')을 삭제한다

SELECT * FROM TBL_PHONE;
SELECT * FROM TBL_CASE;



-- ======================================================
-- [실습]
/*
	TBL_MEMBER, TBL_BOOK 활용!
	 
	회언 정보 추가(3개 이상)
	책 정보 추가(3개 이상)
	회원 이름 수정
	책 대여하기
	책 대여한 회원 번호 수정
	회원 삭제
	
*/
--회원 정보 추가 (3개 이상)
INSERT INTO TBL_MEMBER
VALUES(1, '류호근', 22, '010-1111-1222', '수원시 장안구');

INSERT INTO TBL_MEMBER
VALUES(2, '홍길동', 23, '010-2222-2222', '수원시 장안구');

INSERT INTO TBL_MEMBER
VALUES(3, '강감찬', 25, '010-3333-3333', '수원시 장안구');

--	책 정보 추가 (3개 이상)
INSERT INTO HR.TBL_BOOK
(BOOK_ID, BOOK_NAME, BOOK_GENRE)
VALUES(101, '셜록 홈즈', '추리');

INSERT INTO TBL_BOOK
(BOOK_ID, BOOK_NAME, BOOK_GENRE)
VALUES(102, 'DBMS 완전 정복', 'IT');

INSERT INTO TBL_BOOK
(BOOK_ID, BOOK_NAME, BOOK_GENRE)
VALUES(103, '그리고 아무도 없었다', '추리');

--	회원 이름 수정
UPDATE TBL_MEMBER 
SET MEMBER_NAME = '스펀지밥'
WHERE MEMBER_ID = 1;

--	책 대여 하기
UPDATE TBL_BOOK 
SET MEMBER_ID = 1
WHERE BOOK_ID = 101;

UPDATE TBL_BOOK 
SET MEMBER_ID = 1
WHERE BOOK_ID = 102;

UPDATE TBL_BOOK 
SET MEMBER_ID = 3
WHERE BOOK_ID = 103;

--	책 대여한 회원 번호 수정
UPDATE TBL_BOOK 
SET MEMBER_ID = NULL
WHERE MEMBER_ID = 1;

UPDATE TBL_MEMBER
SET	MEMBER_ID = 49
WHERE MEMBER_ID = 1;

UPDATE TBL_BOOK 
SET MEMBER_ID = 49
WHERE MEMBER_ID IS NULL;

--	회원 삭제
UPDATE TBL_BOOK 
SET MEMBER_ID = NULL
WHERE MEMBER_ID = 49;

DELETE FROM TBL_MEMBER
WHERE MEMBER_ID = 49;

SELECT * FROM TBL_MEMBER;
SELECT * FROM TBL_BOOK;
--===================================================================
-- SEQUENCE
-- 회원과 책 정보를 INSERT 할 때
-- PK를 직접 지정하는 것이 아닌, 시퀀스로 받아올 거예요!
TRUNCATE TABLE TBL_BOOK;
DELETE FROM TBL_MEMBER; -- TRUNCATE 는 DDL이라 FK는 좀 힘든듯


-- 시퀀스 생성
CREATE SEQUENCE SEQ_BOOK;
CREATE SEQUENCE SEQ_MEMBER;

-- 시퀀스를 사용해서 데이터 넣기! 
--회원 정보 추가 (3개 이상)
INSERT INTO TBL_MEMBER
VALUES(SEQ_MEMBER.NEXTVAL, '류호근', 22, '010-1111-1222', '수원시 장안구');

INSERT INTO TBL_MEMBER
VALUES(SEQ_MEMBER.NEXTVAL, '홍길동', 23, '010-2222-2222', '수원시 장안구');

INSERT INTO TBL_MEMBER
VALUES(SEQ_MEMBER.NEXTVAL, '강감찬', 25, '010-3333-3333', '수원시 장안구');

--	책 정보 추가 (3개 이상)
INSERT INTO HR.TBL_BOOK
(BOOK_ID, BOOK_NAME, BOOK_GENRE)
VALUES(SEQ_BOOK.NEXTVAL, '셜록 홈즈', '추리');

INSERT INTO TBL_BOOK
(BOOK_ID, BOOK_NAME, BOOK_GENRE)
VALUES(SEQ_BOOK.NEXTVAL, 'DBMS 완전 정복', 'IT');

INSERT INTO TBL_BOOK
(BOOK_ID, BOOK_NAME, BOOK_GENRE)
VALUES(SEQ_BOOK.NEXTVAL, '그리고 아무도 없었다', '추리');
SELECT * FROM TBL_BOOK;

-- ==============================================================

-- 관계를 맺은 테이블 간의 데이터의 삭제!
SELECT * FROM TBL_MEMBER;
SELECT * FROM TBL_BOOK;

--	책 대여 하기
UPDATE TBL_BOOK 
SET MEMBER_ID = 4
WHERE BOOK_ID = 4;

UPDATE TBL_BOOK 
SET MEMBER_ID = 4
WHERE BOOK_ID = 5;

UPDATE TBL_BOOK 
SET MEMBER_ID = 6
WHERE BOOK_ID = 6;
-- ======================================

DELETE FROM TBL_MEMBER
WHERE MEMBER_ID = 4; -- 자식에서 참조하고 있기 때문에 삭제 불가능!

-- 1. 자식에서 해당 FK 값을 NULL 로 수정!

-- 2. 자동으로 부모 PK 가 삭제되면
-- 자식에서 해당 PK 값을 참조하고 있던 행도 함께 삭제!
-- FK 제약 조건 뒤에 ON DELETE CASCADE 옵션을 추가함으로써 구현!
-- 이렇게 작성하면 부모 PK 가 삭제되면 자동으로 해당 PK를 참조하고 있는 FK 행이 삭제됨
ALTER TABLE TBL_BOOK DROP CONSTRAINT FK_BOOK;
ALTER TABLE TBL_BOOK ADD CONSTRAINT FK_BOOK FOREIGN KEY(MEMBER_ID)
REFERENCES TBL_MEMBER(MEMBER_ID) ON DELETE CASCADE;

DELETE FROM TBL_MEMBER
WHERE MEMBER_ID = 4; -- 다시 실행하면 에러가 나지 않고 4번 회원이 가지고 있던 정보까지 전부 삭제됨

SELECT * FROM TBL_MEMBER;
SELECT * FROM TBL_BOOK;

DROP TABLE TBL_MEMBER;
DROP TABLE TBL_BOOK;
--==================================================================

-- NVL
SELECT * FROM TBL_BOOK;
SELECT * FROM TBL_MEMBER;

INSERT INTO HR.TBL_BOOK
(BOOK_ID, BOOK_NAME, BOOK_GENRE)
VALUES(SEQ_BOOK.NEXTVAL, '셜록 홈즈', '추리');

INSERT INTO TBL_BOOK
(BOOK_ID, BOOK_NAME, BOOK_GENRE)
VALUES(SEQ_BOOK.NEXTVAL, 'DBMS 완전 정복', 'IT');

INSERT INTO TBL_BOOK
(BOOK_ID, BOOK_NAME, BOOK_GENRE)
VALUES(SEQ_BOOK.NEXTVAL, '그리고 아무도 없었다', '추리');

SELECT BOOK_ID, BOOK_NAME, BOOK_GENRE, NVL(MEMBER_ID, -1)
FROM TBL_BOOK;

SELECT BOOK_ID, BOOK_NAME, BOOK_GENRE, 
	NVL2(MEMBER_ID, '대여 중', '대여 가능') "대여 가능 여부"
FROM TBL_BOOK;


























