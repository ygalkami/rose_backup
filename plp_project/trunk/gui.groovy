import groovy.swing.SwingBuilder
import java.awt.BorderLayout as BL
import java.awt.FlowLayout

def swing = new SwingBuilder()
count = 0

def createSocket() {
    s = new Socket("137.112.150.181", 5000);
    }

def textlabel
def frame = swing.frame(title:'Groove Chat Client', size:[300,300]) {
  borderLayout()
  panel(constraints:BL.NORTH) {
      flowLayout(alignment:FlowLayout.CENTER)
      textlabel = label(text:"Click the button!")
      button(text:'Click Me',
             actionPerformed: {count++; textlabel.text = "Clicked ${count} time(s)."; println "clicked"})
  }
  
  panel(constraints:BL.CENTER) {
      borderLayout()
      scrollPane() {textArea(id:'conversation', autoscrolls:true)}
  }

  panel(constraints:BL.SOUTH) {
      flowLayout()
      textField(id:'message', columns:25)
      button(text:'Send',
             actionPerformed: {createSocket();
                               println "Sending message: ${message.text}";
                               conversation.text += "me: ${message.text}\n";
                               s.withStreams {input, output ->
                                   w = new PrintWriter(output)
                                   w << message.text; 
                                   w.flush();
                                   s.close();}})
  }
}
frame.show()