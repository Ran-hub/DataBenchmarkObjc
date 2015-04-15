//
// Created by Stanislav on 15.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "ArrayHelper.h"
#import "PerformanceTestCase.h"
#import "YALRandom.h"


@implementation ArrayHelper

+ (NSMutableArray *)generateArray:(NSUInteger)elementCount {
    NSMutableArray *testArray = [NSMutableArray arrayWithCapacity:elementCount];
    for (NSUInteger i = 0; i < elementCount; i++) {
        NSString *element = [testString stringByAppendingFormat:@"%d", i];
        [testArray addObject:element];
    }

    return testArray;
}

+ (NSUInteger)randomArrayIndex:(NSArray *)array {
    return [YALRandom intFrom:0 to:array.count - 1];
}

+ (NSString *)randomArrayElement:(NSArray *)array randomIndex:(NSUInteger)randomIndex {
    return array[randomIndex];
}


@end