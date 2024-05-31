<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Student</title>
</head>
<body>
    <form method="post" action="decision_support_report.jsp">
        <label for="COURSEID">Select COURSEID:</label>
        <select name="COURSEID" id="COURSEID">
            <%
                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                try {
                    // Load the PostgreSQL JDBC driver
                    Class.forName("org.postgresql.Driver");

                    // Establish connection to the database
                     String url = "jdbc:postgresql://localhost:5432/CSE132B";
                     String username = "postgres";
                     String password = "Cyj020803!";
                    connection = DriverManager.getConnection(url, username, password);

                    // Create a statement
                    statement = connection.createStatement();

                    // Query to get students enrolled in the current quarter
                    String query = "SELECT COURSEID FROM PASTCLASS GROUP BY COURSEID";
                    resultSet = statement.executeQuery(query);

                    // Populate the <select> control with student data
                    while (resultSet.next()) {
                        String COURSEID = resultSet.getString("COURSEID");
                        %>
                        <option value="<%= COURSEID %>"><%= COURSEID %></option>
                        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (resultSet != null) resultSet.close(); } catch (Exception e) { }
                    try { if (statement != null) statement.close(); } catch (Exception e) { }
                    try { if (connection != null) connection.close(); } catch (Exception e) { }
                }
            %>
        </select>
        <label for="PROFESSOR">Select PROFESSOR:</label>
                <select name="PROFESSOR" id="PROFESSOR">
                    <%

                        try {
                            // Load the PostgreSQL JDBC driver
                            Class.forName("org.postgresql.Driver");

                            // Establish connection to the database
                             String url = "jdbc:postgresql://localhost:5432/CSE132B";
                             String username = "postgres";
                             String password = "Cyj020803!";
                            connection = DriverManager.getConnection(url, username, password);

                            // Create a statement
                            statement = connection.createStatement();

                            // Query to get students enrolled in the current quarter
                            String query = "SELECT FACULTYNAME FROM PASTCLASS GROUP BY FACULTYNAME";
                            resultSet = statement.executeQuery(query);

                            // Populate the <select> control with student data
                            while (resultSet.next()) {
                                String FACULTYNAME = resultSet.getString("FACULTYNAME");
                                %>
                                <option value="<%= FACULTYNAME %>"><%= FACULTYNAME %></option>
                                <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try { if (resultSet != null) resultSet.close(); } catch (Exception e) { }
                            try { if (statement != null) statement.close(); } catch (Exception e) { }
                            try { if (connection != null) connection.close(); } catch (Exception e) { }
                        }
                    %>
                </select>
        <label for="QUARTER">Select QUARTER:</label>
                        <select name="QUARTER" id="QUARTER">
                            <%

                                try {
                                    // Load the PostgreSQL JDBC driver
                                    Class.forName("org.postgresql.Driver");

                                    // Establish connection to the database
                                     String url = "jdbc:postgresql://localhost:5432/CSE132B";
                                     String username = "postgres";
                                     String password = "Cyj020803!";
                                    connection = DriverManager.getConnection(url, username, password);

                                    // Create a statement
                                    statement = connection.createStatement();

                                    // Query to get students enrolled in the current quarter
                                    String query = "SELECT QUARTER FROM PASTCLASS GROUP BY QUARTER";
                                    resultSet = statement.executeQuery(query);

                                    // Populate the <select> control with student data
                                    while (resultSet.next()) {
                                        String QUARTER = resultSet.getString("QUARTER");
                                        %>
                                        <option value="<%= QUARTER %>"><%= QUARTER %></option>
                                        <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    try { if (resultSet != null) resultSet.close(); } catch (Exception e) { }
                                    try { if (statement != null) statement.close(); } catch (Exception e) { }
                                    try { if (connection != null) connection.close(); } catch (Exception e) { }
                                }
                            %>
                        </select>
    <label for="YEAR">Select YEAR:</label>
                            <select name="YEAR" id="YEAR">
                                <%

                                    try {
                                        // Load the PostgreSQL JDBC driver
                                        Class.forName("org.postgresql.Driver");

                                        // Establish connection to the database
                                         String url = "jdbc:postgresql://localhost:5432/CSE132B";
                                         String username = "postgres";
                                         String password = "Cyj020803!";
                                        connection = DriverManager.getConnection(url, username, password);

                                        // Create a statement
                                        statement = connection.createStatement();

                                        // Query to get students enrolled in the current quarter
                                        String query = "SELECT YEAR FROM PASTCLASS GROUP BY YEAR";
                                        resultSet = statement.executeQuery(query);

                                        // Populate the <select> control with student data
                                        while (resultSet.next()) {
                                            String YEAR = resultSet.getString("YEAR");
                                            %>
                                            <option value="<%= YEAR %>"><%= YEAR %></option>
                                            <%
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        try { if (resultSet != null) resultSet.close(); } catch (Exception e) { }
                                        try { if (statement != null) statement.close(); } catch (Exception e) { }
                                        try { if (connection != null) connection.close(); } catch (Exception e) { }
                                    }
                                %>
                            </select>
        <input type="submit" value="Get Summary">
    </form>
    <form method="post" action="decision_support_report1.jsp">
            <label for="COURSEID">Select COURSEID:</label>
            <select name="COURSEID" id="COURSEID">
                <%

                    try {
                        // Load the PostgreSQL JDBC driver
                        Class.forName("org.postgresql.Driver");

                        // Establish connection to the database
                         String url = "jdbc:postgresql://localhost:5432/CSE132B";
                         String username = "postgres";
                         String password = "Cyj020803!";
                        connection = DriverManager.getConnection(url, username, password);

                        // Create a statement
                        statement = connection.createStatement();

                        // Query to get students enrolled in the current quarter
                        String query = "SELECT COURSEID FROM PASTCLASS GROUP BY COURSEID";
                        resultSet = statement.executeQuery(query);

                        // Populate the <select> control with student data
                        while (resultSet.next()) {
                            String COURSEID = resultSet.getString("COURSEID");
                            %>
                            <option value="<%= COURSEID %>"><%= COURSEID %></option>
                            <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try { if (resultSet != null) resultSet.close(); } catch (Exception e) { }
                        try { if (statement != null) statement.close(); } catch (Exception e) { }
                        try { if (connection != null) connection.close(); } catch (Exception e) { }
                    }
                %>
            </select>
            <label for="PROFESSOR">Select PROFESSOR:</label>
                    <select name="PROFESSOR" id="PROFESSOR">
                        <%

                            try {
                                // Load the PostgreSQL JDBC driver
                                Class.forName("org.postgresql.Driver");

                                // Establish connection to the database
                                 String url = "jdbc:postgresql://localhost:5432/CSE132B";
                                 String username = "postgres";
                                 String password = "Cyj020803!";
                                connection = DriverManager.getConnection(url, username, password);

                                // Create a statement
                                statement = connection.createStatement();

                                // Query to get students enrolled in the current quarter
                                String query = "SELECT FACULTYNAME FROM PASTCLASS GROUP BY FACULTYNAME";
                                resultSet = statement.executeQuery(query);

                                // Populate the <select> control with student data
                                while (resultSet.next()) {
                                    String FACULTYNAME = resultSet.getString("FACULTYNAME");
                                    %>
                                    <option value="<%= FACULTYNAME %>"><%= FACULTYNAME %></option>
                                    <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                try { if (resultSet != null) resultSet.close(); } catch (Exception e) { }
                                try { if (statement != null) statement.close(); } catch (Exception e) { }
                                try { if (connection != null) connection.close(); } catch (Exception e) { }
                            }
                        %>
                    </select>
            <input type="submit" value="Get Summary">
        </form>
        <form method="post" action="decision_support_report2.jsp">
                    <label for="COURSEID">Select COURSEID:</label>
                    <select name="COURSEID" id="COURSEID">
                        <%

                            try {
                                // Load the PostgreSQL JDBC driver
                                Class.forName("org.postgresql.Driver");

                                // Establish connection to the database
                                 String url = "jdbc:postgresql://localhost:5432/CSE132B";
                                 String username = "postgres";
                                 String password = "Cyj020803!";
                                connection = DriverManager.getConnection(url, username, password);

                                // Create a statement
                                statement = connection.createStatement();

                                // Query to get students enrolled in the current quarter
                                String query = "SELECT COURSEID FROM PASTCLASS GROUP BY COURSEID";
                                resultSet = statement.executeQuery(query);

                                // Populate the <select> control with student data
                                while (resultSet.next()) {
                                    String COURSEID = resultSet.getString("COURSEID");
                                    %>
                                    <option value="<%= COURSEID %>"><%= COURSEID %></option>
                                    <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                try { if (resultSet != null) resultSet.close(); } catch (Exception e) { }
                                try { if (statement != null) statement.close(); } catch (Exception e) { }
                                try { if (connection != null) connection.close(); } catch (Exception e) { }
                            }
                        %>
                    </select>

                    <input type="submit" value="Get Summary">
                </form>
                <form method="post" action="decision_support_report3.jsp">
                            <label for="COURSEID">Select COURSEID:</label>
                            <select name="COURSEID" id="COURSEID">
                                <%

                                    try {
                                        // Load the PostgreSQL JDBC driver
                                        Class.forName("org.postgresql.Driver");

                                        // Establish connection to the database
                                         String url = "jdbc:postgresql://localhost:5432/CSE132B";
                                         String username = "postgres";
                                         String password = "Cyj020803!";
                                        connection = DriverManager.getConnection(url, username, password);

                                        // Create a statement
                                        statement = connection.createStatement();

                                        // Query to get students enrolled in the current quarter
                                        String query = "SELECT COURSEID FROM PASTCLASS GROUP BY COURSEID";
                                        resultSet = statement.executeQuery(query);

                                        // Populate the <select> control with student data
                                        while (resultSet.next()) {
                                            String COURSEID = resultSet.getString("COURSEID");
                                            %>
                                            <option value="<%= COURSEID %>"><%= COURSEID %></option>
                                            <%
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        try { if (resultSet != null) resultSet.close(); } catch (Exception e) { }
                                        try { if (statement != null) statement.close(); } catch (Exception e) { }
                                        try { if (connection != null) connection.close(); } catch (Exception e) { }
                                    }
                                %>
                            </select>
                            <label for="PROFESSOR">Select PROFESSOR:</label>
                                    <select name="PROFESSOR" id="PROFESSOR">
                                        <%

                                            try {
                                                // Load the PostgreSQL JDBC driver
                                                Class.forName("org.postgresql.Driver");

                                                // Establish connection to the database
                                                 String url = "jdbc:postgresql://localhost:5432/CSE132B";
                                                 String username = "postgres";
                                                 String password = "Cyj020803!";
                                                connection = DriverManager.getConnection(url, username, password);

                                                // Create a statement
                                                statement = connection.createStatement();

                                                // Query to get students enrolled in the current quarter
                                                String query = "SELECT FACULTYNAME FROM PASTCLASS GROUP BY FACULTYNAME";
                                                resultSet = statement.executeQuery(query);

                                                // Populate the <select> control with student data
                                                while (resultSet.next()) {
                                                    String FACULTYNAME = resultSet.getString("FACULTYNAME");
                                                    %>
                                                    <option value="<%= FACULTYNAME %>"><%= FACULTYNAME %></option>
                                                    <%
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            } finally {
                                                try { if (resultSet != null) resultSet.close(); } catch (Exception e) { }
                                                try { if (statement != null) statement.close(); } catch (Exception e) { }
                                                try { if (connection != null) connection.close(); } catch (Exception e) { }
                                            }
                                        %>
                                    </select>
                            <input type="submit" value="Get Average GPA">
                        </form>
</body>
</html>
