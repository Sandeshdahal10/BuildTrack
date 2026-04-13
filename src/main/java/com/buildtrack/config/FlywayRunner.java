package com.buildtrack.config;
import java.io.InputStream;
import java.util.Properties;

import org.flywaydb.core.Flyway;

public class FlywayRunner {
    public static void migrate() {
        Properties properties = new Properties();
        try (InputStream input = FlywayRunner.class.getClassLoader().getResourceAsStream("application.properties")) {
            if (input == null) {
                System.out.println("Sorry, unable to find application.properties");
                return;
            }
            properties.load(input);
        } catch (Exception ex) {
            ex.printStackTrace();
            return;
        }

        Flyway flyway = Flyway.configure()
                .baselineOnMigrate(true)
                .dataSource(properties.getProperty("db.url"), properties.getProperty("db.username"), properties.getProperty("db.password"))
                .load();

        flyway.migrate();
    }
}