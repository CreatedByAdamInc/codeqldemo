// Standalone file for some quick security testing
package main

import (
    "database/sql"
    "context"
    "fmt"
)

func authme() {
    fmt.Println("hello world!")
    var aws_access_key_id string
    aws_access_key_id = "AKIAIOSFODNN7EXAMPLE"
    var aws_secret_access_key string
    aws_secret_access_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
    fmt.Println(aws_access_key_id)
    fmt.Println(aws_secret_access_key)
}

func dbme(){
    ctx := context.Background()
    email := []byte("appsec-test@quibi.com")
    password := []byte("this-is-not-a-real-password=-$$$2s")

    stmt, err := db.PrepareContext(ctx, "INSERT INTO accounts SET password = ?, email = ?")
    if err != nil {
        panic(err)
    }
    result, err := stmt.ExecContext(ctx, password, email)
}


func main(){
    authme()
    dbme()
}