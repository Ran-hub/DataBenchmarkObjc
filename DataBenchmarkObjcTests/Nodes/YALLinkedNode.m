//
//  YALLinkedNode.m
//  DataBenchmarkObjc
//
//  Created by Stanislav on 06.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "YALLinkedNode.h"

@implementation YALLinkedNode

- (instancetype)initWithStoredValue: (id)value nextLinkedNode: (YALLinkedNode *)node {
    if (self = [super initWithStoredValue:value]) {
        self.next = node;
    }
    
    return self;
}

+ (instancetype)nodeWithStoredValue: (id)value nextLinkedNode: (YALLinkedNode *)node {
    return [[YALLinkedNode alloc] initWithStoredValue:value nextLinkedNode:node];
}

+ (instancetype)nodeWithStoredValue: (id)value {
    return [[YALLinkedNode alloc] initWithStoredValue:value nextLinkedNode:nil];
}


@end
