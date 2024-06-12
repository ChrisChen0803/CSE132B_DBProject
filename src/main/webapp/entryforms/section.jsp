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
                    String url = "jdbc:postgresql://localhost:5432/CSE132B";
                    String username = "postgres";
                    String password = "Cyj020803!";
                    connection = DriverManager.getConnection(url, username, password);
                %>
                <table>
                <tr>
                <th>SECTIONID</th>
                <th>COURSEID</th>
                <th>QUARTER</th>
                <th>YEAR</th>
                <th>FACULTY NAME</th>
                <th>ENROLLMENT_LIMIT</th>

                </tr>
                <tr>
                <form action="section.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="SECTIONID" size="10"></th>
                <th><input value="" name="COURSEID" size="10"></th>
                <th><input value="" name="QUARTER" size="15"></th>
                <th><input value="" name="YEAR" size="15"></th>
                <th><input value="" name="FACULTYNAME" size="15"></th>
                <th><input value="" name="ENROLLMENT_LIMIT" size="15"></th>
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
                    ("INSERT INTO SECTION VALUES (?, ?, ?, ?, ?, ?)"));
                    pstmt.setString(1,request.getParameter("SECTIONID"));
                    pstmt.setString(2, request.getParameter("COURSEID"));
                    pstmt.setString(3, request.getParameter("QUARTER"));
                    pstmt.setInt(4, Integer.parseInt(request.getParameter("YEAR")));
                    pstmt.setString(5, request.getParameter("FACULTYNAME"));
                    pstmt.setInt(6, Integer.parseInt(request.getParameter("ENROLLMENT_LIMIT")));
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
        "UPDATE SECTION SET FACULTYNAME = ?, ENROLLMENT_LIMIT = ? WHERE COURSEID = ? AND SECTIONID = ? AND QUARTER = ? AND YEAR = ?");
        pstatement.setString(1, request.getParameter("FACULTYNAME"));
        pstatement.setInt(2, Integer.parseInt(request.getParameter("ENROLLMENT_LIMIT")));
        pstatement.setString(3,request.getParameter("COURSEID"));
        pstatement.setString(4,request.getParameter("SECTIONID"));
        pstatement.setString(5, request.getParameter("QUARTER"));
        pstatement.setInt(6,Integer.parseInt(request.getParameter("YEAR")));
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
        "DELETE FROM SECTION WHERE SECTIONID = ? AND COURSEID = ? AND QUARTER = ? AND YEAR = ?");
        pstmt.setString(1,request.getParameter("SECTIONID"));
        pstmt.setString(2,request.getParameter("COURSEID"));
        pstmt.setString(3, request.getParameter("QUARTER"));
        pstmt.setInt(4,Integer.parseInt(request.getParameter("YEAR")));
        int rowCount = pstmt.executeUpdate();
        connection.setAutoCommit(false);
        connection.setAutoCommit(true);
    }
%>
                    <%
                    // Create the statement

                    Statement statement = connection.createStatement();
                    // Use the statement to SELECT the student attributes
                    // FROM the Student table.
                    out.println("Connected to the PostgreSQL server successfully.");
                    ResultSet rs = statement.executeQuery("SELECT * FROM SECTION");
                    %>
<%
    // Iterate over the ResultSet
    while ( rs.next() ) {
    %>
        <tr>
        <form action="section.jsp" method="get">
        <input type="hidden" value="update" name="action">
        <td><input value="<%= rs.getString("SECTIONID") %>" name="SECTIONID"></td>
        <td><input value="<%= rs.getString("COURSEID") %>" name="COURSEID"></td>
        <td><input value="<%= rs.getString("QUARTER") %>" name="QUARTER"></td>
        <td><input value="<%= rs.getInt("YEAR") %>" name="YEAR"></td>
        <td><input value="<%= rs.getString("FACULTYNAME") %>" name="FACULTYNAME"></td>
        <td><input value="<%= rs.getInt("ENROLLMENT_LIMIT") %>" name="ENROLLMENT_LIMIT"></td>
        <td><input type="submit" value="Update"></td>
        </form>
        <form action="section.jsp" method="get">
        <input type="hidden" value="delete" name="action">
        <input type="hidden" value="<%= rs.getString("SECTIONID") %>" name="SECTIONID">
        <input type="hidden" value="<%= rs.getString("COURSEID") %>" name="COURSEID">
        <input type="hidden" value="<%= rs.getString("QUARTER") %>" name="QUARTER">
        <input type="hidden" value="<%= rs.getInt("YEAR") %>" name="YEAR">
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