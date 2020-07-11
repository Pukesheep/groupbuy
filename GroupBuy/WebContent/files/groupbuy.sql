
/* 檔案儲存的目錄路徑 

請在C槽下建立目錄image
並把圖片放入此目錄

*/ 
--CREATE OR REPLACE  DIRECTORY MEDIA_DIR AS 'd:/Project/Oracle/image/'; 

--/* 擷取檔案的FUNCTION */ 
--CREATE OR REPLACE FUNCTION load_blob( myFileName VARCHAR) RETURN BLOB as result BLOB;  
--  myBFILE      BFILE;
--  myBLOB       BLOB;
--BEGIN
--    myBFILE := BFILENAME('MEDIA_DIR',myFileName);
--    dbms_lob.createtemporary(myBLOB, TRUE);
--    dbms_lob.fileopen(myBFILE,dbms_lob.file_readonly);
--    dbms_lob.loadfromfile(myBLOB,myBFILE,dbms_lob.getlength(myBFILE) );
--    dbms_lob.fileclose(myBFILE);
--    RETURN myBLOB;
--END load_blob;

/* 注意: 上下兩段要分開來個跑一次 */
/* *************************************************************************************** */

----------------------------------------------------------
--DROP TABLE BEFORE CREATING

drop table question;
DROP TABLE AUTHORITY_TABLE;
DROP TABLE FEATURES_TABLE;
DROP TABLE IMMEDACCUSE;
DROP TABLE POSTACCUSE;
DROP TABLE MEMBERACCUSE;
DROP TABLE AUCTACCUSE;
DROP TABLE ADMINISTRATOR;
DROP TABLE BID;
DROP TABLE AUCT;
DROP TABLE IMMED;
DROP TABLE PRODUCT_ORDER_LIST;
DROP TABLE PRODUCT_ORDER;
drop table GRO_ORDER;
DROP TABLE ORDSTAT;
drop table FAVOURITE_GRO;
drop table GRO_MEM;
drop table GROUPBUY;
drop table REBATE;
DROP TABLE CUSTOMER_MESSAGE;
DROP TABLE ONE_TO_ONE;
DROP TABLE FAVOURITE_BOUNS;
DROP TABLE BOUNS_ORDER;
DROP TABLE BOUNS_STATE;
DROP TABLE BOUNS_MALL;
DROP TABLE DISCOUNT_LIST;
DROP TABLE FAVOURITE_PRODUCT;
DROP TABLE PRODUCT;
DROP TABLE DISCOUNT;
DROP TABLE PRODUCT_TYPE;
DROP TABLE COMM;
DROP TABLE FAVORITE_POST;
DROP TABLE POST;
DROP TABLE PTYPE;
DROP TABLE MEMBER;

DROP SEQUENCE QUESTION_SEQ;
DROP SEQUENCE BID_SEQ;
DROP SEQUENCE AUCT_SEQ;
DROP SEQUENCE IMMED_SEQ;
DROP SEQUENCE ORDSTAT_SEQ;
drop sequence GROUPBUY_seq;
drop sequence REBATE_seq;
drop sequence GRO_ORDER_seq;
DROP SEQUENCE CM_SEQ;
DROP SEQUENCE CR_SEQ;
DROP SEQUENCE MEMBER_SEQ;
DROP SEQUENCE SEQ_DIS_ID ;
DROP SEQUENCE SEQ_ORESTAT_ID ;
DROP SEQUENCE SEQ_P_ID;
DROP SEQUENCE SEQ_PO_ID;
DROP SEQUENCE POST_SEQ;
DROP SEQUENCE COMM_SEQ;
DROP SEQUENCE PTYPE_SEQ;
DROP SEQUENCE BOUNS_STATE_SEQ;
DROP SEQUENCE BOUNS_MALL_SEQ;
DROP SEQUENCE BOUNS_ORDER_SEQ;
DROP SEQUENCE POSTACCUSE_SEQ;
DROP SEQUENCE MEMBERACCUSE_SEQ;
DROP SEQUENCE AUCTACCUSE_SEQ;
DROP SEQUENCE IMMEDACCUSE_SEQ;
DROP SEQUENCE ADMINISTRATOR_SEQ;
DROP SEQUENCE FEATURES_SEQ;

--DROP TABLE BEFORE CREATING
----------------------------------------------------------

ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy-mm-dd';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'yyyy-mm-dd hh24:mi:ss';

-----------------------------TABLE-----------------------------

CREATE TABLE MEMBER(
    MEM_ID VARCHAR2(30) PRIMARY KEY NOT NULL,
    MEM_EMAIL VARCHAR2(30) UNIQUE NOT NULL,
    MEM_PASS VARCHAR2(30) NOT NULL,
    MEM_NAME VARCHAR2(50),
    MEM_ICON BLOB,
    MEM_PHONE VARCHAR2(30),
    MEM_ADDR VARCHAR2(200),
    BANK_ACC VARCHAR2(30),
    CARD_NO VARCHAR2(16),
    CARD_YY VARCHAR2(4),
    CARD_MM VARCHAR2(2),
    CARD_SEC VARCHAR2(3),
    MEM_AUTHO NUMBER(2) NOT NULL,
    MEM_BONUS NUMBER(30),
    MEM_JOINDAT DATE DEFAULT CURRENT_TIMESTAMP,
    MEM_BIRTH DATE,
    MEM_WARN NUMBER(30)
);

CREATE TABLE ADMINISTRATOR (
 ADM_NO                 VARCHAR2(30) PRIMARY KEY NOT NULL,
 ADM_ACCO               VARCHAR2(30),
 ADM_PASS               VARCHAR2(30),
 ADM_NAME               VARCHAR2(30),
 ADM_STATE              NUMBER(2)
 );
 
 CREATE TABLE FEATURES_TABLE (
 F_NO                 VARCHAR2(30) PRIMARY KEY NOT NULL,
 F_TYPE               VARCHAR2(30)
 );
 
 CREATE TABLE AUTHORITY_TABLE (
 ADM_NO             VARCHAR2(30) NOT NULL,
 F_NO               VARCHAR2(30) NOT NULL,
 PRIMARY KEY(ADM_NO,F_NO),
 FOREIGN KEY(ADM_NO)REFERENCES ADMINISTRATOR(ADM_NO),
 FOREIGN KEY(F_NO)REFERENCES FEATURES_TABLE(F_NO)
 );

CREATE TABLE CUSTOMER_MESSAGE(
CM_ID VARCHAR2(30) not null PRIMARY KEY,
CM_TIME TIMESTAMP DEFAULT current_timestamp,
CM_WORD clob,
CM_PIC blob,
CM_STATUS NUMBER(1),
CM_CUSTOMERID VARCHAR2(30) references MEMBER(MEM_ID)
);

CREATE TABLE ONE_TO_ONE(
CR_ID VARCHAR2(30) not null PRIMARY KEY,
USER_ONE VARCHAR2(30) references MEMBER(MEM_ID),
USER_TWO VARCHAR2(30) references MEMBER(MEM_ID),
CR_TIME TIMESTAMP DEFAULT current_timestamp,
CR_WORD clob,
CR_PIC blob,
CR_STATUS NUMBER(1)
);

CREATE TABLE PTYPE(
    PTYPE_ID NUMBER(30) PRIMARY KEY NOT NULL,
    TYPE VARCHAR2(30)
);

CREATE TABLE POST(
    POST_ID VARCHAR2(30) PRIMARY KEY NOT NULL,
    MEM_ID VARCHAR2(30) NOT NULL,
    PTYPE_ID NUMBER(30) NOT NULL,
    P_STATUS NUMBER(1) NOT NULL,
    P_TITLE VARCHAR2(200) NOT NULL,
    TEXT CLOB NOT NULL,
    IMAGE BLOB,
    LAST_EDIT TIMESTAMP,
    POST_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_POST_MEMBER
    FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID),
    CONSTRAINT FK_POST_PTYPE
    FOREIGN KEY (PTYPE_ID) REFERENCES PTYPE(PTYPE_ID)
);

CREATE TABLE COMM(
    COMM_ID VARCHAR2(30) PRIMARY KEY NOT NULL,
    POST_ID VARCHAR2(30) NOT NULL,
    MEM_ID VARCHAR2(30) NOT NULL,
    C_STATUS NUMBER(1) NOT NULL,
    C_TEXT CLOB NOT NULL,
    LAST_EDIT TIMESTAMP,
    POST_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_COMM_POST
    FOREIGN KEY (POST_ID) REFERENCES POST(POST_ID),
    CONSTRAINT FK_COMM_MEMBER
    FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID)
);

CREATE TABLE FAVORITE_POST(
    MEM_ID VARCHAR2(30),
    POST_ID VARCHAR2(30),
    CONSTRAINT PK_FAV
    PRIMARY KEY (MEM_ID, POST_ID),
    CONSTRAINT FK_FAV_MEMBER
    FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID),
    CONSTRAINT FK_FAV_POST
    FOREIGN KEY (POST_ID) REFERENCES POST(POST_ID)
);

CREATE TABLE PRODUCT_TYPE(
    PT_ID VARCHAR2(10) PRIMARY KEY NOT NULL,
    TYPENAME VARCHAR2(30)
);

CREATE TABLE ORDSTAT(
    ORDSTAT_ID VARCHAR2(3) PRIMARY KEY NOT NULL,
    ORDSTAT    VARCHAR2(20)
);

