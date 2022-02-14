package main

import (
    "flag"
    "fmt"
    "log"
    "net"
)

var (
    port int
)

func init() {
    flag.IntVar(&port, "port", 8080, "tcp port")
}

func main() {
    flag.Parse()
    listener, err := net.Listen("tcp", fmt.Sprintf(":%v", port))
    if err != nil {
        // Use fatal to exit if the listener fails to start
        log.Fatal(err)
    }
    defer listener.Close()

    log.Printf("tcp server started successfully, listen on port: %v\n", port)
    for {
        _, err := listener.Accept()
        if err != nil {
            // Print the error using a log.Fatal would exit the server
            log.Println(err)
        }
    }
}
