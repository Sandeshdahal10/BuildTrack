package com.buildtrack.service.admin;

import java.util.List;

import com.buildtrack.dao.admin.DocumentDao;
import com.buildtrack.model.Document;

/**
 * Service layer for document queries.
 */
public class DocumentService {
    private final DocumentDao documentDao = new DocumentDao();

    /**
     * Returns all documents.
     */
    public List<Document> getAllDocuments() {
        return documentDao.getAllDocuments();
    }
}