CREATE TABLE DISCOUNT(
    DIS_ID VARCHAR2(10) PRIMARY KEY NOT NULL,
    DIS_NAME VARCHAR2(40),
    STAR_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    END_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE PRODUCT(
    P_ID VARCHAR2(10) PRIMARY KEY NOT NULL,
    PT_ID VARCHAR2(10) REFERENCES PRODUCT_TYPE(PT_ID) NOT NULL,
    P_NAME VARCHAR2(40),
    P_PRICE NUMBER,
    P_IMAGE BLOB,
    P_INFO CLOB,
    P_SALES NUMBER,
    P_STOCK NUMBER,
    P_ADD_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    P_STAT NUMBER
);

CREATE TABLE FAVOURITE_PRODUCT(
    P_ID VARCHAR2(10) REFERENCES PRODUCT(P_ID)  NOT NULL,
    MEM_ID VARCHAR(10) REFERENCES MEMBER(MEM_ID)  NOT NULL,
    PRIMARY KEY(P_ID,MEM_ID)
);

CREATE TABLE PRODUCT_ORDER(
    PO_ID VARCHAR2(20) PRIMARY KEY NOT NULL,
    MEM_ID VARCHAR2(20) REFERENCES MEMBER(MEM_ID),
    ORDSTAT_ID VARCHAR2(3) REFERENCES ORDSTAT(ORDSTAT_ID),
    ADD_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    AMOUNT NUMBER,
    RETURN_FORM CLOB
);

CREATE TABLE PRODUCT_ORDER_LIST(
    PO_ID VARCHAR2(20) REFERENCES PRODUCT_ORDER(PO_ID)  NOT NULL,
    P_ID VARCHAR2(10) REFERENCES PRODUCT(P_ID)  NOT NULL,
    ORDER_QUA NUMBER,
    P_PRICE NUMBER,
    PRIMARY KEY(PO_ID,P_ID)
);

CREATE TABLE DISCOUNT_LIST(
    P_ID VARCHAR2(10) REFERENCES PRODUCT(P_ID)  NOT NULL,
    DIS_ID VARCHAR2(10) REFERENCES DISCOUNT(DIS_ID)  NOT NULL,
    DIS_PRICE NUMBER,
    PRIMARY KEY(P_ID,DIS_ID)
);

CREATE TABLE BOUNS_STATE(
    BS_ID VARCHAR2(5) PRIMARY KEY NOT NULL,
    BS_STAT VARCHAR2(50)
);

CREATE TABLE BOUNS_MALL (
    BON_ID VARCHAR2(30) PRIMARY KEY NOT NULL,
    PT_ID VARCHAR2(10) NOT NULL,
    CONSTRAINT FK_BOUNS_MALL_PRODUCT_TYPE FOREIGN KEY ( PT_ID )
        REFERENCES PRODUCT_TYPE ( PT_ID ),
    BON_NAME VARCHAR2(100) NOT NULL,
    BON_PRICE NUMBER(20) CHECK ( BON_PRICE >= 0 ),
    BON_IMAGE BLOB,
    BON_INFO VARCHAR2(4000) NOT NULL,
    BON_EXCHANGE NUMBER(10) CHECK ( BON_EXCHANGE >= 0 ),
    BON_STOCK NUMBER(10) NOT NULL CHECK ( BON_STOCK >= 0 ),
    BON_ADDDATE DATE DEFAULT CURRENT_TIMESTAMP,
    BON_STATUS VARCHAR2(5) NOT NULL
);

CREATE TABLE BOUNS_ORDER(
    ORD_ID VARCHAR2(30) PRIMARY KEY NOT NULL,
    MEM_ID VARCHAR2(30) NOT NULL,
    CONSTRAINT FK_BOUNS_ORDER_MEMBER FOREIGN KEY ( MEM_ID )
        REFERENCES MEMBER ( MEM_ID ),
    BON_ID VARCHAR2(30) NOT NULL,
    CONSTRAINT FK_BOUNS_ORDER_BONUS_MALL FOREIGN KEY ( BON_ID )
        REFERENCES BOUNS_MALL ( BON_ID ),
    ORD_DATE DATE DEFAULT CURRENT_TIMESTAMP,
    BS_ID VARCHAR2(5),
    CONSTRAINT FK_BONUS_ORDER_BOUNS_STATE FOREIGN KEY ( BS_ID )
        REFERENCES BOUNS_STATE ( BS_ID )
);

CREATE TABLE FAVOURITE_BOUNS(
    MEM_ID VARCHAR2(30) NOT NULL,
    CONSTRAINT FK_FAVOURITE_BOUNS_MEMBER FOREIGN KEY ( MEM_ID )
        REFERENCES MEMBER ( MEM_ID ),
    BON_ID VARCHAR2(30) NOT NULL,
    CONSTRAINT FK_FAVOURITE_BOUNS_BOUNS_MALL FOREIGN KEY ( BON_ID )
        REFERENCES BOUNS_MALL ( BON_ID )
);

CREATE TABLE AUCT (
    AUCT_ID VARCHAR2(10) PRIMARY KEY NOT NULL,
    SALE_ID VARCHAR2(7) NOT NULL,   
    BUY_ID VARCHAR2(7),
    PT_ID VARCHAR2(10),
    AUCT_NAME VARCHAR2(200)  NOT NULL,
    AUCT_START TIMESTAMP,
    AUCT_END TIMESTAMP,
    MARKETPRICE NUMBER(20),
    INITPRICE  NUMBER(20)  NOT NULL,
    AUCT_INC  NUMBER(10),
    MAXPRICE  NUMBER(20),
    AUCT_DESC CLOB,
    AUCT_PIC BLOB,
    AUCT_SOLD NUMBER(5),
    AUCT_DOWN NUMBER(5),
    ORDSTAT_ID VARCHAR2(10),
    ORD_TIME TIMESTAMP,
    PAY_END TIMESTAMP,
    RCPT_NAME VARCHAR2(50),
    RCPT_CEL VARCHAR2(30),
    RCPT_ADD VARCHAR2(200),
    CONSTRAINT FK1_AUCT_MEMBER
    FOREIGN KEY (SALE_ID) REFERENCES MEMBER (MEM_ID),
    CONSTRAINT FK2_AUCT_MEMBER
    FOREIGN KEY (BUY_ID) REFERENCES MEMBER (MEM_ID),
    CONSTRAINT FK3_AUCT_PRODUCT_TYPE
    FOREIGN KEY (PT_ID) REFERENCES PRODUCT_TYPE (PT_ID),
    CONSTRAINT FK4_AUCT_ORDSTAT
    FOREIGN KEY (ORDSTAT_ID) REFERENCES ORDSTAT(ORDSTAT_ID)
 );

 CREATE TABLE IMMED (
    IMMED_ID VARCHAR2(11) PRIMARY KEY NOT NULL,
    SALE_ID VARCHAR2(7) NOT NULL,   
    BUY_ID VARCHAR2(7),
    PT_ID VARCHAR2(10),
    IMMED_NAME VARCHAR2(200) NOT NULL,
    IMMED_START TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    IMMED_PRC NUMBER(20),
    IMMED_PIC BLOB,
    IMMED_DESC CLOB,
    IMMED_SOLD NUMBER(5),
    IMMED_DOWN NUMBER(5),
    ORD_TIME TIMESTAMP,
    ORDSTAT_ID VARCHAR2(10),
    RCPT_NAME VARCHAR2(50),
    RCPT_CELL VARCHAR2(30),
    RCPT_ADD VARCHAR2(200),
    CONSTRAINT FK1_IMMED_MEMBER
    FOREIGN KEY (SALE_ID) REFERENCES MEMBER (MEM_ID),
    CONSTRAINT FK2_IMMED_MEMBER
    FOREIGN KEY (BUY_ID) REFERENCES MEMBER (MEM_ID),
    CONSTRAINT FK3_IMMED_PRODUCT_TYPE
    FOREIGN KEY (PT_ID) REFERENCES PRODUCT_TYPE (PT_ID),
    CONSTRAINT FK4_IMMED_ORDSTAT
    FOREIGN KEY (ORDSTAT_ID) REFERENCES ORDSTAT(ORDSTAT_ID)
 );

CREATE TABLE BID(
    BID_ID VARCHAR2(9) NOT NULL,
    AUCT_ID VARCHAR2(10) NOT NULL,
    BUY_ID VARCHAR2(7) NOT NULL,
    BID_PRC NUMBER(20) NOT NULL,
    BID_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
    BID_WIN NUMBER(10) NOT NULL,
    CONSTRAINT PK_BID PRIMARY KEY (BID_ID),
    CONSTRAINT FK1_BID_AUCT
    FOREIGN KEY (AUCT_ID) REFERENCES AUCT (AUCT_ID),
    CONSTRAINT FK2_BID_MEMBER
    FOREIGN KEY (BUY_ID) REFERENCES MEMBER (MEM_ID)
);

CREATE TABLE REBATE (
  REB_NO VARCHAR2(10) PRIMARY KEY NOT NULL,
  DISCOUNT NUMBER(10, 2),
  PEOPLE NUMBER(10)
);

CREATE TABLE GROUPBUY(
GRO_ID VARCHAR2(10) constraint groupbuy_grono_pk primary key,
START_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
END_DATE TIMESTAMP,
GROTIME NUMBER(3),
STATUS NUMBER(20),
PEOPLE NUMBER(10),
MONEY NUMBER(20, 2),
AMOUNT NUMBER(20) NOT NULL,
P_ID VARCHAR2(10) unique NOT NULL constraint product_p_id_fk references product(P_ID),
REB1_NO VARCHAR2(10)constraint rebate_reb1_no_fk references rebate(REB_NO),
REB2_NO VARCHAR2(10)constraint rebate_reb2_no_fk references rebate(REB_NO),
REB3_NO VARCHAR2(10)constraint rebate_reb3_no_fk references rebate(REB_NO)
);

CREATE TABLE GRO_ORDER (
  ORD_ID VARCHAR2(10) PRIMARY KEY NOT NULL,
  ADD_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  MEM_ID VARCHAR2(10)NOT NULL REFERENCES MEMBER(MEM_ID),
  GRO_ID VARCHAR2(10)NOT NULL REFERENCES GROUPBUY(GRO_ID),
  ORDSTAT_ID VARCHAR2(3)NOT NULL REFERENCES ORDSTAT(ORDSTAT_ID)
);

create table FAVOURITE_GRO(
	MEM_ID 	varchar2(10)	not null,
	GRO_ID	VARCHAR2(10)	not null,
	constraint FAVOURITE_GRO_mem_id_gro_id_pk primary key (MEM_ID,GRO_ID),
	constraint MEMBER_mem_id_fk foreign key (MEM_ID) references MEMBER (MEM_ID),
	constraint GROUPBUY_gro_id_fk foreign key (GRO_ID) references GROUPBUY (GRO_ID)
);

create table GRO_MEM(
	MEM_ID 	varchar2(10)not null,
	GRO_ID	VARCHAR2(10)not null,

	constraint GRO_MEM_MEM_ID_fk foreign key (MEM_ID) references MEMBER (MEM_ID),
	constraint GRO_MEM_gro_id_fk foreign key (GRO_ID) references groupbuy (GRO_ID),
    constraint GRO_MEM_MEM_ID_pk primary key(GRO_ID,MEM_ID)
);

CREATE TABLE POSTACCUSE (
 PSAC_NO                 VARCHAR2(30) PRIMARY KEY NOT NULL,
 MEM_ID                  VARCHAR2(30),
 POST_ID                 VARCHAR2(30),
 ADM_NO                  VARCHAR2(30),
 PSAC_CONTENT            CLOB,
 PSAC_STATE              NUMBER(3),
 FOREIGN KEY(MEM_ID)REFERENCES MEMBER(MEM_ID),
 FOREIGN KEY(MEM_ID)REFERENCES MEMBER(MEM_ID),
 FOREIGN KEY(ADM_NO)REFERENCES ADMINISTRATOR(ADM_NO)
);

CREATE TABLE MEMBERACCUSE (
 MEMAC_NO                 VARCHAR2(30) PRIMARY KEY NOT NULL,
 ADM_NO                   VARCHAR2(30),
 MEMAC_CONTENT            CLOB,
 MEMAC_STATE              NUMBER(3),
 MEM1_ID  VARCHAR2(30) REFERENCES MEMBER(MEM_ID),
 MEM2_ID  VARCHAR2(30) REFERENCES MEMBER(MEM_ID),
 FOREIGN KEY(ADM_NO)REFERENCES ADMINISTRATOR(ADM_NO)
);

CREATE TABLE AUCTACCUSE (
 AUCTAC_NO                 VARCHAR2(30) PRIMARY KEY NOT NULL,
 MEM_ID                    VARCHAR2(30),
 AUCT_ID                   VARCHAR2(10),
 ADM_NO                    VARCHAR2(30),
 AUCTAC_CONTENT            CLOB,
 AUCTAC_STATE              NUMBER(30),
 FOREIGN KEY(MEM_ID)REFERENCES MEMBER(MEM_ID),
 FOREIGN KEY(AUCT_ID)REFERENCES AUCT(AUCT_ID),
 FOREIGN KEY(ADM_NO)REFERENCES ADMINISTRATOR(ADM_NO)
 );
 
 CREATE TABLE IMMEDACCUSE (
 IMMEDAC_NO                 VARCHAR2(30) PRIMARY KEY NOT NULL,
 MEM_ID                    VARCHAR2(30),
 IMMED_ID                   VARCHAR2(11),
 ADM_NO                    VARCHAR2(30),
 IMMEDAC_CONTENT            CLOB,
 IMMEDAC_STATE              NUMBER(30),
 FOREIGN KEY(MEM_ID)REFERENCES MEMBER(MEM_ID),
 FOREIGN KEY(IMMED_ID)REFERENCES IMMED(IMMED_ID),
 FOREIGN KEY(ADM_NO)REFERENCES ADMINISTRATOR(ADM_NO)
 );
 
create table question(
QA_ID VARCHAR2(10) not null PRIMARY KEY,
ANS clob,
QUE clob
);

-----------------------------TABLE-----------------------------

-----------------------------SEQUENCE-----------------------------

CREATE SEQUENCE MEMBER_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE SEQ_DIS_ID 
INCREMENT BY 1 
START WITH 1 
NOMAXVALUE
;

CREATE SEQUENCE SEQ_ORESTAT_ID 
INCREMENT BY 1 
START WITH 1  
NOMAXVALUE 
;
CREATE SEQUENCE SEQ_P_ID 
INCREMENT BY 1 
START WITH 1 
NOMAXVALUE
;
CREATE SEQUENCE SEQ_PO_ID 
INCREMENT BY 1 
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE PTYPE_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE POST_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE COMM_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE CM_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE CR_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE BOUNS_STATE_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE
;

CREATE SEQUENCE BOUNS_MALL_SEQ
START WITH 1
INCREMENT BY 1
;

CREATE SEQUENCE BOUNS_ORDER_SEQ
START WITH 1
INCREMENT BY 1
;

CREATE SEQUENCE ORDSTAT_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE AUCT_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE IMMED_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE BID_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;




create sequence REBATE_seq
increment by 1
start with 1
nomaxvalue
nocycle
nocache
;

create sequence GROUPBUY_seq
increment by 1
start with 1
nomaxvalue
nocycle
nocache
;

create sequence GRO_ORDER_seq
increment by 1
start with 1
nomaxvalue
nocycle
nocache
;

CREATE SEQUENCE ADMINISTRATOR_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 ;
 
 CREATE SEQUENCE FEATURES_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 ;
 
CREATE SEQUENCE POSTACCUSE_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE 
 ;
 
 CREATE SEQUENCE MEMBERACCUSE_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 ;
 
 CREATE SEQUENCE AUCTACCUSE_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 ;
 
 CREATE SEQUENCE IMMEDACCUSE_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 ;
 
 CREATE SEQUENCE QUESTION_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 ;

-----------------------------SEQUENCE-----------------------------

-----------------------------新增會員-----------------------------

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_ICON, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'servereDiarrhea@gmail.com', '123456', '早餐店大冰奶', load_blob('Member/1.jpg'), '0912345678', '桃園市中壢區中大路300號', '121234512345', '1234567898765432', '2028', '11', '876', 2, 5000, to_date('1970-01-01', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_ICON, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'pg18Guardian@gmail.com', '123456', '十八禁銅人', load_blob('Member/2.jpg'), '0987654321', '桃園市中壢區三光路115號', '43215678912345', '9876123476545678', '2023', '04', '551', 2, 499, to_date('1970-01-02', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_ICON, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'neutralVoter@gmail.com', '123456', '中壢李姓選民', load_blob('Member/3.jpg'), '0923456789', '桃園市中壢區健行路229號', '843257564928', '7364856382659380', '2021', '06', '366', 2, 16888, to_date('1970-01-03', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_ICON, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'alBacino@gmail.com', '123456', '艾爾不怕西諾', load_blob('Member/4.jpg'), '0934567890', '桃園市中壢區林森路95號', '47584776534274', '5828565532195890', '2011', '02', '313', 2, 23999, to_date('1970-01-04', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_ICON, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'tomohisaAtFGS@gmail.com', '123456', '金寶山下製酒', load_blob('Member/5.jpg'), '0945678901', '桃園市中壢區元化路357號', '8475875947599', '5638449676900713', '2028', '10', '335', 2, 33666, to_date('1970-01-05', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_ICON, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'johnCenan@gmail.com', '123456', '江西男', load_blob('Member/6.jpg'), '0956789012', '桃園市平鎮區振興路2號', '334785769930', '2274388900216475', '2031', '10', '585', 2, 66666, to_date('1970-01-06', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_ICON, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'iPadWarmWater@gmail.com', '123456', '一定iPad溫開水', load_blob('Member/7.jpg'), '0967890123', '桃園市平鎮區環南路三段100號', '54909483775894', '1385966849604958', '2024', '05', '984', 2, 55123, to_date('1970-01-07', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_ICON, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'ayalReallyStrict@gmail.com', '123456', '阿粵真der很嚴格', load_blob('Member/8.jpg'), '0978901234', '桃園市中壢區廣州路25號', '447384758672', '6485938495069485', '2029', '12', '374', 2, 123456, to_date('1970-01-08', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_ICON, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'fiveSpeedMouth@gmail.com', '123456', '投資一定有風險', load_blob('Member/9.jpg'), '0989012345', '桃園市中壢區龍東路750號', '31326654694948', '8377586849586757', '2026', '08', '394', 2, 23456, to_date('1970-01-09', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_ICON, MEM_PHONE, MEM_ADDR, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'fiveSpeedMouth2@gmail.com', '123456', '基金投資有賺有賠', load_blob('Member/10.jpg'), '0990123456', '桃園市八德區山下街115號', '3948586948594739', '2023', '04', '118', 1, 34567, to_date('1970-01-10', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_ICON, MEM_PHONE, MEM_ADDR, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'prospectus@gmail.com', '123456', '申購前應詳閱公開說明書', load_blob('Member/11.jpg'), '0901234567', '桃園市八德區廣德里18鄰廣興路601巷25號', '8374857687748576', '2022', '09', '368', 1, 45678, to_date('1970-01-11', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_ICON, MEM_PHONE, MEM_ADDR, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'admin@gmail.com', '123456', '平台管理員', load_blob('Member/12.jpg'), '0901234567', '桃園市中壢區華勛街363巷', 99, 50000, to_date('1970-01-12', 'yyyy-mm-dd'), 0);

-----------------------------新增會員-----------------------------

-----------------------------新增管理員-----------------------------

INSERT INTO ADMINISTRATOR VALUES ('ad'||LPAD(to_char(administrator_seq.NEXTVAL),6,'0'),'DAVID','123456','DAVID',1);
INSERT INTO ADMINISTRATOR VALUES ('ad'||LPAD(to_char(administrator_seq.NEXTVAL),6,'0'),'JAMES','168888','JAMES',1);
INSERT INTO ADMINISTRATOR VALUES ('ad'||LPAD(to_char(administrator_seq.NEXTVAL),6,'0'),'JIM','080808','JIM',0);
INSERT INTO ADMINISTRATOR VALUES ('ad'||LPAD(to_char(administrator_seq.NEXTVAL),6,'0'),'JOHN','567890','JOHN',1);
INSERT INTO ADMINISTRATOR VALUES ('ad'||LPAD(to_char(administrator_seq.NEXTVAL),6,'0'),'JUDY','556656','JUDY',1);
INSERT INTO ADMINISTRATOR VALUES ('ad'||LPAD(to_char(administrator_seq.NEXTVAL),6,'0'),'ALICE','878787','ALICE',1);

-----------------------------新增管理員-----------------------------

-----------------------------新增管理員功能-----------------------------

INSERT INTO FEATURES_TABLE VALUES ('f'||LPAD(to_char(features_seq.NEXTVAL),6,'0'),'新增帳號/密碼');
INSERT INTO FEATURES_TABLE VALUES ('f'||LPAD(to_char(features_seq.NEXTVAL),6,'0'),'修改帳號/密碼');
INSERT INTO FEATURES_TABLE VALUES ('f'||LPAD(to_char(features_seq.NEXTVAL),6,'0'),'修改會員檢舉案狀態');
INSERT INTO FEATURES_TABLE VALUES ('f'||LPAD(to_char(features_seq.NEXTVAL),6,'0'),'修改文章檢舉案狀態');
INSERT INTO FEATURES_TABLE VALUES ('f'||LPAD(to_char(features_seq.NEXTVAL),6,'0'),'修改商品檢舉案狀態');

-----------------------------新增管理員功能-----------------------------

-----------------------------新增管理員權限-----------------------------

INSERT INTO AUTHORITY_TABLE VALUES ('ad000001','f000002');
INSERT INTO AUTHORITY_TABLE VALUES ('ad000003','f000002');
INSERT INTO AUTHORITY_TABLE VALUES ('ad000004','f000002');
INSERT INTO AUTHORITY_TABLE VALUES ('ad000005','f000002');
INSERT INTO AUTHORITY_TABLE VALUES ('ad000002','f000002');
INSERT INTO AUTHORITY_TABLE VALUES ('ad000006','f000002');

-----------------------------新增管理員權限-----------------------------

---商品分類 PRODUCT_TYPE---

INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('1',3,'0'),'Switch主機');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('2',3,'0'),'Switch遊戲');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('3',3,'0'),'Switch周邊');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('4',3,'0'),'PS4主機');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('5',3,'0'),'PS4遊戲');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('6',3,'0'),'PS4周邊');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('7',3,'0'),'XBOX主機');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('8',3,'0'),'XBOX遊戲');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('9',3,'0'),'XBOX周邊');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('10',3,'0'),'其他');

---商品分類 PRODUCT_TYPE---

---限時優惠專案 DISCOUNT---

INSERT INTO DISCOUNT(DIS_ID,DIS_NAME,STAR_DATE,END_DATE)
VALUES('DIS'||LPAD(TO_CHAR(SEQ_DIS_ID.NEXTVAL),3,'0'),'單身狗優惠','2020-11-11','2020-11-12');
INSERT INTO DISCOUNT(DIS_ID,DIS_NAME,STAR_DATE,END_DATE)
VALUES('DIS'||LPAD(TO_CHAR(SEQ_DIS_ID.NEXTVAL),3,'0'),'爸爸節優惠','2020-08-08','2020-08-09');
INSERT INTO DISCOUNT(DIS_ID,DIS_NAME,STAR_DATE,END_DATE)
VALUES('DIS'||LPAD(TO_CHAR(SEQ_DIS_ID.NEXTVAL),3,'0'),'聖誕節優惠','2020-12-25','2020-12-26');

---限時優惠專案 DISCOUNT---

---商城商品 PRODUCT---

INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE, P_IMAGE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT001','Nintendo Switch',9780, load_blob('Product/product1.jpg'),'
▉ 可遊玩時間加長!!!

▉ 遊戲生活變得更加互動

▉ 改變形態多種遊戲模式：TV模式、桌上模式、手提模式

▉ 最多連線8台主機，進行對戰或協力遊戲

▉ Joy-Con內置「HD震動」體驗逼真細膩臨場感

▉ 台灣公司貨，提供1年保固'
,2,500,1);

INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE, P_IMAGE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT002','集合啦！動物森友會',1790, load_blob('Product/product2.jpg'),'
主機平台：Nintendo Switch ( NS )

遊戲類型：其他

發售日期：2020-03-20

遊戲人數：多人

作品分級：保護級

製作廠商：Nintendo

發行廠商：Nintendo

代理廠商：香港任天堂

官方網站：https://www.nintendo.tw/switch/animal_crossing_new_horizons/'
,3,500,1);
INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE, P_IMAGE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT003','動物之森 支架 for Nintendo Switch ',550, load_blob('Product/product3.jpg'),'
■ Nintendo Switch 專用桌上型支架

■ 18mm超輕巧NS螢幕立架可折疊、輕巧好攜帶、三段式角度調整

■ 貼心充電孔、可一邊充電一邊遊玩'
,1,500,1);
INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE, P_IMAGE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT004','PS4 Pro 專業版 主機 極致黑 1TB',12980, load_blob('Product/product4.jpg'),'
■全新CUH-7200系列

■硬體容量為1TB

■支援 4K 超高解析度

■PS4 遊戲均以1080p 解像度呈現

■支援已發售及將會發售的所有PS4遊戲'
,5,500,1);
INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE, P_IMAGE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT005','湯姆克蘭西：全境封鎖 2',590, load_blob('Product/product5.jpg'),'
主機平台：PS4

遊戲類型：射擊

發售日期：2019年預定

遊戲人數：多人

作品分級：CERO D

製作廠商：Massive Entertainment

發行廠商：Ubisoft

官方網站：https://tomclancy-thedivision.ubisoft.com/game/en-gb/home'
,2,500,1);
INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE, P_IMAGE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT006','原廠無線手把',1780, load_blob('Product/product6.jpg'),'
適用於電腦和Xbox One

有線控制器

舒適度及操作度提升',3,500,1);
INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE, P_IMAGE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT007','Xbox One S',7980, load_blob('Product/product7.jpg'),'
▉ 全面數位化，個人遊戲庫

▉ 超值的價錢 豐富的遊戲和娛樂

▉ 效能依然強悍，支援4K與HDR

▉ 內含3款遊戲

▉ 本主機無藍光光碟機'
,4,500,1);
INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT008','絕地求生',839,'
遊戲類型：射擊

發售日期：2017-12-12

遊戲人數：多人

作品分級：CERO D

製作廠商：Bluehole,PlayerUnknown''s Battle Royale G

發行廠商：Microsoft Studios

代理廠商：台灣微軟

官方網站：https://playbattlegrounds.com/'
,1,500,1);

INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT009','Xbox One 無線控制器(黑色)',1549,'
適用於電腦和Xbox One

有線控制器

舒適度及操作度提升',0,500,1);

---商城商品 PRODUCT---

---我的最愛．商城 FAVOURITE_PRODUCT---

INSERT INTO FAVOURITE_PRODUCT(P_ID,MEM_ID)
VALUES('P001','M000001');
INSERT INTO FAVOURITE_PRODUCT(P_ID,MEM_ID)
VALUES('P003','M000001');
INSERT INTO FAVOURITE_PRODUCT(P_ID,MEM_ID)
VALUES('P005','M000001');
INSERT INTO FAVOURITE_PRODUCT(P_ID,MEM_ID)
VALUES('P004','M000002');
INSERT INTO FAVOURITE_PRODUCT(P_ID,MEM_ID)
VALUES('P005','M000002');
INSERT INTO FAVOURITE_PRODUCT(P_ID,MEM_ID)
VALUES('P009','M000002');

---我的最愛．商城 FAVOURITE_PRODUCT---

-----------------------------新增訂單狀態種類-----------------------------

INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '訂單成立');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '待付款');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '已付款,待出貨');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '未付款,待出貨');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '已送達,待收貨');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '已收貨');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '已取消訂單');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '成立換貨');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '成立退貨');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '商品回收中');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '檢驗中');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '退款中');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '已退款');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '完成');

-----------------------------新增訂單狀態種類-----------------------------

-----商城訂單 PRODUCT_ORDER---

INSERT INTO PRODUCT_ORDER(PO_ID,MEM_ID,ORDSTAT_ID)
VALUES(TO_CHAR(sysdate,'yyyy-mm-dd')||'-'||LPAD(TO_CHAR(SEQ_PO_ID.NEXTVAL),6,'0'),'M000001','002');
INSERT INTO PRODUCT_ORDER(PO_ID,MEM_ID,ORDSTAT_ID)
VALUES(TO_CHAR(sysdate,'yyyy-mm-dd')||'-'||LPAD(TO_CHAR(SEQ_PO_ID.NEXTVAL),6,'0'),'M000002','005');

-----商城訂單 PRODUCT_ORDER---

-----商城訂單明細 PRODUCT_ORDER_LIST---

INSERT INTO PRODUCT_ORDER_LIST(PO_ID,P_ID,ORDER_QUA,P_PRICE)
VALUES(TO_CHAR(sysdate,'yyyy-mm-dd')||'-'||'000001','P002',1,1790);
INSERT INTO PRODUCT_ORDER_LIST(PO_ID,P_ID,ORDER_QUA,P_PRICE)
VALUES(TO_CHAR(sysdate,'yyyy-mm-dd')||'-'||'000001','P003',1,550);
INSERT INTO PRODUCT_ORDER_LIST(PO_ID,P_ID,ORDER_QUA,P_PRICE)
VALUES(TO_CHAR(sysdate,'yyyy-mm-dd')||'-'||'000002','P005',1,590);
INSERT INTO PRODUCT_ORDER_LIST(PO_ID,P_ID,ORDER_QUA,P_PRICE)
VALUES(TO_CHAR(sysdate,'yyyy-mm-dd')||'-'||'000002','P009',2,1549);

-----商城訂單明細 PRODUCT_ORDER_LIST---

---限時優惠專案細項 DISCOUNT_LIST---

