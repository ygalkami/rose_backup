  This document describes the general setup for the VNS sr
  assignment.

  You will be assigned a topology by the script which looks like this:


                                            Application Server
                                        +====================+
                                        |                    |
                                        |  app_server_1_ip   |
                                        |                    |
                                        +====================+
                                                /
                                               /
                                              /
                    eth0:                    /
                     router_ip_eth0         /     eth1:   router_ip_eth1
                           +============(eth1)==+
                           |                    |
  internet =============(eth0)  Your Router     |
                           |                    |
                           +============(eth2)==+
                                            \    eth2:   router_ip_eth2
                                             \
                                              \
                                               \
                                        +====================+
                                        |                    |
                                        |  app_server_2_ip   |
                                        |                    |
                                        +====================+
                                           Application Server


  To connect to your topology, after compiling the stub code, invoke sr
  as follows:

  >./vns_load_balancer_client.py

 (You may need to change permissions before you can execute the script:
      >chmod 755 vns_load_balance_client.py
  ) 

  Your output upon connecting should look like this (the first entry
  will be the first application server, while the second will be the
  second application server):

 Loading routing table
 -----------------------------------------------------
 Destination     Gateway         Mask            Iface
 192.168.129.155 192.168.129.155 255.255.255.255 eth1
 192.168.129.157 192.168.129.157 255.255.255.255 eth2
 0.0.0.0         172.24.74.17    0.0.0.0         eth0
 -----------------------------------------------------
 Client ccollier connecting to Server vns-2:12345
 Requesting topology 999
 Router interfaces:
 eth0    HWaddr70:00:00:eb:00:01
 inet addr 192.168.129.153
 eth1    HWaddr70:00:00:eb:00:02
 inet addr 192.168.129.154
 eth2    HWaddr70:00:00:eb:00:06
 inet addr 192.168.129.156
 <-- Ready to process packets -->

 Please verify that you can see packets arriving to your topology when you
 try and ping one of your router interfaces.  To do this, connect to your topology
 as described above and try and ping eth0 (IP: router__ip_eth0).

 $ ping router_ip_eth0

 If you see output from sr that looks like:

 *** -> Received packet of length 60
 *** -> Received packet of length 60
 *** -> Received packet of length 60

 everything is working!  If not, please email vns-support@lists.stanford.edu.

Good Luck!
