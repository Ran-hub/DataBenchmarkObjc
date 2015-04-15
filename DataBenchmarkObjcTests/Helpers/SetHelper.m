//
// Created by Stanislav on 15.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "SetHelper.h"
#import "PerformanceTestCase.h"
#import "YALRandom.h"


@implementation SetHelper

+ (NSMutableSet *)generateSet:(NSUInteger)elementCount {
    NSMutableSet *testSet = [NSMutableSet setWithCapacity:elementCount];
    for (NSUInteger i = 0; i < elementCount; i++) {
        NSString *element = [testString stringByAppendingFormat:@"%d", i];
        [testSet addObject:element];
    }

    return testSet;
}

+ (NSUInteger)randomSetIndex:(NSSet *)set {
    return [YALRandom intFrom:0 to:set.count - 1];
}

+ (NSString *)randomSetElement:(NSSet *)set randomIndex:(NSUInteger)randomIndex {
    return [testString stringByAppendingFormat:@"%d", randomIndex];
}

@end