INSERT INTO DISCOUNT_LIST(P_ID,DIS_ID,DIS_PRICE)
VALUES('P001','DIS001',1111);
INSERT INTO DISCOUNT_LIST(P_ID,DIS_ID,DIS_PRICE)
VALUES('P002','DIS002',8888);
INSERT INTO DISCOUNT_LIST(P_ID,DIS_ID,DIS_PRICE)
VALUES('P003','DIS003',520);

---限時優惠專案細項 DISCOUNT_LIST---

-----------------------------新增文章類型-----------------------------

INSERT INTO ptype (ptype_id, type) VALUES (ptype_seq.NEXTVAL, '心得');
INSERT INTO ptype (ptype_id, type) VALUES (ptype_seq.NEXTVAL, '情報');
INSERT INTO ptype (ptype_id, type) VALUES (ptype_seq.NEXTVAL, '閒聊');
INSERT INTO ptype (ptype_id, type) VALUES (ptype_seq.NEXTVAL, '問題');
INSERT INTO ptype (ptype_id, type) VALUES (ptype_seq.NEXTVAL, '平台資訊');

-----------------------------新增文章類型-----------------------------

-----------------------------新增文章-----------------------------

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, IMAGE, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000001', 3, 1, '一直拉 從昨晚腹瀉了24小時怎麼辦？', '

<p>
大家好
</p>
<p>
我肥宅啦
</p>
<p>
昨天晚上突然猛拉
</p>
<p>
一開始覺得還好有點嚴重（我想說還好）
</p>
<p>
就吃新表飛鳴 跑去睡了
</p>
<p>
結果被屎意嚇醒 整床都是拉稀
</p>
<p>
昨天連續拉了一整天
</p>
<p>
好不容易晚上九點  控制一下 去看醫生
</p>
<p>
回家吃了一包藥 吃了雞湯粥
</p>
<p>
剛過十二點 想說睡覺時間差不多了
</p>
<p>
吃「一顆強力止瀉藥」
</p>
<p>
結果這短短一小時我又拉了四次
</p>
<p>
我是不是得到什麼病毒啊......
</p>
<p>
醫生也只說吃壞肚子而已嗚嗚嗚嗚
</p>

', load_blob('Post/001.jpg'), SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, IMAGE, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000002', 3, 1, '為什麼才剛上班就有人在刷牙？', '
如題

<p>
為什麼才剛上班就有人在刷牙？
</p>
<p>
刷牙不是起床在家就刷玩了嗎？
</p>
<p>
同樣也是有人在上班剪指甲
</p>
<p>
在公司剪有什麼魔力嗎？
</p>
<p>
我很好奇
</p>

', load_blob('Post/002.jpg'), SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, IMAGE, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000002', 3, 1, '8+9屁孩語錄有哪些？', '

<p>
大家安安
</p>
<p>
#Just do it
</p>
<p>
#莫忘初衷
</p>
<p>
#狼若回頭 不是報恩就是報仇
</p>
<p>
#OO在走 XX要有
</p>
<p>
8+9屁孩語錄還有哪些？
</p>

', load_blob('Post/003.png'), SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, IMAGE, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000002', 3, 1, '只有台灣的牛排有麵嗎？', '

<p>
除了一些外國或高檔的餐廳以外
</p>
<p>
台灣本地不管是夜市或連鎖店、小牛排館的牛排大都是有附加麵的
</p>
<p>
台灣人從小也是很理所當然牛排有麵
</p>
<p>
但是其它國家的聽說都只有肉跟主菜而已，中國沒吃過不知道
</p>
<p>
有沒有全世界只有台灣的牛排有麵的八卦？
</p>
', load_blob('Post/004.jpg'), SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, IMAGE, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000002', 3, 1, '在山上種田養豬雞牛羊自己自足要多少錢？', '

<p>
在山上，蓋間小屋，屋子四周，種田種地瓜馬玲薯各種菜葱薑蒜
</p>
<p>
再養些豬雞牛羊，想吃肉就殺一隻
</p>
<p>
過著盡量少花錢，自己自足的生活
</p>
<p>
從此不再被政客資本家銀行家剝削
</p>
<p>
醬要多少地多少錢啊
</p>
<p>
在山上種田養豬雞牛羊自己自足要多少錢？
</p>

', load_blob('Post/005.png'), SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, IMAGE, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000001', 3, 1, '欸，白開水不是白色的啊？', '

<p>
長輩每次都說
</p>
<p>
你們小孩子啊，只會喝飲料
</p>
<p>
都不喝白開水
</p>
<p>
我想了想
</p>
<p>
不對啊
</p>
<p>
開水就不是白色的
</p>
<p>
是在白什麼？
</p>

', load_blob('Post/006.png'), SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, IMAGE, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000001', 3, 1, '台南沙茶火鍋誰才是最強', '

<p>
乳啼
</p>
<p>
台南號稱美食聖地，是否有能屌打林聰明或是台中
</p>
<p>
汕頭沙茶鍋的沙茶火鍋呢？
</p>
<p>
小豪洲 和二月牌 夠格嗎？
</p>
<p>
還是又是我家巷口屌打？
</p>
<p>
有掛嗎？
</p>

', load_blob('Post/007.png'), SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, IMAGE, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000001', 3, 1, '出桶了該如何慶祝？！', '

<p>
大家晚安啊
</p>
<p>
是這樣的
</p>
<p>
我剛剛發現我出桶了
</p>
<p>
上個月因為不小心超貼問卦
</p>
<p>
所以被桶了一個月
</p>
<p>
真的是有夠智障
</p>
<p>
忍了一個月又可以在八卦發言
</p>
<p>
感覺真好
</p>
<p>
所以我該如何慶祝？
</p>
<p>
有卦嗎？
</p>
', load_blob('Post/008.jpg'), SYSDATE);

-----------------------------新增文章-----------------------------

-----------------------------新增留言-----------------------------

INSERT INTO comm
(COMM_ID, POST_ID, MEM_ID, C_STATUS, C_TEXT, LAST_EDIT)
VALUES
('COMM'||LPAD(to_char(COMM_SEQ.NEXTVAL), 6, '0'), 'POST000001', 'M000002', 1, '
</p>
<p>
真的學不到什麼東西 
</p>
<p>
除非他玩蠻王之類的
</p>
<p>不過大部分都練角
</p>
<p>而且也很少看小地圖
</p>
<p>也不會去預測jg位置
</p>
<p>都是做效果居多
</p>
<p>如果學他玩大機率會下去
</p>
', SYSDATE);

INSERT INTO comm
(COMM_ID, POST_ID, MEM_ID, C_STATUS, C_TEXT, LAST_EDIT)
VALUES
('COMM'||LPAD(to_char(COMM_SEQ.NEXTVAL), 6, '0'), 'POST000001', 'M000005', 1, '

<p>
謝謝各位的建議
</p>
<p>
我還在銅牌地獄慢慢往上爬....
</p>
', SYSDATE);

INSERT INTO comm
(COMM_ID, POST_ID, MEM_ID, C_STATUS, C_TEXT, LAST_EDIT)
VALUES
('COMM'||LPAD(to_char(COMM_SEQ.NEXTVAL), 6, '0'), 'POST000001', 'M000002', 1, '

<p>
這我覺得不行，他有些套路10場才成功一場，像是上路慨影，實況主都偏做效果
</p>
', SYSDATE);

INSERT INTO comm
(COMM_ID, POST_ID, MEM_ID, C_STATUS, C_TEXT, LAST_EDIT)
VALUES
('COMM'||LPAD(to_char(COMM_SEQ.NEXTVAL), 6, '0'), 'POST000003', 'M000007', 1, '

<p>
認同這個人跟玩遊戲是兩回事
</p>
', SYSDATE);

INSERT INTO comm
(COMM_ID, POST_ID, MEM_ID, C_STATUS, C_TEXT, LAST_EDIT)
VALUES
('COMM'||LPAD(to_char(COMM_SEQ.NEXTVAL), 6, '0'), 'POST000003', 'M000006', 1, '

<p>
經驗值曲線不知道有沒有調整,像上次一樣免費送大家幾星?
</p>
', SYSDATE);

-----------------------------新增留言-----------------------------

-----------------------------新增收藏文章-----------------------------

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000001', 'POST000005');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000002', 'POST000003');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000003', 'POST000006');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000005', 'POST000002');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000008', 'POST000001');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000004', 'POST000007');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000002', 'POST000006');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000007', 'POST000006');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000008', 'POST000003');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000010', 'POST000005');

-----------------------------新增收藏文章-----------------------------

-----------------------------新增CM-----------------------------
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),1,'M000001','哈囉你好嗎請問方便嗎');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),1,'M000002','哈囉你好嗎請問方便嗎');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),1,'M000001','我要申訴');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),1,'M000001','我買的東西壞掉了，我要退貨');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),1,'M000001','請問怎麼上架商品到交易區');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),0,'M000002','在~~請問需要什麼服務嗎?');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),0,'M000001','在~~請問需要什麼服務嗎?');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),0,'M000003','
:┴┬┴┬／￣＼＿／￣＼
┬┴┬┴▏　　▏▔▔▔▔＼
┴┬┴／＼　／　　　　　　﹨
┬┴∕　　　　　　　／　　　）
┴┬▏　　　　　　　　●　　▏
┬┴▏　　　　　　　　　　　▔█◤
┴◢██◣　　　　　　 ＼＿＿／
┬█████◣　　　　　　　／
┴█████████████◣
◢██████████████▆▄
█◤◢██◣◥█████████◤＼
◥◢████　████████◤　　 ＼
┴█████　██████◤　　　　　 ﹨
┬│　　　│█████◤　　　　　　　　▏
┴│　　　│　　　　　　　　　　　　　　▏
┬∕　　　∕　　　　／▔▔▔＼　　　　 ∕
∕＿＿／﹨　　　∕　　　　　 ＼　　／＼
┬┴┬┴┬┴＼ 　　 ＼　　　　　﹨／　　﹨
┴┬┴┬┴┬┴ ＼＿＿＿＼　　　　 ﹨／▔＼﹨／▔＼
▲△▲▲╓╥╥╥╥╥╥╥╥＼　　 ∕　 ／▔﹨　／▔﹨
　＊＊＊╠╬╬╬╬╬╬╬╬＊﹨　　／　　／／　　／
（＼／）（＼／）＊＊　△▲▲﹨／＿＿／／＿＿');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),1,'M000003','
★︵＿＿＿︵☆
／　　　　　＼
︴●　　　●　︴大　家　天　天　快→樂　~
︴≡　﹏　≡　︴永　遠　幸　福　快　樂 唷　！～
＼＿＿＿＿＿／ 要　加　油　～～加　油！
╭灌水╮╭灌水╮╭灌水╮╭灌水╮
╰～～╯╰～～╯╰～～╯╰～～╯ ');

-----------------------------新增CM-----------------------------

-----------------------------新增CR-----------------------------
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'哈囉你好嗎請問方便嗎','M000001','M000002',1);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),
'☆ ．．．▍▍．☆█ ☆ ☆ ∵ ..../ .；☆
◥█▅▅██▅▅██▅▅▅▅▅██ ██ █ ◤
　◥███我開ㄌ一艘船來幫你灌水 ███◤
～~～~～~～~～~～~～～~～～～~～~～~～~～～~～~～','M000001','M000002',0);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'kono Dio ?','M000001','M000002',0);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'.............','M000001','M000002',1);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'
恩？＿＿＿＿＿
　／───　　＼
／　 ●　　───＼
︳　　　　　 ●    ︱
︳　　　　　　　  ︱
＼╭╮／＼　　　／
你｜╰－－－╮／有點
好｜　－┬－╯生氣哦
像｜　－╯','M000001','M000002',0);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'可以換個正常的人嗎?','M000001','M000002',1);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'我很正常喔','M000001','M000002',0);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'那可以幫我取消那筆韓式烤肉醬的訂單嗎','M000001','M000002',1);

-----------------------------新增CR-----------------------------

-----------------------------新增紅利訂單狀態-----------------------------

INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT )
VALUES ( 'BS'||LPAD ( TO_CHAR( BOUNS_STATE_SEQ.NEXTVAL ) , 3 , '0' ) , '訂單成立' );
INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT )
VALUES ( 'BS'||LPAD ( TO_CHAR( BOUNS_STATE_SEQ.NEXTVAL ) , 3 , '0' ) , '訂單取消' );
INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT )
VALUES ( 'BS'||LPAD ( TO_CHAR( BOUNS_STATE_SEQ.NEXTVAL ) , 3 , '0' ) , '已出貨' );
INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT )
VALUES ( 'BS'||LPAD ( TO_CHAR( BOUNS_STATE_SEQ.NEXTVAL ) , 3 , '0' ) , '已完成' );
INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT )
VALUES ( 'BS'||LPAD ( TO_CHAR( BOUNS_STATE_SEQ.NEXTVAL ) , 3 , '0' ) , '待審核' );
INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT )
VALUES ( 'BS'||LPAD ( TO_CHAR( BOUNS_STATE_SEQ.NEXTVAL ) , 3 , '0' ) , '已退換' );

-----------------------------新增紅利訂單狀態-----------------------------

-----------------------------新增紅利商品-----------------------------

INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_IMAGE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT005','碧藍幻想 Versus',169, load_blob('Bonus/image0001.jpg'),'主機平台：PS4
遊戲類型：動作
發售日期：2020-02-06
遊戲人數：2人
作品分級：保護級
製作廠商：Arc System Works
發行廠商：Cygames
代理廠商：台灣世雅育樂
官方網站：https://versus.granbluefantasy.jp/',1,22,to_date('2020-02-06','yyyy-mm-dd'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_IMAGE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT007','極限競速 7 終極版',279, load_blob('Bonus/image0002.jpg'),'主機平台：XboxOne
遊戲類型：競速
發售日期：2017-10-03
遊戲人數：多人
作品分級：普遍級
製作廠商：Turn 10 Studios
發行廠商：Microsoft Game Studios
代理廠商：台灣微軟
官方網站：http://www.xbox.com/zh-TW/games/forza-7',1,33,to_date('2017-10-03','yyyy-mm-dd'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_IMAGE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT010','RPG 製作大師 FES',165, load_blob('Bonus/image0003.jpg'),'主機平台：3DS
遊戲類型：其他
發售日期：2016-11-24
遊戲人數：1人
作品分級：CERO A
製作廠商：KADOKAWA
發行廠商：KADOKAWA GAMES',1,13,to_date('2016-11-24','yyyy-mm-dd'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_IMAGE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT005','Final Fantasy VII 重製版',179, load_blob('Bonus/image0004.jpg'),'主機平台：PS4
遊戲類型：角色扮演
發售日期：2020-03-03
遊戲人數：1人
作品分級：輔12級
製作廠商：SQUARE ENIX
發行廠商：SQUARE ENIX
代理廠商：台灣索尼互動娛樂
官方網站：http://www.jp.square-enix.com/ffvii_remake/',1,47,to_date('2020-03-03','yyyy-mm-dd'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_IMAGE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT010','瑪利歐賽車 8 豪華版',179, load_blob('Bonus/image0005.jpg'),'主機平台：Nintendo Switch ( NS )
遊戲類型：競速
發售日期：2017-04-28
遊戲人數：多人
作品分級：保護級
製作廠商：任天堂株式会社
發行廠商：任天堂株式会社
代理廠商：展碁國際股份有限公司
官方網站：https://www.nintendo.co.jp/switch/aabpa/',2,50,to_date('2017-04-28','yyyy-mm-dd'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_IMAGE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT010','數碼寶貝世界 -Next Order-',169, load_blob('Bonus/image0006.jpg'),'主機平台：PSV
遊戲類型：角色扮演
發售日期：2017-02-09
遊戲人數：1人
製作廠商：NAMCO BANDAI Games
發行廠商：NAMCO BANDAI Games',0,42,to_date('2017-02-09','yyyy-mm-dd'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_IMAGE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT010','星之卡比 戰鬥豪華版！',135, load_blob('Bonus/image0007.jpg'),'主機平台：3DS
遊戲類型：動作
發售日期：2017-11-30
遊戲人數：4人
作品分級：CERO A
製作廠商：HAL Laboratory
發行廠商：Nintendo
官方網站：https://www.nintendo.co.jp/3ds/aj8j/',2,11,to_date('2017-11-30','yyyy-mm-dd'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_IMAGE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT002','航海王：海賊無雙 4 豪華版',259, load_blob('Bonus/image0008.jpg'),'主機平台：Nintendo Switch ( NS )
遊戲類型：動作
發售日期：2020-03-26
遊戲人數：1人
作品分級：輔導級
發行廠商：BANDAI NAMCO Entertainment
代理廠商：台灣萬代南夢宮娛樂
官方網站：https://oppw4-20.bn-ent.net/',0,25,to_date('2020-03-26','yyyy-mm-dd'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_IMAGE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT005','女神異聞錄 5 皇家版',179, load_blob('Bonus/image0009.jpg'),'主機平台：PS4
遊戲類型：角色扮演
發售日期：2020-02-20
遊戲人數：1人
作品分級：輔導級
製作廠商：ATLUS
發行廠商：SEGA Games
代理廠商：台灣世雅育樂
官方網站：https://p5r.jp/',2,45,to_date('2020-02-20','yyyy-mm-dd'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_IMAGE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT010','菲莉絲的鍊金工房 ～不可思議之旅的鍊金術士～',138, load_blob('Bonus/image0010.jpg'),'主機平台：PSV
遊戲類型：角色扮演
遊戲人數：1人
作品分級：輔12級
製作廠商：GUST
發行廠商：KOEI TECMO GAMES
代理廠商：臺灣光榮特庫摩',0,47,to_date('2016-11-02','yyyy-mm-dd'),0);

-----------------------------新增紅利商品-----------------------------

-----------------------------新增紅利訂單-----------------------------

INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000001','B000001',to_date('2019-06-06','yyyy-mm-dd'),'BS004' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000002','B000002',to_date('2019-07-16','yyyy-mm-dd'),'BS006' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000001','B000003',to_date('2019-08-20','yyyy-mm-dd'),'BS004' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000001','B000004',to_date('2019-09-24','yyyy-mm-dd'),'BS003' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000002','B000005',to_date('2019-10-01','yyyy-mm-dd'),'BS005' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000003','B000007',to_date('2019-11-13','yyyy-mm-dd'),'BS003' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000002','B000009',to_date('2019-12-24','yyyy-mm-dd'),'BS001' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000003','B000005',to_date('2020-01-14','yyyy-mm-dd'),'BS002' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000004','B000007',to_date('2020-02-25','yyyy-mm-dd'),'BS001' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000005','B000009',to_date('2020-03-26','yyyy-mm-dd'),'BS001' );

-----------------------------新增紅利訂單-----------------------------

-----------------------------新增收藏紅利商品-----------------------------

INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000001' , 'B000001' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000001' , 'B000003' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000002' , 'B000002' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000003' , 'B000003' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000003' , 'B000004' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000002' , 'B000001' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000001' , 'B000002' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000011' , 'B000003' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000012' , 'B000004' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000001' , 'B000004' );

-----------------------------新增收藏紅利商品-----------------------------

-----------------------------新增交易區競標商品資料-----------------------------

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END,MARKETPRICE, INITPRICE, AUCT_INC, MAXPRICE, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_TIME, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000001','M000003', 'PT002', '集合啦！動物森友會', to_date('2020-02-04 12:52:42', 'yyyy-mm-dd hh24:mi:ss'), 
        to_date('2020-02-05 12:52:42', 'yyyy-mm-dd hh24:mi:ss'),1890, 100, 500, 3500, '《動物森友會》系列最新作品《集合啦！動物森友會》將會重新詮釋動物森友會的傳統體驗方式。玩家將參加由 Nook Inc. 所策劃的「無人島移居計畫」，在以無人島為背景的遊戲中展開全新的生活。
在遊戲中可以悠閒地在海邊漫步、四處探索......在什麼都沒有的無人島展開自由自在的生活。另外，還有全新改造系統，讓玩家可以 DIY，將島上的材料收集起來，DIY 成家具及生活所需的道具等等。此外，還有園藝、釣魚、島上探索、居家環境佈置、與移居到島上的可愛動物們交流等多項體驗，讓玩家可以一面感受四季變化，一面享受悠閒生活。
下標前請先看關於我
特典內容依官方公佈,特典非所有軟體1:1,會依下標順序照排發放
不回答特典相關問題
預購商品會於3個工作天內出貨
超商取貨者商品約2-3天送達,宅配隔日送達(如遇國定例假日或特殊狀況依物流實際配送時間而定)', load_blob('Auc/auct_img001.jpg'), 1, 1, '006',to_date('2020-02-05 10:12:02', 'yyyy-mm-dd hh24:mi:ss'), to_date('2020-02-06 12:52:42', 'yyyy-mm-dd hh24:mi:ss'), '中壢李姓選民', '0923456789', '桃園市中壢區健行路229號');

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END,MARKETPRICE, INITPRICE, AUCT_INC, MAXPRICE, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_TIME, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000002','M000007' , 'PT004', ' PS4 Pro主機1TB 死亡擱淺同捆組', to_date('2020-02-12 18:03:58', 'yyyy-mm-dd hh24:mi:ss'), 
        to_date('2020-02-13 18:03:58', 'yyyy-mm-dd hh24:mi:ss'),12980, 1000, 100, 7100, '朋友抽獎抽到的，託我幫售，歡迎面交
全新未拆，主機、配件該有的都有
手把是透明橘色的蠻好看',load_blob('Auc/auct_img002.jpg'), 1, 1, '006', to_date('2020-02-14 14:03:46', 'yyyy-mm-dd hh24:mi:ss'), to_date('2020-02-14 18:03:58', 'yyyy-mm-dd hh24:mi:ss'), '一定iPad溫開水', '0967890123', '桃園市平鎮區環南路三段100號');

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END,MARKETPRICE, INITPRICE, AUCT_INC, MAXPRICE, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_TIME, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000003', 'M000006', 'PT002', 'Switch 巫師3 狂獵 完全版 中文版', to_date('2020-03-22 10:05:30', 'yyyy-mm-dd hh24:mi:ss'),
       to_date('2020-03-23 10:05:30', 'yyyy-mm-dd hh24:mi:ss'),1650, 600, 150, 1350, '二手 台中南屯可面交', load_blob('Auc/004.png'), 1, 1, '006', to_date('2020-03-23 18:50:38', 'yyyy-mm-dd hh24:mi:ss'),
       to_date('2020-03-24 10:05:30', 'yyyy-mm-dd hh24:mi:ss'), '江西男', '0956789012', '桃園市平鎮區振興路2號');

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END,MARKETPRICE, INITPRICE, AUCT_INC, MAXPRICE, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_TIME, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000004', 'M000005', 'PT001', 'Switch主機 動物森友會主機', to_date('2020-04-21 23:06:35', 'yyyy-mm-dd hh24:mi:ss'),
       to_date('2020-04-22 23:06:35', 'yyyy-mm-dd hh24:mi:ss'),14200, 100, 1500, 12100, '＊單主機（沒有含遊戲）
 商品描述:
 1.電量加強版主機 ，遊戲時間加長!
 2.最多連線8台主機，進行對戰或協力遊戲
 3.Joy-Con內置「HD震動」體驗逼真細膩臨場感
 4.多種遊戲模式：電視連接、掌上遊玩
                       
 盒裝內容物標準配備:
 Switch 主機1台
 Joy-Con(L)/( R) 各1支
 Switch 底座1個
 AC變壓器1個
 Joy-Con 握把1個
 Joy-Con 腕帶(黑色)1組
 HDMI Cable線 1條', load_blob('Auc/005.png'), 1,1, '006', to_date('2020-04-23 13:16:05', 'yyyy-mm-dd hh24:mi:ss'), to_date('2020-04-23 23:06:35', 'yyyy-mm-dd hh24:mi:ss'), '金寶山下製酒', '0945678901', '桃園市中壢區元化路357號');

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END,MARKETPRICE, INITPRICE, AUCT_INC, MAXPRICE, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_TIME, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000006', 'M000004', 'PT001', '二手過保一般型switch 紅藍配色', to_date('2020-05-16 15:06:20', 'yyyy-mm-dd hh24:mi:ss'),
       to_date('2020-05-17 15:06:20', 'yyyy-mm-dd hh24:mi:ss'),12500, 6500, 500, 8500, '保存良好，8-9成新。外觀無明顯使用痕跡。
 可私訊聊聊看主機近照。
 功能皆正常，手把無飄移。附主機包。', load_blob('Auc/006.png'), 1,1, '006', to_date('2020-05-18 7:16:20', 'yyyy-mm-dd hh24:mi:ss'), to_date('2020-05-18 15:06:20', 'yyyy-mm-dd hh24:mi:ss'), '艾爾不怕西諾', '0934567890', '桃園市中壢區林森路95號');

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END,MARKETPRICE, INITPRICE, AUCT_INC, MAXPRICE, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_TIME, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000004', 'M000006', 'PT005', 'PS4 魔物獵人 世界 Iceborne 中文版(全新)', to_date('2020-05-21 13:31:05', 'yyyy-mm-dd hh24:mi:ss'),
        to_date('2020-05-22 13:31:05', 'yyyy-mm-dd hh24:mi:ss'),1650, 150, 150, 1050, '全新未拆封 內附特典DLC［士林遊戲頻道］', load_blob('Auc/007.png'), 1, 1, '006', to_date('2020-05-22 23:31:05','yyyy-mm-dd hh24:mi:ss'), 
        to_date('2020-05-23 13:31:05', 'yyyy-mm-dd hh24:mi:ss'), '江西男', '0956789012', '桃園市平鎮區振興路2號'); 

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END,MARKETPRICE, INITPRICE, AUCT_INC, MAXPRICE, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_TIME, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000005', 'M000004', 'PT005', 'PS4 特惠組合包 惡靈古堡2 + 噬神者3 中文版', to_date('2020-06-01 11:21:37', 'yyyy-mm-dd hh24:mi:ss'),
       to_date('2020-06-02 11:21:37', 'yyyy-mm-dd hh24:mi:ss'),3850, 950, 100, 1450, '組合內容:
