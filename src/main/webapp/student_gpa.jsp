<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Student</title>
</head>
<body>
    <form method="post" action="student_gpa_report.jsp">
        <label for="SSN">Select Student:</label>
        <select name="SSN" id="SSN">
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
                    String query = "SELECT DISTINCT S.SSN, S.FIRSTNAME, S.LASTNAME " +
                                   "FROM STUDENT S, STUDENT_ENROLLMENT SE " +
                                   "WHERE S.STUDENTID = SE.STUDENTID";
                    resultSet = statement.executeQuery(query);

                    // Populate the <select> control with student data
                    while (resultSet.next()) {
                        String ssn = resultSet.getString("SSN");
                        String firstName = resultSet.getString("FIRSTNAME");
                        String lastName = resultSet.getString("LASTNAME");
                        %>
                        <option value="<%= ssn %>"><%= ssn %> - <%= firstName %> <%= lastName %></option>
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
        <input type="submit" value="Get Classes">
    </form>
</body>
</html>
