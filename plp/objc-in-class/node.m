#import "node.h"
#import "empty.h"
#import <stdlib.h>
#import <stdio.h>

@implementation Node

-(Node*) initWith: (char*) val {
    self = [super init];

    if ( self ) {
        [self setVal: val];
        [self setLeft: [[Empty alloc] init]];
        [self setRight: [[Empty alloc] init]];
    }

    return self;
}

-(char*) print {
    return value;
}

-(void) setVal: (char*) val {
    value = val;
}

-(void) setLeft: (Node*) left {
    leftChild = left;
}

-(void) setRight: (Node*) right {
    rightChild = right;
}

//TODO: A preOrder method that will recursively print the preorder-traversal of the tree
//      (calling the preOrder method on the root of a tree should print out the entire
//      traversal on its own, NOT return the string)

//TODO: The same method as preOrder but for inOrder

//TODO: The same method as preOrder and inOrder but for postOrder

@end
