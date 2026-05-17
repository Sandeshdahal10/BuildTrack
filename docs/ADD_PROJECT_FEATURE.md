# Add New Project Feature - Implementation Guide

## Overview
This implementation adds a complete "Add New Project" feature to the BuildTrack Client Portal. The feature allows authenticated clients to create new construction projects with file upload capability.

## Files Created

### 1. Model Classes

#### [ProjectDocument.java](src/main/java/com/buildtrack/model/ProjectDocument.java)
- POJO representing a project document
- Fields: id, projectId, clientId, fileName, filePath, fileType, fileSize, uploadedAt
- Includes method: `getFormattedFileSize()` for human-readable file size display

### 2. DAO Layer

#### [ClientProjectDAO.java](src/main/java/com/buildtrack/dao/client/ClientProjectDAO.java)
- `createProject(Project)` - Inserts project into database, returns generated ID
- `saveProjectDocument(ProjectDocument)` - Saves document record to database
- `projectBelongsToClient(projectId, clientId)` - Security check for ownership

### 3. Service Layer

#### [ClientProjectService.java](src/main/java/com/buildtrack/service/client/ClientProjectService.java)
- `createProject()` - Validates and creates project (returns project ID)
- `saveProjectDocument()` - Validates and saves uploaded file
- File validation: max 5MB, allowed types (PDF, DOC, DOCX, JPG, PNG)
- Server-side validation for all input fields
- Generates unique filenames using UUID
- Creates upload directory if it doesn't exist

### 4. Controller

#### [ClientAddProjectServlet.java](src/main/java/com/buildtrack/controller/client/ClientAddProjectServlet.java)
- `@WebServlet("/client/addProject")`
- `@MultipartConfig` for file upload handling
- Session validation on both GET and POST
- GET: Displays the form
- POST: Processes form submission with file upload
- Handles validation errors with form data preservation
- Redirects to project list on success

### 5. Views

#### [addProject.jsp](src/main/webapp/WEB-INF/views/client/addProject.jsp)
- Complete form with fields:
  - Project Title (text input, max 100 chars, required)
  - Description (textarea, max 500 chars, required)
  - Budget (number input, min 0, step 0.01, required)
  - Start Date (date picker, required)
  - End Date (date picker, required, validates after start date)
  - Status (dropdown: Planned, In Progress, Completed, On Hold)
  - Document Upload (file input, optional, drag & drop support)
- Error message display
- Form data preservation on validation errors
- Tailwind CSS styling consistent with client dashboard
- Client-side JavaScript validation and file handling

#### Modified [project.jsp](src/main/webapp/WEB-INF/views/client/project.jsp)
- Added "Add New Project" button in header (blue, with plus icon)
- Visible only to authenticated clients
- Success message display after project creation
- Responsive design for mobile

## Database

### New Table: project_documents
See [create_project_documents.sql](db/create_project_documents.sql)
```sql
CREATE TABLE project_documents (
  id INT PRIMARY KEY AUTO_INCREMENT,
  project_id INT NOT NULL,
  client_id INT NOT NULL,
  file_name VARCHAR(255),
  file_path VARCHAR(500),
  file_type VARCHAR(50),
  file_size BIGINT,
  uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEXES on (project_id, client_id, uploaded_at)
);
```

### Existing Table: projects
Should have these columns:
- id (INT PRIMARY KEY AUTO_INCREMENT)
- title (VARCHAR)
- description (TEXT)
- client_id (INT FOREIGN KEY)
- start_date (DATE)
- end_date (DATE)
- total_budget (DECIMAL)
- status (VARCHAR) - values: PLANNED, IN_PROGRESS, COMPLETED, ON_HOLD
- created_at (TIMESTAMP)
- updated_at (TIMESTAMP)

## Setup Instructions

### 1. Database Setup
Execute the SQL migration scripts:
```bash
mysql -u username -p buildtrack < db/create_project_documents.sql
```

Ensure the `projects` table exists with all required columns.

### 2. Directory Structure
Create the upload directory:
```bash
mkdir -p uploads/documents
chmod 755 uploads/documents
```

### 3. Web.xml
No changes required - uses `@WebServlet` annotation.

## Features

### Security
- ✓ Session validation on all requests
- ✓ Client ownership verification
- ✓ Redirects to login if session invalid

