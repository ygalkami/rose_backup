import groovy.swing.SwingBuilder
import java.awt.BorderLayout as BL
import java.awt.FlowLayout
import javax.swing.ScrollPaneConstants as SPC
import javax.swing.BorderFactory as BF

def createSocket(ip) {
    s = new Socket("137.112.149.148", 5000);
    println "Creating socket with ${ip}...";
}

def swing = new SwingBuilder()
def usernamelabel, iplabel

def frame = swing.frame(title:'Groove Chat Client', size:[500,400]) {
  borderLayout()
  panel(constraints:BL.NORTH, border:BF.createEmptyBorder(5, 8, 5, 8)) {
      gridLayout(rows:2, hgap:40)
      usernamelabel = label(text:"Username: ")
      iplabel = label(text:"IP to connect to: ")
      textField(id:'username', text:"User #1")
      textField(id:'otherUserIP', text:"")
  }
  
  panel(constraints:BL.CENTER, border:BF.createEmptyBorder(10, 8, 5, 8)) {
      borderLayout()
      scrollPane(verticalScrollBarPolicy:SPC.VERTICAL_SCROLLBAR_ALWAYS) {
          textArea(id:'conversation', autoscrolls:true, lineWrap:true, editable:false)
      }
  }

  panel(constraints:BL.SOUTH, border:BF.createEmptyBorder(5, 8, 5, 8)) {
      borderLayout()
      textField(id:'message',
                actionPerformed: {createSocket(otherUserIP.text);
                                  conversation.text += "${username.text}: ${message.text}\n";
                                  s.withStreams {input, output ->
                                      w = new PrintWriter(output)
                                      w << message.text; 
                                      w.flush();
                                      s.close();}
                                  })
  }
}

server = new ServerSocket(5000)
frame.show()

while(true) {
    server.accept() { socket ->
        socket.withStreams { input, output ->
                println "got connection"
            	r = input.readLines()
                println "$r"
				frame.conversation.add("$r", 0)
        }
    }
}
