250305_DQL(SELECT).sql
--====== 250305_DQL(SELECT)_���������(TEST250305).sql ���� �� �Ʒ� ��ȸ ======--
-- ����� ������ �������ּ���. (����ڸ�: C##TEST250305 / ��й�ȣ: test0305)


-- ��� ����� ���� ��ȸ

select * from customer;

-- �̸�, �������, ���� ���� ��ȸ

select name �̸� , birthdate ������� , EXTRACT(YEAR FROM sysdate) -  EXTRACT(YEAR FROM birthdate) + 1 ����
from customer;

-- ���̰� 40���� ������� ���� ��ȸ

select * 
from customer
where  EXTRACT(YEAR FROM sysdate) -  EXTRACT(YEAR FROM birthdate)+1  between 40 and 49;


-- �����ÿ� ���� ���� ������� ���� ��ȸ
select * from customer;

select * from customer
where address like '%������%';


-- �̸��� 2���� ������� ���� ��ȸ
select * from customer;

select * from customer
where LENGTH(NAME) = 2;

--===========================================================================
-- '250305' ����Ÿ�� �����͸� '2025�� 03�� 05��'�� ǥ��

SELECT TO_CHAR(TO_DATE('250305','YYMMDD'),'YYYY"�� "MM"�� "DD"��"') FROM DUAL;


-- ������ �¾�� ��ĥ °���� Ȯ��
select * from customer;

SELECT CEIL(SYSDATE - TO_DATE('19940817'))||'�� °' FROM DUAL;


--===========================================================================
-- ����� ������ �������ּ���. (����ڸ�: C##KH / ��й�ȣ: KH)
--  �ش� ������ ���� ��� �߰� �� kh.sql ��ũ��Ʈ �����Ͽ� �Ʒ� ������ �������ּ���.

-- ������� ���� ����� �޿� �� ��ȸ

SELECT * FROM EMPLOYEE;

SELECT SUM(SALARY) 
FROM EMPLOYEE
WHERE ENT_YN = 'N';


-- �Ի���� ��� �� ��ȸ (* �Ի�� �������� ����)

SELECT EXTRACT(MONTH FROM HIRE_DATE) "�Ի� ��", COUNT(*) "��� ��"
FROM EMPLOYEE
GROUP BY EXTRACT(MONTH FROM HIRE_DATE)
ORDER BY 1 ;


