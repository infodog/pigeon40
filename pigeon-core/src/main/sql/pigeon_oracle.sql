

CREATE BIGFILE TABLESPACE PIGEON DATAFILE   '/u01/app/oracle/oradata/XE/pigeon.dbf' SIZE 5120M AUTOEXTEND ON NEXT 1024M EXTENT MANAGEMENT LOCAL;

CREATE TEMPORARY TABLESPACE PIGEONTEMP TEMPFILE '/u01/app/oracle/oradata/XE/pigeontemp.dbf' SIZE 512M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL UNIFORM SIZE 16M;



CREATE USER pigeon IDENTIFIED BY hellopigeon DEFAULT TABLESPACE PIGEON QUOTA UNLIMITED ON PIGEON TEMPORARY TABLESPACE PIGEONTEMP PROFILE DEFAULT ACCOUNT UNLOCK;

GRANT CONNECT, CREATE SESSION, CREATE CLUSTER, CREATE TABLE, CREATE TRIGGER, CREATE ANY INDEX TO pigeon;



disconn

conn pigeon/hellopigeon@XE



CREATE TABLE T_FLEXOBJECT(
  NAME VARCHAR2(512) PRIMARY KEY,
  CONTENT BLOB,
  HASH NUMBER(16,0),  
  ISCOMPRESSED NUMBER(1),
  ISSTRING NUMBER(1)
);


CREATE TABLE T_LISTBAND(
  ID NUMERIC(16) PRIMARY KEY,
  LISTNAME VARCHAR2(512),
  ISHEAD NUMERIC(1),
  ISMETA NUMERIC(1),
  VALUE CLOB,
  NEXTMETABANDID NUMERIC(16),
  PREVMETABANDID NUMERIC(16)
);
CREATE INDEX IDX_LISTBAND ON T_LISTBAND(LISTNAME,ISHEAD);


CREATE TABLE T_IDS(
  TABLENAME VARCHAR2(512) PRIMARY KEY,
  NEXTVALUE NUMERIC(16)
);


CREATE TABLE T_SIMPLEATOM(
  NAME VARCHAR2(512) PRIMARY KEY,
  VALUE NUMERIC(16)
);

CREATE TABLE T_TESTWHILEIDLE (
  ID VARCHAR2(128) PRIMARY KEY
);
INSERT INTO T_TESTWHILEIDLE VALUES ('TEST');


CREATE TABLE T_PIGEONTRANSACTION(
  NAME VARCHAR2(512) PRIMARY KEY,
  VERSION NUMERIC(16),
  LASTTIME DATE DEFAULT SYSDATE NULL  
);
CREATE OR REPLACE TRIGGER TR_AUTO_TIMESTAMP
BEFORE UPDATE OF VERSION ON T_PIGEONTRANSACTION
FOR EACH ROW    
BEGIN
:NEW.LASTTIME := SYSDATE;     
END TR_AUTO_TIMESTAMP;

/

