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
#include <stdlib.h>


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
uint16_t sr_inet_checksum(uint8_t* buf/*borrowed*/, uint32_t len);
int arp_entries = 0;

void sr_init(struct sr_instance* sr) {
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
        char* interface/* lent */) {
    /* REQUIRES */
    assert(sr);
    assert(packet);
    assert(interface);

    /*  printf("*** -> Received packet of length %d \n",len); */
    struct sr_ethernet_hdr EthernetHdrCheck;

    struct sr_if* theInterface;
    theInterface = sr_get_interface(sr, interface);

    struct sr_if* eth0;
    eth0 = sr_get_interface(sr, "eth0");

    struct sr_if* eth1;
    eth1 = sr_get_interface(sr, "eth1");

    struct sr_if* eth2;
    eth2 = sr_get_interface(sr, "eth2");

    /*used for ICMP */
    uint8_t *myPacket = malloc(70);
    uint8_t *fail = malloc(28);
    memcpy(fail, packet + sizeof (struct sr_ethernet_hdr), 28);

    struct sr_ether_icmp etherIcmpHost;
    memcpy(&etherIcmpHost, packet, sizeof (etherIcmpHost));

    memcpy(&EthernetHdrCheck, packet, sizeof (struct sr_ethernet_hdr));
    /* fprintf(stderr,"RAWR"); */

    if (ntohs(EthernetHdrCheck.ether_type) == ETHERTYPE_IP) {
        struct sr_ether_ip etherIsItIp;
        memcpy(&etherIsItIp, packet, sizeof (struct sr_ether_ip));

        /*check whether we need forwarding*/
        if (!(etherIsItIp.ip_hdr.ip_dst == eth0->ip || (etherIsItIp.ip_hdr.ip_dst) == eth1->ip || (etherIsItIp.ip_hdr.ip_dst) == eth2->ip)) {

            /*Forward the packet, its not for us*/
            struct table_entry check_entry = ArpContains(etherIsItIp.ip_hdr.ip_dst);
            printf("Arp contains data:");
            DebugMAC(check_entry.addr);
            if (check_entry.ip == etherIsItIp.ip_hdr.ip_dst) {
                printf("\nReady to forward packets.\n");

                /*add packet to be forwarded data to the ARPtable*/
                memcpy(ArpTable[arp_entries].addr, etherIsItIp.eth_hdr.ether_shost, ETHER_ADDR_LEN);
                memcpy(&(ArpTable[arp_entries].ip), &etherIsItIp.ip_hdr.ip_src, sizeof (etherIsItIp.ip_hdr.ip_src));
                arp_entries++;

                /*get a new interface*/
                struct sr_if* forwardInterface;
                forwardInterface = sr_get_interface(sr, getForwardingEthernet(etherIsItIp.ip_hdr.ip_src, sr->routing_table));

                /*change IP fields*/
                memcpy(etherIsItIp.eth_hdr.ether_shost, forwardInterface->addr, ETHER_ADDR_LEN);
                memcpy(etherIsItIp.eth_hdr.ether_dhost, check_entry.addr, ETHER_ADDR_LEN);

                /*drop the packet if ttl <= 1 */
                if (etherIsItIp.ip_hdr.ip_ttl <= 1) {
                    return;
                } else {
                    etherIsItIp.ip_hdr.ip_ttl--;
                }

                /*Checksums for the IP packet*/
                etherIsItIp.ip_hdr.ip_sum = 0;
                memcpy(packet, &etherIsItIp, sizeof (etherIsItIp));
                uint8_t * pointerToIpStart = packet + sizeof ( struct sr_ethernet_hdr);
                unsigned int lengthIpData = sizeof ( struct ip);
                printf("Size of data total data %d versus IP data %d\n", len, lengthIpData);
                etherIsItIp.ip_hdr.ip_sum = sr_inet_checksum(pointerToIpStart, lengthIpData);

                /*prepare to send packet*/
                memcpy(packet, &etherIsItIp, sizeof (etherIsItIp));
                if (sr_send_packet(sr, packet, len, forwardInterface->name) < 0) {
                    printf("Error forwarding IP packet.\n");
                }
                return;
            } else {
                printf("here\n");
                uint8_t *ourPacket = malloc(60);
                /*make an etherARP*/
                struct sr_ether_arp etherArp;
                /*memcpy(&etherArp, packet, sizeof (struct sr_ethernet_hdr));*/
                memset(ourPacket, 0, 60);
                /*lookup what ethernet interface to send through.*/
                struct sr_if* arpInterface;
                arpInterface = sr_get_interface(sr, getForwardingEthernet(etherIsItIp.ip_hdr.ip_dst, sr->routing_table));

                /* memcpy fields into packet*/
                etherArp.arp_hdr.ar_hrd = htons(1);
                etherArp.arp_hdr.ar_pro = htons(ETHERTYPE_IP);
                etherArp.arp_hdr.ar_hln = 6;
                etherArp.arp_hdr.ar_pln = 4;
                etherArp.arp_hdr.ar_op = htons(ARP_REQUEST);

                /*copy original ip dest->arp hdr*/
                /* struct in_addr addr;
                                
                inet_pton(AF_INET, "171.67.240.222", &addr);
                memcpy(&etherArp.arp_hdr.ar_tip, &addr.s_addr, sizeof(etherArp.arp_hdr.ar_sip)); */
                memcpy(&etherArp.arp_hdr.ar_tip, &etherIsItIp.ip_hdr.ip_dst, sizeof (etherArp.arp_hdr.ar_sip));
                memcpy(&etherArp.arp_hdr.ar_sip, &arpInterface->ip, sizeof (arpInterface->ip));

                /*Prepare to broadcast some FFFF*/
                memset(etherArp.arp_hdr.ar_tha, 0xff, 6);
                memcpy(etherArp.arp_hdr.ar_sha, arpInterface->addr, ETHER_ADDR_LEN);

                /*Does this need htons()?*/
                etherArp.eth_hdr.ether_type = htons(ETHERTYPE_ARP);
                memset(etherArp.eth_hdr.ether_dhost, 0xff, 6);

                /*Do we need a different MAC here? */
                memcpy(etherArp.eth_hdr.ether_shost, arpInterface->addr, sizeof (arpInterface->addr));

                /*send packet*/
                memcpy(ourPacket, &etherArp, sizeof (etherArp));
                if (sr_send_packet(sr, ourPacket, 60, arpInterface->name) < 0) {
                    printf("Error Sending ARP request.\n");
                } else {
                    free(ourPacket);
                    printf("\nARP Request\n");
                    /*every time an ARP request is sent go here*/
                    struct table_entry *temp_entry;
                    temp_entry = RequestTableContains(etherIsItIp.ip_hdr.ip_dst);


                    /*Check if there are 5 attempts made*/
                    if (temp_entry != NULL) {
                        temp_entry->attempts++;
                        printf("attempts %d\n", temp_entry->attempts);
                        if (temp_entry->attempts >= 5) {

                            /*make new packet for ICMP*/
                            /*
                                                        uint8_t *Icmppacket = malloc(64);
                                                        memset(Icmppacket, 0, 64);
                             */

                            memset(packet, 0, len);
                            /*get interface*/
                            struct sr_if* arpInterface;
                            arpInterface = sr_get_interface(sr, getForwardingEthernet(etherArp.arp_hdr.ar_tip, sr->routing_table));

                            /*Send ICMP fail package*/
                            memcpy(&etherIcmpHost.ip_hdr.ip_src, &arpInterface->ip, sizeof (arpInterface->ip));

                            /*dest and source of ethernet header*/
                            memcpy(etherIcmpHost.eth_hdr.ether_dhost, etherIsItIp.eth_hdr.ether_shost, ETHER_ADDR_LEN);
                            memcpy(etherIcmpHost.eth_hdr.ether_shost, arpInterface->addr, ETHER_ADDR_LEN);

                            /*IP datagram */
                            /*tos 0x0, ttl 50, id 0, offset 0, flags [DF], proto ICMP (1)*/
                            /*
                                                        etherIcmpHost.ip_hdr.ip_v = htons(4);
                             */
                            etherIcmpHost.ip_hdr.ip_len = htons(56);
                            /*
                            etherIcmpHost.ip_hdr.ip_id = htons(1337);
                             */
                            etherIcmpHost.ip_hdr.ip_hl = 5;
                            etherIcmpHost.ip_hdr.ip_ttl = 64;
                            etherIcmpHost.ip_hdr.ip_p = 1;
                            memcpy(&etherIcmpHost.ip_hdr.ip_dst, &etherIsItIp.ip_hdr.ip_src, sizeof (etherIsItIp.ip_hdr.ip_src));

                            printf("        hl%u  len%u\n", etherIcmpHost.ip_hdr.ip_hl, ntohs(etherIcmpHost.ip_hdr.ip_len));
                            /*ICMP data*/
                            etherIcmpHost.icmp_hdr.type = 3;
                            etherIcmpHost.icmp_hdr.code = 1;

                            /*Create the ICMP checksum */
                            etherIcmpHost.icmp_hdr.checksum = 0;
                            memcpy(myPacket + sizeof (etherIcmpHost)+4, fail, 28);
                            memcpy(myPacket, &etherIcmpHost, sizeof (etherIcmpHost));
                            uint8_t *pointerToIcmpStart1 = myPacket + sizeof (struct sr_ethernet_hdr) + sizeof (struct ip);
                            unsigned int lengthIcmpData1 = 36;
                            etherIcmpHost.icmp_hdr.checksum = sr_inet_checksum(pointerToIcmpStart1, lengthIcmpData1);

                            /*Create the IP checksum */
                            etherIcmpHost.ip_hdr.ip_sum = 0;
                            memcpy(myPacket, &etherIcmpHost, sizeof (etherIcmpHost));
                            uint8_t *pointerToIpStart = myPacket + sizeof (struct sr_ethernet_hdr);
                            unsigned int lengthIpData = sizeof (struct ip);
                            etherIcmpHost.ip_hdr.ip_sum = sr_inet_checksum(pointerToIpStart, lengthIpData);

                            printf("Sending ICMP host unreachable.\n");
                            int length = sizeof(etherIcmpHost) + 32;
                            fprintf(stderr, "   %d\n", length);
                            /*SEND THIS ICMP host unreachable*/
                            memcpy(myPacket, &etherIcmpHost, sizeof (etherIcmpHost));
/*
                            memcpy(myPacket + sizeof (etherIcmpHost)+4, fail, 28);
*/
                            if (sr_send_packet(sr, myPacket, length, arpInterface->name) < 0) {
                                printf("Error Sending ICMP host unreachable.\n");

                            }
                            printf("Sent ICMP host unreachable.\n");

                        }
                    } else { /* if we need to add it to the table return NULL temp_entry*/
                        struct table_entry requestToAdd;
                        memcpy(&requestToAdd.ip, &etherArp.arp_hdr.ar_tip, sizeof (etherArp.arp_hdr.ar_tip));
                        requestToAdd.attempts = 1;
                        addToRequestTable(&requestToAdd);
                        printf("adding table entry\n");
                    }
                }
            }
        } else {
            /*WE AREM"T FORWARDING NOW*/
            if (ntohs(etherIsItIp.ip_hdr.ip_p == IPPROTO_ICMP)) {
                struct sr_ether_icmp etherIp;
                memcpy(&etherIp, packet, sizeof (struct sr_ether_icmp));

                /*IS THIS AN ICMP REQUEST?*/
                if (etherIp.icmp_hdr.type == 8 && etherIp.icmp_hdr.code == 0) { /* function - look through interface list, and see if ip matches, don't forward */

                    /*creating a holder for etherIP src*/
                    uint32_t temporary_src = etherIp.ip_hdr.ip_src;

                    /*check the incoming dst against our interfaces*/
                    if (etherIp.ip_hdr.ip_dst == eth0->ip) {
                        printf("in eth0, pinged\n");
                        memcpy(&etherIp.ip_hdr.ip_src, &eth0->ip, sizeof (eth1->ip));
                    } else if ((etherIp.ip_hdr.ip_dst) == eth1->ip) {
                        printf("in eth1, pinged\n");
                        memcpy(&etherIp.ip_hdr.ip_src, &eth1->ip, sizeof (eth1->ip));
                    } else if ((etherIp.ip_hdr.ip_dst) == eth2->ip) {
                        printf("in eth2, pinged\n");
                        memcpy(&etherIp.ip_hdr.ip_src, &eth2->ip, sizeof (eth2->ip));
                    } else {
                        /*forward packet area*/
                    }

                    /*change to a reply*/
                    etherIp.icmp_hdr.code = 0;
                    etherIp.icmp_hdr.type = 0;
                    etherIp.icmp_hdr.checksum = 0;

                    /*make icmp checksum*/
                    memcpy(packet, &etherIp, sizeof (etherIp));
                    uint8_t * pointerToIcmpStart = packet + sizeof ( struct sr_ethernet_hdr) + sizeof ( struct ip);
                    unsigned int lengthIcmpData = len - sizeof ( struct sr_ethernet_hdr) - sizeof ( struct ip);
                    etherIp.icmp_hdr.checksum = sr_inet_checksum(pointerToIcmpStart, lengthIcmpData);

                    /*Set ethernet fields*/
                    memcpy(etherIp.eth_hdr.ether_dhost, etherIp.eth_hdr.ether_shost, sizeof (etherIp.eth_hdr.ether_dhost));
                    memcpy(etherIp.eth_hdr.ether_shost, theInterface->addr, sizeof (theInterface->addr));

                    /*IP Dst gets stored src */
                    memcpy(&etherIp.ip_hdr.ip_dst, &temporary_src, sizeof (etherIp.ip_hdr.ip_src));
                    etherIp.ip_hdr.ip_sum = 0;

                    /*IP checksum*/
                    memcpy(packet, &etherIp, sizeof (etherIp));
                    uint8_t * pointerToIpStart5 = packet + sizeof ( struct sr_ethernet_hdr);
                    unsigned int lengthIpData5 = len - sizeof (struct sr_ethernet_hdr);
                    etherIp.ip_hdr.ip_sum = sr_inet_checksum(pointerToIpStart5, lengthIpData5);

                    /*prepare packet for departure*/
                    memcpy(packet, &etherIp, sizeof (etherIp));
                    if (sr_send_packet(sr, packet, len, interface) < 0) {
                        printf("Error Sending ICMP reply\n");
                    }
                    return;
                }
            }
        }
    } else if (ntohs(EthernetHdrCheck.ether_type) == ETHERTYPE_ARP) {
        /* dealing with an ARP datagram, so check to see if its an arp request, or an arp reply. */
        struct sr_ether_arp etherArp;
        memcpy(&etherArp, packet, sizeof (struct sr_ether_arp));

        /* pointer */
        if (theInterface->ip == etherArp.arp_hdr.ar_tip) /* the ips are equal */ {
            if (ntohs(etherArp.arp_hdr.ar_op) == ARP_REQUEST) {
                /*Copy fields for ARP reply*/
                memcpy(etherArp.arp_hdr.ar_tha, etherArp.arp_hdr.ar_sha, sizeof (etherArp.arp_hdr.ar_sha));
                memcpy(etherArp.arp_hdr.ar_sha, theInterface->addr, sizeof (etherArp.arp_hdr.ar_sha));
                memcpy(etherArp.eth_hdr.ether_dhost, etherArp.eth_hdr.ether_shost, sizeof (etherArp.eth_hdr.ether_dhost));
                memcpy(&etherArp.arp_hdr.ar_tip, &etherArp.arp_hdr.ar_sip, sizeof (etherArp.arp_hdr.ar_sip));
                memcpy(&etherArp.arp_hdr.ar_sip, &theInterface->ip, sizeof (theInterface->ip));
                memcpy(etherArp.eth_hdr.ether_shost, theInterface->addr, sizeof (theInterface->addr));
                etherArp.arp_hdr.ar_op = htons(ARP_REPLY);
                /*Arp request*/
                memcpy(packet, &etherArp, sizeof (etherArp));
                if (sr_send_packet(sr, packet, len, interface) < 0) {
                    printf("Error Sending ARP reply (to an ARP request.)\n");
                }
            } else if (ntohs(etherArp.arp_hdr.ar_op) == ARP_REPLY) {

                /*
                                int t;
                                for(t =0; t < 3; t++){
                                    struct in_addr test ;
                                    test.s_addr = ntohl(ArpTable[t].ip);
                                    printf( "Entry%d:  IP:%s  Addr:", t, inet_ntoa(test));
                                    DebugMAC(ArpTable[t].addr);
                                    printf("\n");
                                }
                                printf("\n");
                 */

                /*add entry to arp table*/

                memcpy(ArpTable[arp_entries].addr, etherArp.arp_hdr.ar_sha, ETHER_ADDR_LEN);
                memcpy(&(ArpTable[arp_entries].ip), &etherArp.arp_hdr.ar_sip, sizeof (etherArp.arp_hdr.ar_sip));
                arp_entries++;


                /*remove entry from request attempt table*/
                /*
                                temp_entry = RequestTableContains(&etherArp.arp_hdr.ar_sip);
                                temp_entry->ip = -1;
                                temp_entry->attempts = -1;
                 *temp_entry->addr = '\0';
                 */
            }
            /* switch the ARP op to 2 for a reply, switch the sending 2 fields to the destination 2 fields, 			replace the sending with our MAC and our IP on that interface. */
        } else {
            return;
        }

        /* put it into the ether_arp */
        /* sr_get_interface( sr, interface) - > returns the sr_if, which we can pull out of to get the sr_if->ip */
    }


    return;
}/* end sr_ForwardPacket */