### Validation
- ✓ Client-side: HTML5 required, maxlength, number validation
- ✓ Server-side: 
  - Title/Description not null or empty
  - Budget >= 0
  - End date >= Start date
  - Valid status value
  - File size <= 5MB
  - File type whitelisted

### File Upload
- ✓ Multipart form data handling
- ✓ Unique filename generation (UUID)
- ✓ File system error handling
- ✓ Database rollback if file save fails

### User Experience
- ✓ Error messages preserved with form data on validation failure
- ✓ Success message displayed on project list
- ✓ Drag & drop file upload
- ✓ Responsive design
- ✓ Consistent Tailwind CSS styling

## API Endpoints

### GET /client/addProject
Displays the project creation form.

### POST /client/addProject
Handles project submission.

**Parameters:**
- title (String) - Project title
- description (String) - Project description
- budget (BigDecimal) - Total budget in NPR
- startDate (Date) - Project start date (YYYY-MM-DD)
- endDate (Date) - Project end date (YYYY-MM-DD)
- status (String) - Project status (PLANNED, IN_PROGRESS, COMPLETED, ON_HOLD)
- document (File) - Optional project document

**Success Response:**
- Redirects to `/client/project` with success message in session

**Error Response:**
- Redirects to `/client/addProject` with errors and form data in session

## Usage Flow

1. Client clicks "Add New Project" button on projects page
2. Form displays with all required fields
3. Client fills in project details
4. Client optionally uploads a document
5. Client submits form
6. Server validates:
   - All required fields present
   - Budget is valid number
   - Dates are valid and end >= start
   - Status is valid
   - File (if present) is within size limit and allowed type
7. If validation fails:
   - Form redisplays with error messages
   - Form data is preserved for correction
8. If validation succeeds:
   - Project is created in database
   - Document is saved to file system and database (if uploaded)
   - User is redirected to projects list with success message

## Configuration

### File Upload Limits
Edit `ClientProjectService.java`:
- `MAX_FILE_SIZE = 5 * 1024 * 1024` (5 MB)
- `ALLOWED_EXTENSIONS = {".pdf", ".doc", ".docx", ".jpg", ".jpeg", ".png"}`

### Upload Directory
Edit `ClientProjectService.java`:
- `UPLOAD_DIR = "uploads/documents"`

### Multipart Config (in servlet)
- fileSizeThreshold: 1 MB
- maxFileSize: 5 MB
- maxRequestSize: 10 MB

## Testing Scenarios

### Test 1: Valid Project Creation
1. Fill all required fields
2. Submit without file
3. Expect: Project created, redirect to list with success message

### Test 2: With File Upload
1. Fill all required fields
2. Upload valid PDF/DOC file
3. Submit
4. Expect: Project created, document saved, success message

### Test 3: Validation Errors
1. Leave title empty or too long (>100 chars)
2. Leave status unselected
3. Set end date before start date
4. Submit
5. Expect: Form redisplays with specific errors and preserved data

### Test 4: File Upload Errors
1. Try uploading file > 5MB
2. Expect: Error message about file size

### Test 5: Invalid File Type
1. Try uploading .zip or .txt file
2. Expect: Error message about file type

### Test 6: Session Validation
1. Access `/client/addProject` without session
2. Expect: Redirect to login page

## Future Enhancements

1. Project search/filtering
2. Bulk document upload
3. Document preview
4. Edit existing projects
5. Archive/delete projects
6. Project templates
7. Cost tracking integration
8. Worker assignment from project creation
9. Email notifications on project creation
10. Project status workflow automation

## Browser Compatibility

- Chrome/Edge: Full support
- Firefox: Full support
- Safari: Full support
- IE11: Requires polyfills for Tailwind CSS

## Performance Considerations

1. File upload limited to 5MB to prevent server overload
2. Unique filenames prevent collisions
3. Database indexes on frequently queried columns
4. Proper connection closing in DAO layer

## Troubleshooting

### Issue: File upload fails
- Check `uploads/documents` directory exists and is writable
- Verify multipart config in servlet
- Check file size limit in service

### Issue: Project not saving
- Verify `projects` table exists with all columns
- Check MySQL JDBC driver is loaded
- Check database connection in application.properties

### Issue: Session validation failing
- Check session timeout setting
- Verify login flow sets userId in session
- Check session cookie settings

## Dependencies

### Java
- Jakarta EE (Servlet 5.0+)
- Java 11+

### Database
- MySQL 5.7+

### Frontend
- Tailwind CSS (already in project)
- Browser with HTML5 support
