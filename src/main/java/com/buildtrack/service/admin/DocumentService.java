package com.buildtrack.service.admin;

import java.util.List;

import com.buildtrack.dao.admin.DocumentDao;
import com.buildtrack.model.Document;

public class DocumentService {
    private final DocumentDao documentDao = new DocumentDao();

    public List<Document> getAllDocuments() {
        return documentDao.getAllDocuments();
    }
}