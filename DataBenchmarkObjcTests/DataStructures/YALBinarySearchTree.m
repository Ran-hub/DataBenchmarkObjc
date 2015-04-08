//
// Created by Stanislav on 08.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "YALBinarySearchTree.h"
#import "YALBinaryTreeNode.h"
#import "DataStorage.h"

@interface YALBinarySearchTree ()

@property(nonatomic, strong) YALBinaryTreeNode *root;

@end

@implementation YALBinarySearchTree

- (void)insert:(DataStorage *)storage {
    if (!self.root) {
        self.root = [YALBinaryTreeNode nodeWithStoredValue:storage];
    } else {
        [self.root insert:storage];
    }
}

- (void)remove:(id)key {
    [self.root remove:key];
}

- (id)find:(id)key {
    return [self.root find:key];
}

- (void)traverseWithType:(TraverseType)type andCallback:(void (^)(DataStorage *))callback {
    [self.root traverseWithType:type andCallback:callback];
}


@end