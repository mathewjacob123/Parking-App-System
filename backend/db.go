package main

import (
    "database/sql"
    "fmt"
    _ "github.com/go-sql-driver/mysql"
)

var db *sql.DB

func initDB() {
    var err error
    dsn := "root:root@tcp(127.0.0.1:3306)/parking_app" // Update with your MySQL credentials
    db, err = sql.Open("mysql", dsn)
    if err != nil {
        panic(fmt.Sprintf("Failed to connect to database: %v", err))
    }

    // Check if the connection is valid
    if err := db.Ping(); err != nil {
        panic(fmt.Sprintf("Database connection is not valid: %v", err))
    }

    fmt.Println("Database connection established")
}
