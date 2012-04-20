server = new ServerSocket(5000)
while(true) {
    server.accept() { socket ->
        socket.withStreams { input, output ->
            w = new PrintWriter(output)
            w << "What is your name? "
            w.flush()
            r = input.readLine()
            System.err.println "User responded with $r"
            w.close()
        }
    }
}
