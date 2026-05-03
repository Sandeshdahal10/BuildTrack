# BuildTrack - Java Classes & Methods Documentation

## Class: AdminDashboardController.java (Package: com.buildtrack.controller.admin)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`

## Class: AttendanceController.java (Package: com.buildtrack.controller.admin)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`
- `private void transferFlashMessages(HttpServletRequest request)`
- `protected void doPost(HttpServletRequest request, HttpServletResponse response)`

## Class: ClientController.java (Package: com.buildtrack.controller.admin)

- `protected void doGet(HttpServletRequest req, HttpServletResponse resp)`
- `protected void doPost(HttpServletRequest req, HttpServletResponse resp)`

## Class: ExpenseController.java (Package: com.buildtrack.controller.admin)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`
- `protected void doPost(HttpServletRequest request, HttpServletResponse response)`
- `private void preserveForm(HttpServletRequest request)`

## Class: InquiryController.java (Package: com.buildtrack.controller.admin)

- `protected void doPost(HttpServletRequest request, HttpServletResponse response)`

## Class: MaterialController.java (Package: com.buildtrack.controller.admin)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`
- `protected void doPost(HttpServletRequest request, HttpServletResponse response)`
- `private void preserveMaterialForm(HttpServletRequest request)`

## Class: PayrollController.java (Package: com.buildtrack.controller.admin)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`
- `private void transferFlashMessages(HttpServletRequest request)`
- `protected void doPost(HttpServletRequest request, HttpServletResponse response)`
- `private Integer resolveAdminId(HttpServletRequest request)`
- `private String normalizeMonthYear(String monthYear)`

## Class: ProjectController.java (Package: com.buildtrack.controller.admin)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`
- `protected void doPost(HttpServletRequest request, HttpServletResponse response)`
- `private void preserveProjectForm(HttpServletRequest request)`
- `private void loadProjectListPageData(HttpServletRequest request)`

## Class: ReportController.java (Package: com.buildtrack.controller.admin)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`

## Class: UserManagementController.java (Package: com.buildtrack.controller.admin)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`
- `protected void doPost(HttpServletRequest request, HttpServletResponse response)`

## Class: WorkerController.java (Package: com.buildtrack.controller.admin)

- `protected void doGet(HttpServletRequest req, HttpServletResponse resp)`
- `protected void doPost(HttpServletRequest req, HttpServletResponse resp)`

## Class: ForgotPasswordController.java (Package: com.buildtrack.controller.auth)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`
- `protected void doPost(HttpServletRequest request, HttpServletResponse response)`

## Class: LoginController.java (Package: com.buildtrack.controller.auth)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`
- `protected void doPost(HttpServletRequest request, HttpServletResponse response)`

## Class: LogoutController.java (Package: com.buildtrack.controller.auth)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`

## Class: RegisterController.java (Package: com.buildtrack.controller.auth)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`
- `protected void doPost(HttpServletRequest request, HttpServletResponse response)`

## Class: ResetPasswordController.java (Package: com.buildtrack.controller.auth)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`
- `protected void doPost(HttpServletRequest request, HttpServletResponse response)`

## Class: BudgetController.java (Package: com.buildtrack.controller.client)

- `public void doGet(HttpServletRequest request, HttpServletResponse response)`

## Class: ClientDashboardController.java (Package: com.buildtrack.controller.client)

- `public void doGet(HttpServletRequest request, HttpServletResponse response)`

## Class: ProfileController.java (Package: com.buildtrack.controller.client)

- `public void doGet(HttpServletRequest request, HttpServletResponse response)`

## Class: ProjectTrackingController.java (Package: com.buildtrack.controller.client)

- `public void doGet(HttpServletRequest request, HttpServletResponse response)`

## Class: AboutController.java (Package: com.buildtrack.controller.common)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`

## Class: ContactController.java (Package: com.buildtrack.controller.common)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`
- `protected void doPost(HttpServletRequest request, HttpServletResponse response)`
- `private String trim(String v)`

