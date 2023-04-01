package main

import (
	"io"
	"net/http"
    "fmt"
)

func main() {
    http.HandleFunc("/helloworld", func(w http.ResponseWriter, r *http.Request) {
        fmt.Println("Hello World is happening guys")
        io.WriteString(w, "Hello World!")
    })

    fmt.Println("Running server...")
    http.ListenAndServe(":8082", nil)
}
