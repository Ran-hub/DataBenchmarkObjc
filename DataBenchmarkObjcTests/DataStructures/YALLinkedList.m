//
//  YALLinkedList.m
//  DataBenchmarkObjc
//
//  Created by Stanislav on 06.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "YALLinkedList.h"
#import "YALLinkedNode.h"

@implementation YALLinkedList

- (instancetype)initWithStartNode:(YALLinkedNode *)startNode {
    self = [super init];
    if (self) {
        self.startNode = startNode;
    }

    return self;
}

+ (instancetype)listWithStartNode:(YALLinkedNode *)startNode {
    return [[self alloc] initWithStartNode:startNode];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained[])buffer count:(NSUInteger)len {
    if (state->state == 0) {
        state->mutationsPtr = &state->extra[0]; //unused
        state->state = 1;
        state->extra[1] = (long) self.startNode;  //this is used to save position in the list; start with head node
    }

    NSUInteger count = 0;
    state->itemsPtr = buffer;

    //grab the current start node
    void *n = (void *) state->extra[1];  //these casts to avoid ARC retain operations
    YALLinkedNode *node = (__bridge YALLinkedNode *) n;

    //node is nil if the list is exhausted
    while (node) {
        buffer[count] = node.storedValue;
        ++count;

        if (count < len) {
            //continue if there's still room
            node = node.next;
        } else {
            //break if we run out of room in the buffer
            break;
        }
    }

    //node may be nil at this point but ObjC returns nil on messages sent to nil
    //save the next start node which is nil if the list is exhausted
    state->extra[1] = (long) node.next;

    return count;
}

@end
