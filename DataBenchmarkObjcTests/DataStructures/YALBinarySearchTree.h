//
// Created by Stanislav on 08.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YALBinaryTreeNode.h"

@class DataStorage;


@interface YALBinarySearchTree : NSObject
- (void)insert:(DataStorage *)storage;

- (void)remove:(id)key;

- (id)find:(id)key;

- (void)traverseWithType:(TraverseType)type andCallback:(void (^)(DataStorage *))callback;
@end