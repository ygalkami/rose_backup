import groovy.swing.SwingBuilder

import java.awt.Color
import javax.swing.JFrame
import java.awt.GridLayout
import java.awt.FlowLayout
import java.awt.BorderLayout as BL
import javax.swing.BorderFactory as BF
import javax.swing.JFileChooser
import javax.swing.JSplitPane
import javax.swing.JTextArea
import java.util.Date
import java.text.DateFormat
import java.text.SimpleDateFormat

def createSocket(ip) {
    s = new Socket("${ip}", 5000);
    println "Creating socket with ${ip}...";
}

def getDateTime() {
    DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
    Date date = new Date();
    return dateFormat.format(date);
}

swing = new SwingBuilder()
JTextArea messageArea
SwingBuilder.build {
    myFrame = frame(title: 'Groove Chat Client', pack: true, size: [400,300]) {
      lookAndFeel("system")
      
      runAction = action(
          name:'Run',
          closure: {runScript()},
          mnemonic: 'R',
          keyStroke: 'ctrl ENTER',
          accelerator: 'ctrl R'
      )
      
      testAction = action(
          name:'abc',
          closure: {testitup(messageArea.text); messageArea.text = "";},
          mnemonic: 'T',
          keyStroke: 'shift ENTER',
          accelerator: 'shift T'
      )
      
      // Create the menu
      menuBar {
          menu(text:'Conversation', mnemonic: 'C') {
              menuItem {
                  action(name:'Send File', mnemonic: 'F', accelerator:'ctrl F', closure:{sendFile(myFrame)})
              }
              separator()
              menuItem {
                  action(name:'Close', mnemonic:'W', accelerator:'ctrl W', closure:{System.exit(0)})
              }
          }
          menu(text:'Help', mnemonic:'H') {
              menuItem {
                  action(name:'About', mnemonic:'A', closure:{showAbout(myFrame)})
              }
          }

      }
      
      // Setup the rest of the chat interface
      borderLayout()
      panel(constraints:BL.NORTH, border:BF.createEmptyBorder(5, 5, 5, 5)) {
          gridLayout(rows:2, hgap:40)
          usernamelabel = label(text:"Username: ")
          iplabel = label(text:"IP to connect to: ")
          textField(id:'username', text:"User #1")
          textField(id:'otherUserIP', text:"")
      }
      
      splitPane(orientation:JSplitPane.VERTICAL_SPLIT, dividerLocation:280) {
          def lazyPanelsParent
          scrollPane(constraints: "center", preferredSize: [400, 300]) {
              lazyPanelsParent = panel(layout: new GridLayout(1,1,1,1)) {}
          }
          buildInTheBackground(lazyPanelsParent)
          
          scrollPane(constraints: "bottom") {
              messageArea = textArea() { action(testAction) }
          }
      }

/*      panel(border:BF.createEmptyBorder(5, 5, 5, 5)) {
      borderLayout()
      textField(id:'message',
                actionPerformed: {createSocket(otherUserIP.text);
                                  s.withStreams {input, output ->
                                      w = new PrintWriter(output)
                                      w << "(" + getDateTime() + ") " + username.text + ": " + message.text;
                                      w.flush();
                                      s.close();}

                                  createSocket("127.0.0.1");
                                  s.withStreams {input, output ->
                                      w = new PrintWriter(output)
                                      w << "(" + getDateTime() + ") " + username.text + ": " + message.text;
                                      w.flush();
                                      s.close();}
                                  
                                  message.text = ""; //clear for a new message to be typed
                                  })
          }*/
    }
    myFrame.show()
}


/**
 * Create a Swing panel in the background using SwingBuilder.
 * This can be called from any thread.
 */
def buildInTheBackground(parentPanel) {
    // If we are not already on the EDT, static SwingBuilder.build(Closure) will do that for us.
    // In the case of an event handler like the actionPerformed for the button, then naturally
    // we're on the EDT already and the building will continue immediately.
    SwingBuilder.build {
        def statusMessage = textArea(editable: false, lineWrap: true,
                                     border: lineBorder(color:Color.GRAY, thickness:3))

        // Notice that the parameter to setStatus() is declared as String.
        // That way if code uses a GString it gets rendered at the time (and on the
        // thread) of the call.  If we don't do that then it might get deferred,
        // by which time the results that the GString will produce may change and
        // could be in a race (results varying with execution order and maybe invalid).
        // Also the context here is that the caller is the work environment and that
        // operations on the EDT are to be quick and determinate for display only.

        def setStatus = { String msg -> println msg; statusMessage.text += (msg.substring(1,(msg.size()-1)) + "\n")}

        // Put the message at the top of the list if we use index = 0.
        // Use plain parentPanel.add(statusMessage) if you want the end of the list.
        parentPanel.add(statusMessage, 0)

        // Component.validate() must be called after any changes that affect layout
        // on realized (shown) AWT/Swing trees.
        parentPanel.validate()

        doOutside {
            // Now we're off on our own thread.

            // To change the display, be sure to run that code on the EDT

            server = new ServerSocket(5000)

            while(true) {
                server.accept() {socket ->
                    socket.withStreams { input, output ->
                            println "got connection"
                            r = input.readLines()
                            edt { setStatus("$r") }
                    }
                }
            }

            edt { setStatus("New panel ready") }

            // Back to the EDT for fiddling with the Swing tree.

            doLater {
                setStatus("Adding new panel")

                // We're gonna remove the widget used for the new panel's progress indication.
                // An alternate (and simpler) way to get this effect is to put the status
                // in a panel that doesn't get removed.  But this method is shown because
                // it is fairly general in that the status indicator can have a utility
                // layout that gets removed when done and so doesn't impact the customized
                // structure desired for the application.

                // We may not be the zeroth child (beginning of list) anymore.
                // (Or end of list either, if that's where we started.)
                def idx = (parentPanel.components as List).indexOf(statusMessage)
                parentPanel.remove(idx)
                parentPanel.add(newPanel, idx)
                parentPanel.validate()

                setStatus("Built")
            }
        }
    }
}


/**
 * Actions for the menu elements.
 */
def sendFile(Frame) {
    scriptFile = selectFilename(Frame);
    if (scriptFile != null) {
        // do stuff here to send files
        // from example: inputArea.text = scriptFile.readLines().join('\n');
    }
}

def selectFilename(Frame, name = "Open") {
    def fc = new JFileChooser()
    fc.fileSelectionMode = JFileChooser.FILES_ONLY
    fc.acceptAllFileFilterUsed = true
    if (fc.showDialog(Frame, name) == JFileChooser.APPROVE_OPTION) {
        return fc.selectedFile
    } else {
        return null
    }
}

def showAbout(Frame) {
    def pane = swing.optionPane(message:'Welcome to the Groove Chat Client!\n\nWritten by David Pick, Mark Jenne, Patrick Nowicki\n');
    def dialog = pane.createDialog(Frame, 'About Groove Chat');
    dialog.show();
}

def runScript() {
    println "omg?";
}

def testitup(text) {
    println "line break";
    println "message: " + text;
}