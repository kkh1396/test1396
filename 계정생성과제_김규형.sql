
-- 계정 유무 화인
select * from dba_users ;
-- 계정 생성시 앞에 C## 안붙이게 설정
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- TEST0228 계정 생성
CREATE USER TEST0228 IDENTIFIED BY TEST0228;

-- TEST0228 계정 유무 확인
select * from dba_users WHERE USERNAME = 'TEST0228';

-- TEST0228에 접속 및 리소스 권한 부여
GRANT CONNECT, RESOURCE TO TEST0228;