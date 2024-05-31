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
                <th>Course Id</th>
                <th>Course Number</th>
                <th>Unit</th>
                <th>Grade Status</th>
                <th>Prerequisites</th>
                <th>General Topic</th>
                <th>Instructor Consent</th>
                <th>Is Required Lab Work</th>
                <th>Is Lower</th>
                <th>Department</th>
                </tr>
                <tr>
                <form action="courses.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="COURSEID" size="10"></th>
                <th><input value="" name="COURSENAME" size="10"></th>
                <th><input value="" name="UNIT" size="15"></th>
                <th><input value="" name="GRADESTATUS" size="15"></th>
                <th><input value="" name="PREREQUISITES" size="15"></th>
                <th><input value="" name="GENERALTOPIC" size="15"></th>
                <th><input value="" name="INSTRUCTORCONSENT" size="15"></th>
                <th><input value="" name="ISREQUIREDLABWORK" size="15"></th>
                <th><input value="" name="ISLOWER" size="15"></th>
                <th><input value="" name="DEPARTMENT" size="15"></th>
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
                ("INSERT INTO COURSE VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"));
                pstmt.setString(1,request.getParameter("COURSEID"));
                pstmt.setString(2, request.getParameter("COURSENAME"));
                pstmt.setInt(3,Integer.parseInt(request.getParameter("UNIT")));
                pstmt.setString(4, request.getParameter("GRADESTATUS"));
                pstmt.setString(5, request.getParameter("PREREQUISITES"));
                pstmt.setString(6, request.getParameter("GENERALTOPIC"));
                pstmt.setBoolean(7, Boolean.parseBoolean(request.getParameter("INSTRUCTORCONSENT")));
                pstmt.setBoolean(8, Boolean.parseBoolean(request.getParameter("ISREQUIREDLABWORK")));
                pstmt.setBoolean(9, Boolean.parseBoolean(request.getParameter("ISLOWER")));
                pstmt.setString(10, request.getParameter("DEPARTMENT"));
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
"UPDATE COURSE SET ISLOWER = ?,COURSENAME = ?, UNIT = ?,GRADESTATUS = ?, PREREQUISITES = ?," +
"GENERALTOPIC = ?, INSTRUCTORCONSENT = ?,ISREQUIREDLABWORK = ?, DEPARTMENT = ? WHERE COURSEID = ?");
pstatement.setBoolean(1, Boolean.parseBoolean(request.getParameter("ISLOWER")));
pstatement.setString(2, request.getParameter("COURSENAME"));
pstatement.setInt(3,Integer.parseInt(request.getParameter("UNIT")));
pstatement.setString(4, request.getParameter("GRADESTATUS"));
pstatement.setString(5, request.getParameter("PREREQUISITES"));
pstatement.setString(6, request.getParameter("GENERALTOPIC"));
pstatement.setBoolean(7, Boolean.parseBoolean(request.getParameter("INSTRUCTORCONSENT")));
pstatement.setBoolean(8, Boolean.parseBoolean(request.getParameter("ISREQUIREDLABWORK")));
pstatement.setString(9, request.getParameter("DEPARTMENT"));
pstatement.setString(10,request.getParameter("COURSEID"));

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
"DELETE FROM COURSE WHERE COURSEID = ?");
pstmt.setString(1,request.getParameter("COURSEID"));
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
                    ResultSet rs = statement.executeQuery("SELECT * FROM COURSE");
                    %>
<%
// Iterate over the ResultSet
while ( rs.next() ) {
%>
<tr>
<form action="courses.jsp" method="get">
<input type="hidden" value="update" name="action">
<td><input value="<%= rs.getString("COURSEID") %>" name="COURSEID"></td>
<td><input value="<%= rs.getString("COURSENAME") %>" name="COURSENAME"></td>
<td><input value="<%= rs.getString("UNIT") %>" name="UNIT"></td>
<td><input value="<%= rs.getString("GRADESTATUS") %>" name="GRADESTATUS"></td>
<td><input value="<%= rs.getString("PREREQUISITES") %>" name="PREREQUISITES"></td>
<td><input value="<%= rs.getString("GENERALTOPIC") %>" name="GENERALTOPIC"></td>
<td><input value="<%= rs.getString("INSTRUCTORCONSENT") %>" name="INSTRUCTORCONSENT"></td>
<td><input value="<%= rs.getString("ISREQUIREDLABWORK") %>" name="ISREQUIREDLABWORK"></td>
<td><input value="<%= rs.getString("ISLOWER") %>" name="ISLOWER"></td>
<td><input value="<%= rs.getString("DEPARTMENT") %>" name="DEPARTMENT"></td>
<td><input type="submit" value="Update"></td>
</form>
<form action="courses.jsp" method="get">
<input type="hidden" value="delete" name="action">
<input type="hidden" value="<%= rs.getInt("COURSEID") %>"
name="COURSEID">
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