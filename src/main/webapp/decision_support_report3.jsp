<%@ page import="java.sql.*" %>
<%
    // Retrieve request parameters
    String courseid = request.getParameter("COURSEID");
    String facultyname = request.getParameter("PROFESSOR");
    String year = request.getParameter("YEAR");

    // Initialize database variables
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

        // Construct the SQL query
        String query = "SELECT " +
            "AVG(grade_conversion.NUMBER_GRADE) AS GPA " +
            "FROM PASTCLASS pc " +
            "JOIN GRADE_CONVERSION grade_conversion ON pc.grade = grade_conversion.LETTER_GRADE " +
            "WHERE pc.courseid = '" + courseid + "' " +
            "AND pc.facultyname = '" + facultyname + "' " +
            "AND pc.year = '" + year + "' " +
            "AND pc.grade != 'IN';";

        // Print the constructed query for debugging

        // Execute the query
        resultSet = statement.executeQuery(query);

        // Print the result if available
        if (resultSet.next()) {
            double gpa = resultSet.getDouble("GPA");

            // Print the result
%>
            <p>Average GPA: <%= gpa %></p>
<%
        } else {
            out.println("No results found.");
        }
    } catch (SQLException e) {
        out.println("SQL Exception: " + e.getMessage());
    } finally {
        // Close resources
        if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
