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
                <th>PASTID</th>
                <th>STUDENTID</th>
                <th>COURSEID</th>
                <th>SECTIONID</th>
                <th>Quarter</th>
                <th>Year</th>
                <th>unit</th>
                </tr>
                <tr>
                <form action="pastclasses.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="PASTID" size="10"></th>
                <th><input value="" name="STUDENTID" size="10"></th>
                <th><input value="" name="COURSEID" size="10"></th>
                <th><input value="" name="SECTIONID" size="10"></th>
                <th><input value="" name="QUARTER" size="10"></th>
                <th><input value="" name="YEAR" size="10"></th>
                <th><input value="" name="unit" size="15"></th>
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
                ("INSERT INTO PASTCLASSES VALUES (?, ?, ?, ?, ?, ?, ?)"));
                pstmt.setInt(1, Integer.parseInt(request.getParameter("PASTID")));
                pstmt.setInt(2, Integer.parseInt(request.getParameter("STUDENTID")));
                pstmt.setInt(3, Integer.parseInt(request.getParameter("COURSEID")));
                pstmt.setInt(4, Integer.parseInt(request.getParameter("SECTIONID")));
                pstmt.setString(5, request.getParameter("QUARTER"));
                pstmt.setInt(6, Integer.parseInt(request.getParameter("YEAR")));
                pstmt.setInt(7, Integer.parseInt(request.getParameter("unit")));
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
"UPDATE PASTCLASSES SET STUDENTID = ?, COURSEID = ?, SECTIONID = ?,QUARTER = ?, YEAR = ?, unit = ? WHERE PASTID=? ");
pstatement.setInt(1, Integer.parseInt(request.getParameter("STUDENTID")));
pstatement.setInt(2, Integer.parseInt(request.getParameter("COURSEID")));
pstatement.setInt(3, Integer.parseInt(request.getParameter("SECTIONID")));
pstatement.setString(4, request.getParameter("QUARTER"));
pstatement.setInt(5, Integer.parseInt(request.getParameter("YEAR")));
pstatement.setInt(6, Integer.parseInt(request.getParameter("unit")));
pstatement.setInt(7, Integer.parseInt(request.getParameter("PASTID")));
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
"DELETE FROM PASTCLASSES WHERE PASTID = ?");
pstmt.setInt(1,Integer.parseInt(request.getParameter("PASTID")));
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
                    ResultSet rs = statement.executeQuery("SELECT * FROM PASTCLASSES");
                    %>
<%
// Iterate over the ResultSet
while ( rs.next() ) {
%>
<tr>
<form action="pastclasses.jsp" method="get">
<input type="hidden" value="update" name="action">
<td><input value="<%= rs.getInt("PASTID") %>" name="PASTID"></td>
<td><input value="<%= rs.getInt("STUDENTID") %>" name="STUDENTID"></td>
<td><input value="<%= rs.getInt("COURSEID") %>" name="COURSEID"></td>
<td><input value="<%= rs.getInt("SECTIONID") %>" name="SECTIONID"></td>
<td><input value="<%= rs.getString("QUARTER") %>" name="QUARTER"></td>
<td><input value="<%= rs.getInt("YEAR") %>" name="YEAR"></td>
<td><input value="<%= rs.getInt("unit") %>" name="unit"></td>
<td><input type="submit" value="Update"></td>
</form>
<form action="pastclasses.jsp" method="get">
<input type="hidden" value="delete" name="action">
<input type="hidden" value="<%= rs.getInt("PASTID") %>"
name="PASTID">
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