## Class: AttendanceController.java (Package: com.buildtrack.controller.worker)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`

## Class: PayslipController.java (Package: com.buildtrack.controller.worker)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`

## Class: ProfileController.java (Package: com.buildtrack.controller.worker)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`
- `protected void doPost(HttpServletRequest request, HttpServletResponse response)`

## Class: ProjectController.java (Package: com.buildtrack.controller.worker)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`

## Class: WorkerDashboardController.java (Package: com.buildtrack.controller.worker)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`

## Class: WorkLogController.java (Package: com.buildtrack.controller.worker)

- `protected void doGet(HttpServletRequest request, HttpServletResponse response)`

## Class: AttendanceDao.java (Package: com.buildtrack.dao.admin)

- `public boolean insert(Attendance a)`
- `public List<Attendance> findByDate(Date date)`
- `public List<Attendance> findByProjectAndDate(int projectId, Date date)`
- `public List<Attendance> findByWorker(int workerId, String monthYear)`
- `public int[] getAttendanceCounts(int workerId, String monthYear)`
- `public boolean exists(int workerId, int projectId, Date date)`
- `public List<Attendance> getProjectWorkerSummary(int projectId, String monthYear)`
- `private Attendance mapRow(ResultSet rs)`

## Class: DocumentDao.java (Package: com.buildtrack.dao.admin)

- `public List<Document> getAllDocuments()`
- `private Document mapRow(ResultSet rs)`

## Class: ExpenseDao.java (Package: com.buildtrack.dao.admin)

- `public int insert(Expense expense)`
- `public boolean update(Expense expense)`
- `public boolean delete(int id)`
- `public Expense findById(int id)`
- `public List<Expense> findAll()`
- `public List<Expense> findByProject(int projectId)`
- `public List<Expense> findRecent(int limit)`
- `public BigDecimal getTotalByProject(int projectId)`
- `public BigDecimal getGrandTotal()`
- `public List<Map<String, Object>> getCategoryBreakdown(int projectId)`
- `public List<Map<String, Object>> getProjectExpenseSummary()`
- `public BigDecimal getTotalByProjectAndMonth(int projectId, String monthYear)`
- `public int countAll()`
- `private Expense mapRow(ResultSet rs)`

## Class: InquiryDao.java (Package: com.buildtrack.dao.admin)

- `public List<Inquiry> getAllInquiries()`
- `public boolean updateInquiryReplyAndStatus(int inquiryId, String reply, String status)`
- `private Inquiry mapRow(ResultSet rs)`

## Class: MaterialDao.java (Package: com.buildtrack.dao.admin)

- `public List<Material> findAll()`
- `public List<Material> findLowStock()`
- `public Material findById(int id)`
- `public int insert(Material m)`
- `public boolean update(Material m)`
- `public boolean delete(int id)`
- `public int countAll()`
- `public int countLowStock()`
- `public boolean deductStock(Connection conn, int materialId, java.math.BigDecimal quantity)`
- `public List<MaterialUsage> findUsageByProject(int projectId)`
- `public List<MaterialUsage> findRecentUsage(int limit)`
- `public int insertUsage(Connection conn, MaterialUsage mu)`
- `public List<MaterialUsage> getUsageSummaryByProject(int projectId)`
- `private Material mapMaterial(ResultSet rs)`
- `private MaterialUsage mapUsage(ResultSet rs)`

## Class: PayrollDao.java (Package: com.buildtrack.dao.admin)

- `public int insert(Payroll p)`
- `public int insert(Connection conn, Payroll p)`
- `public boolean markAsPaid(int id)`
- `public List<Payroll> findByMonth(String monthYear)`
- `public Payroll findById(int id)`
- `public Payroll findByWorkerAndMonth(int workerId, String monthYear)`
- `public Payslip findPayslipById(int id)`
- `public boolean exists(int workerId, String monthYear)`
- `private Payroll mapRow(ResultSet rs)`
- `private Payslip mapPayslip(ResultSet rs)`

