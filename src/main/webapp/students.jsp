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
                <th>SSN</th>
                <th>StudentId</th>
                <th>First Name</th>
                <th>Middle Name</th>
                <th>Last Name</th>
                <th>Enrolled</th>
                <th>Citizenship</th>
                </tr>
                <tr>
                <form action="students.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="SSN" size="10"></th>
                <th><input value="" name="STUDENTID" size="10"></th>
                <th><input value="" name="FIRSTNAME" size="15"></th>
                <th><input value="" name="MIDDLENAME" size="15"></th>
                <th><input value="" name="LASTNAME" size="15"></th>
                <th><input value="" name="ENROLLED" size="15"></th>
                <th><input value="" name="CITIZENSHIP" size="15"></th>
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
                ("INSERT INTO Student VALUES (?, ?, ?, ?, ?, ?, ?)"));
                pstmt.setString(1, request.getParameter("STUDENTID"));
                pstmt.setInt(2,Integer.parseInt(request.getParameter("SSN")));
                pstmt.setString(3, request.getParameter("FIRSTNAME"));
                pstmt.setString(4, request.getParameter("MIDDLENAME"));
                pstmt.setString(5, request.getParameter("LASTNAME"));
                pstmt.setInt(6, Integer.parseInt(request.getParameter("ENROLLED")));
                pstmt.setInt(7, Integer.parseInt(request.getParameter("CITIZENSHIP")));
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
"UPDATE Student SET STUDENTID = ?,SSN = ?, FIRSTNAME = ?, MIDDLENAME = ?," +
"LASTNAME = ?, ENROLLED = ? WHERE CITIZENSHIP = ?");
pstatement.setString(1, request.getParameter("STUDENTID"));
pstatement.setInt(2,Integer.parseInt(request.getParameter("SSN")));
pstatement.setString(3, request.getParameter("FIRSTNAME"));
pstatement.setString(4, request.getParameter("MIDDLENAME"));
pstatement.setString(5, request.getParameter("LASTNAME"));
pstatement.setInt(6, Integer.parseInt(request.getParameter("ENROLLED")));
pstatement.setInt(7, Integer.parseInt(request.getParameter("CITIZENSHIP")));
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
"DELETE FROM Student WHERE STUDENTID = ?");
pstmt.setString(1,request.getParameter("STUDENTID"));
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
                    ResultSet rs = statement.executeQuery("SELECT * FROM Student");
                    %>
<%
// Iterate over the ResultSet
while ( rs.next() ) {
%>
<tr>
<form action="students.jsp" method="get">
<input type="hidden" value="update" name="action">
<td><input value="<%= rs.getInt("SSN") %>" name="SSN"></td>
<td><input value="<%= rs.getString("STUDENTID") %>" name="STUDENTID"></td>
<td><input value="<%= rs.getString("FIRSTNAME") %>" name="FIRSTNAME"></td>
<td><input value="<%= rs.getString("MIDDLENAME") %>" name="MIDDLENAME"></td>
<td><input value="<%= rs.getString("LASTNAME") %>" name="LASTNAME"></td>
<td><input value="<%= rs.getString("ENROLLED") %>" name="ENROLLED"></td>
<td><input value="<%= rs.getString("CITIZENSHIP") %>" name="CITIZENSHIP"></td>
<td><input type="submit" value="Update"></td>
</form>
<form action="students.jsp" method="get">
<input type="hidden" value="delete" name="action">
<input type="hidden" value="<%= rs.getString("STUDENTID") %>"
name="STUDENTID">
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