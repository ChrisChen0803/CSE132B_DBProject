<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <title>CPQG</title>
</head>
<body>
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

            // Query to get student information
            String studentQuery = "SELECT * FROM CPQG ORDER BY COURSEID";
            resultSet = statement.executeQuery(studentQuery);
    %>
    <table border="1">
        <thead>
            <tr>
                <th>Course ID</th>
                <th>Faculty Name</th>
                <th>Grade</th>
                <th>Count</th>
            </tr>
        </thead>
        <tbody>
            <%
            while (resultSet.next()) {
                String courseid = resultSet.getString("courseid");
                String facultyname = resultSet.getString("facultyname");
                String grade = resultSet.getString("grade");
                int count = resultSet.getInt("count");
            %>
            <tr>
                <td><%= courseid %></td>
                <td><%= facultyname %></td>
                <td><%= grade %></td>
                <td><%= count %></td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
