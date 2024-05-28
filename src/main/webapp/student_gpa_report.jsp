<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Grade Report</title>
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
            String studentQuery = "SELECT SSN, FIRSTNAME, MIDDLENAME, LASTNAME FROM STUDENT WHERE SSN = '" + SSN + "'";
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
                                "WHERE SE.studentid = (SELECT studentid FROM STUDENT WHERE SSN = '" +
                                SSN + "') AND (quarter, year) IN (SELECT quarter, year " +
                                " FROM STUDENT_ENROLLMENT GROUP BY quarter, year)";


            resultSet = statement.executeQuery(classQuery);
            %>
            <table border="1">
            <%
            Map<String, List<String[]>> classesByQuarterYear = new HashMap<String, List<String[]>>();
            Map<String, Double> totalGradePointsByQuarterYear = new HashMap<String, Double>();
            Map<String, Double> totalUnitsByQuarterYear = new HashMap<String, Double>();
            double cumulativeTotalGradePoints = 0;
            double cumulativeTotalUnits = 0;
            %>
            <%
            while (resultSet.next()) {
                String courseId = resultSet.getString("COURSEID");
                String quarter = resultSet.getString("QUARTER");
                int year = resultSet.getInt("YEAR");
                int unit = resultSet.getInt("UNIT");
                String sectionId = resultSet.getString("SECTIONID");
                String grade = resultSet.getString("GRADE");

                String[] classDetails = {courseId, quarter, String.valueOf(year), String.valueOf(unit), sectionId, grade};
                String quarterYearKey = quarter + " " + year;

                if (!classesByQuarterYear.containsKey(quarterYearKey)) {
                    classesByQuarterYear.put(quarterYearKey, new ArrayList<String[]>());
                    totalGradePointsByQuarterYear.put(quarterYearKey, 0.0);
                    totalUnitsByQuarterYear.put(quarterYearKey, 0.0);

                }
                // Calculate total grade points and units for the quarter
                String number_grade = "0.0";

                double gradePoint = Double.parseDouble(number_grade) * unit;
                double totalGradePoints = totalGradePointsByQuarterYear.get(quarterYearKey);
                double totalUnits = totalUnitsByQuarterYear.get(quarterYearKey);
                totalGradePoints += gradePoint * unit;
                totalUnits += unit;
                totalGradePointsByQuarterYear.put(quarterYearKey, totalGradePoints);
                totalUnitsByQuarterYear.put(quarterYearKey, totalUnits);

                // Update cumulative total grade points and units
                cumulativeTotalGradePoints += gradePoint * unit;
                cumulativeTotalUnits += unit;

                classesByQuarterYear.get(quarterYearKey).add(classDetails);
            }
            %>

            <%
            // Output classes by quarter and year
            for (Map.Entry<String, List<String[]>> entry : classesByQuarterYear.entrySet()) {
                String quarterYear = entry.getKey();
                List<String[]> classes = entry.getValue();
                double totalGradePoints = totalGradePointsByQuarterYear.get(quarterYear);
                double totalUnits = totalUnitsByQuarterYear.get(quarterYear);
                double quarterGPA = totalUnits != 0 ? totalGradePoints / totalUnits : 0;
            %>
                <h3>Classes Taken in <%= quarterYear %></h3>
                <table border="1">
                    <tr>
                        <th>Class Name</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>Units</th>
                        <th>Section</th>
                        <th>Grade</th>
                    </tr>
                    <% for (String[] classDetails : classes) { %>
                        <tr>
                            <td><%= classDetails[0] %></td>
                            <td><%= classDetails[1] %></td>
                            <td><%= classDetails[2] %></td>
                            <td><%= classDetails[3] %></td>
                            <td><%= classDetails[4] %></td>
                            <td><%= classDetails[5] %></td>
                        </tr>
                    <% } %>
                </table>
                <p>Quarter GPA: <%= String.format("%.2f", quarterGPA) %></p>
            <%
            }
            %>

            <%
            // Calculate cumulative GPA
            double cumulativeGPA = cumulativeTotalUnits != 0 ? cumulativeTotalGradePoints / cumulativeTotalUnits : 0;
            %>

            <p>Cumulative GPA: <%= String.format("%.2f", cumulativeGPA) %></p>

            <%
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
