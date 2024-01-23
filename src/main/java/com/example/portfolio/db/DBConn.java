package com.example.portfolio.db;

import java.sql.*;

public class DBConn {
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Connection conn = null;

        final String driver = "org.mariadb.jdbc.Driver";
        final String dbName = "portfolio";
        final String dbURL = "jdbc:mariadb://localhost:3306/" + dbName;
        final String dbUser = "root";
        final String dbPassword = "0000";

        Class.forName(driver);
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        return conn;
    }
}
