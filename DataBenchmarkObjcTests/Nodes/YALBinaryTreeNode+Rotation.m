//
// Created by Stanislav on 08.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "YALBinaryTreeNode+Rotation.h"


@implementation YALBinaryTreeNode (Rotation)

- (void)rotateRight {
    switch ([self getType]) {
        case BinaryNodeTypeRoot:
            NSLog(@"cannot rotate root");
        case BinaryNodeTypeLeft:
            [self.right moveNodeToNode:self.parent asLeftChild:TRUE];
            [self.right moveNodeToNode:self asLeftChild:FALSE];
        case BinaryNodeTypeRight:
            NSLog(@"Right rotation for right branch ins't implemented");
    }
}

- (void)rotateLeft {
    switch ([self getType]) {
        case BinaryNodeTypeRoot:
            NSLog(@"cannot rotate root");
        case BinaryNodeTypeLeft:
            NSLog(@"Left rotation for left branch ins't implemented");
        case BinaryNodeTypeRight:
            [self.left moveNodeToNode:self.parent asLeftChild:FALSE];
            [self.parent moveNodeToNode:self asLeftChild:TRUE];
    }
}

- (void)moveNodeToNode:(YALBinaryTreeNode *)owner asLeftChild:(BOOL)isLeft {
    self.parent = owner;
    if ([self getType] == BinaryNodeTypeLeft) {
        self.parent.left = nil;
    } else if ([self getType] == BinaryNodeTypeRight) {
        self.parent.right = nil;
    }
    if (isLeft) {
        owner.left = self;
    } else {
        owner.right = self;
    }
}


@end