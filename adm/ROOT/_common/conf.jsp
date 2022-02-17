<%!
	// file upload path, from /
//	private static final String UPLOAD_DIRECTORY = "/usr/local/server/apache-tomcat-9.0.0.M4/webapps/ROOT/_userfiles";
	private static final String UPLOAD_DIRECTORY = "D:\\idea-korean\\web\\_userfiles";
	private static final String UPLOAD_URL = "/_userfiles";

	// upload settings
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB

%>