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
                <th>StudentId</th>
                <th>ProbationId</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Reason</th>
                </tr>
                <tr>
                <form action="probation.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="STUDENTID" size="10"></th>
                <th><input value="" name="PROBATIONID" size="15"></th>
                <th><input value="" name="STARTDATE" size="20"></th>
                <th><input value="" name="ENDDATE" size="20"></th>
                <th><input value="" name="REASON" size="15"></th>
                <th><input type="submit" value="Insert"></th>
                </form>
                </tr>
                <%
                // Check if an insertion is requested
                String action = request.getParameter("action");
                if (action != null && action.equals("insert")) {
                    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
                    java.util.Date parsedStartDate = sdf.parse(request.getParameter("STARTDATE"));
                    java.sql.Date startDate = new java.sql.Date(parsedStartDate.getTime());
                    java.util.Date parsedEndDate = sdf.parse(request.getParameter("ENDDATE"));
                    java.sql.Date endDate = new java.sql.Date(parsedEndDate.getTime());
                    connection.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // INSERT the student attrs INTO the Student table.
                    PreparedStatement pstmt = connection.prepareStatement(
                    ("INSERT INTO Probation VALUES (?, ?, ?, ?, ?)"));
                    pstmt.setString(1, request.getParameter("STUDENTID"));
                    pstmt.setString(2, request.getParameter("PROBATIONID"));
                    pstmt.setDate(3, startDate); // Use setDate for dates
                    pstmt.setDate(4, endDate);   // Use setDate for dates
                    pstmt.setString(5, request.getParameter("REASON"));
                    pstmt.executeUpdate();
                    connection.commit();
                    connection.setAutoCommit(true);
                }
                %>
<%
    // Check if an update is requested
    if (action != null && action.equals("update")) {
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
        java.util.Date parsedStartDate = sdf.parse(request.getParameter("STARTDATE"));
        java.sql.Date startDate = new java.sql.Date(parsedStartDate.getTime());

        java.util.Date parsedEndDate = sdf.parse(request.getParameter("ENDDATE"));
        java.sql.Date endDate = new java.sql.Date(parsedEndDate.getTime());
        connection.setAutoCommit(false);
        // Create the prepared statement and use it to
        // UPDATE the student attributes in the Student table.
        PreparedStatement pstatement = connection.prepareStatement(
        "UPDATE PROBATION SET REASON = ?, STARTDATE = ?, ENDDATE = ? WHERE STUDENTID = ? AND PROBATIONID = ?");
        pstatement.setString(1, request.getParameter("REASON"));
        pstatement.setDate(2, startDate);
        pstatement.setDate(3, endDate);
        pstatement.setString(4, request.getParameter("STUDENTID"));
        pstatement.setString(5, request.getParameter("PROBATIONID"));
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
        "DELETE FROM PROBATION WHERE STUDENTID = ? AND PROBATIONID = ?");
        pstmt.setString(1,request.getParameter("STUDENTID"));
        pstmt.setString(2,request.getParameter("PROBATIONID"));
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
                    out.println("Please enter Start Date & End Date in the form of (MM/dd/yyyy)");
                    ResultSet rs = statement.executeQuery("SELECT * FROM PROBATION");
                    %>
<%
// Iterate over the ResultSet
while ( rs.next() ) {
    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
    String startDateStr = sdf.format(rs.getDate("STARTDATE"));
    String endDateStr = sdf.format(rs.getDate("ENDDATE"));
%>
<tr>
    <form action="probation.jsp" method="get">
        <input type="hidden" value="update" name="action">
        <td><input value="<%= rs.getString("STUDENTID") %>" name="STUDENTID"></td>
        <td><input value="<%= rs.getString("PROBATIONID") %>" name="PROBATIONID"></td>
        <td><input value="<%= startDateStr %>" name="STARTDATE"></td>
        <td><input value="<%= endDateStr %>" name="ENDDATE"></td>
        <td><input value="<%= rs.getString("REASON") %>" name="REASON"></td>
        <td><input type="submit" value="Update"></td>
    </form>
    <form action="probation.jsp" method="get">
        <input type="hidden" value="delete" name="action">
        <input type="hidden" value="<%= rs.getString("STUDENTID") %>"
        name="STUDENTID">
        <input type="hidden" value="<%= rs.getString("PROBATIONID") %>"
        name="PROBATIONID">
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