//
//  Node.m
//  DataBenchmarkObjc
//
//  Created by Stanislav on 06.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "YALNode.h"

@implementation YALNode

- (instancetype)initWithStoredValue: (id)value {
    if (self = [super init]) {
        self.storedValue = value;
    }
    
    return self;
}

+ (instancetype)nodeWithStoredValue: (id)value {
    return [[YALNode alloc] initWithStoredValue:value];
}

@end
