/* arrayofstruct.c -- test of arrays of structures
   Mark Ardis, RHIT, 10/4/02
   Modified: Made changes to style and formatting 
            Archana Chidanandan, 3/28/2007
*/

#include "globals.h"

int 
 main() {

  PACKET *cmd_packet;  /* a pointer to a PACKET */
  PACKET five[5];     /* an array of 5 PACKETS */
  int i;              /* a counter for a for-loop */

  /* Since cmd_packet is just a pointer, we need to allocate memory for
     the packet that it points to.  We do NOT need to allocate memory
     for the array, since the declaration did that for us. */
  cmd_packet = (PACKET *) malloc (sizeof *cmd_packet);

  /* Initialize cmd_packet to some random values */
  cmd_packet->control = ACK;
  cmd_packet->sequence = 0;
  cmd_packet->loadsize = 10;
  strcpy(cmd_packet->data, "123456789");
  cmd_packet->checksum = 0;

  /* Print cmd_packet to see what we have so far */
  printf("cmd_packet::::::::::::::::\n");
  print_packet(cmd_packet);

  /* Assign each element of five to something like cmd_packet,
     but increment the sequence number for each element. */

  for (i = 0; i<5; i++) {
    /* We will copy cmd_packet field-by-field, to show how
       individual fields are referenced.  Note the syntax:
       five[i].<field> is an individual field in the structure.
       You can assign to it if it is a basic type like int or char,
       but not if it is a string. */
    five[i].control    = cmd_packet->control;
    five[i].sequence   = cmd_packet->sequence;
    five[i].loadsize   = cmd_packet->loadsize;
    /* You cannot assign string values, so use strcpy. */
    strcpy(five[i].data, cmd_packet->data);
    five[i].checksum   = cmd_packet->checksum;

    /* Print the five[i] packet.  Note that the print_packet function
       expects a pointer to a packet for an argument, so we have to
       use &five[i] to pass a pointer to five[i] */
    printf("::::::::::::::::five[%d]\n", i);
    print_packet(&five[i]);

    /* Increment the sequence number in cmd_packet */
    cmd_packet->sequence++;
  }

  printf("\nEnd of loop.\n\n");
  
  /* Change the sequence number in five[4] */
  five[4].sequence = 123;

  /* Here is a simpler way to assign a structure to a structure. 
     Note that this is NOT just changing cmd_packet to point to
     five[4], but assigning a new value to the packet pointed to 
     by cmd_packet. */
  *cmd_packet = five[4];

  /* Print cmd_packet to see what we get. */
  printf("cmd_packet::::::::::::::::\n");
  print_packet(cmd_packet);

  /* Change the sequence number in five[4] */
  five[4].sequence = 456;
  /* Print the five[4] packet. */
  printf("::::::::::::::::five[4]\n");
  print_packet(&five[4]);

  /* Print cmd_packet to show that it has not changed. */
  printf("cmd_packet::::::::::::::::\n");
  print_packet(cmd_packet);

  printf("\n=========================\n\n");

  /* Now change cmd_packet to POINT TO five[4]
     This means that changes to five[4] are also changes
     to the packet pointed to by cmd_packet. */
  cmd_packet = &five[4];

  /* Print cmd_packet to see what we have. */
  printf("cmd_packet::::::::::::::::\n");
  print_packet(cmd_packet);

  /* Change the sequence number in five[4] */
  five[4].sequence = 777;
  /* Print the five[4] packet. */
  printf("::::::::::::::::five[4]\n");
  print_packet(&five[4]);

  /* Print cmd_packet to show that it HAS changed. */
  printf("cmd_packet::::::::::::::::\n");
  print_packet(cmd_packet);

}
