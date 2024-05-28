<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Classes Report</title>
</head>
<body>
    <%
        String SSN = request.getParameter("SSN");

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
            String studentQuery = "SELECT SSN, FIRSTNAME, MIDDLENAME, LASTNAME FROM ENROLLEDSTUDENTS WHERE SSN = '" + SSN + "'";
            resultSet = statement.executeQuery(studentQuery);
            if (resultSet.next()) {
                String ssn = resultSet.getString("SSN");
                String firstName = resultSet.getString("FIRSTNAME");
                String middleName = resultSet.getString("MIDDLENAME");
                String lastName = resultSet.getString("LASTNAME");
                %>
                <h2>Student Information</h2>
                SSN: <%= ssn %><br>
                First Name: <%= firstName %><br>
                Middle Name: <%= middleName %><br>
                Last Name: <%= lastName %><br>
                <%
            }

            // Query to get classes taken by the student in the current quarter CE.Unit, CE.sectionid
            String classQuery = "SELECT SE.* FROM STUDENT_ENROLLMENT SE " +
                                "WHERE SE.studentid = (SELECT studentid FROM ENROLLEDSTUDENTS WHERE SSN = '" + SSN + "')" +
                                "AND SE.quarter = 'SPRING' AND SE.year = 2018 ";
;
            resultSet = statement.executeQuery(classQuery);
            %>
            <h2>Classes Taken in the Current Quarter</h2>
            <table border="1">
                <th>Class Name</th><th>Quarter</th><th>Year</th><th>Units</th><th>Section</th></tr>
            <%
            while (resultSet.next()) {
                String courseId = resultSet.getString("COURSEID");
                String quarter = resultSet.getString("QUARTER");
                int year = resultSet.getInt("YEAR");
                int unit = resultSet.getInt("UNIT");
                String sectionId = resultSet.getString("SECTIONID");
                %>
                <tr>
                    <td><%= courseId %></td>
                    <td><%= quarter %></td>
                    <td><%= year %></td>
                    <td><%= unit %></td>
                    <td><%= sectionId %></td>
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
