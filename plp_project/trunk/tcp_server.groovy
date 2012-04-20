// a web server as a script (extension to cookbook)
 server = new ServerSocket(5001)
 while(true) {
     server.accept() { socket ->
         socket.withStreams { input, output ->
			 println "got connection"
             r = input.readLines()
			 println "$r"
         }
     }
 }