PS4 噬神者3
PS4 惡靈古堡 2 重製版
特典內容:(送完為止)
《惡靈古堡 2》豪華武器 “武士之刃 - 克里斯型”
《惡靈古堡 2》豪華武器 “武士之刃 - 吉兒型”
《惡靈古堡 2》PS4 專用佈景主題」', load_blob('Auc/008.png'), 1, 1, '006', to_date('2020-06-02 21:00:37', 'yyyy-mm-dd hh24:mi:ss'), to_date('2020-06-03 11:21:37', 'yyyy-mm-dd hh24:mi:ss'), '艾爾不怕西諾', '0934567890', '桃園市中壢區林森路95號');

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END,MARKETPRICE, INITPRICE, AUCT_INC, MAXPRICE, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_TIME, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000007', 'M000006', 'PT004', '二手主機 PS4 1207A 500G 主機', to_date('2020-06-02 5:06:20', 'yyyy-mm-dd hh24:mi:ss'),
       to_date('2020-06-03 5:06:20', 'yyyy-mm-dd hh24:mi:ss'),36000, 1000, 2500, 31000, '此為PS4 初代主機 型號1207賣場, 二手主機皆測試通過, 整理乾淨

狀態：
主機狀態：二手主機皆測試通過, 配件齊全, 整理乾淨
主機顏色：請見商品選項
主機版本：6.50以上
主機容量：500G
保固狀態：1207為初代主機, 皆已無保固', load_blob('Auc/009.png'), 1, 1, '006', to_date('2020-06-03 15:26:20', 'yyyy-mm-dd hh24:mi:ss'), to_date('2020-06-04 5:06:20', 'yyyy-mm-dd hh24:mi:ss'), '江西男', '0956789012', '桃園市平鎮區振興路2號');

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END,MARKETPRICE, INITPRICE, AUCT_INC, MAXPRICE, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_TIME, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000003', 'M000007', 'PT009', 'XBOX 電玩主機 殺肉 零件機 故障機', to_date('2020-06-09 03:21:05', 'yyyy-mm-dd hh24:mi:ss'),
        to_date('2020-06-10 03:21:05', 'yyyy-mm-dd hh24:mi:ss'),300, 50, 50, 300, 'XBOX 360 S 4GB 電玩主機
        2012出廠
開機鈕按下去有聲音，沒有燈號
含轉接線，主機板，機殼
一起賣300', load_blob('Auc/010.png'), 1, 1, '006', to_date('2020-06-10 08:11:05','yyyy-mm-dd hh24:mi:ss'), to_date('2020-06-11 03:21:05', 'yyyy-mm-dd hh24:mi:ss'), '一定iPad溫開水', '0967890123', '桃園市平鎮區環南路三段100號');

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END,MARKETPRICE, INITPRICE, AUCT_INC, MAXPRICE, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_TIME, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000005', 'M000001', 'PT007', 'XBOX ONE', to_date('2020-06-11 01:01:05', 'yyyy-mm-dd hh24:mi:ss'),
        to_date('2020-06-12 01:01:05', 'yyyy-mm-dd hh24:mi:ss'),8000, 500, 500, 8500, '3C XBOX ONE 360 CONSOLE 1540 1TB 黑色 /XBOX One Kinect 2.0 體感主機/感應器/攝影機/控制器 

✔物品過大無法寄送超商
✔商品包含配件 附變壓器 附傳輸線 附電源線 附hdmi線 無其他配件
✔2手商品 功能都正常 物品過大無法寄送超商
✔2013年出廠已過原廠保固
✔兩個手把
✔所有商品沒有因為不能升級版本而退貨！
✔請麻煩看清楚商品照片以及商品狀況再確認才下單請勿隨意取消訂單 ', load_blob('Auc/011.png'), 1, 1, '006', to_date('2020-06-12 19:16:50','yyyy-mm-dd hh24:mi:ss'), to_date('2020-06-13 01:01:05', 'yyyy-mm-dd hh24:mi:ss'), '早餐店大冰奶', '0912345678', '桃園市中壢區中大路300號');

-----------------------------新增交易區競標商品資料-----------------------------

-----------------------------新增交易區直購商品資料-----------------------------

