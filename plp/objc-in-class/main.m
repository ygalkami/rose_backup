#import <stdio.h>
#import "node.h"
#import "empty.h"

int main( int argc, const char *argv[] ) {
    // create the nodes
    Node *node1 = [[Node alloc] initWith: "1"];
    Node *node2 = [[Node alloc] initWith: "2"];
    Node *node3 = [[Node alloc] initWith: "3"];
    Node *node4 = [[Node alloc] initWith: "4"];
    Node *node5 = [[Node alloc] initWith: "5"];
    Node *node6 = [[Node alloc] initWith: "6"];
    Node *node7 = [[Node alloc] initWith: "7"];

    // test printing all nodes
    printf("%s",[node1 print]);
    printf("%s",[node2 print]);
    printf("%s",[node3 print]);
    printf("%s",[node4 print]);
    printf("%s",[node5 print]);
    printf("%s",[node6 print]);
    printf("%s",[node7 print]);
    printf("\n");
    
    // build the tree
    [node4 setLeft: node2];
    [node4 setRight: node6];
    [node2 setLeft: node1];
    [node2 setRight: node3];
    [node6 setLeft: node5];
    [node6 setRight: node7];

    // print root
    printf("%s",[node4 print]);
    printf("\n");

    // print preorder

    
    // print inorder

    
    // print postorder


    // free memory
    [node1 free];
    [node2 free];
    [node3 free];
    [node4 free];
    [node5 free];
    [node6 free];
    [node7 free];

    return 0;
}
