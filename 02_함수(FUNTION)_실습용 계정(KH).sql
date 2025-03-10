 /*
    * �Լ� (FUNTION)
     : ���޵� �÷����� �о �Լ��� ������ ����� ��ȯ
     
     - ������ �Լ� : ���� ���� ���� �о ���� ���� ������� ���� (=> �ึ�� �Լ��� ������ ��� ��ȯ)
     - �׷� �Լ� : ���� ���� ���� �о 1���� ������� ���� (=> �׷��� ���� �׷캰�� �Լ��� ������ ����� ��ȯ)
     
     * SELECT���� �������Լ��� �׷��Լ��� ���ÿ� ����� �� ����!
      => ��� ���� ������ �ٸ��� ������
      
     * �Լ����� ����ϴ� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
 */
 
 -- ===========================================================================
 
 /*
    ����Ÿ���� ������ ó�� �Լ�
     -> VARCHAR2(n), CHAR(n) 
     
     * LENGTH(�÷��� '���ڿ�') : G�ش� ���ڿ��� ���ڼ��� ��ȯ 
     * LENGTHB(�÷��� �Ǵ� '���ڿ�') : �ش� ���ڿ��� ����Ʈ���� ��ȯ
     
     => ������, ����, Ư������ : ���ڴ� 1BYTE
      �ѱ� : ���ڴ� 3byte '��', '��' '��' '��'
 */
 
 -- '����Ŭ' �ܾ��� ���ڼ��� ����Ʈ���� Ȯ��
 SELECT LENGTH('����Ŭ') ���ڼ�, LENGTHB('����Ŭ') ����Ʈ��
 FROM DUAL;
 
 -- 'ORACLE' �ܾ��� ���ڼ��� ����Ʈ���� Ȯ��
 SELECT LENGTH('ORACLE') ���ڼ�, LENGTHB('ORACLE') ����Ʈ��
 FROM DUAL;
 
 -- ��� �������� �����, �����(���ڼ�), �����(����Ʈ��)
 --                �̸���, �̸���(���ڼ�), �̸���(����Ʈ��) ��ȸ
 
 SELECT EMP_NAME,LENGTH(EMP_NAME),LENGTHB(EMP_NAME),
        EMAIL, LENGTH(EMAIL),LENGTHB(EMAIL)
FROM EMPLOYEE;
 
 -- ===========================================================================
 
 /*
    * INSTR : ���ڿ��κ��� Ư�� ������ ������ġ�� ��ȯ
    
    [ǥ����]
        INSTR(�÷� �Ǵ� '���ڿ�', 'ã�����ϴ¹���'[, ã����ġ�� ���۰�, ����])
            => �Լ� ���� ������� ����Ÿ��(NUMBER)
            
 */
 
 SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- �տ������� ù��° B�� ��ġ : 3
 SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- ���� ��ġ : 1 (�⺻��)
 SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- �ڿ������� ù��? B�� ��ġ : 10
 -- ���� ��ġ�� �������� �����ϰ� �Ǹ�, �ڿ������� ���ڸ� ã�� ��!
 
 SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
 
 -- ��� ���� �� �̸���, �̸����� '_'�� ù��? ��ġ, �̸����� '@'�� ù��? ��ġ ��ȸ
 SELECT * FROM EMPLOYEE;
 
 SELECT EMAIL, INSTR(EMAIL, '_', 1, 1 ), INSTR(EMAIL,'@') 
 FROM EMPLOYEE;
 
 /*
    * SUBSTR : ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
    
    [ǥ����] 
            SUBSTR('���ڿ�' �Ǵ� �÷�, ������ġ[, ����(����)])
            => ���̸� �����ϸ� ������ġ���� ���ڿ� ������ ����
 */
 
 SELECT SUBSTR('ORACLE SQL DEVELOPER',10) FROM DUAL; -- 10��? ��ġ ������ ����
 SELECT SUBSTR('ORACLE SQL DEVELOPER',12) FROM DUAL;
 
 -- �� ���ڿ����� 'SQL' ����
 SELECT SUBSTR('ORACLE SQL DEVELOPER',8,3) FROM DUAL;
 -- 8�� ��ġ���� 3���ڸ� ����
 
 SELECT SUBSTR('ORACLE SQL DEVELOPER',-3) FROM DUAL;
 -- �ڿ��� 3��? ��ġ���� ������ ����

