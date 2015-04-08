//
//  YALLinkedNode.h
//  DataBenchmarkObjc
//
//  Created by Stanislav on 06.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "YALNode.h"

@interface YALLinkedNode : YALNode

@property(nonatomic, strong) YALLinkedNode *next;

- (instancetype)initWithStoredValue:(id)value nextLinkedNode:(YALLinkedNode *)node;

+ (instancetype)nodeWithStoredValue:(id)value nextLinkedNode:(YALLinkedNode *)node;

@end
