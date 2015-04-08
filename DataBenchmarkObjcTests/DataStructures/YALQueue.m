//
// Created by Stanislav on 07.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "YALQueue.h"
#import "YALLinkedNode.h"


@implementation YALQueue

- (id)dequeue {
    if (!self.startNode) {
        return nil;
    }

    NSString *outcomeValue = self.startNode.storedValue;
    self.startNode = self.startNode.next;

    return outcomeValue;
}

@end