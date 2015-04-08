//
// Created by Stanislav on 07.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "YALStack.h"
#import "YALLinkedNode.h"


@implementation YALStack

- (void)push:(id)value {
    YALLinkedNode *newNode = [YALLinkedNode nodeWithStoredValue:value];
    if (self.startNode) {
        newNode.next = self.startNode;
    }
    self.startNode = newNode;
}

- (id)pop {
    if (!self.startNode) {
        return nil;
    }

    NSString *outcomeValue = self.startNode.storedValue;
    self.startNode = self.startNode.next;

    return outcomeValue;
}

@end