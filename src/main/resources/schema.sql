DROP
ALL OBJECTS;
CREATE TABLE Users
(
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    user_name           varchar2(100),
    email               VARCHAR(250) DEFAULT NULL,
    password            VARCHAR2(300),
    email_Verified      varchar2(10),
    account_Locked      varchar2(10),
    account_Expired     varchar2(10),
    credentials_Expired varchar2(10),
    status              varchar2(1),
    roles               varchar2(250),
    provider            varchar2(250),
    provider_Id         varchar2(250),
    IMAGE_URL           varchar2(250),
    blocked_by          varchar2(250)
);

CREATE SEQUENCE SEQ_Coffee
    INCREMENT BY 1;

CREATE TABLE Coffee
(
    coffee_id       INT  PRIMARY KEY,
    brand           VARCHAR(20),
    origin          VARCHAR(20),
    characteristics VARCHAR(30)
);

CREATE TABLE MENU
(
    id                INT AUTO_INCREMENT PRIMARY KEY,
    DESCRIPTION       VARCHAR2(100),
    STATUS            VARCHAR2(1),
    LAST_APPROVE_BY   VARCHAR2(50),
    LAST_APPROVE_DATE TIMESTAMP(6),
    LAST_UPDATE_BY    VARCHAR2(50),
    LAST_UPDATE_DATE  TIMESTAMP(6),
    BATCH_NO          VARCHAR2(10)
);

CREATE TABLE MENU_DETAIL
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    DESCRIPTION varchar2(100),
    ON_CLICK    varchar2(100),
    ID_MENU     INT
);

CREATE TABLE STUDENT
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    NAME        varchar2(100),
    ROLL_NUMBER varchar2(100)
);

CREATE TABLE BAGS
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    NAME        varchar2(100),
    DESCRIPTION varchar2(100),
    ID_STUDENT  int
);

CREATE TABLE TRADE
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    isin     varchar2(100),
    quantity int,
    PRICE    double,
    customer varchar2(100),
    xmlns    varchar2(100),
    text     varchar2(100)
);

CREATE TABLE PERSON
(
    id                INT AUTO_INCREMENT PRIMARY KEY,
    NAME              varchar2(100),
    DATE_OF_BIRTH     TIMESTAMP(6),
    ADDRESS_ID        int,
    LAST_APPROVE_BY   VARCHAR2(50),
    LAST_APPROVE_DATE TIMESTAMP(6),
    LAST_UPDATE_BY    VARCHAR2(50),
    LAST_UPDATE_DATE  TIMESTAMP(6),
    status            varchar2(1)
);

CREATE TABLE ADDRESS
(
    id                INT AUTO_INCREMENT PRIMARY KEY,
    CITY              varchar2(100),
    DISTRICT          varchar2(100),
    ADDRESS_DETAIL    varchar2(200),
    LAST_APPROVE_BY   VARCHAR2(50),
    LAST_APPROVE_DATE TIMESTAMP(6),
    LAST_UPDATE_BY    VARCHAR2(50),
    LAST_UPDATE_DATE  TIMESTAMP(6),
    status            varchar2(1)
);


CREATE TABLE BATCH_JOB_INSTANCE
(
    JOB_INSTANCE_ID INT AUTO_INCREMENT PRIMARY KEY,
    VERSION         INT,
    JOB_NAME        VARCHAR(100) NOT NULL,
    JOB_KEY         VARCHAR(32)  NOT NULL,
    constraint JOB_INST_UN unique (JOB_NAME, JOB_KEY)
);

CREATE TABLE BATCH_JOB_EXECUTION
(
    JOB_EXECUTION_ID INT AUTO_INCREMENT PRIMARY KEY,
    VERSION          INT,
    JOB_INSTANCE_ID  INT NOT NULL,
    CREATE_TIME      DATETIME(6) NOT NULL,
    START_TIME       DATETIME(6) DEFAULT NULL,
    END_TIME         DATETIME(6) DEFAULT NULL,
    STATUS           VARCHAR(10),
    EXIT_CODE        VARCHAR(2500),
    EXIT_MESSAGE     VARCHAR(2500),
    LAST_UPDATED     DATETIME(6),
    constraint JOB_INST_EXEC_FK foreign key (JOB_INSTANCE_ID)
        references BATCH_JOB_INSTANCE (JOB_INSTANCE_ID)
);

CREATE TABLE BATCH_JOB_EXECUTION_PARAMS
(
    JOB_EXECUTION_ID INT          NOT NULL,
    PARAMETER_NAME   VARCHAR(100) NOT NULL,
    PARAMETER_TYPE   VARCHAR(100) NOT NULL,
    PARAMETER_VALUE  VARCHAR(2500),
    IDENTIFYING      CHAR(1)      NOT NULL,
    constraint JOB_EXEC_PARAMS_FK foreign key (JOB_EXECUTION_ID)
        references BATCH_JOB_EXECUTION (JOB_EXECUTION_ID)
);