## Class: ProjectDao.java (Package: com.buildtrack.dao.admin)

- `public List<Project> findAll()`
- `public List<Project> findByStatus(String status)`
- `public Project findById(int id)`
- `public int insert(Project p)`
- `public boolean update(Project p)`
- `public boolean delete(int id)`
- `public int countByStatus(String status)`
- `public int countAll()`
- `public boolean assignWorker(int projectId, int workerId, String assignedRole)`
- `public boolean removeWorker(int projectId, int workerId)`
- `public List<User> findAssignedWorkers(int projectId)`
- `public int countAssignedWorkers(int projectId)`
- `public List<AssignedWorker> findAssignedWorkersWithRole(int projectId)`
- `private Project mapRow(ResultSet rs, boolean withClient)`

## Class: ReportDao.java (Package: com.buildtrack.dao.admin)

- `public List<Map<String, Object>> getBudgetVsActualAll()`
- `public Map<String, Object> getBudgetVsActual(int projectId)`
- `public List<Map<String, Object>> getMaterialExpenseByCategory(int projectId)`
- `public List<Map<String, Object>> getManualExpenseByCategory(int projectId)`
- `public List<Map<String, Object>> getCombinedExpenseBreakdown(int projectId)`
- `public List<Map<String, Object>> getPayrollSummaryByMonth()`
- `public BigDecimal getTotalMaterialCost()`
- `public BigDecimal getTotalPayrollCost()`
- `public BigDecimal getTotalManualExpenseCost()`
- `public BigDecimal getGrandTotalExpenses()`
- `public BigDecimal getProjectTotalCost(int projectId)`
- `private BigDecimal runSumQuery(String sql)`
- `private Map<String, Object> buildBudgetRow(ResultSet rs)`

## Class: UserDao.java (Package: com.buildtrack.dao.admin)

- `public List<User> findByRole(String role)`
- `public List<User> findByRoleAndStatus(String role, String status)`
- `public List<User> findByStatus(String status)`
- `public List<User> findAllNonAdmin()`
- `public User findById(int id)`
- `public List<User> searchWorkers(String query)`
- `public boolean updateStatus(int id, String status)`
- `public boolean updateDailyWage(int id, java.math.BigDecimal wage)`
- `public boolean updateProfile(int id, String fullName, String phone)`
- `public int countByRoleAndStatus(String role, String status)`
- `public int countByStatus(String status)`
- `private User mapRowBasic(ResultSet rs)`

## Class: AuthDao.java (Package: com.buildtrack.dao.auth)

- `public boolean insertUser(User user)`
- `public User findByEmail(String email)`
- `public User findById(int id)`
- `public User findByResetToken(String token)`
- `public boolean emailExists(String email)`
- `public boolean updatePassword(int userId, String hashedPassword)`
- `public boolean saveResetToken(String email, String token, Timestamp expiry)`
- `public boolean clearResetToken(int userId)`
- `private User mapRowToUser(ResultSet rs)`

## Class: ClientDao.java (Package: com.buildtrack.dao.client)

- `public User findById(int id)`
- `public boolean updateProfile(int id, String fullName, String phone)`
- `public List<Project> findProjectsByClientId(int clientId)`
- `public int countProjects(int clientId)`
- `private User mapRowToUser(ResultSet rs)`
- `private Project mapRowToProject(ResultSet rs, boolean withClient)`

## Class: ProjectTrackingDao.java (Package: com.buildtrack.dao.client)

- `public Project findProjectForClient(int projectId, int clientId)`
- `public List<MaterialUsage> findMaterialUsageForProject(int projectId)`
- `public List<Map<String, Object>> findExpensesForProject(int projectId)`
- `public int getTimeProgressPercent(int projectId)`

## Class: WorkerDao.java (Package: com.buildtrack.dao.worker)


## Class: WorkLogDao.java (Package: com.buildtrack.dao.worker)


