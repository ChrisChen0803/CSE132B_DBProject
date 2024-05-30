<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Student</title>
</head>
<body>
    <form method="post" action="grad_degree_report.jsp">
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
                    String query = "SELECT SSN, FIRSTNAME, MIDDLENAME, LASTNAME FROM ENROLLEDSTUDENTS WHERE DEGREENAME = 'MS'";
                    resultSet = statement.executeQuery(query);

                    // Populate the <select> control with student data
                    %>
                    <label for="SSN">Select Student:</label>
                    <select name="SSN" id="SSN">
                    <%
                    while (resultSet.next()) {
                        String ssn = resultSet.getString("SSN");
                        String firstName = resultSet.getString("FIRSTNAME");
                        String middleName = resultSet.getString("MIDDLENAME");
                        String lastName = resultSet.getString("LASTNAME");
                        %>
                        <option value="<%= ssn %>"><%= ssn %> - <%= firstName %> <%= middleName %> <%= lastName %></option>
                        <%
                    }
                    %>
                    </select>
                    <%

                    query = "SELECT DISTINCT DEGREE_NAME, MAJOR FROM DEGREE_INFO WHERE DEGREE_NAME = 'MS'";
                    resultSet = statement.executeQuery(query);

                    // Populate the <select> control with degree data
                    %>
                    <br>
                    <label for="degree">Select Degree:</label>
                    <select name="degree" id="degree">
                    <%
                    while (resultSet.next()) {
                        String degree_name = resultSet.getString("DEGREE_NAME");
                        String major = resultSet.getString("MAJOR");
                        %>
                        <option value="<%= degree_name %>|<%= major %>"><%= degree_name %> <%= major %></option>
                        <%
                    }
                    %>
                    </select>
                    <%

                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (resultSet != null) resultSet.close(); } catch (Exception e) { }
                    try { if (statement != null) statement.close(); } catch (Exception e) { }
                    try { if (connection != null) connection.close(); } catch (Exception e) { }
                }
            %>
        </select>
        <br>
        <input type="submit" value="Get Degree Requirement">
    </form>
</body>
</html>