CREATE TABLE BATCH_STEP_EXECUTION
(
    STEP_EXECUTION_ID  INT          NOT NULL PRIMARY KEY,
    VERSION            INT          NOT NULL,
    STEP_NAME          VARCHAR(100) NOT NULL,
    JOB_EXECUTION_ID   INT          NOT NULL,
    CREATE_TIME        DATETIME(6) NOT NULL,
    START_TIME         DATETIME(6) DEFAULT NULL,
    END_TIME           DATETIME(6) DEFAULT NULL,
    STATUS             VARCHAR(10),
    COMMIT_COUNT       INT,
    READ_COUNT         INT,
    FILTER_COUNT       INT,
    WRITE_COUNT        INT,
    READ_SKIP_COUNT    INT,
    WRITE_SKIP_COUNT   INT,
    PROCESS_SKIP_COUNT INT,
    ROLLBACK_COUNT     INT,
    EXIT_CODE          VARCHAR(2500),
    EXIT_MESSAGE       VARCHAR(2500),
    LAST_UPDATED       DATETIME(6),
    constraint JOB_EXEC_STEP_FK foreign key (JOB_EXECUTION_ID)
        references BATCH_JOB_EXECUTION (JOB_EXECUTION_ID)
);

CREATE TABLE BATCH_STEP_EXECUTION_CONTEXT
(
    STEP_EXECUTION_ID  INT           NOT NULL PRIMARY KEY,
    SHORT_CONTEXT      VARCHAR(2500) NOT NULL,
    SERIALIZED_CONTEXT TEXT,
    constraint STEP_EXEC_CTX_FK foreign key (STEP_EXECUTION_ID)
        references BATCH_STEP_EXECUTION (STEP_EXECUTION_ID)
);

CREATE TABLE BATCH_JOB_EXECUTION_CONTEXT
(
    JOB_EXECUTION_ID   INT           NOT NULL PRIMARY KEY,
    SHORT_CONTEXT      VARCHAR(2500) NOT NULL,
    SERIALIZED_CONTEXT TEXT,
    constraint JOB_EXEC_CTX_FK foreign key (JOB_EXECUTION_ID)
        references BATCH_JOB_EXECUTION (JOB_EXECUTION_ID)
);

CREATE SEQUENCE BATCH_JOB_SEQ
    MINVALUE 1
    MAXVALUE 999999999
    INCREMENT BY 1
    START WITH 202700
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE BATCH_STEP_EXECUTION_SEQ
    MINVALUE 1
    MAXVALUE 999999999
    INCREMENT BY 1
    START WITH 202700
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE BATCH_JOB_EXECUTION_SEQ
    MINVALUE 1
    MAXVALUE 999999999
    INCREMENT BY 1
    START WITH 202700
    NOCACHE
    NOCYCLE;


CREATE TABLE UPLOAD_FILE_ERROR
(
    ID                   INT AUTO_INCREMENT PRIMARY KEY,
    UPLOAD_FILE_ERROR    VARCHAR2(50),
    UPLOAD_FILE_ERROR_ID VARCHAR2(50),
    LINE_NUMBER          NUMBER(15),
    LINE                 VARCHAR2(4000),
    ERROR_CODE           VARCHAR2(10),
    ERROR_MESSAGE        VARCHAR2(500),
    ETL_DATE             TIMESTAMP(6),
    BATCH_NO             VARCHAR2(20)
);

CREATE TABLE UPLOAD_FILE_COFFEE
(
    ID              INT AUTO_INCREMENT PRIMARY KEY,
    LINE_NUMBER     NUMBER(15),
    LINE            VARCHAR2(4000),
    brand           VARCHAR(20),
    origin          VARCHAR(20),
    characteristics VARCHAR(30),
    BATCH_NO        VARCHAR2(20)
);

CREATE TABLE QRTZ_CALENDARS
(
    SCHED_NAME    VARCHAR(120) NOT NULL,
    CALENDAR_NAME VARCHAR(200) NOT NULL,
    CALENDAR      IMAGE        NOT NULL
);


CREATE TABLE QRTZ_CRON_TRIGGERS
(
    SCHED_NAME      VARCHAR(120) NOT NULL,
    TRIGGER_NAME    VARCHAR(200) NOT NULL,
    TRIGGER_GROUP   VARCHAR(200) NOT NULL,
    CRON_EXPRESSION VARCHAR(120) NOT NULL,
    TIME_ZONE_ID    VARCHAR(80)
);