## Class: AuthFilter.java (Package: com.buildtrack.filter)

- `public void init(FilterConfig filterConfig)`
- `public void destroy()`

## Class: RoleFilter.java (Package: com.buildtrack.filter)

- `public void init(FilterConfig filterConfig)`
- `public void destroy()`
- `private Role getRequiredRole(String path)`

## Class: SessionListener.java (Package: com.buildtrack.listener)

- `public void sessionCreated(HttpSessionEvent se)`
- `public void sessionDestroyed(HttpSessionEvent se)`
- `public int getActiveSessionCount()`

## Class: Attendance.java (Package: com.buildtrack.model)

- `public int getId()`
- `public void setId(int id)`
- `public int getWorkerId()`
- `public void setWorkerId(int workerId)`
- `public int getProjectId()`
- `public void setProjectId(int projectId)`
- `public Date getAttendanceDate()`
- `public void setAttendanceDate(Date attendanceDate)`
- `public String getStatus()`
- `public void setStatus(String status)`
- `public String getNotes()`
- `public void setNotes(String notes)`
- `public Integer getMarkedBy()`
- `public void setMarkedBy(Integer markedBy)`
- `public Timestamp getCreatedAt()`
- `public void setCreatedAt(Timestamp createdAt)`
- `public String getWorkerName()`
- `public void setWorkerName(String workerName)`
- `public String getProjectName()`
- `public void setProjectName(String projectName)`
- `public String getMarkedByName()`
- `public void setMarkedByName(String markedByName)`
- `public String getStatusDisplayName()`
- `public String getStatusBadgeClass()`
- `public double getEffectiveDays()`

## Class: Document.java (Package: com.buildtrack.model)

- `public int getId()`
- `public void setId(int id)`
- `public int getProjectId()`
- `public void setProjectId(int projectId)`
- `public int getClientId()`
- `public void setClientId(int clientId)`
- `public String getFileName()`
- `public void setFileName(String fileName)`
- `public String getFilePath()`
- `public void setFilePath(String filePath)`
- `public Timestamp getUploadedAt()`
- `public void setUploadedAt(Timestamp uploadedAt)`
- `public String getClientName()`
- `public void setClientName(String clientName)`
- `public String getProjectTitle()`
- `public void setProjectTitle(String projectTitle)`

## Class: Expense.java (Package: com.buildtrack.model)

- `public int getId()`
- `public void setId(int id)`
- `public int getProjectId()`
- `public void setProjectId(int projectId)`
- `public String getCategory()`
- `public void setCategory(String category)`
- `public String getDescription()`
- `public void setDescription(String description)`
- `public BigDecimal getAmount()`
- `public void setAmount(BigDecimal amount)`
- `public Date getExpenseDate()`
- `public void setExpenseDate(Date expenseDate)`
- `public int getRecordedBy()`
- `public void setRecordedBy(int recordedBy)`
- `public Timestamp getCreatedAt()`
- `public void setCreatedAt(Timestamp createdAt)`
- `public Timestamp getUpdatedAt()`
- `public void setUpdatedAt(Timestamp updatedAt)`
- `public String getProjectName()`
- `public void setProjectName(String projectName)`
- `public String getRecordedByName()`
- `public void setRecordedByName(String recordedByName)`
- `public String getCategoryBadgeClass()`

## Class: Inquiry.java (Package: com.buildtrack.model)

- `public int getId()`
- `public void setId(int id)`
- `public int getClientId()`
- `public void setClientId(int clientId)`
- `public int getProjectId()`
- `public void setProjectId(int projectId)`
- `public String getSubject()`
- `public void setSubject(String subject)`
- `public String getMessage()`
- `public void setMessage(String message)`
- `public String getAdminReply()`
- `public void setAdminReply(String adminReply)`
- `public String getStatus()`
- `public void setStatus(String status)`
- `public Timestamp getCreatedAt()`
- `public void setCreatedAt(Timestamp createdAt)`
- `public Timestamp getUpdatedAt()`
- `public void setUpdatedAt(Timestamp updatedAt)`
- `public String getClientName()`
- `public void setClientName(String clientName)`
- `public String getProjectTitle()`
- `public void setProjectTitle(String projectTitle)`

