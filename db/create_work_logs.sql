-- SQL migration to create the work_logs table used by WorkLogDao
-- Run this in the `buildtrack` database (e.g. in MySQL Workbench or mysql CLI)

CREATE TABLE IF NOT EXISTS `work_logs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `worker_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  `log_date` DATE NOT NULL,
  `description` TEXT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_work_logs_worker` (`worker_id`),
  INDEX `idx_work_logs_project` (`project_id`)
);

-- Optional foreign keys (uncomment if `users` and `projects` tables exist and are InnoDB):
-- ALTER TABLE `work_logs`
--   ADD CONSTRAINT `fk_work_logs_worker` FOREIGN KEY (`worker_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
--   ADD CONSTRAINT `fk_work_logs_project` FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`) ON DELETE CASCADE;
