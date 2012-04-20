/* globals.h -- includes and global def.s for ftp-like application
   Mark Ardis, RHIT, 9/4/2002
   Changed 10/8/2002 - fixed bug in PrintPacket
   Changed 03/14/2007 - Moved implementations to C source file. 
					  - Converted to GNU C coding standards.
*/

/* LIBRARIES ========================================  */

#include <arpa/inet.h>
#include <dirent.h>
#include <errno.h>
#include <netdb.h>
#include <signal.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

/* CONSTANTS ======================================== */

#define DEFAULTPORT 5555 /* Default port for socket connection */
#define LOADSIZE 30      /* Size of packet data area in bytes */

/* TYPES ======================================== */

typedef enum {ACK, DATA, ECHO, GET, PUT, RETR} packettype;

/*  transmission unit for this application's protocol */
typedef struct
{
  packettype  control;         /* type of packet */
  int         sequence;        /* packet's sequence number */
  int         loadsize;        /* amount of data (in bytes) in packet */
  char        data[LOADSIZE];  /* holds data */
  int         checksum;        /* for error detection */
} PACKET;                                                     


/* USEFUL UTILITY FUNCTIONS ======================================== */

/* print_packet - print the contents of a packet */
void 
print_packet(PACKET *packet);

/* print_sock_addr - print a socket address */
void 
print_sock_addr(struct sockaddr_in *addr);

/* print_datagram - print the contents of an entire datagram */
void 
print_datagram(PACKET *packet, struct sockaddr_in *addr);

