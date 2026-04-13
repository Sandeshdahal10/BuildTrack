CREATE TABLE users (
                       id              INT PRIMARY KEY AUTO_INCREMENT,
                       full_name       VARCHAR(100)    NOT NULL,
                       email           VARCHAR(150)    NOT NULL UNIQUE,
                       phone           VARCHAR(20)     NOT NULL,
                       password        VARCHAR(255)    NOT NULL,
                       role            ENUM('ADMIN', 'WORKER', 'CLIENT') NOT NULL DEFAULT 'WORKER',
                       status          ENUM('PENDING', 'APPROVED', 'DEACTIVATED') NOT NULL DEFAULT 'PENDING',
                       daily_wage      DECIMAL(10, 2)  DEFAULT 0.00,
                       reset_token     VARCHAR(255)    DEFAULT NULL,
                       reset_token_expiry TIMESTAMP NULL DEFAULT NULL,
                       created_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
                       updated_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

                       CONSTRAINT chk_phone     CHECK (LENGTH(phone) =10),
                       CONSTRAINT chk_daily_wage CHECK (daily_wage >= 0)
);
