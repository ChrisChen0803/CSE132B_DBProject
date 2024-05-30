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
            String classQuery = "WITH enrolled_meetings AS ( " +
                                "SELECT rm.courseid, rm.sectionid, rm.day_of_week, rm.start_time, rm.end_time " +
                                "FROM courseenrollment ce " +
                                "JOIN regular_meeting rm ON ce.sectionid = rm.sectionid AND ce.courseid = rm.courseid AND rm.quarter = 'SPRING' AND rm.year = 2018 " +
                                "WHERE ce.studentid = (SELECT studentid FROM ENROLLEDSTUDENTS WHERE SSN = '" + SSN + "')), " +

                                "potential_course AS ( " +
                                "SELECT rm.courseid, rm.sectionid, rm.day_of_week, rm.start_time, rm.end_time " +
                                "From regular_meeting rm " +
                                "WHERE rm.quarter = 'SPRING' AND rm.year = 2018 AND NOT EXISTS (SELECT * FROM enrolled_meetings em WHERE em.courseid = rm.courseid)), " +

                                "conflicting_sections AS ( " +
                                "SELECT pc.courseid, pc.sectionid, em.courseid AS CID " +
                                "FROM potential_course pc " +
                                "JOIN enrolled_meetings em ON pc.day_of_week SIMILAR TO '%' || em.day_of_week || '%' AND ( (pc.start_time < em.end_time AND pc.end_time > em.start_time) OR (em.start_time < pc.end_time AND em.end_time > pc.start_time))), " +

                                "non_conflicting_sections AS (SELECT pc.COURSEID FROM potential_course pc " +
                                "WHERE NOT EXISTS (SELECT * FROM conflicting_sections cs " +
                                "WHERE pc.COURSEID = cs.COURSEID AND pc.SECTIONID = cs.SECTIONID)), " +
                                "conflicting_class AS (SELECT DISTINCT pc.courseid FROM potential_course pc WHERE NOT EXISTS (SELECT * FROM non_conflicting_sections nc WHERE nc.courseid = pc.courseid)) " +
                                "select cc.courseid, c1.coursetitle, cs.CID, c2.coursetitle AS CTITLE FROM conflicting_class cc, conflicting_sections cs, class c1, class c2 WHERE cc.courseid = cs.courseid AND c1.courseid = cc.courseid AND c2.courseid = cs.CID GROUP BY cc.courseid, c1.coursetitle, cs.CID, c2.coursetitle ";

            resultSet = statement.executeQuery(classQuery);
            %>
            <h2>Conflict Classes in the Current Quarter</h2>
            <table border="1">
                <th>Class Name</th><th>Title</th><th>Conflict Classes</th><th>Title</th></tr>
            <%
            String pre_courseId = "";
            while (resultSet.next()) {
                String courseId = resultSet.getString("COURSEID");
                String courseTitle = resultSet.getString("coursetitle");
                String conflictCourseId = resultSet.getString("CID");
                String conflictTitle = resultSet.getString("CTITLE");
                if (!courseId.equals(pre_courseId)) {
                    %>
                    <tr>
                        <td><%= courseId %></td>
                        <td><%= courseTitle %></td>
                        <td><%= conflictCourseId %></td>
                        <td><%= conflictTitle %></td>
                    </tr>
                    <%
                }
                else {
                    %>
                    <tr>
                        <td></td>
                        <td></td>
                        <td><%= conflictCourseId %></td>
                        <td><%= conflictTitle %></td>
                    </tr>
                    <%
                }
                pre_courseId = courseId;
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