SELECT SUBSTR('ORACLE SQL DEVELOPER',-9) FROM DUAL;

SELECT SUBSTR('ORACLE SQL DEVELOPER',-9,3) FROM DUAL;                   
-- �ڿ��� 9��° ��ġ���� 3���ڸ� ����
 
 
 
 -- ����� �� ��������� �̸�, �ֹι�ȣ ��ȸ
 SELECT * FROM EMPLOYEE;
 
 SELECT EMP_NAME �����, EMP_NO �ֹι�ȣ
 FROM EMPLOYEE
 -- WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4' ;
 WHERE SUBSTR(EMP_NO,8,1) IN (2,4);
 -- SUBSTR(EMP_NO, 8, 1) => EMP_NO �÷��� �����Ϳ��� 8��° ��ġ�� �ѱ��ڸ� ����
 
 -- ����� �� ��������� �̸�, �ֹι�ȣ ��ȸ. (��� �̸� �������� �������� ����)
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME �����, EMP_NO �ֹι�ȣ
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN (1,3)
ORDER BY EMP_NAME;

-- * �Լ����� ��ø�ؼ� ��밡��

-- ��� ���� �� �����, �̸���, ���̵� ��ȸ
-- * ���̵� : �̸��Ͽ��� @ �տ������� ������
--          [1] �̸��Ͽ���  '@' ��ġ�� ã�� => INSTR
--          [2] �̸��� ������ 1��° ��ġ���� @ ��ġ ������ ���� => SUBSTR

SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1 ,(INSTR(EMAIL,'@')-1))
--SELECT EMP_NAME, EMAIL, (INSTR(EMAIL,'@')-1
FROM EMPLOYEE;

 -- ===========================================================================

 /*
    * LPAD / RPAD : ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���
    
    [ǥ����]
         LPAD(���ڿ� �Ǵ� �÷�, �� ����[, '�����Ϲ���']) -- ���ʿ� �����Ϲ��ڸ� ����Ͽ� ä��
         RPAD(���ڿ� �Ǵ� �÷�, �� ����[, '�����Ϲ���']) -- �����ʿ� �����Ϲ��ڸ� ����Ͽ� ä��
         => �����Ϲ��ڸ� ������ ��� �������� ä����!
 */
 
 -- ��� ���� �� ������� ���ʿ� ������ ä���� 20���̷� ��ȸ
 SELECT EMP_NAME, LPAD(EMP_NAME, 20)"�����"
 FROM EMPLOYEE;
 
 -- ������� �����ʿ� ������ ä���� 20���̷� ��ȸ
 SELECT EMP_NAME, RPAD(EMP_NAME,20) "�����" 
 FROM EMPLOYEE;
 
 -- ��� ���� �� �����, �̸��� ��ȸ( * �̸��� ����������, �� ���� : 20)
 SELECT EMP_NAME, LPAD(EMAIL,20)
 FROM EMPLOYEE;
 
 -- * ���� ����
SELECT EMP_NAME, RPAD(EMAIL,20)
FROM EMPLOYEE;

-- *��������, '#'���� ä��
SELECT EMP_NAME, RPAD(EMAIL,20,'#')
FROM EMPLOYEE;
 
SELECT '000201-1', RPAD('000201-1', 14, '*') FROM DUAL;

-- ��� ���� �� �����, �ֹι�ȣ ��ȸ
-- ��, �ֹι�ȣ�� 'XXXXXX-X*****' �������� ��ȸ
--      [1] �ֹι�ȣ �����͸� 8�ڸ��� ����
--      [2] �������� *�� ä��

SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8), 14, '*')
FROM EMPLOYEE;
 
-- ===========================================================================

/*
   * LTRIM /RTRIM : ���ڿ����� Ư�� ���ڸ� ������ �� ������ ��ȯ
   
   [ ǥ���� ]
      LTRIM(���ڿ� �Ǵ� �÷�)[, '�����ҹ��ڵ�')
      RTRIM(���ڿ� �Ǵ� �÷�)[, '�����ҹ��ڵ�')
       => ������ ���ڸ� �������� ���� ��� ������ ��������!
*/

SELECT LTRIM('    H I') FROM DUAL; -- ���ʺ��� �ٸ����ڰ� ���Ë����� ���� ���� 
SELECT RTRIM('H I    ') FROM DUAL; -- �����ʺ��� �ٸ����ڰ� ���Ë����� ���� ���� 

