def host = 'http://www.comitservices.com/ip.php'
try {
  def results = new URL(host).getText()
  println "According to '${host}', this computer's IP address is: ${results}"
} catch (Exception e) {
  println "Sorry, there was a problem connecting to: ${host}: ${e.toString()}"
}
