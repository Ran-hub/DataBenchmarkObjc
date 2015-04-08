//
// Created by Stanislav on 07.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YALNode.h"

@class DataStorage;

typedef NS_ENUM(NSUInteger, TraverseType)  {
    TraverseTypePreOrder,
    TraverseTypeInOrder,
    TraverseTypePostOrder
};

typedef NS_ENUM(NSUInteger, BinaryNodeType) {
    BinaryNodeTypeLeft,
    BinaryNodeTypeRight,
    BinaryNodeTypeRoot
};

@interface YALBinaryTreeNode : YALNode

@property(nonatomic, weak) YALBinaryTreeNode *parent;

@property(nonatomic, strong) YALBinaryTreeNode *left;

@property(nonatomic, strong) YALBinaryTreeNode *right;

- (BinaryNodeType)getType;

- (void)insert:(DataStorage *)storage;

- (id)find:(id)key;

- (void)remove:(id)key;

- (void)traverseWithType:(TraverseType)type andCallback:(void (^)(DataStorage *))callback;
@end