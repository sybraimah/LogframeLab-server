CREATE TABLE IF NOT EXISTS USERS
(
    USERNAME VARCHAR(50) NOT NULL PRIMARY KEY,
    PASSWORD VARCHAR(50) NOT NULL,
    ENABLED  BOOLEAN     NOT NULL
);

CREATE TABLE IF NOT EXISTS `GROUPS`
(
    ID         BIGINT PRIMARY KEY,
    GROUP_NAME VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS GROUP_AUTHORITIES
(
    GROUP_ID  BIGINT      NOT NULL,
    AUTHORITY VARCHAR(50) NOT NULL,
    FOREIGN KEY FK_GROUP_AUTHORITIES_GROUP (GROUP_ID) REFERENCES `GROUPS` (ID)
);

CREATE TABLE IF NOT EXISTS GROUP_MEMBERS
(
    ID       BIGINT AUTO_INCREMENT PRIMARY KEY,
    USERNAME VARCHAR(50) NOT NULL,
    GROUP_ID BIGINT      NOT NULL,
    FOREIGN KEY FK_GROUP_MEMBERS_USER (USERNAME) REFERENCES USERS (USERNAME),
    FOREIGN KEY FK_GROUP_MEMBERS_GROUP (GROUP_ID) REFERENCES `GROUPS` (ID)
);

INSERT USERS
VALUES ('SECURITY_ADMIN', 'PASSWORD', TRUE),
       ('ADMIN', 'PASSWORD', TRUE),
       ('DEMO_USER', 'PASSWORD', TRUE);

INSERT `GROUPS`
VALUES (1, 'ADMIN'),
       (2, 'USER'),
       (3, 'SEC_ADMIN');

INSERT GROUP_AUTHORITIES
VALUES (1, 'CRUD_USER'),
       (2, 'READ_USER'),
       (2, 'READ_ADMIN'),
       (3, 'CRUD_ADMIN');

INSERT GROUP_MEMBERS (USERNAME, GROUP_ID)
VALUES ('SECURITY_ADMIN', 3),
       ('ADMIN', 1),
       ('DEMO_USER', 2);
