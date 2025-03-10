-- ���� �ּ�

/*
   ���� �� �ּ�
*/

--���� ��� �����鿡 ���Ͽ� ��ȸ�ϴ� ��ɹ�
select * from dba_users;
-- ��ɹ�(sql) ���� : �����ư Ŭ�� �Ǵ� Ctrl + Enter Ű���� �Է�

-- �Ϲ� ����� ���� ���� ���� --> ������ �������θ� ���� ����!
-- [ǥ����] CREATE USER ������ INDENTIFIED BY ��й�ȣ;
-- * 12c �������ʹ� ������ �տ� C## �� �ٿ���� ��.

-- ����ڸ� : KH, ��й�ȣ: KH �� ���� �߰�
CREATE USER C##KH IDENTIFIED by KH;

-- ���� ���� �� C## �� �����ϰ� ���� ���ó�� �ϰ��� �� ���
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- * �� ��ɹ��� SQL Developer ������ ������ ��ɹ��� ������� ��!
-- CREATE USER KHTEST IDENTIFIED BY KHTEST; -- �׽�Ʈ�� �߰�


-- (2) ���� �ο�
--    ������ ����ڿ��� �ּ�ȯ�� ������ �ο� (����, ��ü ���� ����)
--    [ǥ����] GRANT ����1, ����2, .. TO ������;
GRANT CONNECT, RESOURCE TO C##KH;
-- * CONNECT : ���� ����
-- * RESOURCE : ������ ����, DB������ ��ü(���̺�, ������, ���ν���, Ʈ���� ��) ���� ����

-- ���̺� �����̽� ���� ����
ALTER USER C##KH DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;