SELECT LTRIM('123123H123','123') FROM DUAL; -- H123
SELECT LTRIM('123123H123','321') FROM DUAL; --

SELECT RTRIM('123123H123','123') FROM DUAL;

SELECT LTRIM('KKHHII','123') FROM DUAL;

/*
    * TRIM : ���ڿ� ��/�� ���ʿ� �ִ� ������ ���ڵ��� ������ �� ������ ���� ��ȯ
    
    [ǥ����]
            TRIM([LEADING | TRAILING | BOTH]) [�����ҹ��� FROM] ���ڿ� �Ǵ� �÷�)
             * ù��? �ɼ� ���� �� �⺻�� BOTH (����)
             * ������ ���� ���� �� ���� ����
     
*/

SELECT TRIM('     H   I    ') FROM DUAL; -- ���� ������� ���ŵ�

-- 'LLLLLHLLLLLL' ���ڿ����� ������ 'L' ����
SELECT TRIM('L' FROM 'LLLLLHLLLLLL') FROM DUAL;

SELECT TRIM(BOTH 'L' FROM 'LLLLLHLLLLLL') "��" FROM DUAL; -- �⺻�� Ȯ��!
SELECT TRIM(LEADING 'L' FROM 'LLLLLHLLLLLL') "��" FROM DUAL; -- �⺻�� Ȯ��!
SELECT TRIM(TRAILING 'L' FROM 'LLLLLHLLLLLL') "��" FROM DUAL; -- �⺻�� Ȯ��!
 
 ----------------------------------------------------------------------------
 /*
    * LOWER / UPPER /INITCAP
       - LOWER : ���ڿ��� ��� �ҹ��ڷ� �����Ͽ� ��� ��ȯ
       - UPPER : ���ڿ��� ��� �빮�ڷ� �����Ͽ� ��� ��ȯ
       - INITCAP : ���⸦ �������� ù ���ڸ��� �빮�ڷ� �����Ͽ� ��� ��ȯ
 */
 
 -- * 'oh my god ' 
 SELECT LOWER('OH my god') FROM DUAL;
 SELECT UPPER('OH my god') FROM DUAL;
 SELECT INITCAP('OH my god') FROM DUAL;
 
 /*
 
    * CONCAT : ���ڿ� �� ���� �����ִ°�
     [ǥ����]
         CONCAT(���ڿ�1, ���ڿ�2)
 */
 
 SELECT 'KH' , 'A������' FROM DUAL;
 SELECT 'KH' || 'A������' FROM DUAL;
 SELECT CONCAT('KH','A������') FROM DUAL;
 
 -- ��� ���� �� ����� ��ȸ (* {�����}�� �������� ��ȸ)
 SELECT * FROM EMPLOYEE;

SELECT EMP_NAME ||'��' �����
FROM EMPLOYEE;

SELECT  CONCAT( EMP_NAME ,'��' ) AS �����
FROM EMPLOYEE;
 
-- 200�����ϴ� �������� ��ȸ *CONCAT �Լ� ���
SELECT CONCAT(EMP_ID,CONCAT( EMP_NAME ,'��' ))
FROM EMPLOYEE;
 
 
 /*
    * REPLACE : ���ڿ����� Ư�� �κ��� ������ ���ڿ��� ��ü�Ͽ� ��ȯ
    
    [ǥ����]
    
        REPLACE(���ڿ�, ã�����ڿ�, �����ҹ��ڿ�)
 
*/

SELECT REPLACE('����� ������', '������', '���α�' ) FROM DUAL;


-- ��� ���� �� �̸��� �������� '@kh.or.kh'�κ��� '@gmail.com')���� �����Ͽ� ��ȸ

SELECT * FROM EMPLOYEE;

SELECT REPLACE(EMAIL,'@kh.or.kh', '@gmai.com')
FROM EMPLOYEE;



/*
    [ ���� Ÿ���� �Լ� ]
*/

/*
   * ABS
*/

SELECT ABS(-100) FROM DUAL;

SELECT ABS(-12.34) FROM DUAL;
-------------------------------------------------------------------------------
/*
    * MOD = �� ���� ���� ������ ���� �����ִ� �Լ�
    
     MOD(����1, ����2)    ---> ����1 % ����2
*/
-- 10�� 3���� ���� �������� ���غ���

SELECT MOD(10, 3) FROM DUAL;

SELECT MOD(10.9, 3) FROM DUAL;

-------------------------------------------------------------------------------

