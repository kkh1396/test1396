/*
	����Ŭ(DB)���� �پ��� ��ü���� �ִ�.
	������ � ��ü�� ���� �����ΰ�? �ش� ��ü�� ���� ������ �ۼ��غ���.
	
	* _VIEW_ : ���̺�� �ٸ��� ���������� �����͸� �������� ������,
						   ���� ���̺��� Ư�� �÷��̳� ������ �����Ͽ� �����͸� �� �� �ִ�.
						   
	* __������______ : �ڵ� ���� ���� �����ϴ� ��ü. �ַ� �⺻ Ű ���� �� ���.
	
	* __Ʈ����______ : Ư�� �̺�Ʈ �߻� �� �ڵ����� ����ǵ��� ������ ��ü.
	
	* __�����(USER)______ : ���̺�, ��, ������ ���� ��ü�� ������ �� �ִ� ��ü. Ư�� ������ �ο� �޾� �ٸ� ��ü�� ������ �� ����.
*/
-- * ---------------------------------------------------------------------- * --
/*
    * ����� ����� �Է¹޾� �ش� ����� ���, �̸��� ���
      - ��� : XXX
      - �̸� : XXX
      
      ��, ��ȸ�� ����� ���� ��� '�Է��� ��� ����� ���� ����� �����ϴ�.' ���
      ��ȸ�� ����� ���� ��� '�ش� ����� ���� ����� �����ϴ�.' ���
      �� ���� ���� �߻� �� '������ �߻��߽��ϴ�. �����ڿ��� �����ϼ���.' ���
      
      
*/


DECLARE
   E_ID EMPLOYEE.EMP_ID%TYPE;
   ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN

     SELECT EMP_ID, EMP_NAME
      INTO E_ID, ENAME
      FROM EMPLOYEE
      WHERE EMP_ID = &���;


            DBMS_OUTPUT.PUT_LINE('E_ID : '|| E_ID);
             DBMS_OUTPUT.PUT_LINE('ENAME : '|| ENAME);


EXCEPTION 
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�Է��� ��� ����� ���� ����� �����ϴ�.');
  
  WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ش� ����� ���� ����� �����ϴ�.');
  
  WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�. �����ڿ��� �����ϼ���.');

END;
/


CREATE USER C##INDEXTEST IDENTIFIED BY INDEXTEST;
GRANT CONNECT, RESOURCE TO C##INDEXTEST;
ALTER USER C##INDEXTEST QUOTA 200M ON USERS;
   

