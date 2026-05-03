package com.buildtrack.model;

import java.math.BigDecimal;

/**
 * Worker-specific view of user details and wage information.
 */
public class Worker {
    private int id;
    private String userId;
    private BigDecimal dailyWage;
    private String skills;
    private String fullName;
    private String email;
    private String status;

    /**
     * Creates an empty worker instance.
     */
    public Worker() {
    }

}