CREATE TABLE QRTZ_FIRED_TRIGGERS
(
    SCHED_NAME        VARCHAR(120) NOT NULL,
    ENTRY_ID          VARCHAR(95)  NOT NULL,
    TRIGGER_NAME      VARCHAR(200) NOT NULL,
    TRIGGER_GROUP     VARCHAR(200) NOT NULL,
    INSTANCE_NAME     VARCHAR(200) NOT NULL,
    FIRED_TIME        BIGINT       NOT NULL,
    SCHED_TIME        BIGINT       NOT NULL,
    PRIORITY          INTEGER      NOT NULL,
    STATE             VARCHAR(16)  NOT NULL,
    JOB_NAME          VARCHAR(200) NULL,
    JOB_GROUP         VARCHAR(200) NULL,
    IS_NONCONCURRENT  BOOLEAN      NULL,
    REQUESTS_RECOVERY BOOLEAN      NULL
);


CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS
(
    SCHED_NAME    VARCHAR(120) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL
);


CREATE TABLE QRTZ_SCHEDULER_STATE
(
    SCHED_NAME        VARCHAR(120) NOT NULL,
    INSTANCE_NAME     VARCHAR(200) NOT NULL,
    LAST_CHECKIN_TIME BIGINT       NOT NULL,
    CHECKIN_INTERVAL  BIGINT       NOT NULL
);


CREATE TABLE QRTZ_LOCKS
(
    SCHED_NAME VARCHAR(120) NOT NULL,
    LOCK_NAME  VARCHAR(40)  NOT NULL
);


CREATE TABLE QRTZ_JOB_DETAILS
(
    SCHED_NAME        VARCHAR(120) NOT NULL,
    JOB_NAME          VARCHAR(200) NOT NULL,
    JOB_GROUP         VARCHAR(200) NOT NULL,
    DESCRIPTION       VARCHAR(250) NULL,
    JOB_CLASS_NAME    VARCHAR(250) NOT NULL,
    IS_DURABLE        BOOLEAN      NOT NULL,
    IS_NONCONCURRENT  BOOLEAN      NOT NULL,
    IS_UPDATE_DATA    BOOLEAN      NOT NULL,
    REQUESTS_RECOVERY BOOLEAN      NOT NULL,
    JOB_DATA          IMAGE        NULL
);


CREATE TABLE QRTZ_SIMPLE_TRIGGERS
(
    SCHED_NAME      VARCHAR(120) NOT NULL,
    TRIGGER_NAME    VARCHAR(200) NOT NULL,
    TRIGGER_GROUP   VARCHAR(200) NOT NULL,
    REPEAT_COUNT    BIGINT       NOT NULL,
    REPEAT_INTERVAL BIGINT       NOT NULL,
    TIMES_TRIGGERED BIGINT       NOT NULL
);


CREATE TABLE qrtz_simprop_triggers
(
    SCHED_NAME    VARCHAR(120)   NOT NULL,
    TRIGGER_NAME  VARCHAR(200)   NOT NULL,
    TRIGGER_GROUP VARCHAR(200)   NOT NULL,
    STR_PROP_1    VARCHAR(512)   NULL,
    STR_PROP_2    VARCHAR(512)   NULL,
    STR_PROP_3    VARCHAR(512)   NULL,
    INT_PROP_1    INTEGER        NULL,
    INT_PROP_2    INTEGER        NULL,
    LONG_PROP_1   BIGINT         NULL,
    LONG_PROP_2   BIGINT         NULL,
    DEC_PROP_1    NUMERIC(13, 4) NULL,
    DEC_PROP_2    NUMERIC(13, 4) NULL,
    BOOL_PROP_1   BOOLEAN        NULL,
    BOOL_PROP_2   BOOLEAN        NULL
);


CREATE TABLE QRTZ_BLOB_TRIGGERS
(
    SCHED_NAME    VARCHAR(120) NOT NULL,
    TRIGGER_NAME  VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    BLOB_DATA     IMAGE        NULL
);


CREATE TABLE QRTZ_TRIGGERS
(
    SCHED_NAME     VARCHAR(120) NOT NULL,
    TRIGGER_NAME   VARCHAR(200) NOT NULL,
    TRIGGER_GROUP  VARCHAR(200) NOT NULL,
    JOB_NAME       VARCHAR(200) NOT NULL,
    JOB_GROUP      VARCHAR(200) NOT NULL,
    DESCRIPTION    VARCHAR(250) NULL,
    NEXT_FIRE_TIME BIGINT       NULL,
    PREV_FIRE_TIME BIGINT       NULL,
    PRIORITY       INTEGER      NULL,
    TRIGGER_STATE  VARCHAR(16)  NOT NULL,
    TRIGGER_TYPE   VARCHAR(8)   NOT NULL,
    START_TIME     BIGINT       NOT NULL,
    END_TIME       BIGINT       NULL,
    CALENDAR_NAME  VARCHAR(200) NULL,
    MISFIRE_INSTR  SMALLINT     NULL,
    JOB_DATA       IMAGE        NULL
);


