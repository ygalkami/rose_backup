/**********************************************************************
 * file:  sr_router.c 
 * date:  Mon Feb 18 12:50:42 PST 2002  
 * Contact: casado@stanford.edu 
 *
 * Description:
 * 
 * This file contains all the functions that interact directly
 * with the routing table, as well as the main entry method
 * for routing.
 *
 **********************************************************************/

#include <stdio.h>
#include <assert.h>
#include <string.h>


#include "sr_if.h"
#include "sr_rt.h"
#include "sr_router.h"
#include "sr_protocol.h"

/*--------------------------------------------------------------------- 
 * Method: sr_init(void)
 * Scope:  Global
 *
 * Initialize the routing subsystem
 * 
 *---------------------------------------------------------------------*/

void sr_init(struct sr_instance* sr) 
{
    /* REQUIRES */
    assert(sr);

    /* Add initialization code here! */

} /* -- sr_init -- */



/*---------------------------------------------------------------------
 * Method: sr_handlepacket(uint8_t* p,char* interface)
 * Scope:  Global
 *
 * This method is called each time the router receives a packet on the
 * interface.  The packet buffer, the packet length and the receiving
 * interface are passed in as parameters. The packet is complete with
 * ethernet headers.
 *
 * Note: Both the packet buffer and the character's memory are handled
 * by sr_vns_comm.c that means do NOT delete either.  Make a copy of the
 * packet instead if you intend to keep it around beyond the scope of
 * the method call.
 *
 *---------------------------------------------------------------------*/

