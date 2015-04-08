//
// Created by Stanislav on 07.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "YALBinaryTreeNode.h"
#import "DataStorage.h"

@implementation YALBinaryTreeNode

- (BinaryNodeType)getType {
    if (!self.parent) {
        return BinaryNodeTypeRoot;
    }
    if (self.parent.left == self) {
        return BinaryNodeTypeLeft;
    } else {
        return BinaryNodeTypeRight;
    }
}

+ (instancetype)nodeWithStoredValue:(DataStorage *)value {
    return [[YALBinaryTreeNode alloc] initWithStoredValue:value];
}

- (void)insert:(DataStorage *)storage {
    DataStorage *currentStorage = self.storedValue;
    if ([storage compare:currentStorage] == NSOrderedSame) {
        return;
    }

    if ([storage compare:self.storedValue] == NSOrderedAscending) {
        if (!self.left) {
            self.left = [YALBinaryTreeNode nodeWithStoredValue:storage];
        } else {
            [self.left insert:storage];
        }
    } else {
        if (!self.right) {
            self.right = [YALBinaryTreeNode nodeWithStoredValue:storage];
        } else {
            [self.right insert:storage];
        }
    }
}

- (id)find:(id)key {
    DataStorage *currentStorage = self.storedValue;
    if ([key compare:currentStorage.key] == NSOrderedSame) {
        return currentStorage.value;
    }

    if ([key compare:currentStorage.key] == NSOrderedAscending && self.left) {
        return [self.left find:key];
    } else if ([key compare:currentStorage.key] == NSOrderedDescending && self.right) {
        return [self.right find:key];
    }
    return nil;
}

- (void)remove:(id)key {
    DataStorage *currentStorage = self.storedValue;
    if ([key compare:currentStorage.key] == NSOrderedAscending) {
        [self.left remove:key];
    } else if ([key compare:currentStorage.key] == NSOrderedDescending) {
        [self.right remove:key];
    } else {
        if (!self.left && !self.right) {
            self.parent = nil;
        } else if (self.left && !self.right) {
            self.storedValue = self.left.storedValue;
            self.left = nil;
        } else if (!self.left && self.right) {
            self.storedValue = self.right.storedValue;
            self.right = nil;
        } else {
            YALBinaryTreeNode *successor = [self.right findMinNode];
            self.storedValue = successor.storedValue;
            [successor remove:[successor.storedValue key]];
        }
    }
}

- (void)traverseWithType:(TraverseType)type andCallback:(void (^)(DataStorage *))callback {
    switch (type) {
        case TraverseTypeInOrder:
            [self.left traverseWithType:type andCallback:callback];
            callback(self.storedValue);
            [self.right traverseWithType:type andCallback:callback];
        case TraverseTypePreOrder:
            callback(self.storedValue);
            [self.left traverseWithType:type andCallback:callback];
            [self.right traverseWithType:type andCallback:callback];
        case TraverseTypePostOrder:
            [self.left traverseWithType:type andCallback:callback];
            [self.right traverseWithType:type andCallback:callback];
            callback(self.storedValue);
    }
}

- (YALBinaryTreeNode *)findMinNode {
    if (!self.left) {
        return self;
    } else {
        return [self.left findMinNode];
    }
}

@end