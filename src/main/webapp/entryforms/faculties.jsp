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
                <th>FACULTYNAME</th>
                <th>TITLE</th>
                <th>DEPARTMENT</th>
                </tr>
                <tr>
                <form action="faculties.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="FACULTYNAME" size="10"></th>
                <th><input value="" name="TITLE" size="10"></th>
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
                ("INSERT INTO FACULTY VALUES (?, ?, ?)"));
                pstmt.setString(1, request.getParameter("FACULTYNAME"));
                pstmt.setString(2, request.getParameter("TITLE"));
                pstmt.setString(3, request.getParameter("DEPARTMENT"));
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
"UPDATE FACULTY SET TITLE = ?, DEPARTMENT = ? WHERE FACULTYNAME = ?");
pstatement.setString(1, request.getParameter("TITLE"));
pstatement.setString(2, request.getParameter("DEPARTMENT"));
pstatement.setString(3, request.getParameter("FACULTYNAME"));
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
"DELETE FROM FACULTY WHERE FACULTYNAME = ?");
pstmt.setString(1,request.getParameter("FACULTYNAME"));
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
                    ResultSet rs = statement.executeQuery("SELECT * FROM FACULTY");
                    %>
<%
// Iterate over the ResultSet
while ( rs.next() ) {
%>
<tr>
<form action="faculties.jsp" method="get">
<input type="hidden" value="update" name="action">
<td><input value="<%= rs.getString("FACULTYNAME") %>" name="FACULTYNAME"></td>
<td><input value="<%= rs.getString("TITLE") %>" name="TITLE"></td>
<td><input value="<%= rs.getString("DEPARTMENT") %>" name="DEPARTMENT"></td>
<td><input type="submit" value="Update"></td>
</form>
<form action="faculties.jsp" method="get">
<input type="hidden" value="delete" name="action">
<input type="hidden" value="<%= rs.getString("FACULTYNAME") %>"
name="FACULTYNAME">
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