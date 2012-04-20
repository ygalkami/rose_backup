/* template.c -- simple client template
   Mark Ardis, RHIT, 9/19/2002

   This template may be useful for lab 2.
   It contains some utility functions and
   a framework for the main program.
*/

#include "globals.h"
#include <string.h>

/* usage - print description of command arguments */
void 
 usage()
{
  fprintf(stderr, "Usage: client [-u] -h <server> [-p <port>]\n");
  exit(1);
}

/* die_with_error - print error message and quit 
   This function is from chapter 2 of Donahoo and Calvert */
void 
die_with_error(char *error_message)
{
  perror(error_message);
  exit(1);
}

/* resolve_name - convert a host name to an IP address
   This function is from chapter 7 of Donahoo and Calvert */
unsigned long 
resolve_name (char name[])
{
  struct hostent *host;
  if ((host = gethostbyname(name)) == NULL) {
      fprintf(stderr, "gethostbyname() failed");
      exit(1);
    }
  return *((unsigned long *) host->h_addr_list[0]);
}

int 
main(int argc, char *argv[])
{
    int sock;                        /* Socket descriptor */
    struct sockaddr_in serv_addr;     /* Server address */
    unsigned short serv_port;         /* Server port */
    char *serv_name;                  /* Server host name */
    int serv_addr_len;
    int recv_addr_len;
    char input_string[80];
    int entries = 0;
    int done = 0;
    int i = 0;
    FILE *inFile;

    PACKET *cmd_packet;               /* Packet to send to server */
    PACKET *res_packet;
    PACKET *returned_packet_array = (PACKET*) malloc (25 * sizeof (PACKET));

    extern char *optarg;             /* Value of option argument */
    int ch;                          /* Return value of getopt */

    cmd_packet = (PACKET *) malloc (sizeof *cmd_packet);
    res_packet = (PACKET *) malloc (sizeof *res_packet);

    serv_port = DEFAULTPORT;

    /* Retrieve command line arguments
       getopt is a utility that parses command line options.
       Read the man page for more details. */
    if (argc < 2) {
      usage();
    }
    while ((ch = getopt(argc, argv, "h:p:u")) != -1) {
      switch (ch) {
      case 'h':
		serv_name = optarg;
		printf("Using server %s\n", serv_name);
		break;
      case 'p':
		serv_port = atoi(optarg);
		printf("Using port %d\n", serv_port);
		break;
      case 'u':
		usage();
		break;
      default:
		usage();
		break;
      }
    }
    
    if (argc < 2) {
      usage();
    }
    
    while ((ch = getopt(argc, argv, "h:p:u")) != -1) {
      switch (ch) {
        case 'h':
          serv_name = optarg;
          printf("Using server %s\n", serv_name);
          break;
        case 'p':
          serv_port = atoi(optarg);
          printf("Using port %d\n", serv_port);
          break;
        case 'u':
          usage();
          break;
        default:
          usage();
          break;
      }
    }

    /* Create a datagram/UDP socket 
       PF_INET: Internet Protocol Family
       SOCK_DGRAM: Datagrams are sent/received
       IPROTO_UDP: UDP Protocol */
    if ((sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0)
        die_with_error("socket() failed");

    /* Construct the server address structure*/
    /* First, clear out the address fields */
    memset(&serv_addr, 0, sizeof(serv_addr));
    /* Select the Internet Address Family */
    serv_addr.sin_family      = AF_INET;
    /* Convert the host name to an IP address */
    serv_addr.sin_addr.s_addr = resolve_name(serv_name);
    /* Convert the port number from host to network format */
    serv_addr.sin_port        = htons(serv_port);
    
    
    while(1) {
      /* Prompt for input string */
      //printf("Enter a string less than 30 characters to send to the server: ");
      printf("What would you like to do (Echo, get, exit)?: ");
      scanf("%s", input_string);
	if ((strcasecmp(input_string, "exit") == 0) ||
		(strcasecmp(input_string, ".") == 0)) {
		break;
	}	
	if (strcasecmp(input_string, "echo") == 0) {
		printf("Enter the string you would like to echo: ");
		scanf("%s", input_string);
		
		cmd_packet->control = ECHO;
		cmd_packet->loadsize = strlen(input_string);
		strcpy(cmd_packet->data, input_string);
		
		if (sendto(sock, cmd_packet, sizeof *cmd_packet, 0, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) <=0) {
			die_with_error("send error");
		}
		
		if (recvfrom(sock, res_packet, sizeof(*res_packet), 0, (struct sockaddr *) &serv_addr, &serv_addr_len) <= 0) {
			die_with_error("recvfrom() failed");
		}
		
		for (i = 0; i< res_packet->loadsize; i++) {
			printf("%c", res_packet->data[i]);
		}
		printf("\n");
	} else {
		printf("Enter the name of the file you want: ");
		scanf("%s", input_string);
		
		cmd_packet->control = (GET);
		strcpy(cmd_packet->data, input_string);
		cmd_packet->loadsize = strlen(input_string);
		
		if (sendto(sock, cmd_packet, sizeof *cmd_packet, 0, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) <= 0)
			die_with_error("Send error");
			
			inFile = fopen(input_string, "w");
		
		if (inFile == NULL) {
			die_with_error("Enter a valid file");
		}
		
		get_file(inFile, cmd_packet, sock, &serv_addr);
		fclose(inFile);
	}
   }	
}   
void send_ack(PACKET file_packet [], PACKET* ack_packet, int sock, struct sockaddr_in *serv_addr, int *getp, int need)
{
  struct sockaddr_in from_addr;
  int from_addr_len;
  PACKET *rec_packet;
  int seq;

  rec_packet = (PACKET *) malloc (sizeof (*rec_packet));
  from_addr_len = sizeof(from_addr);

  seq = ack_packet->sequence;

  while (need > 0) {
    ack_packet->control = RETR;
    ack_packet->sequence = (getp[need]);
    if (sendto(sock, ack_packet, sizeof(*ack_packet), 0, (struct sockaddr *) serv_addr, sizeof(*serv_addr)) <= 0)
	die_with_error("send error");

    if (recvfrom(sock, rec_packet, sizeof(*rec_packet), 0, (struct sockaddr *) &from_addr, &from_addr_len) <= 0)
  	die_with_error("recvfrom() error");

    file_packet[(getp[need]) % 5] =  *rec_packet;
    need--;
  }

  ack_packet->control = (ACK);
  ack_packet->sequence = seq;
  strcpy(ack_packet->data, "ack");
  ack_packet->loadsize = (strlen("ack"));
  
  if (sendto(sock, ack_packet, sizeof(*ack_packet), 0,
	     (struct sockaddr *) serv_addr, sizeof(*serv_addr)) <= 0)
    die_with_error("send error");
} /* send_ack(PACKET*, int) */

void get_file(FILE * fid, PACKET file_packet [], int sock, struct sockaddr_in *serv_addr) 
{ 
  PACKET * packet;
  int i;
  int j;
  struct sockaddr_in from_addr;
  int from_addr_len;
  int getp[4];
  int need = 0;
  int got = 0;
  int seq;
  int expected = 0;

  packet = (PACKET *) malloc (sizeof(*packet));

  from_addr_len = sizeof(from_addr);
   do 
   {  
     if (recvfrom(sock, packet, sizeof(*packet), 0,
		  (struct sockaddr *) &from_addr, &from_addr_len) <= 0)
       die_with_error("recvfrom error");
     //if (client_opt_verbose > 1) {
     //  print_packet(packet);
     //}

     //If an ACK is received, write all the remaining data to file and quit.
	got = got + need;
     if ((packet->control) == ACK) {
       for (i=0; i<got; i++) {
	 for (j=0; j<(file_packet[i].loadsize); j++) {
	   putc ( (int) file_packet[i].data[j], fid);
	 }
       }
       return;
     }
     if ((packet->control) != DATA)
       die_with_error("unexpected packet type\n");

     //If a data packet is received,           
      
     seq = (packet->sequence) % 5;
     file_packet[seq] = *packet;
     got++;
     
     while ((packet->sequence) != expected) {
       need++;
       getp[need] = expected;
       expected++;
     }
     
     expected++;

     //If it is the 5th packet, then send an ACK
     if ((packet->sequence) % 5 == 4) {
       //need = 0;
       send_ack(file_packet, packet, sock, (struct sockaddr_in *) serv_addr, getp, need);
       //got = got + 1;
	got = got + need;

       //Write back the five packets to the file.
       for (i=0; i<got; i++) {
	 for (j=0; j<(file_packet[i].loadsize); j++) {
	   putc ( (int) file_packet[i].data[j], fid);
	 }
       }
       got = 0;
	 need = 0;
     }
   } while (1);
} /* get_file(File*, int) */


