<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Classes Report</title>
</head>
<body>
    <%
        String courseid = request.getParameter("COURSEID");
        String year = request.getParameter("YEAR");

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
            String query = "SELECT " +
                "COUNT(CASE WHEN pc.grade IN ('A', 'A-', 'A+') THEN 1 END) AS A, " +
                "COUNT(CASE WHEN pc.grade IN ('B', 'B-', 'B+') THEN 1 END) AS B, " +
                "COUNT(CASE WHEN pc.grade IN ('C', 'C-', 'C+') THEN 1 END) AS C, " +
                "COUNT(CASE WHEN pc.grade = 'D' THEN 1 END) AS D, " +
                "COUNT(CASE WHEN pc.grade NOT IN ('A', 'A-', 'A+', 'B', 'B-', 'B+', 'C', 'C-', 'C+', 'D','IN') THEN 1 END) AS other " +
                "FROM PASTCLASS pc WHERE pc.courseid = '" + courseid + "';";
            resultSet = statement.executeQuery(query);
            if (resultSet.next()) {
                        int countA = resultSet.getInt("A");
                        int countB = resultSet.getInt("B");
                        int countC = resultSet.getInt("C");
                        int countD = resultSet.getInt("D");
                        int countOther = resultSet.getInt("other");

                        // Display the results
            %>
                        <table border="1">
                            <tr>
                                <th>Grade</th>
                                <th>Count</th>
                            </tr>
                            <tr>
                                <td>A, A-, A+</td>
                                <td><%= countA %></td>
                            </tr>
                            <tr>
                                <td>B, B-, B+</td>
                                <td><%= countB %></td>
                            </tr>
                            <tr>
                                <td>C, C-, C+</td>
                                <td><%= countC %></td>
                            </tr>
                            <tr>
                                <td>D</td>
                                <td><%= countD %></td>
                            </tr>
                            <tr>
                                <td>Other</td>
                                <td><%= countOther %></td>
                            </tr>
                        </table>
            <%
                    }
                } catch (SQLException e) {
                    out.println("SQL Exception: " + e.getMessage());
                } finally {
                    if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
    </table>
</body>
</html>