## Class: Material.java (Package: com.buildtrack.model)

- `public int getId()`
- `public void setId(int id)`
- `public String getName()`
- `public void setName(String name)`
- `public String getUnit()`
- `public void setUnit(String unit)`
- `public BigDecimal getUnitPrice()`
- `public void setUnitPrice(BigDecimal unitPrice)`
- `public BigDecimal getTotalStock()`
- `public void setTotalStock(BigDecimal totalStock)`
- `public BigDecimal getLowStockThreshold()`
- `public void setLowStockThreshold(BigDecimal lowStockThreshold)`
- `public String getDescription()`
- `public void setDescription(String description)`
- `public Timestamp getCreatedAt()`
- `public void setCreatedAt(Timestamp createdAt)`
- `public Timestamp getUpdatedAt()`
- `public void setUpdatedAt(Timestamp updatedAt)`
- `public boolean isLowStock()`
- `public boolean isOutOfStock()`

## Class: MaterialUsage.java (Package: com.buildtrack.model)

- `public int getId()`
- `public void setId(int id)`
- `public int getMaterialId()`
- `public void setMaterialId(int materialId)`
- `public int getProjectId()`
- `public void setProjectId(int projectId)`
- `public BigDecimal getQuantityUsed()`
- `public void setQuantityUsed(BigDecimal quantityUsed)`
- `public BigDecimal getUnitCost()`
- `public void setUnitCost(BigDecimal unitCost)`
- `public BigDecimal getTotalCost()`
- `public void setTotalCost(BigDecimal totalCost)`
- `public Date getUsageDate()`
- `public void setUsageDate(Date usageDate)`
- `public int getRecordedBy()`
- `public void setRecordedBy(int recordedBy)`
- `public String getNotes()`
- `public void setNotes(String notes)`
- `public Timestamp getCreatedAt()`
- `public void setCreatedAt(Timestamp createdAt)`
- `public String getMaterialName()`
- `public void setMaterialName(String materialName)`
- `public String getMaterialUnit()`
- `public void setMaterialUnit(String materialUnit)`
- `public String getProjectName()`
- `public void setProjectName(String projectName)`
- `public String getRecordedByName()`
- `public void setRecordedByName(String recordedByName)`

## Class: Payroll.java (Package: com.buildtrack.model)

- `public int getId()`
- `public void setId(int id)`
- `public int getWorkerId()`
- `public void setWorkerId(int workerId)`
- `public String getMonthYear()`
- `public void setMonthYear(String monthYear)`
- `public int getTotalDays()`
- `public void setTotalDays(int totalDays)`
- `public int getHalfDays()`
- `public void setHalfDays(int halfDays)`
- `public BigDecimal getDailyWage()`
- `public void setDailyWage(BigDecimal dailyWage)`
- `public BigDecimal getTotalSalary()`
- `public void setTotalSalary(BigDecimal totalSalary)`
- `public String getStatus()`
- `public void setStatus(String status)`
- `public int getGeneratedBy()`
- `public void setGeneratedBy(int generatedBy)`
- `public Timestamp getGeneratedAt()`
- `public void setGeneratedAt(Timestamp generatedAt)`
- `public Timestamp getPaidAt()`
- `public void setPaidAt(Timestamp paidAt)`
- `public String getWorkerName()`
- `public void setWorkerName(String workerName)`
- `public String getWorkerEmail()`
- `public void setWorkerEmail(String workerEmail)`
- `public BigDecimal calculateSalary()`
- `public String getStatusDisplayName()`
- `public String getStatusBadgeClass()`
- `public String getMonthYearDisplay()`

## Class: Payslip.java (Package: com.buildtrack.model)