ALTER TABLE QRTZ_CALENDARS
    ADD CONSTRAINT PK_QRTZ_CALENDARS PRIMARY KEY (SCHED_NAME,
                                                  CALENDAR_NAME);


ALTER TABLE QRTZ_CRON_TRIGGERS
    ADD CONSTRAINT PK_QRTZ_CRON_TRIGGERS PRIMARY KEY (SCHED_NAME,
                                                      TRIGGER_NAME,
                                                      TRIGGER_GROUP);


ALTER TABLE QRTZ_FIRED_TRIGGERS
    ADD CONSTRAINT PK_QRTZ_FIRED_TRIGGERS PRIMARY KEY (SCHED_NAME,
                                                       ENTRY_ID);


ALTER TABLE QRTZ_PAUSED_TRIGGER_GRPS
    ADD CONSTRAINT PK_QRTZ_PAUSED_TRIGGER_GRPS PRIMARY KEY (SCHED_NAME,
                                                            TRIGGER_GROUP);


ALTER TABLE QRTZ_SCHEDULER_STATE
    ADD CONSTRAINT PK_QRTZ_SCHEDULER_STATE PRIMARY KEY (SCHED_NAME,
                                                        INSTANCE_NAME);


ALTER TABLE QRTZ_LOCKS
    ADD CONSTRAINT PK_QRTZ_LOCKS PRIMARY KEY (SCHED_NAME,
                                              LOCK_NAME);


ALTER TABLE QRTZ_JOB_DETAILS
    ADD CONSTRAINT PK_QRTZ_JOB_DETAILS PRIMARY KEY (SCHED_NAME,
                                                    JOB_NAME,
                                                    JOB_GROUP);


ALTER TABLE QRTZ_SIMPLE_TRIGGERS
    ADD CONSTRAINT PK_QRTZ_SIMPLE_TRIGGERS PRIMARY KEY (SCHED_NAME,
                                                        TRIGGER_NAME,
                                                        TRIGGER_GROUP);


ALTER TABLE QRTZ_SIMPROP_TRIGGERS
    ADD CONSTRAINT PK_QRTZ_SIMPROP_TRIGGERS PRIMARY KEY (SCHED_NAME,
                                                         TRIGGER_NAME,
                                                         TRIGGER_GROUP);


ALTER TABLE QRTZ_TRIGGERS
    ADD CONSTRAINT PK_QRTZ_TRIGGERS PRIMARY KEY (SCHED_NAME,
                                                 TRIGGER_NAME,
                                                 TRIGGER_GROUP);


ALTER TABLE QRTZ_CRON_TRIGGERS
    ADD CONSTRAINT FK_QRTZ_CRON_TRIGGERS_QRTZ_TRIGGERS
        FOREIGN KEY (SCHED_NAME,
                     TRIGGER_NAME,
                     TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) ON
            DELETE CASCADE;


ALTER TABLE QRTZ_SIMPLE_TRIGGERS
    ADD CONSTRAINT FK_QRTZ_SIMPLE_TRIGGERS_QRTZ_TRIGGERS
        FOREIGN KEY (SCHED_NAME,
                     TRIGGER_NAME,
                     TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) ON
            DELETE CASCADE;


ALTER TABLE QRTZ_SIMPROP_TRIGGERS
    ADD CONSTRAINT FK_QRTZ_SIMPROP_TRIGGERS_QRTZ_TRIGGERS
        FOREIGN KEY (SCHED_NAME,
                     TRIGGER_NAME,
                     TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) ON
            DELETE CASCADE;


ALTER TABLE QRTZ_TRIGGERS
    ADD CONSTRAINT FK_QRTZ_TRIGGERS_QRTZ_JOB_DETAILS
        FOREIGN KEY (SCHED_NAME,
                     JOB_NAME,
                     JOB_GROUP) REFERENCES QRTZ_JOB_DETAILS (SCHED_NAME, JOB_NAME, JOB_GROUP);

CREATE TABLE Customer_info (
                               Customer_ID INT PRIMARY KEY,
                               first_name VARCHAR(255),
                               last_name VARCHAR(255),
                               email VARCHAR(255),
                               gender VARCHAR(10),
                               contact VARCHAR(20),
                               country VARCHAR(100)

);
