package com.buildtrack.model;

import java.time.LocalDateTime;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String password;
    private String role;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public User(){}
    public User(String fullName, String email, String password, String role){
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.status = "PENDING";
    }
    //Getters and Setter

    public int getId() {
            return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public boolean isAdmin() {
        return "Admin".equals(role);
    }
    public boolean isWorker() {
        return "Worker".equals(role);
    }
    public boolean isClient() {
        return "Client".equals(role);
    }
    public boolean isActive() {
        return "Active".equals(status);
    }
    public boolean isPending() {
        return "Pending".equals(status);
    }

}