INSERT INTO IMMED (IMMED_ID, SALE_ID, BUY_ID, PT_ID, IMMED_NAME, IMMED_START, IMMED_PRC, IMMED_PIC, IMMED_DESC, IMMED_SOLD, IMMED_DOWN, ORD_TIME, ORDSTAT_ID, RCPT_NAME, RCPT_CELL, RCPT_ADD)
VALUES ('IMMED'||LPAD(to_char(IMMED_SEQ.NEXTVAL), 6, '0'), 'M000001', null, 'PT005', '[哈GAME族]●限時特惠價●PS4 隻狼：暗影雙死 中文版', to_timestamp('2020-07-04 12:52:42', 'syyyy-mm-dd hh24:mi:ss'), 
        1100, load_blob('Auc/immed000001.jpg'), '遊戲介紹
    由打造《惡魔靈魂》和血源詛咒》的知名開發團隊 FromSoftware 製作的全新遊戲《隻狼：暗影雙死》，劇情講述 16 世紀末
的日本戰國時代，一個充滿血腥暴力，人們無時無刻生死相搏的世界。隨著局勢日漸緊繃，一個扣人心弦的全新故事在混沌中展
開。玩家將可從中享受奇幻、黑暗與扭曲的全新遊玩體驗。',  0, 0, null, null, null, null, null);

INSERT INTO IMMED (IMMED_ID, SALE_ID, BUY_ID, PT_ID, IMMED_NAME, IMMED_START, IMMED_PRC, IMMED_PIC, IMMED_DESC, IMMED_SOLD, IMMED_DOWN, ORD_TIME, ORDSTAT_ID, RCPT_NAME, RCPT_CELL, RCPT_ADD)
VALUES ('IMMED'||LPAD(to_char(IMMED_SEQ.NEXTVAL), 6, '0'), 'M000002', 'M000001', 'PT005', 'PS4《太空戰士 7 Final Fantasy VII 重製版》中文版 EE2882【GAME休閒館】', to_timestamp('2020-07-01 19:41:12', 'syyyy-mm-dd hh24:mi:ss'), 
        1300, load_blob('Auc/immed000002.jpg'), 'FINAL FANTASY VII REMAKE''由經手原版的主要原班人馬精心製作。 
    
    其壯大的劇情與充滿魅力的角色，以及運用當時最先進技術製作的畫面，而一直是深受眾多 玩家喜愛的不朽名
作，如今將重生為「全新故事」。
    
    FINAL FANTASY VII REMAKE 指令式戰鬥融合操作直覺的動作系統，衍生出更豐富的戰略性。遊戲畫面則運用 20
年前不可 能實現的技術，打造出身歷其境的全新『FINAL FANTASY VII REMAKE''世界。',  1, 1, to_timestamp('2020-07-05 20:13:45', 'syyyy-mm-dd hh24:mi:ss'), '006', '早餐店大冰奶', '0912345678', '桃園市中壢區中大路300號');

INSERT INTO IMMED (IMMED_ID, SALE_ID, BUY_ID, PT_ID, IMMED_NAME, IMMED_START, IMMED_PRC, IMMED_PIC, IMMED_DESC, IMMED_SOLD, IMMED_DOWN, ORD_TIME, ORDSTAT_ID, RCPT_NAME, RCPT_CELL, RCPT_ADD)
VALUES ('IMMED'||LPAD(to_char(IMMED_SEQ.NEXTVAL), 6, '0'), 'M000003', null, 'PT004', '現貨★Days of Play【PS4 PRO主機 1TB 黑or白 雙手把 台灣公司貨】', to_timestamp('2020-07-06 13:39:05', 'syyyy-mm-dd hh24:mi:ss'), 
        10850, load_blob('Auc/immed000003.jpg'), 'Days of Play特惠活動
時間：6/3-6/16

原價12980元，活動時間內特價10880元

售完為止

此商品為雙手把組，第二支手把皆黑手把 ',  0, 0, null, null, null, null, null);

INSERT INTO IMMED (IMMED_ID, SALE_ID, BUY_ID, PT_ID, IMMED_NAME, IMMED_START, IMMED_PRC, IMMED_PIC, IMMED_DESC, IMMED_SOLD, IMMED_DOWN, ORD_TIME, ORDSTAT_ID, RCPT_NAME, RCPT_CELL, RCPT_ADD)
VALUES ('IMMED'||LPAD(to_char(IMMED_SEQ.NEXTVAL), 6, '0'), 'M000004', 'M000003', 'PT006', 'PS4 周邊【保固一年 SONY 無線 耳機 7.1聲道無線耳機組 】CECHYA-0080阿嚕咪電玩', to_timestamp('2020-07-08 10:24:13', 'syyyy-mm-dd hh24:mi:ss'), 
        2750, load_blob('Auc/immed000004.jpg'), 'PS4 周邊【保固一年 SONY 無線 耳機 7.1聲道無線耳機組 】CECHYA-0080阿嚕咪電玩

．塑膠 + 仿真皮革材質 (長時間遊玩也一樣舒適) 

．40mm驅動單元 / 7.1虛擬環繞聲 
．改良隱藏式麥克風 (更好的麥克風品質) 
．數位訊號處理技術(DSP)提升 
．8小時高續航力的充電式電池 ',  1, 1, to_timestamp('2020-07-10 17:44:08', 'syyyy-mm-dd hh24:mi:ss'), '003', '中壢李姓選民', '0923456789', '桃園市中壢區健行路229號');

INSERT INTO IMMED (IMMED_ID, SALE_ID, BUY_ID, PT_ID, IMMED_NAME, IMMED_START, IMMED_PRC, IMMED_PIC, IMMED_DESC, IMMED_SOLD, IMMED_DOWN, ORD_TIME, ORDSTAT_ID, RCPT_NAME, RCPT_CELL, RCPT_ADD)
VALUES ('IMMED'||LPAD(to_char(IMMED_SEQ.NEXTVAL), 6, '0'), 'M000005', null, 'PT002', '現貨中Switch 遊戲NS 薩爾達傳說 荒野之息 曠野之息 中文版', to_timestamp('2020-07-11 21:56:02', 'syyyy-mm-dd hh24:mi:ss'), 
        1050, load_blob('Auc/immed000005.jpg'), '薩爾達傳說：荒野之息》是《薩爾達傳說》系列首款 Wii U 完全新作，首度採
用開放世界與擬真物理模擬設計，讓玩家扮演從長眠甦醒的林克，在遼闊無邊的
                    海拉魯世界展開探索與冒險。
    在這次的 GameCenter DX 節目中，是由擔任節目執行總監的濱口優接下挑戰，挑
戰的對象是《薩爾達傳說：荒野之息》的 E3 2016 體驗版，挑戰的任務
是濱口似曾相識的「在海拉魯世界生活一週（遊戲內時間）」，他將依照企劃
        書的規划來體驗遊戲中的各種事件，收集食材製作料理 ',  0, 0, null, null, null, null, null);
        
INSERT INTO IMMED (IMMED_ID, SALE_ID, BUY_ID, PT_ID, IMMED_NAME, IMMED_START, IMMED_PRC, IMMED_PIC, IMMED_DESC, IMMED_SOLD, IMMED_DOWN, ORD_TIME, ORDSTAT_ID, RCPT_NAME, RCPT_CELL, RCPT_ADD)
VALUES ('IMMED'||LPAD(to_char(IMMED_SEQ.NEXTVAL), 6, '0'), 'M000006', 'M000005', 'PT002', 'NS-集合啦！動物森友會 中文版[亞力士電玩]', to_timestamp('2020-07-15 16:46:28', 'syyyy-mm-dd hh24:mi:ss'), 
        1400, load_blob('Auc/immed000006.jpg'), '《動物森友會》系列最新作品《集合啦！動物森友會》將會重新詮釋動物森友會的傳統體驗方式。玩家將
參加由 Nook Inc. 所策劃的「無人島移居計畫」，在以無人島為背景的遊戲中展開全新的生活。

　　在遊戲中可以悠閒地在海邊漫步、四處探索......在什麼都沒有的無人島展開自由自在的生活。另外，還
有全新改造系統，讓玩家可以 DIY，將島上的材料收集起來，DIY 成家具及生活所需的道具等等。此外，
還有園藝、釣魚、島上探索、居家環境佈置、與移居到島上的可愛動物們交流等多項體驗，讓玩家可以一面
感受四季變化，一面享受悠閒生活。',  1, 1, to_timestamp('2020-07-18 20:32:39', 'syyyy-mm-dd hh24:mi:ss'), '006', '金寶山下製酒', '0945678901', '桃園市中壢區元化路357號');

INSERT INTO IMMED (IMMED_ID, SALE_ID, BUY_ID, PT_ID, IMMED_NAME, IMMED_START, IMMED_PRC, IMMED_PIC, IMMED_DESC, IMMED_SOLD, IMMED_DOWN, ORD_TIME, ORDSTAT_ID, RCPT_NAME, RCPT_CELL, RCPT_ADD)
VALUES ('IMMED'||LPAD(to_char(IMMED_SEQ.NEXTVAL), 6, '0'), 'M000007', 'M000006', 'PT001', 'NS Switch 破解Sxpro雙系統全配主機 限定版', to_timestamp('2020-07-05 19:32:13', 'syyyy-mm-dd hh24:mi:ss'), 
        13900, load_blob('Auc/immed000007.jpg'), '可破解，可改機主機，附全套配件，可面交，其他地區郵局掛號郵寄。

非單賣主機螢幕！！！完整雙把手，電視底座都附給你。

二手保存良好，買來之後玩沒幾次就放著，最近想要出清時突
然發現是可改機的版本。

請注意：此商品仍未破解，請購買後自己進行後續處理。
購買前請使用露露通聯絡，勿直接下標，直接下標一律取消。',  1, 1, to_timestamp('2020-07-6 03:10:46', 'syyyy-mm-dd hh24:mi:ss'), '003', '江西男', '0956789012', '桃園市平鎮區振興路2號');

INSERT INTO IMMED (IMMED_ID, SALE_ID, BUY_ID, PT_ID, IMMED_NAME, IMMED_START, IMMED_PRC, IMMED_PIC, IMMED_DESC, IMMED_SOLD, IMMED_DOWN, ORD_TIME, ORDSTAT_ID, RCPT_NAME, RCPT_CELL, RCPT_ADD)
VALUES ('IMMED'||LPAD(to_char(IMMED_SEQ.NEXTVAL), 6, '0'), 'M000008', null, 'PT003', 'N-Switch joy-con 蟒蛇四座快充 Switch周邊 Switch副廠', to_timestamp('2020-07-09 23:54:46', 'syyyy-mm-dd hh24:mi:ss'), 
        299, load_blob('Auc/immed000008.jpg'), '品內容物:mini Joycon手把充電器*1個

1.完美貼合N-Switch Dock原裝底座使用的充電座，適用NS Joy-Con手把充電

2.本產品具有4個充電插槽，支持給1~4個JoyCon手把同時充電

3.配備USB2.0公插頭接口，由原廠底座提供電源輸入

4.底部擴充的USB2.0母座，支持DC5V電源輸出，支持通信功能

5.產品精巧簡潔，操作簡單，及時顯示手把充電狀態',  0, 0, null, null, null, null, null);

INSERT INTO IMMED (IMMED_ID, SALE_ID, BUY_ID, PT_ID, IMMED_NAME, IMMED_START, IMMED_PRC, IMMED_PIC, IMMED_DESC, IMMED_SOLD, IMMED_DOWN, ORD_TIME, ORDSTAT_ID, RCPT_NAME, RCPT_CELL, RCPT_ADD)
VALUES ('IMMED'||LPAD(to_char(IMMED_SEQ.NEXTVAL), 6, '0'), 'M000009', null, 'PT008', '全新未拆 XBOX ONE 刺客教條 奧德賽 (含初回特典 盲王) 中文亞版 Odyssey AC 刺客信條 希臘 X1', to_timestamp('2020-07-17 14:28:21', 'syyyy-mm-dd hh24:mi:ss'), 
        1450, load_blob('Auc/immed000009.jpg'), '命運由你主宰
--------
在這世界中，你的每一個選擇都至關重要，寫下屬於你的傳奇故事，體驗精彩萬分的史詩冒險。被你的家族宣
判死刑，踏上轟轟烈烈的旅程：從被放逐的傭兵變身成為傳奇希臘英雄，並發掘你的過往真相。在山海為之震
動、撕裂人神共塑世界的戰爭中，走出屬於你自己的路。會晤古希臘的著名人物，並參與塑造西方文明的重要
歷史時刻。

《刺客教條：奧德賽》帶來了該系列前所未見的創新機制突顯玩家每個選擇的重要性：玩家可以選擇要成為什
麼樣的英雄並且改變週遭世界。玩家在冒險旅程中做的每個決定，以及和各式各樣人物建立起的關係，將決定
自己的未來命運。玩家可以自訂裝備以及精通新的特殊技能，量身訂製出適合自己玩法的英雄技能組合。玩家
可以南征北討希臘各地，於陸上與海上從事激烈戰鬥，並且成為真正的傳奇英雄。',  0, 0, null, null, null, null, null);

INSERT INTO IMMED (IMMED_ID, SALE_ID, BUY_ID, PT_ID, IMMED_NAME, IMMED_START, IMMED_PRC, IMMED_PIC, IMMED_DESC, IMMED_SOLD, IMMED_DOWN, ORD_TIME, ORDSTAT_ID, RCPT_NAME, RCPT_CELL, RCPT_ADD)
VALUES ('IMMED'||LPAD(to_char(IMMED_SEQ.NEXTVAL), 6, '0'), 'M000010', null, 'PT007', '電玩小舖~地表最強遊戲機組合 Xbox One X 1TB 主機 黑潮版'||chr(38)||'第2支原廠無線控制器', to_timestamp('2020-07-18 16:07:53', 'syyyy-mm-dd hh24:mi:ss'), 
        15150, load_blob('Auc/immed000010.jpg'), '內容物：
Xbox One X 主機（黑色，含 1TB 硬碟容量）、Xbox One 無線控制器、1 個月 Xbox 
Game Pass 訂閱試用版、HDMI 線、第2支原廠無線控制器
產品特色：
◆ Xbox One X 主機
Xbox One X 是延伸 Xbox One 主機產品線的強化機種，將搭載 40 組時脈 
1172MHz 的圖形處理計算單元（CU）與容量 12GB、頻寬 326GBps 的 GDDR5 高
速記憶體，提供高達 6TFLOPS 的浮點數處理效能，是既有 Xbox One 的 4.5 倍以
上，完整支援原生 4K 解析度 HDR 畫面輸出。此外，Xbox One X 亦兼顧既有的 
1080p 電視玩家，可透過超取樣技術將原生 4K 畫面輸出為更細緻平滑的 1080p 畫
面呈現。不只是影像，Xbox One X 同時支援杜比實驗室新一代的「杜比全景聲
（Dolby Atmos）」音效技術，增加朝上反射的額外 2 個副聲道，可提供最多 128 
個獨立音效物件的定位效果，讓觀眾如同被遊戲所處的環境包覆，同時能清晰辨識
環境中各物件所在方位，以及與環境相稱的聲音特質。',  0, 0, null, null, null, null, null);

-----------------------------新增交易區直購商品資料-----------------------------

-----------------------------新增競標出價資料-----------------------------

INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000001', 'M000002', 1500, to_date('2020-06-04 13:34:20', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000001', 'M000006', 2000, to_date('2020-02-04 22:54:05', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000001', 'M000004', 2500, to_date('2020-02-05 00:42:30', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000001', 'M000002', 3000, to_date('2020-02-05 07:04:25', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000001', 'M000003', 3500, to_date('2020-02-05 09:10:40', 'yyyy-mm-dd hh24:mi:ss'), 1);

INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000002', 'M000004', 5350, to_date('2020-02-11 20:28:43', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000002', 'M000005', 5700, to_date('2020-02-11 21:15:40', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000002', 'M000007', 6050, to_date('2020-02-11 23:00:05', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000002', 'M000003', 6400, to_date('2020-02-12 01:10:45', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000002', 'M000001', 6750, to_date('2020-02-12 09:08:40', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000002', 'M000007', 7100, to_date('2020-02-12 15:10:04', 'yyyy-mm-dd hh24:mi:ss'), 1);

INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000003', 'M000006', 750, to_date('2020-03-22 16:45:40', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000003', 'M000007', 900, to_date('2020-03-22 20:38:45', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000003', 'M000002', 1050, to_date('2020-03-22 23:18:04', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000003', 'M000001', 1200, to_date('2020-03-23 06:08:10', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000003', 'M000006', 1350, to_date('2020-03-23 09:10:04', 'yyyy-mm-dd hh24:mi:ss'), 1);

INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000004', 'M000007', 1600, to_date('2020-04-22 00:01:19', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000004', 'M000005', 3100, to_date('2020-04-22 03:09:18', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000004', 'M000001', 4600, to_date('2020-04-22 06:11:10', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000004', 'M000003', 6100, to_date('2020-04-22 10:08:21', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000004', 'M000006', 7600, to_date('2020-04-22 15:28:05', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000004', 'M000007', 9100, to_date('2020-04-22 18:58:15', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000004', 'M000001', 10600, to_date('2020-04-22 20:08:10', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000004', 'M000005', 12100, to_date('2020-04-22 22:59:04', 'yyyy-mm-dd hh24:mi:ss'), 1);

INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000005', 'M000007', 7000, to_date('2020-05-16 19:18:20', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000005', 'M000001', 7500, to_date('2020-05-17 01:30:40', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000005', 'M000003', 8000, to_date('2020-05-17 07:10:55', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000005', 'M000004', 8500, to_date('2020-05-17 13:59:04', 'yyyy-mm-dd hh24:mi:ss'), 1);

INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000006', 'M000003', 900, to_date('2020-05-21 20:03:20', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000006', 'M000006', 1050, to_date('2020-05-22 12:10:30', 'yyyy-mm-dd hh24:mi:ss'), 1);

INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000007', 'M000004', 1050, to_date('2020-06-01 15:07:40', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000007', 'M000001', 1150, to_date('2020-06-01 18:15:26', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000007', 'M000002', 1250, to_date('2020-06-01 20:13:50', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000007', 'M000007', 1350, to_date('2020-06-01 22:31:10', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000007', 'M000004', 1450, to_date('2020-06-02 10:03:20', 'yyyy-mm-dd hh24:mi:ss'), 1);

INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000008', 'M000002', 13500, to_date('2020-06-02 07:45:10', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000008', 'M000005', 16000, to_date('2020-06-02 12:31:09', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000008', 'M000006', 18500, to_date('2020-06-02 17:15:10', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000008', 'M000004', 21000, to_date('2020-06-02 18:21:25', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000008', 'M000001', 23500, to_date('2020-06-02 19:31:30', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000008', 'M000005', 26000, to_date('2020-06-02 20:32:00', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000008', 'M000001', 28500, to_date('2020-06-02 21:21:10', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000008', 'M000004', 31000, to_date('2020-06-02 22:11:20', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000008', 'M000005', 33500, to_date('2020-06-02 23:31:10', 'yyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000008', 'M000006', 36000, to_date('2020-06-03 01:03:20', 'yyyy-mm-dd hh24:mi:ss'), 1);

INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_TIME, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000009', 'M000007', 300, to_date('2020-06-10 00:13:20', 'yyyy-mm-dd hh24:mi:ss'), 1);



-----------------------------新增競標出價資料-----------------------------

-----------------------------新增折扣級距-----------------------------

INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,6,'0'), 0.9, 5);
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,6,'0'), 0.85, 10);
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,6,'0'), 0.8, 15);
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,6,'0'), 0.75, 20);
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,6,'0'), 0.7, 25);
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,6,'0'), 0.65, 30);
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,6,'0'), 0.6, 35);
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,6,'0'), 0.55, 40);
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,6,'0'), 0.5, 45);

-----------------------------新增折扣級距-----------------------------

-----------------------------新增團購案-----------------------------

INSERT INTO GROUPBUY(GRO_ID,P_ID,REB1_NO,REB2_NO,REB3_NO,START_DATE,END_DATE,GROTIME,PEOPLE,STATUS, MONEY, AMOUNT) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,6,'0'),'P001','R000001','R000002','R000003',to_date('2019-05-03 01:03:20', 'yyyy-mm-dd hh24:mi:ss'),to_date('2019-05-10 01:03:20', 'yyyy-mm-dd hh24:mi:ss'),7,9,0, 599.4, 50);
INSERT INTO GROUPBUY(GRO_ID,P_ID,REB1_NO,REB2_NO,REB3_NO,START_DATE,END_DATE,GROTIME,PEOPLE,STATUS, MONEY, AMOUNT) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,6,'0'),'P002','R000004','R000005','R000006',to_date('2019-06-03 01:03:20', 'yyyy-mm-dd hh24:mi:ss'),to_date('2019-06-07 01:03:20', 'yyyy-mm-dd hh24:mi:ss'),7,6,0, 313, 50);
INSERT INTO GROUPBUY(GRO_ID,P_ID,REB1_NO,REB2_NO,REB3_NO,START_DATE,END_DATE,GROTIME,PEOPLE,STATUS, MONEY, AMOUNT) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,6,'0'),'P003','R000007','R000008','R000009',to_date('2019-09-11 01:03:20', 'yyyy-mm-dd hh24:mi:ss'),to_date('2019-09-18 01:03:20', 'yyyy-mm-dd hh24:mi:ss'),7,20,1, 2528, 50);
INSERT INTO GROUPBUY(GRO_ID,P_ID,REB1_NO,REB2_NO,REB3_NO,START_DATE,END_DATE,GROTIME,PEOPLE,STATUS, MONEY, AMOUNT) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,6,'0'),'P004','R000001','R000003','R000005',to_date('2020-02-06 01:03:20', 'yyyy-mm-dd hh24:mi:ss'),to_date('2020-02-13 01:03:20', 'yyyy-mm-dd hh24:mi:ss'),7,15,1, 3316, 50);
INSERT INTO GROUPBUY(GRO_ID,P_ID,REB1_NO,REB2_NO,REB3_NO,START_DATE,END_DATE,GROTIME,PEOPLE,STATUS, MONEY, AMOUNT) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,6,'0'),'P005','R000002','R000004','R000006',to_date('2020-03-28 01:03:20', 'yyyy-mm-dd hh24:mi:ss'),to_date('2020-04-04 01:03:20', 'yyyy-mm-dd hh24:mi:ss'),7,3,2, 2729, 50);
INSERT INTO GROUPBUY(GRO_ID,P_ID,REB1_NO,REB2_NO,REB3_NO,START_DATE,END_DATE,GROTIME,PEOPLE,STATUS, MONEY, AMOUNT) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,6,'0'),'P006','R000003','R000006','R000009',to_date('2020-04-17 01:03:20', 'yyyy-mm-dd hh24:mi:ss'),to_date('2020-04-24 01:03:20', 'yyyy-mm-dd hh24:mi:ss'),7,2,2, 1811, 50);