/*
  * ROUND : �ݿø��� ���� �����ִ� �Լ�
  
    ROUND(����[,��ġ] : �Ҽ��� ��ġ���� �ݿø��� ���� ������!
                       ���� �� ù��? ��ġ���� �ݿø�!
*/

SELECT ROUND(123.456) FROM DUAL;  -- .4��ġ���� �ݿø�! ��� = 123
SELECT ROUND(123.456, 1) FROM DUAL;  -- .5��ġ���� �ݿø�! ��� = 123.5
SELECT ROUND(123.456, 2) FROM DUAL;  -- .5��ġ���� �ݿø�! ��� = 123.46

SELECT ROUND(123.456,-1) FROM DUAL; -- 120;
SELECT ROUND(123.456,-2) FROM DUAL; -- 100;
-- ��ġ���� ����� ������ ���� �Ҽ��� �ڷ� ��ĭ�� �̵�,
--         ������ ������ ���� �Ҽ��� ������ ��ĭ�� �̵�
-------------------------------------------------------------------------------

/*
  * CEIL : �ø�ó���� �� ����� ��ȯ���ִ� �Լ�
*/
SELECT CEIL(123.456) FROM DUAL; --124
/*
   FLOOR : ����ó�� �� ����� ��ȯ���ִ� �Լ�
*/
SELECT FLOOR(123.456) FROM DUAL; --123
/*
  TRUNC : ����ó�� �� ����� ��ȯ���ִ� �Լ�. (��ġ ���� ����)
*/
SELECT TRUNC(123.456) FROM DUAL; -- FLOOR �Լ��� ����
SELECT TRUNC(123.456,1) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

/*
  [��¥ Ÿ�� ���� �Լ�]
*/
-- SYSDATE : ������ ���� ��¥ �� �ð��� ��ȯ
SELECT SYSDATE FROM DUAL;


-- MONTHS BETWEEN : �� ��¥ ������ ���� ���� ��ȯ
-- [ǥ����] MONTHS_BETWEEN(��¥A, ��¥B) : ��¥A - ��¥B => ���� �� ��ȯ

SELECT MONTHS_BETWEEN(SYSDATE, '24/12/31') FROM DUAL;
SELECT MONTHS_BETWEEN(SYSDATE, '24/12/5') FROM DUAL;
SELECT CEIL(MONTHS_BETWEEN(SYSDATE, '24/12/5')) FROM DUAL;

-- ������� �� ���� ���Ҵ°�? (������ 25/06/18)

SELECT FLOOR(MONTHS_BETWEEN('25/06/18', SYSDATE)) || '���� ����' "�������.." FROM DUAL;

-- ��� ���� �� �����, �Ի���, �ټӰ����� ��ȸ
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME �����, HIRE_DATE �Ի���, 
        CEIL (MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) �ټӰ�����
FROM EMPLOYEE
WHERE ENT_DATE IS NULL;

/*
    * ADD_MONTHS : Ư�� ��¥�� N���� ���� ���ؼ� ��ȯ
    [ǥ����] 
         ADD_MONTHS(��¥, ���Ұ�����)
            
*/
-- ���� ��¥ ���� 3���� �� ��ȸ
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) "3���� ��" FROM DUAL;

-- ��� ���� �� �����, �Ի���, ���������� ��ȸ
-- * �����Ⱓ : �Ի��� + 3����

SELECT * FROM EMPLOYEE;

SELECT EMP_NAME �����, HIRE_DATE �Ի���, ADD_MONTHS(HIRE_DATE, 3) ����������
FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
   * NEXT_DAT : Ư�� ��¥ ���� ������ ������ ���� ����� ��¥�� ��ȯ
   
   [ǥ����] 
            NEXT_DAY(��¥, ����)
            * ���� => ���� �Ǵ� ���� 
              1: ��, 2: ��, ... 7:��
*/

-- ���� ��¥ ���� ���� ����� �Ͽ����� ��¥ ��ȸ
SELECT NEXT_DAY(SYSDATE,1) FROM DUAL;
-- ����Ÿ���� ��� ������� �����!

-- ����Ÿ������ ���� �� ��� ������ ���� ����� �� ����!
-- ��� ���� : KOREAN
ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '�Ͽ���') FROM DUAL;

-- ��� ����: AMERICAN
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE,'SUN') FROM DUAL;
SELECT NEXT_DAY(SYSDATE,'SUNDAY') FROM DUAL;


