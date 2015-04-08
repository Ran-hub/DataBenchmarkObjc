//
// Created by Stanislav on 07.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "YALOptimizedLinkedList.h"
#import "YALNode.h"
#import "YALLinkedNode.h"

@interface YALOptimizedLinkedList()

@property(nonatomic, weak) YALLinkedNode *lastNode;

@end

@implementation YALOptimizedLinkedList

- (instancetype)initWithStartNode:(YALLinkedNode *)startNode {
    self = [super initWithStartNode:startNode];
    if (self) {
          self.lastNode = startNode;
    }

    return self;
}

- (id)last {
    return self.lastNode.storedValue;
}

- (void)add:(id)value {
    YALLinkedNode *newNode = [YALLinkedNode nodeWithStoredValue:value];
     if (self.lastNode != nil) {
         self.lastNode.next = newNode;
         self.lastNode = self.lastNode.next;
     } else {
         self.startNode = newNode;
         self.lastNode = self.startNode;
     }
}

- (BOOL)removeFirstOccurenceOf: (id)value {
    if (self.startNode == nil) {
        return FALSE;
    }
    YALLinkedNode *currentNode = self.startNode;
    YALLinkedNode *prevNode;
    while (currentNode.next) {
        if (currentNode.storedValue == value) {
            if (!prevNode) {
                self.startNode = currentNode.next;
                if (!currentNode.next) {
                    self.lastNode = self.startNode;
                }
            } else {
                prevNode.next = currentNode.next;
                if (!currentNode.next) {
                    self.lastNode = prevNode;
                }
            }

            return TRUE;
        }
        prevNode = currentNode;
        currentNode = currentNode.next;
    }
    return FALSE;
}


@end