-----------------------------新增團購案-----------------------------

-----------------------------新增團購訂單-----------------------------

INSERT INTO GRO_ORDER(ORD_ID,MEM_ID,GRO_ID,ORDSTAT_ID,ADD_DATE) VALUES ('GO'||LPAD(GRO_ORDER_seq.NEXTVAL,6,'0'),'M000001','G000001','001',to_date('2020-04-17 01:03:20', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO GRO_ORDER(ORD_ID,MEM_ID,GRO_ID,ORDSTAT_ID,ADD_DATE) VALUES ('GO'||LPAD(GRO_ORDER_seq.NEXTVAL,6,'0'),'M000002','G000002','002',to_date('2020-03-15 01:03:20', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO GRO_ORDER(ORD_ID,MEM_ID,GRO_ID,ORDSTAT_ID,ADD_DATE) VALUES ('GO'||LPAD(GRO_ORDER_seq.NEXTVAL,6,'0'),'M000003','G000003','003',to_date('2020-02-17 01:03:20', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO GRO_ORDER(ORD_ID,MEM_ID,GRO_ID,ORDSTAT_ID,ADD_DATE) VALUES ('GO'||LPAD(GRO_ORDER_seq.NEXTVAL,6,'0'),'M000004','G000004','004',to_date('2020-01-17 01:03:20', 'yyyy-mm-dd hh24:mi:ss'));

-----------------------------新增團購訂單-----------------------------

-----------------------------新增收藏團購-----------------------------

INSERT INTO FAVOURITE_GRO(MEM_ID,GRO_ID) VALUES ('M000001','G000001');
INSERT INTO FAVOURITE_GRO(MEM_ID,GRO_ID) VALUES ('M000002','G000002');
INSERT INTO FAVOURITE_GRO(MEM_ID,GRO_ID) VALUES ('M000003','G000003');
INSERT INTO FAVOURITE_GRO(MEM_ID,GRO_ID) VALUES ('M000004','G000004');

-----------------------------新增收藏團購-----------------------------

-----------------------------新增團購成員-----------------------------

INSERT INTO GRO_MEM(MEM_ID,GRO_ID) VALUES ('M000001','G000001');
INSERT INTO GRO_MEM(MEM_ID,GRO_ID) VALUES ('M000002','G000002');
INSERT INTO GRO_MEM(MEM_ID,GRO_ID) VALUES ('M000003','G000003');
INSERT INTO GRO_MEM(MEM_ID,GRO_ID) VALUES ('M000004','G000004');

-----------------------------新增團購成員-----------------------------

-----------------------------新增文章檢舉案-----------------------------

INSERT INTO POSTACCUSE VALUES ('p'||LPAD(to_char(postaccuse_seq.NEXTVAL),6,'0'),'M000001','POST000001','ad000006','圖文不符',1);
INSERT INTO POSTACCUSE VALUES ('p'||LPAD(to_char(postaccuse_seq.NEXTVAL),6,'0'),'M000002','POST000005','ad000004','置入性行銷',0);
INSERT INTO POSTACCUSE VALUES ('p'||LPAD(to_char(postaccuse_seq.NEXTVAL),6,'0'),'M000005','POST000003','ad000003','內容誇大不實',1);
INSERT INTO POSTACCUSE VALUES ('p'||LPAD(to_char(postaccuse_seq.NEXTVAL),6,'0'),'M000007','POST000004','ad000005','文章字數太少',0);
INSERT INTO POSTACCUSE VALUES ('p'||LPAD(to_char(postaccuse_seq.NEXTVAL),6,'0'),'M000003','POST000006','ad000001','含有色情內容',1);
INSERT INTO POSTACCUSE VALUES ('p'||LPAD(to_char(postaccuse_seq.NEXTVAL),6,'0'),'M000006','POST000002','ad000002','文字未排版',1);

-----------------------------新增文章檢舉案-----------------------------

-----------------------------新增會員檢舉案-----------------------------

INSERT INTO MEMBERACCUSE VALUES ('ma'||LPAD(to_char(memberaccuse_seq.NEXTVAL),6,'0'),'ad000005','惡意言語攻擊',1,'M000003','M000001');
INSERT INTO MEMBERACCUSE VALUES ('ma'||LPAD(to_char(memberaccuse_seq.NEXTVAL),6,'0'),'ad000002','上架不實商品',0,'M000001','M000006');
INSERT INTO MEMBERACCUSE VALUES ('ma'||LPAD(to_char(memberaccuse_seq.NEXTVAL),6,'0'),'ad000001','亂標商品價格',1,'M000004','M000002');
INSERT INTO MEMBERACCUSE VALUES ('ma'||LPAD(to_char(memberaccuse_seq.NEXTVAL),6,'0'),'ad000004','違規多次未停權',0,'M000005','M000007');
INSERT INTO MEMBERACCUSE VALUES ('ma'||LPAD(to_char(memberaccuse_seq.NEXTVAL),6,'0'),'ad000003','言語帶有歧視',1,'M000003','M000008');
INSERT INTO MEMBERACCUSE VALUES ('ma'||LPAD(to_char(memberaccuse_seq.NEXTVAL),6,'0'),'ad000006','惡意競價',0,'M000001','M000004');

-----------------------------新增會員檢舉案-----------------------------

-----------------------------新增競標商品檢舉案-----------------------------

INSERT INTO AUCTACCUSE VALUES ('a'||LPAD(to_char(auctaccuse_seq.NEXTVAL),6,'0'),'M000003','AUCT000002','ad000004','商品毀損',1);
INSERT INTO AUCTACCUSE VALUES ('a'||LPAD(to_char(auctaccuse_seq.NEXTVAL),6,'0'),'M000005','AUCT000006','ad000003','價錢太高',1);
INSERT INTO AUCTACCUSE VALUES ('a'||LPAD(to_char(auctaccuse_seq.NEXTVAL),6,'0'),'M000004','AUCT000005','ad000001','與圖片差異太大',1);
INSERT INTO AUCTACCUSE VALUES ('a'||LPAD(to_char(auctaccuse_seq.NEXTVAL),6,'0'),'M000001','AUCT000004','ad000002','仿冒品',1);
INSERT INTO AUCTACCUSE VALUES ('a'||LPAD(to_char(auctaccuse_seq.NEXTVAL),6,'0'),'M000002','AUCT000003','ad000005','違禁品',1);
INSERT INTO AUCTACCUSE VALUES ('a'||LPAD(to_char(auctaccuse_seq.NEXTVAL),6,'0'),'M000007','AUCT000001','ad000006','含色情成分',1);

-----------------------------新增競標商品檢舉案-----------------------------

-----------------------------新增直購商品檢舉案-----------------------------

INSERT INTO IMMEDACCUSE VALUES ('a'||LPAD(to_char(immedaccuse_seq.NEXTVAL),6,'0'),'M000003','IMMED000002','ad000004','商品毀損',1);
INSERT INTO IMMEDACCUSE VALUES ('a'||LPAD(to_char(immedaccuse_seq.NEXTVAL),6,'0'),'M000005','IMMED000006','ad000003','價錢太高',1);
INSERT INTO IMMEDACCUSE VALUES ('a'||LPAD(to_char(immedaccuse_seq.NEXTVAL),6,'0'),'M000004','IMMED000005','ad000001','與圖片差異太大',1);
INSERT INTO IMMEDACCUSE VALUES ('a'||LPAD(to_char(immedaccuse_seq.NEXTVAL),6,'0'),'M000001','IMMED000004','ad000002','仿冒品',1);
INSERT INTO IMMEDACCUSE VALUES ('a'||LPAD(to_char(immedaccuse_seq.NEXTVAL),6,'0'),'M000002','IMMED000003','ad000005','違禁品',1);
INSERT INTO IMMEDACCUSE VALUES ('a'||LPAD(to_char(immedaccuse_seq.NEXTVAL),6,'0'),'M000007','IMMED000001','ad000006','含色情成分',1);

-----------------------------新增直購商品檢舉案-----------------------------

-----------------------------新增Q&A-----------------------------

insert into question(QA_ID,ANS,QUE) values('Q'||LPAD(to_char(QUESTION_SEQ.NEXTVAL), 3, '0'),'您於登入會員後，至『我的帳戶』→『訂單管理』查詢配送狀況，訂單狀態：配送中-表示已通知廠商出貨；已配送-表示廠商已送交郵局或貨運寄送。若您當時選擇首次購買，則於此頁面下方依訂單編號進行訂單查詢，一樣可以確認訂單配送狀態。','我要如何查詢配送進度？');
insert into question(QA_ID,ANS,QUE) values('Q'||LPAD(to_char(QUESTION_SEQ.NEXTVAL), 3, '0'),'您可以在填寫訂單資料時的收件人欄位，輸入您指定的送貨地址，有「速」標誌的商品皆可離島地區配送，(另有材積及重量限制)','我可以指定送貨地點嗎？');
insert into question(QA_ID,ANS,QUE) values('Q'||LPAD(to_char(QUESTION_SEQ.NEXTVAL), 3, '0'),'有「速」標誌商品皆可離島全區配送，單一商品材積限制：長+寬+高需低於120公分; 單一商品重量限制：需低於20公斤; 運費：每張訂單加收運費200元; 配送時間：約3個工作天。','請問可以離島配送嗎?');
insert into question(QA_ID,ANS,QUE) values('Q'||LPAD(to_char(QUESTION_SEQ.NEXTVAL), 3, '0'),'紅利金視同現金，每一點紅利金等同於新台幣一元，可使用於FSG(但不包含旅遊商品)、專人訂購、語音訂購，以紅利金兌換之商品，同樣可享有猶豫期等相關客戶權益。','什麼是紅利金？');
insert into question(QA_ID,ANS,QUE) values('Q'||LPAD(to_char(QUESTION_SEQ.NEXTVAL), 3, '0'),'FSG將會不定時於網站或購物台舉辦促銷活動，請您多多參考。行銷活動贈送之紅利金將以訂單之成立與否為給獎認定標準，若該筆訂單事後取消，本公司得主張扣回贈送之紅利金。','我要如何獲得紅利金？');
insert into question(QA_ID,ANS,QUE) values('Q'||LPAD(to_char(QUESTION_SEQ.NEXTVAL), 3, '0'),'您可以於客戶登入後，至『我的帳戶』→『紅利金管理』中查詢紅利金金額','我要如何查詢紅利金？');
insert into question(QA_ID,ANS,QUE) values('Q'||LPAD(to_char(QUESTION_SEQ.NEXTVAL), 3, '0'),'FSG包裝出貨已全程攝影，在您收到訂購商品時，我們隨貨為您附上了「商品明細表」，為確保消費者權益，請您於開啟商品外箱時全程攝影，依表核對包裝箱內的商品內容，若有不符或短少，請於24小時內於網頁「聯絡客服」中反應，由網路客服人員為您服務，我們將為您作紀錄並進行處理。商品明細表為退換貨憑證之一，請您在7天猶豫期內，妥善保管勿毀損丟棄。','收到商品後，我需要注意什麼事項，以確保我的購物權益呢？');
insert into question(QA_ID,ANS,QUE) values('Q'||LPAD(to_char(QUESTION_SEQ.NEXTVAL), 3, '0'),'若您發現商品有短缺的現象，請您至「客服中心」與我們聯絡。','如我收到商品有缺件，應該如何處理？');
insert into question(QA_ID,ANS,QUE) values('Q'||LPAD(to_char(QUESTION_SEQ.NEXTVAL), 3, '0'),'『我的帳戶』內包含了客戶資料修改、密碼修改、訂單查詢、紅利金管理、暫收款管理、折價券管理、中獎記錄、追蹤清單，利用以上的介面可查詢到個人的訂購狀況。','什麼是『我的帳戶』？');
insert into question(QA_ID,ANS,QUE) values('Q'||LPAD(to_char(QUESTION_SEQ.NEXTVAL), 3, '0'),'FSG可接受VISA、Master、JCB、銀聯卡等四家國際發卡組織之信用卡。 可使用分期付款之發卡銀行如下：台北富邦、中國信託、聯邦、日盛、永豐、遠東、安泰、第一、臺灣新光、大眾、國泰世華、澳盛、玉山、凱基、合作金庫、兆豐、花旗台灣、上海、陽信、渣打、台新、元大、華泰、台灣永旺、台灣中小企銀、匯豐、台中商銀、華南、三信等家，真正提供無息分期優惠。','信用卡付款有卡別或發卡銀行的限制嗎？');

-----------------------------新增Q&A-----------------------------

COMMIT;