/*
   * LAST_DAY : �ش� ���� ������ ��¥�� ��ȯ���ִ� �Լ�
*/

SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- ��� ���� �� �����, �Ի���, �Ի��� ���� ��������¥, �Ի��� ���� �ٹ��ϼ� ��ȸ

SELECT * FROM EMPLOYEE;

SELECT EMP_NAME �����, HIRE_DATE �Ի���, LAST_DAY(HIRE_DATE) "�Ի��� ���� ��������¥",
(LAST_DAY(HIRE_DATE) - HIRE_DATE  ) "�Ի��� ���� �ٹ��ϼ�"
FROM EMPLOYEE;


/*
   * EXTRACT : Ư�� ��¥�κ��� ����/��/��/ ���� �����Ͽ� ��ȯ���ִ� �Լ�
     [ǥ����]
             EXTRACT(YEAR FROM ��¥) : �ش� ������ ������ ����
             EXTRACT(MONTH FROM ��¥) : �ش� ������ ���� ����
             EXTRACT(DAY FROM ��¥) : �ش� ������ �ϸ� ����
*/
-- ���糯¥�� ����/��/���� ���� �����Ͽ� ��ȸ
SELECT SYSDATE,
    EXTRACT(YEAR FROM SYSDATE) "����",
    EXTRACT(MONTH FROM SYSDATE) "��",
    EXTRACT(DAY FROM SYSDATE) "��"
FROM DUAL;

-- ��� ���� �� �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
--          (* ���� : �Ի�⵵->�Ի��->�Ի��� ������ ��������)

SELECT * FROM EMPLOYEE;
SELECT EMP_NAME �����, 
                EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵, 
                EXTRACT(MONTH FROM HIRE_DATE) �Ի��,
                EXTRACT(DAY FROM HIRE_DATE) �Ի���
FROM EMPLOYEE
--ORDER BY �Ի�⵵, �Ի��,�Ի���;
ORDER BY 2, 3, 4;

--------------------------------------------------------------------------------

/*
   * ����ȯ �Լ� : ������ Ÿ���� �������ִ� �Լ� 
           -> ���� / ���� / ��¥
*/
/*
    TO_CHAR : ���� �Ǵ� ��¥ Ÿ���� ���� ���� Ÿ������ �������ִ� �Լ�
    
    [ǥ����]
            TO_CHAR(���� �Ǵ� ��¥[, ����])
*/
-- * ����Ÿ�� -> ����Ÿ��
SELECT 1234 "����Ÿ���� ������", TO_CHAR(1234) "����Ÿ������ ����� ����" FROM DUAL;

SELECT TO_CHAR(1234) "Ÿ�� ���游 �� ������", TO_CHAR(1234, '999999') "��������������" FROM DUAL;
-- => 9 : ������ŭ �ڸ����� Ȯ��. ������ ����. ���ڸ��� �������� ä��

SELECT TO_CHAR(1234) "Ÿ�� ���游 �� ������", TO_CHAR(1234, '000000') "��������������" FROM DUAL;
-- => 0 : ������ŭ �ڸ����� Ȯ��. ����������. ���ڸ��� 0���� ä��

SELECT TO_CHAR(1234, 'L99999') "���˵�����" FROM DUAL;
-- ==> L : ���� ������ ����(���)�� ���� ȭ������� ǥ��. KOREAN -> \(��ȭ), AMERICAN -> $

SELECT TO_CHAR(1234, '$999999') "���˵�����" FROM DUAL;

SELECT 100000, TO_CHAR(100000, 'L9,999,999') FROM DUAL;

-- ������� �����, ����, ������ ��ȸ (����, ������ ȭ����� ǥ��. 3�ڸ��� �����Ͽ� ǥ��.)

SELECT * FROM EMPLOYEE;
SELECT EMP_NAME, TO_CHAR(SALARY, 'L9,999,999') ����, 
        TO_CHAR(SALARY*12, 'L999,999,999') ����
FROM EMPLOYEE;

-------------------------------------------------------------------------------

-- ��¥Ÿ�� --> ����Ÿ��
SELECT SYSDATE, TO_CHAR(SYSDATE) "���ڷ� ��ȯ" FROM DUAL;
/*
    * �ð� ���� ����
    
    - HH : �� ���� (HOUR) --> 12�ð���
      HH24 --> 24�ð���
      
    - MI : �� ���� (MINUTE)
    - SS : �� ���� (SECOND)
*/
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL;  --> 12�ð���
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; --> 24�ð���

SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;
--> AM / PM : ����/�������� ǥ��

/*
    * ���� ���� ����
    
    - DAY : X���� -> ������, ȭ����, ..., �Ͽ���
    - DY  : X    -> ��, ȭ, ��, ..., ��
    - D   : ����Ÿ������ ǥ�� (1: �Ͽ���, ..., 7: �����)
*/
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY D') FROM DUAL;

/*
    * �� ���� ����
    - MON, MONTH : X�� -> 3��, 4��, ... , 12��
    - MM : �� ������ 2�ڸ��� ǥ��
*/
SELECT TO_CHAR(SYSDATE, 'MON MONTH') FROM DUAL;

/*
    * �� ���� ����
    - DD : �� ������ 2�ڸ��� ǥ��
    - DDD : �ش� ��¥�� �ش�⵵ ���� �� ��° �ϼ�
*/
SELECT TO_CHAR(SYSDATE, 'DD') "2�ڸ� ǥ��"
        , TO_CHAR(SYSDATE, 'DDD') "�� ��° ��"
FROM DUAL;

/*
    * �⵵ ���� ����
    - YYYY : �⵵�� 4�ڸ��� ǥ��
    - YY   : �⵵�� 2�ڸ��� ǥ��
    
    - RRRR : �⵵�� 4�ڸ��� ǥ��
    - RR   : �⵵�� 2�ڸ��� ǥ��
      => �Էµ� ������ 00 ~ 49�� ��:
            ���� ������ �� �� �ڸ��� 00 ~ 49 -> ��ȯ�� ������ �� ���ڸ��� ���� ������ ����
            ���� ������ �� �� �ڸ��� 50 ~ 99 -> ��ȯ�� ������ �� ���ڸ��� ���� ������ �� ���ڸ��� +1
         �Էµ� ������ 50 ~ 99�� ��:
            ���� ������ �� �� �ڸ��� 00 ~ 49 -> ��ȯ�� ������ �� ���ڸ��� ���� ������ �� �� �ڸ� -1
            ���� ������ �� �� �ڸ��� 50 ~ 99 -> ��ȯ�� ������ �� ���ڸ��� ���� ������ ����
*/
SELECT TO_CHAR(TO_DATE('250304', 'RRMMDD'), 'YYYY') "RR���(50�̸�)"
        , TO_CHAR(TO_DATE('550304', 'RRMMDD'), 'YYYY') "RR���(50�̻�)"
        , TO_CHAR(TO_DATE('250304', 'YYMMDD'), 'YYYY') "YY���(50�̸�)"
        , TO_CHAR(TO_DATE('550304', 'YYMMDD'), 'YYYY') "YY���(50�̻�)"
FROM DUAL;        

-- ��� ���� �� �����, �Ի糯¥ ��ȸ
-- (��, �Ի糯¥ ���� "XXXX�� XX�� XX��" ���� ��ȸ)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') "�Ի糯¥"
FROM EMPLOYEE;
--> ǥ���� ����(����) �κ��� ū ����ǥ("")�� ��� ���Ͽ� �ݿ��ؾ� ��!
--------------------------------------------------------------------------------
/*
    * TO_DATE : ����Ÿ�� �Ǵ� ����Ÿ���� ��¥Ÿ������ �������ִ� �Լ�
    
    [ǥ����]
            TO_DATE(���� �Ǵ� ����[, ����])
*/
SELECT TO_DATE(20250304) FROM DUAL;
SELECT TO_DATE(250304) FROM DUAL;       --> 50�� �̸��� �ڵ����� 20XX���� �����(����)
SELECT TO_DATE(550304) FROM DUAL;       --> 50�� �̻��� �ڵ����� 19XX���� �����(����)

SELECT TO_DATE(020222) FROM DUAL;       --> ���ڴ� 0���� �����ϸ� �ȵ�!
SELECT TO_DATE('020222') FROM DUAL;     --> 0���� �����ϴ� ��� ����Ÿ������ �����ϸ� ��!

