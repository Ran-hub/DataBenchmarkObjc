//
// Created by Stanislav on 15.04.15.
// Copyright (c) 2015 Stanislav. All rights reserved.
//

#import "DictionaryHelper.h"


@implementation DictionaryHelper

+ (NSMutableDictionary *)generateDictionary:(NSUInteger)elementCount {
    NSMutableDictionary *testDictionary = [NSMutableDictionary dictionaryWithCapacity:elementCount];
    for (NSUInteger i = 0; i < elementCount; i++) {
        NSString *key = [NSString stringWithFormat:@"%d", i];
        NSString *element = [testString stringByAppendingFormat:@"%d", i];
        testDictionary[key] = element;
    }

    return testDictionary;
}

+ (NSString *)randomDictionaryIndex:(NSDictionary *)dict {
    return [NSString stringWithFormat:@"%d", [YALRandom intFrom:0 to:dict.count - 1]];
}

+ (NSString *)randomDictionaryElement:(NSDictionary *)dict randomIndex:(NSString *)randomIndex {
    return dict[randomIndex];
}

@end