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
                <th>Degree Name</th>
                <th>Department Name</th>
                <th>Category</th>
                <th>Class List</th>
                <th>Unit</th>
                <th>Grade</th>

                </tr>
                <tr>
                <form action="degreerequirements.jsp" method="get">
                <input type="hidden" value="insert" name="action">
                <th><input value="" name="DEGREE_NAME" size="15"></th>
                <th><input value="" name="DEPARTMENT_NAME" size="15"></th>
                <th><input value="" name="CATEGORY" size="15"></th>
                <th><input value="" name="CLASS_LIST" size="15"></th>
                <th><input value="" name="UNIT" size="10"></th>
                <th><input value="" name="GRADE" size="10"></th>
                <th><input type="submit" value="Insert"></th>
                </form>
                </tr>
                <%
                // Check if an insertion is requested
                String action = request.getParameter("action");
                if (action != null && action.equals("insert")) {
                connection.setAutoCommit(false);
                // Create the prepared statement and use it to
                // INSERT the DEGREE_INFO attrs INTO the DEGREE_INFO table.
                PreparedStatement pstmt = connection.prepareStatement(
                ("INSERT INTO DEGREE_INFO VALUES (?, ?, ?, ?, ?, ?)"));
                pstmt.setString(1, request.getParameter("DEGREE_NAME"));
                pstmt.setString(2, request.getParameter("DEPARTMENT_NAME"));
                pstmt.setString(3, request.getParameter("CATEGORY"));
                pstmt.setString(4, request.getParameter("CLASS_LIST"));
                pstmt.setInt(5, Integer.parseInt(request.getParameter("UNIT")));
                pstmt.setString(6, request.getParameter("GRADE"));
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
// UPDATE the DEGREE_INFO attributes in the DEGREE_INFO table.
PreparedStatement pstatement = connection.prepareStatement(
"UPDATE DEGREE_INFO SET CLASS_LIST = ?, UNIT = ?, GRADE = ? WHERE DEGREE_NAME = ? AND DEPARTMENT_NAME = ? AND CATEGORY = ?");
pstatement.setString(1, request.getParameter("CLASS_LIST"));
pstatement.setInt(2,Integer.parseInt(request.getParameter("UNIT")));
pstatement.setString(3, request.getParameter("GRADE"));
pstatement.setString(4, request.getParameter("DEGREE_NAME"));
pstatement.setString(5, request.getParameter("DEPARTMENT_NAME"));
pstatement.setString(6, request.getParameter("CATEGORY"));
int rowCount = pstatement.executeUpdate();
connection.setAutoCommit(false);
connection.setAutoCommit(true);
}
// Check if a delete is requested
if (action != null && action.equals("delete")) {
connection.setAutoCommit(false);
// Create the prepared statement and use it to
// DELETE the DEGREE_INFO FROM the DEGREE_INFO table.
PreparedStatement pstmt = connection.prepareStatement(
"DELETE FROM DEGREE_INFO WHERE DEGREE_NAME = ? AND DEPARTMENT_NAME = ? AND CATEGORY = ?");
pstmt.setString(1,request.getParameter("DEGREE_NAME"));
pstmt.setString(2,request.getParameter("DEPARTMENT_NAME"));
pstmt.setString(3,request.getParameter("CATEGORY"));
int rowCount = pstmt.executeUpdate();
connection.setAutoCommit(false);
connection.setAutoCommit(true);
}
%>
                    <%
                    // Create the statement

                    Statement statement = connection.createStatement();
                    // Use the statement to SELECT the DEGREE_INFO attributes
                    // FROM the DEGREE_INFO table.
                    out.println("Connected to the PostgreSQL server successfully.");
                    ResultSet rs = statement.executeQuery("SELECT * FROM DEGREE_INFO");
                    %>
<%
// Iterate over the ResultSet
while ( rs.next() ) {
%>
<tr>
<form action="degreerequirements.jsp" method="get">
<input type="hidden" value="update" name="action">
<td><input value="<%= rs.getString("DEGREE_NAME") %>" name="DEGREE_NAME"></td>
<td><input value="<%= rs.getString("DEPARTMENT_NAME") %>" name="DEPARTMENT_NAME"></td>
<td><input value="<%= rs.getString("CATEGORY") %>" name="CATEGORY"></td>
<td><input value="<%= rs.getString("CLASS_LIST") %>" name="CLASS_LIST"></td>
<td><input value="<%= rs.getInt("UNIT") %>" name="UNIT"></td>
<td><input value="<%= rs.getString("GRADE") %>" name="GRADE"></td>
<td><input type="submit" value="Update"></td>
</form>
<form action="degreerequirements.jsp" method="get">
<input type="hidden" value="delete" name="action">
<input type="hidden" value="<%= rs.getString("DEGREE_NAME") %>" name="DEGREE_NAME">
<input type="hidden" value="<%= rs.getString("DEPARTMENT_NAME") %>" name="DEPARTMENT_NAME">
<input type="hidden" value="<%= rs.getString("CATEGORY") %>" name="CATEGORY">

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