uint16_t sr_inet_checksum(uint8_t* buf/*borrowed*/, uint32_t len) {
    uint16_t* hdr = (uint16_t*) buf;
    uint32_t sum = 0;
    uint16_t answer = 0;
    int i = 0;

    /* accumulate all 16 bit words */
    for (i = 0; i < len; i += 2) {
        sum += (uint32_t) hdr[i / 2];
    }

    /* XXX: TODO if we have a variable length header, may have to
     * handle extra byte! */

    /* add back carry outs from top 16 bits to low 16 bites */
    sum = (sum & 0xFFFF)+(sum >> 16); /* add hi 16 to low 16 */
    sum += (sum >> 16); /* add carry */

    /* one's complement the result */
    answer = ~sum; /* truncate to 16 bits */

    return answer;
} /* -- sr_inet_checksum -- */

struct table_entry ArpContains(uint32_t ip) {
    int t;
    for (t = 0; t < 100; t++) {
        if (ArpTable[t].ip == ip) {
            return ArpTable[t];

        }
    }
    struct table_entry temp;
    *temp.addr = '\0';
    return temp;
}

struct table_entry* RequestTableContains(uint32_t ip) {
    int t;
    for (t = 0; t < 100; t++) {
        struct in_addr temp;
        temp.s_addr = RequestTable[t].ip;
        printf("table entry = %s\n", inet_ntoa(temp));
        if (RequestTable[t].ip == ip) {
            return &RequestTable[t];
        }
    }
    return NULL;
}

