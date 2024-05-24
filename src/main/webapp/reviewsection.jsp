<html>
    <body>
        <%@ page import="java.text.SimpleDateFormat" %>
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
                    String url = "jdbc:postgresql://localhost:5432/CSE132B";
                    String username = "postgres";
                    String password = "Cyj020803!";
                    connection = DriverManager.getConnection(url, username, password);
                %>
                <table>
                <tr>
                <th>CLassId</th>
                <th>SectionId</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Building</th>
                </tr>
                <tr>
                <form action="reviewsection.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="COURSEID" size="10"></th>
                <th><input value="" name="SECTIONID" size="15"></th>
                <th><input value="" name="STARTTIME" size="20"></th>
                <th><input value="" name="ENDTIME" size="20"></th>
                <th><input value="" name="BUILDING" size="15"></th>
                <th><input type="submit" value="Insert"></th>
                </form>
                </tr>
                <%
                // Check if an insertion is requested
                String action = request.getParameter("action");
                if (action != null && action.equals("insert")) {
                    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm");
                    java.util.Date parsedStartDate = sdf.parse(request.getParameter("STARTTIME"));
                    java.sql.Timestamp startDate = new java.sql.Timestamp(parsedStartDate.getTime());
                    java.util.Date parsedEndDate = sdf.parse(request.getParameter("ENDTIME"));
                    java.sql.Timestamp endDate = new java.sql.Timestamp(parsedEndDate.getTime());
                    connection.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // INSERT the student attrs INTO the Student table.
                    PreparedStatement pstmt = connection.prepareStatement(
                    ("INSERT INTO REVIEW_SECTION VALUES (?, ?, ?, ?, ?)"));
                    pstmt.setInt(1, Integer.parseInt(request.getParameter("COURSEID")));
                    pstmt.setInt(2, Integer.parseInt(request.getParameter("SECTIONID")));
                    pstmt.setTimestamp(3, startDate); // Use setDate for TIME
                    pstmt.setTimestamp(4, endDate);   // Use setDate for TIME
                    pstmt.setString(5, request.getParameter("BUILDING"));
                    pstmt.executeUpdate();
                    connection.commit();
                    connection.setAutoCommit(true);
                }
                %>
<%
    // Check if an update is requested
    if (action != null && action.equals("update")) {
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        java.util.Date parsedStartDate = sdf.parse(request.getParameter("STARTTIME"));
        java.sql.Timestamp startDate = new java.sql.Timestamp(parsedStartDate.getTime());
        java.util.Date parsedEndDate = sdf.parse(request.getParameter("ENDTIME"));
        java.sql.Timestamp endDate = new java.sql.Timestamp(parsedEndDate.getTime());
        connection.setAutoCommit(false);
        // Create the prepared statement and use it to
        // UPDATE the student attributes in the Student table.
        PreparedStatement pstatement = connection.prepareStatement(
        "UPDATE Review_Section SET BUILDING = ?, STARTTIME = ?, ENDTIME = ? WHERE COURSEID = ? AND SECTIONNID = ?");
        pstatement.setString(1, request.getParameter("BUILDING"));
        pstatement.setTimestamp(2, startDate);
        pstatement.setTimestamp(3, endDate);
        pstatement.setInt(4, Integer.parseInt(request.getParameter("COURSEID")));
        pstatement.setInt(5, Integer.parseInt(request.getParameter("SECTIONID")));
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
        "DELETE FROM Review_Section WHERE COURSEID = ? AND SECTIONID = ?");
        pstmt.setInt(1, Integer.parseInt(request.getParameter("COURSEID")));
        pstmt.setInt(2, Integer.parseInt(request.getParameter("SECTIONID")));
        int rowCount = pstmt.executeUpdate();
        connection.setAutoCommit(false);
        connection.setAutoCommit(true);
    }
%>
                    <%
                    // Create the statement

                    Statement statement = connection.createStatement();
                    // Use the statement to SELECT the Probation attributes
                    // FROM the Probation table.
                    //out.println("Connected to the PostgreSQL server successfully");
                    out.println("Please enter Start Time & End Time in the form of (MM/dd/yyyy HH:mm)");
                    ResultSet rs = statement.executeQuery("SELECT * FROM REVIEW_SECTION");
                    %>
<%
// Iterate over the ResultSet
while ( rs.next() ) {
    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm");
    String startDateStr = null;
        String endDateStr = null;

        // Retrieve the start time as a Timestamp
        java.sql.Timestamp startTimeStamp = rs.getTimestamp("STARTTIME");
        if (startTimeStamp != null) {
            // Format the start time as a string
            startDateStr = sdf.format(startTimeStamp);
        }

        // Retrieve the end time as a Timestamp
        java.sql.Timestamp endTimeStamp = rs.getTimestamp("ENDTIME");
        if (endTimeStamp != null) {
            // Format the end time as a string
            endDateStr = sdf.format(endTimeStamp);
        }
%>
<tr>
    <form action="reviewsection.jsp" method="get">
        <input type="hidden" value="update" name="action">
        <td><input value="<%= rs.getInt("COURSEID") %>" name="COURSEID"></td>
        <td><input value="<%= rs.getInt("SECTIONID") %>" name="SECTIONID"></td>
        <td><input value="<%= startDateStr %>" name="STARTTIME"></td>
        <td><input value="<%= endDateStr %>" name="ENDTIME"></td>
        <td><input value="<%= rs.getString("BUILDING") %>" name="BUILDING"></td>
        <td><input type="submit" value="Update"></td>
    </form>
    <form action="reviewsection.jsp" method="get">
        <input type="hidden" value="delete" name="action">
        <input type="hidden" value="<%= rs.getInt("COURSEID") %>"
        name="COURSEID">
        <input type="hidden" value="<%= rs.getInt("SECTIONID") %>"
        name="SECTIONID">
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