SELECT TO_DATE('20250304 104230') FROM DUAL;    --> �ð��� �����ϴ� ���, ������ �����ؾ� ��!
SELECT TO_DATE('20250304 104230', 'YYYYMMDD HH24MISS') FROM DUAL;
--------------------------------------------------------------------------------
/*
    * TO_NUMBER : ����Ÿ���� �����͸� ����Ÿ������ ��������ִ� �Լ�
    
    [ǥ����]
            TO_NUMBER(����[, ����])
            -> ��ȣ�� ���Եǰų� ȭ������� �����ϴ� ��� ������ ����
*/
SELECT TO_NUMBER('0123456789') FROM DUAL;

SELECT '10000' + '500' FROM DUAL;   -- �ڵ����� ����->���� ��ȯ�Ǿ� ��������� �����!
SELECT '10,000' + '500' FROM DUAL;

SELECT TO_NUMBER('10,000', '99,999') + TO_NUMBER('500', '999') FROM DUAL;
--==============================================================================
/*
    * NULL ó�� �Լ�
*/

/*
    * NVL : �ش� �÷��� ���� NULL�� ��� �ٸ� ������ ����� �� �ֵ��� �������ִ� �Լ�
    
    [ǥ����]
            NVL(�÷���, �ش��÷��� ���� NULL�� ��� ����� ��)
*/
-- ��� ���� �� �����, ���ʽ� ������ ��ȸ
-- (��, ���ʽ� ���� NULL�� ��� 0���� ǥ��)
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- ��� ���� �� �����, ���ʽ�, ����, ���ʽ� ���� ���� ������ ��ȸ
SELECT EMP_NAME, NVL(BONUS, 0) "BONUS", SALARY * 12 "����"
        , (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "���ʽ� ���� ����"
FROM EMPLOYEE;

/*
    * NVL2 : �ش� �÷��� ���� NULL�� ��� ǥ���� ���� �����ϰ�,
                            NULL�� �ƴ� ��� ǥ���� ���� ������ �� �ִ� �Լ�
                            -> �����Ͱ� �ִ� ���
                            
    [ǥ����]
            NVL2(�÷���, �����Ͱ� �����ϴ� ��� ����� ��, NULL�� ��� ����� ��)
*/
-- ��� ���� �� �����, ���ʽ� ���� ��ȸ (���ʽ��� ���� ��� 'O', ���� ��� 'X' ǥ��)
SELECT EMP_NAME, BONUS, NVL2(BONUS, 'O', 'X') "���ʽ� ����"
FROM EMPLOYEE;

-- ��� ���� �� �����, �μ��ڵ�, �μ���ġ���� ��ȸ (��ġ�� �� ��� '�����Ϸ�', ��ġ���� ���� ��� '�̹���' ǥ��)
SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '�����Ϸ�', '�̹���') "�μ� ��ġ����"
FROM EMPLOYEE;

/*
    * NULLIF : �� ���� ��ġ�ϸ� NULL, ��ġ���� �ʴ� �ٸ� �񱳴��1 ��ȯ
    
    [ǥ����]
            NULLIF(�񱳴��1, �񱳴��2)
*/
SELECT NULLIF('999', '999') FROM DUAL;
SELECT NULLIF('999', '555') FROM DUAL;
--==============================================================================
/*
    * �����Լ�
        DECODE(�񱳴��, �񱳰�1, �����1, �񱳰�2, �����2, ...)
        
        --> �ڹٿ��� switch
            switch(�񱳴��) {
                case �񱳰�1: �����1;
                case �񱳰�2: �����2;
                ...
            }
*/
-- ��� ���� �� ���, �����, �ֹι�ȣ, ���� ��ȸ
-- (��, ������ 1: ��, 2: ��, �׿�: �˼�����)
SELECT EMP_ID, EMP_NAME, EMP_NO,
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��', '�˼�����') ����
FROM EMPLOYEE;

-- ��� ���� �� �����, �����޿�, �λ�� �޿� ��ȸ
/*
    ������ J7�� ����� 10% �λ�
          J6�� ����� 15% �λ�
          J5�� ����� 20% �λ�
        �� �ܿ���      5% �λ�
*/
SELECT EMP_NAME, JOB_CODE, SALARY,
        DECODE(JOB_CODE,
                    'J7', SALARY * 1.1,
                    'J6', SALARY * 1.15,
                    'J5', SALARY * 1.2,
                    SALARY * 1.05) "�λ�� �޿�"
FROM EMPLOYEE;

