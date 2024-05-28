<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Class</title>
</head>
<body>
    <form method="post" action="class_roster_report.jsp">
        <label for="courseID">Course:</label>
        <input type="text" name="courseId" id="courseId" required><br>

        <label for="quarter">Quarter:</label>
        <input type="text" name="quarter" id="quarter" required><br>

        <label for="year">Year:</label>
        <input type="text" name="year" id="year" required><br>

        <input type="submit" value="Get Roster">
    </form>
</body>
</html>