- `public int getPayrollId()`
- `public void setPayrollId(int payrollId)`
- `public String getWorkerName()`
- `public void setWorkerName(String workerName)`
- `public String getWorkerEmail()`
- `public void setWorkerEmail(String workerEmail)`
- `public String getWorkerPhone()`
- `public void setWorkerPhone(String workerPhone)`
- `public String getMonthYearDisplay()`
- `public void setMonthYearDisplay(String monthYearDisplay)`
- `public String getMonthYear()`
- `public void setMonthYear(String monthYear)`
- `public int getTotalDays()`
- `public void setTotalDays(int totalDays)`
- `public int getHalfDays()`
- `public void setHalfDays(int halfDays)`
- `public double getEffectiveDays()`
- `public void setEffectiveDays(double effectiveDays)`
- `public BigDecimal getDailyWage()`
- `public void setDailyWage(BigDecimal dailyWage)`
- `public BigDecimal getTotalSalary()`
- `public void setTotalSalary(BigDecimal totalSalary)`
- `public String getStatus()`
- `public void setStatus(String status)`
- `public String getGeneratedByName()`
- `public void setGeneratedByName(String generatedByName)`
- `public String getGeneratedAt()`
- `public void setGeneratedAt(String generatedAt)`
- `public String getPaidAt()`
- `public void setPaidAt(String paidAt)`

## Class: Project.java (Package: com.buildtrack.model)

- `public int getId()`
- `public void setId(int id)`
- `public String getTitle()`
- `public void setTitle(String title)`
- `public String getStatus()`
- `public void setStatus(String status)`
- `public String getDescription()`
- `public void setDescription(String description)`
- `public Integer getClientId()`
- `public void setClientId(Integer clientId)`
- `public Date getStartDate()`
- `public void setStartDate(Date startDate)`
- `public Date getEndDate()`
- `public void setEndDate(Date endDate)`
- `public BigDecimal getTotalBudget()`
- `public void setTotalBudget(BigDecimal totalBudget)`
- `public Timestamp getCreatedAt()`
- `public void setCreatedAt(Timestamp createdAt)`
- `public Timestamp getUpdatedAt()`
- `public void setUpdatedAt(Timestamp updatedAt)`
- `public String getClientName()`
- `public void setClientName(String clientName)`
- `public int getAssignedWorkerCount()`
- `public void setAssignedWorkerCount(int assignedWorkerCount)`
- `public BigDecimal getActualCost()`
- `public void setActualCost(BigDecimal actualCost)`
- `public String getStatusDisplayName()`
- `public String getStatusBadgeClass()`
- `public BigDecimal getRemainingBudget()`
- `public double getBudgetUsagePercent()`

## Class: Role.java (Package: com.buildtrack.model)

- `public Role fromString(String value)`
- `public String toLower()`
- `public String getDashboardPath()`

## Class: User.java (Package: com.buildtrack.model)

- `public int getId()`
- `public void setId(int id)`
- `public String getFullName()`
- `public void setFullName(String fullName)`
- `public String getEmail()`
- `public void setEmail(String email)`
- `public String getPhone()`
- `public void setPhone(String phone)`
- `public String getPassword()`
- `public void setPassword(String password)`
- `public Role getRole()`
- `public void setRole(Role role)`
- `public String getStatus()`
- `public void setStatus(String status)`
- `public BigDecimal getDailyWage()`
- `public void setDailyWage(BigDecimal dailyWage)`
- `public String getResetToken()`
- `public void setResetToken(String resetToken)`
- `public Timestamp getResetTokenExpiry()`
- `public void setResetTokenExpiry(Timestamp resetTokenExpiry)`
- `public Timestamp getCreatedAt()`
- `public void setCreatedAt(Timestamp createdAt)`
- `public Timestamp getUpdatedAt()`
- `public void setUpdatedAt(Timestamp updatedAt)`
- `public boolean isApproved()`
- `public boolean isPending()`
- `public boolean isDeactivated()`
- `public boolean isResetTokenValid()`
- `public String getRoleDisplayName()`
- `public String toString()`

