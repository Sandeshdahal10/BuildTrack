-- SQL migration to create the project_documents table
-- Run this in the `buildtrack` database (e.g. in MySQL Workbench or mysql CLI)

CREATE TABLE IF NOT EXISTS `project_documents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `project_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  `file_name` VARCHAR(255) NOT NULL,
  `file_path` VARCHAR(500) NOT NULL,
  `file_type` VARCHAR(255),
  `file_size` BIGINT DEFAULT 0,
  `uploaded_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_project_documents_project` (`project_id`),
  INDEX `idx_project_documents_client` (`client_id`),
  INDEX `idx_project_documents_uploaded_at` (`uploaded_at`)
);

-- Optional foreign keys (uncomment if `projects` and `users` tables exist and are InnoDB):
-- ALTER TABLE `project_documents`
--   ADD CONSTRAINT `fk_project_documents_project` FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`) ON DELETE CASCADE,
--   ADD CONSTRAINT `fk_project_documents_client` FOREIGN KEY (`client_id`) REFERENCES `users`(`id`) ON DELETE CASCADE;
