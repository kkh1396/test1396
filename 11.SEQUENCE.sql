/*
    * ������ (SEQUENCE)
    : �ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
       ������ ���������� ������ ������ ������Ű�鼭 ����
       
       EX) �����ȣ, ȸ����ȣ, ������ȣ, ..... --> �⺻Ű�� ����ߴ� �÷���
*/

--

/*
    * ������ ���� *
    
   [ǥ����]
       CREATE SEQUENCE ��������
       [START WITH ����]         --> ó�� �߻���ų ���۰� ���� (���� �� �⺻���� 1)
       [INCREMENT BY ����]       --> �󸶸�ŭ�� ������ų �������� ���� �� ���� (���� �� �⺻�� 1)
       [ MAXVALUE ���� ]         --> �ִ밪 (���� �� �⺻��... ��ûŭ)
       [ MINVALUE ���� ]         --> �ּҰ� (���� �� �⺻�� 1)
       [CYCLE | NOCYCLE]         --> ���� ��ȯ���� (�⺻�� NOCYCLE)
                                     * CYCLE : ������ ���� �ִ밪�� �����ϸ� �ּҰ����� 
                                                �ٽ� ��ȯ�ϵ��� ����
                                     * NOCYCLE : ������ ���� �ִ밪�� �����ϸ� ���̻�
                                                 ������Ű�� �ʵ��� ����
    
       [NOCACHE | CACHE ����]     --> ĳ�ø޸� �Ҵ� ���� ( �⺻�� CACHE 20)
                                    *ĳ�ø޸� : �̸� �߻��� ������ �����ؼ� �����صδ� ����
                                      �Ź� ȣ��� ������ ���� ��ȣ�� �����ϴ� ���� �ƴ϶�
                                      ĳ�ø޸𸮶�� ������ �̸� �����ص� ���� �����ٰ� ��� (�ӵ��� ����)
                
      * ���� (�̸� �����ֱ�)
         - ���̺� : TB_
         - ��    : VW_
         - ������ : SEQ_
         - Ʈ���� : TRG_
*/
-- * ������ ���� : SEQ_TEST ��� �̸�
CREATE SEQUENCE SEQ_TEST;

-- * ���� ������ �����Ǵ� ������ ��ȸ 
SELECT * FROM USER_SEQUENCES;

-- SEQ_EMPNO ������ ����
-- * ���۹�ȣ: 300, ������: 5, �ִ밪: 310, ��ȯX, ĳ�ø޸� X
CREATE SEQUENCE SEQ_EMPNO 
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

-----------------
/*
    * ������ ��� *
    
    - ��������.CURRVAL : ���� ������ ��. ���������� ������ NEXTVAL�� ������ ��.
    - ��������.NEXTVAL : ������ ���� ���� ���� �������� �߻��� �����.
                        ���� ������ ������ INCREMNET BY�� ������ ����ŭ ������ ��.
*/

-- * SEQ_EMPNO �������� ���� ������ �� ��ȸ
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--> �����߻�!! NEXTVAL�� �ѹ��� �������� ���� �������� CURRVAL�� ����Ҽ� ����!

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
--> NEXTVAL�� ��� ���� �� ó�� ���� �� ���� ���� Ȯ���� �� ����! : 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300 + 5 -> 305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305 + 5 -> 310

SELECT * FROM USER_SEQUENCES;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; 
-- 315. �����߻�!! �ִ밪�� 310���� �����Ǿ� �ֱ� ������ �� �̻��� ���� ��ȸ�� �� ����!

---------
/*

     * ������ ���� *
     
       ALTER SEQUENCE ��������
       [INCREMENT BY ����]
       [MAXVALUE ����]
       [MINVALUE ����]
       [CYCLE | NOCYCLE]
       [NOCACHE | CACHE ����]
       
       --> ���� ���� ���� �Ұ�!
*/

-- * SEQ_EMPNO �������� �������� 10, �ִ밪�� 400���� ����

ALTER SEQUENCE SEQ_EMPNO INCREMENT BY 10  MAXVALUE 400;

SELECT * FROM USER_SEQUENCES;


SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;

---------------------------------
/*
   * ������ ���� * 

    DROP SEQUENCE ��������;

*/

-- * SEQ_EMPNO �������� ����

DROP SEQUENCE SEQ_EMPNO;

SELECT * FROM USER_SEQUENCES;



---------------------------------------------------------------------------

/*
     -- EMPLOYEE ���̺� ������ ����غ��� --
     ==> ���(EMP_ID) �÷��� ���

*/

-- * ������ ���� (SEQ_ID) -> 300������ �����ϵ���, ĳ�ø޸� ������� ����, 1�� ����.
CREATE SEQUENCE SEQ_ID 
START WITH 300        -- ���۹�ȣ: 300
INCREMENT BY 1
NOCACHE;              -- ĳ�ø޸� ��� X

-- >> ���۰�: 300, ������: 1,  ��ȯ���� : NOCYCLE (X), �ִ밪: ��ûū��....

-- * ������ ��� : EMPLOYEE ���̺� �����Ͱ� �߰��� ��
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
    VALUES (SEQ_ID.NEXTVAL, '����ġ', '250311-123456', 'J5', SYSDATE);

SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
    VALUES (SEQ_ID.NEXTVAL, '����ġ', '250311-123456', 'J5', SYSDATE);

ROLLBACK; -- �ӽõ����� �߰� ���

