<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Student</title>
</head>
<body>
    <form method="post" action="available_timeslots_reports.jsp">
        <label for="COURSEID">Select Student:</label>
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
                    String query = "SELECT COURSEID FROM SECTION WHERE QUARTER='SPRING' AND YEAR=2018 GROUP BY COURSEID";
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
                <label for="SECTIONID">Select SECTIONID:</label>
                                        <select name="SECTIONID" id="SECTIONID">
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
                                                    String query = "SELECT SECTIONID FROM SECTION WHERE QUARTER='SPRING' AND YEAR=2018 GROUP BY SECTIONID";
                                                    resultSet = statement.executeQuery(query);

                                                    // Populate the <select> control with student data
                                                    while (resultSet.next()) {
                                                        String SECTIONID = resultSet.getString("SECTIONID");
                                                        %>
                                                        <option value="<%= SECTIONID %>"><%= SECTIONID %></option>
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
                                        <label for="start_date">Choose a start_date:</label>
                                            <input type="date" id="start_date" name="start_date" required>
                                        <label for="end_date">Choose a end_date:</label>
                                            <input type="date" id="end_date" name="end_date" required>
        <input type="submit" value="Get Timeslots">
    </form>
</body>
</html>
