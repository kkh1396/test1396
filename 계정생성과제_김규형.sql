
-- ���� ���� ȭ��
select * from dba_users ;
-- ���� ������ �տ� C## �Ⱥ��̰� ����
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- TEST0228 ���� ����
CREATE USER TEST0228 IDENTIFIED BY TEST0228;

-- TEST0228 ���� ���� Ȯ��
select * from dba_users WHERE USERNAME = 'TEST0228';

-- TEST0228�� ���� �� ���ҽ� ���� �ο�
GRANT CONNECT, RESOURCE TO TEST0228;