## Class: Worker.java (Package: com.buildtrack.model)


## Class: AttendanceService.java (Package: com.buildtrack.service.admin)

- `public List<Attendance> getAttendanceByDate(String dateStr)`
- `public List<Attendance> getAttendanceByProjectAndDate(int projectId, String dateStr)`
- `public List<Attendance> getWorkerHistory(int workerId, String monthYear)`
- `public boolean attendanceExists(int workerId, int projectId, String dateStr)`
- `public int[] getAttendanceCounts(int workerId, String monthYear)`
- `public List<Attendance> getProjectWorkerSummary(int projectId, String monthYear)`

## Class: DocumentService.java (Package: com.buildtrack.service.admin)

- `public List<Document> getAllDocuments()`

## Class: ExpenseService.java (Package: com.buildtrack.service.admin)

- `public List<String> deleteExpense(int id)`
- `public Expense getById(int id)`
- `public List<Expense> getAllExpenses()`
- `public List<Expense> getExpensesByProject(int projectId)`
- `public List<Expense> getRecentExpenses(int limit)`
- `public BigDecimal getTotalByProject(int projectId)`
- `public BigDecimal getGrandTotal()`
- `public List<Map<String, Object>> getCategoryBreakdown(int projectId)`
- `public List<Map<String, Object>> getProjectExpenseSummary()`
- `public BigDecimal getTotalByProjectAndMonth(int projectId, String monthYear)`
- `public int getCount()`
- `public String[] getValidCategories()`

## Class: InquiryService.java (Package: com.buildtrack.service.admin)

- `public List<Inquiry> getAllInquiries()`
- `public List<String> updateInquiry(int id, String reply, String status)`

## Class: MaterialService.java (Package: com.buildtrack.service.admin)

- `public List<Material> getAllMaterials()`
- `public List<Material> getLowStockMaterials()`
- `public Material getMaterialById(int id)`
- `public List<String> deleteMaterial(int id)`
- `public List<MaterialUsage> getUsageByProject(int projectId)`
- `public List<MaterialUsage> getUsageSummaryByProject(int projectId)`
- `public List<MaterialUsage> getRecentUsage(int limit)`
- `public BigDecimal getTotalCostByProject(int projectId)`
- `public BigDecimal getTotalStockValue()`
- `public BigDecimal getUsedCostThisMonth()`
- `public String getCurrentMonthLabel()`
- `public Map<String, Integer> getMaterialStats()`

## Class: PayrollService.java (Package: com.buildtrack.service.admin)

- `public List<Payroll> getPayrollByMonth(String monthYear)`
- `public Payroll getPayrollById(int id)`
- `public Payslip getPayslipById(int id)`
- `public Payroll getWorkerPayroll(int workerId, String monthYear)`
- `public boolean payrollExists(int workerId, String monthYear)`
- `public BigDecimal getTotalSalaryByMonth(String monthYear, String status)`
- `public List<String> generateMonthlyPayroll(String monthYear, int generatedBy)`
- `public List<String> generateSinglePayroll(int workerId, String monthYear, int generatedBy)`
- `public List<String> markAsPaid(int payrollId)`

## Class: ProjectService.java (Package: com.buildtrack.service.admin)

- `public List<Project> getAllProjects()`
- `public List<Project> getProjectsByStatus(String status)`
- `public Project getProjectById(int id)`
- `public List<String> deleteProject(int id)`
- `public List<String> assignWorker(int projectId, int workerId, String assignedRole)`
- `public List<String> removeWorker(int projectId, int workerId)`
- `public Map<String, Integer> getStatusCounts()`

## Class: ReportService.java (Package: com.buildtrack.service.admin)

