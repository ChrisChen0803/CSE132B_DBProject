<html>
    <body>
        <table>
            <tr>
                <td>
                <%-- Set the scripting language to java and --%>
                <%-- import the java.sql package --%>
                <%@ page language="java" import="java.sql.*" %>
                <%
                Connection connection = null;
                ResultSet resultSet = null;
                try {
                    // Load the PostgreSQL JDBC driver
                    Class.forName("org.postgresql.Driver");

                    // Establish connection to the database
                    String url = "jdbc:postgresql://localhost:5433/CSE132B";
                    String username = "postgres";
                    String password = "xbxjj";
                    connection = DriverManager.getConnection(url, username, password);
                %>
                <table>
                <tr>
                <th>Meeting ID</th>
                <th>Section ID</th>
                <th>Course ID</th>
                <th>QUARTER</th>
                <th>YEAR</th>
                <th>Day Of Week</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Building</th>
                <th>Type</th>

                </tr>
                <tr>
                <form action="regular_meeting.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="MEETINGID" size="10"></th>
                <th><input value="" name="SECTIONID" size="10"></th>
                <th><input value="" name="COURSEID" size="10"></th>
                <th><input value="" name="QUARTER" size="15"></th>
                <th><input value="" name="YEAR" size="15"></th>
                <th><input value="" name="DAY_OF_WEEK" size="15"></th>
                <th><input value="" name="START_TIME" size="15"></th>
                <th><input value="" name="END_TIME" size="15"></th>
                <th><input value="" name="BUILDING" size="15"></th>
                <th><input value="" name="TYPE" size="15"></th>
                <th><input type="submit" value="Insert"></th>
                </form>
                </tr>
                <%
                // Check if an insertion is requested
                String action = request.getParameter("action");
                if (action != null && action.equals("insert")) {
                    connection.setAutoCommit(false);
                    // Create the prepared statement and use it to
                    // INSERT the student attrs INTO the Student table.
                    PreparedStatement pstmt = connection.prepareStatement(
                    ("INSERT INTO REGULAR_MEETING VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"));
                    pstmt.setInt(1, Integer.parseInt(request.getParameter("MEETINGID")));
                    pstmt.setString(2, request.getParameter("SECTIONID"));
                    pstmt.setString(3, request.getParameter("COURSEID"));
                    pstmt.setString(4, request.getParameter("QUARTER"));
                    pstmt.setInt(5, Integer.parseInt(request.getParameter("YEAR")));
                    pstmt.setString(6, request.getParameter("DAY_OF_WEEK"));
                    pstmt.setTime(7, java.sql.Time.valueOf(request.getParameter("START_TIME"))); // Assuming time format is correct
                    pstmt.setTime(8, java.sql.Time.valueOf(request.getParameter("END_TIME"))); // Assuming time format is correct
                    pstmt.setString(9, request.getParameter("BUILDING"));
                    pstmt.setString(10, request.getParameter("TYPE"));
                    pstmt.executeUpdate();
                    connection.commit();
                    connection.setAutoCommit(true);
                }
                %>
<%
    // Check if an update is requested
    if (action != null && action.equals("update")) {
        connection.setAutoCommit(false);
        // Create the prepared statement and use it to
        // UPDATE the student attributes in the Student table.
        PreparedStatement pstatement = connection.prepareStatement(
        "UPDATE regular_meeting SET sectionid = ?, courseid = ?, quarter = ?, year = ?, day_of_week = ?, start_time = ? " +
        "end_time = ?, building = ?, type = ? WHERE meetingid");
        pstatement.setString(1, request.getParameter("SECTIONID"));
        pstatement.setString(2, request.getParameter("COURSEID"));
        pstatement.setString(3, request.getParameter("QUARTER"));
        pstatement.setInt(4, Integer.parseInt(request.getParameter("YEAR")));
        pstatement.setString(5,request.getParameter("DAY_OF_WEEK"));
        pstatement.setString(6, request.getParameter("START_TIME"));
        pstatement.setString(7, request.getParameter("END_TIME"));
        pstatement.setString(8, request.getParameter("TYPE"));
        pstatement.setInt(9, Integer.parseInt(request.getParameter("MEETINGID")));

        int rowCount = pstatement.executeUpdate();
        connection.setAutoCommit(false);
        connection.setAutoCommit(true);
    }
    // Check if a delete is requested
    if (action != null && action.equals("delete")) {
        connection.setAutoCommit(false);
        // Create the prepared statement and use it to
        // DELETE the student FROM the Student table.
        PreparedStatement pstmt = connection.prepareStatement(
        "DELETE FROM REGULAR_MEETING WHERE MEETINGID = ?");
        pstmt.setInt(1, Integer.parseInt(request.getParameter("MEETINGID")));
        int rowCount = pstmt.executeUpdate();
        connection.setAutoCommit(true);
    }
%>
                    <%
                    // Create the statement

                    Statement statement = connection.createStatement();
                    // Use the statement to SELECT the student attributes
                    // FROM the Student table.
                    out.println("Connected to the PostgreSQL server successfully.");
                    ResultSet rs = statement.executeQuery("SELECT * FROM REGULAR_MEETING");
                    %>
<%
    // Iterate over the ResultSet
    while ( rs.next() ) {
    %>
        <tr>
        <form action="regular_meeting.jsp" method="get">
        <input type="hidden" value="update" name="action">
        <td><input value="<%= rs.getInt("MEETINGID") %>" name="MEETINGID"></td>
        <td><input value="<%= rs.getString("SECTIONID") %>" name="SECTIONID"></td>
        <td><input value="<%= rs.getString("COURSEID") %>" name="COURSEID"></td>
        <td><input value="<%= rs.getString("QUARTER") %>" name="QUARTER"></td>
        <td><input value="<%= rs.getInt("YEAR") %>" name="YEAR"></td>
        <td><input value="<%= rs.getString("DAY_OF_WEEK") %>" name="DAY_OF_WEEK"></td>
        <td><input value="<%= rs.getString("START_TIME") %>" name="START_TIME"></td>
        <td><input value="<%= rs.getString("END_TIME") %>" name="END_TIME"></td>
        <td><input value="<%= rs.getString("BUILDING") %>" name="BUILDING"></td>
        <td><input value="<%= rs.getString("TYPE") %>" name="TYPE"></td>
        <td><input type="submit" value="Update"></td>
        </form>
        <form action="regular_meeting.jsp" method="get">
        <input type="hidden" value="delete" name="action">
        <input type="hidden" value="<%= rs.getInt("MEETINGID") %>" name="MEETINGID">
        <td><input type="submit" value="Delete"></td>
        </form>
        </tr>
    <%
    }
%>

                </table>
                <%
                // Close the ResultSet
                rs.close();
                // Close the Statement
                statement.close();
                // Close the Connection
                connection.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
                %>
                </td>
            </tr>
        </table>
    </body>
</html>