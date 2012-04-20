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
      printf("Do you want to download a file (yes/no): ");
      scanf("%s", input_string);
      
      if (strcmp(input_string, ".") == 0)
        exit(1);
      
      if (strcmp(input_string, "no") == 0) {
        printf("Do you want to echo a string (yes/no)? ");
        scanf("%s", input_string);
        
        if(strcmp(input_string, "no") == 0) {
          //exit(1);
          break;
        }
        
        if(strcmp(input_string, ".") == 0)
          exit(1);
        
        printf("Enter a string to send to the sever: ");
        scanf("%s", input_string);
        
        if (strcmp(input_string, ".") == 0)
          exit(1);
          
        cmd_packet->control = ECHO;
        cmd_packet->loadsize = strlen(input_string);
        strcpy(cmd_packet->data, input_string);
        
        if (sendto(sock, cmd_packet, sizeof(*cmd_packet), 0, (struct sockaddr*) &serv_addr, sizeof(serv_addr)) <= 0) {
          die_with_error("Send Error");
        }
        
        if (recvfrom(sock, cmd_packet, sizeof(*cmd_packet), 0, (struct sockaddr*) &serv_addr, &recv_addr_len) <= 0) {
          die_with_error("recvfrom() failed");
        }
        
        printf("Recived String: %s\n", cmd_packet->data);
      } else {
      
      printf("What file would you like to download? ");
      scanf("%s", input_string);
      
      /* If no more input, quit */
      if (strcmp(input_string, ".") == 0)
        exit(1);

      /* Send the string to the server to be echoed */
      cmd_packet->control = GET;
      strcpy(cmd_packet->data, input_string);
      cmd_packet->loadsize = strlen(cmd_packet->data);
      cmd_packet->sequence = 0;
      /* ... more to do here */
      
      sendto(sock, cmd_packet, sizeof(*cmd_packet), 0, (struct sockaddr*) &serv_addr, sizeof(serv_addr));
      
      while (!done) {
        if (recvfrom(sock, res_packet, sizeof (*res_packet), 0, (struct sockaddr *) &serv_addr, &recv_addr_len) <= 0) {
          die_with_error("recvfrom() failed");
        }
        
        if (res_packet->control == ACK) {
          FILE *outFile;
          int i = 0;
          outFile = fopen(input_string, "w");
          if (outFile == NULL) {
            die_with_error("Failed to open the output file, check filename.\n");
          }
          
          for (i = 0; i < entries; i++) {
            print_packet((returned_packet_array + i));
            printf("\n");
            fprintf(outFile, "%s", (returned_packet_array + i)->data);
            done = 1;
          }
          fclose(outFile);
        } else if (res_packet->control == DATA) {
          *(returned_packet_array + entries) = *res_packet;
          entries++;
        }
        
        if ((res_packet->sequence + 1) % 5 == 0) {
          //cmd_packet = (PACKET *) malloc (sizeof *cmd_packet);
          cmd_packet->control = ACK;
          cmd_packet->sequence = res_packet->sequence;
          if (sendto(sock, cmd_packet, sizeof *cmd_packet, 0, (struct sockaddr *) &serv_addr, sizeof (serv_addr)) <= 0) {
            die_with_error("ACK send error");
          }
        }
        }      
      }
    }

    close(sock);
    exit(0);
}