- `public List<Map<String, Object>> getBudgetVsActualAll()`
- `public Map<String, Object> getBudgetVsActual(int projectId)`
- `public List<Map<String, Object>> getMaterialExpenseByCategory(int projectId)`
- `public List<Map<String, Object>> getManualExpenseByCategory(int projectId)`
- `public List<Map<String, Object>> getCombinedExpenseBreakdown(int projectId)`
- `public List<MaterialUsage> getMaterialUsageSummary(int projectId)`
- `public List<Attendance> getProjectWorkerSummary(int projectId, String monthYear)`
- `public List<Map<String, Object>> getPayrollSummaryByMonth()`
- `public BigDecimal getTotalMaterialCost()`
- `public BigDecimal getTotalPayrollCost()`
- `public BigDecimal getTotalManualExpenseCost()`
- `public BigDecimal getGrandTotalExpenses()`
- `public BigDecimal getProjectTotalCost(int projectId)`

## Class: UserService.java (Package: com.buildtrack.service.admin)

- `public List<User> getWorkers()`
- `public List<User> getClients()`
- `public List<User> getPendingUsers()`
- `public List<User> getAllNonAdmin()`
- `public List<User> getWorkersByStatus(String status)`
- `public List<User> searchWorkers(String query)`
- `public User getUserById(int id)`
- `public boolean approveUser(int id)`
- `public boolean deactivateUser(int id)`
- `public boolean activateUser(int id)`
- `public boolean updateStatus(int id, String status)`
- `public List<String> setDailyWage(int userId, String wageStr)`
- `public List<String> updateProfile(int id, String fullName, String phone)`
- `public Map<String, Integer> getUserStats()`

## Class: AuthService.java (Package: com.buildtrack.service.auth)

- `public LoginResult login(String email, String password)`
- `public User getUser()`
- `public void setUser(User user)`
- `public List<String> getErrors()`
- `public boolean hasErrors()`
- `public void setErrors(List<String> errors)`
- `public void addError(String error)`

## Class: PasswordService.java (Package: com.buildtrack.service.auth)

- `public boolean initiatePasswordReset(String email, String baseUrl)`
- `public User validateResetToken(String token)`

## Class: ClientService.java (Package: com.buildtrack.service.client)

- `public User getClientById(int id)`
- `public List<String> updateProfile(int id, String fullName, String phone)`
- `public List<Project> getProjectsByClientId(int clientId)`
- `public int countProjects(int clientId)`
- `public BigDecimal getTotalBudgetForClient(int clientId)`
- `public Map<String, Object> getDashboardSummary(int clientId)`

## Class: ProjectTrackingService.java (Package: com.buildtrack.service.client)

- `public Project getProjectOverviewForClient(int projectId, int clientId)`
- `public List<MaterialUsage> getMaterialUsageForProject(int projectId)`
- `public List<Map<String, Object>> getExpensesForProject(int projectId)`
- `public int getTimeProgressPercent(int projectId)`

## Class: WorkerService.java (Package: com.buildtrack.service.worker)


## Class: WorkLogService.java (Package: com.buildtrack.service.worker)


## Class: DBUtil.java (Package: com.buildtrack.util)

- `private void loadConfig()`
- `public Connection getConnection()`
- `public void close(Connection conn, PreparedStatement pstmt, ResultSet rs)`
- `public void close(Connection conn, PreparedStatement pstmt)`

## Class: EmailUtil.java (Package: com.buildtrack.util)

- `private synchronized void init()`
- `public boolean sendPasswordResetEmail(String toEmail, String resetLink)`
- `protected PasswordAuthentication getPasswordAuthentication()`
- `private String buildResetEmailHtml(String resetLink)`

## Class: PasswordUtil.java (Package: com.buildtrack.util)

- `public String hashedPassword(String plainPassword)`
- `public boolean verifyPassword(String plainPassword, String hashedPassword)`
- `public String generateResetToken()`

## Class: ValidationUtil.java (Package: com.buildtrack.util)

- `public List<String> validateLogin(String email, String password)`
- `public List<String> validateForgotPassword(String email)`
- `public boolean isEmpty(String value)`
- `public String sanitize(String value)`

