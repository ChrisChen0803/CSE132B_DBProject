<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Classes Report</title>
</head>
<body>
    <%
        String courseid = request.getParameter("COURSEID");
        String sectionid = request.getParameter("SECTIONID");
        String start_date = request.getParameter("start_date");
        String end_date = request.getParameter("end_date");

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

            String query = "WITH RECURSIVE DateSeries AS (" +
                        "SELECT " +
                            "CAST('" + start_date + "' AS DATE) AS date, " +
                            "EXTRACT(DOW FROM CAST('" + start_date + "' AS DATE)) AS day_of_week " +
                        "UNION ALL " +
                        "SELECT " +
                            "(date + INTERVAL '1 day')::DATE, " +
                            "EXTRACT(DOW FROM (date + INTERVAL '1 day')::DATE) AS day_of_week " +
                        "FROM DateSeries " +
                        "WHERE (date + INTERVAL '1 day')::DATE <= '" + end_date + "' " +
                    "), " +
                    "TimeSlots AS (" +
                        "SELECT " +
                            "(CAST('08:00' AS TIME) + (interval '1 hour' * generate_series(0, 11))) AS time " +
                    "), " +
                    "Potential_Time AS (" +
                        "SELECT DateSeries.date, " +
                        "CASE " +
                            "WHEN DateSeries.day_of_week = 0 THEN 'Su' " +
                            "WHEN DateSeries.day_of_week = 1 THEN 'M' " +
                            "WHEN DateSeries.day_of_week = 2 THEN 'Tu' " +
                            "WHEN DateSeries.day_of_week = 3 THEN 'W' " +
                            "WHEN DateSeries.day_of_week = 4 THEN 'Th' " +
                            "WHEN DateSeries.day_of_week = 5 THEN 'F' " +
                            "WHEN DateSeries.day_of_week = 6 THEN 'Sa' " +
                        "END AS day_of_week, " +
                        "TimeSlots.time, (TimeSlots.time + INTERVAL '1 hour') AS end_time " +
                        "FROM DateSeries, TimeSlots " +
                        "ORDER BY DateSeries.date, TimeSlots.time " +
                    "), " +
                    "BusyTime AS (" +
                        "SELECT " +
                            "rm.day_of_week AS meeting_days, " +
                            "rm.start_time AS meeting_start_time, " +
                            "rm.end_time AS meeting_end_time " +
                        "FROM " +
                            "COURSEENROLLMENT ce " +
                        "JOIN " +
                            "regular_meeting rm ON ce.courseid = rm.courseid AND ce.sectionid = rm.sectionid " +
                        "WHERE " +
                            "ce.studentid IN ( " +
                                "SELECT studentid " +
                                "FROM COURSEENROLLMENT " +
                                "WHERE COURSEID = '" + courseid + "' AND SECTIONID = '" + sectionid + "' " +
                            ") " +
                    ") " +
                    "SELECT " +
                            "pt.date, " +
                            "pt.time, " +
                            "pt.end_time, " +
                            "pt.day_of_week " +
                        "FROM " +
                            "Potential_Time pt " +
                        "WHERE " +
                            "NOT EXISTS ( " +
                                "SELECT 1 " +
                                "FROM BusyTime bt " +
                                "WHERE " +
                                    "bt.meeting_days LIKE '%' || pt.day_of_week || '%' " +
                                    "AND pt.time < bt.meeting_end_time " +
                                    "AND pt.end_time > bt.meeting_start_time " +
                            ");";

                    resultSet = statement.executeQuery(query);

                    %>
                    <table border="1">
                        <tr>
                            <th>Date</th>
                            <th>Time</th>
                            <th>End Time</th>
                            <th>Day of Week</th>
                        </tr>
                    <%
                            while (resultSet.next()) {
                                // Retrieve and display each row of the result set
                                String date = resultSet.getString("date");
                                String time = resultSet.getString("time");
                                String end_time = resultSet.getString("end_time");
                                String day_of_week = resultSet.getString("day_of_week");
                    %>
                        <tr>
                            <td><%= date %></td>
                            <td><%= time %></td>
                            <td><%= end_time %></td>
                            <td><%= day_of_week %></td>
                        </tr>
                    <%
                            }
                    %>
                    </table>
                    <%
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