/*
    * CASE WHEN THEN : ���ǽĿ� ���� ������� ��ȯ���ִ� �Լ�
    
    [ǥ����]
            CASE
                WHEN ���ǽ�1 THEN �����1
                WHEN ���ǽ�2 THEN �����2
                ...
                ELSE �����
            END
            
    --> �ڹٿ����� if~else���� ����
*/
-- ��� ���� �� �����, �޿�, �޿��� ���� ��� ��ȸ
/*
    500���� �̻� '���'
    350���� �̻� '�߱�'
    �� �� '�ʱ�'
*/
SELECT EMP_NAME, SALARY, 
        CASE
            WHEN SALARY >= 5000000 THEN '���'
            WHEN SALARY >= 3500000 THEN '�߱�'
            ELSE '�ʱ�'
        END "�޿��� ���� ���"
FROM EMPLOYEE;        
--==============================================================================
-------------------------- �׷� �Լ� --------------------------------------------
/*
    * SUM : �ش� �÷��� ������ �� ���� ��ȯ���ִ� �Լ�
    
    [ǥ����]
            SUM(����Ÿ���÷�)
*/
-- ��ü ������� �� �޿��� ��ȸ
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- 'XXX,XXX,XXX' �������� ��ȸ�ϰ��� �Ѵٸ�..?
SELECT TO_CHAR( SUM(SALARY), 'L999,999,999') "�� �޿�"
FROM EMPLOYEE;

-- ���� ������� �� �޿��� ��ȸ
SELECT SUM(SALARY) "��������� �� �޿�" -- 3
FROM EMPLOYEE                       -- 1
WHERE SUBSTR(EMP_NO, 8, 1) = 1;     -- 2

-- �μ��ڵ尡 'D5'�� ������� �� ���� ��ȸ
SELECT SUM( SALARY*12 ) "D5 �μ��� �� ����"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';
--------------------------------------------------------------------------------
/*
    * AVG : �ش� �÷��� ������ ����� ��ȯ���ִ� �Լ�
    
    [ǥ����]
            AVG(����Ÿ���÷�)
*/
-- ��ü ������� ��� �޿� ��ȸ (* �ݿø� ����)
SELECT ROUND( AVG(SALARY) ) "��ü ��� ��� �޿�"
FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * MIN : �ش� �÷��� ���� �� ���� ���� ���� ��ȯ���ִ� �Լ�
    
    [ǥ����]
            MIN(���Ÿ���÷�)
*/
SELECT MIN(EMP_NAME) "����Ÿ�� �ּڰ�", MIN(SALARY) "����Ÿ�� �ּڰ�", MIN(HIRE_DATE) "��¥Ÿ�� �ּڰ�"
FROM EMPLOYEE;

/*
    * MAX : �ش� �÷��� ���� �� ���� ū ���� ��ȯ���ִ� �Լ�
    
    [ǥ����]
            MAX(���Ÿ���÷�)
*/
SELECT MAX(EMP_NAME) "����Ÿ�� �ִ�", MAX(SALARY) "����Ÿ�� �ִ�", MAX(HIRE_DATE) "��¥Ÿ�� �ִ�"
FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * COUNT : ���� ������ ��ȯ���ִ� �Լ� (��, ������ ���� ��� �ش� ���ǿ� �´� ���� ������ ��ȯ)
    
    [ǥ����]
            COUNT(*)  : ��ȸ�� ����� ��� ���� ������ ��ȯ
            COUNT(�÷�) : �ش� �÷��� ���� NULL�� �ƴ� �͸� ���� ������ ���� ��ȯ
            COUNT(DISTINCT �÷�) : �ش� �÷��� ������ �ߺ��� ������ ���� ���� ������ ���� ��ȯ
                    => �ߺ� ���� �� NULL�� �������� �ʰ� ������ ������!
*/
-- ��ü ��� ���� ��ȸ
SELECT COUNT(*) "��ü ��� ��" FROM EMPLOYEE;

-- ������ �� ��ȸ
SELECT COUNT(*) "������ ��" 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- ������ �� ��ȸ
SELECT COUNT(*) "������ ��" 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- ���ʽ��� �޴� ��� �� ��ȸ
SELECT COUNT(*) "���ʽ��� �޴� ��� ��"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

SELECT COUNT(BONUS) "���ʽ��� �޴� ��� ��"
FROM EMPLOYEE;

-- �μ� ��ġ�� ���� ��� �� ��ȸ
SELECT COUNT(DEPT_CODE) "�μ� ��ġ�� ���� ��� ��" FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE 
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE) "�Ҽӻ���� �ִ� �μ� ��"
FROM EMPLOYEE;