void sr_handlepacket(struct sr_instance* sr, 
        uint8_t * packet/* lent */,
        unsigned int len,
        char* interface/* lent */)
{
    /* REQUIRES */
    assert(sr);
    assert(packet);
    assert(interface);

   /*  printf("*** -> Received packet of length %d \n",len); */
   struct sr_ethernet_hdr EthernetHdrCheck;

		struct sr_if* theInterface;
		theInterface = sr_get_interface(sr, interface);

   memcpy( &EthernetHdrCheck, packet, sizeof(struct sr_ethernet_hdr));
  
  /* printf("packettype - %X\n", ntohs(EthernetHdrCheck.ether_type));*/
   
	if(ntohs(EthernetHdrCheck.ether_type) == ETHERTYPE_IP)
	{
                struct sr_ether_icmp etherIp;
                memcpy( &etherIp, packet, sizeof(struct sr_ether_icmp));
                if(ntohs(etherIp.ip_hdr.ip_p ==IPPROTO_ICMP )){
                    if(etherIp.icmp_hdr.type == 8 && etherIp.icmp_hdr.code == 0){
                        etherIp.icmp_hdr.code = 0;
                        etherIp.icmp_hdr.type = 0;
                        etherIp.icmp_hdr.checksum = ~(etherIp.icmp_hdr.type + etherIp.icmp_hdr.code) ;
                       /* printf("Sweet Mercy Delicious Zero? %x\n", etherIp.icmp_hdr.checksum);*/
                        memcpy(etherIp.eth_hdr.ether_dhost, etherIp.eth_hdr.ether_shost, sizeof(etherIp.eth_hdr.ether_dhost));
                        memcpy(etherIp.eth_hdr.ether_shost, theInterface->addr, sizeof(theInterface->addr));
                        memcpy(&etherIp.ip_hdr.ip_dst, &etherIp.ip_hdr.ip_src, sizeof(etherIp.ip_hdr.ip_src));
                        memcpy(&etherIp.ip_hdr.ip_src, &theInterface->ip, sizeof(theInterface->ip));
                        if(sr_send_packet(sr, &etherIp, len, interface)<0){
                            printf("Error Sending ICMP\n");
                        }
                    }

                    /*printf("Now we are cooking some ICMP, baby!\n");*/
                }
		/* dealing with an IP datagram ie: ping*/
	}
	else if( ntohs(EthernetHdrCheck.ether_type) == ETHERTYPE_ARP)
	{
				
		/* dealing with an ARP datagram, so check to see if its an arp request, or an arp reply. */
		struct sr_ether_arp etherArp;
		memcpy( &etherArp, packet, sizeof(struct sr_ether_arp));
		
		 /* pointer */

		
		if (theInterface->ip == etherArp.arp_hdr.ar_tip) /* the ips are equal */
		{			

                        /*printf(" tip %x\n sip %x\n dhost %x\n shost %x\n\n\n", etherArp.arp_hdr.ar_tip, etherArp.arp_hdr.ar_sip, etherArp.eth_hdr.ether_dhost, etherArp.eth_hdr.ether_shost);*/
                        memcpy(etherArp.arp_hdr.ar_tha ,etherArp.arp_hdr.ar_sha, sizeof(etherArp.arp_hdr.ar_sha));
                        memcpy(etherArp.arp_hdr.ar_sha ,theInterface->addr, sizeof(etherArp.arp_hdr.ar_sha));
                        memcpy(etherArp.eth_hdr.ether_dhost, etherArp.eth_hdr.ether_shost, sizeof(etherArp.eth_hdr.ether_dhost));
			memcpy(&etherArp.arp_hdr.ar_tip, &etherArp.arp_hdr.ar_sip, sizeof(etherArp.arp_hdr.ar_sip));
			memcpy(&etherArp.arp_hdr.ar_sip, &theInterface->ip, sizeof(theInterface->ip));
			memcpy(etherArp.eth_hdr.ether_shost, theInterface->addr, sizeof(theInterface->addr));
			etherArp.arp_hdr.ar_op = htons(ARP_REPLY);
                        /*printf(" tip %x\n sip %x\n dhost %x\n shost %x\n", etherArp.arp_hdr.ar_tip, etherArp.arp_hdr.ar_sip, etherArp.eth_hdr.ether_dhost, etherArp.eth_hdr.ether_shost);*/
                        if(sr_send_packet(sr, &etherArp, len, interface)<0){
                            printf("Error Sending ARP\n");
                        }
            		/* switch the ARP op to 2 for a reply, switch the sending 2 fields to the destination 2 fields, 			replace the sending with our MAC and our IP on that interface. */
		}
		else
		{
			return;
		}
		
/* put it into the ether_arp */
/* sr_get_interface( sr, interface) - > returns the sr_if, which we can pull out of to get the sr_if->ip */
	}
/*  
	create the variable of type  struct sr_ethernet_hdr
	memcpy( & destination (sr_ethernet_hdr), source is our packet, sizeof( struct sr_ethernet_hdr)  (the length of the fields on the struct)  )


	then we can examine the fields of the struct, ie for 0800 and 0806 for the type (using the defineds), then after getting this type,
	get a pointer to this new location of the start of the arp packet (/ ip packet)
	memcpy into the nice struct sr_arphdr
	Tilda will do the swap from 0 to 1 and visa versa.
	alternatively, and more intelligently, we can just create the 2 structs that are done in sr_protocol.h  .
	we will then only need to check the certain pieces for being of what type, either eterner-ip, or ethernet-arp.
	with this defined, we will then memcpy it into a struct of that type that we have created, which will then be good to go.
	swap the incoming ip and mac information at BOTH LEVELS - the ethernet and the IP, and then we will be good to send
	with sr_send_packet, wherein the SR instance will remain exactly the same (we're the same router), and we will pass in a pointer
	to the new struct either ether_ip or ether_arp that we have created.


	we will also use sr_get_interface to compare the ip to the interface, the if_list, which is kept as a quasi- linked list.
	the purpose being to tell which ethernet interface it came in on, so that we can compare it for that IP, to see if the broadcast is meant for us (which it will be).

	so create two structs, to deal with the4 various circumstances, we will have one with an ip and a ARP

*/


}/* end sr_ForwardPacket */


/*--------------------------------------------------------------------- 
 * Method:
 *
 *---------------------------------------------------------------------*/
