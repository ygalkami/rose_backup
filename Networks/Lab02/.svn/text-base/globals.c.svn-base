#include "globals.h"


/* USEFUL UTILITY FUNCTIONS ======================================== */

/* print_packet - print the contents of a packet */
void 
print_packet(PACKET *packet)
{
  char cstr[20];
  int i;

  switch (packet->control) {
  case ACK:
    strcpy(cstr, "ACK");
    break;
  case DATA:
    strcpy(cstr, "DATA");
    break;
  case ECHO:
    strcpy(cstr, "ECHO");
    break;
  case GET:
    strcpy(cstr, "GET");
    break;
  case PUT:
    strcpy(cstr, "PUT");
    break;
  case RETR:
    strcpy(cstr, "RETR");
    break;
  }
  printf("=====Packet: \n");
  printf("control:%s:\n", cstr);
  printf("sequence:%d:\n", packet->sequence);
  printf("loadsize:%d:\n", packet->loadsize);
  printf("data:");
  i = 0;
  while (i < packet->loadsize) {
    printf("%c", packet->data[i]);
    i++;
  }
  printf(":\n");
  printf("checksum:%d:\n", packet->checksum);
  printf("=====End of packet.\n");
}

/* print_sock_addr - print a socket address */
void 
print_sock_addr(struct sockaddr_in *addr)
{
  printf("socket address family:%d:\n", addr->sin_family);
  printf("socket address port:%d:\n", addr->sin_port);
  printf("socket address IP address:%d:\n", addr->sin_addr.s_addr);
}

/* print_datagram - print the contents of an entire datagram */
void 
print_datagram(PACKET *packet, struct sockaddr_in *addr)
{
  print_packet(packet);
  print_sock_addr(addr);
}
