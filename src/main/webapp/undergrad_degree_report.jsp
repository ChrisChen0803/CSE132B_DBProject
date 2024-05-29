<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Degree Requirement Calculation</title>
</head>
<body>
    <%
        String SSN = request.getParameter("SSN");
        String degreeParam = request.getParameter("degree");
        String degree_name = "";
        String major = "";

        if (degreeParam != null && degreeParam.contains("|")) {
            String[] parts = degreeParam.split("\\|");
            degree_name = parts[0];
            major = parts[1];
        }

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        ResultSet degreeSet = null;

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
            %>
            <h2>Remaining Degree Requirements</h2>
            <table border="1">
            <p>Degree Name: <%= degree_name %></p>
            <p>Major: <%= major %></p>
            <%


            String degreeQuery = "SELECT DC.* " +
                                 "FROM DEGREE_CLASSES DC " +
                                 "WHERE DC.DEGREENAME = '" + degree_name + "' AND DC.MAJOR = '" + major + "'";
            degreeSet = statement.executeQuery(degreeQuery);
            // Map to store category and associated classes and details
            Map<String, List<Map<String, Object>>> categoryMap = new HashMap<String, List<Map<String, Object>>>();
            double totalUnit = 0;
            // Iterate through the result set and populate the map
            while (degreeSet.next()) {
                String category = degreeSet.getString("Category");
                String classes = degreeSet.getString("Classes");
                int unit = degreeSet.getInt("Unit");

                // Create a map to store the class details
                Map<String, Object> classDetails = new HashMap<String, Object>();
                classDetails.put("Classes", classes);
                classDetails.put("Unit", unit);

                // Add the class details to the category map
                if (!categoryMap.containsKey(category)) {
                    categoryMap.put(category, new ArrayList<Map<String, Object>>());
                }
                categoryMap.get(category).add(classDetails);
            }

            // Iterate over the map to display the results
            for (Map.Entry<String, List<Map<String, Object>>> entry : categoryMap.entrySet()) {
                String category = entry.getKey();
                List<Map<String, Object>> classDetailsList = entry.getValue();
                %>
                <h3>Category: <%= category %></h3>
                <%
                for (Map<String, Object> classDetails : classDetailsList) {
                    String classes = (String) classDetails.get("Classes");
                    int categoryUnit = (Integer) classDetails.get("Unit");
                    %>
                    Required Unit: <%= categoryUnit %><br>
                    Class List: <%= classes %><br>
                    <%
                    String studentUnitsQuery = "SELECT PC.courseid, PC.unit " +
                                               "FROM PASTCLASS PC " +
                                               "WHERE PC.grade <> 'IN' AND PC.grade <> 'U' AND  PC.grade <> 'NP' " +
                                               "AND PC.studentid = (SELECT studentid FROM ENROLLEDSTUDENTS WHERE SSN = '" + SSN + "') ";
                    resultSet = statement.executeQuery(studentUnitsQuery);
                    while (resultSet.next()) {
                        String courseid = resultSet.getString("courseid");
                        int unit = resultSet.getInt("unit");
                        if (classes.contains(courseid)) {
                            categoryUnit -= unit;
                        }
                    }
                    if (categoryUnit > 0) totalUnit += categoryUnit;
                    %>
                    <br>
                    Remaining Unit: <%= categoryUnit < 0 ? 0 : categoryUnit %><br>
                    <%
                }
            }
            %>
            <br><br>
            <h2>Total Remaining Unit: <%= totalUnit < 0 ? 0 : totalUnit %></h2><br>
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