void addToRequestTable(struct table_entry *temp_entry) {
    int i = 0;

    while (RequestTable[i].attempts != 0) {
        i++;
    }
    memcpy(&RequestTable[i], temp_entry, sizeof (struct table_entry));
}

char* getForwardingEthernet(uint32_t ip, struct sr_rt *temp_rt) {
    struct sr_rt rt1, rt2, rt0;
    struct in_addr temp;
    temp.s_addr = ip;
    printf("        %s\n", inet_ntoa(temp));
    memcpy(&rt0, temp_rt, sizeof (temp_rt));
    temp_rt = temp_rt->next;
    memcpy(&rt1, temp_rt, sizeof (temp_rt));
    temp_rt = temp_rt->next;
    memcpy(&rt2, temp_rt, sizeof (temp_rt));
    if ((rt1.dest.s_addr & rt1.mask.s_addr) == (ip & rt1.mask.s_addr)) {
        printf("    Return eth1\n");
        return "eth1";
    } else if ((rt2.dest.s_addr & rt2.mask.s_addr) == (ip & rt2.mask.s_addr)) {
        printf("    Return eth2\n");
        return "eth2";
    } else {
        printf("    Return eth3\n");
        return "eth0";
    }
}
/*--------------------------------------------------------------------- 
 * Method:
 *
 *---------------------------------------------------------------------*/
