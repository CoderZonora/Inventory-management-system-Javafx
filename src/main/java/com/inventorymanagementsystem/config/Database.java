package com.inventorymanagementsystem.config;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.io.IOException;

public class Database {
    private static Database database = new Database();
    private static final String DB_URL = "jdbc:sqlite:inventory_management_system.db";
    private static final String SCHEMA_FILE = "database/inventory_management_system.sql";
    private static Connection globalConnection;
    private static final Object lock = new Object();

    private Database() {
        // Private constructor for singleton
    }

    public static Database getInstance() {
        return database;
    }

    public Connection connectDB() {
        synchronized (lock) {
            try {
                if (globalConnection == null || globalConnection.isClosed()) {
                    // Load SQLite driver
                    Class.forName("org.sqlite.JDBC");
                    
                    // Create the database file if it doesn't exist
                    globalConnection = DriverManager.getConnection(DB_URL);
                    
                    // Enable WAL mode and set busy timeout for better concurrent access
                    try (Statement stmt = globalConnection.createStatement()) {
                        stmt.execute("PRAGMA journal_mode=WAL");
                        stmt.execute("PRAGMA busy_timeout=30000");
                    }
                    
                    // Check if tables exist, if not initialize the database
                    if (!tablesExist(globalConnection)) {
                        initializeDatabase(globalConnection);
                    }
                }
                return globalConnection;
            } catch (Exception e) {
                throw new RuntimeException("Failed to connect to the database", e);
            }
        }
    }

    private boolean tablesExist(Connection conn) throws SQLException {
        DatabaseMetaData meta = conn.getMetaData();
        var rs = meta.getTables(null, null, "users", null);
        return rs.next(); // Returns true if the users table exists
    }

    private void initializeDatabase(Connection conn) {
        StringBuilder sql = new StringBuilder();
        
        // Get the absolute path to the schema file
        String schemaPath = Paths.get(SCHEMA_FILE).toAbsolutePath().toString();
        File schemaFile = new File(schemaPath);
        
        if (!schemaFile.exists()) {
            throw new RuntimeException("Schema file not found at: " + schemaPath);
        }

        // Read the SQL schema file
        try (BufferedReader br = new BufferedReader(new FileReader(schemaFile))) {
            String line;
            while ((line = br.readLine()) != null) {
                // Skip comments and empty lines
                if (!line.trim().startsWith("--") && !line.trim().isEmpty()) {
                    sql.append(line).append("\n");
                }
            }
        } catch (IOException e) {
            throw new RuntimeException("Error reading the schema file: " + e.getMessage(), e);
        }

        // Split the SQL statements (assuming they're separated by semicolons)
        String[] statements = sql.toString().split(";");

        // Execute each SQL statement
        try {
            conn.setAutoCommit(false);
            try (Statement stmt = conn.createStatement()) {
                for (String statement : statements) {
                    if (!statement.trim().isEmpty()) {
                        stmt.execute(statement.trim());
                    }
                }
                conn.commit();
                System.out.println("Database schema created successfully.");
            }
        } catch (SQLException e) {
            try {
                conn.rollback();
                throw new RuntimeException("Error executing the schema: " + e.getMessage(), e);
            } catch (SQLException ex) {
                throw new RuntimeException("Error rolling back database initialization", ex);
            }
        }
    }

    // Method to check if database needs to be initialized
    public void checkAndInitializeDatabase() {
        try (Connection tempConn = DriverManager.getConnection(DB_URL)) {
            if (!tablesExist(tempConn)) {
                initializeDatabase(tempConn);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to initialize database", e);
        }
    }

    // Add this method to properly close the connection when the application shuts down
    public void closeConnection() {
        synchronized (lock) {
            try {
                if (globalConnection != null && !globalConnection.isClosed()) {
                    globalConnection.close();
                    globalConnection = null;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}