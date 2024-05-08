import java.sql.*;

public class jdbc {
    public static void main(String[] args) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            // Load the PostgreSQL JDBC driver
            Class.forName("org.postgresql.Driver");

            // Establish connection to the database
            String url = "jdbc:postgresql://localhost:5432/CSE132B";
            String username = "postgres";
            String password = "Cyj020803!";
            connection = DriverManager.getConnection(url, username, password);
            String query = "SELECT * FROM faculty";
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                String title = resultSet.getString("Title");
                String facultyName = resultSet.getString("Faculty_Name");
                String department = resultSet.getString("Department");
                System.out.println("Title: " + title + ", Faculty Name: " + facultyName + ", Department: " + department);
            }
            // Connection successful, you can execute SQL queries here
            System.out.println("Connected to the PostgreSQL server successfully.");
        } catch (ClassNotFoundException e) {
            System.out.println("PostgreSQL JDBC Driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Connection to the PostgreSQL server failed.");
            e.printStackTrace();
        } finally {
            // Close the connection when done
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
