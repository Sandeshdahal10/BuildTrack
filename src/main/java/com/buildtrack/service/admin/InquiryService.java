package com.buildtrack.service.admin;

import java.util.ArrayList;
import java.util.List;

import com.buildtrack.dao.admin.InquiryDao;
import com.buildtrack.model.Inquiry;
import com.buildtrack.util.ValidationUtil;

public class InquiryService {
    private final InquiryDao inquiryDao = new InquiryDao();

    public List<Inquiry> getAllInquiries() {
        return inquiryDao.getAllInquiries();
    }

    public List<String> updateInquiry(int id, String reply, String status) {
        List<String> errors = new ArrayList<>();
        if (ValidationUtil.isEmpty(status)) {
            errors.add("Status cannot be empty.");
        }
        
        if (errors.isEmpty()) {
            boolean success = inquiryDao.updateInquiryReplyAndStatus(id, reply, status);
            if (!success) {
                errors.add("Failed to update inquiry.");
            }
        }
        return errors;
    }
}