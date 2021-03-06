CREATE TABLE IF NOT EXISTS `USERS`
(
    USERNAME       VARCHAR(50) NOT NULL PRIMARY KEY,
    PASSWORD       VARCHAR(150) NOT NULL,
    ENABLED        BOOLEAN     NOT NULL,
    CREATED_BY     VARCHAR(50),
    CREATED_AT     TIMESTAMP,
    LAST_UPDATE_BY VARCHAR(50),
    UPDATED_AT     TIMESTAMP   NULL,
    UPDATED_BY     VARCHAR(50) NULL
);

CREATE TABLE IF NOT EXISTS `GROUPS`
(
    ID             BIGINT PRIMARY KEY,
    GROUP_NAME     VARCHAR(50) NOT NULL UNIQUE,
    CREATED_BY     VARCHAR(50),
    CREATED_AT     TIMESTAMP,
    LAST_UPDATE_BY VARCHAR(50),
    UPDATED_AT     TIMESTAMP   NULL,
    UPDATED_BY     VARCHAR(50) NULL
);

CREATE TABLE IF NOT EXISTS `GROUP_AUTHORITIES`
(
    GROUP_ID       BIGINT      NOT NULL,
    AUTHORITY      VARCHAR(50) NOT NULL,
    CREATED_BY     VARCHAR(50),
    CREATED_AT     TIMESTAMP,
    LAST_UPDATE_BY VARCHAR(50),
    UPDATED_AT     TIMESTAMP   NULL,
    UPDATED_BY     VARCHAR(50) NULL,
    PRIMARY KEY (GROUP_ID, AUTHORITY),
    CONSTRAINT FK_GROUP_AUTHORITIES_GROUP FOREIGN KEY (GROUP_ID) REFERENCES `GROUPS` (ID)
);

CREATE TABLE IF NOT EXISTS `GROUP_MEMBERS`
(
    USERNAME       VARCHAR(50) NOT NULL,
    GROUP_ID       BIGINT      NOT NULL,
    CREATED_BY     VARCHAR(50),
    CREATED_AT     TIMESTAMP,
    LAST_UPDATE_BY VARCHAR(50),
    UPDATED_AT     TIMESTAMP   NULL,
    UPDATED_BY     VARCHAR(50) NULL,
    PRIMARY KEY (USERNAME, GROUP_ID),
    CONSTRAINT FK_GROUP_MEMBERS_USER FOREIGN KEY (USERNAME) REFERENCES USERS (USERNAME),
    CONSTRAINT FK_GROUP_MEMBERS_GROUP FOREIGN KEY (GROUP_ID) REFERENCES `GROUPS` (ID)
);

INSERT INTO `GROUPS` (ID, GROUP_NAME)
VALUES (1, 'SEC_ADMIN'),
       (2, 'APP_USER'),
       (3, 'INDICATOR_ADMIN');

INSERT INTO `GROUP_AUTHORITIES` (GROUP_ID, AUTHORITY)
VALUES (1, 'CRUD_APP_USER'),
       (2, 'READ_APP_USER'),
       (2, 'READ_INDICATOR'),
       (2, 'READ_INDICATOR_LEVEL'),
       (1, 'CRUD_ADMIN'),
       (3, 'CRUD_INDICATOR'),
       (3, 'CRUD_INDICATOR_LEVEL');
