<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Classes Report</title>
</head>
<body>
    <%
        String courseId = request.getParameter("courseId");
        String quarter = request.getParameter("quarter");
        String year = request.getParameter("year");

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
            String studentQuery = "SELECT DISTINCT S.*, SE.UNIT, SE.GRADEOPTION " +
                                "FROM STUDENT S, STUDENT_ENROLLMENT SE " +
                                "WHERE SE.STUDENTID = S.STUDENTID AND SE.COURSEID = '" + courseId
                                + "' AND SE.QUARTER = '" + quarter + "' AND SE.YEAR = " + year;

            resultSet = statement.executeQuery(studentQuery);
            %>
            <h2>Students taking the class <%= courseId %> in <%= quarter %> <%= year %></h2>
            <table border="1">
                <th>Student ID</th><th>SSN</th><th>First Name</th><th>Middle Name</th><th>Last Name</th><th>Enrolled</th><th>Citizenship</th><th>Degree</th><th>Major</th><th>Unit</th><th>Grade option</th></tr>
            <%
             while (resultSet.next()) {
                String studentid = resultSet.getString("studentid");
                String ssn = resultSet.getString("SSN");
                String firstName = resultSet.getString("FIRSTNAME");
                String middleName = resultSet.getString("MIDDLENAME");
                String lastName = resultSet.getString("LASTNAME");
                String enrolled = resultSet.getString("ENROLLED");
                String citizenship = resultSet.getString("CITIZENSHIP");
                String degreeName = resultSet.getString("DEGREENAME");
                String major = resultSet.getString("Major");
                String unit = resultSet.getString("UNIT");
                String grade_option = resultSet.getString("GRADEOPTION");
                %>

                <tr>
                    <td><%= studentid %></td>
                    <td><%= ssn %></td>
                    <td><%= firstName %></td>
                    <td><%= middleName %></td>
                    <td><%= lastName %></td>
                    <td><%= enrolled %></td>
                    <td><%= citizenship %></td>
                    <td><%= degreeName %></td>
                    <td><%= major %></td>
                    <td><%= unit %></td>
                    <td><%
                        if ("1".equals(grade_option)) {
                            out.print("Letter");
                        } else if ("2".equals(grade_option)) {
                            out.print("P/NP");
                        } else if ("3".equals(grade_option)) {
                            out.print("S/U");
                        } %></td>
                </tr>
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
    </table>
</body>
</html>
